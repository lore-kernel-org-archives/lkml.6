Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeCLOM6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:12:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57402 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeCLOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:12:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA2E46016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: andy.gross@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        swboyd@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        dianders@chromium.org, marc.zyngier@arm.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v7 0/3] Add DTS for SDM845 SoC and MTP
Date: Mon, 12 Mar 2018 19:42:21 +0530
Message-Id: <20180312141224.11907-1-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are basic device tree files needed to boot a SDM845 MTP
board to a ramfs based serial console shell

Bindings are based on whats proposed for pinctrl/serial/clock
drivers for SDM845 SoC
pinctrl: https://patchwork.kernel.org/patch/10157143/ (This is now pulled
in by Linus Walleij for 4.17)
clocks: https://lkml.org/lkml/2018/1/31/209 (under review)

I have dropped the patch that adds the serial/geni nodes from v6/7, as that
will be reposted along with the geni patch series by Karthik

Since 'PATCH 3/3' also adds an ITS node and keeps it disabled, we also depend
on https://lkml.org/lkml/2018/1/29/383

Andy, since we aren't adding anything new for clocks (gcc) and pinctrl,
do these look good to be pulled in for 4.17?

changes in v7:
* Dropped redistributor-stride and #redistributor-regions as suggested
by Marc Zyngier

changes in v6:
* added the missing power-domain-cells property for gcc as reported
by Doug Anderson 
* Dropped the patch which added geni/serial nodes in dts. Karthik has
agreed to carry that patch along with his GENI series. 

changes in v5:
* Removed all instances of IRQ_TYPE_NONE

changes in v4:
* pull config changes to uart pins
* License in device tree files is still GPL-2.0

changes in v3:
* split the pinmux/pinconf nodes across SoC/Board files
* Fixes for issues reported with 'make dtbs W=2'
* other minor fixes based on review
 
changes in v2:
* dropped cpu-map
* dropped GIC_CPU_MASK_SIMPLE()
* Added new cpu compatible for kryo385
* added ITS node, marked as disabled

Rajendra Nayak (3):
  dt-bindings: arm: Document kryo385 cpu
  dt-bindings: qcom: Add SDM845 bindings
  arm64: dts: sdm845: Add minimal dts/dtsi files for sdm845 SoC and MTP

 Documentation/devicetree/bindings/arm/cpus.txt |   1 +
 Documentation/devicetree/bindings/arm/qcom.txt |   1 +
 arch/arm64/boot/dts/qcom/Makefile              |   1 +
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts        |  15 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi           | 276 +++++++++++++++++++++++++
 5 files changed, 294 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
