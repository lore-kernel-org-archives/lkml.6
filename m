Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B81C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86551261E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAzbFXq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86551261E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754546AbeF0NQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:16:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36917 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeF0NQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:16:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id v22-v6so3070604edq.4;
        Wed, 27 Jun 2018 06:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=enj+RknWQFZPQt6GKnAK5dY7dJqtJcc0WQt0IHvtgSI=;
        b=VAzbFXq3IiNICMm1VAPuyVO5zatfE0Xkvcs2LomrdHTDfcFxg7PlsL0YJXrN0Y5tpG
         CyF722ahaexALS4LNQSGRW4jV/l/wQH8oSGZQRrpA7RetKFmHlFYNIVrvaVRYb716Qg4
         XINKLnwf1C/QHXM/1rmwNLCoSigsrVC14LfF1vvKXDi9b+jl7OCCeAppxpAXTpmg4M95
         DJZuD25paKsi/tfHPmJlyOZtyTBM7wq72WpjdCWH65+T50+eiMNsGs6VQuewCka6UbdR
         DmMVuiEWRX6qtTfyxjsseXg8wOwBhQ9XRpsxFZYvZGjz8RWoqOAckFZ4tBXGmFIlZ3Wq
         tsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=enj+RknWQFZPQt6GKnAK5dY7dJqtJcc0WQt0IHvtgSI=;
        b=OPaMQGtBhPT5UoUX5bexJSAEzXF1Fdj4U3I04m9jaIHPl5OLuN3YS2xRNRG7y7NsCK
         2YDbX0fOsTIytwpJCYelTSnFj5+xrV1vP1ywXSl10RWVirictXKX+oz7CGGquL21M4Jp
         Hlf0LvyECRQQ29wVBc/r0kdbTA2yMGmFL/F9bQGY5bjB7GUxZOGyCYaU7lUin5OtNNlT
         yohQjHoniAICPucC6P0Sp0Od73C3IXa+6irByOr3/naZJDmUWVbHlQx6kCLEVZMLgHXp
         48qhkMACg1ARtU3yGlATr4GyZ8OtM6X6Ohxr5Or/pptAzL1yVbi3ziYbC0l4X71VB6NX
         Kctw==
X-Gm-Message-State: APt69E2P1DV4lh20QZ+1JnxgDHuF1/XeNz4d/ynPN2ISSeVR0D4qGDL5
        ON99YxdMRc8ddaBWYjzvLLnaWc0=
X-Google-Smtp-Source: AAOMgpdnzO0rEazg1vzj1HzQegg4+LYS0GcDkhcnKCZRuk8XgYFKHUwUgFbPohWyrXKe5GAtq4ELhw==
X-Received: by 2002:aa7:d788:: with SMTP id s8-v6mr5609584edq.228.1530105377822;
        Wed, 27 Jun 2018 06:16:17 -0700 (PDT)
Received: from carbonite.sagemdenmark.dk ([130.228.251.5])
        by smtp.gmail.com with ESMTPSA id i34-v6sm1953000edc.29.2018.06.27.06.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:16:17 -0700 (PDT)
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
Subject: [RFC PATCH v2 0/6] New QuadSPI driver for Atmel SAMA5D2
Date:   Wed, 27 Jun 2018 15:16:03 +0200
Message-Id: <20180627131609.13681-1-bugalski.piotr@gmail.com>
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
 drivers/{mtd/spi-nor => spi}/atmel-quadspi.c       | 529 ++++++---------------
 6 files changed, 155 insertions(+), 394 deletions(-)
 rename Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt (100%)
 rename drivers/{mtd/spi-nor => spi}/atmel-quadspi.c (52%)

-- 
2.11.0

