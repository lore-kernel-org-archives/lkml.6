Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1120C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DAE20896
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SOGRxD30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DAE20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeH1Rat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:30:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38158 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeH1Rat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:30:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id h33-v6so1403744edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 06:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=68+Vu+lQWHojtoyEFuI2o+33g2Xv3HxIF7ejjTszY6c=;
        b=SOGRxD30exOWpoDV2OGbRamp96wEPhPVG/dSE0/Rhpw1p3uWDu0VB1TU2fztYQduUa
         NicRk8TODj2x0Sy0bWFRWZLmUm+0RJLKO/Diavtim7ZEBkbSW+5EJ0f4iPqFOm27YJV5
         jORaVpjrGWycYExZu6NIsRBFlLOoKcdSaJk5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=68+Vu+lQWHojtoyEFuI2o+33g2Xv3HxIF7ejjTszY6c=;
        b=GH2Ehryi0GFejttEPv8llJjmJIXiR+mEfeYs8/euxWyjH5XoqpkUOXP2lIbwsy08tY
         axMIlhBn8Oxf5wA0r9wqypYYHYtfaE/m9ypjf8qPcoC1ztqNa6dzIVqVIzfmdt2kB94O
         t21bB0v/bcdVMOl95gVCjthIbRqn8oNxfeg0YQG30U5GnsJsYImDN1ATyE1KPPUeEU4U
         TgvJHYFqf0+u/IQLYCw1Xi3xxmQ50WhiA+8LLkHrC/XHJXF8NCOswJI8FchLA2LQ2kE2
         LQnyxld1rbPmMwxhRdeWwuU6kmeI3I5F41YesEABbszylji4u85/wCBE5mBA4yW5BArB
         AfJA==
X-Gm-Message-State: APzg51CXs6swNbcceyonRcDF6xhWhFUdC8ljGEKrGdZUaKK3k2eTZxyD
        vEWCaLg9rX5uReAp7DMhpQj1S4ovywM=
X-Google-Smtp-Source: ANB0Vdbb0mdwSuMa1geeg2/eIPAnh8IV/7v4r98vlrxZ/oI8AE/ocpw1Xg9TEssGffc3M8Va4A6I2A==
X-Received: by 2002:a50:8ee4:: with SMTP id x33-v6mr2488157edx.252.1535463545430;
        Tue, 28 Aug 2018 06:39:05 -0700 (PDT)
Received: from localhost ([49.248.200.109])
        by smtp.gmail.com with ESMTPSA id c28-v6sm722599edc.52.2018.08.28.06.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 06:39:04 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 01/11] arm/arm64: dts: msm8974/msm8916: thermal: Split address space into two
Date:   Tue, 28 Aug 2018 19:08:30 +0530
Message-Id: <882739b10bd0a3b655baef9b7ee1958680aa0b04.1535462942.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've earlier added support to split the register address space into TM
and SROT regions.

Split up the regmap address space into two for the remaining platforms
that have a similar register layout and make corresponding changes to
the get_temp_common() function used by these platforms.

Since tsens-common.c/init_common() currently only registers one address
space, the order is important (TM before SROT).  This is OK since the
code doesn't really use the SROT functionality yet.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi   | 5 +++--
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 5 +++--
 drivers/thermal/qcom/tsens-common.c   | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d9019a49b292..56dbbf788d15 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -427,9 +427,10 @@
 			};
 		};
 
-		tsens: thermal-sensor@fc4a8000 {
+		tsens: thermal-sensor@fc4a9000 {
 			compatible = "qcom,msm8974-tsens";
-			reg = <0xfc4a8000 0x2000>;
+			reg = <0xfc4a9000 0x1000>, /* TM */
+			      <0xfc4a8000 0x1000>; /* SROT */
 			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
 			nvmem-cell-names = "calib", "calib_backup";
 			#thermal-sensor-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7b32b8990d62..6a277fce3333 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -761,9 +761,10 @@
 			};
 		};
 
-		tsens: thermal-sensor@4a8000 {
+		tsens: thermal-sensor@4a9000 {
 			compatible = "qcom,msm8916-tsens";
-			reg = <0x4a8000 0x2000>;
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SROT */
 			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
 			nvmem-cell-names = "calib", "calib_sel";
 			#thermal-sensor-cells = <1>;
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 6207d8d92351..478739543bbc 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -21,7 +21,7 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
-#define S0_ST_ADDR		0x1030
+#define STATUS_OFFSET		0x30
 #define SN_ADDR_OFFSET		0x4
 #define SN_ST_TEMP_MASK		0x3ff
 #define CAL_DEGC_PT1		30
@@ -107,8 +107,9 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
 	unsigned int status_reg;
 	int last_temp = 0, ret;
 
-	status_reg = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
+	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;
 	ret = regmap_read(tmdev->map, status_reg, &code);
+
 	if (ret)
 		return ret;
 	last_temp = code & SN_ST_TEMP_MASK;
-- 
2.17.1

