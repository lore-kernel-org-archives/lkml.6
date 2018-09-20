Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D008FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8533C2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iNskHUS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8533C2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbeITRBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:01:55 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:35806 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731580AbeITRBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:01:55 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5C08D24E11DC;
        Thu, 20 Sep 2018 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537442336; bh=oXnQNihPmc0fk9RZ4hzCJqavtVIRLP6VcU68oPTG4Q4=;
        h=From:To:Cc:Subject:Date:From;
        b=iNskHUS1AbvivhBk8tDDnRncBtSGvRVbLjEzdAx1wLDOFUnCZhsfU8u3JzNWVCfyF
         Mx2zKDrYmpmvTkU3DjgA4tWyuhgepmSY/OQc0/mZt+Yn5ytlf++DRnTPf5FgeCBDM4
         B35rrmgc8PoQB/28LChBsk5F86SWhFkWGhWR+GtKmz/6dQuZvQ0o97zbTrRyX9N/Vt
         spwayUxqCmbxaSoQZ597Y0U0oQameU0q817SbdBFRDOaaGm7zAh3XABrUJuxE7Tp6Z
         zFAbzlDvY6AxY214vZLD3xSJFr+34Nn39qQxKw4MH9qNiLpDPJ1kGc+8lj2nYTQ70B
         DKfnoBLCbqsYQ==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 99B593BC6;
        Thu, 20 Sep 2018 04:18:52 -0700 (PDT)
Received: from de02dwemt291.internal.synopsys.com (de02dwemt291.internal.synopsys.com [10.225.18.65])
        by de02.synopsys.com (Postfix) with ESMTP id 77E333E49A;
        Thu, 20 Sep 2018 13:18:51 +0200 (CEST)
Received: from de02dwemt291.internal.synopsys.com (localhost [127.0.0.1])
        by de02dwemt291.internal.synopsys.com (8.14.4/8.12.3) with ESMTP id w8KBIpGl028417;
        Thu, 20 Sep 2018 13:18:51 +0200
Received: (from lolivei@localhost)
        by de02dwemt291.internal.synopsys.com (8.14.4/8.14.4/Submit) id w8KBIg4P028372;
        Thu, 20 Sep 2018 13:18:42 +0200
From:   Luis Oliveira <Luis.Oliveira@synopsys.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joao.Pinto@synopsys.com, festevam@gmail.com,
        Luis Oliveira <Luis.Oliveira@synopsys.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>
Subject: [V2, 0/5]  platform: dwc: Add of DesignWare MIPI CSI-2 Host
Date:   Thu, 20 Sep 2018 13:16:38 +0200
Message-Id: <20180920111648.27000-1-lolivei@synopsys.com>
X-Mailer: git-send-email 2.9.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for Synopsys MIPI CSI-2 Host and MIPI D-PHY.
The patch series include support for initialization/configuration of the
DW MIPI CSI-2 controller and DW MIPI D-PHY and both include a reference
platform driver.

This will enable future SoCs to use this standard approach and possibly
create a more clean environment.

This series also documents the dt-bindings needed for the platform drivers.

This was applied in: https://git.linuxtv.org/media_tree.git

Luis Oliveira (5):
  media: platform: Add a DesignWare folder to have Synopsys drivers
  Documentation: dt-bindings: Document the Synopsys MIPI DPHY Rx
    bindings
  media: platform: dwc: Add DW MIPI DPHY Rx platform
  Documentation: dt-bindings: Document bindings for DW MIPI CSI-2 Host
  media: platform: dwc: Add MIPI CSI-2 controller driver

 .../devicetree/bindings/media/snps,dw-csi-plat.txt |  74 +++
 .../devicetree/bindings/phy/snps,dphy-rx.txt       |  36 ++
 MAINTAINERS                                        |  11 +
 drivers/media/platform/Kconfig                     |   1 +
 drivers/media/platform/Makefile                    |   3 +
 drivers/media/platform/dwc/Kconfig                 |  43 ++
 drivers/media/platform/dwc/Makefile                |   4 +
 drivers/media/platform/dwc/dw-csi-plat.c           | 508 ++++++++++++++++++
 drivers/media/platform/dwc/dw-csi-plat.h           |  76 +++
 drivers/media/platform/dwc/dw-dphy-plat.c          | 365 +++++++++++++
 drivers/media/platform/dwc/dw-dphy-rx.c            | 594 +++++++++++++++++++++
 drivers/media/platform/dwc/dw-dphy-rx.h            | 176 ++++++
 drivers/media/platform/dwc/dw-mipi-csi.c           | 490 +++++++++++++++++
 drivers/media/platform/dwc/dw-mipi-csi.h           | 202 +++++++
 include/media/dwc/dw-mipi-csi-pltfrm.h             | 101 ++++
 15 files changed, 2684 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt
 create mode 100644 Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
 create mode 100644 drivers/media/platform/dwc/Kconfig
 create mode 100644 drivers/media/platform/dwc/Makefile
 create mode 100644 drivers/media/platform/dwc/dw-csi-plat.c
 create mode 100644 drivers/media/platform/dwc/dw-csi-plat.h
 create mode 100644 drivers/media/platform/dwc/dw-dphy-plat.c
 create mode 100644 drivers/media/platform/dwc/dw-dphy-rx.c
 create mode 100644 drivers/media/platform/dwc/dw-dphy-rx.h
 create mode 100644 drivers/media/platform/dwc/dw-mipi-csi.c
 create mode 100644 drivers/media/platform/dwc/dw-mipi-csi.h
 create mode 100644 include/media/dwc/dw-mipi-csi-pltfrm.h

-- 
2.9.3

