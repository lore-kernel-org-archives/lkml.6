Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BCDECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC7C20863
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9GRQyVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC7C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbeGUNum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42515 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387710AbeGUNul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so9015928pgp.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ayfH5Y/vyBaIp45uKVQCo0pzmhTz+X0jzM0LY5Y+bcQ=;
        b=I9GRQyVWrz3zaUzFyGTcdJ3uNq6WywHBrWQqXYj1bvZK5A1NacDbG6CVtSqfAzzvl2
         fWRpZ3bN2v6npooSvQVdACFJplHHfmDknnWsJTRadUb1VxsiIGfspUs+qPPzBtx60up1
         W9EcwWtM+G3SoXs0VWGC27GobRp3fkn1QUWcMNGfGELArTPYDnH4lX8l6vbgOc3ZmJmF
         HHIpMG6Hvt9RMltZG2zNzxn2/wrIsXZvLB4ZTKqks6/T2s8DoR29eXcdRSpPZcgWquEK
         YQNRVB41AKA718M9eRP+oP1guLfeEKsMoVaEbuS7XskHDIzCOje+O0U8QdI5uG9YG4pk
         c7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ayfH5Y/vyBaIp45uKVQCo0pzmhTz+X0jzM0LY5Y+bcQ=;
        b=QPzEXchHlQQoBC2FGHsC6x/53EwsguJiuw77ihh/yN4NyLuZh1q2LWEaQnbztDJlk7
         dp2qN8umjoPskq8kAfo2sIB1viFg6LAlUTl4b11yWWcUbLVTKyg9hJiGz0mUi2LfnvgY
         csTx6Mly6UpNZAouLjYIcJN13c/5zPkA0pJAS013SDM2FRwtSHivD9rVIRlcurEXeud5
         2mmYTurlIMIg3ds8thK2aCrlXrwPakzUt6NCMwAsj6nHARZ6bkioockl0AEzfpV+lbYw
         ODZ8TuIrA6DTWyDWHCoJ7YfvyDBugtmnMU1n3m8iHjxd8LtxO/3/9I957MG0XqvOTaJF
         toyQ==
X-Gm-Message-State: AOUpUlEKQfSzXPKOyIu6XfKbbq8XojJUb7kkk4/cxqRJveEgLWyPKdNR
        r64sEzD5PtJscxtgRzDQwBY=
X-Google-Smtp-Source: AAOMgpdqAVb9CCJNfQ/kWCwDGFSCuktXB4BY6ouuPo+qFMrjkq4QacEM+wJRLbzKGIQ6fq3Xn5q1Dw==
X-Received: by 2002:a63:9a52:: with SMTP id e18-v6mr5505227pgo.188.1532177881744;
        Sat, 21 Jul 2018 05:58:01 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:58:01 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 17/20] staging: gasket: top ioctl handler add __user annotations
Date:   Sat, 21 Jul 2018 05:57:10 -0700
Message-Id: <20180721125713.88501-32-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
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

