Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C57C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470F02064D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKbvE6lD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470F02064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeI3CZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:25:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37298 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbeI3CZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:25:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id x26-v6so6506791pfn.4;
        Sat, 29 Sep 2018 12:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dmeXAmBelOCFqsPh6iQ/YyaEDwO5fwP3SZ8G2dj0zVA=;
        b=cKbvE6lD1zw01qyOUuRDgyPAfQjrc+FosTKVZETpKfwLwCKuTvGr2FsBgQU0Tv3Vzz
         slBXoLjsm9WafmYPypvXAY8UI+BEOtoE3BMgi8wNQIhafivcMacXvtwYGD5ql9poiMAz
         vRIbCmlTeKxUUxoNBpTtBJ/1M/FHFsO/iPFeiDcTrM7PU9EOOco6+0z8T9ynSNUQIYtD
         +FhiMjBfuJist0odP3dPbRtG4Oa/tVPKqK7Dj/rBJW4pEyO/pDacJpISJe3LhInVmeT0
         R+Gpix10mL7G3dzfralFd8FuvDeITWoLL4uAqzi0klB7xN87ZdhUSQFN33hqIgjxbmEU
         M79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dmeXAmBelOCFqsPh6iQ/YyaEDwO5fwP3SZ8G2dj0zVA=;
        b=RIau3g37EQ6spukO/0wXI30tftMCM5o5mCD0KY1HW7GCnRwkrn6QAzvwsiN67LMSj/
         9vYu24S5jVa2v5/qq2LkybzpzMQNz5qvm+AqE5KACqQyxmW6Vv/tQMfEC65P2NzZWWD3
         Tgp7m0KPx+pxlUw1ibuiXBjlb26sU13mIuZgv43B0eHMy7PlJyIBRyxT4oSGW159cJJe
         Uch4MDqeE7OshZXNI4poNZ98NDVWix5Y1eJCqCbQpRTfnEe7DRXEGfp41+oMhm8/BkoU
         GDlmirjRXNNLswGP7T2YqDrlAUMlDkQwlA6KK0mQI4iRP38e+l3x3GrRg2A0ysWuVGPU
         ULeg==
X-Gm-Message-State: ABuFfogKaCynBCYjvouBPsSjBCqXZD3wPo0H/HMQV5eVmC2e5pCyqNCE
        s8cSjS7sc3uqzqke+6U7AOqfjwTs
X-Google-Smtp-Source: ACcGV60tQaQD5uodx2+Xmu+YkHc4rSXKvkSRfWRAjm7pHu1O1mRkkKsukWg4MNIMNqePgvqxu0DPvQ==
X-Received: by 2002:a17:902:bc4a:: with SMTP id t10-v6mr4508382plz.66.1538250916809;
        Sat, 29 Sep 2018 12:55:16 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id b126-v6sm18371946pga.49.2018.09.29.12.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:55:15 -0700 (PDT)
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
Subject: [RESEND PATCH v7 16/17] media: v4l2: async: Remove notifier subdevs array
Date:   Sat, 29 Sep 2018 12:54:19 -0700
Message-Id: <20180929195420.28579-17-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929195420.28579-1-slongerbeam@gmail.com>
References: <20180929195420.28579-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All platform drivers have been converted to use
v4l2_async_notifier_add_subdev(), in place of adding
asd's to the notifier subdevs array. So the subdevs
array can now be removed from struct v4l2_async_notifier,
and remove the backward compatibility support for that
array in v4l2-async.c.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes since v6:
- none
Changes since v5:
- also remove notifier num_subdevs and V4L2_MAX_SUBDEVS macro.
  Suggested by Sakari Ailus.
