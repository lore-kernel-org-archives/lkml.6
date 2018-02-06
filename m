Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeBFSJd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:09:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39570 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752481AbeBFSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:09:27 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D3CA60272
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 0/2] irqchip: qcom: add support for PDC interrupt controller
Date: Tue,  6 Feb 2018 11:09:03 -0700
Message-Id: <20180206180905.29047-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since RFC v2:
- Fixed up DT probe based on suggestions from Thomas and Marc
- Code clean up as suggested by Thomas
- Switch to SPDX license marker
- Dropped the FTRACE patch for now, will need more thought and discussions

On newer Qualcomm Techonologies Inc's SoCs like the SDM845, the GIC is in a
power domain that can be powered off when not needed. Interrupts that need to
be sensed even when the GIC is powered off, are routed through an interrupt
controller in an always-on domain called the Power Domain Controller a.k.a PDC.
This series adds support for the PDC's interrupt controller.

Please consider reviewing these patches.

RFC v1: https://patchwork.kernel.org/patch/10180857/
RFC v2: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1600634.html

Lina Iyer (2):
  drivers: irqchip: pdc: Add PDC interrupt controller for QCOM SoCs
  dt-bindings/interrupt-controller: pdc: descibe PDC device binding

 .../bindings/interrupt-controller/qcom,pdc.txt     |  80 ++++++
 drivers/irqchip/Kconfig                            |   9 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/qcom-pdc.c                         | 302 +++++++++++++++++++++
 4 files changed, 392 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
 create mode 100644 drivers/irqchip/qcom-pdc.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
