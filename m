Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970D2C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F3620818
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfBDRn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:43:58 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:50857 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbfBDRn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:43:58 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id E077D13F8E0;
        Mon,  4 Feb 2019 18:43:39 +0100 (CET)
Subject: [PATCH v3 2/5] arm64: dts: qcom: msm8998: Allow drivers to set-load
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
Message-ID: <31108a78-e158-5147-2f2f-cd300cb5d49b@free.fr>
Date:   Mon, 4 Feb 2019 18:37:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UFS host controller driver needs to set the load on 3 power rails
(l20, l26, s4) but the operation fails silently unless we specify the
regulator-allow-set-load property in the corresponding DT nodes.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index 80075283847a..198885db775e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -104,6 +104,7 @@
 		vreg_s4a_1p8: s4 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
 		};
 		vreg_s5a_2p04: s5 {
 			regulator-min-microvolt = <1904000>;
@@ -188,6 +189,7 @@
 		vreg_l20a_2p95: l20 {
 			regulator-min-microvolt = <2960000>;
 			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
 		};
 		vreg_l21a_2p95: l21 {
 			regulator-min-microvolt = <2960000>;
@@ -212,6 +214,7 @@
 		vreg_l26a_1p2: l26 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
+			regulator-allow-set-load;
 		};
 		vreg_l28_3p0: l28 {
 			regulator-min-microvolt = <3008000>;
-- 
2.17.1
