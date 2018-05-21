Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753373AbeEURaS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:30:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55870 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753212AbeEUR1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:27:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90B2560AF9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, jassisinghbrar@gmail.com, ohad@wizery.com,
        mark.rutland@arm.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: [PATCH v5 0/8] Add support for remoteproc modem-pil on SDM845 SoCs
Date: Mon, 21 May 2018 22:57:06 +0530
Message-Id: <20180521172714.8551-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for remoteproc Q6v5 modem-pil on Qualcomm
SDM845 SoC. The first patch adds AOSS (Always on subsystem) reset driver
to provide for mss reset line. The last couple of patches add the resets
sequence for Q6 on SDM845 and adds helper functions for arbitrary reset
assert/deassert sequences.

V5:
   corrected dt-binding and increased usleep_range for aoss reset driver
   Include the ready interrupt handling in the patch series 
   Replaced reset ops with a simpler helper function
   Re-ordered and split patches as recommended
   Inlined q6v5_request_irq function

V4:
   Removed regmap depencencies from aoss reset driver
   Separted apss shared mailbox into separate patch
   Corrected all nits and replaced with author full name

V3:
   Removed syscon dependency for the aoss reset driver
   Split dt-bindings and the aoss reset driver into separate patches
   Corrected few typos and replaced misconfigured author name

V2:
   Addressed reset-qcom-aoss review suggestions and reworked
   re-ordering of the active clk and reset sequence in
   qcom_q6v5_pil

Sibi Sankar (8):
  dt-bindings: reset: Add AOSS reset bindings for SDM845 SoCs
  reset: qcom: AOSS (always on subsystem) reset controller
  remoteproc: Move proxy unvote to handover irq handler
  remoteproc: Synchronize proxy unvote from multiple contexts
  dt-bindings: remoteproc: Add Q6v5 Modem PIL binding for SDM845
  remoteproc: qcom: Introduce reset assert/deassert helper functions
  remoteproc: qcom: Add support for mss remoteproc on SDM845
  remoteproc: qcom: Allow defining GLINK edge for mss remoteproc

 .../bindings/remoteproc/qcom,q6v5.txt         |   1 +
 .../bindings/reset/qcom,aoss-reset.txt        |  52 +++++
 drivers/remoteproc/qcom_q6v5_pil.c            | 212 ++++++++++++++++--
 drivers/reset/Kconfig                         |   9 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-qcom-aoss.c               | 133 +++++++++++
 include/dt-bindings/reset/qcom,sdm845-aoss.h  |  17 ++
 7 files changed, 404 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
 create mode 100644 drivers/reset/reset-qcom-aoss.c
 create mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
