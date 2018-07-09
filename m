Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06615C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A674C2086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXthhN5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A674C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933015AbeGIWlo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:41:44 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40169 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933442AbeGIWkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:40:00 -0400
Received: by mail-pf0-f193.google.com with SMTP id e13-v6so1279292pff.7;
        Mon, 09 Jul 2018 15:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vVw/7tUmYXJN34JZTnVhjtAoZU8DiZDgqC/LutHSves=;
        b=vXthhN5cKci0IHJxdo3Ym8jpLqBaYPD6LGAh/824y7mPZJORtLkSM+kDNVNSN59Ucl
         9vpEif7zLRy1x3Dqfs5J8R0gnxZzc+/BEnThoov4nvg4dzAZiNYxC/+BVTvNJkKaA5wz
         glJ6jRnjQU2u73j10v6wb4ogtShmuEYDly3Ar0fvrZOVCXn6wmm3al+BpSLUK3ivo5qw
         eDqvTAMbs7LSI3PansH3PiSRd0qwPpCnpS/sw6srzSw+TqMnDil7tBEJLhH1PD3tOmha
         8Bvbccl/y3HiGjpqohefKTFKkpVH7Q6JzIziGsiSjIb37N2fTl38NvNcg45jumTqZBLK
         PjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vVw/7tUmYXJN34JZTnVhjtAoZU8DiZDgqC/LutHSves=;
        b=jVvRMjkvpZBptmPFAGPGKIEQ5uEIJczRoA513qr8JAMMp/ZIuO/C6oCjlD4L5zAA3M
         B8iNGqs6xX2srPn/MUf8Ckq8b4COC743rWtSx/tFvUstxSItdLzToaWxXr7Xc8koJoQx
         GezKV2Z5l7vRTUW/cYFSO9sGKfZwoupwQJnSQ4tVl3LsdoAHxWZ1ougsdlOVRLfA1GQW
         1sIvqIpFByLMDBvnvrkkS7tlvFRX8wAVA8fT9Zs6m3dm/nz8QzaeHRkWjCEwoZRAh+TS
         rJJDsHKYcJcCl0e0A1r2pfn74A7kUfxT21x/I7fKOwNxy7HN2OPYPYvS0Y3nKkZ4epxE
         jwQw==
X-Gm-Message-State: APt69E2BQhuJd0HARrmR8UxMG+xOGP9UZIW5g6daZuQ2tW8mZ75Zdt+L
        elTrwM5+8PtV3iLHRFQVCzLlEw==
X-Google-Smtp-Source: AAOMgpf8VOpum/ipy2lGK8XS1sYBuBc2gdyyhein+9cNUM9RDbhXsl2JHJCdZLEhrYwSPwplQBViJQ==
X-Received: by 2002:a62:e00a:: with SMTP id f10-v6mr23222701pfh.208.1531175999981;
        Mon, 09 Jul 2018 15:39:59 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm30143804pfe.173.2018.07.09.15.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 15:39:59 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 13/17] media: staging/imx: Switch to v4l2_async_notifier_add_*_subdev
Date:   Mon,  9 Jul 2018 15:39:13 -0700
Message-Id: <1531175957-1973-14-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to v4l2_async_notifier_add_*_subdev() when adding async subdevs
to the imx-media root notifier. This removes the need to check for
an already added asd, since v4l2_async_notifier_add_*_subdev() does this
check. Also no need to allocate a subdevs array when registering the
root notifier, or keeping an internal master asd_list, since this is
moved to the notifier's asd_list.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
Changes since v5:
- remove reference to notifier.num_subdevs and call
  v4l2_async_notifier_init(). Suggested by Sakari Ailus.
---
 drivers/staging/media/imx/imx-media-dev.c         | 121 ++++++----------------
 drivers/staging/media/imx/imx-media-internal-sd.c |   5 +-
 drivers/staging/media/imx/imx-media.h             |   4 +-
 3 files changed, 36 insertions(+), 94 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
