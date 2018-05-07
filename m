Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1144428-1525706389-2-13969096640401601322
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='io',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525706388; b=LqmXrwsOjmhRAL23bwpOAXrgvm+4KeK4UVB1fcKVaRBtKPyIuM
    i37ebMtrPIFd3DLCA4VIhvPI5HiBBhy0I22u58EsJ7Dl1jP5JDWTBlLu2qe4pw/h
    eT2asZNcpnV+FLXNujFJk9FjyUfJYQT1eh+Pu+JvtD6aNo3JmhDR0LEQ6D4GfEEo
    y7YP4yxiYIccrbhE/RmCr+Vfh+Q5sO2Y/EGjAerzDJdFZpBS3eNl6RvPUZOxAEMd
    sZg5UE9TSs/acrooQ+NNDzDXvN4KePl3CtZagPMemS/7b4LE5EMqqtBsur+fQ3rj
    oQaHclMl0kJIoXu4vhcfwVFawfEHCuSVaulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525706388; bh=tcSUKZ8Wi1p6pOVw3zGoj01nsIXt9K
    oE6BYvrAuFkYs=; b=fZuU+NzTzLmHws0rTZ2iRKZ+fxrRsSnS/azawJwiwgHpdC
    XfuRxK98AMZXUTTljBP2DbcbbJO/I2qXXbkFIR32v9dnMJELZQaHk4KnhrFexz1A
    wD2JMYiXhDnFb90tvD/McLcBUYy4zDy2UNMU9IVStKFtHQFvo3gDyYevOE/xAP7w
    kLY6v9/fo9cnh/ZffU0TbXh8WZPTZr5YyyN4gKk1EoUKHm6kkZUqVB3B1RKPWFLh
    BeArS51fN3sAVP0Q4lZ/7j8SPL3I9fFlK9OdQdS/LD33J1BFmQLq7PmK/LsTnHbP
    VUh46mYYkHml+jAE1P13RUHgTTRozHcQ7LXqmyqA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aosc.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=aosc.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aosc.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=aosc.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKqZV2bcGhA+YR6pdsW1VM+Pw30HF+lXpxTjL7AU+xKG1rKb6XD27WPn9OGYA6iKokhX5k7TyefAdZbPUG3OFZy1jBWLH5AcBBC8WKJWkt9YYeInyImd
    T+imrsskFSRpiyZ2jZa9oEt+VDjn+KHl2WDvus7sho2HqmiqB8ZkHxKCtqh7/m41GAW1ns8eiWkK0FzS5JkPvKTFZ5lkCaD3j6D1Bex+gDRoJtswhxTPzair
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=wFg47sUz4ovGHF8ESIMA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeEGPTS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 11:19:18 -0400
Received: from hermes.aosc.io ([199.195.250.187]:48307 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750881AbeEGPTR (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 7 May 2018 11:19:17 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Felipe Balbi <balbi@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/5] Allwinner H6 USB3 support
Date: Mon,  7 May 2018 23:18:12 +0800
Message-Id: <20180507151817.55663-1-icenowy@aosc.io>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset contains USB3 support for Allwinner H6 SoC (DWC3 with a custom PHY).

The first patch adds the PHY driver, and the second/third patch adds
compatible to adapt DWC3 platform glue to Allwinner platform. The last
two patches are DT changes.

Icenowy Zheng (5):
  phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC
  dt-bindings: usb: add binding for the DWC3 controller on Allwinner SoC
  usb: dwc3: of-simple: Add compatible for Allwinner H6 platform
  arm64: allwinner: h6: add USB3 device nodes
  arm64: allwinner: h6: enable USB3 port on Pine H64

 .../bindings/phy/sun50i-usb3-phy.txt          |  24 +++
 .../bindings/usb/allwinner,dwc3.txt           |  39 ++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  23 +++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  38 ++++
 drivers/phy/allwinner/Kconfig                 |  13 ++
 drivers/phy/allwinner/Makefile                |   1 +
 drivers/phy/allwinner/phy-sun50i-usb3.c       | 195 ++++++++++++++++++
 drivers/usb/dwc3/dwc3-of-simple.c             |   1 +
 8 files changed, 334 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
 create mode 100644 Documentation/devicetree/bindings/usb/allwinner,dwc3.txt
 create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c

-- 
2.17.0

