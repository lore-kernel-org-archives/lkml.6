Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C800C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D2C27906
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCD+YPGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D2C27906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936716AbeF2SvI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:51:08 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40822 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936675AbeF2SvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:51:03 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so4608865pfe.7;
        Fri, 29 Jun 2018 11:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hH/e+EZqEH22KoJF0d577Thw7rTNUnombGnEzEK4yNE=;
        b=uCD+YPGJKonDG323NweKZ6mwQG9rqX7l8uDXWTkVBS3BGA9W7yEsHXrmBVdScJyW9f
         YcTygU1rTfZJDHLyGpWTMCHkTzS4lPA2zpdHucG8EjAj7ABXu7AgBNFJHI7ZqvUQkRDq
         jhcCT+O5ROQ2JMibbDBtrKyTknKpOT27T6qzaZuVLSmKoTHMANgTbpBMEkbMCyOTJ+IG
         FIMX8TRugQUjKBvdfInh+/4YY2sT6lmD4arQMCzMLaYXjDtqWbuziKkbF0NYYWhpKu7W
         9cXePHodGavCYse5S6GcG9faIjNExTYMflhkaNSmkkCRgYv6pFpSr45k++OJY4XMMiKl
         yQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hH/e+EZqEH22KoJF0d577Thw7rTNUnombGnEzEK4yNE=;
        b=FVwswqs4aQZhC+y2PadRBuCQ5YY+Yi4q/L+0Rxkf7Splx9D5FPzxi5Z/WcR0sRV6yU
         k2hTTr73jrD7I3hTmkHUdErs4RS04GekcUmDKHzE7jUIlpCOBhqDlB3qQZ+o8BHgm5jn
         miXVxdW8xxWHczZyx8So3Zbk1UD13fAi63lZgNN5psNcPDkJV92joEr8gOsinbxLy7gI
         5upGLFBjSd4xgeUz1Y07xUXKBwFpbSpDa5Kq5YlRywN5FYiUEePdY8zRP5dGplIAw627
         rqOukcivOOWe4B0IX/ubn6PvzYWg8AZRXUOUg9EcxTvkY03jsfTst2utcFwupU9iou0l
         C/PA==
X-Gm-Message-State: APt69E2BhkZstTj7P0lI4R1sPxKsKmDZMg+vnCmtRCkL9Fu9oK0T8A0l
        bBTUkcWdu36MBmBGGyXXPmdz3g==
X-Google-Smtp-Source: ADUXVKLsz2XEoD+3MfgKMOfQaIv6ysjlOS3O4PDuXBbKtYeIlWxjn+2KJBIwzKwNZuqm0L8ZFyZ3FQ==
X-Received: by 2002:a65:6455:: with SMTP id s21-v6mr13187338pgv.394.1530298262364;
        Fri, 29 Jun 2018 11:51:02 -0700 (PDT)
Received: from mappy.world.mentorg.com ([2602:306:cc3b:f020:7cd8:9ad7:a375:e853])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm27672308pfg.130.2018.06.29.11.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 11:51:01 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/17] media: v4l2-fwnode: Switch to v4l2_async_notifier_add_subdev
Date:   Fri, 29 Jun 2018 11:49:49 -0700
Message-Id: <1530298220-5097-6-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fwnode endpoint and reference parsing functions in v4l2-fwnode.c
are modified to make use of v4l2_async_notifier_add_subdev().
As a result the notifier->subdevs array is no longer allocated or
re-allocated, and by extension the max_subdevs value is also no
longer needed.

Since the notifier->subdevs array is no longer allocated in the
fwnode endpoint and reference parsing functions, the callers of
those functions must never reference that array, since it is now
NULL. Of the drivers that make use of the fwnode/ref parsing,
only the intel-ipu3 driver references the ->subdevs[] array,
(in the notifier completion callback), so that driver has been
modified to iterate through the notifier->asd_list instead.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2.c |  10 +--
 drivers/media/v4l2-core/v4l2-async.c     |   4 -
 drivers/media/v4l2-core/v4l2-fwnode.c    | 130 +++++++------------------------
 include/media/v4l2-async.h               |   2 -
 include/media/v4l2-fwnode.h              |  22 +++---
 5 files changed, 43 insertions(+), 125 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 2902715..3c44f10 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1435,13 +1435,13 @@ static int cio2_notifier_complete(struct v4l2_async_notifier *notifier)
 	struct cio2_device *cio2 = container_of(notifier, struct cio2_device,
 						notifier);
 	struct sensor_async_subdev *s_asd;
