Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5777FECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E57020644
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KkRtQsUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E57020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbeJSU6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:58:47 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:50568 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbeJSU6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:58:47 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 96DBA10C1320;
        Fri, 19 Oct 2018 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1539953567; bh=Y3hs2cq6I2lwuxSRrB2ikJFgoKsrdZaLTvvBFd5YpiA=;
        h=From:To:Cc:Subject:Date:From;
        b=KkRtQsUPa0Neuz62FrKxbvP4G7Dz4YbjlZddK6XJUujITIYdOaa278C7IwcA/lmxO
         TrwmlglQvk2bsZzxNLfXhrtKPpHaIr7kLNzsU0bJEz+BK2mjuZf3Wl/0Vpm8+BGd9Z
         IBPCqni2X9De1gGb9YTER2b+jEL4AkXtHJzk0m29UXKFnYPh1GNTAsVzONrjNCrb2r
         7yF1nwMwhACpK8QZV5l1mpF+wv+TzZaiAXVViBAkNdaoXkDugm2KKxYVzEnxZKXpu2
         cVV6W6aAy6IlmKvBVh9bPR1OaNKqSCY1GzihwoHm02VlSspQrLlJcZ4GWdA0rE/VUy
         xRaW/dd8hQTOQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2ED953C84;
        Fri, 19 Oct 2018 05:52:45 -0700 (PDT)
Received: from de02dwemt290.internal.synopsys.com (de02dwemt290.internal.synopsys.com [10.225.18.64])
        by de02.synopsys.com (Postfix) with ESMTP id 2FFC67E53;
        Fri, 19 Oct 2018 14:52:44 +0200 (CEST)
Received: from de02dwemt290.internal.synopsys.com (localhost [127.0.0.1])
        by de02dwemt290.internal.synopsys.com (8.14.4/8.12.3) with ESMTP id w9JCqhcR035844;
        Fri, 19 Oct 2018 14:52:43 +0200
Received: (from lolivei@localhost)
        by de02dwemt290.internal.synopsys.com (8.14.4/8.14.4/Submit) id w9JCqaen035841;
        Fri, 19 Oct 2018 14:52:36 +0200
From:   Luis Oliveira <luis.oliveira@synopsys.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     joao.pinto@synopsys.com, festevam@gmail.com,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Todor Tomov <todor.tomov@linaro.org>
Subject: [V3, 0/4] platform: dwc: Add of DesignWare MIPI CSI-2 Host
Date:   Fri, 19 Oct 2018 14:52:22 +0200
Message-Id: <1539953556-35762-1-git-send-email-lolivei@synopsys.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for Synopsys MIPI CSI-2 Host and MIPI D-PHY.
The patch series include support for initialization/configuration of the
DW MIPI CSI-2 controller and DW MIPI D-PHY and both include a reference
platform driver. This way the future PCI integration will be clean.

This will enable future SoCs to use this standard approach and possibly
create a more clean environment.

This series also documents the dt-bindings needed for the platform drivers.

This was applied in: https://git.linuxtv.org/media_tree.git

Luis Oliveira (4):
  Documentation: dt-bindings: phy: Document the Synopsys MIPI DPHY Rx
    bindings
  media: platform: dwc: Add DW MIPI DPHY Rx platform
  Documentation: dt-bindings: media: Document bindings for DW MIPI CSI-2
    Host
  media: platform: dwc: Add MIPI CSI-2 controller driver

 .../devicetree/bindings/media/snps,dw-csi-plat.txt |  52 ++
 .../devicetree/bindings/phy/snps,dphy-rx.txt       |  28 +
 MAINTAINERS                                        |  11 +
 drivers/media/platform/Kconfig                     |   1 +
 drivers/media/platform/Makefile                    |   3 +
 drivers/media/platform/dwc/Kconfig                 |  52 ++
 drivers/media/platform/dwc/Makefile                |   4 +
 drivers/media/platform/dwc/dw-csi-plat.c           | 699 +++++++++++++++++++++
 drivers/media/platform/dwc/dw-csi-plat.h           |  77 +++
 drivers/media/platform/dwc/dw-dphy-plat.c          | 347 ++++++++++
 drivers/media/platform/dwc/dw-dphy-rx.c            | 596 ++++++++++++++++++
 drivers/media/platform/dwc/dw-dphy-rx.h            | 181 ++++++
 drivers/media/platform/dwc/dw-mipi-csi.c           | 494 +++++++++++++++
 drivers/media/platform/dwc/dw-mipi-csi.h           | 202 ++++++
 include/media/dwc/dw-mipi-csi-pltfrm.h             | 102 +++
 15 files changed, 2849 insertions(+)
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
2.7.4

