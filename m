Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3782484-1526035128-2-3719051384158389707
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526035128; b=G4KhpvlswHGm9nGb7oApmi4ZyTnRLvzOif8pHDkQTZdBb1Gfai
    XhH9pTY/ebhxlAzCUQisLU/aMdsV3lG4PiAcQQIHToywWlw30bcx36bfgQ2EHzJ2
    EguVxh52AFmpf4za8sJ7mhSFDQyCruhAT5vP8BUmeA73gBDGGVNde72GCHCkSviv
    likC828yqTMRVOcN5WReS9u5hydiM3zI2d0vzBuCEPfvIn4dCIDn/aSApXxISHB1
    VQdiFZDOW4Vmk1pNWMo6CVNDhf0Bp6+wVOzuYjoTfTGUWYszJOdq0lQ5x9X9m+nm
    cuoTtn9+ci0VYoc8t2mWnpq7VHSXahnevMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526035128; bh=Xo1k765mCElrnuEdZn6zfMKjDcmLH6
    xlDC/ZpCyRpDA=; b=BtgCyEo5S72meDX9lFrvoaTXbnNPFYPCslsU2XcuvzPHp9
    U1jc/0le7f/X2gYGWd4JY85c3vb+qPe+JGGl8Y09iJfY/i4RzCUVEcAIRJJf6ouj
    Gf9jaxK5UxqYEybph9dToqNyV3pFktIwk8xS//32V6QtsGDQek7j3Vwof4Ul85yu
    HF8ha8yUR5qVUdVquHCaglzQT/2xZTHB249v81rOkApKRJeYXWOs20P4jJpbQtL7
    FZHDx+r0crZa9hwmYEwD9E2lGy8nLyn/pIqGk0meqFMBwgDuMbiYixwDg0iUawsm
    TuLYPSQa40xwVDFypzgcSvPrLej9K9ddpVq0lNvw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=microchip.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=microchip.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEsQdvv7BHYiYYYexKqxcLtgl9qSsczcxEbug0SVAEqIVvBD5uuoWrjy9hl87yIlA0gO88Z1XXaEr4f64qi4CrWhxSn9uSg4CQ9qubtB9SRe6rl8cTeU
    2KTbb94AyVIyVVwdG/HyfRS85+SS7Ms9vIe+9niUgoUwTgEOJG4lFailHQ9tdz0TGdeM8BWYvoA1SpKYTRtjTHscBtryIrZneHGjm9gEs8WFes3fBq0h6HjZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8
    a=VwQbUJbxAAAA:8 a=WEKalfPYb8qsuMOUQUgA:9 a=x8gzFH9gYPwA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeEKKhW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 06:37:22 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:63073 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752936AbeEKKhS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 May 2018 06:37:18 -0400
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="11427328"
From: Radu Pirea <radu.pirea@microchip.com>
To: <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC: <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <richard.genoud@gmail.com>,
        <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <broonie@kernel.org>, Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v3 1/6] MAINTAINERS: add at91 usart mfd driver
Date: Fri, 11 May 2018 13:38:17 +0300
Message-ID: <20180511103822.31698-2-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511103822.31698-1-radu.pirea@microchip.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added entry for at91 usart mfd driver.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e2a2fddbd19..ca06c6f58299 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9192,6 +9192,13 @@ S:	Supported
 F:	drivers/mtd/nand/raw/atmel/*
 F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
 
+MICROCHIP AT91 USART MFD DRIVER
+M:	Radu Pirea <radu.pirea@microchip.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/mfd/at91-usart.c
+F:	include/dt-bindings/mfd/at91-usart.h
+
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-- 
2.17.0

