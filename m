Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F16C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D573208AC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nGBrEHuL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HAnXZ4u/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D573208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388897AbeHAKqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:46:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57716 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388250AbeHAKqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:46:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3849060275; Wed,  1 Aug 2018 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533114081;
        bh=QBRaWo7Vz62WuwUvTaB0LAFutD/xhWxVV/uKLBQidsY=;
        h=From:To:Cc:Subject:Date:From;
        b=nGBrEHuLpbJIijP6Y0hrIWVtRdCtDhViQg3ZABh3Pm5uasQYSE2Wm/H/+jtf1Aods
         XdfS9l3tcuVEgIztDDi826nB06/QtR2tJxpUaWlv4ChWa9Gr8aCkQBma5SWk2QrL5b
         GvC59QcGZSlLU4ZyvRiJLseXjp036mWLa57UB2Zc=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1B506035F;
        Wed,  1 Aug 2018 09:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533114080;
        bh=QBRaWo7Vz62WuwUvTaB0LAFutD/xhWxVV/uKLBQidsY=;
        h=From:To:Cc:Subject:Date:From;
        b=HAnXZ4u/Q7q2LPEDSrb9hV8edLV0j4m/MF85kvMDs3zxca7kNRftjHHGz1BBL34Zb
         kiCGCPLO5fvCmXQnQtyDNo04cbyaTklLZjvhtN1ZfISGvcNRfPoyHBEuHMWsMzcg+r
         VVVJROrtCe7GvIdB33gwaN7EGcFI3h1NS0C3poEo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1B506035F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v5 0/4] Add support for audio on SDM845 SoC
Date:   Wed,  1 Aug 2018 14:31:05 +0530
Message-Id: <1533114069-16570-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides initial patchset to support audio on
Qualcomm Techonologies Inc. SDM845 SoC. Currently, it supports
audio playback/capture over Primary MI2S and Quaternary
TDM ports.

Changes since v4:
- Used snd_mask_set_format() instead of snd_mask_set() to avoid sparse warning.

Rohit kumar (4):
  ASoC: qcom: dt-bindings: Add sdm845 machine bindings
  ASoC: dt-bindings: Update dt binding name for apq8096
  ASoC: qcom: Add support to parse common audio device nodes
  ASoC: qcom: add sdm845 sound card support

 .../devicetree/bindings/sound/qcom,apq8096.txt     |  15 +-
 .../devicetree/bindings/sound/qcom,sdm845.txt      |  80 ++++++
 sound/soc/qcom/Kconfig                             |   8 +
 sound/soc/qcom/Makefile                            |   4 +-
 sound/soc/qcom/apq8096.c                           | 111 +-------
 sound/soc/qcom/common.c                            | 112 ++++++++
 sound/soc/qcom/common.h                            |  12 +
 sound/soc/qcom/sdm845.c                            | 286 +++++++++++++++++++++
 8 files changed, 525 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
 create mode 100644 sound/soc/qcom/common.c
 create mode 100644 sound/soc/qcom/common.h
 create mode 100644 sound/soc/qcom/sdm845.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

