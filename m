Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeBHVUi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 16:20:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50536 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeBHVUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 16:20:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD93E60558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v5 0/2] irqchip: qcom: add support for PDC interrupt controller
Date: Thu,  8 Feb 2018 14:20:29 -0700
Message-Id: <20180208212031.20192-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4:
- Code clean up as suggested by Marc

On newer Qualcomm Techonologies Inc's SoCs like the SDM845, the GIC is in a
power domain that can be powered off when not needed. Interrupts that need to
be sensed even when the GIC is powered off, are routed through an interrupt
controller in an always-on domain called the Power Domain Controller a.k.a PDC.
This series adds support for the PDC's interrupt controller.

Please consider reviewing these patches.

RFC v1: https://patchwork.kernel.org/patch/10180857/
RFC v2: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1600634.html
v3: https://lkml.org/lkml/2018/2/6/595
v4: https://www.spinics.net/lists/linux-arm-msm/msg32906.html

Lina Iyer (2):
  drivers: irqchip: pdc: Add PDC interrupt controller for QCOM SoCs
  dt-bindings/interrupt-controller: pdc: descibe PDC device binding

 .../bindings/interrupt-controller/qcom,pdc.txt     |  78 ++++++
 drivers/irqchip/Kconfig                            |   9 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/qcom-pdc.c                         | 312 +++++++++++++++++++++
 4 files changed, 400 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
 create mode 100644 drivers/irqchip/qcom-pdc.c

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
