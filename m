Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9917CC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556F720858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NzRaTJ5v";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g6RuwLEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556F720858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJHUiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:38:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40544 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJHUiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:38:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B45360B7F; Mon,  8 Oct 2018 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539005176;
        bh=LhvQIAWA45Tb4l/u2hrM/Sp4HTDqY8M9cTJESLdsvaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NzRaTJ5vvXGzPVTGGIABGCH2rDWvOVVlAgfV5d9HjUQiPpZ+O8Tub8ieVnQB0oI0A
         TKZNx1Ify+Ws1/Sr8RLqYqyLnRO1pcduO8O4UQOY9LHsAY/CXXMxa9MljJBeYkRBLe
         kvCXmxbGOfKxR6YAiy4FSG7bAdUo/W6G1xO6gbQ4=
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C736560C1D;
        Mon,  8 Oct 2018 13:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539005175;
        bh=LhvQIAWA45Tb4l/u2hrM/Sp4HTDqY8M9cTJESLdsvaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6RuwLEQOlWO2Z8dSaI1EmvCfa/ERaKfpBqLQvhTyQ2Tz8ly2i+EsSIzEkmuX1E/H
         o5AiER1obDy2YVMfLl/RGEh5jRg9iMDbo/yRd0qVW6Vg4D2g4P42xYsaZuTuF8RpFG
         eUmb1vyV+HqxahTpFprhh89f7dCnYewhjOkSNJzo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C736560C1D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com
Cc:     asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 1/2] dt-bindings: mmc: sdhci-msm: Add new compatible string for sdcdc10 DLL
Date:   Mon,  8 Oct 2018 18:55:37 +0530
Message-Id: <1539005138-32560-2-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539005138-32560-1-git-send-email-vbadigan@codeaurora.org>
References: <1539005138-32560-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the SDHC-MSM controllers which makes use of sdcdc10 variant DLLs,
the DLL configuration needs to be restored whenever controller clocks
are gated. This new compatible string denotes the sdhc-msm controller
variant which uses sdcdc10 DLL.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 3720385..49b0a43 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -6,7 +6,11 @@ and the properties used by the sdhci-msm driver.
 Required properties:
 - compatible: Should contain:
 		"qcom,sdhci-msm-v4" for sdcc versions less than 5.0
+		"qcom,sdhci-msm-v4-sdcdc10" for sdcc versions < 5.0 and
+		which makes use of sdcdc10 variant DLLs.
 		"qcom,sdhci-msm-v5" for sdcc versions >= 5.0
+		"qcom,sdhci-msm-v5-sdcdc10" for sdcc versions >= 5.0 and
+		which makes use of sdcdc10 variant DLLs.
 		For SDCC version 5.0.0, MCI registers are removed from SDCC
 		interface and some registers are moved to HC. New compatible
 		string is added to support this change - "qcom,sdhci-msm-v5".
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

