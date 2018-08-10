Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0ECC46470
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A591C21DEC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Gcf8YA17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A591C21DEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeHJPrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:47:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35459 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbeHJPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:47:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so1900517wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g7DsJGBEEB/Beb5kYu8dgD1IWPiGck1texLkmOUNaYg=;
        b=Gcf8YA17QiBVYn8JFkfBZA5Zz5qxF+iI8sAiJ+nNkTYJJrXk3+9eSMGSztPrz+zMCt
         ux8nixnmSuoQQM7qDQWaA0woEsCXIXCPovctz6+fFuVFBNzO8iNWhUY96U/XhJdyNk7v
         XgZQRElZ5cPMIIBsNL5pQPbRRxhTwD7W8FP/76sknVnVSNN0D/V0IvHGGwX/RHLFi6rI
         SRjcbgeIthY/zNYrK1tu+YZ4Vc9Ihxru782vDH0U923pPX8haCJqzBrw17rYHmoB95Vg
         xiIPd4+JGEtDD+HtsTdJPE3/ikteO2eGdWqLY/q1kKoi2Ynti7iXtBIAVUrcpGp638m5
         lNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g7DsJGBEEB/Beb5kYu8dgD1IWPiGck1texLkmOUNaYg=;
        b=jCUbT5k7+BRoznxcFmvKbblEIGXz6m84TEKTvNFppQh4PjUCa9MUtoDPYWQllgm6u0
         B9zouPYM/LvDBSZFWT59VkWFr06MhyL20GlZIQpbzDcWy5I61ZKKYUECiGsqaSZChH7V
         85l4of8NzfipbT8rHJa0i1f+4VzSIbFdYcc8GiAJazZL+TcO8pK7sN9pJrKQD6MnCla1
         b+Djljzch0EcJo25g4MppqgnAHHx/+2HnQs41IYV1OHo6pYgntb/W1XK0lxwu+OCFJYx
         bqs1y3rIBcmyJhH881tO08Ox9Z8h4DH3IgyVNwE7jmRtEb9hDFemCgFtlpRHo5urMBaj
         lbaw==
X-Gm-Message-State: AOUpUlGc+0SVgtiNrVr1xPW4ps1RzWOX6jTWGWUyzgkjH2iep1eg5lsn
        N5+MArY1UnX5+vyLaqcULn1mnw==
X-Google-Smtp-Source: AA+uWPzxSBI1QJ/hl/W7x8xQJ8eyruFgGcJ0bJSX9oi0yWsjSXVwaWfb0EquiFdMM6zo8yIuFaQyGw==
X-Received: by 2002:a1c:888e:: with SMTP id k136-v6mr1572065wmd.6.1533907038940;
        Fri, 10 Aug 2018 06:17:18 -0700 (PDT)
Received: from radium.baylibre.local (AStLambert-681-1-8-155.w90-86.abo.wanadoo.fr. [90.86.13.155])
        by smtp.gmail.com with ESMTPSA id i205-v6sm2069523wmf.30.2018.08.10.06.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 06:17:18 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gpain@baylibre.com, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 2/3] power: supply: cros: add support for dedicated port
Date:   Fri, 10 Aug 2018 15:13:48 +0200
Message-Id: <20180810131349.3883-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810131349.3883-1-fparent@baylibre.com>
References: <20180810131349.3883-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChromeOS devices can have one optional dedicated port.
The Dedicated port is unique and similar to the USB PD ports
except that it doesn't support as many properties.

The presence of a dedicated port is determined from whether the
EC's charger port count is equal to 'number of USB PD port' + 1.
The dedicated port ID is always the last valid port ID.

This commit keeps compatibility with Embedded Controllers that do not
support the new EC_CMD_CHARGE_PORT_COUNT command by setting
the number of charger port to be equal to the number of USB PD port
when this command fails.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

V1 -> V2:
  * Rebased

---
 drivers/power/supply/cros_usbpd-charger.c | 115 +++++++++++++++++++---
 1 file changed, 101 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 688a16bacfbb..fe1502715e46 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -12,8 +12,12 @@
 #include <linux/power_supply.h>
 #include <linux/slab.h>
 
