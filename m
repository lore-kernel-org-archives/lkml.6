Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E65C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F14F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N/ZdNhbB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nbmAFtwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbeLSWL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:11:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44956 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbeLSWLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:11:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 271DA60989; Wed, 19 Dec 2018 22:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545257496;
        bh=SFT52gn32ORcEzH8jQ0mdr9dGKVnOX9iOcw6iYWVoAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/ZdNhbBp7GdrbCjGBr2t0OdEcy8X/lPufyUiIkzHAeFUsSpddk+zPGflGvyb0Z2U
         bII4rhekGzzMX/jIKHPECMjzXWFTCO4RiZkqhTMTBX+5tAHUtHcl1rI/6nbrRZidqR
         LUPk0vx9rCgSaj+9Z/RGHdFsBlEplaN7etzI0SqY=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C198F6092B;
        Wed, 19 Dec 2018 22:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545257494;
        bh=SFT52gn32ORcEzH8jQ0mdr9dGKVnOX9iOcw6iYWVoAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbmAFtwSqLanaPnbLiroA4YhpQd9RmcOyQ5NJy9l1t7wTM9rk0q0xKAPT56pwS87k
         R3YMfs9627YuZh+IpVcYuZWgKjDkfd4rgRArpyEgv68yX5gfLuF65/l1OUbzA0h4hL
         cd2TDFHicgsWI2O0GB2SZ984kNBo0AxjwtCxem2s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C198F6092B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 6/7] arm64: dts: msm: add PDC device bindings for sdm845
Date:   Wed, 19 Dec 2018 15:11:04 -0700
Message-Id: <20181219221105.3004-7-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181219221105.3004-1-ilina@codeaurora.org>
References: <20181219221105.3004-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index b72bdb0a31a5..8e15392a6f64 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1278,6 +1278,15 @@
 			#reset-cells = <1>;
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

