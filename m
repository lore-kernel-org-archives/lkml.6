Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-838514-1520873619-2-4412681207007659466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520873618; b=bdekeMhiY1yDNl3h6yFe2wuUQeTAWFPMuG8ri0oC+04/Rqb
    AgqSQ2QUQOxdTDf5I6aAAZ1wLsBvyLoC/8E98uZ7VfZRZJ+im5sdACIeFtK2LGz7
    2VVV/Ph0HPncg/sw4A8e6yLBvDa8EDyPmMoSLQtvINKtYaCeKPtDzCVETbMa08bh
    YrXnPegIGOdHwYRx7mV23snWhYUpotwbN8E+fqDHtZLIZAteRW/gq43pcm5drast
    iIF6iFWcJwGMijjBMUerecHSL5oQo1skzNs4beWAMi35yShCGFhnWSRQXH9gpMhl
    QB0qSG0HpRzmMffbmPc3Yrz78pYYasEDTakWb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520873618; bh=C8rGVI7bGNn3pgcIygjUEXExMBocl7WBILmyfPP0EeI=; b=J
    NLeo1Uiw0zzGcKy2Y1XXbN1kXfrZvwcTKRnzHDn9+NOwxbVVpN4gQHKDyGE64Jje
    nKKCb0NutzsKy99OLF/WEX6aqjMJZWOkARh9k1Wd01rFXHRwrVx7XZ0u4p++/N6L
    1Bd2WMGhMdKACV++Q9ZkAWbEDqhrN+WVR//yDGtQ2BHKBq0VRTGGuChk8bTxARiB
    kaAWalgInclthkXg6JSA6swOixhK57rXrxWecoFprBI7h1cRefDkQixVttK7Hk4H
    uf029vCgx8dn4hk13+LGXODnbCqV8RFQnthnx33wohY+lupluwsX+adHEwQKf6iF
    pqPoIC+tHagOYu2FOJx4A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GCoX83dO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GCoX83dO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbeCLQxX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 12:53:23 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34014 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeCLQxW (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 12 Mar 2018 12:53:22 -0400
X-Google-Smtp-Source: AG47ELtT4kWIjWiy+hPrqbLlYvrS1/BJFCZBOTlu1yu8Q+ErLxwoxCovmASyvWqf+scJbCxJtwUpfw==
Subject: Re: [PATCH v7 00/12] USB Type-C device-connection, mux and switch
 support
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <02ac8e27-9e42-63a1-2305-d333f65b16f6@redhat.com>
Date: Mon, 12 Mar 2018 17:53:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 12-03-18 15:34, Heikki Krogerus wrote:
> Hi,
> 
> This is version 7 of Hans' and my series introducing support for USB muxes and
> generic device-connections. The api naming for device-connections is now made
> according to proposal from Greg, connection.h is dropped and the prototypes are
> now in device.h. kbuild test robot <fengguang.wu@intel.com> also found stylistic
> problems from patches 9/12 and 10/12 which were fixed. The patch 4/12 ("usb:
> typec: Separate the definitions for data and power roles") was added to the
> series.

Thanks.

I've given this new series a quick test run and it works for me :)

Regards,

Hans




> 
> Check the v6 from here:
> https://lkml.org/lkml/2018/3/2/340
> 
> 
> Here is the cover-letter of v6:
> 
> Hi All,
> 
> Here is version 6 of Heikki's and my USB Type-C device-connection, mux and
> switch support series. Versions 2 - 5 bring various small code and style
> fixes based on review (no major changes). Version 6 is rebased on top of
> the latest usb-next and brings one small but important code fix in
> the devcon code.
> 
> Here is the original cover-letter of v1:
> 
> Some devices with an USB Type-C connector have a bunch of muxes
> behind that connector which need to be controlled by the kernel (rather
> then having them controlled by firmware as on most devices).
> 
> Quite a while back I submitted a patch-series to tie together these muxes
> and the Type-C Port Manager (tcpm) code, using the then new drivers/mux
> framework. But the way I used the mux framework went against what it was
> designed for, so in the end that series got nowhere.
> 
> Heikki Krogerus from Intel, who maintains the USB TYPEC subsystem, has
> recently been working on solving the same problem for some boards he is
> doing hardware-enablement for.
> 
> Heikki has come up with a number of infrastructure patches for this.
> The first one is a new device-connection framework. This solves the
> problem of describing non bus device-links on x86 in what in my experience
> with this problematic area is a really nice simple, clean and *generic*
> way. This could for example in the near future also replace the custom
> lookup code in the pwm subsys and the custom pwm_add_table() /
> pwm_remove_table() functions.
> 
> The other 3 patches add a framework for the different type of Type-C /
> USB "muxes".
> 
> Heikki and I have gone through a number of iterations of these patches
> together and we believe these are now ready for merging. Since merging
> infrastructure patches without users is not done and Heikki's own use-case
> for these is not yet ready for merging, the rest of this series consists
> of patches by me to make the Type-C connector found on some Cherry Trail
> devices (finally) be able to actually work as an USB port and not just
> a charge port.
> 
> The last patch uses the new usb-role-switch framework to also do proper
> devcie / host switching on CHT devices with a USB micro AB connector.
> This is also a big feature for CHT users, because before this they had
> to do a reboot to get an OTG-host cable recognized (on some devices).
> 
> Part of this series is an usb-role-switch driver for the role-switch
> found inside the xhci controller on e.g. CHT devices, this is currently
> implemented as the generic xhci controller instantiating a platform
> child-device for this, since this really is a separate chunk of HW
> which happens to sit in the XHCI mmio space. This approach may not be
> universally liked, given that in this new series the role-switch driver
> is much smaller and does not have any external deps anymore we could
> just integrate it into the xhci code if that is preferred.
> 
> About merging this series (once everything is reviewed, etc.), there are
> quite some interdependencies in it esp. a lot of the patches depend on
> the first patch. Luckily patches 1-10 all apply to subsystems which are
> maintained by Greg (most to the USB subsys). Which just leaves patches
> 11 and 12 once 1-10 are merged. Greg, can you create an immutable branch
> for the platform/x86 and extcon maintainers to merge once this is done?
> 
> Regards,
> 
> Hans
> 
> 
> Hans de Goede (7):
>    usb: typec: tcpm: Set USB role switch to device mode when configured
>      as such
>    usb: typec: tcpm: Use new Type-C switch/mux and usb-role-switch
>      functions
>    xhci: Add Intel extended cap / otg phy mux handling
>    usb: roles: Add Intel xHCI USB role switch driver
>    usb: typec: driver for Pericom PI3USB30532 Type-C cross switch
>    platform/x86: intel_cht_int33fe: Add device connections for the Type-C
>      port
>    extcon: axp288: Set USB role where necessary
> 
> Heikki Krogerus (4):
>    drivers: base: Unified device connection lookup
>    usb: typec: API for controlling USB Type-C Multiplexers
>    usb: common: Small class for USB role switches
>    usb: typec: Separate the definitions for data and power roles
> 
> Mathias Nyman (1):
>    xhci: Add option to get next extended capability in list by passing id
>      = 0
> 
>   Documentation/ABI/testing/sysfs-class-usb_role |  21 ++
>   Documentation/driver-api/device_connection.rst |  43 ++++
>   Documentation/driver-api/usb/typec.rst         |  73 +++++-
>   MAINTAINERS                                    |  12 +
>   drivers/base/Makefile                          |   3 +-
>   drivers/base/devcon.c                          | 141 ++++++++++++
>   drivers/extcon/Kconfig                         |   3 +-
>   drivers/extcon/extcon-axp288.c                 | 176 +++++++++++++-
>   drivers/platform/x86/intel_cht_int33fe.c       |  24 ++
>   drivers/usb/Kconfig                            |   5 +
>   drivers/usb/Makefile                           |   2 +
>   drivers/usb/common/Makefile                    |   1 +
>   drivers/usb/common/roles.c                     | 305 +++++++++++++++++++++++++
>   drivers/usb/host/Makefile                      |   2 +-
>   drivers/usb/host/xhci-ext-caps.c               |  90 ++++++++
>   drivers/usb/host/xhci-ext-caps.h               |   7 +-
>   drivers/usb/host/xhci-pci.c                    |   5 +
>   drivers/usb/host/xhci.h                        |   2 +
>   drivers/usb/roles/Kconfig                      |  14 ++
>   drivers/usb/roles/Makefile                     |   1 +
>   drivers/usb/roles/intel-xhci-usb-role-switch.c | 192 ++++++++++++++++
>   drivers/usb/typec/Kconfig                      |   3 +
>   drivers/usb/typec/Makefile                     |   2 +
>   drivers/usb/typec/{typec.c => class.c}         | 124 ++++++++--
>   drivers/usb/typec/fusb302/fusb302.c            |   2 +-
>   drivers/usb/typec/mux.c                        | 191 ++++++++++++++++
>   drivers/usb/typec/mux/Kconfig                  |  10 +
>   drivers/usb/typec/mux/Makefile                 |   3 +
>   drivers/usb/typec/mux/pi3usb30532.c            | 178 +++++++++++++++
>   drivers/usb/typec/tcpm.c                       |  63 +++--
>   drivers/usb/typec/tps6598x.c                   |  26 ++-
>   drivers/usb/typec/typec_wcove.c                |   1 +
>   drivers/usb/typec/ucsi/ucsi.c                  |  13 +-
>   include/linux/device.h                         |  22 ++
>   include/linux/usb/role.h                       |  53 +++++
>   include/linux/usb/tcpm.h                       |  15 +-
>   include/linux/usb/typec.h                      |  28 ++-
>   include/linux/usb/typec_mux.h                  |  55 +++++
>   38 files changed, 1817 insertions(+), 94 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-usb_role
>   create mode 100644 Documentation/driver-api/device_connection.rst
>   create mode 100644 drivers/base/devcon.c
>   create mode 100644 drivers/usb/common/roles.c
>   create mode 100644 drivers/usb/host/xhci-ext-caps.c
>   create mode 100644 drivers/usb/roles/Kconfig
>   create mode 100644 drivers/usb/roles/Makefile
>   create mode 100644 drivers/usb/roles/intel-xhci-usb-role-switch.c
>   rename drivers/usb/typec/{typec.c => class.c} (93%)
>   create mode 100644 drivers/usb/typec/mux.c
>   create mode 100644 drivers/usb/typec/mux/Kconfig
>   create mode 100644 drivers/usb/typec/mux/Makefile
>   create mode 100644 drivers/usb/typec/mux/pi3usb30532.c
>   create mode 100644 include/linux/usb/role.h
>   create mode 100644 include/linux/usb/typec_mux.h
> 
