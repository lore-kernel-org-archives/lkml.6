Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553B5C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9D820854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9D820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeILS6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:58:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60006 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbeILS6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:58:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7961080D;
        Wed, 12 Sep 2018 06:54:03 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C64673F720;
        Wed, 12 Sep 2018 06:53:58 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, coresight@lists.linaro.org,
        leo.yan@linaro.org, suzuki.poulose@arm.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Gross <andy.gross@linaro.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Ivan T . Ivanov" <ivan.ivanov@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, lipengcheng8@huawei.com,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        orsonzhai@gmail.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Wei Xu <xuwei5@hisilicon.com>, zhang.lyra@gmail.com,
        arm@kernel.org
Subject: [PATCH v2 00/11] dts: Update coresight device tree bindings
Date:   Wed, 12 Sep 2018 14:53:41 +0100
Message-Id: <20180912135352.19722-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coresight DT bindings have been updated to obey the DTS rules
for label/address matching for graph nodes. The changes are in
coresight/next tree scheduled for v4.20. This series updates the
in kernel dts to match the new bindings along with updating a couple
of new examples (e.,g CATU) in the Documentation (which were missed
as they were still in flight when we created the series).

Please note that this should not be pulled for v4.19, which I think
is a safe assumption. But please do pull it for v4.20.
The dt updates for the Juno boards were sent earlier with the original
DT update series and has been queued for v4.20.

Applies on coresight/next (which is based on v4.19) and should apply
cleanly on v4.19-rc3.

Changes since V1:
 - Avoid "avoid_unnecessary_addr_size" warnings by removing
   #address-cells/#size-cells for single port with address 0.
 - Fix TPIU inport for qcom msm8196.  (Leo Yan)
 - Fix documentation example for TPIU (Leo Yan)
 - Fix subject tags (as pointed out by Leo and Shawn)
 - Drop patch for TC2, which has been queued by Sudeep


Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Benoît Cousson <bcousson@baylibre.com>
Cc: David Brown <david.brown@linaro.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-omap@vger.kernel.org
Cc: lipengcheng8@huawei.com
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: orsonzhai@gmail.com
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: xuwei5@hisilicon.com
Cc: zhang.lyra@gmail.com
Cc: arm@kernel.org


Suzuki K Poulose (11):
  coresight: dts: binding: Fix example for TPIU component
  coresight: dts: binding: Update coresight binding examples
  arm64: dts: hi6220: Update coresight bindings for hardware ports
  arm64: dts: sc9836/sc9860: Update coresight bindings for hardware
    ports
  arm64: dts: msm8916: Update coresight bindings for hardware ports
  arm: dts: hip04: Update coresight bindings for hardware ports
  arm: dts: imx7: Update coresight binding for hardware ports
  arm: dts: omap: Update coresight bindings for hardware ports
  arm: dts: qcom: Update coresight bindings for hardware ports
  arm: dts: sama5d2: Update coresight bindings for hardware ports
  arm: dts: ste-dbx5x0: Update coresight bindings for hardware port

 .../devicetree/bindings/arm/coresight.txt     |  27 +-
 arch/arm/boot/dts/hip04.dtsi                  | 346 +++++++++---------
 arch/arm/boot/dts/imx7d.dtsi                  |  14 +-
 arch/arm/boot/dts/imx7s.dtsi                  |  82 ++---
 arch/arm/boot/dts/omap3-beagle-xm.dts         |  17 +-
 arch/arm/boot/dts/omap3-beagle.dts            |  17 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi           |  71 ++--
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 104 +++---
 arch/arm/boot/dts/sama5d2.dtsi                |  17 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi             |  65 ++--
 .../boot/dts/hisilicon/hi6220-coresight.dtsi  | 181 +++++----
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  95 ++---
 arch/arm64/boot/dts/sprd/sc9836.dtsi          |  82 +++--
 arch/arm64/boot/dts/sprd/sc9860.dtsi          | 215 +++++------
 14 files changed, 682 insertions(+), 651 deletions(-)

-- 
2.19.0

