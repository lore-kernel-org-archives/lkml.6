Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18CCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9126420823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="bQBLGMry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfBSNDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:03:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41535 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbfBSNDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:03:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id n2so9722215wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 05:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ib3nWTzMlMvOHJNOPsg7HqLqSUd8Q6N9xMvPHRojwVU=;
        b=bQBLGMryGLAb2PDgTNx/wOurFGL8n9JNoeUl/0J8cuctXc+PK7zN8udi6OsLJ++yAQ
         wyj59U8dx2ZjJ1Ra6Bcgo5UD+LCJRj6x4LNMW8fXz1JAI0B9wrnNbWBUhUd6wxA6F1w2
         dYqVzJvF3xFMSlqx82ToEjNy140T40QitHA/smdTu3ZgIQ4fFxD1KwchRKyEBIhmVuTa
         z7/J/YK8mStOt22l8tFXf6Wy/bUdjsOYMcNLmb8BixVqp4xT1n+kVovM616SAFhgQixT
         JLjNTcAt3rPvXvxvpSjWwm/2egYRc17vS4/QtF7bViCgeeiTSXRnFwugb/xsDWTn/+Ev
         1Drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ib3nWTzMlMvOHJNOPsg7HqLqSUd8Q6N9xMvPHRojwVU=;
        b=ZotZaR/eJV5nA+10TqlJAa85SmItrNLbhHWB6OOJiZ6dwGyF9coM3x15aBCOJReiZf
         DpPuL87/vBgOvNstXs0XSp9BBDij/AqAjs5sRHRqK37EuylO1TToYq3YdlfGclGR6X2/
         8saZYpcPhfZsVRKRvb48mt7GU7y6jtkT+0t7XOXFhqyUVKxpqnqxhMlu3T4PJISFAm8u
         omlAMsJXU+bw/IsaYFbP5fz3SLSDCDmkgIBdA+6/GOjHxMStFjI/lLYpGZxjZs6MI7Sv
         x2Py0MzBM5IdgQGX/Dp12hUwS7dk/ICGFAiVTZ4ubToY1zFgDatikRqCb+pbaKCFxZDj
         5apQ==
X-Gm-Message-State: AHQUAuY6HB7quEN1aMrZUQNeSBxx+2BsJnZ1bDjsS5TrlzYccoVjWUpv
        Z2/8yzwMrk8XhFE7rl1FnXLEaQ==
X-Google-Smtp-Source: AHgI3IbwmjRNZn7bwTYAg0gBYMFuvwAwGyPrmZu6O37VDNX/OrDqL2+7iXonCx7pQ6GfSTKylZsNdA==
X-Received: by 2002:adf:b741:: with SMTP id n1mr19971800wre.287.1550581425138;
        Tue, 19 Feb 2019 05:03:45 -0800 (PST)
Received: from diamond.mathembedded.com (host86-137-106-133.range86-137.btcentralplus.com. [86.137.106.133])
        by smtp.gmail.com with ESMTPSA id y22sm61899811wrd.45.2019.02.19.05.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 05:03:44 -0800 (PST)
From:   Stuart Menefy <stuart.menefy@mathembedded.com>
X-Google-Original-From: Stuart Menefy <stuart@menefy.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: dts: exynos: Fix interrupt for shared EINTs on Exynos5260
Date:   Tue, 19 Feb 2019 13:03:37 +0000
Message-Id: <20190219130337.21353-5-stuart@menefy.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190219130337.21353-1-stuart@menefy.org>
References: <20190219130337.21353-1-stuart@menefy.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Menefy <stuart.menefy@mathembedded.com>

Fix the interrupt information for the GPIO lines with a shared EINT
interrupt.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 arch/arm/boot/dts/exynos5260.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index a8c7c6e589a0..3581b57fbbf7 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -227,7 +227,7 @@
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
 				interrupt-parent = <&gic>;
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
-- 
2.13.6

