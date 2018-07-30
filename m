Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42E1FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E4120881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K5nRKG/F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K5nRKG/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E4120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeG3LpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:45:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42110 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeG3LpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:45:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A78B66199F; Mon, 30 Jul 2018 10:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532945467;
        bh=wrFPLzVjBNomtZE6b0hVxKUEA0uro63yh4EvIiDFdNw=;
        h=From:To:Cc:Subject:Date:From;
        b=K5nRKG/Fyh9mDDAWkxBhc9J5mzNSl+bvwFmhoJa/IU3U6APAa9F+ik84KB9jgbvys
         FXIQ2zhX5F3BR6usHR9NEmStnALFHGCjNJHnirZUAFOOO78GT3PCMxdgN2VAJo18F8
         wV9mL10siWL6zJzWYHPjqZ92BqxQJI0f7twKAr9k=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5779602A7;
        Mon, 30 Jul 2018 10:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532945467;
        bh=wrFPLzVjBNomtZE6b0hVxKUEA0uro63yh4EvIiDFdNw=;
        h=From:To:Cc:Subject:Date:From;
        b=K5nRKG/Fyh9mDDAWkxBhc9J5mzNSl+bvwFmhoJa/IU3U6APAa9F+ik84KB9jgbvys
         FXIQ2zhX5F3BR6usHR9NEmStnALFHGCjNJHnirZUAFOOO78GT3PCMxdgN2VAJo18F8
         wV9mL10siWL6zJzWYHPjqZ92BqxQJI0f7twKAr9k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C5779602A7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v4 0/4] Add support for audio on SDM845 SoC
Date:   Mon, 30 Jul 2018 15:40:50 +0530
Message-Id: <1532945454-10437-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides initial patchset to support audio on
Qualcomm Techonologies Inc. SDM845 SoC. Currently, it supports
audio playback/capture over Primary MI2S and Quaternary
TDM ports.

Changes since v3:
- Added Module_license in common.c
- Merged apq8096.c machine driver change with common api patch
- Addressed comments by Srinivas, Mark and Vinod.

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

