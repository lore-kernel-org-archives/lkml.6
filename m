Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753951AbeAaQVk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:21:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33864 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753356AbeAaQVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:21:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 087B1601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: andy.gross@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        sboyd@codeaurora.org, evgreen@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 0/3] Add DTS for SDM845 SoC and MTP
Date: Wed, 31 Jan 2018 21:49:38 +0530
Message-Id: <20180131161941.29865-1-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have serial[1], pinctrl[2] and clock[3]
drivers for SDM845 SoC out on the lists, heres the
basic dts files needed to boot a SDM845 based MTP
board to a ramfs based serial console shell.

[1] https://patchwork.ozlabs.org/cover/860251/
[2] https://patchwork.kernel.org/patch/10157143/
[3] https://lkml.org/lkml/2018/1/22/78

changes in v2:
* dropped cpu-map
* dropped GIC_CPU_MASK_SIMPLE()
* Added new cpu compatible for kryo385
* added ITS node, marked as disabled
* other cosmetic fixes 

Rajendra Nayak (3):
  Documentation: dt-bindings: arm: Document kryo385 cpu
  arm64: dts: sdm845: Add minimal dts/dtsi files for sdm845 SoC and MTP
  arm64: dts: sdm845: Add serial console support

 Documentation/devicetree/bindings/arm/cpus.txt |   1 +
 arch/arm64/boot/dts/qcom/Makefile              |   1 +
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts        |  55 +++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi           | 298 +++++++++++++++++++++++++
 4 files changed, 355 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