+	struct v4l2_async_subdev *asd;
 	struct cio2_queue *q;
-	unsigned int i, pad;
+	unsigned int pad;
 	int ret;
 
-	for (i = 0; i < notifier->num_subdevs; i++) {
-		s_asd = container_of(cio2->notifier.subdevs[i],
-				     struct sensor_async_subdev, asd);
+	list_for_each_entry(asd, &cio2->notifier.asd_list, asd_list) {
+		s_asd = container_of(asd, struct sensor_async_subdev, asd);
 		q = &cio2->queue[s_asd->csi2.port];
 
 		for (pad = 0; pad < q->sensor->entity.num_pads; pad++)
@@ -1463,7 +1463,7 @@ static int cio2_notifier_complete(struct v4l2_async_notifier *notifier)
 		if (ret) {
 			dev_err(&cio2->pci_dev->dev,
 				"failed to create link for %s\n",
-				cio2->queue[i].sensor->name);
+				q->sensor->name);
 			return ret;
 		}
 	}
diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 17f32d9..d99ffafb 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -572,9 +572,6 @@ static void __v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
 		return;
 
 	if (notifier->subdevs) {
-		if (!notifier->max_subdevs)
-			return;
-
 		for (i = 0; i < notifier->num_subdevs; i++) {
 			asd = notifier->subdevs[i];
 
@@ -589,7 +586,6 @@ static void __v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
 			kfree(asd);
 		}
 
-		notifier->max_subdevs = 0;
 		kvfree(notifier->subdevs);
 		notifier->subdevs = NULL;
 	} else if (notifier->lists_initialized) {
diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 3240c2a..0f88856 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -316,33 +316,6 @@ void v4l2_fwnode_put_link(struct v4l2_fwnode_link *link)
 }
 EXPORT_SYMBOL_GPL(v4l2_fwnode_put_link);
 
