Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B631FC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798862084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a4pR/xKH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="imhQgI/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798862084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeLLMpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:45:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50438 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeLLMpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:45:12 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4389D602FF; Wed, 12 Dec 2018 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544618712;
        bh=bQgKiQOqtRXpI3MSOCfCddTBmmn1fLnC99kZz9N1ZOY=;
        h=From:To:Cc:Subject:Date:From;
        b=a4pR/xKHgk9BFGZheGqc4UC1HQFT9ojCg1/cyuOOGLGpFv3289gUEBi8s7URGLgQk
         kvaWGrsLY7rBhDEWiwv+QKGtwX7PprK/ImgH23IfAihn+y9dAB3hZ2nF9DG2n8CtNs
         4FojthRbBERHdM3g84Dh85NCIQU8/azDvaKuf8nk=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92DA5601D7;
        Wed, 12 Dec 2018 12:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544618711;
        bh=bQgKiQOqtRXpI3MSOCfCddTBmmn1fLnC99kZz9N1ZOY=;
        h=From:To:Cc:Subject:Date:From;
        b=imhQgI/S7vPoSLqCHnMmcQHyCqw8B3+iQMKjIuOHC9HN2+Rr3rjZ/AnqZuc2fIvPA
         I/fZCpBJ16bPbr7MzQiZ+ob/pzCrgTu+0tMY+AXsqP/2qe66Vehnxz48Mw8Dr7pxUF
         7KnX3cHf7XpMyqj1amwPsmpfsSsga2jfoslcJNVA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92DA5601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org
Cc:     briannorris@chromium.org, akdwived@codeaurora.org,
        clew@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 0/2] Add firmware bindings for Q6V5 MSS
Date:   Wed, 12 Dec 2018 18:14:54 +0530
Message-Id: <20181212124456.3164-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q6V5 MSS on certain SoCs like SDM845 are capable of operating under
completely different configuration (like Non-Modem WLAN configuration)
depending on the firmware loaded without any change in boot sequence
of the Hexagon core. The patch series is ultimately aimed to avoid
multiple compatibles per SoC to just specify different upstreamed firmware
locations. This is achieved by introducing "qcom,firmware" binding
to store the relative path of mba and modem metadata.

remoteproc@4080000 { 
	...
	qcom,firmware = "qcom/sdm845/mss/mba.mbn",
			"qcom/sdm845/mss/modem.mdt";
	...
}

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

SibiSankar (2):
  dt-bindings: remoteproc: qcom: Add firmware bindings for Q6V5 MSS
  remoteproc: qcom: q6v5-mss: Add support for parsing fw dt bindings

 .../bindings/remoteproc/qcom,q6v5.txt         |  7 +++
 drivers/remoteproc/qcom_q6v5_mss.c            | 49 ++++++++++++++++---
 2 files changed, 48 insertions(+), 8 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

