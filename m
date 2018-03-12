Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-515744-1520865282-2-4612008574148038796
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520865281; b=cTImtIJUYP6HhLEbozuzlojhfdmy1Fw6MgAhAtARtQZ0sCM
    ZOkV8ih9s9a/kV0oHQ6cqv47Y+OCDMAWGqoBQKR2RoI27Z+mjKPfOQjh91NTr1j3
    +a9KsxqU5JhH1fHPCnWVgdC/v8zMoeuwC3JaGRiL+Q1/TSzlCIQzoG1+SN6lqWFS
    TanulqAyWSFvvh2Jp6/sT90gDjBtTGe0tvlFtxCZ/FQe++fIU6wq0hkIg3kO9C0M
    rXfsKwX0ZX9MUF4FoGi9iK9t3vf70PHIdqx8yLXxpgfV+ZuXx57s7Nr9HvyuciKc
    dhgsp0g4jdHeRdh1ZjlCsiIuz9oCUNZi/XWHo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520865281; bh=RoOmS3Nwtt7W6DNVzt8DvPxgKl
    uqVC26jF01CIE6y2o=; b=cs9W/aJg4R1+4Iyduc9ZlAQtsj0BxlJVMi5tkn9lte
    DK9TEfYrR7fqEs1sACNzjcS8n75sgTvXhrDURzFctBHYW4V5x2SeE+gysT6syCp+
    0h8R8XmRIgNm54T2xGFrJrUyzCv8zDys9LPCkbHcc1WA2/6GtU8Ep9UfOeGFz2sz
    yVz1Y2tBOQRtF4WQM8SGAb8tR/akYBtXpAH8qd4JNzL9VbUofnP0FM+5nU692lv7
    eNvxqBuq1GDDsji4bNuTrKOz40GttRAQlUCPLl3qLgT00W7NTYmKBkQWFyMyo6jq
    qRRuNdIF6+i1TPPsSBc638NQgV06uAqVMk0l4kjkYZHg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeCLOeh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 10:34:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:22074 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751660AbeCLOeg (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 12 Mar 2018 10:34:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="37470749"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v7 00/12] USB Type-C device-connection, mux and switch support
