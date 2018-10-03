Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE88C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690E6213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ89ErE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690E6213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeJCJ7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 05:59:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41330 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeJCJ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 05:59:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id q17-v6so2707797plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 20:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h3yrkxkzYRPf3zuwQSSl32LhNKBguaWeQ5y7qsxFEp8=;
        b=QQ89ErE4hX1xUN0ZWyZC1rrS5Kk2TQ4a73ZVltUM4BJ8pl++EX2scjJ1rzJ7UZ/X2V
         YkyFcTva6XZdHsmOabVllxJjdrB0gjOryi0rK5gjqknU1fkyfum3DiTszioyhjC5ezne
         Pw0bFsFZM+YCBQ41eu7R2zN9ZXsWRjdcmYwWDSvRr1Ctd8XmEn9OuKbJ3AAyz+sf8NjV
         5/1HPXl9RlFRG1QFmTZONdjUUBq3X4t/tGp/Y7QxWVEhyEgLVFsZGhSnoJmWmjQ7uZ9T
         QQ/zklQ2jUGbGI7CqMaTy1hwlDfBzkpFSYakrY5YuipDwwrICz135aMst2DlWQLU2l3R
         rxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h3yrkxkzYRPf3zuwQSSl32LhNKBguaWeQ5y7qsxFEp8=;
        b=jj68vrRVaOwfYcSZp1Hek4O2Y3seDHCxP8Bzf2szcF1hg9Dc4UNZWVVCH0Cu7+7qGR
         fsfoobaABkVbPfIK7SoYEYZekQglwGuB1BHzPAlwdgja8CQDNMekpTX+hpPemnxt4HlP
         xYC1mSZfjsszUF6ZhBBaeDl3lj6BNtlJREsnTNe/NYib7MnSWSLWwpFS4psmPOkgbEq5
         38YtDTQH4Xdz2GVGFur5QnuTWbA0o31aEFx+wh/JJ2xPtzg/YacFbvXBX+tjgksy3Hdt
         iPHyHcn2S2RHUaFFXKRslL1sQacKRrFdfolW/vg+q7XsLvtpf1WPZEEKS+7Rs/A9m/0a
         nyBA==
X-Gm-Message-State: ABuFfoipfjOjK/J49sJ4wo9nTUnhJ7YsZnqvmBWHqrBO/9iqj9sOfh4+
        OQZETQXQ6Xbwqkl24nz/U74=
X-Google-Smtp-Source: ACcGV60ehEqJtUwqbBZnRB0HjzEuAKa4R+UAHFYp605vsz8pMNJ2QchRRpazqmQfMb9CDCy4aQBH3A==
X-Received: by 2002:a17:902:be14:: with SMTP id r20-v6mr17912375pls.293.1538536363194;
        Tue, 02 Oct 2018 20:12:43 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id v23-v6sm21777747pfm.80.2018.10.02.20.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 20:12:42 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v4 2/5] RISC-V: Add preprocessor directive for swiotlb
Date:   Wed,  3 Oct 2018 11:09:59 +0800
Message-Id: <0aaabb05426a360f71cbc7a910e2c613d3a3891c.1538535528.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1538535527.git.zongbox@gmail.com>
References: <cover.1538535527.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RV32, it doesn't select the SWIOTLB, only RV64 support swiotlb now.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index aee6031..6de6584 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -227,7 +227,10 @@ void __init setup_arch(char **cmdline_p)
 	setup_bootmem();
 	paging_init();
 	unflatten_device_tree();
+
+#ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
+#endif
 
 #ifdef CONFIG_SMP
 	setup_smp();
-- 
2.7.4

