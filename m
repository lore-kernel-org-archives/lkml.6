Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753993AbeEAKj2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:39:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeEAKj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:39:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2ADE56028D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
From: Vijay Viswanath <vviswana@codeaurora.org>
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com,
        vviswana@codeaurora.org, bjorn.andersson@linaro.org,
        riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com,
        sayalil@codeaurora.org
Subject: [PATCH RFC 0/4] Changes for SDCC5 version
Date: Tue,  1 May 2018 16:09:09 +0530
Message-Id: <1525171153-24476-1-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With SDCC5, the MCI register space got removed and the offset/order of
several registers have changed. Based on SDCC version used and the register,
we need to pick the base address and offset.
Also power irq is a signal from controller to SW that it is ready for
voltage switch. So added support to register voltage regulators in the
msm driver and use them. With this core layer will not have to take care of
voltage regulators. Chips which are currently using core layer regulator APIs
can continue to do so, while newer chips can utilize power irq for voltage
switch.

Depends on patch series:
	[PATCH V5 0/2] mmc: sdhci-msm: Configuring IO_PAD support for sdhci-msm
	https://lkml.org/lkml/2018/4/20/370

Asutosh Das (1):
  mmc: sdhci-msm: Add and use voltage regulator related APIs

Sahitya Tummala (2):
  host: sdhci: fix current caps when there is no host->vmmc
  host: sdhci-msm: implement get_current_limit() host op

Sayali Lokhande (1):
  mmc: host: Register changes for sdcc V5

 .../devicetree/bindings/mmc/sdhci-msm.txt          |   32 +-
 drivers/mmc/host/sdhci-msm.c                       | 1027 +++++++++++++++++---
 drivers/mmc/host/sdhci.c                           |   11 +-
 drivers/mmc/host/sdhci.h                           |    1 +
 4 files changed, 912 insertions(+), 159 deletions(-)

-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
