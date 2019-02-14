Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62085C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D905222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp3DN4br"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407005AbfBNNJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:09:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35424 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406993AbfBNNJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:09:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id z15so3108571pfa.2;
        Thu, 14 Feb 2019 05:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0v9wVQ3xaGBLf3TQlCnHEwdgsZp+XVStp3m7EDnD+N8=;
        b=Jp3DN4brMf4mZx4wDp3V4QNwlJvaOnGrID+tjX5gtyZlibgtU/rEPVD2L06mULeqpQ
         7vEs4MaEizzqu3pwPD8pDKVAtFDCrZymkUAW24gBhdIkdCWqsMKfkWaTvgc+UOd9JiKR
         2bMPoSGuqpzitElBDZiRmkwKOerBTXbeFg7ItSCEQLS5/jf/lZyQs1we3s2SmCFHS71S
         PZEYRQzKQfGuMeWjfj4d34MvWJKZahtrRKKTmi6n29QPPckcmd+AAOlDIni1LCKLPwdX
         b2G9ksplq3AOKman6glzXuecP7LFleexwpJbhqVUJ4iozuN4SirsRYjzyx1DwKa4/MJ0
         +dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0v9wVQ3xaGBLf3TQlCnHEwdgsZp+XVStp3m7EDnD+N8=;
        b=Rvn5g2eK0kc9xQvkbBtsWEkyYo7CTiRW8SL5tGnGMqYb30jIFLP70+ZEfaNWrfyYZq
         y3UYzi4Sj68MVSdkyGXdof2IWxQYBqXA0iPFy6fbs8xyvGZbcMdN7jJnq1D/c7zIe4RO
         9wPjgYiSfrA1pR3oW2nt6v4YeIykuvNUtD3y2TzU4yZ9tLWkvCsIY4a2owRRJkIkDj/j
         XrBn5w9s+PlI3p/hsW1z9Yp3YpV9lUUEYOIni7XzNsH0ppuyfj6idIGEeH2qaEkm1Oi4
         5A1R7N9jbolRiTYhDbXvqwApS9dVUI1n9OKaQi0FMUGqk46oMsneE3bKjLa4koNsqQ8p
         xpJg==
X-Gm-Message-State: AHQUAuaiR9bhOdbyKQZesDcRQrUzGEM34YOjNDH2/POgtUKQgU17fNVn
        hYL5CqD+jGhYMleQYo/P8u0=
X-Google-Smtp-Source: AHgI3IZFbl5j8qM5LeBkq0v6BKUCQd5a5Q9vNWiXIvgGz1wlVK2PenecD63p/+Y1tRe97hHC+bi89w==
X-Received: by 2002:a65:6549:: with SMTP id a9mr3598261pgw.21.1550149762462;
        Thu, 14 Feb 2019 05:09:22 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id u2sm2999992pfh.134.2019.02.14.05.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 05:09:21 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/4] arm64: dts: allwinner: h6: orangepi: Add CPU supply regulator
Date:   Thu, 14 Feb 2019 08:09:07 -0500
Message-Id: <20190214130910.9201-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190214130910.9201-1-tiny.windzz@gmail.com>
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original orangepi use the dcdca to supply the CPU cores. According
to the axp805 spec, the range of dcdca is 0.6 to 1.1v, 1.12 to 1.52v.
In order to support more CPU frequency, slightly increase the voltage
maximum and minimum.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index b2526dac2fcf..e7aebaf91ede 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -159,8 +159,8 @@
 
 			reg_dcdca: dcdca {
 				regulator-always-on;
-				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -191,6 +191,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.0

