Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3339C282DB
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A568B2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfA3P6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:58:54 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:43928 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfA3P6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:58:53 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id C10C53A6386;
        Wed, 30 Jan 2019 16:50:28 +0100 (CET)
X-Originating-IP: 90.88.147.226
Received: from localhost.localdomain (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id AEBC8FF806;
        Wed, 30 Jan 2019 15:50:25 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/3] SMSC USB333x ULPI USB PHY Support
Date:   Wed, 30 Jan 2019 16:50:20 +0100
Message-Id: <20190130155023.4495-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the SMSC USB333x ULPI USB PHY.

The USB333x usually does not require particular configuration as it
implements generic registers described in the ULPI specification.

However, specific use cases require tweaking some bits. In our case,
VBUS is not connected to anything so the internal EXTVBUS signal has to
be routed to assert VbusValid. 

Paul Kocialkowski (3):
  dt-bindings: phy: Add bindings for the SMSC USB333x ULPI USB PHY
  phy: Add support for the SMSC USB333x ULPI USB PHY
  MAINTAINERS: Add entry for the SMSC USB333x ULPI USB PHY

 .../devicetree/bindings/phy/smsc-usb333x.txt  |  50 +++
 MAINTAINERS                                   |   6 +
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/smsc/Kconfig                      |  11 +
 drivers/phy/smsc/Makefile                     |   2 +
 drivers/phy/smsc/phy-usb333x.c                | 301 ++++++++++++++++++
 7 files changed, 372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/smsc-usb333x.txt
 create mode 100644 drivers/phy/smsc/Kconfig
 create mode 100644 drivers/phy/smsc/Makefile
 create mode 100644 drivers/phy/smsc/phy-usb333x.c

-- 
2.20.1

