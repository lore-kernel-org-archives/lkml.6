Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937D5C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5346020685
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NqeDK78y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M68t+z9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5346020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeHUUku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:40:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeHUUkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:40:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5551160D60; Tue, 21 Aug 2018 17:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534871988;
        bh=NhwwSkExnlL1lyOUOCfo6BZ1NspXqiCiAWjPTD+YQAo=;
        h=From:To:Cc:Subject:Date:From;
        b=NqeDK78yBYba2SPeGU5sx/tZ1WHGeQUWxT5yq+0/GlJO5yLs88XTNn7BE3NiPGp/N
         zTKvRg24KU4aAjAzP+uo8WasqDsRkzNwN1D0GpR7o44qGreJNDk2iR7E5KRxeLzx3n
         nlgFPDRn1Hvv2uoLrhEN7bkBBhmD9V7OOc/x1wjw=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9F4860D60;
        Tue, 21 Aug 2018 17:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534871987;
        bh=NhwwSkExnlL1lyOUOCfo6BZ1NspXqiCiAWjPTD+YQAo=;
        h=From:To:Cc:Subject:Date:From;
        b=M68t+z9hMc5aw7aWGw/vFj9WnUCEy7aOB/ShHt+gmqSdrmcqwxktM2pSIn34Q5+A7
         QrcXJEIyfXK85lJSLxTHbo+M29n3iewvoBL9miTTnJZQguQczj3DVM25MD2oPt0rLJ
         4efQRyZhc0itrXk1pgFLZtp8nPyLEQxpATCliWvY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9F4860D60
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
Subject: [PATCH v5 0/4] Venus updates - PIL
Date:   Tue, 21 Aug 2018 22:49:30 +0530
Message-Id: <1534871974-32269-1-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v5 with following comments addressed:

* non-pixel register programming during reset.
* comments related to instructions reordering.

Vikash Garodia (4):
  venus: firmware: add routine to reset ARM9
  venus: firmware: move load firmware in a separate function
  venus: firmware: add no TZ boot and shutdown routine
  venus: firmware: register separate driver for firmware device

 .../devicetree/bindings/media/qcom,venus.txt       |  17 +-
 drivers/media/platform/qcom/venus/core.c           |  60 +++++--
 drivers/media/platform/qcom/venus/core.h           |   7 +
 drivers/media/platform/qcom/venus/firmware.c       | 194 ++++++++++++++++++---
 drivers/media/platform/qcom/venus/firmware.h       |  17 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
 drivers/media/platform/qcom/venus/hfi_venus_io.h   |   8 +
 7 files changed, 272 insertions(+), 44 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

