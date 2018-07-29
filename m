Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47684C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E250B20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe1HpfID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E250B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbeG2VIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:08:35 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41958 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbeG2VIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:08:35 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so4505867ply.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zGMNkKBoU8Cb7Rhqq4kPz786z8BvNhlQG9jFL4j0L3A=;
        b=pe1HpfIDN51wJjUwUXS6/d7naFnEOez6T1IB5ka/BveVmUbgSNdntEcqzhRmg3XKJG
         TrI3tROED5kw8cxDelgRbfPrwK6zuWZT0+jCF7TnsUJFgHKTPGva1PpF948sgE21Al3z
         1nXMlOd30ZM57uGV2+Pcdcs1ZBXmOM+WCou5YNAxAPW8cFHimjTyAPFaS0ZCNvYWzZfF
         Sbu+1L3OM0eXEYUB9olJQK8G5Yyhtv6MF5V+sUKDHj8757zHwxKTdY9yoFVz/eq0MeMy
         oQJOcqzk0TSAsU5xmnpD8Q+mvfoArCsYxsxkmn9+5wp/Ps3aWjhlxS3JgTtSyY+gSGoQ
         31Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zGMNkKBoU8Cb7Rhqq4kPz786z8BvNhlQG9jFL4j0L3A=;
        b=rK2lY5Sgq700/hS/zThkxYkQfZPYY+mbeTvrJ9PZU1XK2euxn4znBQjeMTEzjhHBeY
         QW0sUNhBwab3y1OJIKCAPQ+eOI33oyWUX2kzObIvwP9vQcaeUEfN48WNVeus8yfGgNjM
         ewbJZjpYrV5ASiQRqpaO0Lwb2o2xK8PxD0FPp5hWZzaf3qnWEZ2v2zpD16Ptdmsl8e1/
         s9HxG1jx6Uv7Ki5TPqliSUxEZO0gRtWi31J+dHq4OM4AIx6K/snxLLwc3ez6suXV597x
         MIGA4fSWiHhd5QkCq8uRQqddRdl7nidoy6C0gHRwcGhptaU1BZTp5VFQkUTPdwv6jMMG
         VLdA==
X-Gm-Message-State: AOUpUlFOJ16G0i2V/pnOMTSSAmIYymzvlR8/MDb+myF6BaGrBmdEuF5N
        5yJDTv2OPMzH6BFYhFaNKUv+56Hd
X-Google-Smtp-Source: AAOMgpfjy0Ev/sTh+wmqsIkcqyjRKQGUdNSLWJnhahudb7r4jUSK0KdEqWIY/ki5FT59uNLmBFykbw==
X-Received: by 2002:a17:902:8bc4:: with SMTP id r4-v6mr13625067plo.257.1532893022776;
        Sun, 29 Jul 2018 12:37:02 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id k26-v6sm27474062pfb.167.2018.07.29.12.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 12:37:02 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 05/13] staging: gasket: apex: simplify comments for static functions
Date:   Sun, 29 Jul 2018 12:36:38 -0700
Message-Id: <20180729193646.201721-6-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180729193646.201721-1-toddpoynor@gmail.com>
References: <20180729193646.201721-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Static functions don't need kernel doc formatting, can be simplified.
Reformat comments that can be single-line.  Remove extraneous text.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 64 +++++-----------------------
 1 file changed, 10 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index ab466d49608a7..a756764751777 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -378,34 +378,20 @@ static int apex_sysfs_setup_cb(struct gasket_dev *gasket_dev)
 		gasket_dev->dev_info.device, apex_sysfs_attrs);
 }
 
-/* On device open, we want to perform a core reinit reset. */
+/* On device open, perform a core reinit reset. */
 static int apex_device_open_cb(struct gasket_dev *gasket_dev)
 {
 	return gasket_reset_nolock(gasket_dev, APEX_CHIP_REINIT_RESET);
 }
 
