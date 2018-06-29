Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4D0C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DBF217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rq3ChGc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DBF217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936867AbeF2SyP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:54:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40671 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966334AbeF2Sx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:53:28 -0400
Received: by mail-pg0-f65.google.com with SMTP id w8-v6so4366437pgp.7;
        Fri, 29 Jun 2018 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m6j4dWVn7iSZkINpDghSbQLTxMVD12qpeNhXHVRmr0s=;
        b=rq3ChGc3EiBxFQdB7vJwGgvO/YmQwVqQNmwWEVOkJ5hE4j9f+9uibTR2nC4kXEAss0
         b/MGzpm7YP5n1sdhrxNbgYosb93On6fQEwAy7N36ZklcDihmK0sU7Jw1svG402Z8WuAd
         GALUhODUiN1InFLCnqIYOa7NMNyoAqbWkifuBwBHZ1FeFXoWeXVLz7wYBKpBEevvkrCP
         DXteXinkwIIaT6NqzUhrWpPLP3d8DCghp1Pa4ux5UUQbLyHXa+fBP3K9hcJZoE4Zoxqn
         Pz7oO5KnymdF4vWAVKXQavOZcVSf3N3M8swXy5bhRN+Rvh1KJ+CkjXK3GraBj1ugN4P+
         Np/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m6j4dWVn7iSZkINpDghSbQLTxMVD12qpeNhXHVRmr0s=;
        b=tIWmEd5c6ti0OvED7U6dXfu739bWcEQPwvmsogjLrYe/wXmwI6i7yMG6AnSrhm5qhd
         wvGGEfELKyxeSO5ym68mjPGbzViwqRw4SA1zl1QS4NrakqDvQ9XAyuldonpx7Epci2yQ
         j/SRVo5xX5wEO5hFwx5poaNYwSAAs88kc0HPYbaVI8SvEB2s6/HkubeSc0MNEqchl7h1
         y9a4mo1KcvcYUXP1ICJB36Lo+t5fjvWDM92wmvyZOH/3Jb8mUqgeGQgyvHre9nL/fPwS
         jRefuVbn1OLK8X0PsL9Pa/afiBrIlrftVaXWmba+l+cXFq2i8HXHWNBGttReoxomD+35
         TTRg==
X-Gm-Message-State: APt69E3XuyFt6ZUCvgL73qCDFJgFoSdW0H7wedjrs65V1Tidop/Y8gyo
        +UN0hDqE8NPFlQ033PwHq0yMCQ==
X-Google-Smtp-Source: AAOMgpfRG2VNu+UXZYWNDo9H/pUGppzpG/gVDuHxykikOCON1QBnjVRCRagUnCX6jMB1UEJvdu55Dw==
X-Received: by 2002:a62:7d5:: with SMTP id 82-v6mr1926198pfh.95.1530298407722;
        Fri, 29 Jun 2018 11:53:27 -0700 (PDT)
