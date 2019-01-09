Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119C2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D782520656
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MLC1Ijw3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NIaJPO57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfAIRrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:47:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58684 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfAIRrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:47:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2EF7A608CD; Wed,  9 Jan 2019 17:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547056050;
        bh=0gyYLuNtvHYhM3xrhaPPKd29npznhL5tuk39VI27em0=;
        h=From:To:Cc:Subject:Date:From;
        b=MLC1Ijw3LT0hVJUYkGRTD2Z0CAq2nhSfU8KySc5Kbd7DqSW1zOn50qL3P7VkX4zdN
         Us2XWYZcbNY/K8ay6UFnNAOm4v+dkbNUIJujAbeOxVpX6YOzA/MBmc+OoTWAYY4e1M
         LvUhCDLw+sbMrFZ2/C/gt/GjByc6tAOEBZirmif4=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E09C6050D;
        Wed,  9 Jan 2019 17:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547056047;
        bh=0gyYLuNtvHYhM3xrhaPPKd29npznhL5tuk39VI27em0=;
        h=From:To:Cc:Subject:Date:From;
        b=NIaJPO57LZljsVWqPPR08VplgWmrs2A0n+aCxaRhZpt6ETr2QvSTK6ymIHZreaJyW
         mYPNBRHGrqJ9Jd5IPuAPPjCUzrr2fnE5pxoKZHKNB+NGsrpXrV3hSr4BDqFD+tTvrR
         m5SunLbhvTRBDvVJVMKfbOSdoUBki8hT6csjHcMA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E09C6050D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 0/3] Add coresight support for SDM845
Date:   Wed,  9 Jan 2019 23:16:46 +0530
Message-Id: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for coresight on SDM845. 

* Patch 1 adds device tree nodes for SDM845 coresight components.

* Patch 2 enables support for ETMv4.2 and enables SDM845 to make
  use of same driver(etm4x).

* Patch 3 is a trivial removal of duplicate header file.

Patch 1 and 2 depends on below AOSS QMP patches by Bjorn:
 https://patchwork.kernel.org/patch/10749469/ 
 https://patchwork.kernel.org/patch/10749481/
 https://patchwork.kernel.org/patch/10749479/
 https://patchwork.kernel.org/patch/10749475/ 

This patch series has been tested on SDM845 MTP.

Sai Prakash Ranjan (3):
  arm64: dts: qcom: sdm845: Add Coresight support
  coresight: etm4x: Add support to enable ETMv4.2
  arm64: dts: qcom: sdm845: Remove the duplicate header inclusion

 .../arm64/boot/dts/qcom/sdm845-coresight.dtsi | 437 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   3 +-
 drivers/hwtracing/coresight/coresight-etm4x.c |   2 +-
 drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
 4 files changed, 441 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-coresight.dtsi

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

