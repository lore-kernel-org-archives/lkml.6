Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60555C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D082086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKegb+Z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D082086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933423AbeGIWo3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:44:29 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40313 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933270AbeGIWji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:39:38 -0400
Received: by mail-pl0-f67.google.com with SMTP id t6-v6so6674737plo.7;
        Mon, 09 Jul 2018 15:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hfl4kU1fMrkJwSKFcy1f+MqO30dlU+OQn06QCU2KPbg=;
        b=oKegb+Z1q3vxv4h4DsEiy1PgDRB08xpmEH2npnmuGfb8NR2fnEKhdG7elm6pqaxVY2
         iYgMgKFnb5xn7Qtfdttm0/GSESyWsEwTeLxdtSfG7TbKvKRmGHBOhwQA61PpLE786w+9
         ELMKKxJ7K9Q2WNT0pScoUhg8QRB+QkaeDhs1hHPL3aXMueh4KRgJF5mtB3OW6u8VR4dI
         781MlGsK78QYZ00OJwD+uBf2wvcZDbKpDyyvdNp/7BirXh0IuUOFHyYwBLTSicfK6Rg9
         yC+LK2elBVpE7QMqtemDDLZdaZIp2OWmyt06aSzfEgja4cOinVHfoDFr1/rWGjve4kzy
         hAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hfl4kU1fMrkJwSKFcy1f+MqO30dlU+OQn06QCU2KPbg=;
        b=jUDJ8Yvc+AA+3UMlAwsqWGoQWvNXQik+l34edNkqofJjqiCXegp7LpC5zu/aKo7q/l
         3tY17GDliUZzyhWIAv7xvg37OF0XFBZnX4di2ukjwHdS5IhOJjEsJGw+lvUYZoWEyEY3
         0VVwQdSOAiYR6iVZptBFm/x7HOkPve9pVYJthZArxMmfh0QeJkeDYwi8eBXlezO+7rTA
         w+b+6m1HlNNSCSm3lxM0UcBdgE0t5d0XgKe3vjzc8xHjdAEDV9cZmkrVcp5T5y0hZc6q
         7p2738Rm5Jfm+Ctj3nVC54bQDxJNDda8DakWR4rxtHBBQesarRnYxkJr+AGnrvRj4oR2
         kX+Q==
X-Gm-Message-State: APt69E2YFFbyUlP5N9KFOkiQNgPOnGZNRxr0WfJgiEYJJ/IpAWnQYsqa
        rSdya9nf5GkUu5JYU/Xc13Hg+g==
X-Google-Smtp-Source: AAOMgpfeKz7cUR9ekcTlHKuh8Cy7EGvHi+ez0R5dhyRBBkCal1MILQV3MRufoZMjZsuM1iZIhJn2hw==
X-Received: by 2002:a17:902:6e09:: with SMTP id u9-v6mr21700581plk.13.1531175977881;
        Mon, 09 Jul 2018 15:39:37 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm30143804pfe.173.2018.07.09.15.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 15:39:37 -0700 (PDT)
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
Subject: [PATCH v6 03/17] media: v4l2: async: Add v4l2_async_notifier_add_subdev
Date:   Mon,  9 Jul 2018 15:39:03 -0700
Message-Id: <1531175957-1973-4-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
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

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
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
 drivers/media/v4l2-core/v4l2-async.c | 189 +++++++++++++++++++++++++++--------
 include/media/v4l2-async.h           |  34 ++++++-
 2 files changed, 180 insertions(+), 43 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 0e7e529..8e52df2 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -363,16 +363,26 @@ static bool v4l2_async_notifier_has_async_subdev(
 	struct v4l2_async_notifier *notifier, struct v4l2_async_subdev *asd,
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
@@ -383,10 +393,46 @@ static bool v4l2_async_notifier_has_async_subdev(
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
+							 this_index))
+			return -EEXIST;
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
@@ -399,29 +445,25 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
 
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
-			if (v4l2_async_notifier_has_async_subdev(
-				    notifier, asd, i)) {
-				dev_err(dev,
-					"asd has already been registered or in notifier's subdev list\n");
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
@@ -511,36 +553,99 @@ void v4l2_async_notifier_unregister(struct v4l2_async_notifier *notifier)
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
@@ -614,7 +719,7 @@ void v4l2_async_unregister_subdev(struct v4l2_subdev *sd)
 	mutex_lock(&list_lock);
 
 	__v4l2_async_notifier_unregister(sd->subdev_notifier);
-	v4l2_async_notifier_cleanup(sd->subdev_notifier);
+	__v4l2_async_notifier_cleanup(sd->subdev_notifier);
 	kfree(sd->subdev_notifier);
 	sd->subdev_notifier = NULL;
 
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 1592d32..ab4d7ac 100644
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
@@ -139,12 +143,38 @@ struct v4l2_async_notifier {
 	struct v4l2_device *v4l2_dev;
 	struct v4l2_subdev *sd;
 	struct v4l2_async_notifier *parent;
+	struct list_head asd_list;
 	struct list_head waiting;
 	struct list_head done;
 	struct list_head list;
 };
 
 /**
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
+/**
  * v4l2_async_notifier_register - registers a subdevice asynchronous notifier
  *
  * @v4l2_dev: pointer to &struct v4l2_device
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
2.7.4

