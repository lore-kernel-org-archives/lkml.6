Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3782484-1526035034-2-8906581217488025654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526035033; b=RFFrA4XtsFKN+Z1KIS99D4lyXXEo/zWmx+AtZzncgz8Ftmsei5
    DzwZ8vCwbF1GuAcA9vrBKXObzZ3QG4JGZvTbKiu5qyHWJJ3HSYZClkwvhwf8+kGj
    BLtMB+xJhQhmx5vPlMr44Z/mIm0bNDS29wmwAd/dUL23HdDO9wNt5Lz+WruQDa0j
    sxUOAve2gocGoJK3/Ph6QoQLPfuRRqKRs9oNsPz9ChcQghHwpVPdyyx/9TXlFIPr
    JKZJK+l62wSWNmsP53zXdxQjdCVf39MRxJNa/819AmI82HCMCsPocMk9/erLlJQI
    khyr4z2XKTx0PPbcSxtVt64Hjcs/Ckw0aOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526035033;
    bh=M0N8+FNsKCGiK+oOa8qqQiw1fUpnRDJMx610BIdtL0I=; b=KNjIWWI3jH8Q
    nzPTX5vDxNDN5TG9A38Za79kMaZRS6bRKmr4P/+cYTf/mmR8qwtOL0UhvYXc6T0n
    jCWLJI9mcpQH0XpHI+IwX1N4Cf4vpAKmlaIUesgwtPPxdfs3U0hCaPJj5ZJvK06n
    wYcwMz5AKbkjHs1Gv0JlOV8ygj6ydROfQpQkAa81WOqgjQ4FwrcKWbpxN9m6jfkT
    ELJ0bPGxhmAwhX1eOgwIVNaE2xHX6pURzFz4UC90Vcy28TdRFGlfDOItxd8v+IPj
    +A+z5NziKHFyTK3tKXycf4KWjkp7Rpa0BuacpuLecY3bSLkz7dOFxsFVKrwQbhet
    E6T0QfMnqg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfFKP2BaUlrJZqTxIQ8wc4Yqaqh65QjddVGMt0sVO63DEWYCIup1tyEa9ASrhfhQ/6sUL1PuQKxhQhldykrWMNAFqDPnNRxiJZz/U1penYh9m7JxhUqfu
    ezfqaAmu+/d4id4AZKy6DCva1Gjk7PvUtXJzzyzzyErUf8bcRTi5dm4wHWM6QfWL3tGXF/LriWy7eBAUk4NPbczXWgUP7ees8SFTKK/Aqct2LZfYszaxJoSG
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=dTC2yFRboX6dEhdSITUA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeEKKhM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 06:37:12 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:60829 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbeEKKhL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 May 2018 06:37:11 -0400
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="11960894"
From: Radu Pirea <radu.pirea@microchip.com>
To: <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC: <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <richard.genoud@gmail.com>,
        <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <broonie@kernel.org>, Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v3 0/6] Driver for at91 usart in spi mode
Date: Fri, 11 May 2018 13:38:16 +0300
Message-ID: <20180511103822.31698-1-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

This is the second version of driver. I added a mfd driver which by
default probes atmel_serial driver and if in dt is specified to probe
the spi driver, then the spi-at91-usart driver will be probed. The
compatible for atmel_serial is now the compatible for at91-usart mfd
driver and compatilbe for atmel_serial driver was changed in order to
keep the bindings for serial as they are.

Changes in v1:
- added spi-at91-usart driver

Changes in v2:
- added at91-usart mfd driver
- modified spi-at91-usart driver to work as mfd driver child
- modified atmel_serial driver to work as mfd driver child

Changes in v3:
- fixed spi slaves probing

Radu Pirea (6):
  MAINTAINERS: add at91 usart mfd driver
  mfd: at91-usart: added mfd driver for usart
  MAINTAINERS: add at91 usart spi driver
  dt-bindings: add binding for at91-usart in spi mode
  spi: at91-usart: add driver for at91-usart as spi
  tty/serial: atmel: changed the driver to work under at91-usart mfd

 .../bindings/spi/microchip,at91-usart-spi.txt |  28 +
 MAINTAINERS                                   |  14 +
 drivers/mfd/Kconfig                           |  10 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/at91-usart.c                      |  75 +++
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-at91-usart.c                  | 544 ++++++++++++++++++
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/atmel_serial.c             |  29 +-
 include/dt-bindings/mfd/at91-usart.h          |  17 +
 11 files changed, 715 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 drivers/spi/spi-at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

-- 
2.17.0

