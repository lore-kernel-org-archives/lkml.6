Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BBCC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4453721479
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4453721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbeLCJQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:16:40 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:55757 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725872AbeLCJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:16:40 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id wB38ixbo010629;
        Mon, 3 Dec 2018 10:45:00 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id F13A062DA6; Mon,  3 Dec 2018 11:14:57 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, marek.vasut@gmail.com, richard@nod.at,
        robh+dt@kernel.org, mark.rutland@arm.com, yuenn@google.com,
        venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-mtd@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/2] SPI-NOR add NPCM FIU controller driver
Date:   Mon,  3 Dec 2018 11:14:54 +0200
Message-Id: <20181203091456.454030-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds Flash Interface Unit(FIU) SPI-NOR
support for the Nuvoton NPCM Baseboard Management 
Controller (BMC).
    
The FIU supports single, dual or quad communication interface.
    
the FIU controller can operate in following modes:
- User Mode Access(UMA): provides flash access by using an
  indirect address/data mechanism.
- direct rd/wr mode: maps the flash memory into the core
  address space.
- SPI-X mode: used for an expansion bus to an ASIC or CPLD.

The NPCM750/730/715/710 supports up to three FIU devices:
- FIU0 supports two chip select.
- FIU3 supports four chip select.
- FIUX supports two chip select.

The NPCM FIU driver tested on NPCM750 evaluation board.

Tomer Maimon (2):
  dt-binding: mtd: add NPCM FIU controller
  mtd: spi-nor: add NPCM FIU controller driver

 Documentation/devicetree/bindings/mtd/npcm-fiu.txt |  64 ++
 drivers/mtd/spi-nor/Kconfig                        |   8 +
 drivers/mtd/spi-nor/Makefile                       |   1 +
 drivers/mtd/spi-nor/npcm-fiu.c                     | 930 +++++++++++++++++++++
 4 files changed, 1003 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/npcm-fiu.txt
 create mode 100644 drivers/mtd/spi-nor/npcm-fiu.c

-- 
2.14.1

