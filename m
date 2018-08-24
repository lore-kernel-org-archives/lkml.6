Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EEAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD3F21477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DfUHvLZG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bHnYiuVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD3F21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeHXWrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:47:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56020 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeHXWrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:47:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 18781604BE; Fri, 24 Aug 2018 19:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535137885;
        bh=rSVd6fQbQWDRJ3FlHiK1ni0WAXUly75OhmA/iYkWu+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=DfUHvLZG16tiYKQYt54jFq8D3D0lNc3owrbOSN4KVrtgkEhfZFn4XmMbAj1I+1EWx
         4iruBAbURylxc5K+fAlkkG3O0jTqztqos6SO5Sx1CUgF0DN2yOkCLZ5pZAdO4rBH2Z
         TH7ipMagrczEaY7UIsPrFqRpZHb5a98DoRBs2+S4=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F4B860251;
        Fri, 24 Aug 2018 19:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535137884;
        bh=rSVd6fQbQWDRJ3FlHiK1ni0WAXUly75OhmA/iYkWu+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=bHnYiuVLxr9gWP+1oATNP63DmzvRZxRJBMMAArHXJZC19t9aswboDbf2erN3SWGMf
         6ZizeScTFVCqY/e6AvPtdpFjDOKiBTJCGKTNSrRg0VCgo/gn0bKpaXydoPSJSsis8n
         ZI4eoTpd52MMmjD9OaTBIHUCTnxWT1738VoeOuV4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F4B860251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 1/2] arm64: dts: msm: add PDC device bindings for sdm845
Date:   Fri, 24 Aug 2018 13:11:10 -0600
Message-Id: <20180824191111.14571-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDC interrupt controller device bindings for SDM845.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
Changes in v3:
	- Fix PDC map, use GIC SPI port number for hwirq
Changes in v2:
	- Order by address
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b3d7af097edf..0208f8557ffa 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -966,6 +966,15 @@
 			};
 		};
 
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,sdm845-pdc";
+			reg = <0xb220000 0x30000>;
+			qcom,pdc-ranges = <0 480 94>, <94 609 15>, <115 630 7>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

