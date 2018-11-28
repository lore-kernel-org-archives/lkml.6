Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1268CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F452081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kooTq+ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F452081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeK2Kqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:46:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36496 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbeK2Kqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:46:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id a18so395668wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eFxFHAhxhJIs1y2b8RAt95A2ABOqjOFINkdabGLCjtE=;
        b=kooTq+yeafdgSYsMFGjkac1PuxTzQqMyqqC22B2gJam7FysNlJSMzvzNOIpJhEO9X6
         wHDWEk+TLbvaWeYqhq4Gl6Sybp/5G24Y6N3zDeAZRPQIAsbPHZFN3oTGAN2GjJc/kmS7
         R5tEDyX6R6+RxUqzh1nTGC0vzIZdr5edGHTn18Po3JMK/jC1CFKF6NZpJ8rQE8/N7OQs
         WdK88tCka1M5KSf/egGIHN1tZOAgpm16KdsFwgAc8OIkSn04y1NF8R2GlRmqaEtXoIyC
         1FOn4NMuyakOj/kd+vcN6uSHVFW909vC0YoBUavsq7fbzM5CKkg7XL0xb2tB4WROEBog
         4C0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eFxFHAhxhJIs1y2b8RAt95A2ABOqjOFINkdabGLCjtE=;
        b=tr7VPoliAxxKT9jIKjYOrtMJqyrupYDHYfRf6VFQ3JescxUtTg/lF0D2aO8MDL1opr
         ExUy5rSp1n46CltFaX2FwXNax8GXrEfdtsjQRdlNqb/UPuNYh+IBAzCBm9fhBq0LEW3i
         OfQB5OICo2VFMeygKNm8ND+RsT5+7jKgToZoEf6+xxduWmXUnA0KhA+AK3SltJ3r+NQJ
         BvC6MbtNIlFuGBvGdnc3iEMj32CWTuq077rbE3uo5JhXpNBWI6bXQbJ9DHMjv5JMMGgf
         ESmOLDL/kNIv+aiUZ3ScbTXnTqiTjLVwFPJNe4mbsT4Xvpfddf+/UoGRfAFRTn/jERqn
         lHow==
X-Gm-Message-State: AA+aEWZ4kP34tnXzcGvT1l4ihq5Rnk2OK6Cao11pz7KQ5nzWTwjb83SM
        6lKe4Re1rgXHW4f1YL3twJ4=
X-Google-Smtp-Source: AFSGD/WEk8DlbZGxLBYIt68454QUehT3Fg8uB2ChJMTZ/Pk9kMS6LOFVZslxZRUwy/BcRlPgrVJDyg==
X-Received: by 2002:a1c:f41:: with SMTP id 62mr4386530wmp.96.1543448591326;
        Wed, 28 Nov 2018 15:43:11 -0800 (PST)
Received: from localhost.localdomain ([88.97.17.19])
        by smtp.gmail.com with ESMTPSA id o81sm744845wmd.10.2018.11.28.15.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 15:43:10 -0800 (PST)
From:   =?UTF-8?q?Szilveszter=20Sz=C3=A9kely?= <szekelyszilv@gmail.com>
Cc:     =?UTF-8?q?Szilveszter=20Sz=C3=A9kely?= <szekelyszilv@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vchiq_arm: add __user pointer annotations
Date:   Wed, 28 Nov 2018 23:40:32 +0000
Message-Id: <20181128234032.7170-1-szekelyszilv@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __user to pointers based on context and suggestions by sparse.

Other sparse warnings still remain, in cases where more change would be
required apart from adding __user.

