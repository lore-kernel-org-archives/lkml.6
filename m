Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC90C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A012088F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oO+MexWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A012088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeI3CYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:24:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37249 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeI3CYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:24:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id x26-v6so6506254pfn.4;
        Sat, 29 Sep 2018 12:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BfzJnIzqNRTgDaERy8jcbXwneJrpDpJvjf2jAJbgtxI=;
        b=oO+MexWPsemsxRyUTBAGV18JtTpYL1yOH+WXfwlAR9ZceiFxg3i9WDx7L4aXQxs9PF
         3V6ohO/kuB0XE+UP4TWb70rLOIaZYklrqpXufnux7QEt3yI0bXJ89W9Wo78qFu4IqUAq
         cKE65azi+zIRLffSycbsw/RA4bfYx8QukZPvwiSLv1p3TL+Z45uNjGm4MNBqeG6IN91K
         Pg2XHLVqvPmKml9X5ySX8Jr1rMAn8sIZ8fX6cRBsIxhouxbqPx4j0YyWWJR/hhMZYl3O
         EcualMemuKBG0MbEBVUvq8NaaRtrK4zi5uzaa0xkRhZcRkC2Om+RxUokuapNxG71hE8n
         FhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BfzJnIzqNRTgDaERy8jcbXwneJrpDpJvjf2jAJbgtxI=;
        b=BEi8BoeKnvWhc/ZpZgiffIEBN3G3QLzg4hMaB/gOSMlYUJRrFnv+E1cNs1x8rtRWKg
         F8Emj19ZQwFL0v4Om+/zsLCzLeCHDB8BgQXBHqkOXn23RXNYIbEUg0qnfz+9MTZ+r7F9
         jk5iYSzaH5rhkC6hW2yTf0HNVBKa2v4Jd2oz5+GYXaTpaUumGeKOegQliF3NKuvOjkNm
         EKELO+NPOnQpiWbLq170tIxfgb/Hp8qR8a8FnkfmW+qPBwmqS89CKL1a1JhzxZdRl6v0
         1D+OdNe6lWt8J8S2eH6bmNd8MkEySVYumNka7eCNX2PReEKptrS9vBwsFw8GfF/gOf1W
         +vkg==
X-Gm-Message-State: ABuFfogG2xbfvYlYAy0EYFtP1iMZDRQKQdg427HxTqfild381NvV7jUP
        +D5GSiSKHUs05+gc7o9qVj9i6brK
X-Google-Smtp-Source: ACcGV61QAQR25h/NJeYqLsXtUHRWt7joCscny7hMuJRET/Vsw+bC2qbMc8vTp6+cLVM+kPnaRnmo+Q==
X-Received: by 2002:a17:902:780d:: with SMTP id p13-v6mr4204037pll.96.1538250876846;
        Sat, 29 Sep 2018 12:54:36 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id b126-v6sm18371946pga.49.2018.09.29.12.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:54:35 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v7 02/17] media: v4l2: async: Allow searching for asd of any type
Date:   Sat, 29 Sep 2018 12:54:05 -0700
Message-Id: <20180929195420.28579-3-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929195420.28579-1-slongerbeam@gmail.com>
References: <20180929195420.28579-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generalize v4l2_async_notifier_fwnode_has_async_subdev() to allow
searching for any type of async subdev, not just fwnodes. Rename to
v4l2_async_notifier_has_async_subdev() and pass it an asd pointer.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes since v6:
- elaborate on comment for asd_equal(), suggested by Mauro Chehab.
- whitespace checkpatch fixes, suggested by Mauro.
- made an error message more clear in __v4l2_async_notifier_register(),
  suggested by Mauro.
Changes since v5:
- none
Changes since v4:
- none
Changes since v3:
- removed TODO to support asd compare with CUSTOM match type in
  asd_equal().
Changes since v2:
- code optimization in asd_equal(), and remove unneeded braces,
  suggested by Sakari Ailus.
Changes since v1:
- none
---
 drivers/media/v4l2-core/v4l2-async.c | 77 +++++++++++++++++-----------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 2b08d03b251d..f09d354b96a0 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -124,6 +124,31 @@ static struct v4l2_async_subdev *v4l2_async_find_match(
 	return NULL;
 }
 
