Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDDCC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188D827906
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEYfepux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188D827906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936772AbeF2Svm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:51:42 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36617 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936693AbeF2SvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:51:07 -0400
Received: by mail-pg0-f67.google.com with SMTP id m19-v6so829311pgv.3;
        Fri, 29 Jun 2018 11:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ic20eZHxg3L5VrpDdc6V8swQ3guf//Gp/DGUmWOQ/0=;
        b=XEYfepuxfiqi8dGP0H7s90IQyj5yYc6SmonDSkQDAk5guCz0hHue3z+tYSZb0wF1d/
         oybfhmAJmhjZA0nGKZAprupbGfCfzKFVZ88vN06tTIWkG4um8Jqjqsb6iago74zSrVx4
         CCdshRT6uh5TQjlRCRbEBOTit6wwXdtCDS0KKBxRQsbQLcsf5vgrU/azvrUCD1BZ71AS
         aXoHX9qkWSbRx7HQJd88NybK1J9Q+oadx6DG7m4vJEqIwHXxCXD2KMPH5Brl02LNskY6
         qvKjbJ5FoxZjSzfcqrd3NsF7CeNjJFQ9hpP8ioDKJX4DWW1Strk0x89Q71pk+Z5uoWYr
         9bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ic20eZHxg3L5VrpDdc6V8swQ3guf//Gp/DGUmWOQ/0=;
        b=q458Uien4Q9y85xOYvpA55iska5ShsVyqj+NOz1gu2K7eng6tmyOnC0cX8xQUcS1dS
         tfXTj/jDBAdN70/c11RJu/knELRaoYQ8eoEd8hC8AtGhJ8AIpxEgrnBI0yeIA9q7v1vE
         4TjzDqFtbPE/e7e0eL9ZV54yXh3e3nstobYmUKMrhqegRIeXw9lOs+4a+u7uiURz3R89
         m7Z+7CMvuxIwpHlhfAFyfSiJuSWnpdufrgIfC5J6oBbInt58Npv2GOyg/vkWrBISgUmM
         qoepRyR+kRiZCLGPW7swo/Fu6B1KJ2Pm8FfMHmjuExBYlq8CnFtPwWhqfWxmRsJ93pbv
         FFig==
X-Gm-Message-State: APt69E13gOAs4gz8h0+N+Q92VhouUSxw9aTXNm4FCytMLQkBNEu1X5Z/
        DVFqDuBA7BS7CETsypJGrUPqgQ==
X-Google-Smtp-Source: AAOMgpe1a8iWK4xyRks77op9RBwWycthBoEoEAIhk+VouM661SXqANk8wGMJRdnJTZiIxWx5n3/l6Q==
X-Received: by 2002:a63:4283:: with SMTP id p125-v6mr12663218pga.142.1530298266072;
        Fri, 29 Jun 2018 11:51:06 -0700 (PDT)
Received: from mappy.world.mentorg.com ([2602:306:cc3b:f020:7cd8:9ad7:a375:e853])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm27672308pfg.130.2018.06.29.11.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 11:51:05 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/17] media: v4l2-fwnode: Add a convenience function for registering subdevs with notifiers
Date:   Fri, 29 Jun 2018 11:49:50 -0700
Message-Id: <1530298220-5097-7-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds v4l2_async_register_fwnode_subdev(), which is a convenience function
for parsing a sub-device's fwnode port endpoints for connected remote
sub-devices, registering a sub-device notifier, and then registering
the sub-device itself.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
Changes since v4:
- none
Changes since v3:
- remove support for port sub-devices, such sub-devices will have to
  role their own.
Changes since v2:
- fix error-out path in v4l2_async_register_fwnode_subdev() that forgot
  to put device.
Changes since v1:
- add #include <media/v4l2-subdev.h> to v4l2-fwnode.h for
  'struct v4l2_subdev' declaration.
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 62 +++++++++++++++++++++++++++++++++++
 include/media/v4l2-fwnode.h           | 38 +++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 0f88856..87c70e3 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -870,6 +870,68 @@ int v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd)
 }
 EXPORT_SYMBOL_GPL(v4l2_async_register_subdev_sensor_common);
 
