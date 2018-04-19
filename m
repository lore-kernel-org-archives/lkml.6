Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3387646-1524151184-2-5852086502766839461
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
    1524151184; b=RcgI3au7ZnG60itWEEyTFQx5G8te54u3G5yRcg2nVGXoXsJmbq
    THBjdeLYRl5K6k5L18sWIaknzkIde/SDGy8JRAuxBtnHujz9jelpHmdH6AN6dNBs
    8JRVvBkIOEjalcxhegkX3CxG1TVexkBoh9RWc7+kNXDoI0m9IUzfaiMKv2Z4XmA1
    ivh3wBceqn4jK4kH5JUOJpY/gemVfSKzUPK/gqlsR1PmATbgjp86Mbz7lBUKVnqG
    GYUK4qgD4h+vNpAfs7C29VNhIumT0hZLCVlnPv3x7HlT/FLeoYjbFz4zWJGO6t5v
    Nd0GiD4wYYTOfrkblqwXGwZdWliGxBCjT+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:sender
    :list-id; s=fm2; t=1524151184; bh=mn9ktZMYxENDCd4xMztlnk8pieM0Gg
    hZbz5vaW5SRDI=; b=i3N1iHRSv6WyrXAvY4xog6WWDPbNrfOWMc+vfDxpd9f3DY
    XPg3EYJCYhsOvtaInzHPBzozkKWoR/5Jfp6gs5BZhkkd33W2eky7ogQWRZCSzxbs
    ZLSG4NzsGDmfXHFpgu20mS/BglQVCx3bGjxQXkS1xLic7V4KLbYoN3iaFF6TlGG8
    CsGJ5jGGq3dbT2Yp0cGSpGqAKeyGtVvI1W8oTUXJSw8NCuajwIkwjXEza2y3zLZP
    kqe8k9VLGLo4067xS7PZ2yMp+2moU9RFuIGqVGV+w5dcXBqTA36dWcouIQR9tDAm
    2BHc17SrcofsFNqqeep5RH7iLvDzMjBlf+JM/RmA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=ArMu/NCd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=p4jpZkbr x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tbwW0tWr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=ArMu/NCd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=p4jpZkbr x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tbwW0tWr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIIuttEfVESQPqy1ZWGM5ZWT4jw0wb/QCCG5T0tcLDgB3roGZQ4YBFjddBhqkh1ac6k2ueM2BDI3t6nPdNHIwefAeJNFkY9g67QZDpnyOwmhAPLjwoVG
    cqtCezpjnP4baNBDKkzmfXFXNLP7fs8K2a9VHmTb82gz8K8PFk1XsBqANsie5GWtZlxZ3D8aD3FbQFuF/nzfvF8YViFZ9t5rZ7GyCJXoppYgrmS0wmVKMwkf
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=0GvlxcLphg-QamNhedUA:9 a=khCMff0rM5IL_L5d:21
    a=3IbkmF0Pay7klY16:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeDSPSF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 11:18:05 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:56640 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752327AbeDSPSC (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 19 Apr 2018 11:18:02 -0400
X-Google-Smtp-Source: AIpwx4+onYlH0SfjLgOWOR2/XhM17DBHfXDqAblRbJhsXf79cdpZ+/e7Mkq2K9chzOW6WDua1lrUDw==
From: Phil Elwell <phil@raspberrypi.org>
To: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Phil Elwell <phil@raspberrypi.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH resend v3 0/3] lan78xx: Read configuration from Device Tree
Date: Thu, 19 Apr 2018 16:16:56 +0100
Message-Id: <1524151019-82823-1-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[ Resending due to incorrect distribution list ]

The Microchip LAN78XX family of devices are Ethernet controllers with
a USB interface. Despite being discoverable devices it can be useful to
be able to configure them from Device Tree, particularly in low-cost
applications without an EEPROM or programmed OTP.

This patch set adds support for reading the MAC address and LED modes from
Device Tree.

v3:
- Move LED setting into PHY driver.

v2:
- Use eth_platform_get_mac_address.
- Support up to 4 LEDs, and move LED mode constants into dt-bindings header.
- Improve bindings document.
- Remove EEE support.

Phil Elwell (3):
  lan78xx: Read MAC address from DT if present
  lan78xx: Read LED states from Device Tree
  dt-bindings: Document the DT bindings for lan78xx

 .../devicetree/bindings/net/microchip,lan78xx.txt  | 54 ++++++++++++++++
 MAINTAINERS                                        |  2 +
 drivers/net/phy/microchip.c                        | 25 ++++++++
 drivers/net/usb/lan78xx.c                          | 74 +++++++++++++++-------
 include/dt-bindings/net/microchip-lan78xx.h        | 21 ++++++
 include/linux/microchipphy.h                       |  3 +
 6 files changed, 156 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt
 create mode 100644 include/dt-bindings/net/microchip-lan78xx.h

-- 
2.7.4