-/**
- * apex_get_status - Set device status.
- * @dev: Apex device struct.
- *
- * Description: Check the device status registers and set the driver status
- *		to ALIVE or DEAD.
- *
- *		Returns 0 if status is ALIVE, a negative error number otherwise.
- */
+/* Check the device status registers and return device status ALIVE or DEAD. */
 static int apex_get_status(struct gasket_dev *gasket_dev)
 {
 	/* TODO: Check device status. */
 	return GASKET_STATUS_ALIVE;
 }
 
-/**
- * apex_device_cleanup - Clean up Apex HW after close.
- * @gasket_dev: Gasket device pointer.
- *
- * Description: Resets the Apex hardware. Called on final close via
- * device_close_cb.
- */
+/* Reset the Apex hardware. Called on final close via device_close_cb. */
 static int apex_device_cleanup(struct gasket_dev *gasket_dev)
 {
 	u64 scalar_error;
@@ -429,14 +415,7 @@ static int apex_device_cleanup(struct gasket_dev *gasket_dev)
 	return ret;
 }
 
-/**
- * apex_reset - Quits reset.
- * @gasket_dev: Gasket device pointer.
- *
- * Description: Resets the hardware, then quits reset.
- * Called on device open.
- *
- */
+/* Reset the hardware, then quit reset.  Called on device open. */
 static int apex_reset(struct gasket_dev *gasket_dev, uint type)
 {
 	int ret;
@@ -459,9 +438,7 @@ static int apex_reset(struct gasket_dev *gasket_dev, uint type)
 	return ret;
 }
 
-/*
- * Enters GCB reset state.
- */
+/* Enter GCB reset state. */
 static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 {
 	if (bypass_top_level)
@@ -516,9 +493,7 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 	return 0;
 }
 
-/*
- * Quits GCB reset state.
- */
+/* Quit GCB reset state. */
 static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 {
 	u32 val0, val1;
@@ -601,9 +576,7 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 	return 0;
 }
 
-/*
- * Determines if GCB is in reset state.
- */
+/* Determine if GCB is in reset state. */
 static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
 {
 	u32 val = gasket_dev_read_32(
@@ -615,9 +588,6 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
 
 /*
  * Check permissions for Apex ioctls.
- * @file: File pointer from ioctl.
- * @cmd: ioctl command.
- *
  * Returns true if the current user may execute this ioctl, and false otherwise.
  */
 static bool apex_ioctl_check_permissions(struct file *filp, uint cmd)
@@ -625,9 +595,7 @@ static bool apex_ioctl_check_permissions(struct file *filp, uint cmd)
 	return !!(filp->f_mode & FMODE_WRITE);
 }
 
-/*
- * Apex-specific ioctl handler.
- */
+/* Apex-specific ioctl handler. */
 static long apex_ioctl(struct file *filp, uint cmd, void __user *argp)
 {
 	struct gasket_dev *gasket_dev = filp->private_data;
@@ -643,11 +611,7 @@ static long apex_ioctl(struct file *filp, uint cmd, void __user *argp)
 	}
 }
 
-/*
- * Gates or un-gates Apex clock.
- * @gasket_dev: Gasket device pointer.
- * @argp: User ioctl arg, pointer to a apex_gate_clock_ioctl struct.
- */
+/* Gates or un-gates Apex clock. */
 static long apex_clock_gating(struct gasket_dev *gasket_dev,
 			      struct apex_gate_clock_ioctl __user *argp)
 {
@@ -681,15 +645,7 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev,
 	return 0;
 }
 
-/*
- * Display driver sysfs entries.
- * @device: Kernel device structure.
- * @attr: Attribute to display.
- * @buf: Buffer to which to write output.
- *
- * Description: Looks up the driver data and file-specific attribute data (the
- * type of the attribute), then fills "buf" accordingly.
- */
+/* Display driver sysfs entries. */
 static ssize_t sysfs_show(
 	struct device *device, struct device_attribute *attr, char *buf)
 {
-- 
2.18.0.345.g5c9ce644c3-goog

