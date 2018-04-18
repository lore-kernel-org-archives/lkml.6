Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-705158-1524066388-2-7121189259947510405
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524066387; b=OodWjczv7h3jqgI+VjY/6ZKYxv6prewQvYhFiGomB3U4DxwZ9h
    M+XyVCzXskwUWehSgsF9+aWwgRm6Mc5xdffkPGsiY4lMJuGrbc2DtwDgfrdXZ4so
    +X+y40e5XqhinCrWX78gWsHiGGVNGSa1crOoMWSjrKF4OL7ZbnyeEMvmnQHFn5tX
    Io+gnAysaH+2yIrsf3wY7qmcIoeM3rIWoKkefGIs1Ceqvlp9AU5MqUahqiuQPd29
    NeaTbyQfpR/tpGPChr6vseklgTpsi/jGDy1XqSSj/TVROWEJQUYdM21mgzdAbfU1
    9F6TyvN/K+Mh0DjPY0u1Cm10UowbaHB11Hhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524066387; bh=gS0x6FeO152qx/nOF+vBIwTdHsGufc
    o2r1eLZ+DUux8=; b=ZkNM3v4mKyHr4ZX0JAUnZGItRfh05O0G1zHGRz8JwBuyWC
    cMY/5g0K30DWU6JcIognOM5Z/sl8sI9xGyu6tUlt3Sw4QdshKE2+y8Wep2VAfM/3
    BkxZGAviOcsghH/s82ZYnpBUsq9443csvL+1bdk/1yuT5yaEhCEiF2iisTK92Jm3
    zsLm3CYzK/yoRsfgr+Fa/1P8gKcYzwLKwo8mimKMGCiGhXqZjT+ryZ4M4Iw24fhp
    11pfRAvKMsxsOiO1EQHEXVQ9Cx9dd0F9hduqsOnc4LF4dmnl1hEvW9fP+w/aKdDR
    MiZiOEr7rROA3u20FMrlrbKvTauw0Bgg86vFyYuA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=X4ROZSxj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=azOLKV5J x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FGogIZUB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=X4ROZSxj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=azOLKV5J x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FGogIZUB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDGN153m5sgV9Kc4q6NUwwUcGMPSqAeuF9EN6kzFkywWJD1CYnH6FrvXinYwC6nCVdSDS0rC5IVF3PnEcB0QSgOi8y7qUh6ESa7zSgp+vIMRBzXzdGjs
    YO4y3mTNI/co/hQUH3MYe45QIJ4oDgTCEaDUmDJmZqwF7SvA49UCaIJ1IcUjuxfaA0lImMmLgkZvyHJ+zjxSQ+IiQ1D+bMZyzEBpKPWjlFhS+7FAKSOtMNYr
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=0GvlxcLphg-QamNhedUA:9 a=QvQ_zLigowP9PyKG:21
    a=AWK9gw6Ur_CXYYSx:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeDRPpe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 11:45:34 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:34381 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752921AbeDRPpb (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 18 Apr 2018 11:45:31 -0400
X-Google-Smtp-Source: AIpwx4+A0Z2NDlkdfCN/JmOre6Vnl5dp9Gu+4pBHVal5kDfDquSDcEpi0NFQLELUv9hRh3xcl9lScQ==
From: Phil Elwell <phil@raspberrypi.org>
To: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH v2 0/3] lan78xx: Read configuration from Device Tree
Date: Wed, 18 Apr 2018 16:45:20 +0100
Message-Id: <1524066323-109628-1-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_03:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Microchip LAN78XX family of devices are Ethernet controllers with
a USB interface. Despite being discoverable devices it can be useful to
be able to configure them from Device Tree, particularly in low-cost
applications without an EEPROM or programmed OTP.

This patch set adds support for reading the MAC address and LED modes from
Device Tree.

v2:
- Use eth_platform_get_mac_address.
- Support up to 4 LEDs, and move LED mode constants into dt-bindings header.
- Improve bindings document.
- Remove EEE support.

Phil Elwell (3):
  lan78xx: Read MAC address from DT if present
  lan78xx: Read LED states from Device Tree
  dt-bindings: Document the DT bindings for lan78xx

 .../devicetree/bindings/net/microchip,lan78xx.txt  | 43 +++++++++++++++
 MAINTAINERS                                        |  2 +
 drivers/net/usb/lan78xx.c                          | 62 ++++++++++++++--------
 include/dt-bindings/net/microchip-78xx.h           | 40 ++++++++++++++
 4 files changed, 125 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt
 create mode 100644 include/dt-bindings/net/microchip-78xx.h

-- 
2.7.4

