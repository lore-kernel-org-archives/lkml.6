Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3309672-1524148385-2-11378264181861625718
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
    1524148385; b=mHvX6pHVn2rMS6YwsqXfUluPIretd0pLojXE2lWYQ7dJMvXOT8
    O+uFeHCICz96ibgYX7dFvJUBrtFRu52n7izaSNsszsTEoOOMTNfMWS9sJxkIJJnN
    gG0WR4g7XurQo7dYjQdGJ4fDIKS9fNlBMzUqoOXoofFVNX3702JjGH4lwFaIHJaG
    tSSW6/zgBSEpM9F9QrD4osj7d9C9cmBoy54f9iGpYa8Jn8W25W2QUJQltnkmxH3w
    Hy587nH52UEs6+9ybenNIr34L6ErS2kzSZKDgGKJZwUlRV8XHmI3VAqACCS/1ET6
    QPAENW4aH1A4eg1K0ONlF38/YNaNKtgwT/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524148385; bh=
    Zagf+/xsyJSi8CPdAizStvmxvcSIwOMacehiK7tPKpQ=; b=d07vQcIGTRikDavh
    lazXNAJyNtqVKL3K5bLKLWmwnLVX/VCw2fPcIXPdDUmfla0hda92HKD8usW+VN3X
    m4PBogba/G+AqY8CYlzLaWMnd2q3rMuLT3OjEE2TcGkZZBOlfUbqzuzXDaZwwYiR
    VOOB+oErrAk04FoMcaAj+191aq1PIcZ4z0SE3zdwvj+txbi97mYceYPU9dbWTQPC
    Pq7x8q4q5sAcqHq5bfxIWtTqaWoVWQCaR5/v1jkHPX/lBZ76sp1qWMv7I/+uU/e9
    qnWJydrX8ijmaTSJNr0ENuCXwLRHmf6hB0d6sOI3vMu0XsJ72m/sWaRaGXgrMsxr
    fxdoNw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=U5v3y0hh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=ncqx2kDO x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EMWqSUko;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=U5v3y0hh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=ncqx2kDO x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EMWqSUko;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHMsEs3p5AE0bu6sQOM9YwRiMhv28Dc9bYaz+J0hyX1x81jZdzKr0fMuZIEB/mPb2aIthgkdXf840vzlbSWsm0ZJPIoQZja5Ta3rZr9RGLCaV7DE2oXD
    xgBDAu0fleMa+0ROaDgyOSdjKM2Vx4JaD/atsmSOJ4BsV9iuDEv08MOC4LWyzarNiYGArKL9MYgf23UBMHlNLFoaylGmH0tx/jVjgQmbXuIp8Kxf+3jhCNV9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=0GvlxcLphg-QamNhedUA:9 a=6Rg4WJzSPT1UJVWi:21
    a=AQ0CqrW8C1V0BqGz:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeDSOcY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:32:24 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:53988 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752283AbeDSOcT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 19 Apr 2018 10:32:19 -0400
X-Google-Smtp-Source: AIpwx499MLdOxk5LTIgdSAtehYoAQMo/mPq2j3516CkuaPSrVAHuVt2xn8IpEF9Fg9osN4mK2YMzGA==
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
Date: Thu, 19 Apr 2018 15:32:02 +0100
Message-Id: <1524148325-78945-2-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524148325-78945-1-git-send-email-phil@raspberrypi.org>
References: <1524148325-78945-1-git-send-email-phil@raspberrypi.org>
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

