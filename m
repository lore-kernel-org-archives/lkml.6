Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1F3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC47A21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naqPk+Jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfBTFSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:18:13 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55582 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfBTFSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:18:11 -0500
Received: by mail-it1-f194.google.com with SMTP id z131so12412688itf.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RusBdzrjtJSH0Xq6Q9xgO/MNbLZkhFf25LwFLQBcXCw=;
        b=naqPk+JpiiJn46wauAdwyuA3vCKUtvsRuKh+Nls5G4wHhvZEmIRyHjqRSslsW9ZXxe
         f1qpMqie5QjM//rcGEjRjpbK6xfPTA6e5E9CQi/YwzTr5pxNLNajQz76XG076yXu2Udh
         FH14u/0H0syD2C9j/CKlv+YaiIDYi/NnAnTuHagPh5V9A5YGioqu2TF/zf53I12bjd7o
         yLtUi/5uty07JV4f1H8Vwvvu/zw5DbM1WqyhvolQCyBNhYO4wFSICt0mznQlLVs9K3DF
         Jgu5gYGILjH4FLkNwPE7PUF1Dx13zKM/H3rq6gwzTQmm92VJmLATy18i2HA3k4B7wgEC
         M5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RusBdzrjtJSH0Xq6Q9xgO/MNbLZkhFf25LwFLQBcXCw=;
        b=rrnwRWF3RVKcMyYhTrjRYB/8poa1QuRiji16VAbwK2W9907FzFJUD4LlBZAyWHzVTG
         3FMpjBHsVwuSwwSSYziI1RvKczjlkOafd6ceW4uLFJtKMXxeDHKsWN2pD5Pz/09zFd8M
         9p/8gyLQO3ZUCus8Y5rAlyQ2yx8c4SQ2bLftVI3v3Xy8Ktm34KX9PVROsUEBj6Uj3WQ3
         rlwvmRcj6f+PI3BbTRsIsbbsRGQMw0++3xDYwiTmoiwtnKMVG2wa+SqUyTOCOTzRNFle
         iG3gyjta0AOYhA93drkD4JBccpWlLdlDaDmHUGmusiMU0j7cIDiCK1URwEglSGm4DyJA
         vY4w==
X-Gm-Message-State: AHQUAuaZh27rVeole2O/vN64hVHYKPKkeGJLZgrCWhFKzyi9N0TF5+rE
        jkO3H1V/W4WmTvjZKsMaOC0=
X-Google-Smtp-Source: AHgI3IZZ7AvclLXXnhmRZ2F7H327adVpdf+2c3T6Z+ts39d4n7fZ1PYOIel7Rk83XRnI7FSr12wMZg==
X-Received: by 2002:a6b:6003:: with SMTP id r3mr7524725iog.231.1550639890225;
        Tue, 19 Feb 2019 21:18:10 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id k64sm2297550itb.7.2019.02.19.21.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 21:18:09 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Neil Brown <neil@brown.name>,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH 04/10] staging: mt7621-mmc: Fix warning when reloading module with debug msgs enabled
Date:   Tue, 19 Feb 2019 22:17:48 -0700
Message-Id: <20190220051754.12195-5-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220051754.12195-1-thirtythreeforty@gmail.com>
References: <20190220051754.12195-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel complained:

    [  510.277151] WARNING: CPU: 0 PID: 395 at fs/proc/generic.c:360 proc_register+0xf0/0x108
    [  510.292891] proc_dir_entry '/proc/msdc_debug' already registered

when doing a modprobe/rmmod/modprobe of this module if debug messages
are compiled in.  Fix this by removing the proc entry when the module is
unloaded.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.c | 15 ++++++++++++---
 drivers/staging/mt7621-mmc/dbg.h |  3 ++-
 drivers/staging/mt7621-mmc/sd.c  |  4 ++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.c b/drivers/staging/mt7621-mmc/dbg.c
index 69b38c7e3179..5764b80893e9 100644
--- a/drivers/staging/mt7621-mmc/dbg.c
+++ b/drivers/staging/mt7621-mmc/dbg.c
@@ -295,9 +295,18 @@ static const struct file_operations msdc_debug_fops = {
 	.release	= single_release,
 };
 
-void msdc_debug_proc_init(void)
+// Keep ahold of the proc entry we create so it can be freed during
+// module removal
+struct proc_dir_entry *msdc_debug_proc_entry;
+
+void __init msdc_debug_proc_init(void)
 {
-	proc_create("msdc_debug", 0660, NULL, &msdc_debug_fops);
+	msdc_debug_proc_entry = proc_create("msdc_debug", 0660,
+					    NULL, &msdc_debug_fops);
+}
+
+void __exit msdc_debug_proc_deinit(void)
+{
+	proc_remove(msdc_debug_proc_entry);
 }
-EXPORT_SYMBOL_GPL(msdc_debug_proc_init);
 #endif
diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 2d447b2d92ae..d100324aa3fe 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -93,7 +93,8 @@ enum msdc_dbg {
 
 extern unsigned int sd_debug_zone[4];
 #define TAG "msdc"
-void msdc_debug_proc_init(void);
+void __init msdc_debug_proc_init(void);
+void __exit msdc_debug_proc_deinit(void);
 
 u32 msdc_time_calc(u32 old_L32, u32 old_H32, u32 new_L32, u32 new_H32);
 void msdc_performance(u32 opcode, u32 sizes, u32 bRx, u32 ticks);
diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 1d357b898952..a7c7ec0d7bbb 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -1843,6 +1843,10 @@ static int __init mt_msdc_init(void)
 
 static void __exit mt_msdc_exit(void)
 {
+#if defined(MT6575_SD_DEBUG)
+	msdc_debug_proc_deinit();
+#endif
+
 	platform_driver_unregister(&mt_msdc_driver);
 }
 
-- 
2.20.1

