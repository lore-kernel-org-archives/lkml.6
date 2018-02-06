Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1507316-1517932307-2-9797988727622644535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517932306; b=irCpyiXgnKx90gwNpXx8FjVpxReBHWudetZqTxmShX0i4t1
    U9VhsuOz5wt9Xhkqk5VlqCM9geWbrpka8gX31/6d95ssxPYKbqNUtk8ub+z+DYbh
    c4Qo1OClQ2+A/j1NFsUQKuU3ybpn2dB06ItG+JMEapSrELTCSV9ev+tWoXFoN8Ck
    +CyGjfxev7nsQdg3kRVOqGoplSwjimkoumw8maKM9tzBVvogPSz9xpNh15/dAcnS
    2prX7XanFm4GTdklkCDH155F9T1pu2U3E4eDr+i5xbc0MfwWkF/dR8mUFO+1KTHz
    FGvAbCSpe9KvOzPXjrEq1UnnnMbTVvDj1ZuIH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517932306; bh=JmyD2Q
    kNIBBhA+Iczbv/PNnmeTuSs0RetQiyz62tTlo=; b=R6qPJ29e4AM4umCIpMoc1I
    k8RVHev8reSAnCWBWtVSfoMhYyX7bbygRyhaD7GArNSbrRZ/cIq3UcAVVu2v2zaG
    72lW/LfOr4K6iMnojQlVvt/w3kfn9i362u6UQngfXblyIVfYhhPs5gFwjmgHJrtH
    QqIoz6zeUfFNRylOifmm+nH5OFWI6kUrqwC4nz+K23oPDLurPHGMI668gMc5pB24
    w3YuJUtBh9SfmaQ0my1xURY3x3fDvnzH+LZEnWkP2xRR+pY+uaWx9OEhYIteHnxH
    8jta+IpR7oAjMSDLJMQBmwTba5tZNIUgNBiaOIlUGhu8kTA2yGObxsSr5rxWRNug
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeBFPvm convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 6 Feb 2018 10:51:42 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:3421 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752496AbeBFPvj (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Feb 2018 10:51:39 -0500
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRWlGSWpSXmKPExsUSt3OpsS77+co
  og6vnuSyaF69ns3hzfDqTRdfqnSwWl3fNYbP43HuE0WLRslZmiycLzzBZNC54z2JxeneJxZ/n
  t9gcuDx2zrrL7rFpVSebx7yTgR77565h93i/7yqbx87vDewenzfJBbBHsWbmJeVXJLBmfJj8k
  r3gsWXF7FkHmRoYP+t1MXJxCAksZZTonbeMrYuRk4NNwEJi8okHYLaIQB+jxJQZXCBFzAIbmC
  XmHznDApIQFoiRmPNvKyNEUazEkr8PmSFsK4kVUycxgdgsAioSl49tYAWxeQUCJFY+X8YMse0
  io8TVJ0fBBnEKmEucetwN1swoICvxpXE1mM0sIC5x68l8sEESAgISS/acZ4awRSVePv7HCmHL
  S2z/9psdwraXeH3vHdBMDiBbX6KvsRgibCixatoBFgjbXGLC34nsEON1JBbs/sQGYWtLLFv4m
  hniTkGJkzOfsExgFJ+F5IpZSFpmIWmZhaRlASPLKkbLpKLM9IyS3MTMHF1DAwNdQ0NjXWNdIx
  NjvcQq3US91FLd5NS8kqJEoKxeYnmxXnFlbnJOil5easkmRmBKYACCHYxz5yQeYpTkYFIS5U2
  dUhElxJeUn1KZkVicEV9UmpNafIhRhoNDSYL32dnKKCHBotT01Iq0zBxgcoJJS3DwKInwXgJJ
  8xYXJOYWZ6ZDpE4x6nLcePG6jVmIJS8/L1VKnFf1HFCRAEhRRmke3AhYorzEKCslzMsIdJQQT
  0FqUW5mCar8K0ZxDkYlYd4XIKt4MvNK4Da9AjqCCeiIG0FgR5QkIqSkGhhl3grIn5zp8mcrv+
  KeUiVluzkcp71zvvR1sX1dycp6e7IHr9Nifv+3aUWHVNK2vnjBvXbT+akmV34tnPdOfIeFGKv
  ihuCthsmGATNSDKxtWw793qZSdNLtTU/IiuLg+BlrmbRXbt5iZ/P9rdaj2+13v77szY7w9vgk
  WP+4XOaUdF1usvfB99lKLMUZiYZazEXFiQCFUjW7jwMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-4.tower-223.messagelabs.com!1517932288!1288134!1
X-Originating-IP: [94.185.165.51]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC: Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Yueyao Zhu <yueyao.zhu@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Support Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v4 6/7] typec: tcpm: Represent source supply through
 power_supply class
Thread-Topic: [PATCH v4 6/7] typec: tcpm: Represent source supply through
 power_supply class
Thread-Index: AQHTg+F5XO5kK7PtjE+aSt2wVOZO/aOMj+2AgAsl/sA=
Date: Tue, 6 Feb 2018 15:51:26 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1C1595@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <e2cb104f53e20a01f3b44442068c549e5d0e1ac3.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
 <20180130131131.GF14922@kuha.fi.intel.com>
In-Reply-To: <20180130131131.GF14922@kuha.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 06/02/2018 13:23:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 30 January 2018 13:12, Heikki Krogerus wrote:

