Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3BBC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D90217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IuQsdFBw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XyqpclTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfAXUWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:22:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53484 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfAXUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:22:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0847B61640; Thu, 24 Jan 2019 20:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548361354;
        bh=ToehwFPiPS3LTfFWh/KBWOGOiw5Vcyq6Uc3orROdysw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IuQsdFBwKpYJZf1G8K7FoBc+P293KIT9GluTb9U7Qo0BroAmSUYq9NRC/HiLUUPIx
         otmjuV18PVb4+T1QA+9+JNpyOv4sDhODuI931soSRvJ6KFfwkCSpaYDdKSmfd+WYQs
         NTYLxTKILK0vdQkKMYPPC4vI3bs6QR808q8RFkW8=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 522AE60D7F;
        Thu, 24 Jan 2019 20:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548361342;
        bh=ToehwFPiPS3LTfFWh/KBWOGOiw5Vcyq6Uc3orROdysw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyqpclTZ/1ivYX/jim77gfhJIj2lFWN/6Sm0Fb+iN6ey5b+UaPoJI0kDOlgm50/Xn
         L4rP1SRSVjW5jH+K4ui3StxwgOPI+6nyPur1dN2xQ6Miczp94YRjBYDG+PsGZ64rvT
         4NzmJ9yQyuse5eieYEySOvWwU8+uZzYRmIKiPQzM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 522AE60D7F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2 7/8] arm64: dts: qcom: setup PDC as wakeup parent for GPIOs for SDM845
Date:   Thu, 24 Jan 2019 13:22:04 -0700
Message-Id: <20190124202205.7940-8-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124202205.7940-1-ilina@codeaurora.org>
References: <20190124202205.7940-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup PDC wakeup parent for TLMM for SDM845 SoC.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e55100c2705e..89982f6ee147 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -994,6 +994,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			wakeup-parent = <&pdc_intc>;
 
 			qup_i2c0_default: qup-i2c0-default {
 				pinmux {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

