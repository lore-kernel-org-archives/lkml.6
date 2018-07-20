Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3E3ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684F420833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4WUHau6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684F420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeGTEg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39865 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbeGTEgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so5618339pgs.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bqsTviS5LCPbpilAaLsUiiIHY+C0tnyeqqXRuMZQK0M=;
        b=e4WUHau6oI1KmB0FF6CWmyw82kJjLT0w0zAeCe6wMrsXKKbMfgALZj20pPtLJkV9jM
         7W3LYn9uCEEZNQoEHwq0fiqtpfh7bf9OnbYmjjy/j4EzJ0ZVF/Wcy2dsvHOcJwHMCnS8
         +Ba8/R+fDNtvXXyY1n76mu9bGAsqaeBxvzKTFb5Kimsx0TJj7uvCaE6qc/xePDDvYsoq
         IC93BryJ0iJPW1AIvgYBEf54wQRA3dqWulHb6topYPf5nahL7Idl0f9ubkDZ3yLqtAA/
         YyololYapNPcGfpCJ50J58dofXDTgWkuJvwYvNCmgY0kZS0t+6NmM1geFBKvXU6PtMlL
         l1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bqsTviS5LCPbpilAaLsUiiIHY+C0tnyeqqXRuMZQK0M=;
        b=cggyB5pUhpxiG4BCjhSIrJn5tjecpjrLVRyk4J0UCgFb9C2a5GeKb7KTjGlCW0bmQ3
         NUS/xjiigNc8KAPGXedHhPRWl2dqZNyqgHZCsGsOzoxgFWasQmZ7t0w4K8FHeP/11Gp5
         5Ya5ojazRZ/osKKAJb1h/+BzANxrYTO2ZogXUlBjEijOjrzTBq5gmqFPhnyu+8tMT/8y
         hK4BUG00Yi+a4POh5MBJ+K7EhghsR5Ux+gUeSLM3Y7ruKEK0epSDTMLiJlU336NOGKYZ
         lysYy2Z5lg3TleR7Xwl8AmytvHwrxWpQji3qUeFc7lLIpT9firHmZbsyeDZKuuuMeeUZ
         yfwg==
X-Gm-Message-State: AOUpUlG6ZaNjVs27fC+mzu+7+hLVZazq4WPJZKF8NBNXo9BOEKvujOzR
        zjvHfezt0ilXdUkw5VqPeeVUs/uvrTo=
X-Google-Smtp-Source: AAOMgpf1P/YghMvo3jFq+HvNwNUUNmb0eFIu+iSWC+7oZjejecNbJvs5Awu+9i/hNxauEDqwIR1SJw==
X-Received: by 2002:a62:3ece:: with SMTP id y75-v6mr462908pfj.7.1532058606139;
        Thu, 19 Jul 2018 20:50:06 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:50:05 -0700 (PDT)
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
Subject: [PATCH 18/20] staging: gasket: apex ioctl add __user annotations
Date:   Thu, 19 Jul 2018 20:49:18 -0700
Message-Id: <20180720034920.77320-19-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Add __user annotation to ioctl pointer argument, for sparse checking.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 4c00f3609f081..3e76c4db5db2e 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2018 Google, Inc.
  */
 
+#include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/init.h>
@@ -142,9 +143,10 @@ static int apex_get_status(struct gasket_dev *gasket_dev);
 
 static bool apex_ioctl_check_permissions(struct file *file, uint cmd);
 
-static long apex_ioctl(struct file *file, uint cmd, ulong arg);
+static long apex_ioctl(struct file *file, uint cmd, void __user *argp);
 
-static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg);
+static long apex_clock_gating(struct gasket_dev *gasket_dev,
+			      struct apex_gate_clock_ioctl __user *argp);
 
 static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type);
 
@@ -635,7 +637,7 @@ static bool apex_ioctl_check_permissions(struct file *filp, uint cmd)
 /*
  * Apex-specific ioctl handler.
  */
-static long apex_ioctl(struct file *filp, uint cmd, ulong arg)
+static long apex_ioctl(struct file *filp, uint cmd, void __user *argp)
 {
 	struct gasket_dev *gasket_dev = filp->private_data;
 
@@ -644,7 +646,7 @@ static long apex_ioctl(struct file *filp, uint cmd, ulong arg)
 
 	switch (cmd) {
 	case APEX_IOCTL_GATE_CLOCK:
-		return apex_clock_gating(gasket_dev, arg);
+		return apex_clock_gating(gasket_dev, argp);
 	default:
 		return -ENOTTY; /* unknown command */
 	}
@@ -653,16 +655,17 @@ static long apex_ioctl(struct file *filp, uint cmd, ulong arg)
 /*
  * Gates or un-gates Apex clock.
  * @gasket_dev: Gasket device pointer.
- * @arg: User ioctl arg, in this case to a apex_gate_clock_ioctl struct.
+ * @argp: User ioctl arg, pointer to a apex_gate_clock_ioctl struct.
  */
-static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg)
+static long apex_clock_gating(struct gasket_dev *gasket_dev,
+			      struct apex_gate_clock_ioctl __user *argp)
 {
 	struct apex_gate_clock_ioctl ibuf;
 
 	if (bypass_top_level || !allow_sw_clock_gating)
 		return 0;
 
-	if (copy_from_user(&ibuf, (void __user *)arg, sizeof(ibuf)))
+	if (copy_from_user(&ibuf, argp, sizeof(ibuf)))
 		return -EFAULT;
 
 	gasket_log_error(gasket_dev, "%s %llu", __func__, ibuf.enable);
-- 
2.18.0.233.g985f88cf7e-goog

