Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeC3UET (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 16:04:19 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41839 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbeC3UER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 16:04:17 -0400
X-Google-Smtp-Source: AIpwx48W7uMPX+nVFjjmPrJnM44Gq5XPYUetXtus8ahlUJqxIv0YSO1dQjC7dgVl47TDEXfDkVu2YA==
From: Craig Tatlor <ctatlor97@gmail.com>
Cc: ctatlor97@gmail.com, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: pm8941: Add vadc nodes needed to estimate an ocv
Date: Fri, 30 Mar 2018 21:04:08 +0100
Message-Id: <20180330200408.12608-1-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.16.2
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vbat_sns is needed to estimate a fairly accurate on chip voltage
and bat_therm is needed to produce an accurate percentage
from the estimated ocv.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 arch/arm/boot/dts/qcom-pm8941.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index 1d5ef55c7ee5..2515c5c217ac 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -139,6 +139,9 @@
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
+			bat_temp {
+				reg = <VADC_LR_MUX1_BAT_THERM>;
+			};
 			die_temp {
 				reg = <VADC_DIE_TEMP>;
 			};
@@ -154,6 +157,9 @@
 			ref_vdd {
 				reg = <VADC_VDD_VADC>;
 			};
+			vbat_sns {
+				reg = <VADC_VBAT_SNS>;
+			};
 		};
 
 		pm8941_iadc: iadc@3600 {
-- 
2.16.2
