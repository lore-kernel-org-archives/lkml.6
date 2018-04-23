Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1286548-1524492828-2-12447960924031091650
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_WORDY 2.5, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='GB'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524492827; b=LditkB1H7WWPy46K1RA7p+wWkip1eIghG0rj/8wfxPgcGCbiI0
    jNsYgsWsyzqDezLtvW3/eN4nY0HVEo15cQrqDcAQB759basSYL2XSOfZ53KetFzI
    ewTyfuyVsjqqr1tGV2pfxtfbfT/G2aD7rAlLaxGdKEnHUlXh3DpEcRihYskvYSWj
    uT1hAKor5VIavKJRn9zM5MDRN6tY2z9ZNU7o/IRbST1PCzSxsLGrW3zsQ2NUcd1Q
    gx48EeBVHqLOYPVWvWIfK5wSY77lc23vwV9pN5PvVcyfe9YsWFVKzSMUSTsO32kZ
    UOQQg5WGuw7m9fqv334ze17Yv16oTCAMoxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :date:subject:to:cc:mime-version:content-type:sender:list-id; s=
    fm2; t=1524492827; bh=HyHAzWUtBI7L9mt9E9NKgIyq7W7VD852n0KaKCHN90
    8=; b=mndq1Lr/R1a3Q8m4FkaVQtVmhz4KgY1bLc2nW7tg6rsaV1c0Vnj53t+zeF
    X7z6azaBA4w3xyH2o2W/ifoyIL2qHl/WdcyKmwKcLnXxlK10Qazrg/3rpuaBh1MI
    ywJcwxnmoMrXja38/87jC3Xw1w4REJq1k+7IRixFSAdg/xIobsKXsU30TvM5Y+Au
    ylvrnY09ceryrFaSt//zbSjTn6D/I5985ymWBnEpNTRmGNT8HrN508iYL3MGpWxX
    U4nAPUyrtsr2UMFRQHijzJlJBXuRKEG/C7GUdPRticpQ45jLtZFlqnwFZEbGJkJ8
    xerXR8N1qUIKBZM5DssXjq8xce0A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOFjJdT3IMTIJQ3DP/b1vHPi3d3JLtHiK71DzlbIlbH3G24WPwW0elG9/K5KYZRNGuUTiikjR3UEr0PiADI5wUt9lSjjZoeUYnVPDFsSwCINnEikVcrM
    sXxLH/tJAqVT/E4cthBnss1GZ24IugyojUKUJCUOX3VJd4YvWnzVVOiKWdKvVp0ocVERcg7sbJOFBxwqq68rXetWZyuL/mnC9OK9l8zfdZ67IJVGjuachoTu
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=Kd1tUaAdevIA:10
    a=X3a0BiUdAAAA:8 a=VwQbUJbxAAAA:8 a=6nszj3UVdbKDbLYIwuoA:9
    a=25nMwCHBu10uLc_Z:21 a=FumoekXEIWpWUzgl:21 a=d24Ss_oZLtcA:10
    a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755505AbeDWOLJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 10:11:09 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.5]:8311 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754962AbeDWOLC (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 10:11:02 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRWlGSWpSXmKPExsUSt3OpsW7Jy7t
  RBg8+yFo0L17PZvHm+HQmi67VO1ksrh3rZbK4vGsOm8Xn3iOMFouWtTJbPFl4hsni9O4SB06P
  Tas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgHsUayZeUn5FQmsGVc2zmMreGxe8
  bd9H0sD41b9LkYuDiGB9YwSH/suMnUxcgI5FRKLjx0Esjk4eAUyJVYfqwAJcwq4S3RP+sgGUe
  ImcbntDSOIzSZgITH5xAOwOIuAqkTb67lgtrBAsMSLOacZQeaLCLxnlPj0+AMLSIJZoE6i9/d
  bMJtXQFDi5MwnUHEJiYMvXjBDLDCQOL2gESwuIWAvMf39VWaQeyQE9CUaj8VChA0lvs/6BlVi
  LnH/cBfbBEbBWUimzkIydQEj0ypG86SizPSMktzEzBxdQwMDXUNDY11jXQu9xCrdRL3UUt3k1
  LySokSgnF5iebFecWVuck6KXl5qySZGYAQxAMEOxnVfEg8xSnIwKYnyWp6/GyXEl5SfUpmRWJ
  wRX1Sak1p8iFGGg0NJgnfTC6CcYFFqempFWmYOMJZh0hIcPEoivKLAeBbiLS5IzC3OTIdInWL
  U5fh3c38vsxBLXn5eqpQ47yeQGQIgRRmleXAjYGnlEqOslDAvI9BRQjwFqUW5mSWo8q8YxTkY
  lYR534JM4cnMK4Hb9AroCCagIzok74AcUZKIkJJqYAy6y/Dqko1hG8t9l9Sp/1+cWvEsm0lAX
  PVfTXglr9pU550cfefa1gfJP3N5tvLrxJkrb0X93nj91t30WS/5PASuznqdJ79H8UiFyavbbp
  Oljab2Sc06rV5+8s+3v8t2H1Y1eePWuTGEcWlJ98Q2p8rXRRv73ljMjjfnSV59z+DJodd/RPe
  95t6lxFKckWioxVxUnAgA8cW8IyYDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-31.tower-223.messagelabs.com!1524492659!751751!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <36488aeca4c870e24ddbcf8bc9d3064c9973413f.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Mon, 23 Apr 2018 15:10:59 +0100
Subject: [PATCH v8 4/6] power: supply: Add 'usb_type' property and supporting
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
X-KSE-Antivirus-Info: Clean, bases: 23/04/2018 11:44:00
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
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
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
index a7984af..ecd68c2 100644
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
index f0139b4..0c9a572 100644
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