> Hi Adam,
>
> On Tue, Jan 02, 2018 at 03:50:54PM +0000, Adam Thomson wrote:
> > This commit adds a power_supply class instance to represent a
> > PD source's voltage and current properties. This provides an
> > interface for reading these properties from user-space or other
> > drivers.
> >
> > For PPS enabled Sources, this also provides write access to set
> > the current and voltage and allows for swapping between standard
> > PDO and PPS APDO.
> >
> > As this represents a superset of the information provided in the
> > fusb302 driver, the power_supply instance in that code is removed
> > as part of this change, so reverting the commit titled
> > 'typec: tcpm: Represent source supply through power_supply class'
>
>
>
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > ---
> >  .../ABI/testing/sysfs-class-power-tcpm-source-psy  |  92 ++++++++
> >  drivers/usb/typec/Kconfig                          |   1 +
> >  drivers/usb/typec/fusb302/Kconfig                  |   2 +-
> >  drivers/usb/typec/fusb302/fusb302.c                |  63 +-----
> >  drivers/usb/typec/tcpm.c                           | 233 ++++++++++++++++++++-
> >  5 files changed, 328 insertions(+), 63 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-power-tcpm-source-
> psy
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-power-tcpm-source-psy
> b/Documentation/ABI/testing/sysfs-class-power-tcpm-source-psy
> > new file mode 100644
> > index 0000000..4986cba
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-power-tcpm-source-psy
> > @@ -0,0 +1,92 @@
> > +What: 		/sys/class/power_supply/tcpm-source-psy/type
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-only property describes the main type of source supply.
> > +	Type-C is a USB standard so this property always returns "USB".
> > +
> > +What: 		/sys/class/power_supply/tcpm-source-psy/connected_type
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-only property describes the type of source supply that is
> > +	connected, if the supply is online. The value is always Type C
> > +	unless a source has been attached which is identified as USB-PD capable.
> > +
> > +	Valid values:
> > +		- "USB_TYPE_C"	: Type C connected supply, not UBS-PD capable
> > +				  (default value)
> > +		- "USB_PD"	: USB-PD capable source supply connected
> > +		- "USB_PD_PPS"	: USB-PD PPS capable source supply connected
> > +
> > +What: 		/sys/class/power_supply/tcpm-source-psy/online
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-write property describes the online state of the source
> > +	supply. When the value of this property is not 0, and the supply allows
> > +	it, then it's possible to switch between online states (i.e. 1 -> 2,
> > +	2 -> 1)
> > +
> > +	Valid values:
> > +		- 0	: Offline, no source supply attached
> > +		- 1	: Fixed Online, Type-C or USB-PD capable supply
> > +			  attached, non-configurable current and voltage
> > +			  properties in this state.
> > +		- 2	: PPS Online, USB-PD PPS feature enabled, 'current_now'
> > +			  and 'voltage_now' properties can be modified in this
> > +			  state. Re-writing of this value again, once already
> > +			  set, will re-request the same configured voltage and
> > +			  current values. This can be used as a keep-alive for
> > +			  the PPS connection.
> > +			  [NOTE: This is value only selectable if
> > +			   'connected_type' reports a value of "USB_PD_PPS"]
> > +
> > +What: 		/sys/class/power_supply/tcpm-source-psy/voltage_min
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-only property describes the minimum voltage the source supply
> > +	can provide.
> > +
> > +	Value in microvolts.
> > +
> > +What: 		/sys/class/power_supply/tcpm-source-psy/voltage_max
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-only property describes the maximum voltage the source supply
> > +	can provide.
> > +
> > +	Value in microvolts.
> > +
> > +What: 		/sys/class/power_supply/tcpm-source-psy/voltage_now
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-write property describes the voltage the source supply is
> > +	providing now. This property can only be written to if the source supply
> > +	is in online state '2' (PPS enabled), otherwise it's read-only
> > +	information.
> > +
> > +	Value in microvolts.
> > +
> > +What: 		/sys/class/power_supply/tcpm-source-psy/current_max
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-only property describes the maximum current the source supply
> > +	can provide.
> > +
> > +	Value in microamps.
> > +
> > +What: 		/sys/class/power_supply/tcpm-source-psy/current_now
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-write property describes the current the source supply can
> > +	provide now. This property can only be written to if the source supply
> > +	is in online state '2' (PPS enabled), otherwise it's read-only
> > +	information.
> > +
> > +	Value in microamps.
>
> I think those should be documented for the entire psy class, not just
> for this driver.

Right now there is no documentation for the generic psy class. The stuff in
sysfs-class-power is device specific property information, and the same goes for
sysfs-class-power-twl4030. The property usage can vary depending on driver
implementation, an example being the 'online' property which can differ between
drivers, so the usage I have here is very much tcpm related. Also, the ability
to write to certain properties varies depending on the driver and HW, so here
where we configure 'voltage_now' and 'current_now', the likelihood is that most
other psy driver implementations won't allow for this.

Sebastian, do you have any thoughts on this discussion? Would be useful to get
your input here.

>
> > diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> > index bcb2744..1ef606d 100644
> > --- a/drivers/usb/typec/Kconfig
> > +++ b/drivers/usb/typec/Kconfig
> > @@ -48,6 +48,7 @@ if TYPEC
> >  config TYPEC_TCPM
> >  	tristate "USB Type-C Port Controller Manager"
> >  	depends on USB
> > +	select POWER_SUPPLY
>
> I'm a little bit uncomfortable with such a strong dependency on an
> other subsystem that we may not always need, but let's see what
> Guenter says.

Right now I've used the psy class to represent power information from the
external PD source supply, so for the scenarios where we're the source or a
non-PD device has been attached then this is not going to provide any
information to user-space. I guess in the future we could update to represent
information when we're the PD source as well, although that'll likely be all
just read-only info. Right now, not sure if this is something that would be
useful.

Sebastian, do you seen any problems on the dependency front?
