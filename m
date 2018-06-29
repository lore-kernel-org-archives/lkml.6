Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F4BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679D2248FC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679D2248FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965557AbeF2IjK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:39:10 -0400
Received: from mx.socionext.com ([202.248.49.38]:43004 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965312AbeF2IjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:39:02 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Jun 2018 17:39:01 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id B83A31800FC;
        Fri, 29 Jun 2018 17:39:01 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 29 Jun 2018 17:39:01 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 4BCDF1A120B;
        Fri, 29 Jun 2018 17:39:01 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/4]  phy: socionext: add new UniPhier USB PHY driver support
Date:   Fri, 29 Jun 2018 17:38:57 +0900
Message-Id: <1530261541-23104-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for PHY interface built into USB controller
implemented in Socionext UniPhier SoCs.

The USB3 PHY driver supports High-Speed PHY and Super-Speed PHY included in
the USB3 glue layer, and the USB2 PHY driver supports High-Speed PHY
integrated into system controller.

Kunihiko Hayashi (4):
  dt-bindings: phy: add DT bindings for UniPhier USB3 PHY driver
  phy: socionext: add USB3 PHY driver for UniPhier SoC
  dt-bindings: phy: add DT bindings for UniPhier USB2 PHY driver
  phy: socionext: add USB2 PHY driver for UniPhier SoC

 .../devicetree/bindings/phy/uniphier-usb2-phy.txt  |  45 +++
 .../devicetree/bindings/phy/uniphier-usb3-phy.txt  | 118 ++++++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/socionext/Kconfig                      |  25 ++
 drivers/phy/socionext/Makefile                     |   7 +
 drivers/phy/socionext/phy-uniphier-usb2.c          | 218 +++++++++++
 drivers/phy/socionext/phy-uniphier-usb3hs.c        | 422 +++++++++++++++++++++
 drivers/phy/socionext/phy-uniphier-usb3ss.c        | 369 ++++++++++++++++++
 9 files changed, 1206 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-phy.txt
 create mode 100644 drivers/phy/socionext/Kconfig
 create mode 100644 drivers/phy/socionext/Makefile
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb2.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c

-- 
2.7.4

