Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D571FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26D520874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eZ0nlPzD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LLu1dpjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbeLSWLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:11:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45128 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729759AbeLSWLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:11:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 28D7C609C2; Wed, 19 Dec 2018 22:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545257497;
        bh=Am12eEntG3Sh5NcSUMYZeI1ZP0aDUT9ccSxoXYlfz+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZ0nlPzDfqrzMIa1CUyLC5sNb2tG5c5k2TQd3hTxakSpx/1iHUGree69aisDBh5FA
         1Cn3aqS+L5+EPpPE0WRcw7FlmFDFrtd59XO0PKIm9wkJLqkujcQJrRpS6hclJQUryZ
         NcKKhp5pXJeckIqx81trE+hbkuYLZhg8nfLCqXnw=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E038C60907;
        Wed, 19 Dec 2018 22:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545257495;
        bh=Am12eEntG3Sh5NcSUMYZeI1ZP0aDUT9ccSxoXYlfz+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LLu1dpjWA5yYoTKh4dCLnGfHtYy1FmeCWRyL/HIvMb6t5kRbT3vs9eNfIkq2iAhj6
         DWuy8qwOxZu+nDTge/LOA2n82NGfP4s/nan0mJ+xKTRcEiDuC4YzpHfv4EpFaiOaO7
         g6HVie2k8hg4UkHD748CmeXId44mPQF57XsfIRvw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E038C60907
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 7/7] arm64: dts: msm: setup PDC as wakeup parent for GPIOs for SDM845
Date:   Wed, 19 Dec 2018 15:11:05 -0700
Message-Id: <20181219221105.3004-8-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181219221105.3004-1-ilina@codeaurora.org>
References: <20181219221105.3004-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDC wakeup parent for TLMM for SDM845 SoC.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 8e15392a6f64..40dca655ba86 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -821,6 +821,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			wakeup-parent = <&pdc>;
 
 			qup_i2c0_default: qup-i2c0-default {
 				pinmux {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

