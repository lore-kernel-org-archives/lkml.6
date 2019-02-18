Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8986C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A71F21773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s9cgG6UN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfBRMf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:35:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37629 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbfBRMf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:35:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id c8so18168894wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8W36gyptsb6IsQFqhC2cFgxce+VUuRSodxyYFDnxhiE=;
        b=s9cgG6UNA993nmeX6ukOj6Icus3ZWKhIqEPmdbaUwMbHuQABXup+jvC2a3rGKXzpZf
         b3JfrFMzRaJbr6owH+j76bgROC2HnDhKrQmo+x1qlhgt2m2u81Zt8mUGad0wp5XR+Vvf
         YavEBQDRRjCaFb3bzF0tpkbLnnKsCZeHdoxRUA/XuKhdaPftFaZYcsxEaAt0m5F5JO3+
         RnMaqZp3Kd+jbgKuCIxMHr7o0YnTG8OCFe4A/zZ5OO7aks/r2UJZPgjzihJDrZ/oSg32
         72F0cP27DzYiM7T9IcMtYMygizXccoikS/uxyDhcIcK2igizSAgeeWkanU+0hgAwvoc5
         7c6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8W36gyptsb6IsQFqhC2cFgxce+VUuRSodxyYFDnxhiE=;
        b=CR4iP8yVgQA6t21VUIkUFkRqjSVYkobEiUUYRrcbxXI6t0HgSMsdy/WxaODX95gISc
         //CuZ0TOaMUa+rRgk5SxEixnWDqJ1l3/wKqhsR/XSgUa6ybtTntPrwYRGJJ/NsbL6a+X
         z+ItwPuP2Mnkx3IXb6d5EqrrReIKd3HRhw+7luHrmP/TEcSNxS6Xl6MzU6pR81G82JLj
         K+/WF9Dm1uWT/NxdTFUP7ozfBFuPgM3MPAsfRKuNqEXbKoESHftGRxB5Widl2V25sm+p
         PulqixYxgo3H7ZyhXYGNChaqNdP8mk2pRngwY31glRZxX/n7F92rJ+v7ibVaDU1lRuc6
         YWIA==
X-Gm-Message-State: AHQUAuZeOF7ySbI9hNIke2oyXUtvi/LtpdnScI0xc/yBoRVeuRCDu9hS
        VjMJp8mKZ3rMTcuyNH2mqnI/Xm0XRow=
X-Google-Smtp-Source: AHgI3IYMW+SlD1jxCuRfYI9zMvksJTSVrjYLHfgsPX1AwGDZ3kqYmH/rYa/hEYf7kbmA8b0SPLKdBQ==
X-Received: by 2002:a5d:6b07:: with SMTP id v7mr4704012wrw.314.1550493354840;
        Mon, 18 Feb 2019 04:35:54 -0800 (PST)
Received: from localhost ([49.248.190.152])
        by smtp.gmail.com with ESMTPSA id n6sm10328481wmk.9.2019.02.18.04.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 04:35:54 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 03/12] arm64: dts: msm8916: thermal: Add sensor for modem
Date:   Mon, 18 Feb 2019 18:05:17 +0530
Message-Id: <b7a640640775f91956baebbd37a36201f93b78f8.1550493113.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms that have a modem, sensor 0 monitors the modem.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9e598ab438a1..9e4a82e5e0b4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -278,7 +278,13 @@
 					type = "critical";
 				};
 			};
+		};
+
+		modem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
 
+			thermal-sensors = <&tsens 0>;
 		};
 
 	};
-- 
2.17.1

