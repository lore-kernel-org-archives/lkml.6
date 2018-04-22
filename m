Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406181-2-4995123615219296882
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406180; b=kZlkdKu5vA3tGzf/7KoIYe0UU3ExVAq0G5PGY0T680wUmMN8n6
    +7DXxJgM8h7y0D7aN7+uReVlXnHCRtF4WEFt0m99RegKZqyTBwtZ7acgOIf8kN00
    wXGTnrhMqaEdj/dU4asGfhak0Ii+dke9BFZJwOjLsBAkdLyun37P/J2QDyyFBNwp
    9Y6x4UbufWuuzkP34adxisEZ/pnT9mbKSvFNouhXewx7aiWZcZHW3IpTpBrivvYq
    cohg72aLp2CLsjCKhQPfK+Y/UP5kmh+hdGB0wCpDfCaRDwoBRmyTunrQI9kvgA2p
    O5UvpAKR/zBET6mamAEMwVwrOfHGtzYU/dxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406180; bh=xgWb9Cei7yACa2p6EjG7iBpc3IqkZo
    3C9tafzvXwBCo=; b=X2hmRASKUlfCM/WbK9gZNzzo54zmlwIlERJAQHcMQeoxAk
    eY6RwdWNF9NW0sQoxezEBUv4Y+q+hM4ShGWm3EO0caw1qeGbeFVYUX4g4avmSnYW
    t0JXF5LuhmS0SCsj30ofvAjOOtotuXz9kLRSWg0BMDU78e8vOs9ac+Z2/rOBFZX7
    XkQ/tm+Od024PyDn+BfPTSCjXjhPSZBrU/60s3f0RBsAFeotPwjf6dU+wHMkCDM3
    7qIyrqT4hnTPmQd6SqiLeD1KTugFyIkpFeTFmOHf70637C9osXodtz44ZQ0XWlzn
    1k/3p0UM6RcMGWGyhbqobHV/6tD1tpJhUE/q5hEg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJmHjfLhxCAmCiFtRmrJ8ayy1lg8AZZ09qpVDrXC4w1hKpIl7yrjIjs4hw9Sf2Pry2bgAjFGolg1YeKuk1RKdu5ntLuWPRoRYQtMKPe3frXGRoG0XVK3
    WYbuMgZuh1wJP0fQ+1BZG5mU0TGVexleDf2Srm15ZT/76jubszbRouXXgnnER/7M3DBaZOvljHgOuNFKktMbAhcBluCTQHp0x2sWf6ClPkoCbHbejBUdpxQO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=-L87lNefAAAA:8 a=ag1SF4gXAAAA:8
    a=DSCvu7sMhv0pLIhlrGQA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=NKrCwogH1dEa4ZHz75xc:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756140AbeDVOJf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:09:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53188 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756143AbeDVOJc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:09:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.14 138/164] HID: input: fix battery level reporting on BT mice
Date: Sun, 22 Apr 2018 15:53:25 +0200
Message-Id: <20180422135141.072765397@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 2e210bbb7429cdcf1a1a3ad00c1bf98bd9bf2452 upstream.

The commit 581c4484769e ("HID: input: map digitizer battery usage")
assumed that devices having input (qas opposed to feature) report for
battery strength would report the data on their own, without the need to
be polled by the kernel; unfortunately it is not so. Many wireless mice
do not send unsolicited reports with battery strength data and have to
be polled explicitly. As a complication, stylus devices on digitizers
are not normally connected to the base and thus can not be polled - the
base can only determine battery strength in the stylus when it is in
proximity.

To solve this issue, we add a special flag that tells the kernel
to avoid polling the device (and expect unsolicited reports) and set it
when report field with physical usage of digitizer stylus (HID_DG_STYLUS).
Unless this flag is set, and we have not seen the unsolicited reports,
the kernel will attempt to poll the device when userspace attempts to
read "capacity" and "state" attributes of power_supply object
corresponding to the devices battery.

Fixes: 581c4484769e ("HID: input: map digitizer battery usage")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198095
Cc: stable@vger.kernel.org
Reported-and-tested-by: Martin van Es <martin@mrvanes.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-input.c |   24 +++++++++++++++++-------
 include/linux/hid.h     |    9 ++++++++-
 2 files changed, 25 insertions(+), 8 deletions(-)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -387,7 +387,8 @@ static int hidinput_get_battery_property
 		break;
 
 	case POWER_SUPPLY_PROP_CAPACITY:
-		if (dev->battery_report_type == HID_FEATURE_REPORT) {
+		if (dev->battery_status != HID_BATTERY_REPORTED &&
+		    !dev->battery_avoid_query) {
 			value = hidinput_query_battery_capacity(dev);
 			if (value < 0)
 				return value;
@@ -403,17 +404,17 @@ static int hidinput_get_battery_property
 		break;
 
 	case POWER_SUPPLY_PROP_STATUS:
-		if (!dev->battery_reported &&
-		    dev->battery_report_type == HID_FEATURE_REPORT) {
+		if (dev->battery_status != HID_BATTERY_REPORTED &&
+		    !dev->battery_avoid_query) {
 			value = hidinput_query_battery_capacity(dev);
 			if (value < 0)
 				return value;
 
 			dev->battery_capacity = value;
-			dev->battery_reported = true;
+			dev->battery_status = HID_BATTERY_QUERIED;
 		}
 
-		if (!dev->battery_reported)
+		if (dev->battery_status == HID_BATTERY_UNKNOWN)
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		else if (dev->battery_capacity == 100)
 			val->intval = POWER_SUPPLY_STATUS_FULL;
@@ -486,6 +487,14 @@ static int hidinput_setup_battery(struct
 	dev->battery_report_type = report_type;
 	dev->battery_report_id = field->report->id;
 
+	/*
+	 * Stylus is normally not connected to the device and thus we
+	 * can't query the device and get meaningful battery strength.
+	 * We have to wait for the device to report it on its own.
+	 */
+	dev->battery_avoid_query = report_type == HID_INPUT_REPORT &&
+				   field->physical == HID_DG_STYLUS;
+
 	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(dev->battery)) {
 		error = PTR_ERR(dev->battery);
@@ -530,9 +539,10 @@ static void hidinput_update_battery(stru
 
 	capacity = hidinput_scale_battery_capacity(dev, value);
 
-	if (!dev->battery_reported || capacity != dev->battery_capacity) {
+	if (dev->battery_status != HID_BATTERY_REPORTED ||
+	    capacity != dev->battery_capacity) {
 		dev->battery_capacity = capacity;
-		dev->battery_reported = true;
+		dev->battery_status = HID_BATTERY_REPORTED;
 		power_supply_changed(dev->battery);
 	}
 }
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -512,6 +512,12 @@ enum hid_type {
 	HID_TYPE_USBNONE
 };
 
+enum hid_battery_status {
+	HID_BATTERY_UNKNOWN = 0,
+	HID_BATTERY_QUERIED,		/* Kernel explicitly queried battery strength */
+	HID_BATTERY_REPORTED,		/* Device sent unsolicited battery strength report */
+};
+
 struct hid_driver;
 struct hid_ll_driver;
 
@@ -554,7 +560,8 @@ struct hid_device {							/* device repo
 	__s32 battery_max;
 	__s32 battery_report_type;
 	__s32 battery_report_id;
-	bool battery_reported;
+	enum hid_battery_status battery_status;
+	bool battery_avoid_query;
 #endif
 
 	unsigned int status;						/* see STAT flags above */
