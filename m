Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B756C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272F42077B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUIZ+x4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272F42077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbeHOB1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:27:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44093 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732605AbeHOB1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:27:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so9875269pff.11;
        Tue, 14 Aug 2018 15:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wcQbr2j1pyJOpkmzIkNsSWFBmaSgDunCscn2W3Awp2U=;
        b=LUIZ+x4Ng06fZ9iowh6nM/cFI2mO50QTbS3Y5CYvVdnMbsTS0zn5TugBy/wqf4y6hR
         hsqh6d78znvNJaewVNRJX4r2osL4q95M/RKB5369g3pkFGyITSaaPImELCaqnlEP2d6N
         mdbq82Sbe/S0u3mIluQ44+Jfb8FvCbt9B/EDNHuRegxTdi8a8LFnESIzj4pJ+w/HnbyI
         GjD0G7yPrAAThE8shXj9YLx2Z9w16405TRc/5veW5sL18s3PFot0oYL/mz05yeRO1KAR
         X59mAZKPHD11HDcBo1UwhXp312Ey576jATRcWCNfhilymZIXgFTuavq1IDo5fBxdy9k+
         yI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wcQbr2j1pyJOpkmzIkNsSWFBmaSgDunCscn2W3Awp2U=;
        b=IKb4pcn/JiFO/Jvi70a4pXYcC3Lvix/LYL292GNL/RlnlDOZZmT6nl3GKTyxQQYO2m
         /QN2IITZNCB90R6/aJMMtL/OuFStvO40TUCvKf9RfgVV1HAln+a+UMn0vrwWnBE1k4gE
         9m0GRBDnFoIoRBUFuBiuXCDviovYck6CbZJDyO5qa+2FzNDHdbAiywzkPc4wQJ+Fzilf
         ToHv/uncjEJn5r5HiHbMs4VItF/IWX2qAaOq3nnWD1zBhujQ10ib2PCpvfBAU+Obc7VJ
         6Qx5C/BD4BMjdeuXokZz5MRL3sb9zQEn+yOoozP0YWpIkLmMmgFVT1B2lPwcZcwVC2S7
         wY9w==
X-Gm-Message-State: AOUpUlHHEye2gfeorobatJ/x9CDWmf9zGD+ikryo1qmmzSvb/tHpWfA6
        GTqxW32tiyBi6f8JSxbdjCs=
X-Google-Smtp-Source: AA+uWPxOzmMYW6G7+DE7BYuI5XpZ8O2X6hUDHFcWiSQ2yq6AgZdsB5rp+5vtznXyPwzCTclqDFAMVg==
X-Received: by 2002:a63:fa18:: with SMTP id y24-v6mr23040491pgh.362.1534286309834;
        Tue, 14 Aug 2018 15:38:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id e126-v6sm48420948pfg.31.2018.08.14.15.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 15:38:28 -0700 (PDT)
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
Subject: [RFC PATCH v1 3/3] firmware: vpd: add MAC address parser
Date:   Tue, 14 Aug 2018 15:37:58 -0700
Message-Id: <20180814223758.117433-4-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180814223758.117433-1-briannorris@chromium.org>
References: <20180814223758.117433-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device trees can now specify their MAC address via something like:

	mac-address-lookup = "vpd:wifi_mac0";

instead of requiring boot firmware to parse and splice the FDT itself.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/firmware/google/vpd.c | 67 +++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index e9db895916c3..b2b08497db32 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/ctype.h>
+#include <linux/if_ether.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -24,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
@@ -173,6 +175,36 @@ static ssize_t vpd_section_read(struct file *filp, struct kobject *kobp,
 				       sec->bin_attr.size);
 }
 
+static const char *__vpd_get_entry(struct vpd_section *sec, const char *key)
+{
+	struct vpd_attrib_info *info;
+
+	list_for_each_entry(info, &sec->attribs, list)
+		if (!strcmp(info->key, key))
+			return info->value;
+
+	return NULL;
+}
+
+static const char *vpd_get_entry(const char *key)
+{
+	const char *value;
+
+	if (rw_vpd.enabled) {
+		value = __vpd_get_entry(&rw_vpd, key);
+		if (value)
+			return value;
+	}
+
+	if (ro_vpd.enabled) {
+		value = __vpd_get_entry(&ro_vpd, key);
+		if (value)
+			return value;
+	}
+
+	return NULL;
+}
+
 static int vpd_section_create_attribs(struct vpd_section *sec)
 {
 	s32 consumed;
@@ -286,6 +318,37 @@ static int vpd_sections_init(phys_addr_t physaddr)
 	return 0;
 }
 
+/*
+ * 'key' is typically something like 'wifi_mac0' or 'ether_mac1'. Values are 12
+ * character strings of MAC address digits, in hex.
+ */
+static int vpd_lookup_mac_address(const char *key, u8 *mac)
+{
+	const char *entry;
+	int ret;
+
+	if (!key)
+		return -EINVAL;
+
+	entry = vpd_get_entry(key);
+	if (!entry)
+		return -ENOENT;
+
+	if (strlen(entry) != ETH_ALEN * 2)
+		return -EINVAL;
+
+	ret = hex2bin(mac, entry, ETH_ALEN);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct device_mac_addr_provider vpd_mac_addr_provider = {
+	.prefix		= "google-vpd",
+	.lookup		= &vpd_lookup_mac_address,
+};
+
 static int vpd_probe(struct coreboot_device *dev)
 {
 	int ret;
@@ -300,11 +363,15 @@ static int vpd_probe(struct coreboot_device *dev)
 		return ret;
 	}
 
+	device_register_mac_addr_provider(&vpd_mac_addr_provider);
+
 	return 0;
 }
 
 static int vpd_remove(struct coreboot_device *dev)
 {
+	device_unregister_mac_addr_provider(&vpd_mac_addr_provider);
+
 	vpd_section_destroy(&ro_vpd);
 	vpd_section_destroy(&rw_vpd);
 
-- 
2.18.0.865.gffc8e1a3cd6-goog

