Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5661DECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A49E21524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="VD/aUHnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A49E21524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbeITLZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 07:25:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42652 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeITLZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 07:25:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so3808668pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 22:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=D7R5hUr6xmnDBObQlftAmR2IkyyQ2aIA4501KIvIX88=;
        b=VD/aUHnAHREUF+GALnvc3WWUU3zIALRnHdX8ZnCjzoFmGRhM7g7xp1Xl2KITmyC8Hz
         q8tncWOgXOHrFfNPjQK2mdukoMfevUzXzxmYPXFCAu+aLdBjAmzGkLOawbOQDyJCb7Cw
         BDjz/Xu5Jozgt2D172kRNMd2Ffg5+EHDn2iRa7Q6G+LYe0eIAkWr1XYfCdyGpYC1qLI4
         gmI3o6KNI63GCpov6WZzJvmrqSEhstn1/VBEO0OuKAm5yvCokEXHdS7uTnKqbtZ8upa+
         RHBFqjUwMqLXBZVNwAQB5nPBv1EL/emK/WcrzC/EiwtzzGRFGircZgEonAAFAdQsALRW
         oAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D7R5hUr6xmnDBObQlftAmR2IkyyQ2aIA4501KIvIX88=;
        b=rhBOP2Q6LCnKvXgwXTIyJk4Gw9n+Y+2nXjSorI5nGp77/SezwkJ8Qyq9hHn+/SuNWO
         s/q/ginSGnLfYN13LFkj31crpIROddQlDSInqHl0YpVjYJlGr9Vle2GwyRvm9vq+sT48
         LiYz4aFtWUCZ6FuHDzh4bcbrQH/whuZbPtsetewuvk8N4iYktj9+UHRgVK4vFPr22SOj
         IFtbl1+e260j/PGoDf9p2lCCGutNr1KnQ8AiLcdC5WsPjyuSELYYjaclTElbc+31SLpF
         1HvR7JnVkv7sLsUo8idjFBAo/tPQjdgSJa1XQabUPuqm0oiqC4yHXIAgXDp9V4b5NRtv
         xvEw==
X-Gm-Message-State: APzg51D8tz7qA+jJGzPB+As6m04hyIrDsYdtYIPe73KVuP5FvC4LimJF
        Ltapi5J32P8Gur4iA0TARL5J5A==
X-Google-Smtp-Source: ANB0VdbarV27k8PJJl65Tlq6e31uuT3s/2+Hn3BaHH7ZrYKmIkkvlrAseheADXRQ9pAIr00P95p3nw==
X-Received: by 2002:a62:7e93:: with SMTP id z141-v6mr39598133pfc.14.1537422208631;
        Wed, 19 Sep 2018 22:43:28 -0700 (PDT)
Received: from mercury.CELSYSJYN.IN ([182.72.92.62])
        by smtp.gmail.com with ESMTPSA id i76-v6sm2582669pgc.20.2018.09.19.22.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 22:43:27 -0700 (PDT)
From:   Silesh C V <svellattu@mvista.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Silesh C V <svellattu@mvista.com>
Subject: [PATCH] Driver core: add bus_find_device_by_of_node
Date:   Thu, 20 Sep 2018 11:12:02 +0530
Message-Id: <1537422122-6166-1-git-send-email-svellattu@mvista.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to bus_find_device_by_name, but finds the device having a
specific of_node.

Signed-off-by: Silesh C V <svellattu@mvista.com>
---
 drivers/base/bus.c     | 21 +++++++++++++++++++++
 include/linux/device.h |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8bfd27e..39f90d1 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -373,6 +373,27 @@ struct device *bus_find_device_by_name(struct bus_type *bus,
 }
 EXPORT_SYMBOL_GPL(bus_find_device_by_name);
 
+static int match_of_node(struct device *dev, void *data)
+{
+	struct device_node *node = data;
+
+	return dev->of_node == node;
+}
+
+/**
+ * bus_find_device_by_name - device iterator for locating a particular device
+ * having a specific device node
+ * @bus: bus type
+ * @start: Device to begin with
+ * @node: device node pointer
+ */
+struct device *bus_find_device_by_of_node(struct bus_type *bus,
+					struct device *start, struct device_node *node)
+{
+	return bus_find_device(bus, start, (void *)node, match_of_node);
+}
+EXPORT_SYMBOL_GPL(bus_find_device_by_of_node);
+
 /**
  * subsys_find_device_by_id - find a device with a specific enumeration number
  * @subsys: subsystem
diff --git a/include/linux/device.h b/include/linux/device.h
index 055a69d..49006fd 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -171,6 +171,9 @@ struct device *bus_find_device(struct bus_type *bus, struct device *start,
 struct device *bus_find_device_by_name(struct bus_type *bus,
 				       struct device *start,
 				       const char *name);
+struct device *bus_find_device_by_of_node(struct bus_type *bus,
+				       struct device *start,
+				       struct device_node *node);
 struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
 					struct device *hint);
 int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-- 
1.9.1

