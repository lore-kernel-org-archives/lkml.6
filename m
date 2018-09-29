Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE025C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820C320880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtZTLKz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820C320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeI3CYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:24:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38056 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeI3CYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:24:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id r77-v6so6772461pgr.5;
        Sat, 29 Sep 2018 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SdColWhuoxh5iOQR8lDZAZXzz1nID/+dREPu5z8xj0s=;
        b=NtZTLKz6cnSXC9xoISjpe/sOuiZTEgs63IB78hP+Ih1zETBGHqmYgYW7vyHr3/yquT
         w/xD+Uvtv7A9XatS0+bi3CZJ8pZtTZ8ATir2AMUXH54tUSg4LkjmQXf+WeC8I84WrmtN
         VCzHITX6Enm0oNmQihrHIZ65GbZy9F47me3mY+RAmF0ophrLk/Ppz6rqaQPTz41nJl7c
         XRF4r8cPnVRl9oP1gDxfb+gYnojJp065eeF5G5N1CiIzFDKW/DA7I9PIGLfXHNYOSimb
         dvDiEgpBlZDovpBd+Nny25WBjAlLgazuWiow9T/fi4msVsALpr63WxJuuHCfA5B5XS6h
         4Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SdColWhuoxh5iOQR8lDZAZXzz1nID/+dREPu5z8xj0s=;
        b=a6kxUpiy4IMUogF/34jEBGpxYrJkHYwACtiyPyCPgElUcWG0XtMPgL2oW/OrhXqujJ
         DPDFVXY1o6PetJJwgJWhhRgJIjiqIpqrSr0RorA7bHMQcA+Q/DXPj3f5fxYfuDb44T7V
         9T6Qt4PluvSv4xQ7LDfZGLzCKrq9ctBtY94IU6gVl5wRXPNvr+87gWwNvmzIxCBBTDTN
         BBR5beMdUVUnwUrvp8L+Td0vTb+D1Epx8ee7XkCjWOra8YNOn9CjWyPoUA0txbKf05hy
         0RneJZ02xn3a3VfOA2Ry8/Xg9pFvjaPW9IS+9yzXLElESWhwkQjDD+6tp3ubZzZ9sb2l
         B0Pw==
X-Gm-Message-State: ABuFfoh3ArevEIuJ6v5HUYLrteI69pN+IPh3O4ylOAO+igR7o8njR+Oc
        KMFhzdrldehiyf4Ks+N20VRrBbaB
X-Google-Smtp-Source: ACcGV63ERvXB41MM62Cb4UV6nj5gu4QaXipdiwm3e+9o+X45WqztHqh1kbwi/t1Tu88AMHkJNOoP+g==
X-Received: by 2002:a63:1624:: with SMTP id w36-v6mr4000697pgl.409.1538250879996;
        Sat, 29 Sep 2018 12:54:39 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id b126-v6sm18371946pga.49.2018.09.29.12.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:54:39 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v7 03/17] media: v4l2: async: Add v4l2_async_notifier_add_subdev
Date:   Sat, 29 Sep 2018 12:54:06 -0700
Message-Id: <20180929195420.28579-4-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929195420.28579-1-slongerbeam@gmail.com>
References: <20180929195420.28579-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4l2_async_notifier_add_subdev() adds an asd to the notifier. It checks
that no other equivalent asd's have already been added to this notifier's
asd list, or to other registered notifier's waiting or done lists, and
increments num_subdevs.

v4l2_async_notifier_add_subdev() does not make use of the notifier subdevs
array, otherwise it would have to re-allocate the array every time the
function was called. In place of the subdevs array, the function adds
the newly allocated asd to a new master asd_list. The function will
return error with a WARN() if it is ever called with the subdevs array
allocated.

Drivers are now required to call a v4l2_async_notifier_init(), before the
first call to v4l2_async_notifier_add_subdev(), in order to initialize
the asd_list.

In v4l2_async_notifier_has_async_subdev(), __v4l2_async_notifier_register(),
and v4l2_async_notifier_cleanup(), maintain backward compatibility with
the subdevs array, by alternatively operate on the subdevs array or a
non-empty notifier->asd_list.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes since v6:
- add "already listed asd" message from __v4l2_async_notifier_register()
  to v4l2_async_notifier_asd_valid() as a debug message.
