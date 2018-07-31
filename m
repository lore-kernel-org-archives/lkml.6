Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71792C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F944208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvaX+Z7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F944208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeGaLC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:02:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51301 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbeGaLC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:02:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so2277572wma.1;
        Tue, 31 Jul 2018 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OtYgKa+K50AQZfnpyutr+8LrA0LyCrJnQ5OCEVm96d8=;
        b=cvaX+Z7vN+DJ8smB48LMyO1ZFV8GbLxS+XhVsOY5HroCwHobyNVnL9eobxkm2etdUi
         eWFztZniJW9ThMAHhybEGbjeU/xYzYhPjnQI6K/8jU3ELdQDS7lUj/tALP6bu2krU6ip
         ncv19Dy0jsa0r08L692AS++fIkPE1g+zP7AuaOBAZBfarCxRkwTujNh7c/rEIQvwaKjn
         +B30h0BeYKvc5TMZrR1meooJoHnCQdV0PKJwAiCZ4Q1TSuXmGeYk56VzXEN6g9CvadIE
         +oGm2a38oALzGuH7/fHnraq19hNa+SFMCLIc0nc40Sv9G/NEHMcuJlgzcN0m1jx5FsAO
         PbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OtYgKa+K50AQZfnpyutr+8LrA0LyCrJnQ5OCEVm96d8=;
        b=pganvtyc1wpbH0bn+2Rs8Rk8SNsJdLRpoWayGPad33U0i2bkDvuRQ0ktGFzOH58qBt
         VEscYuu02ltt0EfPWBugM0DdpVmQfBMUE2giP8MNAOEvFB5VTFNSxZ9wSuNciGpaE0XO
         +lZun36cGKxOtJwk+IJwqkPPsXoGDAHfurH+Mj4zSLQ7Uf4UNFtl+k0ELwDaeQ4g/W/w
         5wetTAjr0LrkM43lE59vknYNMJsn5THZz/TNoQA90MQHIchLuYtf+uku1gkCjWG16ft9
         FiERcFgrhtHE11HZW1JO18J0wt5IaH1RN2FH050CIufztfPfGf24axvrliB167PPF/jw
         qsLg==
X-Gm-Message-State: AOUpUlEZQmNwKT15fuotuSZPKC8aeRDwu21UpFKCbSPmLDXZv6qSoPTc
        ppDKZXG2W5Pa+Pk9lsCONIs=
X-Google-Smtp-Source: AAOMgpf5Ej8m9eOXrLeWlx3p63JYJy7xX8AISmirSPM6LZ2JHGB069ybu+kzvvr9pdvd9tmSsXsJ5w==
X-Received: by 2002:a1c:8b81:: with SMTP id n123-v6mr1694098wmd.142.1533028981681;
        Tue, 31 Jul 2018 02:23:01 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id y191-v6sm1670873wmy.4.2018.07.31.02.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 02:23:01 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux@armlinux.org.uk, sean@mess.org, p.zabel@pengutronix.de,
        andi.shyti@samsung.com
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v6 2/4] ARM: dts: sun8i: a83t: Add support for the cir interface
Date:   Tue, 31 Jul 2018 11:22:56 +0200
Message-Id: <20180731092258.2279-3-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180731092258.2279-1-embed3d@gmail.com>
References: <20180731092258.2279-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cir interface is like on the H3 located at 0x01f02000 and is exactly
the same. This patch adds support for the ir interface on the A83T.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index afed6c0dea6f..31222a05a8f1 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -992,6 +992,18 @@
 			reg = <0x1f01c00 0x400>;
 		};
 
+		r_cir: ir@1f02000 {
+			compatible = "allwinner,sun5i-a13-ir";
+			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
+			clock-names = "apb", "ir";
+			resets = <&r_ccu RST_APB0_IR>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x01f02000 0x400>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_cir_pin>;
+			status = "disabled";
+		};
+
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun8i-a83t-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-- 
2.11.0