Signed-off-by: Szilveszter Székely <szekelyszilv@gmail.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 28 +++++++++----------
 .../interface/vchiq_arm/vchiq_if.h            |  2 +-
 .../interface/vchiq_arm/vchiq_ioctl.h         |  4 +--
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 0caee2d69..f28f68119 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1593,7 +1593,7 @@ vchiq_compat_ioctl_queue_message(struct file *file,
 				 unsigned long arg)
 {
 	VCHIQ_QUEUE_MESSAGE_T *args;
-	struct vchiq_element *elements;
+	struct vchiq_element __user *elements;
 	struct vchiq_queue_message32 args32;
 	unsigned int count;
 
@@ -1659,7 +1659,7 @@ vchiq_compat_ioctl_queue_bulk(struct file *file,
 			      unsigned int cmd,
 			      unsigned long arg)
 {
-	VCHIQ_QUEUE_BULK_TRANSFER_T *args;
+	VCHIQ_QUEUE_BULK_TRANSFER_T __user *args;
 	struct vchiq_queue_bulk_transfer32 args32;
 	struct vchiq_queue_bulk_transfer32 *ptrargs32 =
 		(struct vchiq_queue_bulk_transfer32 *)arg;
@@ -1725,16 +1725,16 @@ vchiq_compat_ioctl_await_completion(struct file *file,
 				    unsigned int cmd,
 				    unsigned long arg)
 {
-	VCHIQ_AWAIT_COMPLETION_T *args;
-	VCHIQ_COMPLETION_DATA_T *completion;
+	VCHIQ_AWAIT_COMPLETION_T __user *args;
+	VCHIQ_COMPLETION_DATA_T __user *completion;
 	VCHIQ_COMPLETION_DATA_T completiontemp;
 	struct vchiq_await_completion32 args32;
 	struct vchiq_completion_data32 completion32;
-	unsigned int *msgbufcount32;
+	unsigned int __user *msgbufcount32;
 	unsigned int msgbufcount_native;
 	compat_uptr_t msgbuf32;
-	void *msgbuf;
-	void **msgbufptr;
+	void __user *msgbuf;
+	void * __user *msgbufptr;
 	long ret;
 
 	args = compat_alloc_user_space(sizeof(*args) +
@@ -1743,11 +1743,11 @@ vchiq_compat_ioctl_await_completion(struct file *file,
 	if (!args)
 		return -EFAULT;
 
-	completion = (VCHIQ_COMPLETION_DATA_T *)(args + 1);
-	msgbufptr = (void __user **)(completion + 1);
+	completion = (VCHIQ_COMPLETION_DATA_T __user *)(args + 1);
+	msgbufptr = (void * __user *)(completion + 1);
 
 	if (copy_from_user(&args32,
-			   (struct vchiq_completion_data32 *)arg,
+			   (struct vchiq_completion_data32 __user *)arg,
 			   sizeof(args32)))
 		return -EFAULT;
 
@@ -1875,7 +1875,7 @@ vchiq_compat_ioctl_dequeue_message(struct file *file,
 				   unsigned int cmd,
 				   unsigned long arg)
 {
-	VCHIQ_DEQUEUE_MESSAGE_T *args;
+	VCHIQ_DEQUEUE_MESSAGE_T __user *args;
 	struct vchiq_dequeue_message32 args32;
 
 	args = compat_alloc_user_space(sizeof(*args));
@@ -1883,7 +1883,7 @@ vchiq_compat_ioctl_dequeue_message(struct file *file,
 		return -EFAULT;
 
 	if (copy_from_user(&args32,
-			   (struct vchiq_dequeue_message32 *)arg,
+			   (struct vchiq_dequeue_message32 __user *)arg,
 			   sizeof(args32)))
 		return -EFAULT;
 
@@ -1910,7 +1910,7 @@ vchiq_compat_ioctl_get_config(struct file *file,
 			      unsigned int cmd,
 			      unsigned long arg)
 {
-	VCHIQ_GET_CONFIG_T *args;
+	VCHIQ_GET_CONFIG_T __user *args;
 	struct vchiq_get_config32 args32;
 
 	args = compat_alloc_user_space(sizeof(*args));
@@ -1918,7 +1918,7 @@ vchiq_compat_ioctl_get_config(struct file *file,
 		return -EFAULT;
 
 	if (copy_from_user(&args32,
-			   (struct vchiq_get_config32 *)arg,
+			   (struct vchiq_get_config32 __user *)arg,
 			   sizeof(args32)))
 		return -EFAULT;
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index 7b948a173..0cdaebee9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -87,7 +87,7 @@ typedef struct vchiq_header_struct {
 } VCHIQ_HEADER_T;
 
 struct vchiq_element {
-	const void *data;
+	const void __user *data;
 	unsigned int size;
 };
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index 9f859953f..858f46bd2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -50,7 +50,7 @@ typedef struct {
 typedef struct {
 	unsigned int handle;
 	unsigned int count;
-	const struct vchiq_element *elements;
+	const struct vchiq_element __user *elements;
 } VCHIQ_QUEUE_MESSAGE_T;
 
 typedef struct {
@@ -85,7 +85,7 @@ typedef struct {
 
 typedef struct {
 	unsigned int config_size;
-	VCHIQ_CONFIG_T *pconfig;
+	VCHIQ_CONFIG_T __user *pconfig;
 } VCHIQ_GET_CONFIG_T;
 
 typedef struct {
-- 
2.19.2

