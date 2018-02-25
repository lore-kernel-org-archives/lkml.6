Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-153198-1519572319-2-4769141814646004891
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519572319; b=edZxDtR4XAgJUkizx5H3Or1/qVbF7PnA6QkrqAZaeXfn8gv
    TUy2HeHVyMsJHMRm55fE/G3aZA02XaGe/hEyp0bL3r+/WXMy3uzKUXilTyUrnWWl
    GpWWMfbMmmtkp7irWg5ql69jItuzwDSVxTwPuVGkQSVMcMlNZkhSyZW2okoz3xPK
    nuIdoVdVJKfST1qYotYWjeAFvD+Z8Wth+EfA8++yRZ7B5MF1wHwLP84HKsPVCjmO
    9u2xrPS9ehiCsdsH0EJBJf9fAjZ2cG90zhu31v5l5FMqW+M/oWZL4ATNP0h4wKG9
    fhQuiVaJwedwtPjFYLoQrWoZZuPErvl38xdH3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519572319; bh=mtYHECPBnZaW4hTODOx/5Hcbqa
    Pt+nHygEta1rxF1o8=; b=pyDmI6CaqAeHeIFe9A/suXyGdouoCOwvpGf3/c7KWL
    HnM/kVHLblbsMG9jeGVLv9FJjvA+VlJhRtVJJjo0MhzyP/RY7mqrenJiOoQzCDJI
    +D7Pcqwn0wZAGoVmxa2nTCg1jbb+X5nPx6Xs91y8gk+URu4CbdWQJ8N0NL3si2ns
    lAz9n7Qxx02tRGfhwgTMpuCDPRbBi5DXU8fxs0BP71TwqX20axziiLc8tCDMdr3L
    AvwsQWgOEuFcP4Aq/jy41pNpvyfbczNAhVztqXy88bIiTSUmS2+ERHLYmHxuYi1t
    Ujt7VfsoQleBTLYMNUZGgYuBw1qzkaHVL+2DirEMVmVQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeBYPZO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 10:25:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751540AbeBYPZN (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sun, 25 Feb 2018 10:25:13 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 00/12] USB Type-C device-connection, mux and switch support
Date: Sun, 25 Feb 2018 16:24:58 +0100
Message-Id: <20180225152510.10159-1-hdegoede@redhat.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

Here is version 2 of Heikki's and my USB Type-C device-connection, mux and
switch support series. Version 2 brings various small code and style fixes
based on review of v1 (no major changes).

Here is the cover-letter of v1:

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
