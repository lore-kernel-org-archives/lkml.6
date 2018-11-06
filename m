Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B74C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D9B20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRuqjrLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D9B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbeKGACK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:02:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43373 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388583AbeKGACK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:02:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id n10-v6so5887289pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uNGDvFPN4zXrSe9ynX/chysgNcrdJz+M6yhXOppEXqw=;
        b=IRuqjrLvFtNyyzsM69h7vDIEacAd3HwDNczvFQ2ugGYRaUuv1nUW1bSytwEc8m6Zgw
         oa6QsmW9F2TIoIsHIYdZJGbkI7BSr/xgTb6o33FU1oLset9FvUzuJxGpHmgAHRkne4NY
         PdgCP9ZHVc7svhOca9Tp5gEptb1Oc9RGXjO/rsBjSFgtn6M0vJGwyY9HK+3lE279O3Zz
         +B1pZ6S7R0u5jADQ8P9MUPTMhHN+w2EX11JvjilJel79l/57+sGSdpQoWdUb4ofI3zf4
         Y/vjz1sisXDXIJ57Nkshl3hAMILFKmnxypJgTtVqzetxVKsNn1TroOhSaXsimOThHkNx
         NyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uNGDvFPN4zXrSe9ynX/chysgNcrdJz+M6yhXOppEXqw=;
        b=O1zPhjIVjVG1Z/hPcRxLWJsCWQGLotyfOIWSKrt+cvD5ypQXh4MUVaMfnl08pGG6Js
         XaDOcFRwJqI6pXlLyQP9oJ+xIkcm6Wp7VqPL/Ev/nnxcfgpejETmFxQkUttbYJpea2vQ
         DMq8WYZgGxljLnZPl/IKmzKeTXsRp3XUewD9PWXMDE1j/EHtG8gTSSV/dT/rSNUW6W1V
         HMFlCCUE3/SfkrWyztAZi8w+0N7jIezHGj7x110wfs9UP4S8Y0YaSvGjskW5JjSjO9k2
         7EtfG5GnXgTXNsbPftqXNgymve3wFlsiBNEzmTm1FtkAOwmuDNKG21FYJ3uEFqMjw5Yl
         vHyA==
X-Gm-Message-State: AGRZ1gJ6yxA3GweJ8WumcRJo1gbdqch4jhgz725kZ8LofI3fmGkQRMfM
        gVLJoCnsznSrnp1NqxUiJEo=
X-Google-Smtp-Source: AJdET5dsZZctpnYrlfXINBsLUr3ouJ/Mvi4po3bfdnRlIBrCGvZvb/VN8/5tMiV5SyXPWnsduq6UHQ==
X-Received: by 2002:a62:5615:: with SMTP id k21-v6mr19013773pfb.190.1541514999723;
        Tue, 06 Nov 2018 06:36:39 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b75-v6sm55255142pfe.148.2018.11.06.06.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 06:36:39 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] MIPS: r2-on-r6-emu: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Tue,  6 Nov 2018 09:36:36 -0500
Message-Id: <20181106143636.8450-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c | 32 +++++----------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index eb18b186e858..28cb88daa3ef 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -2242,7 +2242,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
 
 #ifdef CONFIG_DEBUG_FS
 
-static int mipsr2_stats_show(struct seq_file *s, void *unused)
+static int mipsr2_emul_show(struct seq_file *s, void *unused)
 {
 
 	seq_printf(s, "Instruction\tTotal\tBDslot\n------------------------------\n");
@@ -2308,9 +2308,9 @@ static int mipsr2_stats_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int mipsr2_stats_clear_show(struct seq_file *s, void *unused)
+static int mipsr2_clear_show(struct seq_file *s, void *unused)
 {
-	mipsr2_stats_show(s, unused);
+	mipsr2_emul_show(s, unused);
 
 	__this_cpu_write((mipsr2emustats).movs, 0);
 	__this_cpu_write((mipsr2bdemustats).movs, 0);
@@ -2353,30 +2353,8 @@ static int mipsr2_stats_clear_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int mipsr2_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mipsr2_stats_show, inode->i_private);
-}
-
-static int mipsr2_stats_clear_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mipsr2_stats_clear_show, inode->i_private);
-}
-
-static const struct file_operations mipsr2_emul_fops = {
-	.open                   = mipsr2_stats_open,
-	.read			= seq_read,
-	.llseek			= seq_lseek,
-	.release		= single_release,
-};
-
-static const struct file_operations mipsr2_clear_fops = {
-	.open                   = mipsr2_stats_clear_open,
-	.read			= seq_read,
-	.llseek			= seq_lseek,
-	.release		= single_release,
-};
-
+DEFINE_SHOW_ATTRIBUTE(mipsr2_emul);
+DEFINE_SHOW_ATTRIBUTE(mipsr2_clear);
 
 static int __init mipsr2_init_debugfs(void)
 {
-- 
2.17.0

