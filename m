Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DATE_IN_PAST_06_12,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFA6C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 07:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B3E20857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 07:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfBIH6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 02:58:04 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:27056 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfBIH6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 02:58:04 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 8779119F5C9;
        Sat,  9 Feb 2019 08:57:25 +0100 (CET)
Subject: [PATCH v4 5/7] arm64: dts: qcom: msm8998: Allow drivers to set-load
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     MSM <linux-arm-msm@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <09ce9c20-c47b-f936-a8a9-6c8ec8f0f867@free.fr>
Message-ID: <31519816-a641-ebfe-64c7-039aff074187@free.fr>
Date:   Fri, 8 Feb 2019 23:15:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <09ce9c20-c47b-f936-a8a9-6c8ec8f0f867@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UFS host controller driver needs to set the load on 3 power rails
(l20, l26, s4) but the operation fails silently unless we specify the
regulator-allow-set-load property in the corresponding DT nodes.

Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index f0901067b043..19775cae1381 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -111,6 +111,7 @@
 		vreg_s4a_1p8: s4 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
 		};
 		vreg_s5a_2p04: s5 {
 			regulator-min-microvolt = <1904000>;
@@ -195,6 +196,7 @@
 		vreg_l20a_2p95: l20 {
 			regulator-min-microvolt = <2960000>;
 			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
 		};
 		vreg_l21a_2p95: l21 {
 			regulator-min-microvolt = <2960000>;
@@ -221,6 +223,7 @@
 		vreg_l26a_1p2: l26 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
+			regulator-allow-set-load;
 		};
 		vreg_l28_3p0: l28 {
 			regulator-min-microvolt = <3008000>;
-- 
2.17.1
