Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC12C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04C021582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZA/t2Ubb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZSRXIJX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04C021582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbeKPGye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:54:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39210 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeKPGye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:54:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 05B52601D1; Thu, 15 Nov 2018 20:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542314711;
        bh=JQxoClD08WMLPOs8Ew54uw+/nJI3q70c37fj05WjhcA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZA/t2Ubb1h205DVo6WTj4tSvkNN7xBnT4P9Y0seHEYbj7v4WF6k/bPlirODigWiDe
         E6Iel5IHTnHrQ7Ip8/iDzY/OSZLOYGdsT7xYxl51S4cqJvhpqltxMVm8KtG+xIMnsk
         SfQGJq7xiSxEoQV0ySvdV22l1DTWt7hErb9vWzss=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9CF4A601D1;
        Thu, 15 Nov 2018 20:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542314710;
        bh=JQxoClD08WMLPOs8Ew54uw+/nJI3q70c37fj05WjhcA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZSRXIJX9FG6X5cK2s63TYHY1atWwDiof3LfnmbmlwzHBWHfHZgZVo5WAooQFzAECt
         9stOApqnfKYn//tBhtDAlEsSLR+E3V3ddKNQ2/V0LOS3Qohai3uRgLJ/VgvPkIw5ry
         g8zHpaMIwzsKjoDLq3WG6EwNnHyJL3JYvoI/VrqY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CF4A601D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2 0/3] Enable SD card slot on msm8998 MTP
Date:   Thu, 15 Nov 2018 13:44:52 -0700
Message-Id: <1542314695-24071-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A short series to enable the SD card slot on the msm8998 MTP so that there
is some storage media to play with.

[v2]
-Added Bjorn's reviewed by tags
-Fixed white space issues in patch 4
-Refactored pin declarations
-Squashed patches 3 and 4

Jeffrey Hugo (3):
  arm64: dts: qcom: msm8998: correct xo clock name
  arm64: dts: qcom: msm8998: Add SDCC2
  arm64: dts: qcom: msm8998-mtp: Add external SD

 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 65 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi     | 20 +++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

