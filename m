Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-306461-1525448874-2-7125643042122070051
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
    1525448874; b=E4GcQnlO4sDOmhVlN8TZON+F3eKvdJC7lXtTLXfIo5WQp+Zy6z
    d9cNGgTj262R/43gVU8ttW22nBuRgnVhixPRN6TKRnbjRRNEn5e6Pdc2evRQW5OF
    3SYENlcuGXg98aMyeXjoze+SDvOknXxOxWfbZdOaHkZEdvQ97Vu3DjZ0e1TkX7xV
    5Mj/58X6JwIcCF0R6sf218oZ+9edY9pSuTYfgEamg5YWlulwJXECdI24UAc911/6
    Qthem8UMCXjoS68agICyS7DMg1HtQ+WLtcczdDVdo1D4ZVxhcJS2h8we+HnMpmM/
    iHy/CNrGT83IR2vTPlfnc+4mCrivfyqTvOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525448874; bh=xE01HSMiXcmKCWSQkSB7Sl/sNh8L12
    GFx61dkTMaqVg=; b=ncag/Mtq7/X3eiEvubzK6U08VYETHgZyBE2z+Uqnl8C1A2
    zGcGAiRQQrsR3bCIut5i4PoYV72R1A5eq77XMTn4/KcCHQhkza3LsyU+PMWLk0hH
    eLVSA0G5MOl+Q3uPo29G8TsfjzDJZzHEZK7hK6+OcGY7Z/bdtJ4vwq2CoIG2rGsY
    rVhU/ZLG/vnwqbCmpbqeUOy4qm+X0frAL4InC9xP+FBWhNPzFysEacfV6Zuk3Dy3
    MMQL5uUsk6AOhWEB4kkkjgdM4NteM9W1Bnvzy81adJ/lfFCH3WOf70DK0A2BAFvU
    X2bkFlq5FWBCfMP8L9hHcZxb4uolIjDzyjHjeNNQ==
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
X-CM-Envelope: MS4wfCbJklnePTgTKrovacwLzZ9uJJ6K7jOaMtQAiG4coMcUvHM4CgygcCwebDNY/sRyGQNVlhUZpW020pmpBYVuI+2vlpCpu2YQqAO5RNyw6zQXWZJ+byJv
    FKURnHovR8TQ5b/R1/SO+OfkAFfvPxA6pj/+V2w+6lBI+gVkeUTbGI6B9LHXHqhIf2Wom/ZoOIbmlfXCvJmAU28i/WaAj0/016tOB/ZnoCOIFTS8X6nymM9o
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8
    a=VwQbUJbxAAAA:8 a=lgtFolcE7YT6ZknlNU4A:9 a=x8gzFH9gYPwA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeEDPqa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 11:46:30 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51559 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeEDPqZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 May 2018 11:46:25 -0400
X-IronPort-AV: E=Sophos;i="5.49,363,1520924400";
   d="scan'208";a="13799023"
From: Radu Pirea <radu.pirea@microchip.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>
CC: <lee.jones@linaro.org>, <broonie@kernel.org>,
        <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <jslaby@suse.com>, <gregkh@linuxfoundation.org>,
        <richard.genoud@gmail.com>, Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v2 3/6] MAINTAINERS: add at91 usart spi driver
Date: Fri, 4 May 2018 18:47:11 +0300
Message-ID: <20180504154714.5109-4-radu.pirea@microchip.com>
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
index ca06c6f58299..9243b9007966 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9199,6 +9199,13 @@ S:	Supported
 F:	drivers/mfd/at91-usart.c
 F:	include/dt-bindings/mfd/at91-usart.h
 
+MICROCHIP AT91 USART SPI DRIVER
+M:	Radu Pirea <radu.pirea@microchip.com>
+L:	linux-spi@vger.kernel.org
+S:	Supported
+F:	drivers/spi/spi-at91-usart.c
+F:	Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
+
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-- 
2.17.0

