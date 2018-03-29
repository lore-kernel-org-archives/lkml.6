Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbeC2LFx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:05:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43040 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeC2LFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:05:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C82C60C66
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@ti.com>, robh@kernel.org,
        sboyd@codeaurora.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, vivek.gautam@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v4 0/7] phy: qcom: Updates for USB PHYs on SDM845
Date: Thu, 29 Mar 2018 16:34:19 +0530
Message-Id: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 has two USB instances each with QUSB2 and QMP PHYs.
One of the QMP PHY is USB-DP (DisplayPort) combo PHY where
as other one is single lane UNI-PHY (without DP support).
Changes are related to PHY configuration for electrical
parameters tuning to improve eye-diagram and some fixes.

Changes since v3:
 - As per Doug's review comments added device tree parameters
   to handle board level differences in PHY tuning values instead
   of adding separate device tree bindings.
 - Replace PHY version specific bindings names with SOC name as
   no one is going to use generic binding names.
 - Update halt_check to not check for pipe clock status that
   allows to simplify pipe_clk handling in QMP driver.

Changes since v2:
 - Use separate phy_ops for USB to not register power_on op.
 - And other minor changes as per review comments from Stephen.

Changes since v1:
 - Updated qusb2 compatibility name as per comment from Vivek.

Manu Gautam (7):
  clk: msm8996-gcc: change halt check for USB/PCIE pipe_clk
  phy: qcom-qmp: Enable pipe_clk before PHY initialization
  phy: qcom-qusb2: Fix crash if nvmem cell not specified
  dt-bindings: phy-qcom-qmp: Update bindings for sdm845
  phy: qcom-qmp: Add QMP V3 USB3 UNI PHY support for sdm845
  dt-bindings: phy-qcom-usb2: Add support to override tuning values
  phy: qcom-qusb2: Add QUSB2 PHYs support for sdm845

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   3 +-
 .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |  19 ++-
 drivers/clk/qcom/gcc-msm8996.c                     |   4 +
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 169 +++++++++++++++++++--
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   5 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              | 116 +++++++++++++-
 6 files changed, 298 insertions(+), 18 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
