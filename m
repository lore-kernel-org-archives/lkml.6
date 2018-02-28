Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933668AbeB1R1s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:27:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36988 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932503AbeB1R1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:27:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5AEF60240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v8 0/2] irqchip: qcom: add support for PDC interrupt controller
Date: Wed, 28 Feb 2018 10:27:28 -0700
Message-Id: <20180228172730.25022-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v7:
	- fix whitespace alignment for multi-line statement
	- add Rob H 'reviewed-by' for DT bindings
	- rebase on top of 4.6-rc3

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
v5: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1605500.html
v6: https://lkml.org/lkml/2018/2/9/545
v7: https://www.spinics.net/lists/kernel/msg2723942.html

Lina Iyer (2):
  drivers: irqchip: pdc: Add PDC interrupt controller for QCOM SoCs
  dt-bindings/interrupt-controller: pdc: describe PDC device binding

 .../bindings/interrupt-controller/qcom,pdc.txt     |  78 ++++++
 drivers/irqchip/Kconfig                            |   9 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/qcom-pdc.c                         | 311 +++++++++++++++++++++
 4 files changed, 399 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
 create mode 100644 drivers/irqchip/qcom-pdc.c

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
