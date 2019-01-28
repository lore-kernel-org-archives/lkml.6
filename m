Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9D4C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB5D20857
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbfA1R2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:28:30 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:45869 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730796AbfA1R21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:28:27 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from lsun@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 28 Jan 2019 19:28:25 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x0SHSNJZ008163;
        Mon, 28 Jan 2019 12:28:23 -0500
Received: (from lsun@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x0SHSKQv009022;
        Mon, 28 Jan 2019 12:28:20 -0500
From:   Liming Sun <lsun@mellanox.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woods <dwoods@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Cc:     Liming Sun <lsun@mellanox.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v8 0/2] TmFifo platform driver for Mellanox BlueField SoC
Date:   Mon, 28 Jan 2019 12:28:05 -0500
Message-Id: <1548696487-8840-1-git-send-email-lsun@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements the device side platform driver
support for the TmFifo on Mellanox BlueField SoC.

TmFifo is part of the RShim component. It provides FIFOs to
communicate with external host machine via USB or PCIe (SmartNic
case). External host machine has driver to access the RShim
component as well, which is not covered in this patch series.

This patch series was submitted to drivers/soc in previous versions.
This version (v8) re-submit it to drivers/platform according to
the received comments / suggestions.

Patch v8 1/2 has changes according to some comments from Vadim
Pasternak during Mellanox internal review.

Patch v8 2/2 was reviewed by Rob Herring before, but might need
a second look since the location of the driver code is moved.

Liming Sun (2):
  platform/mellanox: Add TmFifo driver for Mellanox BlueField Soc
  dt-bindings: soc: Add TmFifo binding for Mellanox BlueField SoC

 .../devicetree/bindings/soc/mellanox/tmfifo.txt    |   23 +
 drivers/platform/mellanox/Kconfig                  |   13 +-
 drivers/platform/mellanox/Makefile                 |    1 +
 drivers/platform/mellanox/mlxbf-tmfifo-regs.h      |   67 +
 drivers/platform/mellanox/mlxbf-tmfifo.c           | 1289 ++++++++++++++++++++
 5 files changed, 1392 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt
 create mode 100644 drivers/platform/mellanox/mlxbf-tmfifo-regs.h
 create mode 100644 drivers/platform/mellanox/mlxbf-tmfifo.c

-- 
1.8.3.1