+/* Compare two async sub-device descriptors for equivalence */
+static bool asd_equal(struct v4l2_async_subdev *asd_x,
+		      struct v4l2_async_subdev *asd_y)
+{
+	if (asd_x->match_type != asd_y->match_type)
+		return false;
+
+	switch (asd_x->match_type) {
+	case V4L2_ASYNC_MATCH_DEVNAME:
+		return strcmp(asd_x->match.device_name,
+			      asd_y->match.device_name) == 0;
+	case V4L2_ASYNC_MATCH_I2C:
+		return asd_x->match.i2c.adapter_id ==
+			asd_y->match.i2c.adapter_id &&
+			asd_x->match.i2c.address ==
+			asd_y->match.i2c.address;
+	case V4L2_ASYNC_MATCH_FWNODE:
+		return asd_x->match.fwnode == asd_y->match.fwnode;
+	default:
+		break;
+	}
+
+	return false;
+}
+
 /* Find the sub-device notifier registered by a sub-device driver. */
 static struct v4l2_async_notifier *v4l2_async_find_subdev_notifier(
 	struct v4l2_subdev *sd)
@@ -308,29 +333,23 @@ static void v4l2_async_notifier_unbind_all_subdevs(
 	notifier->parent = NULL;
 }
 
-/* See if an fwnode can be found in a notifier's lists. */
-static bool __v4l2_async_notifier_fwnode_has_async_subdev(
-	struct v4l2_async_notifier *notifier, struct fwnode_handle *fwnode)
+/* See if an async sub-device can be found in a notifier's lists. */
+static bool
+__v4l2_async_notifier_has_async_subdev(struct v4l2_async_notifier *notifier,
+				       struct v4l2_async_subdev *asd)
 {
-	struct v4l2_async_subdev *asd;
+	struct v4l2_async_subdev *asd_y;
 	struct v4l2_subdev *sd;
 
-	list_for_each_entry(asd, &notifier->waiting, list) {
-		if (asd->match_type != V4L2_ASYNC_MATCH_FWNODE)
-			continue;
-
-		if (asd->match.fwnode == fwnode)
+	list_for_each_entry(asd_y, &notifier->waiting, list)
+		if (asd_equal(asd, asd_y))
 			return true;
-	}
 
 	list_for_each_entry(sd, &notifier->done, async_list) {
 		if (WARN_ON(!sd->asd))
 			continue;
 
-		if (sd->asd->match_type != V4L2_ASYNC_MATCH_FWNODE)
-			continue;
-
-		if (sd->asd->match.fwnode == fwnode)
+		if (asd_equal(asd, sd->asd))
 			return true;
 	}
 
@@ -338,32 +357,29 @@ static bool __v4l2_async_notifier_fwnode_has_async_subdev(
 }
 
 /*
- * Find out whether an async sub-device was set up for an fwnode already or
+ * Find out whether an async sub-device was set up already or
  * whether it exists in a given notifier before @this_index.
  */
-static bool v4l2_async_notifier_fwnode_has_async_subdev(
-	struct v4l2_async_notifier *notifier, struct fwnode_handle *fwnode,
-	unsigned int this_index)
+static bool
+v4l2_async_notifier_has_async_subdev(struct v4l2_async_notifier *notifier,
+				     struct v4l2_async_subdev *asd,
+				     unsigned int this_index)
 {
 	unsigned int j;
 
 	lockdep_assert_held(&list_lock);
 
-	/* Check that an fwnode is not being added more than once. */
+	/* Check that an asd is not being added more than once. */
 	for (j = 0; j < this_index; j++) {
-		struct v4l2_async_subdev *asd = notifier->subdevs[this_index];
-		struct v4l2_async_subdev *other_asd = notifier->subdevs[j];
+		struct v4l2_async_subdev *asd_y = notifier->subdevs[j];
 
-		if (other_asd->match_type == V4L2_ASYNC_MATCH_FWNODE &&
-		    asd->match.fwnode ==
-		    other_asd->match.fwnode)
+		if (asd_equal(asd, asd_y))
 			return true;
 	}
 
-	/* Check than an fwnode did not exist in other notifiers. */
+	/* Check that an asd does not exist in other notifiers. */
 	list_for_each_entry(notifier, &notifier_list, list)
-		if (__v4l2_async_notifier_fwnode_has_async_subdev(
-			    notifier, fwnode))
+		if (__v4l2_async_notifier_has_async_subdev(notifier, asd))
 			return true;
 
 	return false;
@@ -392,12 +408,11 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
 		case V4L2_ASYNC_MATCH_CUSTOM:
 		case V4L2_ASYNC_MATCH_DEVNAME:
 		case V4L2_ASYNC_MATCH_I2C:
-			break;
 		case V4L2_ASYNC_MATCH_FWNODE:
-			if (v4l2_async_notifier_fwnode_has_async_subdev(
-				    notifier, asd->match.fwnode, i)) {
+			if (v4l2_async_notifier_has_async_subdev(notifier,
+								 asd, i)) {
 				dev_err(dev,
-					"fwnode has already been registered or in notifier's subdev list\n");
+					"subdev descriptor already listed in this or other notifiers\n");
 				ret = -EEXIST;
 				goto err_unlock;
 			}
-- 
2.17.1

