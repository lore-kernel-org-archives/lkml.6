Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634E5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 04:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325E621A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 04:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DX1FYQv7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g+EC29pI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbfBQEc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 23:32:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42130 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfBQEc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 23:32:26 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 93BC860769; Sun, 17 Feb 2019 04:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550377944;
        bh=AMOVP2zhSZcJrbkHXaJXuryKa8t3N/LSDW6EwVp6xQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DX1FYQv7m0pTodRO8qYh9JbGypfBWyklxuRrZbuqAsHWe/P8SvKREwL/HPDy6XJ7a
         EzHwuGyr7JWRSwZc6OaoM7CVjrC+bHXLaxfUbe/SFccenGdhYCUM6U1hpJcEKZeB5F
         4C6/biSyuyk7a2//WhACVnz5FGlP7eJK0tviP5Q4=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C68B608FB;
        Sun, 17 Feb 2019 04:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550377943;
        bh=AMOVP2zhSZcJrbkHXaJXuryKa8t3N/LSDW6EwVp6xQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+EC29pINBdKVAA4ZS4KxyznotfyDaXaQeU+keZ8hOHn4wiAf4yTM/rsp0nCmLoIj
         SqOYCHJlJ6laTll+Wo99qOFbXOw5QWLwXke2zLe6+HwkhVcrNH1uv5CD/QrDPJYtTc
         ZLcvSKnaTHx2kNUXfByPWEOlOx+prfuvKDHJdBmk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C68B608FB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2 2/4] dt-bindings: clock: Add support for the MSM8998 mmcc
Date:   Sat, 16 Feb 2019 21:32:14 -0700
Message-Id: <1550377934-11377-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550377885-10618-1-git-send-email-jhugo@codeaurora.org>
References: <1550377885-10618-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the multimedia clock controller found on MSM8998

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,mmcc.txt   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
index 8b0f7841af8d..a92f3cbc9736 100644
--- a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
@@ -10,11 +10,32 @@ Required properties :
 			"qcom,mmcc-msm8960"
 			"qcom,mmcc-msm8974"
 			"qcom,mmcc-msm8996"
+			"qcom,mmcc-msm8998"
 
 - reg : shall contain base register location and length
 - #clock-cells : shall contain 1
 - #reset-cells : shall contain 1
 
+For MSM8998 only:
+	- clocks: a list of phandles and clock-specifier pairs,
+		  one for each entry in clock-names.
+	- clock-names: "xo" for the xo clock.
+		       "gpll0" for the global pll 0 clock.
+		       "dsi0dsi" for the dsi0 pll dsi clock (required if dsi is
+				enabled, optional otherwise).
+		       "dsi0byte" for the dsi0 pll byte clock (required if dsi
+				is enabled, optional otherwise).
+		       "dsi1dsi" for the dsi1 pll dsi clock (required if dsi is
+				enabled, optional otherwise).
+		       "dsi1byte" for the dsi1 pll byte clock (required if dsi
+				is enabled, optional otherwise).
+		       "hdmipll" for the hdmi pll clock (required if hdmi is
+				enabled, optional otherwise).
+		       "dpvco" for the displayport pll vco clock (required if
+				dp is enabled, optional otherwise).
+		       "dplink" for the displayport pll link clock (required if
+				dp is enabled, optional otherwise).
+
 Optional properties :
 - #power-domain-cells : shall contain 1
 
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.


