Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960E4C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1A020864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPY0XRuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1A020864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755322AbeFRQVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:21:51 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44418 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754492AbeFRQVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:21:49 -0400
Received: by mail-lf0-f67.google.com with SMTP id p23-v6so13878743lfh.11;
        Mon, 18 Jun 2018 09:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Rnc5Bticpciszux3a/NDWbIH+7cs+NeUCsYkT2wve4g=;
        b=LPY0XRuWxUt7TFXOF0EeIJaqkA5LrcoISBMBtFoMr8tyK/vgIfck7Wwy6yKRyuAhMW
         FdiqLQSVUt/O4Hz00n6Ui6Nd4GMILUUcvmVZ4S+Le8R2kue5+J39SjKxY1dh0Wt3eHWq
         PQ0iaQWgPDumlR3M7kgY56aDsdboSk1DsrS3A0dRFpamz+ct2+pY4YiDpwQm5658P7RF
         IuoVBOkZiFo4z+Z8Wey0E/IoPelPH62Ag/LhGo/Skes4QwaWjd+k0urANHWwCYEzPsZA
         sgeog90iQzexTlOLz7YAuXMvuO9qSlev2lA9VC6o9yuiUA+L9HdTeMek8yXyLJqI07S3
         tXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rnc5Bticpciszux3a/NDWbIH+7cs+NeUCsYkT2wve4g=;
        b=O6ZST6YSdqwJV6vl/v9th6iFW4Zd/JOqxLw4QD1+w+ZbSLDTgsMr/s/FL363NeEYJq
         msx+FYieQBMmJ5Z1MsMa8CX0oz0TvKBztr7vyHBoUYuhIGjkey02vzqXBK6ZLDT0f9DW
         nmA8WQz1WremIdbocuvUR6kAshHhYI7JEnyJJutuzn6q0i4DKlAakcEdpc7FImWDwpt1
         78q91yNKws88piMFPIHwwCj2+180FledENEUPr6EaVk444f5bfMp7ak8GmTpTyQscT0E
         LFTN3Wt0ScS3IsAyqzb6eMoqe4zFN7jYUhlpApLg/tGcH+Ou7Ye/dZknfmFY+Mwg1pHT
         OieQ==
X-Gm-Message-State: APt69E37zBh2CVLRqzsxLKuJH6Y/qj2WOxNB7WPhK47GRosVHZvZ94MA
        1mt4ihutJ63GVUOQjLWREg==
X-Google-Smtp-Source: ADUXVKLT7DSae3UaHD5oaoHlMHRXXoXdYOmirBUu8UPsBoMkOhfx+28f6yCxsQW5A6tOLf4W5BxnuQ==
X-Received: by 2002:a2e:2206:: with SMTP id i6-v6mr8526327lji.119.1529338907515;
        Mon, 18 Jun 2018 09:21:47 -0700 (PDT)
Received: from localhost.localdomain (89-64-25-103.dynamic.chello.pl. [89.64.25.103])
        by smtp.gmail.com with ESMTPSA id h90-v6sm2761220ljf.65.2018.06.18.09.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 09:21:46 -0700 (PDT)
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
Subject: [RFC PATCH 0/2] New QuadSPI driver for Atmel SAMA5D2
Date:   Mon, 18 Jun 2018 18:21:22 +0200
Message-Id: <20180618162124.21749-1-bugalski.piotr@gmail.com>
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

Piotr Bugalski (2):
  spi: Add QuadSPI driver for Atmel SAMA5D2
  dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2 documentation

 .../devicetree/bindings/spi/spi_atmel-qspi.txt     |  41 ++
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-atmel-qspi.c                       | 480 +++++++++++++++++++++
 4 files changed, 531 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt
 create mode 100644 drivers/spi/spi-atmel-qspi.c

-- 
2.11.0

