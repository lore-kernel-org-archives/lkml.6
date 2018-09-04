Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E460C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368872075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=upb.ro header.i=@upb.ro header.b="fhbiiNQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368872075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=upb.ro
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeIDPo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:44:59 -0400
Received: from mail.upb.ro ([141.85.13.5]:56688 "EHLO mx.upb.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbeIDPo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:44:59 -0400
Received: from mx.upb.ro (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTPS id AA1C9B560061;
        Tue,  4 Sep 2018 14:13:20 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTP id 8A662B560059;
        Tue,  4 Sep 2018 14:13:20 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.upb.ro 8A662B560059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=upb.ro;
        s=96342B8A-77E4-11E5-BA93-D93D0963A2DF; t=1536059600;
        bh=9FCsquMdxX8YK7bFnxznHVYWUMqgKyASnYzXgWDN9lo=;
        h=From:To:Date:Message-Id;
        b=fhbiiNQ4dkD5/XLRhfgy45QntWsFYGXK5KEJ8uGtBi1T4ruL8h3eA39c6+j0nnCcO
         IA+as6FPidoZlQ5o26koyGqMmLHGx0bqh5t1V6x5ZHpSnt9FtRHrNr7FK19eAxNgsH
         ATnVqVo5Znr/l0dpkjsBVWGgWr96wte1Fgvc6TdU=
Received: from mx.upb.ro ([127.0.0.1])
        by localhost (mx.upb.ro [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rP3JoLr5BizG; Tue,  4 Sep 2018 14:13:20 +0300 (EEST)
Received: from asus-rog.localdomain (arh.pub.ro [141.85.160.17])
        by mx.upb.ro (Postfix) with ESMTPSA id 5EBEEB56004E;
        Tue,  4 Sep 2018 14:13:20 +0300 (EEST)
From:   Radu Pirea <radu_nicolae.pirea@upb.ro>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        gregkh@linuxfoundation.org, broonie@kernel.org, jslaby@suse.com,
        richard.genoud@gmail.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Radu Pirea <radu_nicolae.pirea@upb.ro>
Subject: [PATCH v12 0/6] Driver for at91 usart in spi mode
Date:   Tue,  4 Sep 2018 14:13:04 +0300
Message-Id: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Well, this is the 12th version of this patch series.
In this version I fixed a warning from kbuild-robot and I have no idea
how I forgot to add static in declaration of that functions. Also I
fixed the example for the SPI driver in bindings.

Currently I am not working for Microchip, but I will continue to
maintain and improve this driver. So yes, this is the reason that
I changed my email address from MAINTAINERS file.

Changes in v12:
- fixed interrupts property in example from bindings of SPI driver
- changed email address in MAINTAINERS
- added static to declaration of few functions in SPI
  driver(kbuild-robot warning)

Changes in v11:
- removed "depends on HAS_DMA" from drivers/spi/Kconfig because the driver has
no dma support
- changed "selects MFD_AT91_USART" to "depends on MFD_AT91_USART" in
drivers/spi/Kconfig
- changed comment style in spi-at91-usart.c

Changes in v10:
-fixed kbuild test robot warning

Changes in v9:
- minor changes
- rebased on top of broonie/for-4.19

Changes in v8:
- fixed passing an empty mfd cell if "atmel,usart-mode" value is invalid

Changes in v7:
- synced up  SPDIX license with module license
- numbering of usart modes starts from 0 insteand of 1

Changes in v6:
- removed unused compatible strings from serial and spi drivers

Changes in v5:
- fixed usage of stdout-path property with atmel_serial driver

Changes in v4:
- modified the spi driver to use cs gpio support form spi subsystem
- fixed dma transfers for serial driver
- squashed binding for spi and serial and moved them to mfd/atmel-usart.txt

Changes in v3:
- fixed spi slaves probing

Changes in v2:
- added at91-usart mfd driver
- modified spi-at91-usart driver to work as mfd driver child
- modified atmel_serial driver to work as mfd driver child

Changes in v1:
- added spi-at91-usart driver

Radu Pirea (6):
  MAINTAINERS: add at91 usart mfd driver
  dt-bindings: add binding for atmel-usart in SPI mode
  mfd: at91-usart: added mfd driver for usart
  MAINTAINERS: add at91 usart spi driver
  spi: at91-usart: add driver for at91-usart as spi
  tty/serial: atmel: change the driver to work under at91-usart mfd

 .../bindings/{serial => mfd}/atmel-usart.txt  |  25 +-
 MAINTAINERS                                   |  16 +
 drivers/mfd/Kconfig                           |   9 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/at91-usart.c                      |  71 +++
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-at91-usart.c                  | 432 ++++++++++++++++++
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/atmel_serial.c             |  42 +-
 include/dt-bindings/mfd/at91-usart.h          |  17 +
 11 files changed, 606 insertions(+), 17 deletions(-)
 rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 drivers/spi/spi-at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

-- 
2.18.0

