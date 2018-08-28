Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4849DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0108420896
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yew3n8Ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0108420896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeH1Ra4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:30:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43788 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeH1Raz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:30:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id z27-v6so1388581edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vK3Xq6Eo3yCkWAfwmDTLmFy/t/g3sd/X8elMxmYhDlM=;
        b=Yew3n8ExQpnQjKb/LcetgzYblhrSMXaG4ql66N0bu7gzDEEcJVWJdZyTav/B2aTdJh
         qmdt1eiNzUmtj980MIxgCoBF2iqcORWA9EcFzd5Oo0fhqi2l2zRcfGVdgj0Qed0yRfpI
         KOf4NEsscA+m+BoIkeVna4Z/KA6W5YNYx55lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vK3Xq6Eo3yCkWAfwmDTLmFy/t/g3sd/X8elMxmYhDlM=;
        b=EaP7UOgs1t+FUC74Mqtj+YoUjH/VrUekCqSThV0d+OM8ouBwy1xfQQz4ufLE60v+At
         7kYa+HIeDGTLlvB49PORltw+IcFmgJtm5Ili2rBOR4/Eh/0od1eqlTrLhQsBr707WZCr
         xN75YIGDX116yIZCdtT3O+npXEM0EWROSJtFf6kbFku34sOr4WS1NufvsoBgMJQG4SWd
         3i2+A2D39o9EKCfKV5/uM3IGqywoosNfV4BJF2+YzqqmDXcK5TYoKAwgO5I1pf7jnopO
         btOqp33dQtAz4jAUUXdv1ADWzyCzZfMq4gnLMcGG+tX0eMr60Atz6akbr/Z4X/ql7yUa
         eiyQ==
X-Gm-Message-State: APzg51Bg/k+5AYqqodRIdY65PECzarjtuoYXxlanrtZPVnYndz6vBMl0
        xu6AD/TD/gsA5TUxXKcLWkMdTzyCYcw=
X-Google-Smtp-Source: ANB0VdZBmEhxKcTdj7oIOmL6ggySMWVpK/2s8he1ekI7bLta/n7Vv5tOGFQnNpDtSV2UHdTmbBzAaQ==
X-Received: by 2002:a50:9e2f:: with SMTP id z44-v6mr2516451ede.242.1535463551706;
        Tue, 28 Aug 2018 06:39:11 -0700 (PDT)
Received: from localhost ([49.248.200.109])
        by smtp.gmail.com with ESMTPSA id k33-v6sm605087edb.31.2018.08.28.06.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 06:39:11 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 02/11] arm/arm64: dts: msm8974/msm8916: thermal: Add "qcom,sensors" property
Date:   Tue, 28 Aug 2018 19:08:31 +0530
Message-Id: <e894c837385b6a2e120eddb779a359bb08b7c847.1535462942.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new property allows the number of sensors to be configured from DT
instead of being hardcoded in platform data. Use it.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi   | 1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 56dbbf788d15..3c4b81c29798 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -433,6 +433,7 @@
 			      <0xfc4a8000 0x1000>; /* SROT */
 			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
 			nvmem-cell-names = "calib", "calib_backup";
+			#qcom,sensors = <11>;
 			#thermal-sensor-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 6a277fce3333..be27d8dc9e6b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -767,6 +767,7 @@
 			      <0x4a8000 0x1000>; /* SROT */
 			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
 			nvmem-cell-names = "calib", "calib_sel";
+			#qcom,sensors = <5>;
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