-#define CHARGER_DIR_NAME			"CROS_USBPD_CHARGER%d"
-#define CHARGER_DIR_NAME_LENGTH			sizeof(CHARGER_DIR_NAME)
+#define CHARGER_USBPD_DIR_NAME			"CROS_USBPD_CHARGER%d"
+#define CHARGER_DEDICATED_DIR_NAME		"CROS_DEDICATED_CHARGER"
+#define CHARGER_DIR_NAME_LENGTH		(sizeof(CHARGER_USBPD_DIR_NAME) >= \
+					 sizeof(CHARGER_DEDICATED_DIR_NAME) ? \
+					 sizeof(CHARGER_USBPD_DIR_NAME) : \
+					 sizeof(CHARGER_DEDICATED_DIR_NAME))
 #define CHARGER_CACHE_UPDATE_DELAY		msecs_to_jiffies(500)
 #define CHARGER_MANUFACTURER_MODEL_LENGTH	32
 
@@ -42,6 +46,7 @@ struct charger_data {
 	struct cros_ec_dev *ec_dev;
 	struct cros_ec_device *ec_device;
 	int num_charger_ports;
+	int num_usbpd_ports;
 	int num_registered_psy;
 	struct port_data *ports[EC_USB_PD_MAX_PORTS];
 	struct notifier_block notifier;
@@ -58,6 +63,12 @@ static enum power_supply_property cros_usbpd_charger_props[] = {
 	POWER_SUPPLY_PROP_USB_TYPE
 };
 
+static enum power_supply_property cros_usbpd_dedicated_charger_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
 static enum power_supply_usb_type cros_usbpd_charger_usb_types[] = {
 	POWER_SUPPLY_USB_TYPE_UNKNOWN,
 	POWER_SUPPLY_USB_TYPE_SDP,
@@ -69,6 +80,11 @@ static enum power_supply_usb_type cros_usbpd_charger_usb_types[] = {
 	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID
 };
 
+static bool cros_usbpd_charger_port_is_dedicated(struct port_data *port)
+{
+	return port->port_number >= port->charger->num_usbpd_ports;
+}
+
 static int cros_usbpd_charger_ec_command(struct charger_data *charger,
 					 unsigned int version,
 					 unsigned int command,
@@ -102,6 +118,23 @@ static int cros_usbpd_charger_ec_command(struct charger_data *charger,
 }
 
 static int cros_usbpd_charger_get_num_ports(struct charger_data *charger)
+{
+	struct ec_response_charge_port_count resp;
+	int ret;
+
+	ret = cros_usbpd_charger_ec_command(charger, 0,
+					    EC_CMD_CHARGE_PORT_COUNT,
+					    NULL, 0, &resp, sizeof(resp));
+	if (ret < 0) {
+		dev_err(charger->dev,
+			"Unable to get the number of ports (err:0x%x)\n", ret);
+		return ret;
+	}
+
+	return resp.port_count;
+}
+
+static int cros_usbpd_charger_get_usbpd_num_ports(struct charger_data *charger)
 {
 	struct ec_response_usb_pd_ports resp;
 	int ret;
@@ -246,7 +279,10 @@ static int cros_usbpd_charger_get_power_info(struct port_data *port)
 		port->psy_usb_type = POWER_SUPPLY_USB_TYPE_SDP;
 	}
 
-	port->psy_desc.type = POWER_SUPPLY_TYPE_USB;
+	if (cros_usbpd_charger_port_is_dedicated(port))
+		port->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
+	else
+		port->psy_desc.type = POWER_SUPPLY_TYPE_USB;
 
 	dev_dbg(dev,
 		"Port %d: type=%d vmax=%d vnow=%d cmax=%d clim=%d pmax=%d\n",
@@ -281,7 +317,8 @@ static int cros_usbpd_charger_get_port_status(struct port_data *port,
 	if (ret < 0)
 		return ret;
 
-	ret = cros_usbpd_charger_get_discovery_info(port);
+	if (!cros_usbpd_charger_port_is_dedicated(port))
+		ret = cros_usbpd_charger_get_discovery_info(port);
 	port->last_update = jiffies;
 
 	return ret;
@@ -426,17 +463,56 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 
 	platform_set_drvdata(pd, charger);
 
+	/*
+	 * We need to know the number of USB PD ports in order to know whether
+	 * there is a dedicated port. The dedicated port will always be
+	 * after the USB PD ports, and there should be only one.
+	 */
+	charger->num_usbpd_ports =
+		cros_usbpd_charger_get_usbpd_num_ports(charger);
+	if (charger->num_usbpd_ports <= 0) {
+		/*
+		 * This can happen on a system that doesn't support USB PD.
+		 * Log a message, but no need to warn.
+		 */
+		dev_info(dev, "No USB PD charging ports found\n");
+	}
+
 	charger->num_charger_ports = cros_usbpd_charger_get_num_ports(charger);
-	if (charger->num_charger_ports <= 0) {
+	if (charger->num_charger_ports < 0) {
 		/*
 		 * This can happen on a system that doesn't support USB PD.
 		 * Log a message, but no need to warn.
+		 * Older ECs do not support the above command, in that case
+		 * let's set up the number of charger ports equal to the number
+		 * of USB PD ports
+		 */
+		dev_info(dev, "Could not get charger port count\n");
+		charger->num_charger_ports = charger->num_usbpd_ports;
+	}
+
+	if (charger->num_charger_ports <= 0) {
+		/*
+		 * This can happen on a system that doesn't support USB PD and
+		 * doesn't have a dedicated port.
+		 * Log a message, but no need to warn.
 		 */
 		dev_info(dev, "No charging ports found\n");
 		ret = -ENODEV;
 		goto fail_nowarn;
 	}
 
+	/*
+	 * Sanity checks on the number of ports:
+	 *  there should be at most 1 dedicated port
+	 */
+	if (charger->num_charger_ports < charger->num_usbpd_ports ||
+	    charger->num_charger_ports > (charger->num_usbpd_ports + 1)) {
+		dev_err(dev, "Unexpected number of charge port count\n");
+		ret = -EPROTO;
+		goto fail_nowarn;
+	}
+
 	for (i = 0; i < charger->num_charger_ports; i++) {
 		struct power_supply_config psy_cfg = {};
 
@@ -448,22 +524,33 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 
 		port->charger = charger;
 		port->port_number = i;
-		sprintf(port->name, CHARGER_DIR_NAME, i);
 
 		psy_desc = &port->psy_desc;
-		psy_desc->name = port->name;
-		psy_desc->type = POWER_SUPPLY_TYPE_USB;
 		psy_desc->get_property = cros_usbpd_charger_get_prop;
 		psy_desc->external_power_changed =
 					cros_usbpd_charger_power_changed;
-		psy_desc->properties = cros_usbpd_charger_props;
-		psy_desc->num_properties =
-					ARRAY_SIZE(cros_usbpd_charger_props);
-		psy_desc->usb_types = cros_usbpd_charger_usb_types;
-		psy_desc->num_usb_types =
-				ARRAY_SIZE(cros_usbpd_charger_usb_types);
 		psy_cfg.drv_data = port;
 
+		if (cros_usbpd_charger_port_is_dedicated(port)) {
+			sprintf(port->name, CHARGER_DEDICATED_DIR_NAME);
+			psy_desc->type = POWER_SUPPLY_TYPE_MAINS;
+			psy_desc->properties =
+				cros_usbpd_dedicated_charger_props;
+			psy_desc->num_properties =
+				ARRAY_SIZE(cros_usbpd_dedicated_charger_props);
+		} else {
+			sprintf(port->name, CHARGER_USBPD_DIR_NAME, i);
+			psy_desc->type = POWER_SUPPLY_TYPE_USB;
+			psy_desc->properties = cros_usbpd_charger_props;
+			psy_desc->num_properties =
+				ARRAY_SIZE(cros_usbpd_charger_props);
+			psy_desc->usb_types = cros_usbpd_charger_usb_types;
+			psy_desc->num_usb_types =
+				ARRAY_SIZE(cros_usbpd_charger_usb_types);
+		}
+
+		psy_desc->name = port->name;
+
 		psy = devm_power_supply_register_no_ws(dev, psy_desc,
 						       &psy_cfg);
 		if (IS_ERR(psy)) {
-- 
2.18.0

