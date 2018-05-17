Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeEQK3U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:29:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50816 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbeEQK3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:29:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5D7960131
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
From: Vijay Viswanath <vviswana@codeaurora.org>
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com, vviswana@codeaurora.org,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
Subject: [PATCH V1 0/3] Changes for SDCC5 version
Date: Thu, 17 May 2018 15:58:55 +0530
Message-Id: <1526552938-21292-1-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With SDCC5, the MCI register space got removed and the offset/order of
several registers have changed. Based on SDCC version used and the register,
we need to pick the base address and offset.

Changes since RFC:
	Dropped voltage regulator changes in sdhci-msm
	Split the "Register changes for sdcc V5" patch
	Instead of checking mci removal for deciding which base addr to use,
	new function pointers are defined for the 2 variants of sdcc: 
		1) MCI present
		2) V5 (mci removed)
	Instead of string comparing with the compatible string from DT file,
	the sdhci_msm_probe will now pick the data associated with the
	compatible entry and use it to load variant specific address offsets
	and msm variant specific read/write ops. 

Sayali Lokhande (2):
  mmc: sdhci-msm: Define new Register address map
  mmc: host: Register changes for sdcc V5

Vijay Viswanath (1):
  mmc: sdhci-msm: Add msm version specific ops and data structures

 .../devicetree/bindings/mmc/sdhci-msm.txt          |   5 +-
 drivers/mmc/host/sdhci-msm.c                       | 545 ++++++++++++++++-----
 2 files changed, 423 insertions(+), 127 deletions(-)

-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
