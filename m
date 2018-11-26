Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0074C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BB420862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BB420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeK0EaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:30:11 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36879 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0EaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:30:10 -0500
Received: by mail-qk1-f196.google.com with SMTP id 131so12810203qkd.4;
        Mon, 26 Nov 2018 09:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=f9o4rGmK9SY+cN3nCMgonHetVc/q75/sV1ro8QanE5Q=;
        b=Z9fAw1nPCnOzj5BY0Lyk9qP7gpHnfyNzHSWr7SkooJ6DwbERaMjGWp+XQqLYdrcbiD
         mWgpqr9BwQ1dRFdVClqJgB1dfCZyXpOZ6FMTykYlc95HHt1aCzUV+Iqw1B+QH8AvT6mA
         rFsifu/dX55nJcvBG0xnuuAuvhzMVASF1OqVkx/ihoztonyax6T8MgYZ48fakOdidWaf
         P5MKAyAQ8+DoMne9FhprWiCJgNdIlkEiNIuwvtikE8M4tDaC340YTMJu49xJEhZ4IFzF
         aAnbaLGey+4I98iRN7XfbsV6MzMUAAaaxeOW2Pp3XA9KBBQJJsEG3ZOxnJXdlc97UPf+
         HkTA==
X-Gm-Message-State: AA+aEWYtlVKtejcSIVRgjdtK2anMiY+fWrxYAegfxXOEMhlLr5pXOTSK
        jbiNmBHS0Ug3oSA8tN7NQ39/u7qw
X-Google-Smtp-Source: AFSGD/VdJ5V6lRIYlR/1ZpkhRi1yvGSE2HaNhx7xTFOC1H711QsPC76TRYRU3M0YgwprbxwjJ6S1PA==
X-Received: by 2002:a37:ae41:: with SMTP id x62mr24767555qke.354.1543253721827;
        Mon, 26 Nov 2018 09:35:21 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id v57sm695962qtv.80.2018.11.26.09.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 09:35:21 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Mon, 26 Nov 2018 15:35:15 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 2/4] ARM: dts: rockchip: Assign the proper GPIO clocks for rv1108
Date:   Mon, 26 Nov 2018 15:35:04 -0200
Message-Id: <20181126173506.24068-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126173506.24068-1-otavio@ossystems.com.br>
References: <20181126173506.24068-1-otavio@ossystems.com.br>
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
Tested-by: Fabio Berton <fabio.berton@ossystems.com.br>
---

Changes in v2:
- fixup commit signed-off-by
- fixup commit log

 arch/arm/boot/dts/rv1108.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 611f2fe8e56c..300de8e1475b 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -565,7 +565,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x20030000 0x100>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO0_PMU>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -578,7 +578,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x10310000 0x100>;
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO1>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -591,7 +591,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x10320000 0x100>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO2>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -604,7 +604,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x10330000 0x100>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
+			clocks = <&cru PCLK_GPIO3>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
2.19.2

