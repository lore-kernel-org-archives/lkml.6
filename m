Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039695-1521734001-2-4059771602605457474
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_WORDY 2.499, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES enroca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='GB'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521734000; b=XmzfSawzy88oNqzUK87EkElk9sBVBhu1W2v4rrtIOTGRz6b
    PLwXGFiXn7EBbJP+drZL+h7GCJPDAa4ppn1b6g/hcu8AbpA4vQMwXwiEpu/D16I/
    rM8EWasMQKxXufJRRLXawWKSU/uiXfi3CdBrlg86NYckLjfYAU1O0ml/A/5zZlXZ
    fa4KGwAEWMgDYh9zFb6NmGbAyRAgD7cemBsRhLfVt3yiTsTJmICf1Ov6AZZuP8AC
    0EaYWMksA47vYcKSuhPrtJVDNj1CkM7jEcuS8nmhHrWI1TvxPIXHgv4OuPcIb/5i
    ycbzPT/AMcionVPZ3tXrGK3YywObLq4E62a5mGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :date:subject:to:cc:mime-version:content-type:sender:list-id; s=
    arctest; t=1521734000; bh=68s/XvCAJ5wzprx4WJTbTT+EwLT4AUXvO3EgEy
    55r4I=; b=Eyi5yQCOLuXNG9P8xzDHUTEdppOvdW2ui+jIkQe6TIgWPvFSy8Zti9
    S6L1WJ7C40r0UWfMQDmnDaHxvKfmb7szmjrWXTuIY1bGBeMB6am+ZfwD1AKbyKSQ
    ZDANWDKUgy3d3WKWeXBB1nz58S6boAKwjxPs2Yb6sWU9dMwcFwRbKj/xjWw44bp4
    WtmI5RwEAKc4gaLK/TjT16WJ5FKuTDMpSdiaBu2mEwFbJlg1C5iqKT4zelsLp68k
    GxK5kAbnDUZ9vinvKy6sMG0l03jaDsty9QT0ThrohSAeHK2yGajXMFCu4H/eAwTu
    5YDf7sRL0V6GeJ2dAwmxizchxuRMlU7w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeCVPwX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 11:52:23 -0400
