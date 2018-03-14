Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbeCNJVs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:21:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeCNJVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:21:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9AD0960592
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi S <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, jassisinghbrar@gmail.com, ohad@wizery.com,
        mark.rutland@arm.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: [PATCH v3 0/7] Add support for remoteproc modem-pil on SDM845 SoCs
Date: Wed, 14 Mar 2018 14:51:16 +0530
Message-Id: <1521019283-32212-1-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for remoteproc Q6v5 modem-pil on Qualcomm
SDM845 SoC. The second patch adds AOSS (Always on subsystem) reset driver
to provide for mss reset line. The fourth patch adds the APCS offset for
SDM845. The last couple of patches add the resets sequence for Q6 on
SDM845 and adds helper functions for arbitrary reset assert/deassert
sequences.

V3:
   Removed syscon dependency for the aoss reset driver
   Split dt-bindings and the aoss reset driver into separate patches
   Corrected few typos and replaced misconfigured author name

V2:
   Addressed reset-qcom-aoss review suggestions and reworked
   re-ordering of the active clk and reset sequence in
   qcom_q6v5_pil

Sibi S (7):
  dt-bindings: reset: Add AOSS reset bindings for SDM845 SoCs
  reset: qcom: AOSS (always on subsystem) reset controller
  dt-bindings: mailbox: Add APCS global binding for SDM845 SoCs
  mailbox: Add support for Qualcomm SDM845 SoCs
  dt-bindings: remoteproc: Add Q6v5 Modem PIL binding for SDM845
  remoteproc: qcom: Add support for mss remoteproc on SDM845
  remoteproc: qcom: Always assert and deassert reset signals in SDM845

 .../bindings/mailbox/qcom,apcs-kpss-global.txt     |   1 +
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |   1 +
 .../devicetree/bindings/reset/qcom,aoss-reset.txt  |  54 +++++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |   1 +
 drivers/remoteproc/qcom_q6v5_pil.c                 | 163 ++++++++++++++++++++-
 drivers/reset/Kconfig                              |  10 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-qcom-aoss.c                    | 156 ++++++++++++++++++++
 include/dt-bindings/reset/qcom,sdm845-aoss.h       |  17 +++
 9 files changed, 398 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
 create mode 100644 drivers/reset/reset-qcom-aoss.c
 create mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
