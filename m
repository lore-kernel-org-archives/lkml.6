Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E890FC676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E9D20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XBH9qz6e";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rt7utp2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E9D20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeJHUe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:34:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37734 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJHUe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:34:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2FC3C60B73; Mon,  8 Oct 2018 13:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539004995;
        bh=9QoLyaqL0263UtVdZWIiRSij6yhxyUzMjXcwUm6zQKs=;
        h=From:To:Cc:Subject:Date:From;
        b=XBH9qz6e16sK9CeVuOqqlu0+mHtYsEQ1B/stJQCG5/7XyJagdGu45VP7r2g4/nnNX
         a2wzlnrLRp6Cyc1eaqTriIApOECU7NGI3WSq8gax0Td54OhrI/RcpTvrRay7hjZiPa
         LzIZDJQWgPUdeXw4cvHhIfb3Fb4liiw5mKeVIgIA=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36C1C60769;
        Mon,  8 Oct 2018 13:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539004994;
        bh=9QoLyaqL0263UtVdZWIiRSij6yhxyUzMjXcwUm6zQKs=;
        h=From:To:Cc:Subject:Date:From;
        b=Rt7utp2h2sCre3kEns+XYJNDF5WLNQ+1cZVC9zZV8dOekiee8+bwZvlqtj4Vj1L74
         1USerT3TLc77Cu7OOGOlgMQZA8jIIPjy4PHDbKz/EVjSrEJYansYkzb4+TbQN4RzJD
         EEfsyfJLA8BdpHQ605OpN0TFDpvb+E7uMQogXvx8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36C1C60769
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vgarodia@codeaurora.org
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: [PATCH v10 0/5] Venus updates - PIL 
Date:   Mon,  8 Oct 2018 18:52:57 +0530
Message-Id: <1539004982-32555-1-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version of the series
* extends the description of firmware subnode in documentation.
* renames the flag suggesting the presence of tz and update code
  accordingly.

Stanimir Varbanov (1):
  venus: firmware: register separate platform_device for firmware loader

Vikash Garodia (4):
  venus: firmware: add routine to reset ARM9
  venus: firmware: move load firmware in a separate function
  venus: firmware: add no TZ boot and shutdown routine
  dt-bindings: media: Document bindings for venus firmware device

 .../devicetree/bindings/media/qcom,venus.txt       |  13 +-
 drivers/media/platform/qcom/venus/core.c           |  24 ++-
 drivers/media/platform/qcom/venus/core.h           |   6 +
 drivers/media/platform/qcom/venus/firmware.c       | 235 +++++++++++++++++++--
 drivers/media/platform/qcom/venus/firmware.h       |  17 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
 drivers/media/platform/qcom/venus/hfi_venus_io.h   |   8 +
 7 files changed, 273 insertions(+), 43 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

