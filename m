Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4ADC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BA12086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzDo26rV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BA12086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933359AbeGIWjo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:39:44 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43691 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932798AbeGIWjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:39:41 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so6676457plj.10;
        Mon, 09 Jul 2018 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w0bcY2PyJkSTb9lDqIgTQ12xU/cABmv33pZVXJ39g4A=;
        b=MzDo26rVkParcgS7BVEKmz2fXXnMijcqEVr9YHyPBOVgcR8qOVqXkNqq7g7p27cdJ0
         im5v6B1rJQtr1NTo85PnwHQBFzSvNW9rx46/FrQD2LquDr4lXhuLdvxPtLSDlhQnuLn9
         tFn6TLeL+xUZD2qRXh+7ambxRyjgsrbflQtZ3cAZJSh+5DsapIqmGMksdPAdTucJdUju
         5BXx7ou1TjDLwrNonoIEZuJSAvamWs6JicaFvevKi5RCbWVEaHT93l3SFqSyjoNXspDY
         mWaqMGRabqZrrXRWhci0Rfy1G2zmasugudGWp2vlqceSMaHG7HXEkRp2eTXKZPVJqvvH
         JR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w0bcY2PyJkSTb9lDqIgTQ12xU/cABmv33pZVXJ39g4A=;
        b=RjkpET+fhInFBMVPSn4XDZN3hQ/NkcB1PPQBcxC2TXR3gZysIkJl0hGH/76xWTBRf/
         uppsKH+x5uEwhFWi50g21As/le808Y8WyvMLSAmB8U3GXOqmB373ostI7AJ5gkopAr1Q
         maAroP+yUvmXl0/G0NO0Pt8m5oNoz14v+POE9GF0euWzxJjYFMMfcaUIld7Es+e6qJuk
         JGx6CsCl49pXFntQSj1sm6K6tsmm+ERwjzVwvO54C2HxBPc3l9sycPa0ZaW2YaORaPJ9
         99SErXPfPIqJQG12xBo/qsb7G0LnIgm7O4ygPC8YL08QM/ikDD7c35XBAms9HaUOq1DM
         twCw==
X-Gm-Message-State: APt69E31Em1dk4Gn8LceIZmhq4yNYxkR4RStr7XL4/SIu5263B4rxbwQ
        dSxOOYDhN3OPDQ0GygDUeS1YLA==
X-Google-Smtp-Source: AAOMgpe7QA4ESFb5hPoopwprK4D7ZzVlu2UbAeTFuRhJF+2AkDUIyn3aGGTE+58rpf60c5afihyEDA==
X-Received: by 2002:a17:902:b589:: with SMTP id a9-v6mr22369869pls.140.1531175980669;
        Mon, 09 Jul 2018 15:39:40 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm30143804pfe.173.2018.07.09.15.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 15:39:39 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 04/17] media: v4l2: async: Add convenience functions to allocate and add asd's
Date:   Mon,  9 Jul 2018 15:39:04 -0700
Message-Id: <1531175957-1973-5-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
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
index 8e52df2..e60a82a 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -646,6 +646,82 @@ int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
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
index ab4d7ac..3489e4c 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -175,6 +175,68 @@ int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
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

