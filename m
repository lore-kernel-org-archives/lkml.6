Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEECC004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2E520880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sf4aveud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2E520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeI3CYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:24:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35911 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeI3CYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:24:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id f18-v6so3257209pgv.3;
        Sat, 29 Sep 2018 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g6+ikUOI7jx8njeSwjuicq4h9f38aNc/QaFT1TTPVpE=;
        b=sf4aveudY9jD0s8b+ekbmR4UHhXcDO3tYDzXyrQHqYeFqDe9vMvYbKDTwlT87HfDLT
         2yVeznCd46SaClx/TNU+m0lRnQMwPa0OgMfb3NCxD9WTnaUD9CwSWXUCTE31CLasCnJB
         /P9NSD1JcPiKCDS3UNYL+si+IXJo+txcVz32ykkcERy4wV9A79TkKBCUgI3COMv/ZU/h
         dhtGQAbhQENfinv+iAUfiv52TpNYrltHT2c52SGnkG8hTnZGNlRe/AhkJT5xSguMOtQf
         JOM7kk6L3NihLjn0ocdljhusyZf91hLfdBE1uF5QwGS1MHbc4omHULUVtIqad1nRJ2I8
         uL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g6+ikUOI7jx8njeSwjuicq4h9f38aNc/QaFT1TTPVpE=;
        b=tFvcPg35WGjZedsfRuH37kuRRMEAo96Z8UMeW6OWV7wJTjGprNQKqBi4vpAoXP4MW2
         8Iwc7gGXCZukliJAj9IGWdaaUZcUqzzMZo+mSwbzAfeEN1Gmro6pS2BoN3LHrm4jFjWj
         tEiQGkXbeF5/R9044PTMv1a3kP1AfnJFEFIxWqHt3L8sVQufWpd4UbaepxmUZrlcXz5h
         twZGp6sgaLOL6KIk3KUt4PkLbeXeOZE3RuP/APZi+dxxaf0mHDg4VU9b8kQAA7bZGrkG
         HaQHHYYnNE/Uk0YIktrHtYBxFRZ81ftHHMkuZDfOHTS474bXpYPuOYgvggxEY931ri/q
         mrFQ==
X-Gm-Message-State: ABuFfojKDFNdS3HBw58jmleLZ1aTyBqBeizaagbPb/k7Xwy/HlqXspr7
        j5ecDFC0xgq5kyyy3NLGhU0E5ek0
X-Google-Smtp-Source: ACcGV61ve8e6UAoz6URQb4NF1s4A7wtj+ma/WR/Ui2z8/wABeu5+8pK8jU0gDe3x9/a8C28V8BV9XQ==
X-Received: by 2002:a62:2fc1:: with SMTP id v184-v6mr4312159pfv.115.1538250888218;
        Sat, 29 Sep 2018 12:54:48 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id b126-v6sm18371946pga.49.2018.09.29.12.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:54:47 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Jian Xu Zheng <jian.xu.zheng@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sebastian Reichel <sre@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-renesas-soc@vger.kernel.org (open list:MEDIA DRIVERS FOR RENESAS
        - VIN)
Subject: [RESEND PATCH v7 05/17] media: v4l2-fwnode: Switch to v4l2_async_notifier_add_subdev
Date:   Sat, 29 Sep 2018 12:54:08 -0700
Message-Id: <20180929195420.28579-6-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929195420.28579-1-slongerbeam@gmail.com>
References: <20180929195420.28579-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fwnode endpoint and reference parsing functions in v4l2-fwnode.c
are modified to make use of v4l2_async_notifier_add_subdev().
As a result the notifier->subdevs array is no longer allocated or
re-allocated, and by extension the max_subdevs value is also no
longer needed.

Callers of the fwnode endpoint and reference parsing functions must now
first initialize the notifier with a call to v4l2_async_notifier_init().
This includes the function v4l2_async_register_subdev_sensor_common(),
and the intel-ipu3, omap3isp, and rcar-vin drivers.

Since the notifier->subdevs array is no longer allocated in the
fwnode endpoint and reference parsing functions, the callers of
those functions must never reference that array, since it is now
NULL. Of the drivers that make use of the fwnode/ref parsing,
only the intel-ipu3 driver references the ->subdevs[] array,
(in the notifier completion callback), so that driver has been
modified to iterate through the notifier->asd_list instead.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes since v6:
- none
Changes since v5:
- drivers must now initialize the notifier. Suggested by Sakari Ailus.
---
 drivers/media/pci/intel/ipu3/ipu3-cio2.c    |  12 +-
 drivers/media/platform/omap3isp/isp.c       |   1 +
 drivers/media/platform/rcar-vin/rcar-core.c |   4 +
 drivers/media/v4l2-core/v4l2-async.c        |   4 -
 drivers/media/v4l2-core/v4l2-fwnode.c       | 132 +++++---------------
 include/media/v4l2-async.h                  |   2 -
 include/media/v4l2-fwnode.h                 |  22 ++--
 7 files changed, 52 insertions(+), 125 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 08cf4bf00941..d7926c31388f 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1433,13 +1433,13 @@ static int cio2_notifier_complete(struct v4l2_async_notifier *notifier)
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
@@ -1461,7 +1461,7 @@ static int cio2_notifier_complete(struct v4l2_async_notifier *notifier)
 		if (ret) {
 			dev_err(&cio2->pci_dev->dev,
 				"failed to create link for %s\n",
-				cio2->queue[i].sensor->name);
+				q->sensor->name);
 			return ret;
 		}
 	}
