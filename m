Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3581170-1524157295-2-5993509672231497416
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
    1524157295; b=E2NVJI6of7AinC76ZsKP+Sm4d5O+SSh0QJClZg4Gf3SnrgmxAR
    MWjHPWX1DZD8PYHHpJ0yXNePZrW1BdO6vk3ieK+MMx4STkZ+/g/j74wMeyah1B3+
    707IJQw9fA0h+4ScglWsnEdT6yXnS2f3dotXjy/gv2NMRmkeLIoR5zR3a5AUb0fi
    usuGhJqVc3UX3GIsT/OjfsRRKo92u+1+9fEMe8rIlI/3KAlSAybuvT6IeI12gIem
    NS9zCOSVK2P8wNnxJhH+Yym+zvmyXqyeP4wKPCgxKcvjr/J9T+7BvmZHZrJrZAmY
    c5gqEM4yldvyHchZjLddQIr+JrJJU7ooSrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:sender
    :list-id; s=fm2; t=1524157295; bh=E+40zQtO4Hu2AwvaMR46t5UC6MmFHg
    mRGSDIxyWhlCs=; b=jScwoHhDp53oFL4cA5AbrwooDxr1Tciz3I9k8hxhlSliGx
    sXunb0ZW0dEeSSXiGx5Vn/JKBOh1Jz+cVFhtphTqBdJttUKTiddQfZmb9Hi2I7lC
    j4NcrRbhx6kzW9La3O9BSI4ULi+K2tLoJpO+AANHuc+FBrz26iWXKr7u3vsR8J7o
    LFfk/CRSQs/2afbmWYfJY8ugQU7W+7nRwMT8c+BHcXoKak7Zxu3qMKbPNXB05IDm
    9LTzaZL2v4fP6bssk+V4veN6o77FDS05nY/XUyKQ+GPo7t1vPackXeT2rg5pVQOc
    hA3ANaBqi5H/jYSOyQsFoB20PM2Ia5IhFVea3wWg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=qDLyhO3H x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=SEED7Koc x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=By6M6YzZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=qDLyhO3H x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=SEED7Koc x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=By6M6YzZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOKS7cQ7YNXBeFttZghLkT+llGWb0ni38Ls6ehGrqfRViE2r/Rm1qsSY5rJnTN6ap6jetGCR8Nhp33LexXh7X4QV7XOMFjCmM5XNxwhKC4WbhlcAM51y
    1BSN4w35eSi82PfZcqAvJs6u7b6qukJ2HO4ihU3fLvIo9wsYDLj3RoKO5PTAcETauFQVK1Fs6J2FzbK1j+njuSW5G02izTkwuCY9UqjZ4lrX+1AkB78qxU8M
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=0GvlxcLphg-QamNhedUA:9 a=TJ3-MiKU086_5X8r:21
    a=milnfBfWgpGzOC4w:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753492AbeDSRAM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 13:00:12 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:33702 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753340AbeDSRAJ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 19 Apr 2018 13:00:09 -0400
X-Google-Smtp-Source: AIpwx49B2btTowitAFlydvlsSO9YFl9QcGFtrO2UlcZOaC7LPAx7ijpZeSsnBm/R5H/6wS2zb1NHDA==
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
Subject: [PATCH v4 0/3] lan78xx: Read configuration from Device Tree
Date: Thu, 19 Apr 2018 17:59:37 +0100
Message-Id: <1524157180-27276-1-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
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

v4:
- Rename nodes in bindings doc.

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