Received: from mappy.world.mentorg.com ([2602:306:cc3b:f020:7cd8:9ad7:a375:e853])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm27672308pfg.130.2018.06.29.11.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 11:53:26 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/17] media: v4l2: async: Remove notifier subdevs array
Date:   Fri, 29 Jun 2018 11:50:00 -0700
Message-Id: <1530298220-5097-17-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
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

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/media/v4l2-core/v4l2-async.c | 93 +++++++-----------------------------
 include/media/v4l2-async.h           | 18 +++----
 include/media/v4l2-fwnode.h          | 18 ++++---
 3 files changed, 32 insertions(+), 97 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index d99ffafb..5c5890e 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -369,20 +369,12 @@ static bool v4l2_async_notifier_has_async_subdev(
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
+	j = 0;
+	list_for_each_entry(asd_y, &notifier->asd_list, asd_list) {
+		if (j++ >= this_index)
+			break;
+		if (asd_equal(asd, asd_y))
+			return true;
 	}
 
 	/* Check that an asd does not exist in other notifiers. */
@@ -435,7 +427,6 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
 {
 	struct v4l2_async_subdev *asd;
 	int ret;
-	int i;
 
 	if (notifier->num_subdevs > V4L2_MAX_SUBDEVS)
 		return -EINVAL;
@@ -446,17 +437,8 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
 		__v4l2_async_notifier_init(notifier);
 
 	if (!list_empty(&notifier->asd_list)) {
-		/*
-		 * Caller must have either used v4l2_async_notifier_add_subdev
-		 * to add asd's to notifier->asd_list, or provided the
-		 * notifier->subdevs array, but not both.
-		 */
-		if (WARN_ON(notifier->subdevs)) {
-			ret = -EINVAL;
-			goto err_unlock;
-		}
+		unsigned int i = 0;
 
-		i = 0;
 		list_for_each_entry(asd, &notifier->asd_list, asd_list) {
 			ret = v4l2_async_notifier_asd_valid(notifier, asd, i++);
 			if (ret)
@@ -464,16 +446,6 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
 
 			list_add_tail(&asd->list, &notifier->waiting);
 		}
-	} else if (notifier->subdevs) {
-		for (i = 0; i < notifier->num_subdevs; i++) {
-			asd = notifier->subdevs[i];
-
-			ret = v4l2_async_notifier_asd_valid(notifier, asd, i);
-			if (ret)
-				goto err_unlock;
-
-			list_add_tail(&asd->list, &notifier->waiting);
-		}
 	}
 
 	ret = v4l2_async_notifier_try_all_subdevs(notifier);
@@ -566,42 +538,22 @@ EXPORT_SYMBOL(v4l2_async_notifier_unregister);
 static void __v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
 {
 	struct v4l2_async_subdev *asd, *tmp;
-	unsigned int i;
 
-	if (!notifier)
+	if (!notifier || !notifier->lists_initialized)
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
+	list_for_each_entry_safe(asd, tmp,
+				 &notifier->asd_list, asd_list) {
+		switch (asd->match_type) {
+		case V4L2_ASYNC_MATCH_FWNODE:
+			fwnode_handle_put(asd->match.fwnode);
+			break;
+		default:
+			break;
 		}
 
-		kvfree(notifier->subdevs);
-		notifier->subdevs = NULL;
-	} else if (notifier->lists_initialized) {
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
 
 	notifier->num_subdevs = 0;
@@ -629,15 +581,6 @@ int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
 		goto unlock;
 	}
 
-	/*
-	 * If caller uses this function, it cannot also allocate and
-	 * place asd's in the notifier->subdevs array.
-	 */
-	if (WARN_ON(notifier->subdevs)) {
-		ret = -EINVAL;
-		goto unlock;
-	}
-
 	if (!notifier->lists_initialized)
 		__v4l2_async_notifier_init(notifier);
 
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 549b1de..1c00497 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -124,12 +124,11 @@ struct v4l2_async_notifier_operations {
  * struct v4l2_async_notifier - v4l2_device notifier data
  *
  * @ops:	notifier operations
- * @num_subdevs: number of subdevices used in the subdevs array
- * @subdevs:	array of pointers to subdevice descriptors
+ * @num_subdevs: number of subdevices in the @asd_list
  * @v4l2_dev:	v4l2_device of the root notifier, NULL otherwise
  * @sd:		sub-device that registered the notifier, NULL otherwise
  * @parent:	parent notifier
- * @asd_list:	master list of struct v4l2_async_subdev, replaces @subdevs
+ * @asd_list:	master list of struct v4l2_async_subdev
  * @waiting:	list of struct v4l2_async_subdev, waiting for their drivers
  * @done:	list of struct v4l2_subdev, already probed
  * @list:	member in a global list of notifiers
@@ -138,7 +137,6 @@ struct v4l2_async_notifier_operations {
 struct v4l2_async_notifier {
 	const struct v4l2_async_notifier_operations *ops;
 	unsigned int num_subdevs;
-	struct v4l2_async_subdev **subdevs;
 	struct v4l2_device *v4l2_dev;
 	struct v4l2_subdev *sd;
 	struct v4l2_async_notifier *parent;
@@ -156,10 +154,8 @@ struct v4l2_async_notifier {
  * @notifier: pointer to &struct v4l2_async_notifier
  * @asd: pointer to &struct v4l2_async_subdev
  *
- * This can be used before registering a notifier to add an
- * asd to the notifiers master asd_list. If the caller uses
- * this method to compose an asd list, it must never allocate
- * or place asd's in the @subdevs array.
+ * Call this function before registering a notifier to link the
+ * provided asd to the notifiers master asd_list.
  */
 int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
 				   struct v4l2_async_subdev *asd);
@@ -176,10 +172,8 @@ int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
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
index 031ebb0..76ae106 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -259,11 +259,10 @@ typedef int (*parse_endpoint_func)(struct device *dev,
  * This function may not be called on a registered notifier and may be called on
  * a notifier only once.
  *
- * Do not allocate the notifier's subdevs array, or change the notifier's
- * num_subdevs field. This is because this function uses
- * @v4l2_async_notifier_add_subdev to populate the notifier's asd_list,
- * which is in-place-of the subdevs array which must remain unallocated
- * and unused.
+ * Do not change the notifier's num_subdevs field. This is because this
+ * function uses @v4l2_async_notifier_add_subdev to populate the notifier's
+ * asd_list, which increments num_subdevs field to enforce an upper limit on
+ * the number of asd's that can be added to a notifier.
  *
  * The &struct v4l2_fwnode_endpoint passed to the callback function
  * @parse_endpoint is released once the function is finished. If there is a need
@@ -316,11 +315,10 @@ int v4l2_async_notifier_parse_fwnode_endpoints(
  * This function may not be called on a registered notifier and may be called on
  * a notifier only once per port.
  *
- * Do not allocate the notifier's subdevs array, or change the notifier's
- * num_subdevs field. This is because this function uses
- * @v4l2_async_notifier_add_subdev to populate the notifier's asd_list,
- * which is in-place-of the subdevs array which must remain unallocated
- * and unused.
+ * Do not change the notifier's num_subdevs field. This is because this
+ * function uses @v4l2_async_notifier_add_subdev to populate the notifier's
+ * asd_list, which increments num_subdevs field to enforce an upper limit on
+ * the number of asd's that can be added to a notifier.
  *
  * The &struct v4l2_fwnode_endpoint passed to the callback function
  * @parse_endpoint is released once the function is finished. If there is a need
-- 
2.7.4

