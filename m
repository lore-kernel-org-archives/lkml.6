Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2999314-1524573650-2-14756471733965230143
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524573648; b=f6xrK8gjWN7ds7KUF9Q8njHIkwzArifXlIhJf6LnRJXXHAAq8Y
    xPNkbnIBXoKmBSQfaluiMYc55e7j06hTOfzUkq0jRhIyZBkzqPzWLK8zUTE+gdCu
    ooKRtb7vfiKknvTYh7etk+/rgQdFyojLE0C/ySlR9pexJd1+ZDeliPl2M1LTIr4V
    ZXo89iHtq3VUkkE8KJOC7mYQyqu6Dp0ZejkL0N+VskXLCYBd6iEMBrnzXi+SCHAE
    OAvEc6ICWePkKo+D04/+/7WPM3+s5fa3ySKpBWrT6PuHWBal/ucLdZsK91FV09HE
    ZPelmC1MMYX6b0D1EL+6usnA2OkyQY6J8Saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524573648; bh=V3WZyG1eiWNgTO7O3YXNYXe2WfnrR7
    VPcUj9Kr/Hx9Y=; b=pz4CrI7Kfkm2Fn4lRMTYrzqcyzUJENoui/usc0WBjmefMT
    lsvALhPvesBDVAu/HcHk7ZBi3ofmPmUDCa9gSY/zVO4owqO/H5JNmvAgRn4yoBCL
    ItvDuwKKVbJg9eol27hApFPHSOXiSO/BxsI42d+K5+GItVFQantcPtd2ZIB5cjWw
    UXRa+uhfOTHocnli7agobxrasnm6RAj1KrrorsxysmR3NkGu+klV+1T7lQqn4tpc
    Xjg0gMLOQGqlu8SSTfvyqxFIk1MlwTLxwZjMqccKGGxo6v60r1CawVZ4A28GlMDz
    4z1WKzjYFdbpdXQ/9KzaS778ZJWUPeJRUkQPvRNQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK15ufjdn4/aKnAmGGa9s2eUmW0T9cWef3vVhG54SfTDr/tzYOtSLH2Vw8ogp0HkHMS0PvBLm6Zu0zN19x7wokIQWrePDKlVSw7+ggggkm50JL4Y704j
    AodTyE5R3FfwFZs6hD5HDaiZRv/4Sa+pTvSIwqB30xspugM/zc9Scj7dyYInNb/Nhh5W9LevsPOaM4YmgaEiKxHP84zDF3yl9qjeN90a6CEtgvpRwah6gz+G
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=X3a0BiUdAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=Wfx6FqUvVNG8iojvu1YA:9
    a=vHEYs1PvITFEz6TC:21 a=vUADb7RnNkBvcn-1:21 a=CjuIK1q_8ugA:10
    a=d24Ss_oZLtcA:10 a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756957AbeDXMkn (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 08:40:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:18424 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755196AbeDXMkl (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 24 Apr 2018 08:40:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,322,1520924400";
   d="scan'208";a="49490242"
Date: Tue, 24 Apr 2018 15:40:36 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH v8 2/6] Documentation: power: Initial effort to document
 power_supply ABI
Message-ID: <20180424124036.GD25723@kuha.fi.intel.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
 <262928f7cd04c1691c78993520304f036ba207b2.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <262928f7cd04c1691c78993520304f036ba207b2.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 03:10:57PM +0100, Adam Thomson wrote:
> This commit adds generic ABI information regarding power_supply
> properties. This is an initial attempt to try and align the usage
> of these properties between drivers. As part of this commit,
> common Battery and USB related properties have been listed.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Thank you a lot for doing this Adam! FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  Documentation/ABI/testing/sysfs-class-power | 443 ++++++++++++++++++++++++++++
>  MAINTAINERS                                 |   1 +
>  2 files changed, 444 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index f85ce9e..e046566 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -1,3 +1,446 @@
> +===== General Properties =====
> +
> +What:		/sys/class/power_supply/<supply_name>/manufacturer
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the name of the device manufacturer.
> +
> +		Access: Read
> +		Valid values: Represented as string
> +
> +What:		/sys/class/power_supply/<supply_name>/model_name
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the name of the device model.
> +
> +		Access: Read
> +		Valid values: Represented as string
> +
> +What:		/sys/class/power_supply/<supply_name>/serial_number
> +Date:		January 2008
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the serial number of the device.
> +
> +		Access: Read
> +		Valid values: Represented as string
> +
> +What:		/sys/class/power_supply/<supply_name>/type
> +Date:		May 2010
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Describes the main type of the supply.
> +
> +		Access: Read
> +		Valid values: "Battery", "UPS", "Mains", "USB"
> +
> +===== Battery Properties =====
> +
> +What:		/sys/class/power_supply/<supply_name>/capacity
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Fine grain representation of battery capacity.
> +		Access: Read
> +		Valid values: 0 - 100 (percent)
> +
> +What:		/sys/class/power_supply/<supply_name>/capacity_alert_max
> +Date:		July 2012
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Maximum battery capacity trip-wire value where the supply will
> +		notify user-space of the event. This is normally used for the
> +		battery discharging scenario where user-space needs to know the
> +		battery has dropped to an upper level so it can take
> +		appropriate action (e.g. warning user that battery level is
> +		low).
> +
> +		Access: Read, Write
> +		Valid values: 0 - 100 (percent)
> +
> +What:		/sys/class/power_supply/<supply_name>/capacity_alert_min
> +Date:		July 2012
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Minimum battery capacity trip-wire value where the supply will
> +		notify user-space of the event. This is normally used for the
> +		battery discharging scenario where user-space needs to know the
> +		battery has dropped to a lower level so it can take
> +		appropriate action (e.g. warning user that battery level is
> +		critically low).
> +
> +		Access: Read, Write
> +		Valid values: 0 - 100 (percent)
> +
> +What:		/sys/class/power_supply/<supply_name>/capacity_level
> +Date:		June 2009
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Coarse representation of battery capacity.
> +
> +		Access: Read
> +		Valid values: "Unknown", "Critical", "Low", "Normal", "High",
> +			      "Full"
> +
> +What:		/sys/class/power_supply/<supply_name>/current_avg
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports an average IBAT current reading for the battery, over a
> +		fixed period. Normally devices will provide a fixed interval in
> +		which they average readings to smooth out the reported value.
> +
> +		Access: Read
> +		Valid values: Represented in microamps
> +
> +What:		/sys/class/power_supply/<supply_name>/current_max
> +Date:		October 2010
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the maximum IBAT current allowed into the battery.
> +
> +		Access: Read
> +		Valid values: Represented in microamps
> +
> +What:		/sys/class/power_supply/<supply_name>/current_now
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports an instant, single IBAT current reading for the battery.
> +		This value is not averaged/smoothed.
> +
> +		Access: Read
> +		Valid values: Represented in microamps
> +
> +What:		/sys/class/power_supply/<supply_name>/charge_type
> +Date:		July 2009
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Represents the type of charging currently being applied to the
> +		battery.
> +
> +		Access: Read
> +		Valid values: "Unknown", "N/A", "Trickle", "Fast"
> +
> +What:		/sys/class/power_supply/<supply_name>/charge_term_current
> +Date:		July 2014
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the charging current value which is used to determine
> +		when the battery is considered full and charging should end.
> +
> +		Access: Read
> +		Valid values: Represented in microamps
> +
> +What:		/sys/class/power_supply/<supply_name>/health
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the health of the battery or battery side of charger
> +		functionality.
> +
> +		Access: Read
> +		Valid values: "Unknown", "Good", "Overheat", "Dead",
> +			      "Over voltage", "Unspecified failure", "Cold",
> +			      "Watchdog timer expire", "Safety timer expire"
> +
> +What:		/sys/class/power_supply/<supply_name>/precharge_current
> +Date:		June 2017
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the charging current applied during pre-charging phase
> +		for a battery charge cycle.
> +
> +		Access: Read
> +		Valid values: Represented in microamps
> +
> +What:		/sys/class/power_supply/<supply_name>/present
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports whether a battery is present or not in the system.
> +
> +		Access: Read
> +		Valid values:
> +			0: Absent
> +			1: Present
> +
> +What:		/sys/class/power_supply/<supply_name>/status
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Represents the charging status of the battery. Normally this
> +		is read-only reporting although for some supplies this can be
> +		used to enable/disable charging to the battery.
> +
> +		Access: Read, Write
> +		Valid values: "Unknown", "Charging", "Discharging",
> +			      "Not charging", "Full"
> +
> +What:		/sys/class/power_supply/<supply_name>/technology
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Describes the battery technology supported by the supply.
> +
> +		Access: Read
> +		Valid values: "Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe",
> +			      "NiCd", "LiMn"
> +
> +What:		/sys/class/power_supply/<supply_name>/temp
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the current TBAT battery temperature reading.
> +
> +		Access: Read
> +		Valid values: Represented in 1/10 Degrees Celsius
> +
> +What:		/sys/class/power_supply/<supply_name>/temp_alert_max
> +Date:		July 2012
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Maximum TBAT temperature trip-wire value where the supply will
> +		notify user-space of the event. This is normally used for the
> +		battery charging scenario where user-space needs to know the
> +		battery temperature has crossed an upper threshold so it can
> +		take appropriate action (e.g. warning user that battery level is
> +		critically high, and charging has stopped).
> +
> +		Access: Read
> +		Valid values: Represented in 1/10 Degrees Celsius
> +
> +What:		/sys/class/power_supply/<supply_name>/temp_alert_min
> +Date:		July 2012
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Minimum TBAT temperature trip-wire value where the supply will
> +		notify user-space of the event. This is normally used for the
> +		battery charging scenario where user-space needs to know the
> +		battery temperature has crossed a lower threshold so it can take
> +		appropriate action (e.g. warning user that battery level is
> +		high, and charging current has been reduced accordingly to
> +		remedy the situation).
> +
> +		Access: Read
> +		Valid values: Represented in 1/10 Degrees Celsius
> +
> +What:		/sys/class/power_supply/<supply_name>/temp_max
> +Date:		July 2014
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the maximum allowed TBAT battery temperature for
> +		charging.
> +
> +		Access: Read
> +		Valid values: Represented in 1/10 Degrees Celsius
> +
> +What:		/sys/class/power_supply/<supply_name>/temp_min
> +Date:		July 2014
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the minimum allowed TBAT battery temperature for
> +		charging.
> +
> +		Access: Read
> +		Valid values: Represented in 1/10 Degrees Celsius
> +
> +What:		/sys/class/power_supply/<supply_name>/voltage_avg,
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports an average VBAT voltage reading for the battery, over a
> +		fixed period. Normally devices will provide a fixed interval in
> +		which they average readings to smooth out the reported value.
> +
> +		Access: Read
> +		Valid values: Represented in microvolts
> +
> +What:		/sys/class/power_supply/<supply_name>/voltage_max,
> +Date:		January 2008
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the maximum safe VBAT voltage permitted for the battery,
> +		during charging.
> +
> +		Access: Read
> +		Valid values: Represented in microvolts
> +
> +What:		/sys/class/power_supply/<supply_name>/voltage_min,
> +Date:		January 2008
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the minimum safe VBAT voltage permitted for the battery,
> +		during discharging.
> +
> +		Access: Read
> +		Valid values: Represented in microvolts
> +
> +What:		/sys/class/power_supply/<supply_name>/voltage_now,
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports an instant, single VBAT voltage reading for the battery.
> +		This value is not averaged/smoothed.
> +
> +		Access: Read
> +		Valid values: Represented in microvolts
> +
> +===== USB Properties =====
> +
> +What: 		/sys/class/power_supply/<supply_name>/current_avg
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports an average IBUS current reading over a fixed period.
> +		Normally devices will provide a fixed interval in which they
> +		average readings to smooth out the reported value.
> +
> +		Access: Read
> +		Valid values: Represented in microamps
> +
> +
> +What: 		/sys/class/power_supply/<supply_name>/current_max
> +Date:		October 2010
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the maximum IBUS current the supply can support.
> +
> +		Access: Read
> +		Valid values: Represented in microamps
> +
> +What: 		/sys/class/power_supply/<supply_name>/current_now
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the IBUS current supplied now. This value is generally
> +		read-only reporting, unless the 'online' state of the supply
> +		is set to be programmable, in which case this value can be set
> +		within the reported min/max range.
> +
> +		Access: Read, Write
> +		Valid values: Represented in microamps
> +
> +What:		/sys/class/power_supply/<supply_name>/input_current_limit
> +Date:		July 2014
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Details the incoming IBUS current limit currently set in the
> +		supply. Normally this is configured based on the type of
> +		connection made (e.g. A configured SDP should output a maximum
> +		of 500mA so the input current limit is set to the same value).
> +
> +		Access: Read, Write
> +		Valid values: Represented in microamps
> +
> +What:		/sys/class/power_supply/<supply_name>/online,
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Indicates if VBUS is present for the supply. When the supply is
> +		online, and the supply allows it, then it's possible to switch
> +		between online states (e.g. Fixed -> Programmable for a PD_PPS
> +		USB supply so voltage and current can be controlled).
> +
> +		Access: Read, Write
> +		Valid values:
> +			0: Offline
> +			1: Online Fixed - Fixed Voltage Supply
> +			2: Online Programmable - Programmable Voltage Supply
> +
> +What:		/sys/class/power_supply/<supply_name>/temp
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the current supply temperature reading. This would
> +		normally be the internal temperature of the device itself (e.g
> +		TJUNC temperature of an IC)
> +
> +		Access: Read
> +		Valid values: Represented in 1/10 Degrees Celsius
> +
> +What:		/sys/class/power_supply/<supply_name>/temp_alert_max
> +Date:		July 2012
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Maximum supply temperature trip-wire value where the supply will
> +		notify user-space of the event. This is normally used for the
> +		charging scenario where user-space needs to know the supply
> +		temperature has crossed an upper threshold so it can take
> +		appropriate action (e.g. warning user that the supply
> +		temperature is critically high, and charging has stopped to
> +		remedy the situation).
> +
> +		Access: Read
> +		Valid values: Represented in 1/10 Degrees Celsius
> +
> +What:		/sys/class/power_supply/<supply_name>/temp_alert_min
> +Date:		July 2012
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Minimum supply temperature trip-wire value where the supply will
> +		notify user-space of the event. This is normally used for the
> +		charging scenario where user-space needs to know the supply
> +		temperature has crossed a lower threshold so it can take
> +		appropriate action (e.g. warning user that the supply
> +		temperature is high, and charging current has been reduced
> +		accordingly to remedy the situation).
> +
> +		Access: Read
> +		Valid values: Represented in 1/10 Degrees Celsius
> +
> +What:		/sys/class/power_supply/<supply_name>/temp_max
> +Date:		July 2014
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the maximum allowed supply temperature for operation.
> +
> +		Access: Read
> +		Valid values: Represented in 1/10 Degrees Celsius
> +
> +What:		/sys/class/power_supply/<supply_name>/temp_min
> +Date:		July 2014
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the mainimum allowed supply temperature for operation.
> +
> +		Access: Read
> +		Valid values: Represented in 1/10 Degrees Celsius
> +
> +What: 		/sys/class/power_supply/<supply_name>/voltage_max
> +Date:		January 2008
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the maximum VBUS voltage the supply can support.
> +
> +		Access: Read
> +		Valid values: Represented in microvolts
> +
> +What: 		/sys/class/power_supply/<supply_name>/voltage_min
> +Date:		January 2008
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the minimum VBUS voltage the supply can support.
> +
> +		Access: Read
> +		Valid values: Represented in microvolts
> +
> +What: 		/sys/class/power_supply/<supply_name>/voltage_now
> +Date:		May 2007
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the VBUS voltage supplied now. This value is generally
> +		read-only reporting, unless the 'online' state of the supply
> +		is set to be programmable, in which case this value can be set
> +		within the reported min/max range.
> +
> +		Access: Read, Write
> +		Valid values: Represented in microvolts
> +
> +===== Device Specific Properties =====
> +
>  What:		/sys/class/power/ds2760-battery.*/charge_now
>  Date:		May 2010
>  KernelVersion:	2.6.35
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a1410d..700bfb7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11242,6 +11242,7 @@ M:	Sebastian Reichel <sre@kernel.org>
>  L:	linux-pm@vger.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-class-power
>  F:	Documentation/devicetree/bindings/power/supply/
>  F:	include/linux/power_supply.h
>  F:	drivers/power/supply/
> -- 
> 1.9.1

-- 
heikki