---
 drivers/media/v4l2-core/v4l2-async.c | 114 ++++++---------------------
 include/media/v4l2-async.h           |  21 ++---
 include/media/v4l2-fwnode.h          |  12 ---
 3 files changed, 30 insertions(+), 117 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index b0eb31efcbfe..70adbd9a01a2 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -359,32 +359,24 @@ __v4l2_async_notifier_has_async_subdev(struct v4l2_async_notifier *notifier,
 /*
  * Find out whether an async sub-device was set up already or
  * whether it exists in a given notifier before @this_index.
+ * If @this_index < 0, search the notifier's entire @asd_list.
  */
 static bool
 v4l2_async_notifier_has_async_subdev(struct v4l2_async_notifier *notifier,
 				     struct v4l2_async_subdev *asd,
-				     unsigned int this_index)
+				     int this_index)
 {
 	struct v4l2_async_subdev *asd_y;
-	unsigned int j;
+	int j = 0;
 
 	lockdep_assert_held(&list_lock);
 
 	/* Check that an asd is not being added more than once. */
-	if (notifier->subdevs) {
-		for (j = 0; j < this_index; j++) {
-			asd_y = notifier->subdevs[j];
-			if (asd_equal(asd, asd_y))
-				return true;
-		}
-	} else {
-		j = 0;
-		list_for_each_entry(asd_y, &notifier->asd_list, asd_list) {
-			if (j++ >= this_index)
-				break;
-			if (asd_equal(asd, asd_y))
-				return true;
-		}
+	list_for_each_entry(asd_y, &notifier->asd_list, asd_list) {
+		if (this_index >= 0 && j++ >= this_index)
+			break;
+		if (asd_equal(asd, asd_y))
+			return true;
 	}
 
 	/* Check that an asd does not exist in other notifiers. */
@@ -397,7 +389,7 @@ v4l2_async_notifier_has_async_subdev(struct v4l2_async_notifier *notifier,
 
 static int v4l2_async_notifier_asd_valid(struct v4l2_async_notifier *notifier,
 					 struct v4l2_async_subdev *asd,
-					 unsigned int this_index)
+					 int this_index)
 {
 	struct device *dev =
 		notifier->v4l2_dev ? notifier->v4l2_dev->dev : NULL;
@@ -438,36 +430,19 @@ EXPORT_SYMBOL(v4l2_async_notifier_init);
 static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
 {
 	struct v4l2_async_subdev *asd;
-	int ret;
-	int i;
-
-	if (notifier->num_subdevs > V4L2_MAX_SUBDEVS)
-		return -EINVAL;
+	int ret, i = 0;
 
 	INIT_LIST_HEAD(&notifier->waiting);
 	INIT_LIST_HEAD(&notifier->done);
 
 	mutex_lock(&list_lock);
 
-	if (notifier->subdevs) {
-		for (i = 0; i < notifier->num_subdevs; i++) {
-			asd = notifier->subdevs[i];
-
-			ret = v4l2_async_notifier_asd_valid(notifier, asd, i);
-			if (ret)
-				goto err_unlock;
+	list_for_each_entry(asd, &notifier->asd_list, asd_list) {
+		ret = v4l2_async_notifier_asd_valid(notifier, asd, i++);
+		if (ret)
+			goto err_unlock;
 
-			list_add_tail(&asd->list, &notifier->waiting);
-		}
-	} else {
-		i = 0;
-		list_for_each_entry(asd, &notifier->asd_list, asd_list) {
-			ret = v4l2_async_notifier_asd_valid(notifier, asd, i++);
-			if (ret)
-				goto err_unlock;
-
-			list_add_tail(&asd->list, &notifier->waiting);
-		}
+		list_add_tail(&asd->list, &notifier->waiting);
 	}
 
 	ret = v4l2_async_notifier_try_all_subdevs(notifier);
@@ -560,45 +535,22 @@ EXPORT_SYMBOL(v4l2_async_notifier_unregister);
 static void __v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
 {
 	struct v4l2_async_subdev *asd, *tmp;
-	unsigned int i;
 
 	if (!notifier)
 		return;
 
-	if (notifier->subdevs) {
-		for (i = 0; i < notifier->num_subdevs; i++) {
-			asd = notifier->subdevs[i];
-
-			switch (asd->match_type) {
-			case V4L2_ASYNC_MATCH_FWNODE:
-				fwnode_handle_put(asd->match.fwnode);
-				break;
-			default:
-				break;
-			}
-
-			kfree(asd);
+	list_for_each_entry_safe(asd, tmp, &notifier->asd_list, asd_list) {
+		switch (asd->match_type) {
+		case V4L2_ASYNC_MATCH_FWNODE:
+			fwnode_handle_put(asd->match.fwnode);
+			break;
+		default:
+			break;
 		}
 
-		kvfree(notifier->subdevs);
-		notifier->subdevs = NULL;
-	} else {
-		list_for_each_entry_safe(asd, tmp,
-					 &notifier->asd_list, asd_list) {
-			switch (asd->match_type) {
-			case V4L2_ASYNC_MATCH_FWNODE:
-				fwnode_handle_put(asd->match.fwnode);
-				break;
-			default:
-				break;
-			}
-
-			list_del(&asd->asd_list);
-			kfree(asd);
-		}
+		list_del(&asd->asd_list);
+		kfree(asd);
 	}
-
-	notifier->num_subdevs = 0;
 }
 
 void v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
@@ -618,27 +570,11 @@ int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
 
 	mutex_lock(&list_lock);
 
-	if (notifier->num_subdevs >= V4L2_MAX_SUBDEVS) {
-		ret = -EINVAL;
-		goto unlock;
-	}
-
-	/*
-	 * If caller uses this function, it cannot also allocate and
-	 * place asd's in the notifier->subdevs array.
-	 */
-	if (WARN_ON(notifier->subdevs)) {
-		ret = -EINVAL;
-		goto unlock;
-	}
-
-	ret = v4l2_async_notifier_asd_valid(notifier, asd,
-					    notifier->num_subdevs);
+	ret = v4l2_async_notifier_asd_valid(notifier, asd, -1);
 	if (ret)
 		goto unlock;
 
 	list_add_tail(&asd->asd_list, &notifier->asd_list);
-	notifier->num_subdevs++;
 
 unlock:
 	mutex_unlock(&list_lock);
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 16b1e2b097c1..89b152f52ef9 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -20,9 +20,6 @@ struct v4l2_device;
 struct v4l2_subdev;
 struct v4l2_async_notifier;
 
-/* A random max subdevice number, used to allocate an array on stack */
-#define V4L2_MAX_SUBDEVS 128U
-
 /**
  * enum v4l2_async_match_type - type of asynchronous subdevice logic to be used
  *	in order to identify a match
@@ -124,20 +121,16 @@ struct v4l2_async_notifier_operations {
  * struct v4l2_async_notifier - v4l2_device notifier data
  *
  * @ops:	notifier operations
- * @num_subdevs: number of subdevices used in the subdevs array
- * @subdevs:	array of pointers to subdevice descriptors
  * @v4l2_dev:	v4l2_device of the root notifier, NULL otherwise
  * @sd:		sub-device that registered the notifier, NULL otherwise
  * @parent:	parent notifier
- * @asd_list:	master list of struct v4l2_async_subdev, replaces @subdevs
+ * @asd_list:	master list of struct v4l2_async_subdev
  * @waiting:	list of struct v4l2_async_subdev, waiting for their drivers
  * @done:	list of struct v4l2_subdev, already probed
  * @list:	member in a global list of notifiers
  */
 struct v4l2_async_notifier {
 	const struct v4l2_async_notifier_operations *ops;
-	unsigned int num_subdevs;
-	struct v4l2_async_subdev **subdevs;
 	struct v4l2_device *v4l2_dev;
 	struct v4l2_subdev *sd;
 	struct v4l2_async_notifier *parent;
@@ -164,10 +157,8 @@ void v4l2_async_notifier_init(struct v4l2_async_notifier *notifier);
  * @notifier: pointer to &struct v4l2_async_notifier
  * @asd: pointer to &struct v4l2_async_subdev
  *
- * This can be used before registering a notifier to add an
- * asd to the notifiers @asd_list. If the caller uses this
- * method to compose an asd list, it must never allocate
- * or place asd's in the @subdevs array.
+ * Call this function before registering a notifier to link the
+ * provided asd to the notifiers master @asd_list.
  */
 int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
 				   struct v4l2_async_subdev *asd);
@@ -184,10 +175,8 @@ int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
  *		     the driver's async sub-device struct, i.e. both
  *		     begin at the same memory address.
  *
- * This can be used before registering a notifier to add a
- * fwnode-matched asd to the notifiers master asd_list. If the caller
- * uses this method to compose an asd list, it must never allocate
- * or place asd's in the @subdevs array.
+ * Allocate a fwnode-matched asd of size asd_struct_size, and add it
+ * to the notifiers @asd_list.
  */
 struct v4l2_async_subdev *
 v4l2_async_notifier_add_fwnode_subdev(struct v4l2_async_notifier *notifier,
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index 031ebb069dcb..8b4873c37098 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -259,12 +259,6 @@ typedef int (*parse_endpoint_func)(struct device *dev,
  * This function may not be called on a registered notifier and may be called on
  * a notifier only once.
  *
- * Do not allocate the notifier's subdevs array, or change the notifier's
- * num_subdevs field. This is because this function uses
- * @v4l2_async_notifier_add_subdev to populate the notifier's asd_list,
- * which is in-place-of the subdevs array which must remain unallocated
- * and unused.
- *
  * The &struct v4l2_fwnode_endpoint passed to the callback function
  * @parse_endpoint is released once the function is finished. If there is a need
  * to retain that configuration, the user needs to allocate memory for it.
@@ -316,12 +310,6 @@ int v4l2_async_notifier_parse_fwnode_endpoints(
  * This function may not be called on a registered notifier and may be called on
  * a notifier only once per port.
  *
- * Do not allocate the notifier's subdevs array, or change the notifier's
- * num_subdevs field. This is because this function uses
- * @v4l2_async_notifier_add_subdev to populate the notifier's asd_list,
- * which is in-place-of the subdevs array which must remain unallocated
- * and unused.
- *
  * The &struct v4l2_fwnode_endpoint passed to the callback function
  * @parse_endpoint is released once the function is finished. If there is a need
  * to retain that configuration, the user needs to allocate memory for it.
-- 
2.17.1