Date: Mon, 12 Mar 2018 17:34:19 +0300
Message-Id: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This is version 7 of Hans' and my series introducing support for USB muxes and
generic device-connections. The api naming for device-connections is now made
according to proposal from Greg, connection.h is dropped and the prototypes are
now in device.h. kbuild test robot <fengguang.wu@intel.com> also found stylistic
problems from patches 9/12 and 10/12 which were fixed. The patch 4/12 ("usb:
typec: Separate the definitions for data and power roles") was added to the
series.

Check the v6 from here:
https://lkml.org/lkml/2018/3/2/340


Here is the cover-letter of v6:

Hi All,

Here is version 6 of Heikki's and my USB Type-C device-connection, mux and
switch support series. Versions 2 - 5 bring various small code and style
fixes based on review (no major changes). Version 6 is rebased on top of
the latest usb-next and brings one small but important code fix in
the devcon code.

Here is the original cover-letter of v1:

Some devices with an USB Type-C connector have a bunch of muxes
behind that connector which need to be controlled by the kernel (rather
then having them controlled by firmware as on most devices).

Quite a while back I submitted a patch-series to tie together these muxes
and the Type-C Port Manager (tcpm) code, using the then new drivers/mux
framework. But the way I used the mux framework went against what it was
designed for, so in the end that series got nowhere.

Heikki Krogerus from Intel, who maintains the USB TYPEC subsystem, has
recently been working on solving the same problem for some boards he is
doing hardware-enablement for.

Heikki has come up with a number of infrastructure patches for this.
The first one is a new device-connection framework. This solves the
problem of describing non bus device-links on x86 in what in my experience
with this problematic area is a really nice simple, clean and *generic*
way. This could for example in the near future also replace the custom
lookup code in the pwm subsys and the custom pwm_add_table() /
pwm_remove_table() functions.

The other 3 patches add a framework for the different type of Type-C /
USB "muxes".

Heikki and I have gone through a number of iterations of these patches
together and we believe these are now ready for merging. Since merging
infrastructure patches without users is not done and Heikki's own use-case
for these is not yet ready for merging, the rest of this series consists
of patches by me to make the Type-C connector found on some Cherry Trail
devices (finally) be able to actually work as an USB port and not just
a charge port.

The last patch uses the new usb-role-switch framework to also do proper
devcie / host switching on CHT devices with a USB micro AB connector.
This is also a big feature for CHT users, because before this they had
to do a reboot to get an OTG-host cable recognized (on some devices).

Part of this series is an usb-role-switch driver for the role-switch
found inside the xhci controller on e.g. CHT devices, this is currently
implemented as the generic xhci controller instantiating a platform
child-device for this, since this really is a separate chunk of HW
which happens to sit in the XHCI mmio space. This approach may not be
universally liked, given that in this new series the role-switch driver
is much smaller and does not have any external deps anymore we could
just integrate it into the xhci code if that is preferred.

About merging this series (once everything is reviewed, etc.), there are
quite some interdependencies in it esp. a lot of the patches depend on
the first patch. Luckily patches 1-10 all apply to subsystems which are
maintained by Greg (most to the USB subsys). Which just leaves patches
11 and 12 once 1-10 are merged. Greg, can you create an immutable branch
for the platform/x86 and extcon maintainers to merge once this is done?

Regards,

Hans


Hans de Goede (7):
  usb: typec: tcpm: Set USB role switch to device mode when configured
    as such
  usb: typec: tcpm: Use new Type-C switch/mux and usb-role-switch
    functions
  xhci: Add Intel extended cap / otg phy mux handling
  usb: roles: Add Intel xHCI USB role switch driver
  usb: typec: driver for Pericom PI3USB30532 Type-C cross switch
  platform/x86: intel_cht_int33fe: Add device connections for the Type-C
    port
  extcon: axp288: Set USB role where necessary

Heikki Krogerus (4):
  drivers: base: Unified device connection lookup
  usb: typec: API for controlling USB Type-C Multiplexers
  usb: common: Small class for USB role switches
  usb: typec: Separate the definitions for data and power roles

Mathias Nyman (1):
  xhci: Add option to get next extended capability in list by passing id
    = 0

 Documentation/ABI/testing/sysfs-class-usb_role |  21 ++
 Documentation/driver-api/device_connection.rst |  43 ++++
 Documentation/driver-api/usb/typec.rst         |  73 +++++-
 MAINTAINERS                                    |  12 +
 drivers/base/Makefile                          |   3 +-
 drivers/base/devcon.c                          | 141 ++++++++++++
 drivers/extcon/Kconfig                         |   3 +-
 drivers/extcon/extcon-axp288.c                 | 176 +++++++++++++-
 drivers/platform/x86/intel_cht_int33fe.c       |  24 ++
 drivers/usb/Kconfig                            |   5 +
 drivers/usb/Makefile                           |   2 +
 drivers/usb/common/Makefile                    |   1 +
 drivers/usb/common/roles.c                     | 305 +++++++++++++++++++++++++
 drivers/usb/host/Makefile                      |   2 +-
 drivers/usb/host/xhci-ext-caps.c               |  90 ++++++++
 drivers/usb/host/xhci-ext-caps.h               |   7 +-
 drivers/usb/host/xhci-pci.c                    |   5 +
 drivers/usb/host/xhci.h                        |   2 +
 drivers/usb/roles/Kconfig                      |  14 ++
 drivers/usb/roles/Makefile                     |   1 +
 drivers/usb/roles/intel-xhci-usb-role-switch.c | 192 ++++++++++++++++
 drivers/usb/typec/Kconfig                      |   3 +
 drivers/usb/typec/Makefile                     |   2 +
 drivers/usb/typec/{typec.c => class.c}         | 124 ++++++++--
 drivers/usb/typec/fusb302/fusb302.c            |   2 +-
 drivers/usb/typec/mux.c                        | 191 ++++++++++++++++
 drivers/usb/typec/mux/Kconfig                  |  10 +
 drivers/usb/typec/mux/Makefile                 |   3 +
 drivers/usb/typec/mux/pi3usb30532.c            | 178 +++++++++++++++
 drivers/usb/typec/tcpm.c                       |  63 +++--
 drivers/usb/typec/tps6598x.c                   |  26 ++-
 drivers/usb/typec/typec_wcove.c                |   1 +
 drivers/usb/typec/ucsi/ucsi.c                  |  13 +-
 include/linux/device.h                         |  22 ++
 include/linux/usb/role.h                       |  53 +++++
 include/linux/usb/tcpm.h                       |  15 +-
 include/linux/usb/typec.h                      |  28 ++-
 include/linux/usb/typec_mux.h                  |  55 +++++
 38 files changed, 1817 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-usb_role
 create mode 100644 Documentation/driver-api/device_connection.rst
 create mode 100644 drivers/base/devcon.c
 create mode 100644 drivers/usb/common/roles.c
 create mode 100644 drivers/usb/host/xhci-ext-caps.c
 create mode 100644 drivers/usb/roles/Kconfig
 create mode 100644 drivers/usb/roles/Makefile
 create mode 100644 drivers/usb/roles/intel-xhci-usb-role-switch.c
 rename drivers/usb/typec/{typec.c => class.c} (93%)
 create mode 100644 drivers/usb/typec/mux.c
 create mode 100644 drivers/usb/typec/mux/Kconfig
 create mode 100644 drivers/usb/typec/mux/Makefile
 create mode 100644 drivers/usb/typec/mux/pi3usb30532.c
 create mode 100644 include/linux/usb/role.h
 create mode 100644 include/linux/usb/typec_mux.h

-- 
2.16.1

