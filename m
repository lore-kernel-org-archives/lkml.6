Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3309672-1524148458-2-17434913904852370116
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
    1524148458; b=v0Ps2hb37aEeyOTUjOWrW3NPBwIs8yPHgpRdBXcZBMNTGrn92d
    k4Yc3OLrWtsbovII/t8IjPFJVRkqx/7plucn54Ky4EMvC/I0jbwSKhaxJcQerDAr
    3dq4+03807ekTitIk1hwQX5WBzpt0dXN50ruQkc9pV+t5wClojzelRkXG21KV5Zz
    5mU/JBrCGFqJOGSEKAwo1KSOJFO9kuIphWiLR+i63/D9eor8zO2pWyhuZ/6+Unc6
    2zI3DHig6+84UBDCgVH3TYCc/g0Woc3PPbMDJY5QW2TqYdiLJIFS/4z8CHFFZgiI
    E7/7Rkz/dZ52lhurkq3pcXyPX5bmEJS6yPGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524148458; bh=Zagf+/xsyJSi8CPdAizStvmxvcSIwO
    MacehiK7tPKpQ=; b=qtcRnOzXU90MheFtsieG52m7IG/M2AWjfMmA0qEXJIjuWQ
    EILkiyugyoYnGErn1jfLFoWUxyEASyxgp4HjDbsQCMfULnbhPK302+qC7ttH5XfB
    ioKAcSAFRIWjeemfzGYogvAe1yo3eTpW9Aih5RJiawaYhcf+vAt9Uz7zlNUz7tuA
    A7s7YOjXO9IHfCokyK3rfYHhw6pM0SNfZDqkFF7sNirsCJePDQrl+S0xk/V+vzlG
    8IoO7sivORoeyCPkTTxu8Vd2DgIc5M8TXnmXRZWsnr8FjWJX7r7NTZ+b6AfzFlP+
    QBU0OfSIbeFxcEB21eVZ/eVWfkCd/rb4M2xKM0kQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=fKoEP8tL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=SCVDJJzB x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eMPTViZm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=fKoEP8tL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=SCVDJJzB x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eMPTViZm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGm8d8P9+kTsNb6sG+sw2QHyISHXjyudrX7kSIFAN0oSO9DDEVEy1NZ5Fs1ulHGP92WlAYwk8ScZzcM/0tmYb2hkeVzk86dJ5D9vuLuwtn+wB1+tv13Z
    tziDNL6jN0MLVWp2bbUwrhEfoirqCsHBpLQV9kR3zBFFGq1YXEIW6IwCpsh9lwJqCVbDCmUStEywbpGwLPfTRL+4o9C9fXntIz2tbjB7s/7dqL6kbya+GiIM
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=0GvlxcLphg-QamNhedUA:9 a=6Rg4WJzSPT1UJVWi:21
    a=AQ0CqrW8C1V0BqGz:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeDSOcV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:32:21 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:53974 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751695AbeDSOcT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 19 Apr 2018 10:32:19 -0400
X-Google-Smtp-Source: AIpwx4+blbQgaXnTV0CNvWUVialGdweyi1JEnsX4mL15Cs9CaD5vnYGRKibHNxB5l7G5tWCgrO3/iA==
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
Subject: [PATCH v3 0/3] lan78xx: Read configuration from Device Tree
Date: Thu, 19 Apr 2018 15:32:01 +0100
Message-Id: <1524148325-78945-1-git-send-email-phil@raspberrypi.org>
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

