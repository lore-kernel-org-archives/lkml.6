Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-306461-1525448888-2-11835857431447261625
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525448888; b=hYy3+7gzMM8+cws1NOcyPP7hCerOY+wUMddwvRKnRGlXMFNvH+
    rf8e/MEXI2oWmlmdk3ZlJDcjufB/CqB13LMBrunudKKXNLHBgWIsuWc0oGkveoPq
    G52e7TQaMR0CG+h0w6Yhk98vkcV8jRW1z0P0WKR+im4fTma5dOr0NrUsvgQZQLxK
    oDH3mIDClha7qzD25c5uovdO+kb0xyIbH5K/sVph4XVdCi/rQXb7ksxV87un/kGD
    nZMEfn9MjsBQhdm3dvt55EaQPLKTrBf6uJV6dzFc0eDP5J98UtoRiVgRdGu47MgX
    g3X5VT+0gWTagESED7B0Rm9hJkfLrEY17wkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525448888; bh=Xo1k765mCElrnuEdZn6zfMKjDcmLH6
    xlDC/ZpCyRpDA=; b=CT06/qKv6Ojx1zr0A/H8qw89GyvEABhUH1KmyS7DWokriq
    PIKUrqGuG205R3rkiAUnKzN2FRZ1V6APp6di2NrY1b8x6EMD8DiCRsTETRPzJhd/
    I6PiMLd3ji4c3PG4V7wI11sK+Ul+vKEhXeNZ7tgIApsIfSArp18iAT/z9ylW6ALG
    FzHiw28AZhfr5auR4zZzGypoU8fIlzSbEhNRj/bu7YPwEp1JHqrfeCy9N010z+vw
    lZvvoEUsDPzl7Ndm8qAgt/OgZb+DkfGlgKJGwBlDJSXctUqIuKgqqE8WhM6zkh+y
    QGjxgogMRZTPg+4l2vVjbrlBoZseHO7m8EYkduuQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfObn/AveYryBtI8cWYnBlNg6Lk9UXi+Z7ZQ6vZqPCbHAXajqpIzTooge4H+cCCo8EJjtpZoUWHA6+FAf+HswYbxnWyR8+oFwndXnsyNnMw5vm0Jl9jhl
    r5A5Raa8xkH5Hqrk8LU2RjKlVH7khzcwQnGHUxhf0hHcwwh738znX5TvsydIxcG0zdn6x+aWgLogxV6yn1jDNlwwm3AAHryoDB8s4LFi+vmsJX9+cqNeEqus
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8
    a=VwQbUJbxAAAA:8 a=WEKalfPYb8qsuMOUQUgA:9 a=x8gzFH9gYPwA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeEDPqS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 11:46:18 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:21501 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbeEDPqP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 May 2018 11:46:15 -0400
X-IronPort-AV: E=Sophos;i="5.49,363,1520924400";
   d="scan'208";a="14509183"
From: Radu Pirea <radu.pirea@microchip.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>
CC: <lee.jones@linaro.org>, <broonie@kernel.org>,
        <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <jslaby@suse.com>, <gregkh@linuxfoundation.org>,
        <richard.genoud@gmail.com>, Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v2 1/6] MAINTAINERS: add at91 usart mfd driver
Date: Fri, 4 May 2018 18:47:09 +0300
Message-ID: <20180504154714.5109-2-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504154714.5109-1-radu.pirea@microchip.com>
References: <20180504154714.5109-1-radu.pirea@microchip.com>
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

