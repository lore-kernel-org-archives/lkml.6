Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44062C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146D920823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="k1r0V9pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfBSNDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:03:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38258 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbfBSNDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:03:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so2723871wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 05:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=EertYF60nStrNT1pM/X5LNwETvlDNxIyb8iUT32CCOc=;
        b=k1r0V9pzqPf1k7YkvK+Mnc+vNjIU1GBIaNunGV37gSaX1P4AMXW+Icvikk/vHx3AWu
         NJntWhXNfJAbuRhVzVg5M+ANzfcWhGKhJHxRAebEU/omqNK4wFjXlntQhtU+e5VY/4vN
         Mq9WdeweQ4bCjC81ClZ4i6d77vsxhvqleBjcHTJwlDlUszPqmzCcw8dPE4v974PGqVTg
         uLhQEkTxOB7AV3DhnPKlKkROcIjMdIkjebk+CMuLorzGkEMa4a94jpQ7UV3z+g3+JfGZ
         TN7RGNmf5UHd9q7Rb3LqXM7UlQOBMNeEgQTqLY2SCK5py/yXAeM91R4QUDU3NcGldrV3
         ZvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=EertYF60nStrNT1pM/X5LNwETvlDNxIyb8iUT32CCOc=;
        b=CYU3ZM4UmyhMh41xnsDBYJN5ALhKcQYMq/EIO28M8YPRmaI8eTxyR6mT5JlELt13zm
         brJoZsipA8T847AfwempMQ7K2k/1LBWveT1zrrEx0FQcdcbCNsly/gcF10UARZrx9GRc
         nl8bKcmGoWZ0rHGzk81idP/mv+c+sqJ6CGe7oRX4BRekEIGGrbdHfzKI+JCh0M4OtJ+Q
         lBfKZIiYQCrbiEmsQWRhHuHwqjMyjcZehvPtNPXNxbayp2qnGC7BvcupkOl1cqaPUQWc
         VC4j5O4TsqVJwCQKImZ295gddpgEbLB2oGLP155FM24xl9fifxQvWPfWbX/9ZUoCRnXH
         wMbw==
X-Gm-Message-State: AHQUAubYiVycVL0LonF7TDJaBFwYWMZ4ilMtn+PcHXizgu9ChF7x0aVb
        aDTYJ018XzToZPLXFgYFzedj7A==
X-Google-Smtp-Source: AHgI3IahmvczfF6HiUC5cZZcrTMX3conJgIDIOKJ6IdgWS6h591ZBz0sh6VnyCcCDLAG9Vi5S8HNOg==
X-Received: by 2002:a1c:99c3:: with SMTP id b186mr2738670wme.79.1550581424034;
        Tue, 19 Feb 2019 05:03:44 -0800 (PST)
Received: from diamond.mathembedded.com (host86-137-106-133.range86-137.btcentralplus.com. [86.137.106.133])
        by smtp.gmail.com with ESMTPSA id y22sm61899811wrd.45.2019.02.19.05.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 05:03:43 -0800 (PST)
From:   Stuart Menefy <stuart.menefy@mathembedded.com>
X-Google-Original-From: Stuart Menefy <stuart@menefy.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ARM: dts: exynos: Add interrupts for dedicated EINTs on Exynos5260
Date:   Tue, 19 Feb 2019 13:03:36 +0000
Message-Id: <20190219130337.21353-4-stuart@menefy.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190219130337.21353-1-stuart@menefy.org>
References: <20190219130337.21353-1-stuart@menefy.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Menefy <stuart.menefy@mathembedded.com>

Add the missing interrupt information for the GPIO lines with
dedicated EINT interrupts.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
index b1edb20b789e..17e2f3e0d71e 100644
--- a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
@@ -153,6 +153,14 @@
 		#gpio-cells = <2>;
 
 		interrupt-controller;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <2>;
 	};
 
@@ -161,6 +169,14 @@
 		#gpio-cells = <2>;
 
 		interrupt-controller;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <2>;
 	};
 
-- 
2.13.6

