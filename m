Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0FCC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBDB21788
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Dq6HZO/P";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i8HMNtJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBDB21788
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeHQTML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:12:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51632 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeHQTML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:12:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 33903625F4; Fri, 17 Aug 2018 16:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534522095;
        bh=tpomX3KopJzpQJDC7jktjHQOXJWPZCfiMVpyg0FNu7w=;
        h=From:To:Cc:Subject:Date:From;
        b=Dq6HZO/PrONsPSW+DLF3xTvRPGSKIw7GLnSL0RsCvOK0Qy1aDMp2DOk8AYbyB5qf9
         RVkFe35gRFf4EyCVWG438TDJPgQ2yOkiZXkWgSVB79tuxJnmQ+x0alWHLO5JF+NVN+
         iEIXVSkpRQb+a27atg4HmpD6TzYf/lQhGfczXzCk=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F79D619E6;
        Fri, 17 Aug 2018 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534522094;
        bh=tpomX3KopJzpQJDC7jktjHQOXJWPZCfiMVpyg0FNu7w=;
        h=From:To:Cc:Subject:Date:From;
        b=i8HMNtJXLjB/aSFJFyLXmM8p9FSfI+pLVWpPx7JsmT/tatlUh2wW8i8p08QJUmRzx
         T81O8EhBk6t7DNgJ/5YCUZOIw2rWS5+mQtglS/AFI1OO8+9eZnb0m53E63Lo28y+zs
         LK1f7lSJfWGlSPuKSTbe/Cs4gT7yhVzkCbrjoexA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F79D619E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        david.brown@linaro.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2] arm64: dts: msm: add PDC device bindings for sdm845
Date:   Fri, 17 Aug 2018 10:08:02 -0600
Message-Id: <20180817160802.24332-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDC interrupt controller device bindings for SDM845.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
Changes in v2:
	- Order by address
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cdaabeb3c995..516ab4c7acf8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -221,6 +221,15 @@
 			#interrupt-cells = <2>;
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
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

