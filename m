Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4D7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA21214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="gpaKs4LN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA21214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeIYLez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 07:34:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37486 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIYLey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 07:34:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id x26-v6so344030pfn.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 22:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/HACrf5Tu+AFLWvxevDv+YUccBR9VUVbHvWi9W3Q3SM=;
        b=gpaKs4LNszn8QpXlnjCc5yWklx8T3hPaht9QCCjOA+xpIyiT1S2pGMBhuJC8heVGYi
         jocJN4J2JgO89oDVGn4MK6hJbQi4zJk1z8WOoMqLgPlp1bwMjnQlOMCN/XGY80cGaXiE
         f7wWJsYiM0cZeaMfCR/EjiYdn5D/KL91vL3VRkyeRXM33z0rs4ttxkx3/X5wjKOMqAUT
         U1lLA1W2nKixm1QO+GcO26fqraWkWI6tEKG9GQsTvwphHTaV6VBgzKFQc2ABUb0GOeXN
         pS3xE6WUROR66XHOOdy188Yh1qa1rXAUb/BqTzVavT6IUs0xmbSI20yLU9Y9V5/vV3f8
         bd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/HACrf5Tu+AFLWvxevDv+YUccBR9VUVbHvWi9W3Q3SM=;
        b=O9//LiyM/yMTM76xi//qdSxsZ4lkXWhzh/hvetHQ4Jgbmjdh0STv2Mp+Rzh/Dc6T9b
         Ht4uYKIIaHbNJEzzsm8ZtFZkZixM8dAT/Wu2NCdKd1ZrBXcN1j/Vg03yv23Vaojolr8y
         A4bnNXBhENZTV5UOocsJKEebvYurZhk/Xq61YVl3SzVz3iMFy4dEW6DWmOKUXrycNJVV
         /kFra+4+sbW8lhi2Y4fu7FzQL3jbEw4kKgX/WX1YZQFkf5etsSGghjiIksb/8NgbYnpK
         7bYD6/FM54DsXWSWRROZqK2X99tR/SdQ7sN9NnDVlcuPtE6qkObsBVEvFC0wFYAZiE2e
         OMlA==
X-Gm-Message-State: ABuFfojJNiaKf8rlZDUgG8ISLXppnInqkpkmWm2o2wlaAhMIdmwMz+t7
        xnZ7kcNiomUVwaFqc4Gfmv+aeg==
X-Google-Smtp-Source: ACcGV60JJN5BVGzIaoviR87xqtck6podswy3+huiwbF6apqJSF6+Cl4AQ3DjiE6IA8voFAi6+h+uDw==
X-Received: by 2002:a17:902:a5cc:: with SMTP id t12-v6mr1800725plq.229.1537853346403;
        Mon, 24 Sep 2018 22:29:06 -0700 (PDT)
Received: from mercury.CELSYSJYN.IN ([182.72.92.62])
        by smtp.gmail.com with ESMTPSA id d12-v6sm1222840pfn.118.2018.09.24.22.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Sep 2018 22:29:05 -0700 (PDT)
From:   Silesh C V <svellattu@mvista.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Silesh C V <svellattu@mvista.com>
Subject: [PATCH v2 1/2] Driver core: add bus_find_device_by_fwnode
Date:   Tue, 25 Sep 2018 10:58:47 +0530
Message-Id: <1537853328-1282-1-git-send-email-svellattu@mvista.com>
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

