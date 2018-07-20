Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86DBECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB2020833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/SPIehM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB2020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeGTEgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36930 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbeGTEgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so5615460pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X4cZYZeVhwniWGfZ3n0v+5nZzCbWfxWqlSbTxftCGvE=;
        b=k/SPIehMgrMr5rfAd1zksN0yE3yxU2qZTh8HiuL4pBFIYubHJQzaFIo+1odY1LtQPa
         gTG/vvyHwxztMiqtQpccrLHWEflppiaiwwS1IbSobovZWZ9Ov9NPSQRDLY+X1Mf215AO
         A4wLXQHgZNX7vyTL4lylJOa/X3jibfK9ayWX1Y2xKw3O+OA1IK3j+HaRQnVvLCj7erIV
         iHrI77lgN1hrUhYDVI5wlfVRR6lPVAykO875u/HJuy1Z1wM9/SqCENqKjJvrcdizwa6B
         2tFCrN6MNjzEAQDHp6q8sWZ/gmP6BAiGjUcH/DF2lmTii8fW9qTVC6DIkSV4yo3A7cqn
         xzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X4cZYZeVhwniWGfZ3n0v+5nZzCbWfxWqlSbTxftCGvE=;
        b=abGpXhWy9nVuh6PNKmd5BPrSt5ppvLzW3//mtLOS89glcYrfhSGeXigolkwITvTLcq
         F4KZbpbP3lH9hc0i4bKfHgDtzUmuCY0A3j3ZCW4d7grwig+nNGEwha7PqmzdAxyBBS5R
         f6m+KR71mGdwxfDt21k6HmGf0KuND84gNurc9V92NHxeZfdKIUu49SJZrJaBFZuH1DSa
         WdWiBm4CunFRaTVf9L7QJAokbfoVsVpoQBDBjU4qmR0y+OgXQcUkQvLB8FLsUMwk0Ivv
         T1oxEzMYlnHzbwySdgfb3GfDv4NI+TwYVkgry7LrFMCMjmG1SOGs0iSjdiTyhIUIz7xq
         CDuA==
X-Gm-Message-State: AOUpUlFwkZplJEl7qHj5snobitFC3XAYpBwSIeIm616uV5uw5vvSkLSA
        L+0FKZDuVJZ0WJoorVisUUaNMb2vsoM=
X-Google-Smtp-Source: AAOMgpdT+DanX0qQuMILVTBZpqxn+1w2EGhFsSHju7LNR5q9pM/16RSXUL0FAcKdZ/D8BydkcYCAUA==
X-Received: by 2002:a62:9992:: with SMTP id t18-v6mr432729pfk.239.1532058607008;
        Thu, 19 Jul 2018 20:50:07 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:50:06 -0700 (PDT)
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
Subject: [PATCH 19/20] staging: gasket: common ioctl dispatcher add __user annotations
Date:   Thu, 19 Jul 2018 20:49:19 -0700
Message-Id: <20180720034920.77320-20-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
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

