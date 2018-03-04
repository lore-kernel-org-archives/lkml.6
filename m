Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeCDMb5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 07:31:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56480 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeCDMbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 07:31:55 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE94D601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: Ilia Lin <ilialin@codeaurora.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
        mark.rutland@arm.com
Cc: ilialin@codeaurora.org, amit.kucheria@linaro.org,
        nicolas.dechesne@linaro.org, celster@codeaurora.org,
        tfinkel@codeaurora.org
Subject: [PATCH 0/2] Add SAW support to QCOM SPMI driver
Date: Sun,  4 Mar 2018 14:31:47 +0200
Message-Id: <1520166709-554-1-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SAW is the “Subsystem Power Manager (SPM),
Adaptive Voltage Scaling (AVS)
and Dynamic Current Management (DCM) Wrapper”,
that is, a core that contains logic to implement the SPM, AVS,
and DCM functions. The SAW manages power controls for a client core
such as a CPU.

The PMIC regulators supplying power to the CPU cores should not
be controlled by the SPMI accesses directly, but through the SAW
interface.

The patch series adds SAW support to the SPMI regulator driver.
The special SAW controlled regulators should be configured by
device tree handle. The SPI driver will handle those regulators
separately through the SAW interface, instead of SPMI.

Ilia Lin (2):
  regulator: qcom_spmi: Add support for SAW
  dt-bindings: Add support for SAW documentation

 .../bindings/regulator/qcom,spmi-regulator.txt     |  45 +++++++
 drivers/regulator/qcom_spmi-regulator.c            | 133 ++++++++++++++++++++-
 2 files changed, 175 insertions(+), 3 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
