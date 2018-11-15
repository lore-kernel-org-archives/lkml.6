Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC3CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D33224E0
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G21Ywzb5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="os2WUWuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D33224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbeKPD1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:27:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36090 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388365AbeKPD1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:27:15 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8E83260866; Thu, 15 Nov 2018 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542302314;
        bh=aKM5npLNLtd1h2YlfIhU054KLTwkg3H4NB07fGfsAZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G21Ywzb5BDcS+bHgBepqADOIKcUsOH9/u3MEkHtSnn1rqIqoQ7/9dfxIBeZnEEWuc
         gK+4cTJU0v37gZrREvmbH2KcC9b/VJwsidme3Fy6EZrWaZhZTVsrYqtX4WiRC1jd18
         gOgb3L9nuRVste0LPv1+WswRT221hZNW3u41MqnA=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 139BD60791;
        Thu, 15 Nov 2018 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542302313;
        bh=aKM5npLNLtd1h2YlfIhU054KLTwkg3H4NB07fGfsAZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=os2WUWuA5NxPFqvpTngsaw7LxPytQMcWEM1j5UklNSqhLLnJIxhiSkAMkWQoSiBKo
         Wd9+eZCQmg1Y5rypy6DaDsLAZUD2ivNjAlvmRCw/q29L3DOIyqeiofnZ/RToZqpbM9
         7IIJKmim8j2XS1+JFYIeBeuQAF5OxbFTES+5kgno=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 139BD60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH 1/4] arm64: dts: qcom: msm8998: correct xo clock name
Date:   Thu, 15 Nov 2018 10:18:08 -0700
Message-Id: <1542302291-6864-2-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
References: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The root parent clock of most msm8998 clock is the "xo" clock.  The DT node
is incorrectly named "xo_board", which prevents Linux from correctly
parsing the clock tree, resulting in most clocks being unparented and
unable to be manipulated.  The end result is that we can't turn on clocks
for peripherals like SD, so init usually fails.

Fixes: 4807c71cc688 (arm64: dts: Add msm8998 SoC and MTP board support)
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 78227cc..a948d4b 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -53,7 +53,7 @@
 	};
 
 	clocks {
-		xo_board {
+		xo {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <19200000>;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

