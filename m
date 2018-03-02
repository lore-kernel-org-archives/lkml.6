Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425606AbeCBJYW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:24:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48932 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424768AbeCBJYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:24:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6BAF604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: sibis <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, jassisinghbrar@gmail.com,
        p.zabel@pengutronix.de, ohad@wizery.com, mark.rutland@arm.com,
        robh+dt@kernel.org, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/6] Add support for remoteproc modem-pil on SDM845 SoCs  
Date: Fri,  2 Mar 2018 14:53:33 +0530
Message-Id: <1519982619-28336-1-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for remoteproc Q6v5 modem-pil on Qualcomm
SDM845 SoC. The first patch adds AOSS (Always on subsystem) reset driver
to provide for mss reset line. The third patch adds the APCS offset for
SDM845. The last couple of patches add the resets sequence for Q6 on
SDM845 and adds helper functions for arbitrary reset assert/deassert
sequences.

sibis (6):
  reset: qcom: AOSS (Always on subsystem) reset controller
  dt-bindings: mailbox: Add APCS global binding for SDM845 SoCs
  mailbox: Add support for Qualcomm SDM845 SoCs
  dt-bindings: remoteproc: Add Q6v5 Modem PIL binding for SDM845
  remoteproc: qcom: Add support for mss remoteproc on SDM845
  remoteproc: qcom: Reorder active clks enable and reset

 .../bindings/mailbox/qcom,apcs-kpss-global.txt     |   3 +-
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |   5 +-
 .../devicetree/bindings/reset/qcom,aoss-reset.txt  |  54 +++++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |   1 +
 drivers/remoteproc/qcom_q6v5_pil.c                 | 149 +++++++++++++++++--
 drivers/reset/Kconfig                              |  10 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-qcom-aoss.c                    | 161 +++++++++++++++++++++
 include/dt-bindings/reset/qcom,aoss-sdm845.h       |  17 +++
 9 files changed, 386 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
 create mode 100644 drivers/reset/reset-qcom-aoss.c
 create mode 100644 include/dt-bindings/reset/qcom,aoss-sdm845.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
