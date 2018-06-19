Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33CAC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE712083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KzkOIRpP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ODr9A3/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE712083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965473AbeFSFkF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:40:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964895AbeFSFkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:40:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B2CDE60B25; Tue, 19 Jun 2018 05:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529386800;
        bh=9NXbbwVoQMt/GLSDwHZ/UIX3DPJngm8fg+plVf+63Ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KzkOIRpPX0Z9fPSZ/Qs4VaQ1qk97em2tzX7702nrIMqsg35V3MdvvCxyWxRheIt6w
         P+piUOLlpnP5P2eYZBTfXheF/5M67pHWaYid5Ctai8u6xgZbJk8FFxq/2XVWfvom3a
         sgWE9uPq52Jjty3v3FESdSPqPYlralwxBkH7DW64=
Received: from hydcbspbld03.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vviswana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19EA160B10;
        Tue, 19 Jun 2018 05:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529386799;
        bh=9NXbbwVoQMt/GLSDwHZ/UIX3DPJngm8fg+plVf+63Ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODr9A3/9vCDtAgFeU0bX7k58VKQzQIXoKuzHehEVie/r8pQGlc5o9ThDglGYoRZdo
         RHC+Ot5ucpLiimC1RVOanXCnd9dWM8QLJwOgB+kb+ozE1tPvwUm9k/DBp9QmU/pi/0
         b/5VKWZ6jXd3piu+7CE5ePI0Ses/MwmoD4Bg6VC8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19EA160B10
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
From:   Vijay Viswanath <vviswana@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        vviswana@codeaurora.org, bjorn.andersson@linaro.org,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        dianders@google.com, sayalil@codeaurora.org
Subject: [PATCH V3 3/4] Documentation: sdhci-msm: Add new compatible string for SDCC v5
Date:   Tue, 19 Jun 2018 11:09:20 +0530
Message-Id: <1529386761-4923-4-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
References: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sayali Lokhande <sayalil@codeaurora.org>

For SDCC version 5.0.0 and higher, new compatible string
"qcom,sdhci-msm-v5" is added.

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index bfdcdc4..502b3b8 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -4,7 +4,12 @@ This file documents differences between the core properties in mmc.txt
 and the properties used by the sdhci-msm driver.
 
 Required properties:
-- compatible: Should contain "qcom,sdhci-msm-v4".
+- compatible: Should contain:
+		"qcom,sdhci-msm-v4" for sdcc versions less than 5.0
+		"qcom,sdhci-msm-v5" for sdcc versions >= 5.0
+		For SDCC version 5.0.0, MCI registers are removed from SDCC
+		interface and some registers are moved to HC. New compatible
+		string is added to support this change - "qcom,sdhci-msm-v5".
 - reg: Base address and length of the register in the following order:
 	- Host controller register map (required)
 	- SD Core register map (required)
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

