Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BF1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8DB2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8DB2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbeKZIMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:12:13 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35212 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeKZIMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:12:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so15477649qtc.2;
        Sun, 25 Nov 2018 13:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=bMDavPfWrsM8Ixn5Bu+GWFh5dhTnsIk63iyZIoNG/qM=;
        b=YWmV4rFb7kn8C6qt+kP7Pvysc/TZlrPmo2wLjrWZxe0Et462q8y3ecg3/rqhv/PcSi
         T/9oGYgsSr4YwlfcUJPCdQmUtExJfutf0l7xuWKwVErtzE0MuQI+LNVRPLdt4D+lGZdo
         XgOjgASjBHuCUOBrTqHMWsuMN7zoitbz7OLIpYVp0HHuEv5QeqbteI2YdPI/UkzOmUf7
         xcjoxQAoJqkcgT+ZvlEs0PrfvtLDwJlFPjpJ9TuL094H1dNZxKpKZZ2WD/wyzBvA4viT
         1oFjlqR8hbAJy3QvTv51a3vZCBFA8Ga68M17hvxw5pyhARlAhGCkCCKVd6VdeSRc+tVe
         zNgw==
X-Gm-Message-State: AGRZ1gJ/tyogYuFJg41xJvVCRXtRMy/gZhhDf5w3M5te5DOkatlk6TCc
        OoFQnKMTfOLOjUHiFMvC2FyVRRlp
X-Google-Smtp-Source: AJdET5ehrnKYNl92IhKGQXm06BE4lEDzBj7bTgKraracbc8A57IERLFnKl8nlx2UJZ9iRsYTMS7RVA==
X-Received: by 2002:ac8:5392:: with SMTP id x18mr23058268qtp.299.1543180813485;
        Sun, 25 Nov 2018 13:20:13 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id j95sm27438526qtb.74.2018.11.25.13.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:20:12 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:20:07 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Berton <fabio.berton@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 09/13] ARM: dts: rv1108: Assign the proper GPIO clocks
Date:   Sun, 25 Nov 2018 19:19:03 -0200
Message-Id: <20181125211907.9895-9-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not correct to assign the 24MHz clock oscillator to the GPIO
ports.

Fix it by assigning the proper GPIO clocks instead.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 442b749eb2e9..ce5509c4657b 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -562,7 +562,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x20030000 0x100>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO0_PMU>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -575,7 +575,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x10310000 0x100>;
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO1>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -588,7 +588,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x10320000 0x100>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO2>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -601,7 +601,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x10330000 0x100>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO3>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
2.19.1

