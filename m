Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1269041-1524492822-2-2835673077344067626
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_WORDY 2.5, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='GB'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524492820; b=PbB+yHi5KAGud+Q1CcBTdN47jXzvLoFVyby2HXz//ox4b/YxZb
    KH7Tp/m6VZAX1nmuKwx2E4C1zHahqdoEpQcgZIVrvL91JYn6XLTbzhQy1ZpvzsbY
    /X9s7DPvrFzMU1JmXlORMjyx5Tc1B5M0AhX2hVgfU7SkxxHyxF3x8cKTaRr+vTIU
    LuiUOsz7B2q3CenatuStebBNKP67E8tXJts6eryjHju5D/aRVUHonSQIRXUt4lgv
    6uoEwgLxkCkYiGJi7d8J6DqDzA30NjRSyAVbF0V/cNXXNuqvACWNTLUMwZWVSxIA
    KdkGZ8X4UwWdVmtLSc8ANI/A42MNLePTiXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :date:subject:to:cc:mime-version:content-type:sender:list-id; s=
    fm2; t=1524492820; bh=wiZdDXtar9rzjGhTT/l85Zdmn8P0vfQFbQvNcaf1Z7
    Q=; b=ev5IHWISOT55Zu6k7pXnMTBGf0th01RiffpK9Wr9wWBFxU2ZkG18QIb3FP
    6DbeoHvCo4kWvn7TNKY6w0OPVZNwTL6Gk/u023GU1UGz+gCd/SP4rPfpgEo6QyDg
    8mRjcXQIItRaxiu2c3ZotFDmFYdLyTUQb3ttTMIiXZvB/RdMDE219cCRH6JJOEVz
    RqWSSukKwXbH+hVEbrQ5l/gDRElhhcFimzffIlM069h4fjq4UaJE2+0rqm8gvZ7O
    5wOT/yp+BGzrdDPpasjRcQKiRG+BON/1emfJmTr1QOAELx8yA/qUw0IULnn1Iam2
    5cK2JONNYz0G/oHTVE2CTGvUL/RQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOYhZBPcN3V4hV1FDYx5X97JOzmChc6Gy7RDEgf/Ir+v53WQM0pgVg1YJVCt0qxs09cw1Rg7DbjX9ubexgDepXHpNDtkpaI0Q1ewYB+07V9dATvh8Kkf
    KIH1IFZ8h3xCKTmasXvJxzbFzEaFZu2qw0McifApuGs2T04gv2IBhLLLKjVMFQS15GPPJPfhbjr285CKVoGP6nke8ustNGGi1tAairB/w+7UOY9KRlbP+8Cv
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=Kd1tUaAdevIA:10
    a=X3a0BiUdAAAA:8 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=I19jlynAXRwjjud8xtwA:9
    a=t1kEl2L6EXVecZ7_:21 a=fkqapZOYkiAfHoL-:21 a=x8gzFH9gYPwA:10
    a=aWu3muFgq6otJbhCXpL5:22 a=nlm17XC03S6CtCLSeiRr:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755520AbeDWOLK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 10:11:10 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:26345 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755419AbeDWOLD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 10:11:03 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleJIrShJLcpLzFFi42KJ27nUWLf05d0
  ogwldHBbNi9ezWbw5Pp3Jomv1ThaLa8d6mSwu75rDZvG59wijxaJlrcwWTxaeYbI4vbvEgdNj
  06pONo95JwM99s9dw+6x8d0OJo/3+66yeez83sDu8XmTXAB7FGtmXlJ+RQJrxukp59kLZhdUX
  Hi/kq2BsTG+i5GLQ0hgPaPEsiWnmboYOYCcComJZ4W7GDk5eAUyJRrvvGEGsTkF3CW6J31kA7
  GFBNwkLre9YQSx2QQsJCafeAAWZxFQlVjeeA6sXlggUOLywvcsIPNFBN4zSnx6/IEFJMEsUCf
  R+/stC8QCQYmTM59AxSUkDr54wQyxwEDi9IJGsLiEgL3E9PdXmUFukxDQl2g8FgsRNpT4Pusb
  VIm5xP3DXWwTGAVnIZk6C8nUBYxMqxgtk4oy0zNKchMzc3QNDQx0DQ2NdU11DS0M9BKrdJP0U
  kt1k1PzSooSgbJ6ieXFesWVuck5KXp5qSWbGIFRxAAEOxinHUo8xCjJwaQkymt5/m6UEF9Sfk
  plRmJxRnxRaU5q8SFGGQ4OJQneTS+AcoJFqempFWmZOcB4hklLcPAoifDGgaR5iwsSc4sz0yF
  SpxgVpcR5N4MkBEASGaV5cG2wFHKJUVZKmJcR6BAhnoLUotzMElT5V4ziHIxKwhBTeDLzSuCm
  vwJazAS0uEPyDsjikkSElFQDY5yMepHko7WNdz7dX7V+5YWr+SGJV3sebVpgY8WXIONRYXXvz
  /3DS2qOuzbOqdwgH8FhaxVzKC/tzYSSr5oP3S7ICT080ShxkrHjf4pByEfW9y4r9S0X1//LeC
  znx2bwe8PbR17qzhp35Oa8+OPaauTfukZ4ukPIa7drnNOfRz/Nr86dk9n0S4mlOCPRUIu5qDg
  RAFStczgcAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-37.tower-246.messagelabs.com!1524492660!1328244!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <e09e12a78b9cdc2b6bf684ef1a0a4936e96ed4b5.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Mon, 23 Apr 2018 15:11:00 +0100
