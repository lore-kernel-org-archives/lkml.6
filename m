Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D297CC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891A721727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OaAlry/B";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h1H2he1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891A721727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389669AbeHNUTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:19:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58632 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388829AbeHNUTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:19:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4914F6076A; Tue, 14 Aug 2018 17:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534267875;
        bh=+WJIEojQxzhY353XI2XwEGaD1c6/Ynv2JmxsaoB9aGo=;
        h=From:To:Cc:Subject:Date:From;
        b=OaAlry/Bgk+gPK/el57/7VBnnmG0k1ee12QrhUWDH38VRGgxXMPhJu/6R539ibUsZ
         Twj+TV94rGahQIuCgg9qUh2RSj0zCsebYJ3moF4z71TZVyu6Qkg/cF4Kj4lukTrX45
         PDrWaJkJDU5RdG+shvzniemmsYIwxP9l2WtlpF4s=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 744C06076A;
        Tue, 14 Aug 2018 17:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534267874;
        bh=+WJIEojQxzhY353XI2XwEGaD1c6/Ynv2JmxsaoB9aGo=;
        h=From:To:Cc:Subject:Date:From;
        b=h1H2he1Nw+IUBbCjsAHkF/NHemMXw+zoQbXV+3sEudxuz35DDGE9Rh7UYIIG23gEA
         eCqgQVsYX3LwLvNd9xg6Ms5ZBiZWSyuwVYOTE7t5LDUh6La2l6kqq2ZVG9Ynp0BBYa
         ZTLGjOno2nyhntYqgwIFVgwidYcMONMlGc+uqvdc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 744C06076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        david.brown@linaro.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH] arm64: dts: msm: add PDC device bindings for sdm845
Date:   Tue, 14 Aug 2018 11:30:58 -0600
Message-Id: <20180814173058.26143-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDC interrupt controller device bindings for SDM845.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 24e254efb9d1..399bfbd52c5b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1106,6 +1106,15 @@
 			};
 		};
 
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,sdm845-pdc";
+			reg = <0xb220000 0x30000>;
+			qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
 		timer@17c90000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