index 982e455..659420e 100644
--- a/drivers/staging/media/imx/imx-media-dev.c
+++ b/drivers/staging/media/imx/imx-media-dev.c
@@ -33,43 +33,10 @@ static inline struct imx_media_dev *notifier2dev(struct v4l2_async_notifier *n)
 }
 
 /*
- * Find an asd by fwnode or device name. This is called during
- * driver load to form the async subdev list and bind them.
- */
-static struct v4l2_async_subdev *
-find_async_subdev(struct imx_media_dev *imxmd,
-		  struct fwnode_handle *fwnode,
-		  const char *devname)
-{
-	struct imx_media_async_subdev *imxasd;
-	struct v4l2_async_subdev *asd;
-
-	list_for_each_entry(imxasd, &imxmd->asd_list, list) {
-		asd = &imxasd->asd;
-		switch (asd->match_type) {
-		case V4L2_ASYNC_MATCH_FWNODE:
-			if (fwnode && asd->match.fwnode == fwnode)
-				return asd;
-			break;
-		case V4L2_ASYNC_MATCH_DEVNAME:
-			if (devname && !strcmp(asd->match.device_name,
-					       devname))
-				return asd;
-			break;
-		default:
-			break;
-		}
-	}
-
-	return NULL;
-}
-
-
-/*
- * Adds a subdev to the async subdev list. If fwnode is non-NULL, adds
- * the async as a V4L2_ASYNC_MATCH_FWNODE match type, otherwise as
- * a V4L2_ASYNC_MATCH_DEVNAME match type using the dev_name of the
- * given platform_device. This is called during driver load when
+ * Adds a subdev to the root notifier's async subdev list. If fwnode is
+ * non-NULL, adds the async as a V4L2_ASYNC_MATCH_FWNODE match type,
+ * otherwise as a V4L2_ASYNC_MATCH_DEVNAME match type using the dev_name
+ * of the given platform_device. This is called during driver load when
  * forming the async subdev list.
  */
 int imx_media_add_async_subdev(struct imx_media_dev *imxmd,
@@ -80,47 +47,34 @@ int imx_media_add_async_subdev(struct imx_media_dev *imxmd,
 	struct imx_media_async_subdev *imxasd;
 	struct v4l2_async_subdev *asd;
 	const char *devname = NULL;
-	int ret = 0;
-
-	mutex_lock(&imxmd->mutex);
+	int ret;
 
-	if (pdev)
+	if (fwnode) {
+		asd = v4l2_async_notifier_add_fwnode_subdev(
+			&imxmd->notifier, fwnode, sizeof(*imxasd));
+	} else {
 		devname = dev_name(&pdev->dev);
-
-	/* return -EEXIST if this asd already added */
-	if (find_async_subdev(imxmd, fwnode, devname)) {
-		dev_dbg(imxmd->md.dev, "%s: already added %s\n",
-			__func__, np ? np->name : devname);
-		ret = -EEXIST;
-		goto out;
+		asd = v4l2_async_notifier_add_devname_subdev(
+			&imxmd->notifier, devname, sizeof(*imxasd));
 	}
 
-	imxasd = devm_kzalloc(imxmd->md.dev, sizeof(*imxasd), GFP_KERNEL);
-	if (!imxasd) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	asd = &imxasd->asd;
-
-	if (fwnode) {
-		asd->match_type = V4L2_ASYNC_MATCH_FWNODE;
-		asd->match.fwnode = fwnode;
-	} else {
-		asd->match_type = V4L2_ASYNC_MATCH_DEVNAME;
-		asd->match.device_name = devname;
-		imxasd->pdev = pdev;
+	if (IS_ERR(asd)) {
+		ret = PTR_ERR(asd);
+		if (ret == -EEXIST)
+			dev_dbg(imxmd->md.dev, "%s: already added %s\n",
+				__func__, np ? np->name : devname);
+		return ret;
 	}
 
-	list_add_tail(&imxasd->list, &imxmd->asd_list);
+	imxasd = to_imx_media_asd(asd);
 
-	imxmd->notifier.num_subdevs++;
+	if (devname)
+		imxasd->pdev = pdev;
 
 	dev_dbg(imxmd->md.dev, "%s: added %s, match type %s\n",
 		__func__, np ? np->name : devname, np ? "FWNODE" : "DEVNAME");
 
-out:
-	mutex_unlock(&imxmd->mutex);
-	return ret;
+	return 0;
 }
 
 /*
@@ -483,10 +437,8 @@ static int imx_media_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
-	struct imx_media_async_subdev *imxasd;
-	struct v4l2_async_subdev **subdevs;
 	struct imx_media_dev *imxmd;
-	int num_subdevs, i, ret;
+	int ret;
 
 	imxmd = devm_kzalloc(dev, sizeof(*imxmd), GFP_KERNEL);
 	if (!imxmd)
@@ -515,44 +467,31 @@ static int imx_media_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(imxmd->v4l2_dev.dev, imxmd);
 
-	INIT_LIST_HEAD(&imxmd->asd_list);
 	INIT_LIST_HEAD(&imxmd->vdev_list);
 
+	v4l2_async_notifier_init(&imxmd->notifier);
+
 	ret = imx_media_add_of_subdevs(imxmd, node);
 	if (ret) {
 		v4l2_err(&imxmd->v4l2_dev,
 			 "add_of_subdevs failed with %d\n", ret);
-		goto unreg_dev;
+		goto notifier_cleanup;
 	}
 
 	ret = imx_media_add_internal_subdevs(imxmd);
 	if (ret) {
 		v4l2_err(&imxmd->v4l2_dev,
 			 "add_internal_subdevs failed with %d\n", ret);
-		goto unreg_dev;
+		goto notifier_cleanup;
 	}
 
-	num_subdevs = imxmd->notifier.num_subdevs;
-
 	/* no subdevs? just bail */
-	if (num_subdevs == 0) {
+	if (list_empty(&imxmd->notifier.asd_list)) {
 		ret = -ENODEV;
-		goto unreg_dev;
+		goto notifier_cleanup;
 	}
 
-	subdevs = devm_kcalloc(imxmd->md.dev, num_subdevs, sizeof(*subdevs),
-			       GFP_KERNEL);
-	if (!subdevs) {
-		ret = -ENOMEM;
-		goto unreg_dev;
-	}
-
-	i = 0;
-	list_for_each_entry(imxasd, &imxmd->asd_list, list)
-		subdevs[i++] = &imxasd->asd;
-
 	/* prepare the async subdev notifier and register it */
-	imxmd->notifier.subdevs = subdevs;
 	imxmd->notifier.ops = &imx_media_subdev_ops;
 	ret = v4l2_async_notifier_register(&imxmd->v4l2_dev,
 					   &imxmd->notifier);
@@ -566,7 +505,8 @@ static int imx_media_probe(struct platform_device *pdev)
 
 del_int:
 	imx_media_remove_internal_subdevs(imxmd);
-unreg_dev:
+notifier_cleanup:
+	v4l2_async_notifier_cleanup(&imxmd->notifier);
 	v4l2_device_unregister(&imxmd->v4l2_dev);
 cleanup:
 	media_device_cleanup(&imxmd->md);
@@ -582,6 +522,7 @@ static int imx_media_remove(struct platform_device *pdev)
 
 	v4l2_async_notifier_unregister(&imxmd->notifier);
 	imx_media_remove_internal_subdevs(imxmd);
+	v4l2_async_notifier_cleanup(&imxmd->notifier);
 	v4l2_device_unregister(&imxmd->v4l2_dev);
 	media_device_unregister(&imxmd->md);
 	media_device_cleanup(&imxmd->md);
diff --git a/drivers/staging/media/imx/imx-media-internal-sd.c b/drivers/staging/media/imx/imx-media-internal-sd.c
index daf66c2..0fdc45d 100644
--- a/drivers/staging/media/imx/imx-media-internal-sd.c
+++ b/drivers/staging/media/imx/imx-media-internal-sd.c
@@ -350,8 +350,11 @@ int imx_media_add_internal_subdevs(struct imx_media_dev *imxmd)
 void imx_media_remove_internal_subdevs(struct imx_media_dev *imxmd)
 {
 	struct imx_media_async_subdev *imxasd;
+	struct v4l2_async_subdev *asd;
+
+	list_for_each_entry(asd, &imxmd->notifier.asd_list, asd_list) {
+		imxasd = to_imx_media_asd(asd);
 
-	list_for_each_entry(imxasd, &imxmd->asd_list, list) {
 		if (!imxasd->pdev)
 			continue;
 
diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
index 227b79c..bc7feb8 100644
--- a/drivers/staging/media/imx/imx-media.h
+++ b/drivers/staging/media/imx/imx-media.h
@@ -119,12 +119,11 @@ struct imx_media_internal_sd_platformdata {
 	int ipu_id;
 };
 
-
 struct imx_media_async_subdev {
+	/* the base asd - must be first in this struct */
 	struct v4l2_async_subdev asd;
 	/* the platform device of IPU-internal subdevs */
 	struct platform_device *pdev;
-	struct list_head list;
 };
 
 static inline struct imx_media_async_subdev *
@@ -149,7 +148,6 @@ struct imx_media_dev {
 	struct ipu_soc *ipu[2];
 
 	/* for async subdev registration */
-	struct list_head asd_list;
 	struct v4l2_async_notifier notifier;
 };
 
-- 
2.7.4

