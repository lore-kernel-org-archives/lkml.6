Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C964C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1982D218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJ+BplgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfAYXaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:30:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45360 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfAYXaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:30:21 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so5406950pfd.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 15:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=z1uWH6I0nZowoTNaFlOfXGRpKzB/gPii7k1lB+g0+68=;
        b=VJ+BplgASYIcbilTnKMJbsjtD1L57r2y7RirzEDyb1StYZFQXu1XgT63/T6KlW7J1Z
         g9g5rqM6MXz1D89UU7SdiIFbrhkn7aiM2D+8dd035bD/7uWeAiwjbw07xoKuGUiIZkEZ
         +bv/yjlRPLG0lTAPZ8gHqsW9uwiEkVfNDf+Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z1uWH6I0nZowoTNaFlOfXGRpKzB/gPii7k1lB+g0+68=;
        b=bpv1HHJGDhssUtqgQjUEaatxbHd+XhBbjM34KANIq/w3Dg0SnZ5/S4kpN7Srfo4O72
         P1abooiNMMdCBgOSFRC5FVvW2qHAk223DWQETuZ8kEmzVzzMc4vg8MQM2kyGlcQP95aK
         qf901V9JXKlJCHfa0/AwUdDVp0idkGsv//vjjvSdKk/JLGmlaUmfrxJ9IMciPZhuVUON
         c6cDdYkgsDgTsV6CXCIjeN0dqDVRAEpJtYvpbisaS7v4ozpp4SZxlXKDnw1c6k13HvLH
         X2+fnWpe+UhLzkOTsNTDINGDS4mYoGh/c1//7F/vfrZpWwpniCELu9BT9VLYynhvl+H9
         TCHg==
X-Gm-Message-State: AJcUukciPic58E9KmqXWz4aj+Jb2e4FtKmF+ldxLCERLfzcx4tMiYXX4
        6OWe6W/IJSTwt68e2fKHmbEdFA==
X-Google-Smtp-Source: ALg8bN4Bt7aJ8vgkd8h90FcwIbPncgdoIbcAwRJswT79Be79cqp2FW1VQ20hWJJcoLCWRkahP0PAbQ==
X-Received: by 2002:a62:6204:: with SMTP id w4mr13010106pfb.5.1548459020374;
        Fri, 25 Jan 2019 15:30:20 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p2sm34822280pfp.125.2019.01.25.15.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:30:19 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH] arm64: dts: qcs404: evb: Fix voltages for s5 and l3
Date:   Fri, 25 Jan 2019 15:29:54 -0800
Message-Id: <20190125232954.26166-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMS405 S5 was upstreamed without a voltage and PMS405 L3 is outside the
acceptable range, causing PCIe to fail. Fix these.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 579ddaf4f5fa..072061aa1b79 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -72,8 +72,8 @@
 		};
 
 		vreg_s5_1p35: s5 {
-			regulator-min-microvolt = <>;
-			regulator-max-microvolt = <>;
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
 		};
 
 		vreg_l1_1p3: l1 {
@@ -87,7 +87,7 @@
 		};
 
 		vreg_l3_1p05: l3 {
-			regulator-min-microvolt = <976000>;
+			regulator-min-microvolt = <1050000>;
 			regulator-max-microvolt = <1160000>;
 		};
 
-- 
2.18.0

