Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDF3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E3620645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5iHY+4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E3620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbeIGURE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:17:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47024 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIGURD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:17:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so12589639ljj.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HmnDhWFXvcmgI6un6QDIXvMqoLGWaOXaLNGgniGdCHI=;
        b=K5iHY+4cHb2eknfWXSC55sUoi2Q1QvII1KJvMVMx1BzgbAAxXwbsFCdtIYBQDFRws2
         6UZcZdtu4Ac8lzuLS0h8oTd99oVY7EQjnDSpynx0ulwVI+Pi0YXjdFqb8vGibaek/3Tg
         o8iML+FLfsBGEwbBsSrkuRtZZqoyWd90OF+1fa1QaDM9EmQZT3UmUbSFaiSy6a3Pumwh
         6OwJaUi5NLvaPQ2beZI1TY104iA8vklcNGpsG8mVC/fPdVEkv07fsXncLlYf5zH5Pu80
         RO24wgOqDhM6axslHW5D/iDieDpCTnCWlU0ZMkrtrQcWMuWNqYTMpSvjbgITuad68dXp
         Z4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HmnDhWFXvcmgI6un6QDIXvMqoLGWaOXaLNGgniGdCHI=;
        b=Ao2BbMLOHpB7aZIx37BNO+NkXLBP71YYanQry7MA7Zd7ZcPc7Ibw/hjpLHuIvbjWAh
         QWEF+Tg22bvqDBIJAwbGUOi7CnNrbV6jnreph5bJUy1ziehFvIkvsZjg0/ewCD54qdQI
         hFdyw3IJG41qDgjoeRtcOjWqygJ2reQH/c5AnPA50S8MX/H6c1IbrY4Qs4At7iAGYdyA
         UH4zDDccNQw+cq/YzK/ymj0VYFj2NtizFEsFfFyu4HoAUcGKki8/oAm2xtUyYJofxLSw
         a1s41E6v2j7+D3eAdQPB5g8EzNBcyj/8eTEIRtiaESU166j+N4E01j+ShW8kbtoadMf6
         P0fw==
X-Gm-Message-State: APzg51CGvtK1Rn2BlQU7ziXNXomsNVABKifgvULrMAg5xztN+k696s4Q
        5pfO/IB1xZKWBP7RvGDD0H3yTbQualU=
X-Google-Smtp-Source: ANB0Vdbf2z+J7QzW6nvSJKEkIsdGB5M84fXBYgPyadwFJZmgcj16tSLF+BKYAfMdcCfcClrPGmmXJA==
X-Received: by 2002:a2e:4584:: with SMTP id s126-v6mr5165348lja.60.1536334535953;
        Fri, 07 Sep 2018 08:35:35 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id g11-v6sm1323352ljk.45.2018.09.07.08.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 08:35:35 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Arseny Solokha <asolokha@kb.kras.ru>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: remove unnecessary unlikely()
Date:   Fri,  7 Sep 2018 18:35:26 +0300
Message-Id: <20180907153526.19616-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
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
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
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

