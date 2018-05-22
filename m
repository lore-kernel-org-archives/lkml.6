Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeEVMH2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:07:28 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:40320 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeEVMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:07:23 -0400
From: Stefan Agner <stefan@agner.ch>
To: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [RESEND PATCH 0/5] mtd: rawnand: add NVIDIA Tegra NAND flash support
Date: Tue, 22 May 2018 14:07:04 +0200
Message-Id: <cover.1526990589.git.stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
X-Spamd-Result: default: False [-2.09 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[26];
         BAYES_HAM(-2.99)[99.97%];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:6830, ipnet:46.140.0.0/17, country:AT];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resending, this time with mailing lists in cc]

This picks up an older patchset written by Lucas Stach which
adds raw NAND flash support for Tegra 2.
http://lists.infradead.org/pipermail/linux-mtd/2015-November/063031.html

The driver has been reworked to implement the ->exec_op callback.
Some smaller changes and bug fixes have been applied too, but I did
not keep track of them. Since the original patchset has been posted
some years back already, I guess review needs to be done from scratch
anyway.

--
Stefan

Lucas Stach (4):
  mtd: rawnand: tegra: add devicetree binding
  clk: tegra20: init NDFLASH clock to sensible rate
  ARM: tegra: add Tegra20 NAND flash controller node
  ARM: tegra: enable NAND flash on Colibri T20

Stefan Agner (1):
  mtd: rawnand: add NVIDIA Tegra NAND Flash controller driver

 .../bindings/mtd/nvidia,tegra20-nand.txt      |  29 +
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/tegra20-colibri-512.dtsi    |   7 +
 arch/arm/boot/dts/tegra20.dtsi                |  13 +
 drivers/clk/tegra/clk-tegra20.c               |   1 +
 drivers/mtd/nand/raw/Kconfig                  |   6 +
 drivers/mtd/nand/raw/Makefile                 |   1 +
 drivers/mtd/nand/raw/tegra_nand.c             | 915 ++++++++++++++++++
 8 files changed, 979 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
 create mode 100644 drivers/mtd/nand/raw/tegra_nand.c

-- 
2.17.0
