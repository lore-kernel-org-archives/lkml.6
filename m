Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACECC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AF1206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ouUaxjDs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ouUaxjDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AF1206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeHWR7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:59:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46350 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeHWR7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:59:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A0C396053B; Thu, 23 Aug 2018 14:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535034544;
        bh=lZ/B34o+zOSus4EuP5wNnbJ43Vm8KILZB7dDCPR7WgA=;
        h=From:To:Cc:Subject:Date:From;
        b=ouUaxjDsW1vkxthZQXg01JG8AgERQc+IrML1RTKrV+wm4V+RNerXl498fx9fWn7nx
         U1SJY1dNNlphQES4/+3QvY/e1kLUQZbPxsSO7rIcPkgZR9DrE0nmd5z4yVlij8+HkZ
         G5XTcdeRXITVTe6zppTvfFP+zN4a/B01aXrZP/FE=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 820E160214;
        Thu, 23 Aug 2018 14:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535034544;
        bh=lZ/B34o+zOSus4EuP5wNnbJ43Vm8KILZB7dDCPR7WgA=;
        h=From:To:Cc:Subject:Date:From;
        b=ouUaxjDsW1vkxthZQXg01JG8AgERQc+IrML1RTKrV+wm4V+RNerXl498fx9fWn7nx
         U1SJY1dNNlphQES4/+3QvY/e1kLUQZbPxsSO7rIcPkgZR9DrE0nmd5z4yVlij8+HkZ
         G5XTcdeRXITVTe6zppTvfFP+zN4a/B01aXrZP/FE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 820E160214
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vgarodia@codeaurora.org
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: [PATCH v6 0/4] Venus updates - PIL
Date:   Thu, 23 Aug 2018 19:58:44 +0530
Message-Id: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v6 with following comments addressed:

* 4/4 from earlier series was dropped as .probe was not needed.
* indentation as per checkpatch --strict option.
* tested on Venus v4 hardware. 

Stanimir Varbanov (1):
  venus: firmware: register separate platform_device for firmware loader

Vikash Garodia (3):
  venus: firmware: add routine to reset ARM9
  venus: firmware: move load firmware in a separate function
  venus: firmware: add no TZ boot and shutdown routine

 .../devicetree/bindings/media/qcom,venus.txt       |  13 +-
 drivers/media/platform/qcom/venus/core.c           |  24 ++-
 drivers/media/platform/qcom/venus/core.h           |   9 +
 drivers/media/platform/qcom/venus/firmware.c       | 223 +++++++++++++++++++--
 drivers/media/platform/qcom/venus/firmware.h       |  17 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
 drivers/media/platform/qcom/venus/hfi_venus_io.h   |   8 +
 7 files changed, 265 insertions(+), 42 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

