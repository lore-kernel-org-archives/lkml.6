Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAACC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6B4278BB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xn2N3Pye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6B4278BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936678AbeF2SvD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:51:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43687 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933582AbeF2Su7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:50:59 -0400
Received: by mail-pf0-f195.google.com with SMTP id y8-v6so4609178pfm.10;
        Fri, 29 Jun 2018 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E8A8ccWRZX/zVWcRbc1aGy2vsB0KzUrtdhJbwoCUio4=;
        b=Xn2N3PyeGHg4gqwhDDLsYgQEMiSeULmzCToUobQ/Yp9z5qUaQXZVOEpkZ/QZmEm9DS
         z/UB33nAuSQiWcNDSmz9VEejmJhynatA+jyB09LHge1de91gi9FS5kbXGh1HUkxN0ABw
         zSRc5rs45LaL9iRb7XvXpR6amISx5ZKr68yHTJLniNQF4jdbthz1s6qR3dmDy3evRtH5
         Dljh1+ZXICku6N3icrx4rxL46SQKcn6SAjRl3lY/smeczSo6Poto6s2yXOK4NkQGLWRF
         4GfD2wYvYHF7bdEmAr0qDmlzSOgWSbu44YzWOIt/kMnSlJk2I34vNY9K8vCRYJUXgPy9
         Azag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E8A8ccWRZX/zVWcRbc1aGy2vsB0KzUrtdhJbwoCUio4=;
        b=S6GPsUEqUmL8psvO95/9PzVr1Uf6Zfap0S8E/NrEjsLe7BnVIa5QUw4yLoOPg3v8fT
         lOcj8fevHoMDlXmPid7po8SIFhL3eMaJbwlm7PZaZvRVfqnqYY+BdcTQJPcZ7UAgYTZj
         O88u9bXai2LOOjZw+xAQnD4A7b4VLoFR8NPuR7SwB+sFoczTVwkAjI+7nsd9Q6KBrA5q
         rePic65TFFKy7vgfwzHVfZzUBlQ17qI6xJSgOvpYusoLsigIZyOU9P/2AhbPgQDcztBo
         +AEUtK8IYZ+Usm2Qg2sXU+ODwgj5XsUEMJVBUFiXNQNcbLcZmUIGlxn+d5Kc4VW6+9hu
         5NZg==
X-Gm-Message-State: APt69E2iM2L3YF/YhbYsK2yBhURuS+5ufjrwAwuiHjQJOdrakPJC7pAA
        g4XT4ph7HELnwqdEd/zFAviUIQ==
X-Google-Smtp-Source: AAOMgpdzzqhsjOsb0PKEK6MG545i3mr/GjOgazV0T7wBylhgKTbE6YEPXgqAn9dlWX3GC8IflQ2i6g==
X-Received: by 2002:a62:5247:: with SMTP id g68-v6mr15706241pfb.149.1530298258280;
        Fri, 29 Jun 2018 11:50:58 -0700 (PDT)
Received: from mappy.world.mentorg.com ([2602:306:cc3b:f020:7cd8:9ad7:a375:e853])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm27672308pfg.130.2018.06.29.11.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 11:50:57 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/17] media: v4l2: async: Add convenience functions to allocate and add asd's
Date:   Fri, 29 Jun 2018 11:49:48 -0700
Message-Id: <1530298220-5097-5-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add these convenience functions, which allocate an asd of match type
fwnode, i2c, or device-name, of size asd_struct_size, and then adds
them to the notifier asd_list.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/media/v4l2-core/v4l2-async.c | 76 ++++++++++++++++++++++++++++++++++++
 include/media/v4l2-async.h           | 62 +++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 48d66ae..17f32d9 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -659,6 +659,82 @@ int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
 }
 EXPORT_SYMBOL_GPL(v4l2_async_notifier_add_subdev);
 