Received: from mail1.bemta6.messagelabs.com ([193.109.254.108]:6923 "EHLO
        mail1.bemta6.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751657AbeCVPwM (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 11:52:12 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleJIrShJLcpLzFFi42KJ27nUWFfj4uY
  ogxkTOS2aF69ns3hzfDqTRdfqnSwW1471Mllc3jWHzeJz7xFGi0XLWpktniw8w2RxeneJA6fH
  plWdbB7zTgZ67J+7ht1j47sdTB7v911l89j5vYHd4/MmuQD2KNbMvKT8igTWjMWnLrAVLM6ou
  LViN2MD46KILkYuDiGB9YwSvy8sZO1i5ARyKiR6HlxhBLF5BTIlHq2azQ5icwq4S8z/9YUZos
  ZNYs6+l2wgNpuAhcTkEw/AbBYBVYnty+aydDFycAgLBEocPSEAMl9E4D2jxKfHH1hAapgF6iR
  6f79lgZgvKHFy5hOouITEwRcvoOYbSJxe0AgWlxCwl5j+/iozyEwJAX2JxmOxEGFDie+zvkGV
  mEvcXLSHbQKj4CwkU2chmbqAkWkVo0ZxalFZapGuoYFeUlFmekZJbmJmDpBnppebWlycmJ6ak
  5hUrJecn7uJERgjDECwg/H4+7hDjJIcTEqivJ9ebIoS4kvKT6nMSCzOiC8qzUktPsQow8GhJM
  HLcGFzlJBgUWp6akVaZg4wWmHSEhw8SiK8miBp3uKCxNzizHSI1ClGXY4bL163MQux5OXnpUq
  J8149D1QkAFKUUZoHNwKWOC4xykoJ8zICHSXEU5BalJtZgir/ilGcg1FJmFceZBVPZl4J3KZX
  QEcwAR2RPXMDyBEliQgpqQbGpWaz67mEK9/YVWY31gpOffJ9YtSK7brTPJ3SynODtA7O5Ip++
  hDotaNyjx7fjIg9L5wQ58fH6Limlzsk9Vom371z+5vmnjXzv8tw7d7i+8b9Bi5qfUtebu/YPS
  /6xbT/3BWNejf7VINbi1pKqya8XFX4f++TgGS5+x+5ayzvtK1L3/X/kqoSS3FGoqEWc1FxIgA
  1Tz9PFwMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-16.tower-194.messagelabs.com!1521733927!84066099!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <1663fa942df2eee69a8d17657f95cfbeeefa0781.1521732966.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1521732966.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1521732966.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Thu, 22 Mar 2018 15:52:06 +0000
Subject: [PATCH v6 5/6] typec: tcpm: Represent source supply through power_supply
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
CC: <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 22/03/2018 12:24:00
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds a power_supply class instance to represent a
PD source's voltage and current properties. This provides an
interface for reading these properties from user-space or other
drivers.

For PPS enabled Sources, this also provides write access to set
the current and voltage and allows for swapping between standard
PDO and PPS APDO.

As this represents a superset of the information provided in the
fusb302 driver, the power_supply instance in that code is removed
as part of this change, so reverting the commit titled
'typec: tcpm: Represent source supply through power_supply class'

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/usb/typec/Kconfig           |   1 +
 drivers/usb/typec/fusb302/Kconfig   |   2 +-
 drivers/usb/typec/fusb302/fusb302.c |  63 +---------
 drivers/usb/typec/tcpm.c            | 242 +++++++++++++++++++++++++++++++++++-
 4 files changed, 245 insertions(+), 63 deletions(-)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index bcb2744..1ef606d 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -48,6 +48,7 @@ if TYPEC
 config TYPEC_TCPM
 	tristate "USB Type-C Port Controller Manager"
 	depends on USB
+	select POWER_SUPPLY
 	help
 	  The Type-C Port Controller Manager provides a USB PD and USB Type-C
 	  state machine for use with Type-C Port Controllers.
diff --git a/drivers/usb/typec/fusb302/Kconfig b/drivers/usb/typec/fusb302/Kconfig
index 48a4f2f..fce099f 100644
--- a/drivers/usb/typec/fusb302/Kconfig
+++ b/drivers/usb/typec/fusb302/Kconfig
@@ -1,6 +1,6 @@
 config TYPEC_FUSB302
 	tristate "Fairchild FUSB302 Type-C chip driver"
-	depends on I2C && POWER_SUPPLY
+	depends on I2C
 	help
 	  The Fairchild FUSB302 Type-C chip driver that works with
 	  Type-C Port Controller Manager to provide USB PD and USB
diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
index 06794c0..6a8f279 100644
--- a/drivers/usb/typec/fusb302/fusb302.c
+++ b/drivers/usb/typec/fusb302/fusb302.c
@@ -18,7 +18,6 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/power_supply.h>
 #include <linux/proc_fs.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/clock.h>
@@ -99,11 +98,6 @@ struct fusb302_chip {
 	/* lock for sharing chip states */
 	struct mutex lock;
 
-	/* psy + psy status */
-	struct power_supply *psy;
-	u32 current_limit;
-	u32 supply_voltage;
-
 	/* chip status */
 	enum toggling_mode toggling_mode;
 	enum src_current_status src_current_status;
@@ -861,13 +855,11 @@ static int tcpm_set_vbus(struct tcpc_dev *dev, bool on, bool charge)
 		chip->vbus_on = on;
 		fusb302_log(chip, "vbus := %s", on ? "On" : "Off");
 	}
-	if (chip->charge_on == charge) {
+	if (chip->charge_on == charge)
 		fusb302_log(chip, "charge is already %s",
 			    charge ? "On" : "Off");
-	} else {
+	else
 		chip->charge_on = charge;
-		power_supply_changed(chip->psy);
-	}
 
 done:
 	mutex_unlock(&chip->lock);
@@ -883,11 +875,6 @@ static int tcpm_set_current_limit(struct tcpc_dev *dev, u32 max_ma, u32 mv)
 	fusb302_log(chip, "current limit: %d ma, %d mv (not implemented)",
 		    max_ma, mv);
 
-	chip->supply_voltage = mv;
-	chip->current_limit = max_ma;
-
-	power_supply_changed(chip->psy);
-
 	return 0;
 }
 
@@ -1686,43 +1673,6 @@ static irqreturn_t fusb302_irq_intn(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int fusb302_psy_get_property(struct power_supply *psy,
-				    enum power_supply_property psp,
-				    union power_supply_propval *val)
-{
-	struct fusb302_chip *chip = power_supply_get_drvdata(psy);
-
-	switch (psp) {
-	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = chip->charge_on;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = chip->supply_voltage * 1000; /* mV -> µV */
-		break;
-	case POWER_SUPPLY_PROP_CURRENT_MAX:
-		val->intval = chip->current_limit * 1000; /* mA -> µA */
-		break;
-	default:
-		return -ENODATA;
-	}
-
-	return 0;
-}
-
-static enum power_supply_property fusb302_psy_properties[] = {
-	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_MAX,
-};
-
-static const struct power_supply_desc fusb302_psy_desc = {
-	.name		= "fusb302-typec-source",
-	.type		= POWER_SUPPLY_TYPE_USB_TYPE_C,
-	.properties	= fusb302_psy_properties,
-	.num_properties	= ARRAY_SIZE(fusb302_psy_properties),
-	.get_property	= fusb302_psy_get_property,
-};
-
 static int init_gpio(struct fusb302_chip *chip)
 {
 	struct device_node *node;
@@ -1762,7 +1712,6 @@ static int fusb302_probe(struct i2c_client *client,
 	struct fusb302_chip *chip;
 	struct i2c_adapter *adapter;
 	struct device *dev = &client->dev;
-	struct power_supply_config cfg = {};
 	const char *name;
 	int ret = 0;
 	u32 v;
@@ -1809,14 +1758,6 @@ static int fusb302_probe(struct i2c_client *client,
 			return -EPROBE_DEFER;
 	}
 
-	cfg.drv_data = chip;
-	chip->psy = devm_power_supply_register(dev, &fusb302_psy_desc, &cfg);
-	if (IS_ERR(chip->psy)) {
-		ret = PTR_ERR(chip->psy);
-		dev_err(chip->dev, "Error registering power-supply: %d\n", ret);
-		return ret;
-	}
-
 	ret = fusb302_debugfs_init(chip);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 5618b3f..c859cba 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/power_supply.h>
 #include <linux/proc_fs.h>
 #include <linux/sched/clock.h>
 #include <linux/seq_file.h>
@@ -277,6 +278,11 @@ struct tcpm_port {
 	u32 current_limit;
 	u32 supply_voltage;
 
+	/* Used to export TA voltage and current */
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+	enum power_supply_usb_type usb_type;
+
 	u32 bist_request;
 
 	/* PD state for Vendor Defined Messages */
@@ -1874,6 +1880,7 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
 	int ret = -EINVAL;
 
 	port->pps_data.supported = false;
+	port->usb_type = POWER_SUPPLY_USB_TYPE_PD;
 
 	/*
 	 * Select the source PDO providing the most power while staying within
@@ -1893,8 +1900,11 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
 			mv = pdo_min_voltage(pdo);
 			break;
 		case PDO_TYPE_APDO:
-			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
+			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS) {
 				port->pps_data.supported = true;
+				port->usb_type =
+					POWER_SUPPLY_USB_TYPE_PD_PPS;
+			}
 			continue;
 		default:
 			tcpm_log(port, "Invalid PDO type, ignoring");
@@ -2379,6 +2389,9 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	port->try_snk_count = 0;
 	port->supply_voltage = 0;
 	port->current_limit = 0;
+	port->usb_type = POWER_SUPPLY_USB_TYPE_C;
+
+	power_supply_changed(port->psy);
 }
 
 static void tcpm_detach(struct tcpm_port *port)
@@ -2911,6 +2924,8 @@ static void run_state_machine(struct tcpm_port *port)
 
 		tcpm_pps_complete(port, port->pps_status);
 
+		power_supply_changed(port->psy);
+
 		break;
 
 	/* Accessory states */
@@ -4077,6 +4092,227 @@ int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
 }
 EXPORT_SYMBOL_GPL(tcpm_update_sink_capabilities);
 
+/* Power Supply access to expose source power information */
+enum tcpm_psy_online_states {
+	TCPM_PSY_OFFLINE = 0,
+	TCPM_PSY_FIXED_ONLINE,
+	TCPM_PSY_PROG_ONLINE,
+};
+
+static enum power_supply_property tcpm_psy_props[] = {
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+};
+
+static int tcpm_psy_get_online(struct tcpm_port *port,
+			       union power_supply_propval *val)
+{
+	if (port->vbus_charge) {
+		if (port->pps_data.active)
+			val->intval = TCPM_PSY_PROG_ONLINE;
+		else
+			val->intval = TCPM_PSY_FIXED_ONLINE;
+	} else {
+		val->intval = TCPM_PSY_OFFLINE;
+	}
+
+	return 0;
+}
+
+static int tcpm_psy_get_voltage_min(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	if (port->pps_data.active)
+		val->intval = port->pps_data.min_volt * 1000;
+	else
+		val->intval = port->supply_voltage * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_voltage_max(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	if (port->pps_data.active)
+		val->intval = port->pps_data.max_volt * 1000;
+	else
+		val->intval = port->supply_voltage * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_voltage_now(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	val->intval = port->supply_voltage * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_current_max(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	if (port->pps_data.active)
+		val->intval = port->pps_data.max_curr * 1000;
+	else
+		val->intval = port->current_limit * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_current_now(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	val->intval = port->current_limit * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_prop(struct power_supply *psy,
+			     enum power_supply_property psp,
+			     union power_supply_propval *val)
+{
+	struct tcpm_port *port = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = port->usb_type;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = tcpm_psy_get_online(port, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		ret = tcpm_psy_get_voltage_min(port, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		ret = tcpm_psy_get_voltage_max(port, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = tcpm_psy_get_voltage_now(port, val);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		ret = tcpm_psy_get_current_max(port, val);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = tcpm_psy_get_current_now(port, val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int tcpm_psy_set_online(struct tcpm_port *port,
+			       const union power_supply_propval *val)
+{
+	int ret;
+
+	switch (val->intval) {
+	case TCPM_PSY_FIXED_ONLINE:
+		ret = tcpm_pps_activate(port, false);
+		break;
+	case TCPM_PSY_PROG_ONLINE:
+		ret = tcpm_pps_activate(port, true);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int tcpm_psy_set_prop(struct power_supply *psy,
+			     enum power_supply_property psp,
+			     const union power_supply_propval *val)
+{
+	struct tcpm_port *port = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = tcpm_psy_set_online(port, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if (val->intval < (port->pps_data.min_volt * 1000) ||
+		    val->intval > (port->pps_data.max_volt * 1000))
+			ret = -EINVAL;
+		else
+			ret = tcpm_pps_set_out_volt(port, val->intval / 1000);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		if (val->intval > (port->pps_data.max_curr * 1000))
+			ret = -EINVAL;
+		else
+			ret = tcpm_pps_set_op_curr(port, val->intval / 1000);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int tcpm_psy_prop_writeable(struct power_supply *psy,
+				   enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static enum power_supply_usb_type tcpm_psy_usb_types[] = {
+	POWER_SUPPLY_USB_TYPE_C,
+	POWER_SUPPLY_USB_TYPE_PD,
+	POWER_SUPPLY_USB_TYPE_PD_PPS,
+};
+
+static const char *tcpm_psy_name_prefix = "tcpm-source-psy-";
+
+static int devm_tcpm_psy_register(struct tcpm_port *port)
+{
+	struct power_supply_config psy_cfg = {};
+	const char *port_dev_name = dev_name(port->dev);
+	size_t psy_name_len = strlen(tcpm_psy_name_prefix) +
+				     strlen(port_dev_name) + 1;
+	char *psy_name;
+
+	psy_cfg.drv_data = port;
+	psy_name = devm_kzalloc(port->dev, psy_name_len, GFP_KERNEL);
+	snprintf(psy_name, psy_name_len, "%s%s", tcpm_psy_name_prefix,
+		 port_dev_name);
+	port->psy_desc.name = psy_name;
+	port->psy_desc.type = POWER_SUPPLY_TYPE_USB,
+	port->psy_desc.usb_types = tcpm_psy_usb_types;
+	port->psy_desc.num_usb_types = ARRAY_SIZE(tcpm_psy_usb_types);
+	port->psy_desc.properties = tcpm_psy_props,
+	port->psy_desc.num_properties = ARRAY_SIZE(tcpm_psy_props),
+	port->psy_desc.get_property = tcpm_psy_get_prop,
+	port->psy_desc.set_property = tcpm_psy_set_prop,
+	port->psy_desc.property_is_writeable = tcpm_psy_prop_writeable,
+
+	port->usb_type = POWER_SUPPLY_USB_TYPE_C;
+
+	port->psy = devm_power_supply_register(port->dev, &port->psy_desc,
+					       &psy_cfg);
+
+	return PTR_ERR_OR_ZERO(port->psy);
+}
+
 struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 {
 	struct tcpm_port *port;
@@ -4148,6 +4384,10 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->partner_desc.identity = &port->partner_ident;
 	port->port_type = tcpc->config->type;
 
+	err = devm_tcpm_psy_register(port);
+	if (err)
+		goto out_destroy_wq;
+
 	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
 	if (IS_ERR(port->typec_port)) {
 		err = PTR_ERR(port->typec_port);
-- 
1.9.1

