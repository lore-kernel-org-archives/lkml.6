Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518D4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019E82086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M84mTZ5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019E82086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933324AbeGIWjj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:39:39 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44149 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932798AbeGIWjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:39:35 -0400
Received: by mail-pl0-f66.google.com with SMTP id m16-v6so6674754pls.11;
        Mon, 09 Jul 2018 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=COvkSv7AVNT2giyd13/Uo54al3e9gB0iJ5gUihAGfOA=;
        b=M84mTZ5LrnMSTnOvACTCoShSaeTfuFhC9ApegN7FmhwaA59Lt503cpS6GxWxsGFXSu
         fNoSODQkin0bJ1JkVBQNFk1ZZyTnyf8ZEiMWngE9rq5hz+A7F/rGvdhkqhtLIc+1pR68
         lvFbGmKxR7p2mI2pYWfveZvoaDM6XObq9Mb3cji4N6roUq3gMRaAOek1ExP/5P7INioR
         RMfmDSnTlMCFwRWNBTufjlstR66f5H2bMxl8M8MBdUamSjhMlZIXJ8EqWfa0Eym2fJVC
         LJSKx7t7C+NKKf47eUCq33F7xF4eHVv2/Rgf1JiJ98i1og+HXasfdJCVngsWq+kZEW8i
         pneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=COvkSv7AVNT2giyd13/Uo54al3e9gB0iJ5gUihAGfOA=;
        b=MG4/+KXsz2NhwQQNOBb4i0gpcxkzLRlebsbB9RutNp1GW2dZ/5JtN7lFft7DJVKzlS
         1IAzP3DLqEP7UXptp+bynR8XyBmsbmNLqHTFHUlc1wgjQf25OJqPSzG8jhdc/Wcff1Pi
         GmTpw+Qjt/OMcB9AatzfUfTqB4q6edm7pA43w14ZjdxIJ+ThuPwFiT3kKonh897ksB4v
         bqk6SMddtt00hiYocC7xPbxD3SixK3WnmeLpxEuaCaghn8TYAQ7NVko17v5DxE412CYJ
         rzU5kOxi6haw4PHCUteNOWgcCnzX4phYxbVzLgzCDu1GrbO9Z7/aoIs2hr82gn5juK8c
         sUJA==
X-Gm-Message-State: APt69E2MwXPpC4jgDxqfr6EZa/MeXGeNquWww5eY18tLvZ3UcdrLM3ht
        QRk7y2baTdCbOR++lKTQ5SzApA==
X-Google-Smtp-Source: AAOMgpdHgrToeYCmLEV+JZ0kjucYmKuAkwRNpcTfXdRD7J05tLqIv+ap0MmdH2UBotgEV7kWZfWdww==
X-Received: by 2002:a17:902:8f94:: with SMTP id z20-v6mr22018886plo.337.1531175974825;
        Mon, 09 Jul 2018 15:39:34 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm30143804pfe.173.2018.07.09.15.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 15:39:34 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 02/17] media: v4l2: async: Allow searching for asd of any type
Date:   Mon,  9 Jul 2018 15:39:02 -0700
Message-Id: <1531175957-1973-3-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generalize v4l2_async_notifier_fwnode_has_async_subdev() to allow
searching for any type of async subdev, not just fwnodes. Rename to
v4l2_async_notifier_has_async_subdev() and pass it an asd pointer.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
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
 drivers/media/v4l2-core/v4l2-async.c | 73 +++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 2b08d03..0e7e529 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -124,6 +124,31 @@ static struct v4l2_async_subdev *v4l2_async_find_match(
 	return NULL;
 }
 
+/* Compare two asd's for equivalence */
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
@@ -308,29 +333,22 @@ static void v4l2_async_notifier_unbind_all_subdevs(
 	notifier->parent = NULL;
 }
 
-/* See if an fwnode can be found in a notifier's lists. */
-static bool __v4l2_async_notifier_fwnode_has_async_subdev(
-	struct v4l2_async_notifier *notifier, struct fwnode_handle *fwnode)
+/* See if an async sub-device can be found in a notifier's lists. */
+static bool __v4l2_async_notifier_has_async_subdev(
+	struct v4l2_async_notifier *notifier, struct v4l2_async_subdev *asd)
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
 
@@ -338,32 +356,28 @@ static bool __v4l2_async_notifier_fwnode_has_async_subdev(
 }
 
 /*
- * Find out whether an async sub-device was set up for an fwnode already or
+ * Find out whether an async sub-device was set up already or
  * whether it exists in a given notifier before @this_index.
  */
-static bool v4l2_async_notifier_fwnode_has_async_subdev(
-	struct v4l2_async_notifier *notifier, struct fwnode_handle *fwnode,
+static bool v4l2_async_notifier_has_async_subdev(
+	struct v4l2_async_notifier *notifier, struct v4l2_async_subdev *asd,
 	unsigned int this_index)
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
@@ -392,12 +406,11 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
 		case V4L2_ASYNC_MATCH_CUSTOM:
 		case V4L2_ASYNC_MATCH_DEVNAME:
 		case V4L2_ASYNC_MATCH_I2C:
-			break;
 		case V4L2_ASYNC_MATCH_FWNODE:
-			if (v4l2_async_notifier_fwnode_has_async_subdev(
-				    notifier, asd->match.fwnode, i)) {
+			if (v4l2_async_notifier_has_async_subdev(
+				    notifier, asd, i)) {
 				dev_err(dev,
-					"fwnode has already been registered or in notifier's subdev list\n");
+					"asd has already been registered or in notifier's subdev list\n");
 				ret = -EEXIST;
 				goto err_unlock;
 			}
-- 
2.7.4

