Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49FEC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0362086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f52wHrnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0362086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933551AbeGIWnU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:43:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43695 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933366AbeGIWjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:39:49 -0400
Received: by mail-pl0-f66.google.com with SMTP id c41-v6so6676574plj.10;
        Mon, 09 Jul 2018 15:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BIANBOKIcM4Z6TFCxF75PNT2QA6gGdem8dAtDbyykl0=;
        b=f52wHrnunWfV1l1+FEOAo7++Fe/wMttYVpn6Abn70ElvtF7qpxfbkJ34E7P6OcXnim
         p7s6SYSl+M6SYDpmTqA+Xmr/fU4/5XHc+E18xtimRjaRf54b89Re6gFkRR9gbJXY3bbE
         h1n056Aby81ONTNnb4fuyBCZz5zpV0Zpu91fk3hjCTJKwNngtiAlRzOipj0hL9FhEetW
         JJTLfIO/C0FtFupfetYX6M/92///hNzXjQ3d0ePoZDZsysJCH2xYKLjnQp1VEScfWVqy
         QsKEf5PutSoj68zuRq4TPf/jaG6dQ7oWGuTAlxcuJzQ1NeT9jP1n7YPOhJHZBzNuWLqU
         01Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BIANBOKIcM4Z6TFCxF75PNT2QA6gGdem8dAtDbyykl0=;
        b=dBkpLV2b9wgx1pgSwbI78gfV2BMSqsi5IUFBbxNhcXw7upBhUimLr2iPEnP3HwHm3X
         J5ZxUIHmG2tcxHpz++O+7sFPMz25o+AhOuEhXE1ogo3stjo0h45cmdZVHSWAmOCib9Wl
         zTIKHAXF91sbJAPcuYrkKBGlY0LWCkArX26BbtI84unzmuneUcH3IY6iBw4bxVeYpwGc
         Ij5CR+nW5bUO+pLFtmR/HEB/dTxfMR9u/2m2iTzPMhHJQ3RQsTNcQsJTqtAvohM2F2fL
         M2f5YAA+fNTse4tOAeNM9Jhw52baOY9ktQB/8Nzwh6D4eg2WEdIQ2hPqF0JIq042izsR
         H4NA==
X-Gm-Message-State: APt69E3vTu2SnZ45vprIVqBYG3C8/sK+aEjQ1+kXNmErVV9nhtnaLiAT
        70sY2Ea4JPIohPkDkzVUkvycfg==
X-Google-Smtp-Source: AAOMgpfzTVTjX4R0hH0H0IzEqXvE+2EVBasl/rnIkgS7eKjUwWAYu+gkb2L13FcSyjE3Nqwqh+wW2A==
X-Received: by 2002:a17:902:7e43:: with SMTP id a3-v6mr22036172pln.151.1531175987947;
        Mon, 09 Jul 2018 15:39:47 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm30143804pfe.173.2018.07.09.15.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 15:39:47 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 06/17] media: v4l2-fwnode: Add a convenience function for registering subdevs with notifiers
Date:   Mon,  9 Jul 2018 15:39:06 -0700
Message-Id: <1531175957-1973-7-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
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
Changes since v5:
- add call to v4l2_async_notifier_init().
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
 drivers/media/v4l2-core/v4l2-fwnode.c | 64 +++++++++++++++++++++++++++++++++++
 include/media/v4l2-fwnode.h           | 38 +++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 67ad333..94d867a 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -872,6 +872,70 @@ int v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd)
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
+	v4l2_async_notifier_init(notifier);
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

