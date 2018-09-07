Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F681C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366D82086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixA6AAJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366D82086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeIGKNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:13:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37439 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbeIGKNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:13:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id f1-v6so6055345plt.4;
        Thu, 06 Sep 2018 22:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NF2w7lkcmN0Dj5gdrXJ4gvJhzNWHef8gbOxbcRwBN28=;
        b=ixA6AAJ0vCY7LyUP1W6mGFNn2rXOMh3fZoiG2LcccwddD/Sb7nRRNMlAaYN2euyFS3
         A1F8TxXfvm5ySlEq7Hx/yXCQd0HmNiKQaVKv1X3JO97dDpdEMZXLvaSlDbcq6K5hlGOD
         M3TbkivF/a0oHTekFwepnvXCor2U3YbLGrEbHkXPMIDBFOlJHVElZIkttWp7aloNllMv
         BqCi9Y2/LWPWqkL43LTluyzcWRyJPgkuD+kpJ0SLG1Ft2QB1vxBwQsCycok2NE6JG+ni
         6MsBHqrrnjzGPNiyEKKu+lP6dI6Swd5BomrELiyUCn6+TX5cOmK2Pbrys9vgWAyIKF7j
         GMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NF2w7lkcmN0Dj5gdrXJ4gvJhzNWHef8gbOxbcRwBN28=;
        b=rYc14zjsvO15Xs11Gqc0+ljPYlEpQUURO/xq3Rbma89zqT77+ocNFBoIYGC3VZ9f9B
         5TQHqXlrKdLrRiQxhEO3siAxhEj8x1gf9eoeNdFn8dkFT9rWCcQAi7qJaS6/1jkteTB3
         iZhRVya1KNu+sr695b1qLaqzjkOy5emH2D9CzFGLdoZImWh6NgwKShdorzb5Wnyjz5yz
         iXWe7mh6xGNOO/jiLZpCFEKl8+O66MqxHVRxUx2lHlU23bWhG3waEvOFcDlkwev7z3bC
         u61HFnhFrbq4F8Fa9epPoiSTCFpx8Msr5vWyhgq0BnSW5t/dD978MXVcX2QYYTTfkfDq
         UpPA==
X-Gm-Message-State: APzg51AORgEgQq8Yr2//vSCqqyYawSNsjUZ5UojtbcP3/Vsp7yI1zaYB
        A1bbDyJ89QBSsEkkJNU55VA=
X-Google-Smtp-Source: ANB0VdbdvSo07YBSc93Dyz5rWG676RRonSD4DiZ7aXQMx9sc61Nitq4lMnuwzFuJWMxK9OQOEPdohw==
X-Received: by 2002:a17:902:1566:: with SMTP id b35-v6mr6181735plh.135.1536298467756;
        Thu, 06 Sep 2018 22:34:27 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id b203-v6sm9291581pfb.174.2018.09.06.22.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Sep 2018 22:34:27 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4/6] ARM: dts: qcom-msm8974: use named constant for interrupt flag LEVEL HIGH
Date:   Thu,  6 Sep 2018 22:33:12 -0700
Message-Id: <1536298394-5548-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536298394-5548-1-git-send-email-frowand.list@gmail.com>
References: <1536298394-5548-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Cosmetic change of integer value "4" in the third field of the
"interrupts" property to the correct named constant.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 6273b6120be0..c7198900b426 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -445,50 +445,50 @@
 
 			frame@f9021000 {
 				frame-number = <0>;
-				interrupts = <GIC_SPI 8 0x4>,
-					     <GIC_SPI 7 0x4>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0xf9021000 0x1000>,
 				      <0xf9022000 0x1000>;
 			};
 
 			frame@f9023000 {
 				frame-number = <1>;
-				interrupts = <GIC_SPI 9 0x4>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0xf9023000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@f9024000 {
 				frame-number = <2>;
-				interrupts = <GIC_SPI 10 0x4>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0xf9024000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@f9025000 {
 				frame-number = <3>;
-				interrupts = <GIC_SPI 11 0x4>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0xf9025000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@f9026000 {
 				frame-number = <4>;
-				interrupts = <GIC_SPI 12 0x4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0xf9026000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@f9027000 {
 				frame-number = <5>;
-				interrupts = <GIC_SPI 13 0x4>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0xf9027000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@f9028000 {
 				frame-number = <6>;
-				interrupts = <GIC_SPI 14 0x4>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0xf9028000 0x1000>;
 				status = "disabled";
 			};
-- 
Frank Rowand <frank.rowand@sony.com>

