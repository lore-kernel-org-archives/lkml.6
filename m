Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21CEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5BA208AC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMwKxkUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5BA208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389116AbeHALdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:33:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55936 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388952AbeHALdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:33:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so6230533wmc.5;
        Wed, 01 Aug 2018 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GUllKO7wb5633n+/K3RfTcqZ//tFOo/xk+5N63G4iMw=;
        b=kMwKxkUK2yM3Qc1StxW+P76dBgn+gg0BhXT2znbLqF1PuJYMPhtgm6nc4lzh84bHtI
         SJwsUakU83sePe+fmc4nd9FrEBgyQ+TYRx6lXwr7VSDHDjfl6w9NAtmT6Y/cQJrq8H8c
         DUjQ2JVdg/Kaz2WFbL+QuwNQuHY25AL0r1D85bKm+pdFN3ZVULIY5TDuCbtNecFnN8HS
         Ps0sVOnnoj8BchSfGtVpjYU0Z/ADXYtYjfKfdesPRTNyU2vldhj9ihXEBvgG1+acGzZQ
         dq5AhzhqfpBNLtRhiAVGpYF6I4T4cY+rnrmPoEEBjsjDzciGMOvl4UhTDnAczVFNFvTQ
         2Fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GUllKO7wb5633n+/K3RfTcqZ//tFOo/xk+5N63G4iMw=;
        b=FIr1FnML/zbAv4TXm4kzb0xuNW0zT1Fb73U8dP8tXCS9Q9VkIYexK5yJ+AklvxuPP/
         ooGjU8r2mSJf4/z5Y0dqsznUNlwovP2PUCGqdqu7CHbnKe9rsmYdcoyWe8XLHFDX8zKE
         Dm4WWRcLeJE7F0ir+IQ7CcOtMl11YVrFQakBqbGCbpWYPhlhKN8Or7/lRCQmNY5vrrlm
         qfk2MO8XpZRvZl325tgkIlFZldtXg93UbJIMd4QkYvb8hSRl74EHFBWXdBUltLtChG/I
         62M8XdYe6eTZJ2H/+neZrbyxf/qttjkifdJhk9CP1lCK+Su10KYAX6vBIOsWr2Bc5MJ6
         F0HA==
X-Gm-Message-State: AOUpUlFGR4Z9JHjJqLVwBoCIwfZq3mU3OGk5B6Yb+3xVy420PIQyTE2J
        MUieGF8fmPHCoa4OQYrM/nI=
X-Google-Smtp-Source: AAOMgpdN2+MKp/iWPb4pmIFJNyuTwOjViFXMH22z5z2THC18OpFbCGplI+gU35xoVOM5s3LbdCMpTw==
X-Received: by 2002:a1c:3605:: with SMTP id d5-v6mr2360299wma.95.1533116886364;
        Wed, 01 Aug 2018 02:48:06 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id r12-v6sm13580217wmh.0.2018.08.01.02.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 02:48:05 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux@armlinux.org.uk, sean@mess.org, p.zabel@pengutronix.de
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v7 4/4] ARM: dts: sun8i: h3-h5: ir register size should be the whole memory block
Date:   Wed,  1 Aug 2018 11:48:01 +0200
Message-Id: <20180801094801.26627-5-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180801094801.26627-1-embed3d@gmail.com>
References: <20180801094801.26627-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of the register should be the size of the whole memory block,
not just the registers, that are needed.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index c3bff1105e5d..2f4d93de836e 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -818,7 +818,7 @@
 			clock-names = "apb", "ir";
 			resets = <&r_ccu RST_APB0_IR>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			reg = <0x01f02000 0x40>;
+			reg = <0x01f02000 0x400>;
 			status = "disabled";
 		};
 
-- 
2.11.0