@@ -1497,6 +1497,8 @@ static int cio2_notifier_init(struct cio2_device *cio2)
 {
 	int ret;
 
+	v4l2_async_notifier_init(&cio2->notifier);
+
 	ret = v4l2_async_notifier_parse_fwnode_endpoints(
 		&cio2->pci_dev->dev, &cio2->notifier,
 		sizeof(struct sensor_async_subdev),
diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index 93f032a39470..f5dde8774399 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -2220,6 +2220,7 @@ static int isp_probe(struct platform_device *pdev)
 
 	mutex_init(&isp->isp_mutex);
 	spin_lock_init(&isp->stat_lock);
+	v4l2_async_notifier_init(&isp->notifier);
 
 	ret = v4l2_async_notifier_parse_fwnode_endpoints(
 		&pdev->dev, &isp->notifier, sizeof(struct isp_async_subdev),
diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
index 5dd16af3625c..1402b1ea1de1 100644
--- a/drivers/media/platform/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/rcar-vin/rcar-core.c
@@ -611,6 +611,8 @@ static int rvin_parallel_init(struct rvin_dev *vin)
 {
 	int ret;
 
+	v4l2_async_notifier_init(&vin->notifier);
+
 	ret = v4l2_async_notifier_parse_fwnode_endpoints_by_port(
 		vin->dev, &vin->notifier, sizeof(struct rvin_parallel_entity),
 		0, rvin_parallel_parse_v4l2);
@@ -803,6 +805,8 @@ static int rvin_mc_parse_of_graph(struct rvin_dev *vin)
 		return 0;
 	}
 
+	v4l2_async_notifier_init(&vin->group->notifier);
+
 	/*
 	 * Have all VIN's look for CSI-2 subdevices. Some subdevices will
 	 * overlap but the parser function can handle it, so each subdevice
diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 196573f4ec48..b0eb31efcbfe 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -566,9 +566,6 @@ static void __v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
 		return;
 
 	if (notifier->subdevs) {
-		if (!notifier->max_subdevs)
-			return;
-
 		for (i = 0; i < notifier->num_subdevs; i++) {
 			asd = notifier->subdevs[i];
 
@@ -583,7 +580,6 @@ static void __v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
 			kfree(asd);
 		}
 
-		notifier->max_subdevs = 0;
 		kvfree(notifier->subdevs);
 		notifier->subdevs = NULL;
 	} else {
diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 0b8c736b1606..88383d3d5974 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -320,33 +320,6 @@ void v4l2_fwnode_put_link(struct v4l2_fwnode_link *link)
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
@@ -391,8 +364,13 @@ static int v4l2_async_notifier_fwnode_parse_endpoint(
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
 
@@ -411,46 +389,11 @@ static int __v4l2_async_notifier_parse_fwnode_endpoints(
 			    struct v4l2_async_subdev *asd))
 {
 	struct fwnode_handle *fwnode;
-	unsigned int max_subdevs = notifier->max_subdevs;
-	int ret;
+	int ret = 0;
 
 	if (WARN_ON(asd_struct_size < sizeof(struct v4l2_async_subdev)))
 		return -EINVAL;
 
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
 	for (fwnode = NULL; (fwnode = fwnode_graph_get_next_endpoint(
 				     dev_fwnode(dev), fwnode)); ) {
 		struct fwnode_handle *dev_fwnode;
@@ -473,11 +416,6 @@ static int __v4l2_async_notifier_parse_fwnode_endpoints(
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
@@ -548,31 +486,23 @@ static int v4l2_fwnode_reference_parse(
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
@@ -843,31 +773,23 @@ static int v4l2_fwnode_reference_parse_int_props(
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
@@ -924,6 +846,8 @@ int v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd)
 	if (!notifier)
 		return -ENOMEM;
 
+	v4l2_async_notifier_init(notifier);
+
 	ret = v4l2_async_notifier_parse_fwnode_sensor_common(sd->dev,
 							     notifier);
 	if (ret < 0)
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 3489e4ccb29b..16b1e2b097c1 100644
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
@@ -138,7 +137,6 @@ struct v4l2_async_notifier_operations {
 struct v4l2_async_notifier {
 	const struct v4l2_async_notifier_operations *ops;
 	unsigned int num_subdevs;
-	unsigned int max_subdevs;
 	struct v4l2_async_subdev **subdevs;
 	struct v4l2_device *v4l2_dev;
 	struct v4l2_subdev *sd;
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index 9cccab618b98..ea7a8b247e19 100644
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
2.17.1

