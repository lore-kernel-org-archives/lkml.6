Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8113DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ADD20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WokdY0JL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47ADD20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388867AbeKGAAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:00:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40785 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388717AbeKGAAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:00:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so4021287pgp.7;
        Tue, 06 Nov 2018 06:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pdFhDs5I1ZXL1i5BmjG1jSbFtvqAaYqW7KD8G31fZ5A=;
        b=WokdY0JLUOyJBOuZx9ywaKjMP6c+AEOfzgnCFVF1A7K6jsmoRl91L3q7D7Qftk4R8z
         13UnCMi10QDArLNvTRgQkBdyLeEHBlb3v4K3ONaJVr1zOzODK7ZpHh0MfEbe8G5gGeMC
         Q2SEqTwL98E3uLDQMaDpTWqNtfQ+dL5zoptXo/DY4rY/8sYDDLNwNOqiLW3gz7OeI38b
         JPtpAfJL3sNVhoyewFCeWC9woD/N964y9d2Y4U9sASMnxja9T7J9BUCp6n+TgS2UZXIH
         R6+M4KaSQdeh+cljh1JcSh1h8iprm8+bTwK6B5Qh/FT8G+NuXZGypFLNAR7a+fhvxFue
         Z+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pdFhDs5I1ZXL1i5BmjG1jSbFtvqAaYqW7KD8G31fZ5A=;
        b=uoHDczhspS0QL8SzO6GUhGRzZGqnamZvjCH3U58c1VnEJWWHND/qYy6D471l+piP89
         0IY0QiugFJqQ0Lu309aybZXiIdroPvODJts232FHjCHGi3FyHi4gxJdvWrx20RpWrNPD
         P3N6m8qVSWIdyC7yjXiyZInZ3m73p8d3iwZRHgoKurHiysEvXbcBl1hVkRbkoEB/JAMj
         CCHdOkz+UThANpkw7rqLGMBH0KDexkShnra4DoKUY+OJVbKEEIuXfwN7lVvMp1N6UA16
         GEvXMfbkoefNtK4oEpDKd0QdtmmtS8Xsc8NejbDdPB2JX4ps2TTm/MwQsuC5Kvyysh29
         2vSA==
X-Gm-Message-State: AGRZ1gJvQTkKjkcgNFlJTe20LDjQ8m0wTdkROdyVkaiVygOT3MyzbrJv
        9AIo8OlvO+p/5gHUlKJ7NMTUgtLl0As=
X-Google-Smtp-Source: AJdET5f6ZVkPvunbuT6ceMsV2qfUnZKpvKqZuilJ3LqgczusCqRuA5TCtnSVxSNfJpMkK4O2SL6DZw==
X-Received: by 2002:a63:65c7:: with SMTP id z190mr24023587pgb.249.1541514918662;
        Tue, 06 Nov 2018 06:35:18 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id p2sm10167068pgc.94.2018.11.06.06.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 06:35:18 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     khilman@kernel.org, aaro.koskinen@iki.fi, tony@atomide.com,
        linux@armlinux.org.uk
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ARM: OMAP: PM: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Tue,  6 Nov 2018 09:35:16 -0500
Message-Id: <20181106143516.8394-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/mach-omap1/pm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 3e1de14805e4..998075d3ef86 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -532,18 +532,7 @@ static int omap_pm_debug_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int omap_pm_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, omap_pm_debug_show,
-				&inode->i_private);
-}
-
-static const struct file_operations omap_pm_debug_fops = {
-	.open		= omap_pm_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(omap_pm_debug);
 
 static void omap_pm_init_debugfs(void)
 {
-- 
2.17.0

