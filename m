Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ED1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6241820C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="YPBUg3ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6241820C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeIXKg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 06:36:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46040 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeIXKg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 06:36:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id j8-v6so8532729pll.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 21:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/HACrf5Tu+AFLWvxevDv+YUccBR9VUVbHvWi9W3Q3SM=;
        b=YPBUg3ca8xtoi0h1eE8c6fzRdSFu6zsT6GFUkG6iO6ieUEXrYRlaIDEUJitaeVvvxF
         z3tyH6xj3P/DjOC1h+gLIqAV4Z8R4RGS09P2wV+V2NgL60E8lqfouTmsbfncQvFDXWh8
         i7YvqTvvqYtSiSYJx33BNHOsGU3oGdihGdtYtGtAc4Kldq/IZer224ipKbwIsXDFutYG
         CVIcuUISReFkAfiWfwJfHxHGYqrKkfnznayxX9Ym1GmEJpK10Xst+pzfdeI2+Do4wHZQ
         D4KKxm6VqkImXbK9o2mzCA1KC2UhJTpEqMxy50DdHkxYmVy6+0+ZNhgV5ERbed+7HGIe
         icnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/HACrf5Tu+AFLWvxevDv+YUccBR9VUVbHvWi9W3Q3SM=;
        b=eM0s/CEdqQAaCFtNTRLu8ky1cmlrFkyvSdEIHr5/1uWs6TZfWY8oKfbHp2GvhC+naB
         ozRHDEMbpxiEKQ1nB0spK+8FhszPVOKN+axI3lhvcziU0JqLw1LRZfkwzLykA2+iqBj0
         qt9ax30z92mGfIaWpMUxx/puk/nR9FkrfCj1BoWoE4FrU7ErKDcswb7oVfLLtc1KrMAO
         FkOtZrd0c2D/opiFwf1qldBfaKuxh24wqEYbFdrkUfHUMXVoZbWfAvX5srzyxS9aRKKt
         xNZP/hjJgxw3fCvTEd60kajZo5IhqE5WgTfMwqHjdMyfJaAVNFfYRr9hfsn7uLC/w9sT
         rsPQ==
X-Gm-Message-State: ABuFfojNb7jaIxw9oDFkvEEHV3JWf2Q2vTYBoQGnXtxoG5TE9rq31Spf
        UjZRHdH6UHmus2MoPy1WMlO72A==
X-Google-Smtp-Source: ACcGV61bgClgG0RoAM1KGI0mgmKz6/4VypR1SOi8wi4plaqh1/tnxAhoag1B72a+PRl959MnRwx9EQ==
X-Received: by 2002:a17:902:710e:: with SMTP id a14-v6mr4660629pll.179.1537763777253;
        Sun, 23 Sep 2018 21:36:17 -0700 (PDT)
Received: from mercury.CELSYSJYN.IN ([182.72.92.62])
        by smtp.gmail.com with ESMTPSA id d81-v6sm53071725pfj.122.2018.09.23.21.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Sep 2018 21:36:16 -0700 (PDT)
From:   Silesh C V <svellattu@mvista.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Silesh C V <svellattu@mvista.com>
Subject: [PATCH] Driver core: add bus_find_device_by_fwnode
Date:   Mon, 24 Sep 2018 10:05:55 +0530
Message-Id: <1537763755-28871-1-git-send-email-svellattu@mvista.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers need to find the device on a bus having a specific firmware
node. Currently, such drivers have their own implementations to do this.
Provide a helper similar to bus_find_device_by_name so that each driver
does not have to reinvent this.

Signed-off-by: Silesh C V <svellattu@mvista.com>
---
 drivers/base/bus.c     | 26 ++++++++++++++++++++++++++
 include/linux/device.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8bfd27e..148b198 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -17,6 +17,7 @@
 #include <linux/string.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/of.h>
 #include "base.h"
 #include "power/power.h"
 
@@ -373,6 +374,31 @@ struct device *bus_find_device_by_name(struct bus_type *bus,
 }
 EXPORT_SYMBOL_GPL(bus_find_device_by_name);
 
+static int match_fwnode(struct device *dev, void *data)
+{
+	struct fwnode_handle *fwnode = data;
+	struct device_node *of_node = to_of_node(fwnode);
+
+	if (of_node)
+		return dev->of_node == of_node;
+	else
+		return dev->fwnode == fwnode;
+}
+
+/**
+ * bus_find_device_by_fwnode - device iterator for locating a particular device
+ * having a specific firmware node
+ * @bus: bus type
+ * @start: Device to begin with
+ * @fwnode: firmware node of the device to match
+ */
+struct device *bus_find_device_by_fwnode(struct bus_type *bus, struct device *start,
+					struct fwnode_handle *fwnode)
+{
+	return bus_find_device(bus, start, (void *)fwnode, match_fwnode);
+}
+EXPORT_SYMBOL_GPL(bus_find_device_by_fwnode);
+
 /**
  * subsys_find_device_by_id - find a device with a specific enumeration number
  * @subsys: subsystem
diff --git a/include/linux/device.h b/include/linux/device.h
index 8f88254..09384f6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -171,6 +171,9 @@ struct device *bus_find_device(struct bus_type *bus, struct device *start,
 struct device *bus_find_device_by_name(struct bus_type *bus,
 				       struct device *start,
 				       const char *name);
+struct device *bus_find_device_by_fwnode(struct bus_type *bus,
+				       struct device *start,
+				       struct fwnode_handle *fwnode);
 struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
 					struct device *hint);
 int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-- 
1.9.1