+struct v4l2_async_subdev *
+v4l2_async_notifier_add_fwnode_subdev(struct v4l2_async_notifier *notifier,
+				      struct fwnode_handle *fwnode,
+				      unsigned int asd_struct_size)
+{
+	struct v4l2_async_subdev *asd;
+	int ret;
+
+	asd = kzalloc(asd_struct_size, GFP_KERNEL);
+	if (!asd)
+		return ERR_PTR(-ENOMEM);
+
+	asd->match_type = V4L2_ASYNC_MATCH_FWNODE;
+	asd->match.fwnode = fwnode;
+
+	ret = v4l2_async_notifier_add_subdev(notifier, asd);
+	if (ret) {
+		kfree(asd);
+		return ERR_PTR(ret);
+	}
+
+	return asd;
+}
+EXPORT_SYMBOL_GPL(v4l2_async_notifier_add_fwnode_subdev);
+
+struct v4l2_async_subdev *
+v4l2_async_notifier_add_i2c_subdev(struct v4l2_async_notifier *notifier,
+				   int adapter_id, unsigned short address,
+				   unsigned int asd_struct_size)
+{
+	struct v4l2_async_subdev *asd;
+	int ret;
+
+	asd = kzalloc(asd_struct_size, GFP_KERNEL);
+	if (!asd)
+		return ERR_PTR(-ENOMEM);
+
+	asd->match_type = V4L2_ASYNC_MATCH_I2C;
+	asd->match.i2c.adapter_id = adapter_id;
+	asd->match.i2c.address = address;
+
+	ret = v4l2_async_notifier_add_subdev(notifier, asd);
+	if (ret) {
+		kfree(asd);
+		return ERR_PTR(ret);
+	}
+
+	return asd;
+}
+EXPORT_SYMBOL_GPL(v4l2_async_notifier_add_i2c_subdev);
+
+struct v4l2_async_subdev *
+v4l2_async_notifier_add_devname_subdev(struct v4l2_async_notifier *notifier,
+				       const char *device_name,
+				       unsigned int asd_struct_size)
+{
+	struct v4l2_async_subdev *asd;
+	int ret;
+
+	asd = kzalloc(asd_struct_size, GFP_KERNEL);
+	if (!asd)
+		return ERR_PTR(-ENOMEM);
+
+	asd->match_type = V4L2_ASYNC_MATCH_DEVNAME;
+	asd->match.device_name = device_name;
+
+	ret = v4l2_async_notifier_add_subdev(notifier, asd);
+	if (ret) {
+		kfree(asd);
+		return ERR_PTR(ret);
+	}
+
+	return asd;
+}
+EXPORT_SYMBOL_GPL(v4l2_async_notifier_add_devname_subdev);
+
 int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 {
 	struct v4l2_async_notifier *subdev_notifier;
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 6e752ef..5394361 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -167,6 +167,68 @@ int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
 				   struct v4l2_async_subdev *asd);
 
 /**
+ * v4l2_async_notifier_add_fwnode_subdev - Allocate and add a fwnode async
+ *				subdev to the notifier's master asd_list.
+ *
+ * @notifier: pointer to &struct v4l2_async_notifier
+ * @fwnode: fwnode handle of the sub-device to be matched
+ * @asd_struct_size: size of the driver's async sub-device struct, including
+ *		     sizeof(struct v4l2_async_subdev). The &struct
+ *		     v4l2_async_subdev shall be the first member of
+ *		     the driver's async sub-device struct, i.e. both
+ *		     begin at the same memory address.
+ *
+ * This can be used before registering a notifier to add a
+ * fwnode-matched asd to the notifiers master asd_list. If the caller
+ * uses this method to compose an asd list, it must never allocate
+ * or place asd's in the @subdevs array.
+ */
+struct v4l2_async_subdev *
+v4l2_async_notifier_add_fwnode_subdev(struct v4l2_async_notifier *notifier,
+				      struct fwnode_handle *fwnode,
+				      unsigned int asd_struct_size);
+
+/**
+ * v4l2_async_notifier_add_i2c_subdev - Allocate and add an i2c async
+ *				subdev to the notifier's master asd_list.
+ *
+ * @notifier: pointer to &struct v4l2_async_notifier
+ * @adapter_id: I2C adapter ID to be matched
+ * @address: I2C address of sub-device to be matched
+ * @asd_struct_size: size of the driver's async sub-device struct, including
+ *		     sizeof(struct v4l2_async_subdev). The &struct
+ *		     v4l2_async_subdev shall be the first member of
+ *		     the driver's async sub-device struct, i.e. both
+ *		     begin at the same memory address.
+ *
+ * Same as above but for I2C matched sub-devices.
+ */
+struct v4l2_async_subdev *
+v4l2_async_notifier_add_i2c_subdev(struct v4l2_async_notifier *notifier,
+				   int adapter_id, unsigned short address,
+				   unsigned int asd_struct_size);
+
+/**
+ * v4l2_async_notifier_add_devname_subdev - Allocate and add a device-name
+ *				async subdev to the notifier's master asd_list.
+ *
+ * @notifier: pointer to &struct v4l2_async_notifier
+ * @device_name: device name string to be matched
+ * @asd_struct_size: size of the driver's async sub-device struct, including
+ *		     sizeof(struct v4l2_async_subdev). The &struct
+ *		     v4l2_async_subdev shall be the first member of
+ *		     the driver's async sub-device struct, i.e. both
+ *		     begin at the same memory address.
+ *
+ * Same as above but for device-name matched sub-devices.
+ */
+struct v4l2_async_subdev *
+v4l2_async_notifier_add_devname_subdev(struct v4l2_async_notifier *notifier,
+				       const char *device_name,
+				       unsigned int asd_struct_size);
+
+
+/**
  * v4l2_async_notifier_register - registers a subdevice asynchronous notifier
  *
  * @v4l2_dev: pointer to &struct v4l2_device
-- 
2.7.4

