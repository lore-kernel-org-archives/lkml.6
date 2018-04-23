Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1286548-1524492865-2-13822288438695723151
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
    1524492864; b=XYDtnj4/duzwDh/o6wtr00GPjcYYXuc+C79cH/Bj1iqZ+SJZ5H
    DceRN50kb0ufYRBCHX42Og3BpdZhL1Xsiqn+4A5XXwYbyB7MZEIE/+EztlEI4mbp
    M/x8Xk7XwBe9zwZ0xWvAEWFHKQSzWM3/x1Q0ibKv7iiJ4yyUEELt9Fp+NkHIERBJ
    uoz0KpZXngSXoI+9j5xBTU5yMNd1r0uB0w5nbBEfLJ1ZP5eodKBRRGg+2Ic5Cvnx
    fqYzhPTBQ0ESN4rhG7ze0Qn09wpjNfBQXk3UyWY+jSfKN0U6agW8LaIkHL9nxdQy
    CbBYPFtD+rCG+KXw5kxesEHp4XpJCMHFHDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :date:subject:to:cc:mime-version:content-type:sender:list-id; s=
    fm2; t=1524492864; bh=mrE3EzwzDTd/c3dljp1V78wu15SdxlPbAtoqQw/Vom
    c=; b=dT47e+7FJUYO17sRE36yyNz6NOg3KjhpoxLq9IDkSxjURZ6uU6HoPvwGre
    7midxHz/XsreV8MIdIVcgAK3Y6bujL86yckJQW1AeL/w/9iOxcqvzoY008NtDWTa
    IL9NxBztXU3AR0Fc3v7/KHFHh3eUGXupTESC/HH6A5DcPB95C1wj2TDYZtPR0hSo
    luANhS+1DiVawF47HNjGS3YAg7P4wRqVwQ5VAyoJBvRSRTYlXpdUmnLcMMGgW+lS
    Eoej2wyUwTZUhPOxlzyP/SK0E0hCz2jyUMmi+3gymUAcIk5/fAVBQ3V/YZ+5Hep2
    B0Zc+bczrKAFtyzAPZwoGjAcqdyg==
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
X-CM-Envelope: MS4wfHSItJHFNWtcogBshjQCdrbITSAZPcxn8arkv4mjQMS4duA8zwCJM0EedHBwriAmZyi2hvTDTjYBFwO7KvzoOyUA0tKNxtSUhaBOw4AnytRCtzZAIqUm
    dfidKsaq9IfywkJ48ZSbVRzkA8SmYgyq1iJ+P+ZYRRumClVQxAfJADtU5xnx6ckBcIG13cA056WMBCFTVfFxxNfLL1T4R3+JB3GK41QogPLhiHN4HlC+b4Uo
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=Kd1tUaAdevIA:10
    a=X3a0BiUdAAAA:8 a=VwQbUJbxAAAA:8 a=1oTnwJ4CJyehrDCbU1MA:9
    a=2grzjaLDg0IriL4c:21 a=9upTPQrpya9CoTA_:21 a=d24Ss_oZLtcA:10
    a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755675AbeDWOOU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 10:14:20 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.149]:14397 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755227AbeDWOLA (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 10:11:00 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRWlGSWpSXmKPExsUSt3OpsW7hy7t
  RBvt+m1o0L17PZvHm+HQmi67VO1ksrh3rZbK4vGsOm8Xn3iOMFouWtTJbPFl4hsni9O4SB06P
  Tas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgHsUayZeUn5FQmsGUt2rWIv+F9ec
  fXYB9YGxsepXYycHEIC6xklPkxhhbArJDr27mYDsXkFMiVurdkCFucUcJfonvSRDaLGTeJy2x
  tGEJtNwEJi8okHQHEODhYBVYk5JzRBwsICURI/fi9k72Lk4hAReM8o8enxBxaQBLNAnUTv77c
  sEPMFJU7OfAIVl5A4+OIFM8R8A4nTCxrB4hIC9hLT319lBpkvIaAv0XgsFiJsKPF91jeoEnOJ
  +4e72CYwCs5CMnUWkqkLGJlWMaoXpxaVpRbpGuslFWWmZ5TkJmbm6BoamOrlphYXJ6an5iQmF
  esl5+duYgTGBwMQ7GDc+8/pEKMkB5OSKK/l+btRQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR437
  0AygkWpaanVqRl5gAjFSYtwcGjJMIbB5LmLS5IzC3OTIdInWJUlBLn3QySEABJZJTmwbXBksM
  lRlkpYV5GoEOEeApSi3IzS1DlXzGKczAqCfO+BZnCk5lXAjf9FdBiJqDFHZJ3QBaXJCKkpBoY
  I5X//LT3DzE+Ia74+qvuQ1/7oknd9RPWTLUS2Gfw7njMZvNlqVeUb774msWzOHdD4b/wCffyQ
  ta4nw7WufIgVYLz+OKbCu7dRwMOV+3kWB2xNz6t7vsmX4GyLH/5frZ7ohZcV82NMx8ldt86LX
  ZatJZJ+NTK6p2qX+cL7Tknx9/VM/P2V1sfJZbijERDLeai4kQABS33xQkDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-16.tower-180.messagelabs.com!1524492656!99333180!2
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <262928f7cd04c1691c78993520304f036ba207b2.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Mon, 23 Apr 2018 15:10:57 +0100
Subject: [PATCH v8 2/6] Documentation: power: Initial effort to document
 power_supply ABI
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

This commit adds generic ABI information regarding power_supply
properties. This is an initial attempt to try and align the usage
of these properties between drivers. As part of this commit,
common Battery and USB related properties have been listed.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 Documentation/ABI/testing/sysfs-class-power | 443 ++++++++++++++++++++++++++++
 MAINTAINERS                                 |   1 +
 2 files changed, 444 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index f85ce9e..e046566 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -1,3 +1,446 @@
+===== General Properties =====
+
+What:		/sys/class/power_supply/<supply_name>/manufacturer
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the name of the device manufacturer.
+
+		Access: Read
+		Valid values: Represented as string
+
+What:		/sys/class/power_supply/<supply_name>/model_name
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the name of the device model.
+
+		Access: Read
+		Valid values: Represented as string
+
+What:		/sys/class/power_supply/<supply_name>/serial_number
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the serial number of the device.
+
+		Access: Read
+		Valid values: Represented as string
+
+What:		/sys/class/power_supply/<supply_name>/type
+Date:		May 2010
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Describes the main type of the supply.
+
+		Access: Read
+		Valid values: "Battery", "UPS", "Mains", "USB"
+
+===== Battery Properties =====
+
+What:		/sys/class/power_supply/<supply_name>/capacity
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Fine grain representation of battery capacity.
+		Access: Read
+		Valid values: 0 - 100 (percent)
+
+What:		/sys/class/power_supply/<supply_name>/capacity_alert_max
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum battery capacity trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		battery discharging scenario where user-space needs to know the
+		battery has dropped to an upper level so it can take
+		appropriate action (e.g. warning user that battery level is
+		low).
+
+		Access: Read, Write
+		Valid values: 0 - 100 (percent)
+
+What:		/sys/class/power_supply/<supply_name>/capacity_alert_min
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Minimum battery capacity trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		battery discharging scenario where user-space needs to know the
+		battery has dropped to a lower level so it can take
+		appropriate action (e.g. warning user that battery level is
+		critically low).
+
+		Access: Read, Write
+		Valid values: 0 - 100 (percent)
+
+What:		/sys/class/power_supply/<supply_name>/capacity_level
+Date:		June 2009
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Coarse representation of battery capacity.
+
+		Access: Read
+		Valid values: "Unknown", "Critical", "Low", "Normal", "High",
+			      "Full"
+
+What:		/sys/class/power_supply/<supply_name>/current_avg
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an average IBAT current reading for the battery, over a
+		fixed period. Normally devices will provide a fixed interval in
+		which they average readings to smooth out the reported value.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/current_max
+Date:		October 2010
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum IBAT current allowed into the battery.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/current_now
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an instant, single IBAT current reading for the battery.
+		This value is not averaged/smoothed.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/charge_type
+Date:		July 2009
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Represents the type of charging currently being applied to the
+		battery.
+
+		Access: Read
+		Valid values: "Unknown", "N/A", "Trickle", "Fast"
+
+What:		/sys/class/power_supply/<supply_name>/charge_term_current
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the charging current value which is used to determine
+		when the battery is considered full and charging should end.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/health
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the health of the battery or battery side of charger
+		functionality.
+
+		Access: Read
+		Valid values: "Unknown", "Good", "Overheat", "Dead",
+			      "Over voltage", "Unspecified failure", "Cold",
+			      "Watchdog timer expire", "Safety timer expire"
+
+What:		/sys/class/power_supply/<supply_name>/precharge_current
+Date:		June 2017
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the charging current applied during pre-charging phase
+		for a battery charge cycle.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/present
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports whether a battery is present or not in the system.
+
+		Access: Read
+		Valid values:
+			0: Absent
+			1: Present
+
+What:		/sys/class/power_supply/<supply_name>/status
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Represents the charging status of the battery. Normally this
+		is read-only reporting although for some supplies this can be
+		used to enable/disable charging to the battery.
+
+		Access: Read, Write
+		Valid values: "Unknown", "Charging", "Discharging",
+			      "Not charging", "Full"
+
+What:		/sys/class/power_supply/<supply_name>/technology
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Describes the battery technology supported by the supply.
+
+		Access: Read
+		Valid values: "Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe",
+			      "NiCd", "LiMn"
+
+What:		/sys/class/power_supply/<supply_name>/temp
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the current TBAT battery temperature reading.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_alert_max
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum TBAT temperature trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		battery charging scenario where user-space needs to know the
+		battery temperature has crossed an upper threshold so it can
+		take appropriate action (e.g. warning user that battery level is
+		critically high, and charging has stopped).
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_alert_min
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Minimum TBAT temperature trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		battery charging scenario where user-space needs to know the
+		battery temperature has crossed a lower threshold so it can take
+		appropriate action (e.g. warning user that battery level is
+		high, and charging current has been reduced accordingly to
+		remedy the situation).
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_max
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum allowed TBAT battery temperature for
+		charging.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_min
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the minimum allowed TBAT battery temperature for
+		charging.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/voltage_avg,
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an average VBAT voltage reading for the battery, over a
+		fixed period. Normally devices will provide a fixed interval in
+		which they average readings to smooth out the reported value.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/<supply_name>/voltage_max,
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum safe VBAT voltage permitted for the battery,
+		during charging.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/<supply_name>/voltage_min,
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the minimum safe VBAT voltage permitted for the battery,
+		during discharging.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/<supply_name>/voltage_now,
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an instant, single VBAT voltage reading for the battery.
+		This value is not averaged/smoothed.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+===== USB Properties =====
+
+What: 		/sys/class/power_supply/<supply_name>/current_avg
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an average IBUS current reading over a fixed period.
+		Normally devices will provide a fixed interval in which they
+		average readings to smooth out the reported value.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+
+What: 		/sys/class/power_supply/<supply_name>/current_max
+Date:		October 2010
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum IBUS current the supply can support.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What: 		/sys/class/power_supply/<supply_name>/current_now
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the IBUS current supplied now. This value is generally
+		read-only reporting, unless the 'online' state of the supply
+		is set to be programmable, in which case this value can be set
+		within the reported min/max range.
+
+		Access: Read, Write
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/input_current_limit
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Details the incoming IBUS current limit currently set in the
+		supply. Normally this is configured based on the type of
+		connection made (e.g. A configured SDP should output a maximum
+		of 500mA so the input current limit is set to the same value).
+
+		Access: Read, Write
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/online,
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Indicates if VBUS is present for the supply. When the supply is
+		online, and the supply allows it, then it's possible to switch
+		between online states (e.g. Fixed -> Programmable for a PD_PPS
+		USB supply so voltage and current can be controlled).
+
+		Access: Read, Write
+		Valid values:
+			0: Offline
+			1: Online Fixed - Fixed Voltage Supply
+			2: Online Programmable - Programmable Voltage Supply
+
+What:		/sys/class/power_supply/<supply_name>/temp
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the current supply temperature reading. This would
+		normally be the internal temperature of the device itself (e.g
+		TJUNC temperature of an IC)
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_alert_max
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum supply temperature trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		charging scenario where user-space needs to know the supply
+		temperature has crossed an upper threshold so it can take
+		appropriate action (e.g. warning user that the supply
+		temperature is critically high, and charging has stopped to
+		remedy the situation).
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_alert_min
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Minimum supply temperature trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		charging scenario where user-space needs to know the supply
+		temperature has crossed a lower threshold so it can take
+		appropriate action (e.g. warning user that the supply
+		temperature is high, and charging current has been reduced
+		accordingly to remedy the situation).
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_max
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum allowed supply temperature for operation.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_min
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the mainimum allowed supply temperature for operation.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What: 		/sys/class/power_supply/<supply_name>/voltage_max
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum VBUS voltage the supply can support.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What: 		/sys/class/power_supply/<supply_name>/voltage_min
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the minimum VBUS voltage the supply can support.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What: 		/sys/class/power_supply/<supply_name>/voltage_now
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the VBUS voltage supplied now. This value is generally
+		read-only reporting, unless the 'online' state of the supply
+		is set to be programmable, in which case this value can be set
+		within the reported min/max range.
+
+		Access: Read, Write
+		Valid values: Represented in microvolts
+
+===== Device Specific Properties =====
+
 What:		/sys/class/power/ds2760-battery.*/charge_now
 Date:		May 2010
 KernelVersion:	2.6.35
diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d..700bfb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11242,6 +11242,7 @@ M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-power
 F:	Documentation/devicetree/bindings/power/supply/
 F:	include/linux/power_supply.h
 F:	drivers/power/supply/
-- 
1.9.1

