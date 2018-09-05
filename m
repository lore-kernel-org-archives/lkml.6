Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE786C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD83205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD83205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIEOTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:19:16 -0400
Received: from mx.socionext.com ([202.248.49.38]:54948 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbeIEOTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:19:16 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 05 Sep 2018 18:49:50 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 02C201800E0;
        Wed,  5 Sep 2018 18:49:50 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 5 Sep 2018 18:49:49 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 82E711A03A2;
        Wed,  5 Sep 2018 18:49:49 +0900 (JST)
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
Subject: [PATCH 0/2] add new UniPhier PCIe PHY driver
Date:   Wed,  5 Sep 2018 18:49:43 +0900
Message-Id: <1536140985-6058-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for PCIe PHY interface implemented in Socionext
UniPhier SoCs. This driver supports LD20 and PXs3 SoCs.

This series contains changes to phy/Kconfig and phy/Makefile, and will conflict
with the preceding PHY patches for USB [1]. Either one needs to rebase itself
later.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/597430.html

Kunihiko Hayashi (2):
  dt-bindings: phy: add UniPhier PCIe PHY description
  phy: socionext: add PCIe PHY driver support

 .../devicetree/bindings/phy/uniphier-pcie-phy.txt  |  31 +++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/socionext/Kconfig                      |  12 ++
 drivers/phy/socionext/Makefile                     |   6 +
 drivers/phy/socionext/phy-uniphier-pcie.c          | 240 +++++++++++++++++++++
 6 files changed, 291 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
 create mode 100644 drivers/phy/socionext/Kconfig
 create mode 100644 drivers/phy/socionext/Makefile
 create mode 100644 drivers/phy/socionext/phy-uniphier-pcie.c

-- 
2.7.4

