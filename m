Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeC0Sxn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 14:53:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43116 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeC0Sxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 14:53:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A306360251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From: Rishabh Bhatnagar <rishabhb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc: linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, kyan@codeaurora.org, ckadabi@codeaurora.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v3 0/2] SDM845 System Cache Driver
Date: Tue, 27 Mar 2018 11:52:00 -0700
Message-Id: <1522176722-12691-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements system cache or LLCC(Last Level Cache Controller) driver
for SDM845 SOC. The purpose of the driver is to partition the system cache and
program the settings such as priortiy, lines to probe while doing a look up
in the system cache, low power related settings etc. The partitions are called
cache slices. Each cache slice is associated with size and SCID(System Cache ID)
The driver also provides API for clients to query the cache slice details,
activate and deactivate them.

The driver can be broadly classified into:
* SOC specific driver: llcc-sdm845.c: Cache partitioning and cache slice
properties for usecases on sdm845 that need to use system cache.

* API : llcc-slice.c: Exports APIs to clients to query cache slice details,
activate and deactivate cache slices.

Changes since v2:
* Corrected the Makefile to fix compilation.

Changes since v1:
* Added Makefile and Kconfig.

Changes since v0:
* Removed the syscon and simple-mfd approach
* Updated the device tree nodes to mention LLCC as a single HW block
* Moved llcc bank offsets from device tree and handled the offset
  in the driver.

ckadabi@codeaurora.org (2):
  Documentation: Documentation for qcom, llcc
  drivers: soc: Add LLCC driver

 .../devicetree/bindings/arm/msm/qcom,llcc.txt      |  70 ++++
 drivers/soc/qcom/Kconfig                           |  16 +
 drivers/soc/qcom/Makefile                          |   2 +
 drivers/soc/qcom/llcc-sdm845.c                     | 120 ++++++
 drivers/soc/qcom/llcc-slice.c                      | 454 +++++++++++++++++++++
 include/linux/soc/qcom/llcc-qcom.h                 | 178 ++++++++
 6 files changed, 840 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
 create mode 100644 drivers/soc/qcom/llcc-sdm845.c
 create mode 100644 drivers/soc/qcom/llcc-slice.c
 create mode 100644 include/linux/soc/qcom/llcc-qcom.h

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
