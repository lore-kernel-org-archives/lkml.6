Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3061C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4E423FF5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PA6P3KmH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QCJM6Gt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4E423FF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753724AbeGFJna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:43:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51040 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbeGFJn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:43:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9AACF60B27; Fri,  6 Jul 2018 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530870207;
        bh=vt+mNJKVnxKk6rf/5n8El99uPrmHPtyAnzojs9L7+Uo=;
        h=From:To:Cc:Subject:Date:From;
        b=PA6P3KmH9lg0fILkIuDr2BX5ztrINJioP+koT4L/tc4BY7uyo1X26VaRMTgOZtqVx
         rxWNBmQBD6YSYwrI0e6GsNBcoWVrCtIdFUokT7aYxTW00mtgbxwnw68RygHuiM3muk
         ZLIGmoydTblm23gDMssYQ5sTZmsxr9Cp47kfJ8sA=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 314DF60251;
        Fri,  6 Jul 2018 09:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530870206;
        bh=vt+mNJKVnxKk6rf/5n8El99uPrmHPtyAnzojs9L7+Uo=;
        h=From:To:Cc:Subject:Date:From;
        b=QCJM6Gt5Cu17vy/mnyhAv2UuzTIkNePt9NqIGq40XJ2EzJJRMj5oBA8AM440jd/Lf
         7fDYRpCf6VapPHB2FMRL7rewDbuA+aAQoWHhq7ENwhCwxtNHuO/MSgJDwUxjk4yWtl
         Wrg68hkTOjlZdqCLxNpvpeJqa7Onrm8g24deIvA4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 314DF60251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v3 0/5] Add support for audio on SDM845 SoC
Date:   Fri,  6 Jul 2018 15:13:10 +0530
Message-Id: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This provides initial patchset to support audio on
Qualcomm Techonologies Inc. SDM845 SoC. Currently, it supports
audio playback/capture over Primary MI2S and Quaternary
TDM ports.
Changes since v2:
- Added new file to parse dai-links from device tree
  and use it in sdm845 and apq8096 machine driver.
- Removed qcom prefix from device tree properties as
  suggested by Robb.
- Updated apq8096 machine driver to use common APIs.

Rohit kumar (5):
  ASoC: qcom: dt-bindings: Add sdm845 machine bindings
  ASoC: qcom: Add support to parse common audio device nodes
  ASoC: qcom: add sdm845 sound card support
  ASoC: dt-bindings: Update dt binding name for apq8096
  ASoC: qcom: apq8096: Use common APIs to parse device nodes

 .../devicetree/bindings/sound/qcom,apq8096.txt     |  15 +-
 .../devicetree/bindings/sound/qcom,sdm845.txt      |  80 +++++
 sound/soc/qcom/Kconfig                             |  14 +
 sound/soc/qcom/Makefile                            |   3 +
 sound/soc/qcom/apq8096.c                           | 151 +-------
 sound/soc/qcom/common.c                            | 150 ++++++++
 sound/soc/qcom/common.h                            |  14 +
 sound/soc/qcom/sdm845.c                            | 390 +++++++++++++++++++++
 8 files changed, 674 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
 create mode 100644 sound/soc/qcom/common.c
 create mode 100644 sound/soc/qcom/common.h
 create mode 100644 sound/soc/qcom/sdm845.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