-static int v4l2_async_notifier_realloc(struct v4l2_async_notifier *notifier,
-				       unsigned int max_subdevs)
-{
-	struct v4l2_async_subdev **subdevs;
-
-	if (max_subdevs <= notifier->max_subdevs)
-		return 0;
-
-	subdevs = kvmalloc_array(
-		max_subdevs, sizeof(*notifier->subdevs),
-		GFP_KERNEL | __GFP_ZERO);
-	if (!subdevs)
-		return -ENOMEM;
-
-	if (notifier->subdevs) {
-		memcpy(subdevs, notifier->subdevs,
-		       sizeof(*subdevs) * notifier->num_subdevs);
-
-		kvfree(notifier->subdevs);
-	}
-
-	notifier->subdevs = subdevs;
-	notifier->max_subdevs = max_subdevs;
-
-	return 0;
-}
-
 static int v4l2_async_notifier_fwnode_parse_endpoint(
 	struct device *dev, struct v4l2_async_notifier *notifier,
 	struct fwnode_handle *endpoint, unsigned int asd_struct_size,
@@ -387,8 +360,13 @@ static int v4l2_async_notifier_fwnode_parse_endpoint(
 	if (ret < 0)
 		goto out_err;
 
-	notifier->subdevs[notifier->num_subdevs] = asd;
-	notifier->num_subdevs++;
+	ret = v4l2_async_notifier_add_subdev(notifier, asd);
+	if (ret < 0) {
+		/* not an error if asd already exists */
+		if (ret == -EEXIST)
+			ret = 0;
+		goto out_err;
+	}
 
 	return 0;
 
@@ -407,8 +385,7 @@ static int __v4l2_async_notifier_parse_fwnode_endpoints(
 			    struct v4l2_async_subdev *asd))
 {
 	struct fwnode_handle *fwnode;
-	unsigned int max_subdevs = notifier->max_subdevs;
-	int ret;
+	int ret = 0;
 
 	if (WARN_ON(asd_struct_size < sizeof(struct v4l2_async_subdev)))
 		return -EINVAL;
@@ -428,40 +405,6 @@ static int __v4l2_async_notifier_parse_fwnode_endpoints(
 			struct fwnode_endpoint ep;
 
 			ret = fwnode_graph_parse_endpoint(fwnode, &ep);
-			if (ret) {
-				fwnode_handle_put(fwnode);
-				return ret;
-			}
-
-			if (ep.port != port)
-				continue;
-		}
-		max_subdevs++;
-	}
-
-	/* No subdevs to add? Return here. */
-	if (max_subdevs == notifier->max_subdevs)
-		return 0;
-
-	ret = v4l2_async_notifier_realloc(notifier, max_subdevs);
-	if (ret)
-		return ret;
-
-	for (fwnode = NULL; (fwnode = fwnode_graph_get_next_endpoint(
-				     dev_fwnode(dev), fwnode)); ) {
-		struct fwnode_handle *dev_fwnode;
-		bool is_available;
-
-		dev_fwnode = fwnode_graph_get_port_parent(fwnode);
-		is_available = fwnode_device_is_available(dev_fwnode);
-		fwnode_handle_put(dev_fwnode);
-		if (!is_available)
-			continue;
-
-		if (has_port) {
-			struct fwnode_endpoint ep;
-
-			ret = fwnode_graph_parse_endpoint(fwnode, &ep);
 			if (ret)
 				break;
 
@@ -469,11 +412,6 @@ static int __v4l2_async_notifier_parse_fwnode_endpoints(
 				continue;
 		}
 
-		if (WARN_ON(notifier->num_subdevs >= notifier->max_subdevs)) {
-			ret = -EINVAL;
-			break;
-		}
-
 		ret = v4l2_async_notifier_fwnode_parse_endpoint(
 			dev, notifier, fwnode, asd_struct_size, parse_endpoint);
 		if (ret < 0)
@@ -544,31 +482,23 @@ static int v4l2_fwnode_reference_parse(
 	if (ret != -ENOENT && ret != -ENODATA)
 		return ret;
 
-	ret = v4l2_async_notifier_realloc(notifier,
-					  notifier->num_subdevs + index);
-	if (ret)
-		return ret;
-
 	for (index = 0; !fwnode_property_get_reference_args(
 		     dev_fwnode(dev), prop, NULL, 0, index, &args);
 	     index++) {
 		struct v4l2_async_subdev *asd;
 
-		if (WARN_ON(notifier->num_subdevs >= notifier->max_subdevs)) {
-			ret = -EINVAL;
-			goto error;
-		}
+		asd = v4l2_async_notifier_add_fwnode_subdev(
+			notifier, args.fwnode, sizeof(*asd));
+		if (IS_ERR(asd)) {
+			ret = PTR_ERR(asd);
+			/* not an error if asd already exists */
+			if (ret == -EEXIST) {
+				fwnode_handle_put(args.fwnode);
+				continue;
+			}
 
-		asd = kzalloc(sizeof(*asd), GFP_KERNEL);
-		if (!asd) {
-			ret = -ENOMEM;
 			goto error;
 		}
-
-		notifier->subdevs[notifier->num_subdevs] = asd;
-		asd->match.fwnode = args.fwnode;
-		asd->match_type = V4L2_ASYNC_MATCH_FWNODE;
-		notifier->num_subdevs++;
 	}
 
 	return 0;
@@ -839,31 +769,23 @@ static int v4l2_fwnode_reference_parse_int_props(
 		index++;
 	} while (1);
 
-	ret = v4l2_async_notifier_realloc(notifier,
-					  notifier->num_subdevs + index);
-	if (ret)
-		return -ENOMEM;
-
 	for (index = 0; !IS_ERR((fwnode = v4l2_fwnode_reference_get_int_prop(
 					 dev_fwnode(dev), prop, index, props,
 					 nprops))); index++) {
 		struct v4l2_async_subdev *asd;
 
-		if (WARN_ON(notifier->num_subdevs >= notifier->max_subdevs)) {
-			ret = -EINVAL;
-			goto error;
-		}
+		asd = v4l2_async_notifier_add_fwnode_subdev(notifier, fwnode,
+							    sizeof(*asd));
+		if (IS_ERR(asd)) {
+			ret = PTR_ERR(asd);
+			/* not an error if asd already exists */
+			if (ret == -EEXIST) {
+				fwnode_handle_put(fwnode);
+				continue;
+			}
 
-		asd = kzalloc(sizeof(struct v4l2_async_subdev), GFP_KERNEL);
-		if (!asd) {
-			ret = -ENOMEM;
 			goto error;
 		}
-
-		notifier->subdevs[notifier->num_subdevs] = asd;
-		asd->match.fwnode = fwnode;
-		asd->match_type = V4L2_ASYNC_MATCH_FWNODE;
-		notifier->num_subdevs++;
 	}
 
 	return PTR_ERR(fwnode) == -ENOENT ? 0 : PTR_ERR(fwnode);
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 5394361..549b1de 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -125,7 +125,6 @@ struct v4l2_async_notifier_operations {
  *
  * @ops:	notifier operations
  * @num_subdevs: number of subdevices used in the subdevs array
- * @max_subdevs: number of subdevices allocated in the subdevs array
  * @subdevs:	array of pointers to subdevice descriptors
  * @v4l2_dev:	v4l2_device of the root notifier, NULL otherwise
  * @sd:		sub-device that registered the notifier, NULL otherwise
@@ -139,7 +138,6 @@ struct v4l2_async_notifier_operations {
 struct v4l2_async_notifier {
 	const struct v4l2_async_notifier_operations *ops;
 	unsigned int num_subdevs;
-	unsigned int max_subdevs;
 	struct v4l2_async_subdev **subdevs;
 	struct v4l2_device *v4l2_dev;
 	struct v4l2_subdev *sd;
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index 9cccab6..ea7a8b2 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -247,7 +247,7 @@ typedef int (*parse_endpoint_func)(struct device *dev,
  *		    endpoint. Optional.
  *
  * Parse the fwnode endpoints of the @dev device and populate the async sub-
- * devices array of the notifier. The @parse_endpoint callback function is
+ * devices list in the notifier. The @parse_endpoint callback function is
  * called for each endpoint with the corresponding async sub-device pointer to
  * let the caller initialize the driver-specific part of the async sub-device
  * structure.
@@ -258,10 +258,11 @@ typedef int (*parse_endpoint_func)(struct device *dev,
  * This function may not be called on a registered notifier and may be called on
  * a notifier only once.
  *
- * Do not change the notifier's subdevs array, take references to the subdevs
- * array itself or change the notifier's num_subdevs field. This is because this
- * function allocates and reallocates the subdevs array based on parsing
- * endpoints.
+ * Do not allocate the notifier's subdevs array, or change the notifier's
+ * num_subdevs field. This is because this function uses
+ * @v4l2_async_notifier_add_subdev to populate the notifier's asd_list,
+ * which is in-place-of the subdevs array which must remain unallocated
+ * and unused.
  *
  * The &struct v4l2_fwnode_endpoint passed to the callback function
  * @parse_endpoint is released once the function is finished. If there is a need
@@ -303,7 +304,7 @@ int v4l2_async_notifier_parse_fwnode_endpoints(
  * devices). In this case the driver must know which ports to parse.
  *
  * Parse the fwnode endpoints of the @dev device on a given @port and populate
- * the async sub-devices array of the notifier. The @parse_endpoint callback
+ * the async sub-devices list of the notifier. The @parse_endpoint callback
  * function is called for each endpoint with the corresponding async sub-device
  * pointer to let the caller initialize the driver-specific part of the async
  * sub-device structure.
@@ -314,10 +315,11 @@ int v4l2_async_notifier_parse_fwnode_endpoints(
  * This function may not be called on a registered notifier and may be called on
  * a notifier only once per port.
  *
- * Do not change the notifier's subdevs array, take references to the subdevs
- * array itself or change the notifier's num_subdevs field. This is because this
- * function allocates and reallocates the subdevs array based on parsing
- * endpoints.
+ * Do not allocate the notifier's subdevs array, or change the notifier's
+ * num_subdevs field. This is because this function uses
+ * @v4l2_async_notifier_add_subdev to populate the notifier's asd_list,
+ * which is in-place-of the subdevs array which must remain unallocated
+ * and unused.
  *
  * The &struct v4l2_fwnode_endpoint passed to the callback function
  * @parse_endpoint is released once the function is finished. If there is a need
-- 
2.7.4

