Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE5EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9068221A2D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H5j5ORLn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ocr2NMUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9068221A2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbeHFPhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:37:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54552 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeHFPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:37:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EDB8360769; Mon,  6 Aug 2018 13:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533562098;
        bh=k7W7/0r29/AkaJ+h0iiHsvKQ6PrnuqTMruJG2vCE/4I=;
        h=From:To:Cc:Subject:Date:From;
        b=H5j5ORLnon4cCPyyj8asyouMuIvc3/3lHs2G0X9n2mL+1FpFCeJGaZOf1C86oSbiU
         w1W8hSAqUGhPbEmoDFL8msfE3r6CwlC6mT38LwDmrr1IA2SdQFnuVX6kUEHqZPrB92
         dOZysoagi6Gc5uO/GQPhONkjSg1ukRBSSjNHawwI=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7782A60117;
        Mon,  6 Aug 2018 13:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533562097;
        bh=k7W7/0r29/AkaJ+h0iiHsvKQ6PrnuqTMruJG2vCE/4I=;
        h=From:To:Cc:Subject:Date:From;
        b=ocr2NMUvs8rZ4IOPDS5enjy6MpFdeqLf8meF0eS3e9K2leaOxUEXF2muP95sctYQN
         qERUgqVbbhShqAIFZjpplIu62m/oJ4OMX3McvPZ/kGoSVLY9E0fDZWep016IpB080f
         iuFXQV/xnqcvMUAjIZjJhackWB+dGhrX3yDH8984=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7782A60117
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
Subject: [PATCH v4 0/4] Venus updates - PIL
Date:   Mon,  6 Aug 2018 18:58:01 +0530
Message-Id: <1533562085-8773-1-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v4 with following comments addressed:

* inline function for setting suspend and resume.
* keep firmware size as 6 MB.
* comments related to indentation, cleanup, etc.

As per comments from Bjorn, qcom_mdt_load_no_init is being used in this
patch series to align with https://patchwork.kernel.org/patch/10397889/.

Comments are welcome!

Vikash Garodia (4):
  venus: firmware: add routine to reset ARM9
  venus: firmware: move load firmware in a separate function
  venus: firmware: add no TZ boot and shutdown routine
  venus: firmware: register separate driver for firmware device

 .../devicetree/bindings/media/qcom,venus.txt       |  17 +-
 drivers/media/platform/qcom/venus/core.c           |  60 +++++--
 drivers/media/platform/qcom/venus/core.h           |   7 +
 drivers/media/platform/qcom/venus/firmware.c       | 192 ++++++++++++++++++---
 drivers/media/platform/qcom/venus/firmware.h       |  17 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
 drivers/media/platform/qcom/venus/hfi_venus_io.h   |   6 +
 7 files changed, 268 insertions(+), 44 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

