Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAC3ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542EE204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kt1KqCmt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R3TuDGKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542EE204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeINSjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:39:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeINSje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:39:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 342686083E; Fri, 14 Sep 2018 13:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536931504;
        bh=jdPORFePyNIRs+vNifKGskw4WRRVKUew3QNXhPBsbcQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kt1KqCmtcvODNctzzVAb98SkSLyFJyAM5A5sHT93sa+vGgrA88fG0XAE1a6AUPj4M
         5XKh1fKrdZKfhJnxSgSILEQ1uJvA7SPdu2SZsIczc6YnvocmnTxjW6p7GLj+eJIL4h
         Pza5w6VA1Neg5Wl0GJI2PgapMYn/4XRTlKY2zqX8=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC2A060B10;
        Fri, 14 Sep 2018 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536931500;
        bh=jdPORFePyNIRs+vNifKGskw4WRRVKUew3QNXhPBsbcQ=;
        h=From:To:Cc:Subject:Date:From;
        b=R3TuDGKUq0vFkiaCDi+JCPzLSXiWqrOxLQn1jHfrwgR7JvPo05mMKHbppMWruF6md
         xQyq6+fupqoBRKNNIl5WZbKO/S5puAbHDn066XbnHIm7jZuxOfw3znB/w/SJsWnbhu
         HeMdTxw3swR/kO/xPOlSdjOFDGdKsTEBFDSl9dig=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC2A060B10
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
Subject: [PATCH v7 0/5] Venus updates - PIL
Date:   Fri, 14 Sep 2018 18:54:32 +0530
Message-Id: <1536931477-13018-1-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v7 with following comments addressed:

* Move iommu allocate/attach and detach/free to firmware init/deinit
  to avoid iommu configurations during every firmware reload.
* Move DT documentation as separate patch.

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

