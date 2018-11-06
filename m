Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE88C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDA42086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USwtiE//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDA42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388882AbeKGHfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46494 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388363AbeKGHfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:39 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so4298071ljh.13;
        Tue, 06 Nov 2018 14:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vlwsrV2QyTJUzObVwZ18fp/1TPHYR35WeuoO5dQfamc=;
        b=USwtiE//BMhUzzcJB5mIUCTMoA8lcl6rXTQFauSOHEzI3GD8BRsv/586DTCZxUP1DL
         rVbXlzAxm5HI1MajiuDe0jZrpCE1Jbp0CnP5eT2UXY+rLYcFm48tXYomaH4L1IRrCpWZ
         ihQGxslcNgIb3oxGbuqytN07RPSvJ7emUisgfdAMpsmvzvqCh2M+9M6WMWdFnM2NScVp
         pPu+1/96HF/5lV9PLvsFPWnV2fIkSXfDtKKxnDEHIFr1TjfduPL6WRD2lPA5we1T3tNH
         KxeCDtTNBUkZbK8G/BhKtiEBA+4riWWTgLn9zES6NXdjukeHN1zerN6C6ZnWqlJhT3Ar
         VQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vlwsrV2QyTJUzObVwZ18fp/1TPHYR35WeuoO5dQfamc=;
        b=b59JG32tLlraVTd5PWEkJqdWAYzyRq83/7wxe34V5YR542hzb/9+a0qjnVRNElHLfg
         ndLEXrVQMKXeeYFdwx++uryTOaxdkMr7VyIRJGW+eAZROuW9PAzHHWaDc03rDb5i1YGI
         qJxMBlMqbMhJkvEWHw8+22VtCD9y3gxn++s0LHwmH/94Y9Uvxbd/sFzRJ1PBtl4nHxc3
         bCNfLza/ZPU707h6O8TYD+h2T1LxNfeBc28UXuafsO3NYZ0MXrMRPFP/AICyWdaTWIP3
         j3Wfzy18NQnzhhsYU7ho+i2Qpr+g5PU8eJ6kUhq+DSBttCz0yvjkroj/ruAuDT8n/GvZ
         lTkg==
X-Gm-Message-State: AGRZ1gLrbO6wddL94aihVsv2WM7vuBC/1lyU0eTKJRk5eSF9M0uGL/g4
        G/tdTaURAmWKEfrChLmQPRfTk5QCAJQ=
X-Google-Smtp-Source: AJdET5c7pnnlPMBmKsGdXMYbkSthdkuChPcci2yD0ezIF4IecqS+6+eAC8hRGba/wEt83DqxmCM+Fw==
X-Received: by 2002:a2e:90ca:: with SMTP id o10-v6mr7529010ljg.134.1541542095067;
        Tue, 06 Nov 2018 14:08:15 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:14 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com
Subject: [PATCH 17/24] dt-bindings: aat1290: Add function and color properties
Date:   Tue,  6 Nov 2018 23:07:25 +0100
Message-Id: <1541542052-10081-18-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
---
 Documentation/devicetree/bindings/leds/leds-aat1290.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-aat1290.txt b/Documentation/devicetree/bindings/leds/leds-aat1290.txt
index 85c0c58..baa33d1 100644
--- a/Documentation/devicetree/bindings/leds/leds-aat1290.txt
+++ b/Documentation/devicetree/bindings/leds/leds-aat1290.txt
@@ -32,15 +32,18 @@ Required properties of the LED child node:
                          formula: T = 8.82 * 10^9 * Ct.
 
 Optional properties of the LED child node:
-- label : see Documentation/devicetree/bindings/leds/common.txt
+- function : see Documentation/devicetree/bindings/leds/common.txt
+- color : see Documentation/devicetree/bindings/leds/common.txt
+- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 
 Example (by Ct = 220nF, Rset = 160kohm and exynos4412-trats2 board with
 a switch that allows for routing strobe signal either from the host or from
 the camera sensor):
 
 #include "exynos4412.dtsi"
+#include <dt-bindings/leds/functions.h>
 
-aat1290 {
+led-controller {
 	compatible = "skyworks,aat1290";
 	flen-gpios = <&gpj1 1 GPIO_ACTIVE_HIGH>;
 	enset-gpios = <&gpj1 2 GPIO_ACTIVE_HIGH>;
@@ -50,8 +53,9 @@ aat1290 {
 	pinctrl-1 = <&camera_flash_host>;
 	pinctrl-2 = <&camera_flash_isp>;
 
-	camera_flash: flash-led {
-		label = "aat1290-flash";
+	camera_flash: led {
+		function = LED_FUNCTION_FLASH;
+		color = "white";
 		led-max-microamp = <520833>;
 		flash-max-microamp = <1012500>;
 		flash-max-timeout-us = <1940000>;
-- 
2.1.4

