Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CC6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6EF217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="ZBid+p+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfBSNDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:03:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37389 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfBSNDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:03:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so2700469wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 05:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=UX76xod9X+zXCg7JKouCVEpytXUP9Ng1RnH772L+OKo=;
        b=ZBid+p+Keiv1SBhQaOn8qUYKQgVxy3Fveba6NMdztq2HEafBcXQYOo9OG/I9R2ULh2
         TwnE4b/uZsuquiGvAs0vkPDd62yB5sBICb0u5fBNJBY3yndChDFCDcPDwWBCvteGtayg
         7F2ChnaoJUc4HjMzQP+B6ewxWsvp7FaLlwO22vFvJZdR+QkZmNWVIHIQh4+c62fuRdhp
         1znFuG2Yybp3Zxght3tfogtc3hQ3rjF05O3f2VP3eYscqkoTTIfIXlTg3qgqyTXhmcen
         JgTB3bWtjKLTc48K3q5oaZLEEvK3vBYtxlLdkLZfHk1We5XnLJd5FXC6pLIFs2C0937r
         xhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=UX76xod9X+zXCg7JKouCVEpytXUP9Ng1RnH772L+OKo=;
        b=h9TbsRcasejrznw9UET+b5JsXd8C2TkW3NNt86Q9yuKUb5NFG6ZNV32UlTGFMTpEXJ
         H75fudlq8gPqHLUq+6APrP2Kq+EN0w+muugIwQ1Tl8Yi8vMBPEGNa2PTwaNUCU7vOi59
         tAPPf/1vHpYilsyKA6Vgi+MOhAuYwUwwIldN6h/5t4jP4OvTGyZq8qa+g5V0WYYqu6ZU
         /Yv3VNoMdWkk2haOrO6GVmLZxVb/eg5nXuWvqQhSe/uROlTf0YEYNFbtids9MHECmAlB
         H1oEZEScandyhVN8ldi3h4/PCHyfVghOg10MgQgmNPl5whGXL7oBETxjXoDayLZo2axH
         GS+Q==
X-Gm-Message-State: AHQUAuY3DydaEmcF22nyMo9zZFyWlAbrjHe9gupfYfg5+RelCpPIpJdl
        jj7Ueq7ax0Oag5FB+3mlqw+gGQ==
X-Google-Smtp-Source: AHgI3Ibw7pREYmcgsu239XRSfhXs9H2h3akRczM2hHgfUTLKr0xB1Ta3pR8R8KyKejopILO1Mee0KA==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr2878403wmd.36.1550581421445;
        Tue, 19 Feb 2019 05:03:41 -0800 (PST)
Received: from diamond.mathembedded.com (host86-137-106-133.range86-137.btcentralplus.com. [86.137.106.133])
        by smtp.gmail.com with ESMTPSA id y22sm61899811wrd.45.2019.02.19.05.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 05:03:40 -0800 (PST)
From:   Stuart Menefy <stuart.menefy@mathembedded.com>
X-Google-Original-From: Stuart Menefy <stuart@menefy.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ARM: dts: exynos: Use bustop PLL as the source for MMC clocks on Exynos5260
Date:   Tue, 19 Feb 2019 13:03:34 +0000
Message-Id: <20190219130337.21353-2-stuart@menefy.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190219130337.21353-1-stuart@menefy.org>
References: <20190219130337.21353-1-stuart@menefy.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Menefy <stuart.menefy@mathembedded.com>

By default the MMC clock will be derived from mediatop PLL, which
usually runs at 666MHz. However as most SD and MMC clocks are multiples
or fractions of 100MHz, it makes more sense to use the bustop PLL
which runs at 800MHz. This matches the behaviour of the Samsung vendor
supplied 3.4 kernel.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 arch/arm/boot/dts/exynos5260.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 55167850619c..14b423de9137 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -288,6 +288,14 @@
 			#size-cells = <0>;
 			clocks = <&clock_fsys FSYS_CLK_MMC0>, <&clock_top TOP_SCLK_MMC0>;
 			clock-names = "biu", "ciu";
+			assigned-clocks =
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC0_SDCLKIN_A>,
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC0_SDCLKIN_B>,
+				<&clock_top TOP_SCLK_MMC0>;
+			assigned-clock-parents =
+				<&clock_top TOP_MOUT_BUSTOP_PLL_USER>,
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC0_SDCLKIN_A>;
+			assigned-clock-rates = <0>, <0>, <800000000>;
 			fifo-depth = <64>;
 			status = "disabled";
 		};
@@ -300,6 +308,14 @@
 			#size-cells = <0>;
 			clocks = <&clock_fsys FSYS_CLK_MMC1>, <&clock_top TOP_SCLK_MMC1>;
 			clock-names = "biu", "ciu";
+			assigned-clocks =
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC1_SDCLKIN_A>,
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC1_SDCLKIN_B>,
+				<&clock_top TOP_SCLK_MMC1>;
+			assigned-clock-parents =
+				<&clock_top TOP_MOUT_BUSTOP_PLL_USER>,
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC1_SDCLKIN_A>;
+			assigned-clock-rates = <0>, <0>, <800000000>;
 			fifo-depth = <64>;
 			status = "disabled";
 		};
@@ -312,6 +328,14 @@
 			#size-cells = <0>;
 			clocks = <&clock_fsys FSYS_CLK_MMC2>, <&clock_top TOP_SCLK_MMC2>;
 			clock-names = "biu", "ciu";
+			assigned-clocks =
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC2_SDCLKIN_A>,
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC2_SDCLKIN_B>,
+				<&clock_top TOP_SCLK_MMC2>;
+			assigned-clock-parents =
+				<&clock_top TOP_MOUT_BUSTOP_PLL_USER>,
+				<&clock_top TOP_MOUT_SCLK_FSYS_MMC2_SDCLKIN_A>;
+			assigned-clock-rates = <0>, <0>, <800000000>;
 			fifo-depth = <64>;
 			status = "disabled";
 		};
-- 
2.13.6

