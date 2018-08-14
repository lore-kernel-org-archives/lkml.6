Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EB4C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3636321725
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHFb8C4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3636321725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbeHOB1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:27:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36285 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732444AbeHOB1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:27:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so9886038pfo.3;
        Tue, 14 Aug 2018 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1S3Q2HduRfgv16zyLwtzecCilYYeGDNY+o6QuvkJX4s=;
        b=QHFb8C4vevmx6fPUoAyBRI4FrK9DXpK875J2C94qZbXDd4I2EbkyM9SMmjxNMttOnx
         dodAzsGoBx3DY3StiMBX2/cfvQSYah2P/6MZYtFFYJ0ScB+1NBZvPa172LGTPDc+ITEf
         +ScaEnrvZ8ZQBQS3rFK/Cx/FGB5nl8eZyUnV+asNYVz89xj3V63Mf3hJdRY6LgYTc9dW
         5IgEjXNL08P+SMoUlmT8eScNf0shNoOm1IJeI5wwT5bB4VfYdRxGWrlcyOHphgJNJXGB
         LtADp25a3SV7d3xhiSGbx2Ie7FnAyJaScxZQDzIBKQiNZBrj2NZMvrT9HNprvjJCAmmt
         b7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1S3Q2HduRfgv16zyLwtzecCilYYeGDNY+o6QuvkJX4s=;
        b=kLrv9vx0bB3yfwKWS3/aNnobv5cX52ZcqPe8oHKKf5AJadbqlDaIg0KWxnu/eCme+3
         c8JkUQYRnY8gwRXrqQm/h4ZMicw5J4jSZwXX9ggZ4xa63dotQJurtEACC00Ke8rKPEd8
         Mo2jfBJ57jGiRk8JZliv5OfVxxu2uoMxwMjE4v9bV2OK9Hj8O1uSeGoeWjbrGp5A9lKH
         iTaVq1JYLqGGQYUBRI/QyYFMxA/wJMa39fekUTD+4bLUCGFznXa3IVgyfRCDJHzUyb9/
         Ka3QAX9SKJmM/2lQCDNeJdDpaTExi7TvoKV1HhVf+n6Q6GiRrLTisIOuaLtUdz2M/8w6
         rnRg==
X-Gm-Message-State: AOUpUlEyf/XfJQPvXgT4tH44QxB0md5UwSlSrYdmeukAx8zx2/5kncmW
        ppawlgVk3eQdoRoCAMYvHVA=
X-Google-Smtp-Source: AA+uWPyNX/dXbFi0dVSDKZRiXjBozvAy3M2NEqSf1lprGR6PPwF/jZZkBhQ6iBsyoC8B1Rty7ODbng==
X-Received: by 2002:a63:1c13:: with SMTP id c19-v6mr22898720pgc.332.1534286308205;
        Tue, 14 Aug 2018 15:38:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id e126-v6sm48420948pfg.31.2018.08.14.15.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 15:38:26 -0700 (PDT)
From:   Brian Norris <computersforpeace@gmail.com>
X-Google-Original-From: Brian Norris <briannorris@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [RFC PATCH v1 2/3] device property: Support complex MAC address lookup
Date:   Tue, 14 Aug 2018 15:37:57 -0700
Message-Id: <20180814223758.117433-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180814223758.117433-1-briannorris@chromium.org>
References: <20180814223758.117433-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some firmwares include data tables that can be used to derive a MAC
address for devices on the system, but those firmwares don't directly
stash the MAC address in a device property. Support having other drivers
register lookup functions, where the device property contains
"<format>:<key>" strings; a lookup driver can register support for
handling "<format>", and "<key>" can be used by the format parser to
identify which MAC address is being requested.

This is particularly useful for the Google Vital Product Data (VPD)
format [1], which holds various product-specific key/value pairs, often
stashed in the boot flash.

[1] Ref:
https://chromium.googlesource.com/chromiumos/platform/vpd/+/master/README.md

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/base/property.c  | 83 +++++++++++++++++++++++++++++++++++++++-
 include/linux/property.h | 23 +++++++++++
 2 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 240ab5230ff6..fae3390fc56c 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_graph.h>
@@ -1264,6 +1265,78 @@ static void *fwnode_get_mac_addr(struct fwnode_handle *fwnode,
 	return NULL;
 }
 
