Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03CFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6122087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EaNIwCkn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UFKq2Sp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbfA3QgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:36:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58348 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfA3QgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:36:12 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B62C160877; Wed, 30 Jan 2019 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548866170;
        bh=qpOwuWHqt3RqMW9Um/zY0NFdascuvzLlVWFw7025HSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EaNIwCknpavC0HuBj1N1WvrzsDkzAco50NYF0AMAf4JbakUvD8vwMY9244u67TE6S
         akczCWWmWV7QfIWk7pCa4kkRXZNZT+rOOC6Z5cHnFcdedhMPXBqSboWjoJrrvj9NSH
         /tqHwlynldM1SjOCgHfj/YSkV9lp7qUwPSWoNPuU=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DF2356117A;
        Wed, 30 Jan 2019 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548866167;
        bh=qpOwuWHqt3RqMW9Um/zY0NFdascuvzLlVWFw7025HSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UFKq2Sp+H+jthOAFNXWnr8Z/DUh75xjeCzQ3/eKJzS8nyQhKiZOOOmmkjx2Vh6tUY
         jKFW5PVQay1vHo7RXhO0wespVsa2APU9AR2Iv3u6kYc59ppdXRrjsKqHFGD5rJi5Z7
         vV4GFi0XAf7kcI6/gCON4Rb+YCCH/IRrf6dD4zCo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF2356117A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v1 2/4] dt-bindings: clock: Add support for the MSM8998 mmcc
Date:   Wed, 30 Jan 2019 09:35:59 -0700
Message-Id: <1548866159-30304-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the multimedia clock controller found on MSM8998

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 Documentation/devicetree/bindings/clock/qcom,mmcc.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
index 8b0f784..ae85bca 100644
--- a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
@@ -10,11 +10,18 @@ Required properties :
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
+	- clock-names: "xo" for the xo clock,
+		       "gpll0" for the global pll 0 clock.
+
 Optional properties :
 - #power-domain-cells : shall contain 1
 
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

