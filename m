Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33E7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EA42146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LW4Ryj30";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hpwgir2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EA42146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbeISDeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:34:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45918 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbeISDeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:34:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8752760C4F; Tue, 18 Sep 2018 21:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537307972;
        bh=X//jztApO9I29mCIoxbhIkrNDKq3ZO+AztfwsPe8+iw=;
        h=From:To:Cc:Subject:Date:From;
        b=LW4Ryj304f2vUiHXRCoz0AhGY6TWCo25LXQ/wOvz7WjUxWLlotkNDbKPIjqiEl+J7
         jarJEaKcOdWXtQSz2KOKB+x1eXR/i8maDXdN20HZOed1a3u3D8hex9uWYnR9qkLgIM
         v15E14Qejo6OLtGWi2D3GXqOEUR4YCeOxmiKfuxg=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9B6F60CC8;
        Tue, 18 Sep 2018 21:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537307970;
        bh=X//jztApO9I29mCIoxbhIkrNDKq3ZO+AztfwsPe8+iw=;
        h=From:To:Cc:Subject:Date:From;
        b=Hpwgir2kEtQA36gBhEJgkf2vYzCeb7umU3ex1zDJ8WLyuOEm4Eb0hUAus1cym4Y8a
         rhfRe1+SGKqHgjJDKeRgQpwZ+WaoLLJbzj4dUbRsCb4ZdruGeUiLaZMTuj2Zr4YFls
         PAdwocA6uSeiRKxKOHdUly9joXVMoYm2VeWTM3Q8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9B6F60CC8
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
Subject: [PATCH v8 0/5] Venus updates - PIL
Date:   Wed, 19 Sep 2018 03:29:08 +0530
Message-Id: <1537307954-9729-1-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series just fixes the compilation for of_dma_configure.
Minor #define name improvement and indentations.

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

