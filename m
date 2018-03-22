Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039695-1521733957-2-11937737083823100005
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_WORDY 2.499, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='GB'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521733956; b=PkE6ModTq5z8CBLa92Cv3ucNn1niTeBgYaMhQ4joWjRTSnI
    jV4PHQWflDFLsCzfQ56daVOu+gd7sEELlycFdJn8ml9vYAm66X/sT2mUNCQQsvZQ
    qYsQTbGYTBUNunMMCi+3DWTT+Z/kwtKmCbn06uUqlxr6sXEel5v6pGRiW7Ri5KY+
    s6L9gZLl/GwIcKSl3FLICaZBd1gVWrENReafvrM7l9B0yiJ0VgblZzQAfyXv49BI
    QTtnSzDVGDwtciWcAsmXV3yo2u47m3IeOwWapbW9saNs+d49dtTsdVtsveI8eJje
    mqaYzz7C5bMqV8sA7BolqvDVLJCVSzGZT9ujI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :date:subject:to:cc:mime-version:content-type:sender:list-id; s=
    arctest; t=1521733956; bh=FdXPuuUF25YLzE4rwcExW1Jm9ic8yKiMs/Ma5K
    O34ts=; b=NxoIcyTSF5rBpRi8EcilkahVeku0PC+xB0qtIkXjIK1OrMRjCdE8MX
    OYahC0n8JMlCzeDOpupghVMsBqtyFOVCU1eO/Ub5kNg+Nld/jgMllQ6l/HLx13KV
    dhqCfedDxJlSyTQBskxXWVr0weLYwX53VWedx92Iv57dW3fCgzVxcqbM77M/IlzZ
    Haz8dmPo9JaNEoq5SzoRW/YAmSOKD7oCQf52SfCp34u1EDaAJSGSqK5Gr4GFc2bt
    BVPr8RJqrr75MLgqz0AyNR93D2whDUKSwdO8ML95Zw/bKahBhPojOrEXK1n0wbaz
    DK2fDIP+sbRgImL4Y0w0txxfJAG8Bh4w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1751972AbeCVPwd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 11:52:33 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:30715 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751840AbeCVPwI (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 11:52:08 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRWlGSWpSXmKPExsUSt3Opsa7axc1
  RBudXclo0L17PZvHm+HQmi67VO1ksrh3rZbK4vGsOm8Xn3iOMFouWtTJbPFl4hsni9O4SB06P
  Tas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgHsUayZeUn5FQmsGS9fbmUveGxeM
  Wn2CuYGxq36XYycHEIC6xklXk11hLArJN7cv8UMYvMKZEqc/TiJEcTmFHCXmP/rCzNEjZvEnH
  0v2UBsNgELicknHoDZLAKqElM/HGUFsYUFgiWedH4CinNxiAi8Z5T49PgDC0iCWaBOovf3Wxa
  IBYISJ2c+gYpLSBx88QJqgYHE6QWNYHEJAXuJ6e+vAsU5gGx9icZjsRBhQ4nvs75BlZhL3Fy0
  h20Co+AsJFNnIZm6gJFpFaNlUlFmekZJbmJmjq6hgYGuoaGxrpGukaGxXmKVbqJeaqlucmpeS
  VEiUFYvsbxYr7gyNzknRS8vtWQTIzCKGIBgB+Phs4mHGCU5mJREeT+92BQlxJeUn1KZkVicEV
  9UmpNafIhRhoNDSYLX+8LmKCHBotT01Iq0zBxgPMOkJTh4lER4U0DSvMUFibnFmekQqVOMuhw
  3XrxuYxZiycvPS5US5w0BKRIAKcoozYMbAUstlxhlpYR5GYGOEuIpSC3KzSxBlX/FKM7BqCTM
  Kw8yhSczrwRu0yugI5iAjsieuQHkiJJEhJRUA2Pt5urEybvLzucH7HBQ7t0udFt5YrFQReV98
  7xHswtTony1Uo4Wys+v/+e/Jsjthlt2yJbJOgIN5hcin/EfPv7j0LM1dhes0p74S9uZLPuzgW
  +G7gn2pUVvcy9sdfj1PH/56/v81z2K6r+HN4v+ThSsytKYveTd0XPJX/dtmBOTtWNjnMg55XQ
  lluKMREMt5qLiRAChl9cMKAMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-46.tower-223.messagelabs.com!1521733925!637796!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <48b526624feacbb01829c92ce3231a630f482ad3.1521732966.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1521732966.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1521732966.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Thu, 22 Mar 2018 15:52:05 +0000
Subject: [PATCH v6 4/6] power: supply: Add 'usb_type' property and supporting
 code
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

This commit adds the 'usb_type' property to represent USB supplies
which can report a number of different types based on a connection
event.

Examples of this already exist in drivers whereby the existing 'type'
property is updated, based on an event, to represent what was
connected (e.g. USB, USB_DCP, USB_ACA, ...). Current implementations
however don't show all supported connectable types, so this knowledge
has to be exlicitly known for each driver that supports this.

The 'usb_type' property is intended to fill this void and show users
all possible USB types supported by a driver. The property, when read,
shows all available types for the driver, and the one currently chosen
is highlighted/bracketed. It is expected that the 'type' property
would then just show the top-level type 'USB', and this would be
static.

Currently the 'usb_type' enum contains all of the USB variant types
that exist for the 'type' enum at this time, and in addition has
SDP and PPS types. The mirroring is intentional so as to not impact
existing usage of the 'type' property.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 12 ++++++++
 drivers/power/supply/power_supply_core.c    |  8 ++++-
 drivers/power/supply/power_supply_sysfs.c   | 45 +++++++++++++++++++++++++++++
 include/linux/power_supply.h                | 16 ++++++++++
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index e046566..5e23e22 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -409,6 +409,18 @@ Description:
 		Access: Read
 		Valid values: Represented in 1/10 Degrees Celsius
 
+What: 		/sys/class/power_supply/<supply_name>/usb_type
+Date:		March 2018
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports what type of USB connection is currently active for
+		the supply, for example it can show if USB-PD capable source
+		is attached.
+
+		Access: Read-Only
+		Valid values: "Unknown", "SDP", "DCP", "CDP", "ACA", "C", "PD",
+			      "PD_DRP", "PD_PPS", "BrickID"
+
 What: 		/sys/class/power_supply/<supply_name>/voltage_max
 Date:		January 2008
 Contact:	linux-pm@vger.kernel.org
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 64f6449..dff2bbb 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -843,7 +843,7 @@ static void psy_unregister_cooler(struct power_supply *psy)
 {
 	struct device *dev;
 	struct power_supply *psy;
-	int rc;
+	int i, rc;
 
 	if (!parent)
 		pr_warn("%s: Expected proper parent device for '%s'\n",
@@ -852,6 +852,12 @@ static void psy_unregister_cooler(struct power_supply *psy)
 	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
 		return ERR_PTR(-EINVAL);
 
+	for (i = 0; i < desc->num_properties; ++i) {
+		if ((desc->properties[i] == POWER_SUPPLY_PROP_USB_TYPE) &&
+		    (!desc->usb_types || !desc->num_usb_types))
+			return ERR_PTR(-EINVAL);
+	}
+
 	psy = kzalloc(sizeof(*psy), GFP_KERNEL);
 	if (!psy)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 5204f11..1350068 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -46,6 +46,11 @@
 	"USB_PD", "USB_PD_DRP", "BrickID"
 };
 
+static const char * const power_supply_usb_type_text[] = {
+	"Unknown", "SDP", "DCP", "CDP", "ACA", "C",
+	"PD", "PD_DRP", "PD_PPS", "BrickID"
+};
+
 static const char * const power_supply_status_text[] = {
 	"Unknown", "Charging", "Discharging", "Not charging", "Full"
 };
@@ -73,6 +78,41 @@
 	"Unknown", "System", "Device"
 };
 
+static ssize_t power_supply_show_usb_type(struct device *dev,
+					  enum power_supply_usb_type *usb_types,
+					  ssize_t num_usb_types,
+					  union power_supply_propval *value,
+					  char *buf)
+{
+	enum power_supply_usb_type usb_type;
+	ssize_t count = 0;
+	bool match = false;
+	int i;
+
+	for (i = 0; i < num_usb_types; ++i) {
+		usb_type = usb_types[i];
+
+		if (value->intval == usb_type) {
+			count += sprintf(buf + count, "[%s] ",
+					 power_supply_usb_type_text[usb_type]);
+			match = true;
+		} else {
+			count += sprintf(buf + count, "%s ",
+					 power_supply_usb_type_text[usb_type]);
+		}
+	}
+
+	if (!match) {
+		dev_warn(dev, "driver reporting unsupported connected type\n");
+		return -EINVAL;
+	}
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+
 static ssize_t power_supply_show_property(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf) {
@@ -115,6 +155,10 @@ static ssize_t power_supply_show_property(struct device *dev,
 	else if (off == POWER_SUPPLY_PROP_TYPE)
 		return sprintf(buf, "%s\n",
 			       power_supply_type_text[value.intval]);
+	else if (off == POWER_SUPPLY_PROP_USB_TYPE)
+		return power_supply_show_usb_type(dev, psy->desc->usb_types,
+						  psy->desc->num_usb_types,
+						  &value, buf);
 	else if (off == POWER_SUPPLY_PROP_SCOPE)
 		return sprintf(buf, "%s\n",
 			       power_supply_scope_text[value.intval]);
@@ -241,6 +285,7 @@ static ssize_t power_supply_store_property(struct device *dev,
 	POWER_SUPPLY_ATTR(time_to_full_now),
 	POWER_SUPPLY_ATTR(time_to_full_avg),
 	POWER_SUPPLY_ATTR(type),
+	POWER_SUPPLY_ATTR(usb_type),
 	POWER_SUPPLY_ATTR(scope),
 	POWER_SUPPLY_ATTR(precharge_current),
 	POWER_SUPPLY_ATTR(charge_term_current),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 79e90b3..4ca8876 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -145,6 +145,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
 	POWER_SUPPLY_PROP_TYPE, /* use power_supply.type instead */
+	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
@@ -170,6 +171,19 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 };
 
+enum power_supply_usb_type {
+	POWER_SUPPLY_USB_TYPE_UNKNOWN = 0,
+	POWER_SUPPLY_USB_TYPE_SDP,		/* Standard Downstream Port */
+	POWER_SUPPLY_USB_TYPE_DCP,		/* Dedicated Charging Port */
+	POWER_SUPPLY_USB_TYPE_CDP,		/* Charging Downstream Port */
+	POWER_SUPPLY_USB_TYPE_ACA,		/* Accessory Charger Adapters */
+	POWER_SUPPLY_USB_TYPE_C,		/* Type C Port */
+	POWER_SUPPLY_USB_TYPE_PD,		/* Power Delivery Port */
+	POWER_SUPPLY_USB_TYPE_PD_DRP,		/* PD Dual Role Port */
+	POWER_SUPPLY_USB_TYPE_PD_PPS,		/* PD Programmable Power Supply */
+	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
+};
+
 enum power_supply_notifier_events {
 	PSY_EVENT_PROP_CHANGED,
 };
@@ -196,6 +210,8 @@ struct power_supply_config {
 struct power_supply_desc {
 	const char *name;
 	enum power_supply_type type;
+	enum power_supply_usb_type *usb_types;
+	size_t num_usb_types;
 	enum power_supply_property *properties;
 	size_t num_properties;
 
-- 
1.9.1

