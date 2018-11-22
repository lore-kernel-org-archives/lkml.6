Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08286C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A117020659
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A117020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438857AbeKWHpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 02:45:33 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39380 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730446AbeKWHpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 02:45:32 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3F3E220DA7; Thu, 22 Nov 2018 22:04:23 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9BE5620DBE;
        Thu, 22 Nov 2018 22:04:22 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/6] Add Armada 3700 COMPHY support
Date:   Thu, 22 Nov 2018 22:04:14 +0100
Message-Id: <20181122210420.14861-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds a new driver to support Armada 3700 COMPHY IP.
The series has been tested on an ESPRESSObin with SATA, PCIe
and USB3 host. For this purpose, patch 1 enumerates the SATA PHY
mode. The SGMII PHY mode that is supported by the IP has been written
(uses SMC calls anyway) but could not be tested on this platform.

Three series will follow to add PHY support (or at least a PHY nodes
in the A3700/ESPRESSObin device trees) to the MVEBU AHCI driver, the
Aardvark PCI controller driver and the MVEBU xHCI driver. All this is
needed in order to achieve suspend to RAM on this platform.

Thanks,
Miquèl


Miquel Raynal (6):
  phy: enumerate SATA PHY mode
  phy: add A3700 COMPHY support
  dt-bindings: phy: mvebu-comphy: extend the file to describe a3700
    bindings
  MAINTAINERS: phy: add entry for Armada 3700 COMPHY driver
  ARM64: dts: marvell: armada-37xx: fix SATA node scope
  ARM64: dts: marvell: armada-37xx: declare the COMPHY node

 .../bindings/phy/phy-mvebu-comphy.txt         |  65 ++++-
 MAINTAINERS                                   |   6 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  31 +-
 drivers/phy/marvell/Kconfig                   |  10 +
 drivers/phy/marvell/Makefile                  |   1 +
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c  | 276 ++++++++++++++++++
 include/linux/phy/phy.h                       |   1 +
 7 files changed, 377 insertions(+), 13 deletions(-)
 create mode 100644 drivers/phy/marvell/phy-mvebu-a3700-comphy.c

-- 
2.19.1

