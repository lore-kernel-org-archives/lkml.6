Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40E1C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826D920869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVxEGz0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826D920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbeKET4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:56:04 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41324 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeKET4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:56:03 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so5737052lfj.8;
        Mon, 05 Nov 2018 02:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=t0WvrQTAK1cl+miP2jL8xiPiYqfdI7dTrVN6+Bdywfk=;
        b=MVxEGz0yym6KAiZboDK4kDrEFJiCqvWberQ6a1EudrXzwORhXCJiyZHn0hjTwshnhX
         RqZ0JFN1Ylkr+5RMlmYG/wW7xytze/zX7NZtjV1Wx1CVkCzqgQE9jGxzFrgMcFApJwjY
         4ASLAHcgar4DQXhmrU7IBHAyd1L2cHrVKyEvrDhzpsubeZXmgcmMuqtNA2XXrn5Q0ref
         LOAEZNQhilyDKdCCAwE4i1ykqS4Ynao16phxWFsPhALp8xi6BfyklcA9TFO3ZCEfbCOM
         t01JyxxbDk1wQrJixl61rTPosjXvfWBqVMO+iqGgwJP6ZmdlncFtM7Mls0qu0MDmOt2Q
         es8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t0WvrQTAK1cl+miP2jL8xiPiYqfdI7dTrVN6+Bdywfk=;
        b=m7+Zcpo3G0J3FCRdoi7Pz0E+qduuTGPuY7mkyl9OzY29/Yu4SKNt+rrWOrToqUgnSN
         wca1sLBvyM6mZ2+TjUrlFJ74eaMuPSJc9as+ly0DAJSy35fOtDjUwa5OATW9RMQ6QWi2
         cx8pWLqMxDJ+/U0zXamH5t8TbxA8ZnvsCkQ5TTPq4rwwpWvLMR0PTuAseZUuMPm2aqeW
         LHkywRFSmLIEXMHuisAsSfDtIz39M436vkphgprIRUyMF/lVjJQZ3jNJo4qBGlxakF4T
         SomW3Y+9dJpbGk0JD86KHp03Fd0sQOKIiI2iQM+CdCgvQDu3Qz7AL6J6RuuIgcW7oxKA
         PJQQ==
X-Gm-Message-State: AGRZ1gLT7Pnzdz7WsOqoz7nmdLb3pSULVDPnDHb9kEFFjOxkkM/L/Hqx
        5OybBdvr2pNR8mNNQobrZQ==
X-Google-Smtp-Source: AJdET5ep5RdQ0VyD6eP9WrHJXAUDfR1blYvSLYUt/sULsyx0ofc/qCe4hWhVxAcZGll0NIA2LkspMw==
X-Received: by 2002:a19:641d:: with SMTP id y29mr11983778lfb.14.1541414218858;
        Mon, 05 Nov 2018 02:36:58 -0800 (PST)
Received: from localhost.localdomain (89-64-7-227.dynamic.chello.pl. [89.64.7.227])
        by smtp.gmail.com with ESMTPSA id h140-v6sm5413605lfg.4.2018.11.05.02.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 02:36:57 -0800 (PST)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>
Subject: [PATCH v3 0/6] New QuadSPI driver for Atmel SAMA5D2
Date:   Mon,  5 Nov 2018 11:36:19 +0100
Message-Id: <20181105103625.9644-1-bugalski.piotr@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Atmel SAMA5D2 is equipped with two QSPI interfaces. These interfaces can
work as in SPI-compatible mode or use two / four lines to improve
communication speed. At the moment there is QSPI driver strongly tied to
NOR-flash memory and MTD subsystem.
Intention of this change is to provide new driver which will not be tied
to MTD and allows using QSPI with NAND-flash memory or other peripherals
New spi-mem API provides abstraction layer which can disconnect QSPI
from MTD. This driver doesn't support regular SPI interface, it should
be used with spi-mem interface only.
Unfortunately SAMA5D2 hardware by default supports only NOR-flash
memory. It allows 24- and 32-bit addressing while NAND-flash requires
16-bit long. To workaround hardware limitation driver is a bit more
complicated.

Request to spi-mem contains three fiels: opcode (command), address,
dummy bytes. SAMA5D2 QSPI hardware supports opcode, address, dummy and
option byte where address field can only be 24- or 32- bytes long.
Handling 8-bits long addresses is done using option field. For 16-bits
address behaviour depends of number of requested dummy bits. If there
are 8 or more dummy cycles, address is shifted and sent with first dummy
byte. Otherwise opcode is disabled and first byte of address contains
command opcode (works only if opcode and address use the same buswidth).
The limitation is when 16-bit address is used without enough dummy
cycles and opcode is using different buswidth than address. Other modes
are supported with described workaround.

It looks like hardware has some limitation in performance. The same issue
exists in current QSPI driver (MTD/nor-flash) and soft-pack (bare-metal
library from Atmel). Without using DMA read speed is much worse than
maximum bandwidth (efficiency 30-40%). Any help with performance
improvement is highly welcome, especially for NAND-flash memories which
offers higher capacity than NOR-flash used with previous driver.

Best Regards,
Piotr

v3 changes:
 - add get_name implementation
 - email address fix

v2 changes:
 - driver is now replacement of existing atmel-quadspi
 - code was re-written to follow original code structure
 - deinitialization order fixed
 - empty atmel_qspi_adjust_op_size function removed
 - code formatting fixes
 - use spi_device->max_speed_hz to get spi speed
 - spi freqency set in spi_controller->setup() hook
 - address range checkng for 4-bytes addressing
 - use timeout to avoid infinite waiting

Piotr Bugalski (6):
  mtd: spi-nor: atmel-quaspi: Typo fix
  mtd: spi-nor: atmel-quadspi: Add spi-mem support to atmel-quadspi
  mtd: spi-nor: atmel-quadspi: Use spi-mem interface for atmel-quadspi
    driver
  mtd: spi-nor: atmel-quadspi: Remove unused code from atmel-quadspi
    driver
  spi: Add QuadSPI driver for Atmel SAMA5D2
  dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2

 .../bindings/{mtd => spi}/atmel-quadspi.txt        |   0
 drivers/mtd/spi-nor/Kconfig                        |   9 -
 drivers/mtd/spi-nor/Makefile                       |   1 -
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/{mtd/spi-nor => spi}/atmel-quadspi.c       | 528 ++++++---------------
 6 files changed, 158 insertions(+), 390 deletions(-)
 rename Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt (100%)
 rename drivers/{mtd/spi-nor => spi}/atmel-quadspi.c (53%)

-- 
2.11.0

