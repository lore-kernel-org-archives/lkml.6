Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1584206-1521556491-5-8216281341094600260
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
    t=1521556490; b=QQ6XdQgBQdjdgZv4xV1bYGNDUrqRH0bRC5L3kO8K8RaPcEV
    4YylIHHSJ41m+IZxgoOwDtn62x9QbHsJOW9RIrzIQwvUluZaC/2+I9C2w4r7YotM
    5VJNurNQobLcxm2daWy5jXv/F9tK2AYPE6ht55I71CO3DlWFDVAk2i5KVX16e+W/
    mRn1okSVQxzE0lZChFLAdHX32CAn6lIVbFr4htePkshGzU1YEp9XcBoZ/SpJ+NXf
    mV5d6fKwUW91l9odsDWQalH5JB++w0ip0r4r89tIQL//wLIicpKZfkLLs14ILS+8
    ZFhcwxysb5pu9jkelF4yEtVoWRKF7L/hQL+Gvdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :date:subject:to:cc:mime-version:content-type:sender:list-id; s=
    arctest; t=1521556490; bh=ChXn817dUKpwO+Cs+wl0QaELug5ceH7oxOnFCh
    lSnZY=; b=V/H8jqD6Lzx6bBoJHUo42qWB1se7LtJm2LsAZanBAacKhPrX1l5M5g
    GVRTKvsBA4wgZdfN74NLpHUe6fgTak8d2ULr5n8OOKvuFJ109OlIKOH96ZSkhYEU
    xlwEp3FbZafNoZ5g2P5IkQqtNv+afJJxo/6/99Dc7Kkw4DSINfdY185dT9fL0kje
    aGm8Bkg+yPqtS49vk/6Cukg+odrzeXPjOiNWE/rfrkKRW2766UsUdc0YRktatUFA
    S3RDrYvSkfuq2PhJyMSYNhsaTnE43Yb40T8xA9kUlK2crTrGB/P/XAP5O3ZaLEmQ
    NsVKP+gKkbwjE3IuVR8v/jsUdNJfxTEQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeCTOdv (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 10:33:51 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.149]:28711 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750991AbeCTOdr (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Mar 2018 10:33:47 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleJIrShJLcpLzFFi42KJ27nUWPek9MY
  og1fnNS2aF69ns3hzfDqTRdfqnSwW1471Mllc3jWHzeJz7xFGi0XLWpktniw8w2RxeneJA6fH
  plWdbB7zTgZ67J+7ht1j47sdTB7v911l89j5vYHd4/MmuQD2KNbMvKT8igTWjGcdLAX/yyu2P
  /7J3sD4OLWLkYtDSGA9o8TpptXsXYycQE6FxNQ5Z5lBbF6BTIkjh34wgdicAu4Sb37+gKpxkz
  gw6wgbiM0mYCEx+cQDMJtFQFVi9bG5YLawQJTE1OW9TCALRATeM0p8evyBBSTBLFAn0fv7LQv
  EAkGJkzOfQMUlJA6+eMEMscBA4vSCRrC4hIC9xPT3V4HiHEC2vkTjsViIsKHE91nfoErMJRau
  Wsk0gVFwFpKps5BMXcDItIpRvTi1qCy1SNdEL6koMz2jJDcxM0fX0MBULze1uDgxPTUnMalYL
  zk/dxMjMEIYgGAH460+50OMkhxMSqK8nb82RAnxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4D0ltT
  FKSLAoNT21Ii0zBxirMGkJDh4lEd5ikDRvcUFibnFmOkTqFKMux40Xr9uYhVjy8vNSpcR5L4E
  UCYAUZZTmwY2ApY1LjLJSwryMQEcJ8RSkFuVmlqDKv2IU52BUEua9BTKFJzOvBG7TK6AjmICO
  yJ65AeSIkkSElFQDYy9Laba1sW7xO9lSKa/lDLvla//lezq8zvhqosT1uef7udmPVUU25Nr3n
  U+9f0q7MZzHWEqnOD3NQ/Fga9CB18fzd1y7sLXEv1lm2XtpK3upJz+Wcy05FhMS01l+1m7dp+
  j0j1M25J0UluKSPOF14Z9E3qxSqwQp5VQu/hNbJn3eXMBbMDlViaU4I9FQi7moOBEA1++n4RY
  DAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-10.tower-179.messagelabs.com!1521556424!99990328!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <332c75320c6ef1aad7bb31cfc2a78d3d5914714b.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 20 Mar 2018 14:33:44 +0000
Subject: [PATCH v5 2/5] Documentation: power: Initial effort to document
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
X-KSE-Antivirus-Info: Clean, bases: 20/03/2018 12:34:00
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
index 2bee7ac..5bb0a10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11098,6 +11098,7 @@ M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-power
 F:	Documentation/devicetree/bindings/power/supply/
 F:	include/linux/power_supply.h
 F:	drivers/power/supply/
-- 
1.9.1

