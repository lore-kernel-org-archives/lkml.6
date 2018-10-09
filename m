Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F35DC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91921214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="kqqN+8V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91921214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJIRe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:34:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46295 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeJIReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:34:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so590814pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 03:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=I+XobssBceHNES2QCYGPphH3TI/xahn3VphKv1PaJ08=;
        b=kqqN+8V5DmD2G67Qmj/ItzHVG5l/lMtKvreNGNnhVmjNFMrH/8lFPPVTZVQHumLAle
         yiyB4rLkx1ZFnkw4xmCYB2xSWWBQ+6VEbUmarj0CY1gkHPgiKSlLfj24+eSKXPpucB3w
         YBCEa4/7ts8ETb4YzB3ik5U93Jpz4AM0D51MnJp47tV7kXigAymIvH8ZkmL8xokx8Gjq
         GcW8d8WSYBRqI47W6WoKAspcZsrzDq/Fj0vocE1jU9bL+uo9n1EeTRqnugID6CdH2phw
         VuJTWFklzW44F06kptF+tuiuom4g9wnulGGik0AOBEtUcSswNRvdFlvTOF/XXtPpX6Wr
         syJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I+XobssBceHNES2QCYGPphH3TI/xahn3VphKv1PaJ08=;
        b=rAJ7/sA9KILpvPIu575qkLo82uc4QITWyYRlBnbljoZG4XxLXgY8GnAiVYQnxerDY9
         /wnYXatHqnRyOsxnWuMh+6gZooLvoPgZYm7KojygJan6yc2FrZb/EvtgpuGVTqeWCZZW
         wy5snxwv05k8XLmnM8obudDCQuw3/76Ho0Xe1r14c7/w0MB2QLOpeM5OeIfy3dOpSx6p
         BJkBUzsCE0xV3/043EUxSENdGrjvOplLeFyRU6F1DSEGiANqzzLbLgOToHkMRtpXskvd
         jUfjJNoiZZPuqp9C556zhndsdVKMwhTUUVP1yXgYe+mxV3q0VDt/aUENAGv704t21VRA
         xWiA==
X-Gm-Message-State: ABuFfoh08cMqo7a+DGXRRHTeZPQDW7lm5BLYaRu+i9oEXtkSr+ZP7Hwq
        Xn+Kf24/mNZ26wApIUZRiUXbFA==
X-Google-Smtp-Source: ACcGV63Ukdhiqw99pzLpMjNdhRt6pVH4F3QBYuG446+Z66ZuYOBSZwdkDWMW+uEblZC6esUrxjcveQ==
X-Received: by 2002:a62:20d8:: with SMTP id m85-v6mr29277521pfj.152.1539080292835;
        Tue, 09 Oct 2018 03:18:12 -0700 (PDT)
Received: from mercury.mvista.com ([182.72.92.62])
        by smtp.gmail.com with ESMTPSA id z22-v6sm20854472pgv.24.2018.10.09.03.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 03:18:11 -0700 (PDT)
From:   Silesh C V <svellattu@mvista.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Silesh C V <svellattu@mvista.com>
Subject: [PATCH v3 1/2] Driver core: add bus_find_device_by_fwnode
Date:   Tue,  9 Oct 2018 15:47:24 +0530
Message-Id: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
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
Changes since v2: 
	- make use of dev_fwnode in match_fwnode.

 drivers/base/bus.c     | 20 ++++++++++++++++++++
 include/linux/device.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8bfd27e..a2f39db 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -17,6 +17,7 @@
 #include <linux/string.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/property.h>
 #include "base.h"
 #include "power/power.h"
 
@@ -373,6 +374,25 @@ struct device *bus_find_device_by_name(struct bus_type *bus,
 }
 EXPORT_SYMBOL_GPL(bus_find_device_by_name);
 
+static int match_fwnode(struct device *dev, void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode;
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

