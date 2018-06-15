Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A2827C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572FF208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAdb/DD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572FF208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965866AbeFONma (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:42:30 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41032 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936251AbeFONm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:42:27 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so9966810wrq.8;
        Fri, 15 Jun 2018 06:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mK8rbkkSjdUw4bWGYeXhoUYY1D03LPWDK5J5Kn2RXjA=;
        b=lAdb/DD2vs6YwTKrlLB/QOA52TjmXxKfRulb6BYSYyF/BLqzJsVleLz3ceaBd6kNup
         l+0aUjeFHRFSTGTppQp6Loi2lNH+5JScM42aFFqRYwV7OPm6VdRJy62CJxP4Q1mVpNmN
         bIWskyWg0tiReDzCrieIIgNaXRPL75hvSgguxiA7UIr88ARtwkeLx6pcu56R+vYcCE/c
         rYHPWz55ZFjufmrf1WN16xTtEvtoabOvFzV2HYGp+6MX9w94rX1m0K9DULyBoEGRhSxN
         1N8jB32DhnVueOYNAqLhVW3BYJHIpZQOdnAgB3tzfRC6lfpppuSRbuFBcjamGSEkGIUr
         91cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=mK8rbkkSjdUw4bWGYeXhoUYY1D03LPWDK5J5Kn2RXjA=;
        b=XOprcSX+X96uwPjwULTKsaR2qEdNYlrYBKxGtky8aqM/rHPHi6SN9AVklryy8aOp3R
         oUM475D79l0rrdOSDWoGA/zCPGVKoqIJAl00BJ8pz48ur4uB00fz7BrcNZHCtTzX07tK
         7UmA5Rl6kpcaI3AH1wEXq0yijOAnXg9Ouv2NT5Oput8sDScyPcq2EkVxaEgb+248svji
         T5jTOCeWf+weBLwnI1hgcHGnzeEdKyZ7r2uECYMAhWCtCTViNHrW2UxxoHOER/jV7+M4
         kAwKZ6dZzZdmI0roFkAuJTvcV6+aZ2UhMjBGVy2dQRbB9z0DX/QXQ/lNI9HeoeS0FHl6
         C//w==
X-Gm-Message-State: APt69E0O6RyI3djFU5K53WsWIK1H2DkixrRvKGRTWw8cE1i/b1MCqXsn
        GGeOTWC8xjerrEmIDYDTsZoNMJATpIo=
X-Google-Smtp-Source: ADUXVKK15mKyECoLQcLdFP4X2wKIW82G/Wlj/zJt2mCraFWiOCRjnyLO7kj+I3daooupgeOFnWtplg==
X-Received: by 2002:adf:ca03:: with SMTP id o3-v6mr1745474wrh.148.1529070146260;
        Fri, 15 Jun 2018 06:42:26 -0700 (PDT)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id d5-v6sm9816346wrp.64.2018.06.15.06.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jun 2018 06:42:25 -0700 (PDT)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com,
        Ben Whitten <ben.whitten@lairdtech.com>
Subject: [PATCH v2 2/6] arm: dts: at91: add labels to soc dtsi for derivative boards
Date:   Fri, 15 Jun 2018 14:40:51 +0100
Message-Id: <1529070055-18701-2-git-send-email-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
References: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds labels to commonly used device-tree nodes so that derivative
boards can avoid ahb/apb hierarchy.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi | 8 ++++----
 arch/arm/boot/dts/sama5d3.dtsi    | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index a3c3c31..11c0ef1 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -389,13 +389,13 @@
 				};
 			};
 
-			rstc@fffffe00 {
+			reset_controller: rstc@fffffe00 {
 				compatible = "atmel,at91sam9g45-rstc";
 				reg = <0xfffffe00 0x10>;
 				clocks = <&clk32k>;
 			};
 
-			shdwc@fffffe10 {
+			shutdown_controller: shdwc@fffffe10 {
 				compatible = "atmel,at91sam9x5-shdwc";
 				reg = <0xfffffe10 0x10>;
 				clocks = <&clk32k>;
@@ -470,7 +470,7 @@
 				clock-names = "dma_clk";
 			};
 
-			pinctrl@fffff400 {
+			pinctrl: pinctrl@fffff400 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
@@ -1206,7 +1206,7 @@
 				};
 			};
 
-			watchdog@fffffe40 {
+			watchdog: watchdog@fffffe40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffe40 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index eae5e1e..1408fa4 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -494,7 +494,7 @@
 				atmel,external-irqs = <47>;
 			};
 
-			pinctrl@fffff200 {
+			pinctrl: pinctrl@fffff200 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "atmel,sama5d3-pinctrl", "atmel,at91sam9x5-pinctrl", "simple-bus";
@@ -1340,13 +1340,13 @@
 				};
 			};
 
-			rstc@fffffe00 {
+			reset_controller: rstc@fffffe00 {
 				compatible = "atmel,sama5d3-rstc", "atmel,at91sam9g45-rstc";
 				reg = <0xfffffe00 0x10>;
 				clocks = <&clk32k>;
 			};
 
-			shutdown-controller@fffffe10 {
+			shutdown_controller: shutdown-controller@fffffe10 {
 				compatible = "atmel,at91sam9x5-shdwc";
 				reg = <0xfffffe10 0x10>;
 				clocks = <&clk32k>;
@@ -1359,7 +1359,7 @@
 				clocks = <&mck>;
 			};
 
-			watchdog@fffffe40 {
+			watchdog: watchdog@fffffe40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffe40 0x10>;
 				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 7>;
-- 
2.7.4

