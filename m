Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5829C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870DF20B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oUTSfuBP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cTbIdPrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfBAAxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:53:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49512 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfBAAxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:53:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 168BC608FF; Fri,  1 Feb 2019 00:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548982409;
        bh=pwEG+1C3uTQU0fDiavHvzWQydrSqNc7kF+Uc6gYs9Vg=;
        h=From:To:Cc:Subject:Date:From;
        b=oUTSfuBPKgqzQ4xgW1hnHODqoyk/jTMIUllnRsh+/wGayJrmrXfnzASh44Qu787U2
         /KzuZAIoXQVBOnGbufSiL27x7+7zmZdLCmDZnDKX4AzeMUYOAKX40EE4LoiUd3NGlj
         fcsPIHomGQBIi3AsDBFbYHyLfDQu6N18u/xz7ESY=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C8C960590;
        Fri,  1 Feb 2019 00:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548982407;
        bh=pwEG+1C3uTQU0fDiavHvzWQydrSqNc7kF+Uc6gYs9Vg=;
        h=From:To:Cc:Subject:Date:From;
        b=cTbIdPrD9ABjcPnpRTF8RZlj30nY0A0LHREF64w0VtNU0Y6ikyz8UjmzlXuDlVZGW
         jN1UqnEHwae+PlhV9gN84SQQDu0GJhLvuxFFpMH4+4tGO6eGFhTU2LFbMMormZ305C
         dMwbecW1zPeQqXMdGwRARx+TsS6uZPCYWDeQSILo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C8C960590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv7 0/6] Add coresight support for SDM845, MSM8998 and MSM8996
Date:   Fri,  1 Feb 2019 06:23:08 +0530
Message-Id: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for coresight on SDM845, MSM8998, and MSM8996.

* Patch 1 adds device tree nodes for SDM845 coresight components.

* Patch 2 adds device tree nodes for MSM8998 coresight components.

* Patch 3 adds device tree nodes for MSM8996 coresight components.

* Patch 4 enables support for ETMv4.2 and enables SDM845 to make
  use of same driver(etm4x).

* Patch 5 adds ETM PIDs for SDM845 and MSM8996.

* Patch 6 adds coresight CPU debug module for Qualcomm Kryo.

NOTE: All the dependent patches are applied in the below tree,
      the first 12 commits represent the dependent patches.
 * https://github.com/saiprakash-ranjan/linux/tree/coresight-next

Patch 1 and 4 depends on below AOSS QMP, AMBA bus pclk and address cell change:
 * https://lore.kernel.org/lkml/20190131003933.11436-5-bjorn.andersson@linaro.org/
 * https://lore.kernel.org/lkml/20190131003933.11436-6-bjorn.andersson@linaro.org/
 * https://lore.kernel.org/lkml/20190131003933.11436-7-bjorn.andersson@linaro.org/
 * https://lore.kernel.org/lkml/20190131003933.11436-10-bjorn.andersson@linaro.org/
 * https://lore.kernel.org/lkml/20190131020141.28352-1-bjorn.andersson@linaro.org/
 * https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/

Patch 2 depends on MSM8998 rpm clocks and rpmcc nodes:
 * https://lore.kernel.org/lkml/1545099336-5615-1-git-send-email-jhugo@codeaurora.org/
 * https://lore.kernel.org/lkml/1548866144-30265-1-git-send-email-jhugo@codeaurora.org/
 * https://lore.kernel.org/lkml/6da00186-e7c9-c93d-a80a-65eda2516451@free.fr/

Patch 5 and 6 depends on UCI support by Mike Leach:
 * https://lore.kernel.org/lkml/20190130234051.2294-1-mike.leach@linaro.org/ 

This patch series has been tested on SDM845 MTP and MSM8996
based Dragonboard 820c and MSM8998 MTP.

v7:
 * Change uci_id_debug struct to const.
 * Update the subject as suggested by Suzuki.

v6:
 * Update the UCI table with the new macro introduced by
   Mike.
 * Rebase on top of coresight-next and provide a tree with
   all the dependent patches applied.

v5:
 * Added coresight support for MSM8998.
 * Added ETM PIDs for SDM845 and MSM8996 as suggested
   by Suzuki.
 * Added UCI table for Coresight CPU debug module.

v4:
 * Mask out the minor version as suggested by Mathieu.
 * Added the dependent patch description in patch 1.

v3:
 * Added arm,scatter-gather property as suggested by Suzuki.

v2:
 * Added coresight support for msm8996 based on Vivek's patch.
   Cleaned up and added coresight cpu debug nodes for msm8996.
 * Merged coresight dtsi file into sdm845.dtsi as suggested by Bjorn
 * Addressed Mathieu's feedback about masking the minor version in
   etm4_arch_supported() and added a comment for reason to bypass
   the AMBA bus discovery method.

Sai Prakash Ranjan (5):
  arm64: dts: qcom: sdm845: Add Coresight support
  arm64: dts: qcom: msm8998: Add Coresight support
  coresight: etm4x: Add support to enable ETMv4.2
  coresight: etm4x: Add ETM PIDs for SDM845 and MSM8996
  coresight: cpu-debug: Add support for Qualcomm Kryo

Vivek Gautam (1):
  arm64: dts: qcom: msm8996: Add Coresight support

 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 434 +++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi         | 435 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 434 +++++++++++++++++
 .../hwtracing/coresight/coresight-cpu-debug.c |  33 +-
 drivers/hwtracing/coresight/coresight-etm4x.c |  17 +-
 5 files changed, 1330 insertions(+), 23 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

