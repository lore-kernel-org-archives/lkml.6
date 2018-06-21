Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B19C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69BB20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hCREY3jJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hCREY3jJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69BB20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeFUKxi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:53:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46850 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754018AbeFUKxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:53:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 92DD660B10; Thu, 21 Jun 2018 10:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529578412;
        bh=Cw69RMuqBGtiHQ7pEGr9+yOJE+YHS5MFEyC+mSHt8R8=;
        h=From:To:Cc:Subject:Date:From;
        b=hCREY3jJkPDTrCMsa/XGTwbKZY+5Sp2pMqQGb8Kq2RC2adIUGxKE93HAUXJbbzN3B
         Y8xX4J7HxREitYXV6R8EfYr1eCULQbGgKp1pVJY9fG0dEP2hmSx9uxYTMjuuamxqGI
         8aAj/gCZxlfU09MR1cDsZR/ACl3HsH/j/+7Jhm28=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A7D160227;
        Thu, 21 Jun 2018 10:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529578412;
        bh=Cw69RMuqBGtiHQ7pEGr9+yOJE+YHS5MFEyC+mSHt8R8=;
        h=From:To:Cc:Subject:Date:From;
        b=hCREY3jJkPDTrCMsa/XGTwbKZY+5Sp2pMqQGb8Kq2RC2adIUGxKE93HAUXJbbzN3B
         Y8xX4J7HxREitYXV6R8EfYr1eCULQbGgKp1pVJY9fG0dEP2hmSx9uxYTMjuuamxqGI
         8aAj/gCZxlfU09MR1cDsZR/ACl3HsH/j/+7Jhm28=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A7D160227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v2 0/2] Add support for audio on SDM845 SoC
Date:   Thu, 21 Jun 2018 16:23:17 +0530
Message-Id: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides initial patchset to support audio on
Qualcomm Techonologies Inc. SDM845 SoC. Currently, it supports
audio playback/capture over Primary MI2S and Quaternary
TDM ports.
Changes since v1:
Addressed comments posted by Vinod and Srinivas.

Rohit kumar (2):
  ASoC: qcom: dt-bindings: Add sdm845 machine bindings
  ASoC: qcom: add sdm845 sound card support

 .../devicetree/bindings/sound/qcom,sdm845.txt      |  82 ++++
 sound/soc/qcom/Kconfig                             |   9 +
 sound/soc/qcom/Makefile                            |   2 +
 sound/soc/qcom/sdm845.c                            | 514 +++++++++++++++++++++
 4 files changed, 607 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
 create mode 100644 sound/soc/qcom/sdm845.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

