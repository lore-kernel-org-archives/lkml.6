Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FA9ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5B120862
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8A3exUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5B120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbeGUNup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:45 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37743 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbeGUNuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:44 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so6346970plc.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X4cZYZeVhwniWGfZ3n0v+5nZzCbWfxWqlSbTxftCGvE=;
        b=M8A3exUqcL8X+J23D8yrTq6Ybii8cSEuIxeYfKOJBJSmfML7L4MOj1A6zDvtvUXyUv
         6ModXPAK2FCjD0yDkXwZAUfsO2ku+1HWoiuqHhG90lbKefk65Y86AqMVTL9FZ7EsANmx
         s0pkSCSk3zx7GneE6RtbAM8UbYv/AgtLCTT/EPkW9F07906eKGaa3IKS9ONu/3jB6toC
         WHQKs1uRrB7KGdzsP6NzBiE75fiJ+aoVVbUKKPlQcJBjU2eHoy+UK+ZQ1lgbjYlmliNM
         X2hq7ARA9a/eEShHMcVd+Rb09rNOdhBL8PHUVwhiN21ldqG95MNKcmnZNxvHL0JyeSxm
         f8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X4cZYZeVhwniWGfZ3n0v+5nZzCbWfxWqlSbTxftCGvE=;
        b=BR59M2KlYMRhYY+omAabuvIY20v/jRuPDIC0zPuHHnahInB3SMroO6tnJ8qX7NOvaG
         jg+ovot+p3K2PqwzKzD7C0X5FHGl9ZBBwiiocByPgPmoYEs559r9yKjq5+ZaYMzVxX1T
         cemNNJrjjmpp8EY4bk3jm0nFh7nABNWL8ENx9ZfytrXPk4HldKkhCQdu7e1RphrrDfFz
         nrpJRlw22ySp5vdj/rvCV3bOtipxB8Gz4kU0kBRNxjinXCiXuOErK0CScsCvxTKe7tyt
         2Mwk9lPz40gf4NntEMNyYaBjVZP3MPJcfqdy63d4nBqiycQx7tGl0bDxXui7N/uJ7S8t
         kxLw==
X-Gm-Message-State: AOUpUlGZjlFoQF5X8lKfB3oBv4lxktXeiamhNIiO8IiLAc8fRO/LerzQ
        4XK5QZLhedwvrwHHoakxpAc=
X-Google-Smtp-Source: AAOMgpe/FslA4q+Rw85QQCtb3FegXEJCyJj3+jgfd9bIgjJ5FPcJhdHn5J4pZfFUVmAmDXg0WnWxyg==
X-Received: by 2002:a17:902:622:: with SMTP id 31-v6mr5770749plg.153.1532177883588;
        Sat, 21 Jul 2018 05:58:03 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:58:03 -0700 (PDT)
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
Subject: [PATCH 19/20] staging: gasket: common ioctl dispatcher add __user annotations
Date:   Sat, 21 Jul 2018 05:57:12 -0700
Message-Id: <20180721125713.88501-34-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Add __user annotation to gasket core common ioctl pointer arguments for
sparse checking.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_ioctl.c | 8 +++++---
 drivers/staging/gasket/gasket_ioctl.h | 4 +++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 8fd44979fe713..998d0e215523c 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -7,6 +7,7 @@
 #include "gasket_interrupt.h"
 #include "gasket_logging.h"
 #include "gasket_page_table.h"
+#include <linux/compiler.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
 
@@ -39,13 +40,14 @@ static int gasket_config_coherent_allocator(
  * standard ioctl dispatch function.
  * @filp: File structure pointer describing this node usage session.
  * @cmd: ioctl number to handle.
- * @arg: ioctl-specific data pointer.
+ * @argp: ioctl-specific data pointer.
  *
  * Standard ioctl dispatcher; forwards operations to individual handlers.
  */
-long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg)
+long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
 {
 	struct gasket_dev *gasket_dev;
+	unsigned long arg = (unsigned long)argp;
 	int retval;
 
 	gasket_dev = (struct gasket_dev *)filp->private_data;
@@ -53,7 +55,7 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg)
 
 	if (gasket_get_ioctl_permissions_cb(gasket_dev)) {
 		retval = gasket_get_ioctl_permissions_cb(gasket_dev)(
-			filp, cmd, arg);
+			filp, cmd, argp);
 		if (retval < 0) {
 			trace_gasket_ioctl_exit(-EPERM);
 			return retval;
diff --git a/drivers/staging/gasket/gasket_ioctl.h b/drivers/staging/gasket/gasket_ioctl.h
index 461fab27a3e52..51f468c77f041 100644
--- a/drivers/staging/gasket/gasket_ioctl.h
+++ b/drivers/staging/gasket/gasket_ioctl.h
@@ -5,6 +5,8 @@
 
 #include "gasket_core.h"
 
+#include <linux/compiler.h>
+
 /*
  * Handle Gasket common ioctls.
  * @filp: Pointer to the ioctl's file.
@@ -13,7 +15,7 @@
  *
  * Returns 0 on success and nonzero on failure.
  */
-long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg);
+long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp);
 
 /*
  * Determines if an ioctl is part of the standard Gasket framework.
-- 
2.18.0.233.g985f88cf7e-goog