Changes since v5:
- export v4l2_async_notifier_init() which must be called by drivers.
  Suggested by Sakari Ailus.
Changes since v4:
- none
Changes since v3:
- init notifier lists after the sanity checks.
Changes since v2:
- add a NULL asd pointer check to v4l2_async_notifier_asd_valid().
Changes since v1:
- none
---
 drivers/media/v4l2-core/v4l2-async.c | 191 +++++++++++++++++++++------
 include/media/v4l2-async.h           |  34 ++++-
 2 files changed, 182 insertions(+), 43 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index f09d354b96a0..7925875d09b7 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -365,16 +365,26 @@ v4l2_async_notifier_has_async_subdev(struct v4l2_async_notifier *notifier,
 				     struct v4l2_async_subdev *asd,
 				     unsigned int this_index)
 {
+	struct v4l2_async_subdev *asd_y;
 	unsigned int j;
 
 	lockdep_assert_held(&list_lock);
 
 	/* Check that an asd is not being added more than once. */
-	for (j = 0; j < this_index; j++) {
-		struct v4l2_async_subdev *asd_y = notifier->subdevs[j];
-
-		if (asd_equal(asd, asd_y))
-			return true;
+	if (notifier->subdevs) {
+		for (j = 0; j < this_index; j++) {
+			asd_y = notifier->subdevs[j];
+			if (asd_equal(asd, asd_y))
+				return true;
+		}
+	} else {
+		j = 0;
+		list_for_each_entry(asd_y, &notifier->asd_list, asd_list) {
+			if (j++ >= this_index)
+				break;
+			if (asd_equal(asd, asd_y))
+				return true;
+		}
 	}
 
 	/* Check that an asd does not exist in other notifiers. */
@@ -385,10 +395,48 @@ v4l2_async_notifier_has_async_subdev(struct v4l2_async_notifier *notifier,
 	return false;
 }
 
-static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
+static int v4l2_async_notifier_asd_valid(struct v4l2_async_notifier *notifier,
+					 struct v4l2_async_subdev *asd,
+					 unsigned int this_index)
 {
 	struct device *dev =
 		notifier->v4l2_dev ? notifier->v4l2_dev->dev : NULL;
+
+	if (!asd)
+		return -EINVAL;
+
+	switch (asd->match_type) {
+	case V4L2_ASYNC_MATCH_CUSTOM:
+	case V4L2_ASYNC_MATCH_DEVNAME:
+	case V4L2_ASYNC_MATCH_I2C:
+	case V4L2_ASYNC_MATCH_FWNODE:
+		if (v4l2_async_notifier_has_async_subdev(notifier, asd,
+							 this_index)) {
+			dev_dbg(dev, "subdev descriptor already listed in this or other notifiers\n");
+			return -EEXIST;
+		}
+		break;
+	default:
+		dev_err(dev, "Invalid match type %u on %p\n",
+			asd->match_type, asd);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void v4l2_async_notifier_init(struct v4l2_async_notifier *notifier)
+{
+	mutex_lock(&list_lock);
+
+	INIT_LIST_HEAD(&notifier->asd_list);
+
+	mutex_unlock(&list_lock);
+}
+EXPORT_SYMBOL(v4l2_async_notifier_init);
+
+static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
+{
 	struct v4l2_async_subdev *asd;
 	int ret;
 	int i;
@@ -401,29 +449,25 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
 
 	mutex_lock(&list_lock);
 
-	for (i = 0; i < notifier->num_subdevs; i++) {
-		asd = notifier->subdevs[i];
+	if (notifier->subdevs) {
+		for (i = 0; i < notifier->num_subdevs; i++) {
+			asd = notifier->subdevs[i];
 
-		switch (asd->match_type) {
-		case V4L2_ASYNC_MATCH_CUSTOM:
-		case V4L2_ASYNC_MATCH_DEVNAME:
-		case V4L2_ASYNC_MATCH_I2C:
-		case V4L2_ASYNC_MATCH_FWNODE:
-			if (v4l2_async_notifier_has_async_subdev(notifier,
-								 asd, i)) {
-				dev_err(dev,
-					"subdev descriptor already listed in this or other notifiers\n");
-				ret = -EEXIST;
+			ret = v4l2_async_notifier_asd_valid(notifier, asd, i);
+			if (ret)
 				goto err_unlock;
-			}
-			break;
-		default:
-			dev_err(dev, "Invalid match type %u on %p\n",
-				asd->match_type, asd);
-			ret = -EINVAL;
-			goto err_unlock;
+
+			list_add_tail(&asd->list, &notifier->waiting);
+		}
+	} else {
+		i = 0;
+		list_for_each_entry(asd, &notifier->asd_list, asd_list) {
+			ret = v4l2_async_notifier_asd_valid(notifier, asd, i++);
+			if (ret)
+				goto err_unlock;
+
+			list_add_tail(&asd->list, &notifier->waiting);
 		}
-		list_add_tail(&asd->list, &notifier->waiting);
 	}
 
 	ret = v4l2_async_notifier_try_all_subdevs(notifier);
@@ -513,36 +557,99 @@ void v4l2_async_notifier_unregister(struct v4l2_async_notifier *notifier)
 }
 EXPORT_SYMBOL(v4l2_async_notifier_unregister);
 
-void v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
+static void __v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
 {
+	struct v4l2_async_subdev *asd, *tmp;
 	unsigned int i;
 
-	if (!notifier || !notifier->max_subdevs)
+	if (!notifier)
 		return;
 
-	for (i = 0; i < notifier->num_subdevs; i++) {
-		struct v4l2_async_subdev *asd = notifier->subdevs[i];
+	if (notifier->subdevs) {
+		if (!notifier->max_subdevs)
+			return;
 
-		switch (asd->match_type) {
-		case V4L2_ASYNC_MATCH_FWNODE:
-			fwnode_handle_put(asd->match.fwnode);
-			break;
-		default:
-			WARN_ON_ONCE(true);
-			break;
+		for (i = 0; i < notifier->num_subdevs; i++) {
+			asd = notifier->subdevs[i];
+
+			switch (asd->match_type) {
+			case V4L2_ASYNC_MATCH_FWNODE:
+				fwnode_handle_put(asd->match.fwnode);
+				break;
+			default:
+				break;
+			}
+
+			kfree(asd);
 		}
 
-		kfree(asd);
+		notifier->max_subdevs = 0;
+		kvfree(notifier->subdevs);
+		notifier->subdevs = NULL;
+	} else {
+		list_for_each_entry_safe(asd, tmp,
+					 &notifier->asd_list, asd_list) {
+			switch (asd->match_type) {
+			case V4L2_ASYNC_MATCH_FWNODE:
+				fwnode_handle_put(asd->match.fwnode);
+				break;
+			default:
+				break;
+			}
+
+			list_del(&asd->asd_list);
+			kfree(asd);
+		}
 	}
 
-	notifier->max_subdevs = 0;
 	notifier->num_subdevs = 0;
+}
+
+void v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
+{
+	mutex_lock(&list_lock);
+
+	__v4l2_async_notifier_cleanup(notifier);
 
-	kvfree(notifier->subdevs);
-	notifier->subdevs = NULL;
+	mutex_unlock(&list_lock);
 }
 EXPORT_SYMBOL_GPL(v4l2_async_notifier_cleanup);
 
+int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
+				   struct v4l2_async_subdev *asd)
+{
+	int ret;
+
+	mutex_lock(&list_lock);
+
+	if (notifier->num_subdevs >= V4L2_MAX_SUBDEVS) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	/*
+	 * If caller uses this function, it cannot also allocate and
+	 * place asd's in the notifier->subdevs array.
+	 */
+	if (WARN_ON(notifier->subdevs)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = v4l2_async_notifier_asd_valid(notifier, asd,
+					    notifier->num_subdevs);
+	if (ret)
+		goto unlock;
+
+	list_add_tail(&asd->asd_list, &notifier->asd_list);
+	notifier->num_subdevs++;
+
+unlock:
+	mutex_unlock(&list_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(v4l2_async_notifier_add_subdev);
+
 int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 {
 	struct v4l2_async_notifier *subdev_notifier;
@@ -616,7 +723,7 @@ void v4l2_async_unregister_subdev(struct v4l2_subdev *sd)
 	mutex_lock(&list_lock);
 
 	__v4l2_async_notifier_unregister(sd->subdev_notifier);
-	v4l2_async_notifier_cleanup(sd->subdev_notifier);
+	__v4l2_async_notifier_cleanup(sd->subdev_notifier);
 	kfree(sd->subdev_notifier);
 	sd->subdev_notifier = NULL;
 
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 1592d323c577..ab4d7acb7960 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -73,6 +73,8 @@ enum v4l2_async_match_type {
  * @match.custom.priv:
  *		Driver-specific private struct with match parameters
  *		to be used if %V4L2_ASYNC_MATCH_CUSTOM.
+ * @asd_list:	used to add struct v4l2_async_subdev objects to the
+ *		master notifier @asd_list
  * @list:	used to link struct v4l2_async_subdev objects, waiting to be
  *		probed, to a notifier->waiting list
  *
@@ -98,6 +100,7 @@ struct v4l2_async_subdev {
 
 	/* v4l2-async core private: not to be used by drivers */
 	struct list_head list;
+	struct list_head asd_list;
 };
 
 /**
@@ -127,6 +130,7 @@ struct v4l2_async_notifier_operations {
  * @v4l2_dev:	v4l2_device of the root notifier, NULL otherwise
  * @sd:		sub-device that registered the notifier, NULL otherwise
  * @parent:	parent notifier
+ * @asd_list:	master list of struct v4l2_async_subdev, replaces @subdevs
  * @waiting:	list of struct v4l2_async_subdev, waiting for their drivers
  * @done:	list of struct v4l2_subdev, already probed
  * @list:	member in a global list of notifiers
@@ -139,11 +143,37 @@ struct v4l2_async_notifier {
 	struct v4l2_device *v4l2_dev;
 	struct v4l2_subdev *sd;
 	struct v4l2_async_notifier *parent;
+	struct list_head asd_list;
 	struct list_head waiting;
 	struct list_head done;
 	struct list_head list;
 };
 
+/**
+ * v4l2_async_notifier_init - Initialize a notifier.
+ *
+ * @notifier: pointer to &struct v4l2_async_notifier
+ *
+ * This function initializes the notifier @asd_list. It must be called
+ * before the first call to @v4l2_async_notifier_add_subdev.
+ */
+void v4l2_async_notifier_init(struct v4l2_async_notifier *notifier);
+
+/**
+ * v4l2_async_notifier_add_subdev - Add an async subdev to the
+ *				notifier's master asd list.
+ *
+ * @notifier: pointer to &struct v4l2_async_notifier
+ * @asd: pointer to &struct v4l2_async_subdev
+ *
+ * This can be used before registering a notifier to add an
+ * asd to the notifiers @asd_list. If the caller uses this
+ * method to compose an asd list, it must never allocate
+ * or place asd's in the @subdevs array.
+ */
+int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
+				   struct v4l2_async_subdev *asd);
+
 /**
  * v4l2_async_notifier_register - registers a subdevice asynchronous notifier
  *
@@ -177,7 +207,9 @@ void v4l2_async_notifier_unregister(struct v4l2_async_notifier *notifier);
  * Release memory resources related to a notifier, including the async
  * sub-devices allocated for the purposes of the notifier but not the notifier
  * itself. The user is responsible for calling this function to clean up the
- * notifier after calling @v4l2_async_notifier_parse_fwnode_endpoints or
+ * notifier after calling
+ * @v4l2_async_notifier_add_subdev,
+ * @v4l2_async_notifier_parse_fwnode_endpoints or
  * @v4l2_fwnode_reference_parse_sensor_common.
  *
  * There is no harm from calling v4l2_async_notifier_cleanup in other
-- 
2.17.1

