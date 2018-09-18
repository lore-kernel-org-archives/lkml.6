Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C55C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DD12133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fIZ7bkyQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k/HOSMOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DD12133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbeISFS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 01:18:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeISFS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 01:18:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8468160BF5; Tue, 18 Sep 2018 23:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537314208;
        bh=w1Jzx7lLBxguWK4Afp0Vzd0usaACFvGXzO5Qer0jylo=;
        h=From:To:Cc:Subject:Date:From;
        b=fIZ7bkyQmASqptgOzEh768gu4L8hi7Ei2/AHQt9WobDWOkEPsdRGg+oYD1V4Sb94j
         gFDcDiCa1gT+FcLzrYaKjuKbriCGmizxTOsnfR+y3s0jkNmHo83cp8id4gWwKsurKn
         vc6FjzVgvpucNNPR8eY7walzi8FevBVE477SfObw=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22466600ED;
        Tue, 18 Sep 2018 23:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537314207;
        bh=w1Jzx7lLBxguWK4Afp0Vzd0usaACFvGXzO5Qer0jylo=;
        h=From:To:Cc:Subject:Date:From;
        b=k/HOSMOHS8HelP1bYqXbtjpY8oeY1KK7gQ76auF/lu64FXcQAy5GNnqL/rdYXHeci
         P3YFfjvodboBEGDv0bHS8Ju8Ed2QqM8E/GRQmT1jp/gb9M33sWDdXLtkOC4RMUNGR/
         xYV98Iwbfe/SwGCfL2gHoiezqonAhiP77sE3c/fU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22466600ED
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
Subject: [PATCH v9 0/5] Venus updates - PIL
Date:   Wed, 19 Sep 2018 05:13:07 +0530
Message-Id: <1537314192-26892-1-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/media/platform/qcom/venus/firmware.c       | 234 +++++++++++++++++++--
 drivers/media/platform/qcom/venus/firmware.h       |  17 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
 drivers/media/platform/qcom/venus/hfi_venus_io.h   |   8 +
 7 files changed, 272 insertions(+), 43 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

