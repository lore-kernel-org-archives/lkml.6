Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3782484-1526035121-2-17212524864063336830
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
    1526035121; b=KdwRaQJV2zXsDkrFwqXfuK7eLyD4cVZrRhy9+w9m+jgBq0rPWq
    1TuT3w1oOVY67EZt09MOz1dGLh0tHzkyqrcnPFL0xoT0ycuKtRPgE5hgoFEYAA76
    4/wC+QOtiHu8JNwG2Qgg4hKRVjqNQCy7eCYFgRQbmh7qV5V0yZ9M/RCVOlTVTWHV
    VAbM7w3+9O0BA1nOFCFikPPQ37VUi59t4XmRY+RIjnumyzQnQh8cutBpT74mq/7c
    kgrW/RapoH0kdwWOj5ictujPRiR04KlcgqmstLQ/cZ76vlZhDMHVQsQlvCFMOK8J
    xi71Fd+FJZAM5eCjRkjBVyAlnUWBh80VAFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526035121; bh=xE01HSMiXcmKCWSQkSB7Sl/sNh8L12
    GFx61dkTMaqVg=; b=THIPCDajUaVHKJ2B12LCeFLANiQsgiVjEme0A4NbPxJI2w
    sxcabDLe53jAn9lUlG309llArQnp0OdzmjJvQIlZNcN9ySJzRgR03Ktm5Y6+tDpq
    EQAlVPorL4fg5tHRI/aA9JJj1E9o2l4s3GmxmV3t1rjU2bFh708k/Xu0ADmhFpBu
    AKR2POccUSfd2iEH1/lPqNwACeIeZAmzpsfRGKg73z+kFYF5oQ4Ai+G09zdFMD7h
    AGySdq4AEZBRLRHQ6dks67/+JO11uZjcwv+HLSH1gQFIXqnKpbV0Eef6nct2pzDP
    527m0nT1tGGNTpx0O0LMwMpesLPkKN2U1M61XR9A==
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
X-CM-Envelope: MS4wfCcjJHgE/Q+vfMrST+d0sA5PiOpRObT8H50WGk929OCMynkSy/QNvais97EnrD/cG5Zmnh3KPI1m5FOHcNJd+wvzWle9AwsuvI+8wDI3S7DHYIa8rtKm
    NnrahkQVjyxzt79XNlrMFv6KNbsmnW8rNpiSpp+JnaF611kgiiPceWzahYuFF/7KhGT8zBTssFUsFNH+sBGxQnuIFL0MVqG7DwUGcrF3+046GXsiJJTxZhcK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8
    a=VwQbUJbxAAAA:8 a=lgtFolcE7YT6ZknlNU4A:9 a=x8gzFH9gYPwA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeEKKiZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 06:38:25 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:28531 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752992AbeEKKh2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 May 2018 06:37:28 -0400
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="11427331"
From: Radu Pirea <radu.pirea@microchip.com>
To: <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC: <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <richard.genoud@gmail.com>,
        <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <broonie@kernel.org>, Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v3 3/6] MAINTAINERS: add at91 usart spi driver
Date: Fri, 11 May 2018 13:38:19 +0300
Message-ID: <20180511103822.31698-4-radu.pirea@microchip.com>
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