+int v4l2_async_register_fwnode_subdev(
+	struct v4l2_subdev *sd, size_t asd_struct_size,
+	unsigned int *ports, unsigned int num_ports,
+	int (*parse_endpoint)(struct device *dev,
+			      struct v4l2_fwnode_endpoint *vep,
+			      struct v4l2_async_subdev *asd))
+{
+	struct v4l2_async_notifier *notifier;
+	struct device *dev = sd->dev;
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	if (WARN_ON(!dev))
+		return -ENODEV;
+
+	fwnode = dev_fwnode(dev);
+	if (!fwnode_device_is_available(fwnode))
+		return -ENODEV;
+
+	notifier = kzalloc(sizeof(*notifier), GFP_KERNEL);
+	if (!notifier)
+		return -ENOMEM;
+
+	if (!ports) {
+		ret = v4l2_async_notifier_parse_fwnode_endpoints(
+			dev, notifier, asd_struct_size, parse_endpoint);
+		if (ret < 0)
+			goto out_cleanup;
+	} else {
+		unsigned int i;
+
+		for (i = 0; i < num_ports; i++) {
+			ret = v4l2_async_notifier_parse_fwnode_endpoints_by_port(
+				dev, notifier, asd_struct_size,
+				ports[i], parse_endpoint);
+			if (ret < 0)
+				goto out_cleanup;
+		}
+	}
+
+	ret = v4l2_async_subdev_notifier_register(sd, notifier);
+	if (ret < 0)
+		goto out_cleanup;
+
+	ret = v4l2_async_register_subdev(sd);
+	if (ret < 0)
+		goto out_unregister;
+
+	sd->subdev_notifier = notifier;
+
+	return 0;
+
+out_unregister:
+	v4l2_async_notifier_unregister(notifier);
+out_cleanup:
+	v4l2_async_notifier_cleanup(notifier);
+	kfree(notifier);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(v4l2_async_register_fwnode_subdev);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Sakari Ailus <sakari.ailus@linux.intel.com>");
 MODULE_AUTHOR("Sylwester Nawrocki <s.nawrocki@samsung.com>");
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index ea7a8b2..031ebb0 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 
 #include <media/v4l2-mediabus.h>
+#include <media/v4l2-subdev.h>
 
 struct fwnode_handle;
 struct v4l2_async_notifier;
@@ -360,4 +361,41 @@ int v4l2_async_notifier_parse_fwnode_endpoints_by_port(
 int v4l2_async_notifier_parse_fwnode_sensor_common(
 	struct device *dev, struct v4l2_async_notifier *notifier);
 
+/**
+ * v4l2_async_register_fwnode_subdev - registers a sub-device to the
+ *					asynchronous sub-device framework
+ *					and parses fwnode endpoints
+ *
+ * @sd: pointer to struct &v4l2_subdev
+ * @asd_struct_size: size of the driver's async sub-device struct, including
+ *		     sizeof(struct v4l2_async_subdev). The &struct
+ *		     v4l2_async_subdev shall be the first member of
+ *		     the driver's async sub-device struct, i.e. both
+ *		     begin at the same memory address.
+ * @ports: array of port id's to parse for fwnode endpoints. If NULL, will
+ *	   parse all ports owned by the sub-device.
+ * @num_ports: number of ports in @ports array. Ignored if @ports is NULL.
+ * @parse_endpoint: Driver's callback function called on each V4L2 fwnode
+ *		    endpoint. Optional.
+ *
+ * This function is just like v4l2_async_register_subdev() with the
+ * exception that calling it will also allocate a notifier for the
+ * sub-device, parse the sub-device's firmware node endpoints using
+ * v4l2_async_notifier_parse_fwnode_endpoints() or
+ * v4l2_async_notifier_parse_fwnode_endpoints_by_port(), and
+ * registers the sub-device notifier. The sub-device is similarly
+ * unregistered by calling v4l2_async_unregister_subdev().
+ *
+ * While registered, the subdev module is marked as in-use.
+ *
+ * An error is returned if the module is no longer loaded on any attempts
+ * to register it.
+ */
+int v4l2_async_register_fwnode_subdev(
+	struct v4l2_subdev *sd, size_t asd_struct_size,
+	unsigned int *ports, unsigned int num_ports,
+	int (*parse_endpoint)(struct device *dev,
+			      struct v4l2_fwnode_endpoint *vep,
+			      struct v4l2_async_subdev *asd));
+
 #endif /* _V4L2_FWNODE_H */
-- 
2.7.4

