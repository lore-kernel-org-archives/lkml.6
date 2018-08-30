Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774F9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB2D20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd2Ezfdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB2D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeHaCk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41618 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbeHaCk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26-v6so8467623lfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ad/qa269HNpm8MVJTVwUlQl2wkw5HCg3jKISnC9C3BM=;
        b=gd2Ezfdh2gsdpaNkN7ssXItLtEtVxsZgxz1kIQZowSH3IeRRTwmP+l6/RkVtdZspcv
         kSHa7LIvjeBZpO9GSXWIMKM5vhOdb7vsTapIVCRCkXz0Fnilwp2A1TxtpVV34TMdAMhK
         4uWa7nrEAs8YkWkkHBeG4Y+WGUPLL1alrbOdRS+7jE6s70Itce/m61M2wdJqTdIV9mN6
         83DCCXBDWjKtyM5WLLL+O9P0PeFqwQ+XKHnKS+WOWWco4AyCoSKs1QAILBV9swvDmHNt
         FerrWuR7n24jpAnKYGkQPx4v9HgRUrwTiDlvTiJD9pOBjWVIZRWDBBup1R38mS7il7LU
         KOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ad/qa269HNpm8MVJTVwUlQl2wkw5HCg3jKISnC9C3BM=;
        b=Lm8xasQlE+QGM68UsBdVPczgS/X9ejq7V/bS6AnK5FwAwYIoAMz13IMTuEZMah09qc
         qzCrxjgPBNygxKg24U91CKfEAJAccxvGn8SuWlBKoUKi8gy78rbePpNNTiIe+xxs+/de
         HrRMIIg1mUNBP1ghoa0QJt/1TgNDWrkmKJdMB80bbpueiJSySG0g0/GLwc8uRN1Uplwx
         vjB/e3E/tlfLqtO7tmbNQ1jI01hpS1dhpA+VmN0s3HAYg/nUbrIajV/1EcAt0lep1l3h
         fV96i9FiQD1FTvhxo/Loh9SuYTGwU3Psh1pUu81eK1q++eLVQaLZGpVkXOWsYLKtki23
         Hd2A==
X-Gm-Message-State: APzg51DANWyXHlCGxPDfdprIfLkwiaahPaSTxYyz38P8EYuX5bEmHyat
        wa73EyOIoo1KK4akpYBIAl1ciINNyn8=
X-Google-Smtp-Source: ANB0VdZ73zxqy38ew251SGSOP/EwCjrxf278EH5qnRbPgTDbtuio1vhQbhVj0r2ZAzl46kRzbKTIPA==
X-Received: by 2002:a19:944d:: with SMTP id w74-v6mr8485818lfd.10.1535668560502;
        Thu, 30 Aug 2018 15:36:00 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:59 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Arseny Solokha <asolokha@kb.kras.ru>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 22/23] powerpc: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:28 +0300
Message-Id: <20180830223429.30051-23-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Arseny Solokha <asolokha@kb.kras.ru>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/tlb_nohash.c      | 2 +-
 arch/powerpc/sysdev/xive/common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 15fe5f0c8665..46f5d8c972fb 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -302,7 +302,7 @@ void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 	 * This function as well as __local_flush_tlb_page() must only be called
 	 * for user contexts.
 	 */
-	if (unlikely(WARN_ON(!mm)))
+	if (WARN_ON(!mm))
 		return;
 
 	preempt_disable();
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 959a2a62f233..7dde46b38979 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -442,7 +442,7 @@ static void xive_dec_target_count(int cpu)
 	struct xive_cpu *xc = per_cpu(xive_cpu, cpu);
 	struct xive_q *q = &xc->queue[xive_irq_priority];
 
-	if (unlikely(WARN_ON(cpu < 0 || !xc))) {
+	if (WARN_ON(cpu < 0 || !xc)) {
 		pr_err("%s: cpu=%d xc=%p\n", __func__, cpu, xc);
 		return;
 	}
-- 
2.17.1

