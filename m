Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753129AbeBPGFc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 01:05:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49460 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeBPGFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 01:05:30 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 827DE60558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: andy.gross@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@codeaurora.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        dianders@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v4 0/4] Add DTS for SDM845 SoC and MTP
Date: Fri, 16 Feb 2018 11:34:59 +0530
Message-Id: <20180216060503.22006-1-rnayak@codeaurora.org>
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
serial: https://patchwork.ozlabs.org/cover/860251/ (under review)

'PATCH 3/3' is based on v2 of serial patches, will need an update if
v3 (still in the works) has further binding updates

Since 'PATCH 2/3' also adds an ITS node and keeps it disabled, we also depend
on https://lkml.org/lkml/2018/1/29/383

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

Rajendra Nayak (4):
  dt-bindings: arm: Document kryo385 cpu
  dt-bindings: qcom: Add SDM845 bindings
  arm64: dts: sdm845: Add minimal dts/dtsi files for sdm845 SoC and MTP
  arm64: dts: sdm845: Add serial console support

 Documentation/devicetree/bindings/arm/cpus.txt |   1 +
 Documentation/devicetree/bindings/arm/qcom.txt |   1 +
 arch/arm64/boot/dts/qcom/Makefile              |   1 +
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts        |  54 +++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi           | 316 +++++++++++++++++++++++++
 5 files changed, 373 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