+static LIST_HEAD(mac_addr_providers);
+static DEFINE_MUTEX(mac_addr_providers_mutex);
+
+void device_register_mac_addr_provider(struct device_mac_addr_provider *prov)
+{
+	mutex_lock(&mac_addr_providers_mutex);
+	list_add(&prov->entry, &mac_addr_providers);
+	mutex_unlock(&mac_addr_providers_mutex);
+}
+EXPORT_SYMBOL(device_register_mac_addr_provider);
+
+void device_unregister_mac_addr_provider(struct device_mac_addr_provider *prov)
+{
+	struct device_mac_addr_provider *p;
+
+	mutex_lock(&mac_addr_providers_mutex);
+	list_for_each_entry(p, &mac_addr_providers, entry) {
+		if (p == prov) {
+			list_del(&p->entry);
+			goto out;
+		}
+	}
+
+out:
+	mutex_unlock(&mac_addr_providers_mutex);
+}
+EXPORT_SYMBOL(device_unregister_mac_addr_provider);
+
+static void *fwnode_lookup_mac_addr(struct fwnode_handle *fwnode,
+				    char *addr, int alen)
+{
+	struct device_mac_addr_provider *prov;
+	const char *prop, *sep;
+	u8 mac[ETH_ALEN];
+	int ret;
+
+	ret = fwnode_property_read_string(fwnode, "mac-address-lookup", &prop);
+	if (ret)
+		return NULL;
+
+	sep = strchr(prop, ':');
+	if (!sep)
+		return NULL;
+
+	if (alen != ETH_ALEN)
+		return NULL;
+
+	mutex_lock(&mac_addr_providers_mutex);
+	list_for_each_entry(prov, &mac_addr_providers, entry) {
+		if (strncmp(prov->prefix, prop, strlen(prov->prefix)))
+			continue;
+
+		if (prop + strlen(prov->prefix) != sep)
+			continue;
+
+		ret = prov->lookup(sep + 1, mac);
+		if (ret)
+			continue;
+
+		if (!is_valid_ether_addr(mac))
+			continue;
+
+		ether_addr_copy(addr, mac);
+
+		mutex_unlock(&mac_addr_providers_mutex);
+		return addr;
+	}
+	mutex_unlock(&mac_addr_providers_mutex);
+
+	return NULL;
+}
+
 /**
  * fwnode_get_mac_address - Get the MAC from the firmware node
  * @fwnode:	Pointer to the firmware node
@@ -1274,7 +1347,9 @@ static void *fwnode_get_mac_addr(struct fwnode_handle *fwnode,
  * checked first, because that is supposed to contain to "most recent" MAC
  * address. If that isn't set, then 'local-mac-address' is checked next,
  * because that is the default address.  If that isn't set, then the obsolete
- * 'address' is checked, just in case we're using an old device tree.
+ * 'address' is checked, just in case we're using an old device tree.  And
+ * finally, we check for a method of indirect MAC address lookup, via
+ * 'mac-address-lookup'.
  *
  * Note that the 'address' property is supposed to contain a virtual address of
  * the register set, but some DTS files have redefined that property to be the
@@ -1299,7 +1374,11 @@ void *fwnode_get_mac_address(struct fwnode_handle *fwnode, char *addr, int alen)
 	if (res)
 		return res;
 
-	return fwnode_get_mac_addr(fwnode, "address", addr, alen);
+	res = fwnode_get_mac_addr(fwnode, "address", addr, alen);
+	if (res)
+		return res;
+
+	return fwnode_lookup_mac_addr(fwnode, addr, alen);
 }
 EXPORT_SYMBOL(fwnode_get_mac_address);
 
diff --git a/include/linux/property.h b/include/linux/property.h
index ac8a1ebc4c1b..aca5dbb51e19 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -14,6 +14,7 @@
 #define _LINUX_PROPERTY_H_
 
 #include <linux/fwnode.h>
+#include <linux/list.h>
 #include <linux/types.h>
 
 struct device;
@@ -285,6 +286,28 @@ const void *device_get_match_data(struct device *dev);
 
 int device_get_phy_mode(struct device *dev);
 
+/**
+ * struct device_mac_addr_provider - MAC address provider
+ *
+ * Provide methods by which the rest of the kernel can retrieve MAC addresses,
+ * e.g., from a firmware table.
+ *
+ * @entry: list head, for keeping track of all providers
+ * @prefix: string which uniquely identifies the provider
+ * @lookup: Look up a MAC address by key. The provider may associate this @key
+ *	with a stored MAC address; if a match is found, the provider copies the
+ *	associated MAC address to @mac. If not found, a non-zero error code is
+ *	returned.
+ */
+struct device_mac_addr_provider {
+	struct list_head entry;
+	const char *prefix;
+	int (*lookup)(const char *key, u8 *mac);
+};
+
+void device_register_mac_addr_provider(struct device_mac_addr_provider *prov);
+void device_unregister_mac_addr_provider(struct device_mac_addr_provider *prov);
+
 void *device_get_mac_address(struct device *dev, char *addr, int alen);
 
 int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
-- 
2.18.0.865.gffc8e1a3cd6-goog