Subject: [PATCH v8 5/6] typec: tcpm: Represent source supply through power_supply
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
X-KSE-Antivirus-Info: Clean, bases: 23/04/2018 11:44:00
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
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/Kconfig           |   1 +
 drivers/usb/typec/fusb302/Kconfig   |   2 +-
 drivers/usb/typec/fusb302/fusb302.c |  63 +--------
 drivers/usb/typec/tcpm.c            | 251 +++++++++++++++++++++++++++++++++++-
 4 files changed, 251 insertions(+), 66 deletions(-)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index 030f88c..2c8eab1 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -49,6 +49,7 @@ config TYPEC_TCPM
 	tristate "USB Type-C Port Controller Manager"
 	depends on USB
 	select USB_ROLE_SWITCH
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
index 664463d..eba6bb8 100644
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
@@ -862,13 +856,11 @@ static int tcpm_set_vbus(struct tcpc_dev *dev, bool on, bool charge)
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
@@ -884,11 +876,6 @@ static int tcpm_set_current_limit(struct tcpc_dev *dev, u32 max_ma, u32 mv)
 	fusb302_log(chip, "current limit: %d ma, %d mv (not implemented)",
 		    max_ma, mv);
 
-	chip->supply_voltage = mv;
-	chip->current_limit = max_ma;
-
-	power_supply_changed(chip->psy);
-
 	return 0;
 }
 
@@ -1682,43 +1669,6 @@ static irqreturn_t fusb302_irq_intn(int irq, void *dev_id)
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
@@ -1781,7 +1731,6 @@ static int fusb302_probe(struct i2c_client *client,
 	struct fusb302_chip *chip;
 	struct i2c_adapter *adapter;
 	struct device *dev = &client->dev;
-	struct power_supply_config cfg = {};
 	const char *name;
 	int ret = 0;
 	u32 v;
@@ -1823,14 +1772,6 @@ static int fusb302_probe(struct i2c_client *client,
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
index b160da3..7547097 100644
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
@@ -276,6 +277,11 @@ struct tcpm_port {
 	u32 current_limit;
 	u32 supply_voltage;
 
+	/* Used to export TA voltage and current */
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+	enum power_supply_usb_type usb_type;
+
 	u32 bist_request;
 
 	/* PD state for Vendor Defined Messages */
@@ -1895,6 +1901,7 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
 	int ret = -EINVAL;
 
 	port->pps_data.supported = false;
+	port->usb_type = POWER_SUPPLY_USB_TYPE_PD;
 
 	/*
 	 * Select the source PDO providing the most power which has a
@@ -1915,8 +1922,11 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
 			min_src_mv = pdo_min_voltage(pdo);
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
 			tcpm_log(port, "Invalid source PDO type, ignoring");
@@ -2472,6 +2482,9 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	port->try_snk_count = 0;
 	port->supply_voltage = 0;
 	port->current_limit = 0;
+	port->usb_type = POWER_SUPPLY_USB_TYPE_C;
+
+	power_supply_changed(port->psy);
 }
 
 static void tcpm_detach(struct tcpm_port *port)
@@ -2999,6 +3012,8 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_check_send_discover(port);
 		tcpm_pps_complete(port, port->pps_status);
 
+		power_supply_changed(port->psy);
+
 		break;
 
 	/* Accessory states */
@@ -3849,7 +3864,7 @@ static int tcpm_try_role(const struct typec_capability *cap, int role)
 	return ret;
 }
 
-static int __maybe_unused tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
+static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
 {
 	unsigned int target_mw;
 	int ret;
@@ -3901,7 +3916,7 @@ static int __maybe_unused tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_cu
 	return ret;
 }
 
-static int __maybe_unused tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
+static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
 {
 	unsigned int target_mw;
 	int ret;
@@ -3954,7 +3969,7 @@ static int __maybe_unused tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_
 	return ret;
 }
 
-static int __maybe_unused tcpm_pps_activate(struct tcpm_port *port, bool activate)
+static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
 {
 	int ret = 0;
 
@@ -4159,6 +4174,230 @@ int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
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
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = tcpm_psy_set_online(port, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if (val->intval < port->pps_data.min_volt * 1000 ||
+		    val->intval > port->pps_data.max_volt * 1000)
+			ret = -EINVAL;
+		else
+			ret = tcpm_pps_set_out_volt(port, val->intval / 1000);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		if (val->intval > port->pps_data.max_curr * 1000)
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
+	if (!psy_name)
+		return -ENOMEM;
+
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
@@ -4234,6 +4473,10 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 		goto out_destroy_wq;
 	}
 
+	err = devm_tcpm_psy_register(port);
+	if (err)
+		goto out_destroy_wq;
+
 	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
 	if (IS_ERR(port->typec_port)) {
 		err = PTR_ERR(port->typec_port);
-- 
1.9.1

