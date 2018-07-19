Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC72C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C752F2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C752F2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeGSK3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:29:10 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:56724 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeGSK3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:29:10 -0400
Received: from ofmlt.linux-actions.org (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 19 Jul 2018
 17:46:07 +0800
From:   Yixun Lan <yixun.lan@amlogic.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RFC PATCH v2 0/2] mtd: rawnand: meson: add Amlogic NAND driver support
Date:   Thu, 19 Jul 2018 17:46:10 +0800
Message-ID: <20180719094612.5833-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  These two patches try to add initial NAND driver support for Amlogic Meson
SoCs, current it has been tested on GXL(p212) and AXG(s400) platform.

  Note this patch series actually depend on the eMMC clkc patch[2] which
still not merged.

Changes since v1 at [1]:
   - adopt property amlogic,nand-enable-scrambler - thanks Martin
   - drop nand pins in DT
   - convert clk access to emmc clkc model 
   - fix regiser field definition alignment
   - convert devm_kmalloc to kmalloc API
   - drop nand-user-mode 
   - parse cs id from DT
   - rework n2m, m2n function
   - explain why insert two "IDLE" command
   - implement exec_op()
   - drop meson_nfc_get_nand_chip_dts()
   - release resource once error occur in meson_nfc_nand_chips_init(), 
   - call nand_cleanup(nand) once mtd_device_register fail

Items not addressed in this version:
   - convert to ECC conf helper() 
   - how to construct mtd->name

[1] https://lkml.kernel.org/r/20180613161314.14894-1-yixun.lan@amlogic.com
[2] https://lkml.kernel.org/r/20180712211244.11428-1-yixun.lan@amlogic.com

Liang Yang (1):
  dt-bindings: nand: meson: add Amlogic NAND controller driver

Yixun Lan (1):
  mtd: rawnand: meson: add support for Amlogic NAND flash controller

 .../bindings/mtd/amlogic,meson-nand.txt       |   95 ++
 drivers/mtd/nand/raw/Kconfig                  |   10 +
 drivers/mtd/nand/raw/Makefile                 |    1 +
 drivers/mtd/nand/raw/meson_nand.c             | 1333 +++++++++++++++++
 4 files changed, 1439 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 create mode 100644 drivers/mtd/nand/raw/meson_nand.c

-- 
2.18.0

