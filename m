Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeBBOW0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:22:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58878 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeBBOWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:22:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB07F606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sboyd@codeaurora.org, rnayak@codeaurora.org, asathyak@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RFC v2 0/3] irqchip: qcom: add support for PDC interrupt controller
Date: Fri,  2 Feb 2018 07:21:57 -0700
Message-Id: <20180202142200.6229-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changes in v2:
- Drviers will specify PDC pin as their interrupt and PDC as interrupt parent
- Updated driver to pick up PDC pin mappings from DT
- Cleanup driver per Marc's suggestions
- Addressed DT bindings comments from Rob H
- Addressed FTRACE comments from Steven R

On newer Qualcomm Techonologies Inc's SoCs like the SDM845, the GIC is in a
power domain that can be powered off when not needed. Interrupts that need to
be sensed even when the GIC is powered off, are routed through an interrupt
controller in an always-on domain called the Power Domain Controller a.k.a PDC.
This series adds support for the PDC's interrupt controller.

Please consider reviewing these patches.

RFC v1: https://patchwork.kernel.org/patch/10180857/

Lina Iyer (3):
  drivers: irqchip: pdc: Add PDC interrupt controller for QCOM SoCs
  dt-bindings/interrupt-controller: pdc: descibe PDC device binding
  drivers: irqchip: pdc: log PDC info in FTRACE

 .../bindings/interrupt-controller/qcom,pdc.txt     |  78 +++++
 drivers/irqchip/Kconfig                            |   9 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/qcom-pdc.c                         | 333 +++++++++++++++++++++
 include/trace/events/pdc.h                         |  55 ++++
 5 files changed, 476 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
 create mode 100644 drivers/irqchip/qcom-pdc.c
 create mode 100644 include/trace/events/pdc.h

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
