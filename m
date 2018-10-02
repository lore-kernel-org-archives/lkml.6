Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD053C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C872089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ooz3iAVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C872089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJBPlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:41:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45070 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeJBPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:41:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id y15-v6so656981plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NPRdNy7+UDI8uqkv9kQ0+VObvpSXNliiTqy6LJMFPos=;
        b=Ooz3iAVk3RAx1KDVHXjS2lU5F9KGr4+cX22P09QWMXUeA6vJgXXwcMA+TlxWxUKFMo
         kLCP5WdPeaT9MRx/RMVJjntB7iiIqcFDwrVDcqnd/5UqoC6BoCOb+BRW8bacrh4nLf1j
         d4eBAQpx499zXpHqDBtcvrJho/Wt/aA1MRYEWBRy/uvgteI5AJGy229zU132VMscC738
         /RXVgpyeRCFzsvqTeiJ3VHDGpYoobK5mdZAtOC/PxorMAQp05j00POr8akKRc4PtoOZq
         z/s/exXu8F/vKYDIGWbJwtmXYqDEsVFcK+TS1wYp7BRw4wLjRKiDEo5hKC+FK1HH1ZCe
         h4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NPRdNy7+UDI8uqkv9kQ0+VObvpSXNliiTqy6LJMFPos=;
        b=Qx3nI664ZRkvTQhkoAAlArspsOwQzIOCVHR5NalSl8usZZkyukYo2rmt05ZquahqJP
         3bnuYdJRjqvFHTIDZLcHwAJYImG2h3Ya9Gr+tbM/2SCln8BTsDCthfg9ICn4ElsDDqce
         Mn/4nJ2mDDuJhD7pqY3xo+Sp3XZK8oK6BR8WUptKX3br56sONaEvBfLc8xpgKaUoiUcW
         9jgODTeZxZawGFG9yTzVBWHBMNKOl+iE1sLJKwcYoTryH8sGnCphwNCW7X3M1Whlo5Yh
         n34sjn3OWo4H6VGK+AQxYuiYuwyWLF1q7bXF/+oMxVhWQbSx0CCQJYbu4g5THNzeDgr+
         s7KQ==
X-Gm-Message-State: ABuFfojaXd6pqbu8JxJDt4MJcWgzO61Mh+3IeF/3kaOHhQWoeuQ/4Fk2
        tr7gqrrA11h/DPbd30ISKnI=
X-Google-Smtp-Source: ACcGV63Gmx0dog9/qAPm4grpnTa1QbA1K7f3y5OVOM6VMM3ksM1mgw9hGxppuCtDw8wQzcxfQJrtIA==
X-Received: by 2002:a63:2323:: with SMTP id j35-v6mr13725885pgj.337.1538470765554;
        Tue, 02 Oct 2018 01:59:25 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id 62-v6sm5057927pgc.58.2018.10.02.01.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 01:59:25 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v3 2/5] RISC-V: Use swiotlb on RV64 only
Date:   Tue,  2 Oct 2018 16:52:28 +0800
Message-Id: <a2ae9d4b7cd1d97cafe8161ec28f46e4a7968776.1538470103.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1538470103.git.zongbox@gmail.com>
References: <cover.1538470103.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only RV64 supports swiotlb. On RV32, it don't select the SWIOTLB.

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

