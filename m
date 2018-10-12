Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0902C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAF4213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+1AJnMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAF4213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbeJLXiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:38:12 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:58729 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbeJLXiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:38:11 -0400
Received: by mail-it1-f201.google.com with SMTP id m67-v6so9135857ita.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KXn6nL5lan+vznIeXYaB11EVquYEWKx8A0Az9ipgYuc=;
        b=d+1AJnMlZxr3tGBIxQFHLflc8HwY79Ra5D4FnizGqfRXlkLV9Ee2Bt8F2mbKRK7XJF
         ZSnkrTKR4mgzaLEoWoztwGOgoK0rJX3HZjhrxuAYVCbEos1FKHS93QwzDYFWE9+j0AQf
         22O528i1pW++3yIelKVox4k5KMEWYRVI/iem95qehrYYUr4Nuoas7qYN4l4ejBLpBl3g
         uUoyzDPagdTnLqw7xBuognw9K6tL9GiWZOG6WVxDFy8s9nwRTeBzXATPk7XXSFonizYQ
         v5GpE1dAe4F3bSMzCBMoBOUYNi5uoPB3KBHbX/4OHGyOYssvlKtfO+oftVRXZkrPDsvA
         p2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KXn6nL5lan+vznIeXYaB11EVquYEWKx8A0Az9ipgYuc=;
        b=HOVu4mYlMOlzPmjYphmDnBJumD606Khc88rCGZTm/V7aQcr8YuQSbFWONh0QQmtWj1
         5TVDXJxPyRTQOQFwcOVN7vZPj3yFdjpqUyo6cN6RdJcxx5mq5bJZiA8K+aEZc+xN8jtP
         H94GS4XwCOmn5nMK2JsVRxFnP0w0P9/J+fUlB6XObOxpfZJ+U3LMmqoh3JoAjaWUpYeE
         Yc1pyVhqf+NBnu9CjvxDuOnnYuhCuLLNnC86kjCvRnXddavAQt+x25zRQCJberASTPtF
         JYJwRenQh0ATuNmztAwzeCF65ZI7IAZ222F5J8s1DJq+YhU1M6nyA3L/Zc0AnsftNdW4
         47BA==
X-Gm-Message-State: ABuFfohcDIcUNG8SxmKW4HVVMH2kgAu9ST7ayIVrf+Vwz8UxcLArnmxQ
        U6KgoRudVfd3dIJAMvYEy1cFkIt1/DIo
X-Google-Smtp-Source: ACcGV62vcf2CxSqLgHCmggKjhsrCx60RCosSxVua481tlXTrAIIugnhJjkrxkfabor0VKoddYwQRqLDND5Pv
X-Received: by 2002:a24:d945:: with SMTP id p66-v6mr5474220itg.21.1539360301725;
 Fri, 12 Oct 2018 09:05:01 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:04:48 -0600
In-Reply-To: <20181012160448.79018-1-zwisler@google.com>
Message-Id: <20181012160448.79018-5-zwisler@google.com>
Mime-Version: 1.0
References: <20181012160448.79018-1-zwisler@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 4/4] gsmi: Add GSMI commands to log S0ix info
From:   Ross Zwisler <zwisler@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Furquan Shaikh <furquan@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        linux-kernel@vger.kernel.org, Furquan Shaikh <furquan@google.com>,
        Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Furquan Shaikh <furquan@chromium.org>

Add new GSMI commands (GSMI_CMD_LOG_S0IX_SUSPEND = 0xa,
GSMI_CMD_LOG_S0IX_RESUME = 0xb) that allow firmware to log any
information during S0ix suspend/resume paths.

Traditional ACPI suspend S3 involves BIOS both during the suspend and
the resume paths. However, modern suspend type like S0ix does not
involve firmware on either of the paths. This command gives the
firmware an opportunity to log any required information about the
suspend and resume operations e.g. wake sources.

Additionally, this change adds a module parameter to allow platforms
to specifically enable S0ix logging if required. This prevents any
other platforms from unnecessarily making a GSMI call which could have
any side-effects.

Tested by verifying that wake sources are correctly logged in eventlog.

Signed-off-by: Furquan Shaikh <furquan@chromium.org>
Reviewed-by: Aaron Durbin <adurbin@chromium.org>
Reviewed-by: Rajat Jain <rajatja@chromium.org>
Signed-off-by: Furquan Shaikh <furquan@google.com>
Tested-by: Furquan Shaikh <furquan@chromium.org>
Reviewed-by: Aaron Durbin <adurbin@chromium.org>
[zwisler: update changelog for upstream]
Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 drivers/firmware/google/gsmi.c | 93 +++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index edab00cc6bba..7ee25ce0e318 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -29,6 +29,7 @@
 #include <linux/efi.h>
 #include <linux/module.h>
 #include <linux/ucs2_string.h>
