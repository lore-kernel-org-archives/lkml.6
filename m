Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4732AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F372E20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMf8RUv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F372E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeGTEgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36925 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbeGTEgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so5615399pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ayfH5Y/vyBaIp45uKVQCo0pzmhTz+X0jzM0LY5Y+bcQ=;
        b=fMf8RUv4EdKcXegdXiofuOmWDDWule01OXN+Q/MtFwtgcRFLped4bBpRi/pnfYryVf
         /1b09Zaq5AcS+uHruye4SCYbOElTAcq8cpN+t73QGCd7MwFVodg2+2UJ1NN3H9dFDpoX
         IS1bnBIXYlFf9/DXV3kucuCklCoRzXFdKBAlhLKdQNnQ79ieluxW9ZNrj1HNIgRYeF68
         pP8RVUWTx95u5ji4sC2XccYGAlYy43WrLaX9oVum1Amu1bvgJMZbs9NMVmPxavzjDcnT
         BLn8XEKq5376xnKpjki2+nH2BeSOQbryuZmbl4ZI1fWNwwVCZzmO3EOcBjVbDfZVudtc
         m5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ayfH5Y/vyBaIp45uKVQCo0pzmhTz+X0jzM0LY5Y+bcQ=;
        b=kr8g4hpBbr70YqA/cfwyCw0/SROGhtkbcHi6s7MVZScgzLOzU9A7JBFqYPqna6Wnzi
         oY9B4QoYoLZBzzlTNQFPZ3PyHTzFMHG/AbrKyOZT7Df4Bbj3HLw636wYGq/2zLw1iTT1
         7RRpcjUITnzMyRx41nC6xXBMM1/QwyADOI1FqiJPCdMs1lrDflXGzDevWpIw5ijKEemA
         AhJthhVoo4+46Bt1cxVMS0TdD5UegISZhjIYrgnOtdnWTc+nPT+rSF8jsUCPP4dSj+Dg
         rTuOG5MmdBjMrTqV3DoThQPTrCEQiZCvylK9KJzH8rUyErqCz3Yc9vQSAVGjZVbUdGD4
         XLpg==
X-Gm-Message-State: AOUpUlGzIZQa6IsnzDQt8GNEbcqfDZnY6c1xqzROLGzrcy5pHiAV36Qr
        MdOQSWDxRcEfPTW9BhC76Lw=
X-Google-Smtp-Source: AAOMgpf094CHfAW2jfXslUpRT1uUclJnAQeIxRP0P5RHv0ZW8vTBahQAAEHNvjB1DL5v5ZggliYSEA==
X-Received: by 2002:a62:f0d:: with SMTP id x13-v6mr441164pfi.123.1532058605208;
        Thu, 19 Jul 2018 20:50:05 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:50:04 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 17/20] staging: gasket: top ioctl handler add __user annotations
Date:   Thu, 19 Jul 2018 20:49:17 -0700
Message-Id: <20180720034920.77320-18-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Add __user annotation to gasket_core top-level ioctl handling pointer
arguments, for sparse checking.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 6 ++++--
 drivers/staging/gasket/gasket_core.h | 7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 254fb392c05c1..40e46ca5228c8 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -14,6 +14,7 @@
 #include "gasket_page_table.h"
 #include "gasket_sysfs.h"
 
+#include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/init.h>
@@ -1781,6 +1782,7 @@ static long gasket_ioctl(struct file *filp, uint cmd, ulong arg)
 {
 	struct gasket_dev *gasket_dev;
 	const struct gasket_driver_desc *driver_desc;
+	void __user *argp = (void __user *)arg;
 	char path[256];
 
 	if (!filp)
@@ -1810,14 +1812,14 @@ static long gasket_ioctl(struct file *filp, uint cmd, ulong arg)
 		 * check_and_invoke_callback.
 		 */
 		if (driver_desc->ioctl_handler_cb)
-			return driver_desc->ioctl_handler_cb(filp, cmd, arg);
+			return driver_desc->ioctl_handler_cb(filp, cmd, argp);
 
 		gasket_log_error(
 			gasket_dev, "Received unknown ioctl 0x%x", cmd);
 		return -EINVAL;
 	}
 
-	return gasket_handle_ioctl(filp, cmd, arg);
+	return gasket_handle_ioctl(filp, cmd, argp);
 }
 
 int gasket_reset(struct gasket_dev *gasket_dev, uint reset_type)
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 7ea1df123ba5d..bf4ed3769efb2 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -314,9 +314,12 @@ struct gasket_dev {
 	struct hlist_node legacy_hlist_node;
 };
 
+/* Type of the ioctl handler callback. */
+typedef long (*gasket_ioctl_handler_cb_t)
+		(struct file *file, uint cmd, void __user *argp);
 /* Type of the ioctl permissions check callback. See below. */
 typedef int (*gasket_ioctl_permissions_cb_t)(
-	struct file *filp, uint cmd, ulong arg);
+	struct file *filp, uint cmd, void __user *argp);
 
 /*
  * Device type descriptor.
@@ -550,7 +553,7 @@ struct gasket_driver_desc {
 	 * return -EINVAL. Should return an error status (either -EINVAL or
 	 * the error result of the ioctl being handled).
 	 */
-	long (*ioctl_handler_cb)(struct file *filp, uint cmd, ulong arg);
+	gasket_ioctl_handler_cb_t ioctl_handler_cb;
 
 	/*
 	 * device_status_cb: Callback to determine device health.
-- 
2.18.0.233.g985f88cf7e-goog