+#include <linux/suspend.h>
 
 #define GSMI_SHUTDOWN_CLEAN	0	/* Clean Shutdown */
 /* TODO(mikew@google.com): Tie in HARDLOCKUP_DETECTOR with NMIWDT */
@@ -70,6 +71,8 @@
 #define GSMI_CMD_SET_NVRAM_VAR		0x03
 #define GSMI_CMD_SET_EVENT_LOG		0x08
 #define GSMI_CMD_CLEAR_EVENT_LOG	0x09
+#define GSMI_CMD_LOG_S0IX_SUSPEND	0x0a
+#define GSMI_CMD_LOG_S0IX_RESUME	0x0b
 #define GSMI_CMD_CLEAR_CONFIG		0x20
 #define GSMI_CMD_HANDSHAKE_TYPE		0xC1
 
@@ -122,7 +125,6 @@ struct gsmi_log_entry_type_1 {
 	u32	instance;
 } __packed;
 
-
 /*
  * Some platforms don't have explicit SMI handshake
  * and need to wait for SMI to complete.
@@ -133,6 +135,15 @@ module_param(spincount, uint, 0600);
 MODULE_PARM_DESC(spincount,
 	"The number of loop iterations to use when using the spin handshake.");
 
+/*
+ * Platforms might not support S0ix logging in their GSMI handlers. In order to
+ * avoid any side-effects of generating an SMI for S0ix logging, use the S0ix
+ * related GSMI commands only for those platforms that explicitly enable this
+ * option.
+ */
+static bool s0ix_logging_enable;
+module_param(s0ix_logging_enable, bool, 0600);
+
 static struct gsmi_buf *gsmi_buf_alloc(void)
 {
 	struct gsmi_buf *smibuf;
@@ -781,6 +792,78 @@ static const struct platform_device_info gsmi_dev_info = {
 	.dma_mask	= DMA_BIT_MASK(32),
 };
 
+#ifdef CONFIG_PM
+static void gsmi_log_s0ix_info(u8 cmd)
+{
+	unsigned long flags;
+
+	/*
+	 * If platform has not enabled S0ix logging, then no action is
+	 * necessary.
+	 */
+	if (!s0ix_logging_enable)
+		return;
+
+	spin_lock_irqsave(&gsmi_dev.lock, flags);
+
+	memset(gsmi_dev.param_buf->start, 0, gsmi_dev.param_buf->length);
+
+	gsmi_exec(GSMI_CALLBACK, cmd);
+
+	spin_unlock_irqrestore(&gsmi_dev.lock, flags);
+}
+
+static int gsmi_log_s0ix_suspend(struct device *dev)
+{
+	/*
+	 * If system is not suspending via firmware using the standard ACPI Sx
+	 * types, then make a GSMI call to log the suspend info.
+	 */
+	if (!pm_suspend_via_firmware())
+		gsmi_log_s0ix_info(GSMI_CMD_LOG_S0IX_SUSPEND);
+
+	/*
+	 * Always return success, since we do not want suspend
+	 * to fail just because of logging failure.
+	 */
+	return 0;
+}
+
+static int gsmi_log_s0ix_resume(struct device *dev)
+{
+	/*
+	 * If system did not resume via firmware, then make a GSMI call to log
+	 * the resume info and wake source.
+	 */
+	if (!pm_resume_via_firmware())
+		gsmi_log_s0ix_info(GSMI_CMD_LOG_S0IX_RESUME);
+
+	/*
+	 * Always return success, since we do not want resume
+	 * to fail just because of logging failure.
+	 */
+	return 0;
+}
+
+static const struct dev_pm_ops gsmi_pm_ops = {
+	.suspend_noirq = gsmi_log_s0ix_suspend,
+	.resume_noirq = gsmi_log_s0ix_resume,
+};
+
+static int gsmi_platform_driver_probe(struct platform_device *dev)
+{
+	return 0;
+}
+
+static struct platform_driver gsmi_driver_info = {
+	.driver = {
+		.name = "gsmi",
+		.pm = &gsmi_pm_ops,
+	},
+	.probe = gsmi_platform_driver_probe,
+};
+#endif
+
 static __init int gsmi_init(void)
 {
 	unsigned long flags;
@@ -792,6 +875,14 @@ static __init int gsmi_init(void)
 
 	gsmi_dev.smi_cmd = acpi_gbl_FADT.smi_command;
 
+#ifdef CONFIG_PM
+	ret = platform_driver_register(&gsmi_driver_info);
+	if (unlikely(ret)) {
+		printk(KERN_ERR "gsmi: unable to register platform driver\n");
+		return ret;
+	}
+#endif
+
 	/* register device */
 	gsmi_dev.pdev = platform_device_register_full(&gsmi_dev_info);
 	if (IS_ERR(gsmi_dev.pdev)) {
-- 
2.19.0.605.g01d371f741-goog

