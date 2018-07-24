Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC5DECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EE820880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rxg/05+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EE820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbeGXRup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:50:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40717 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388589AbeGXRup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:50:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so3290196pgp.7;
        Tue, 24 Jul 2018 09:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rVKbXczfv+RzlB+yL++j1SAXIAyX+n3XTuzqDXSqkC8=;
        b=Rxg/05+DX3fkEH3YnbJem119nSPsl2lCB4u51FsphXrqDbQ/M3ltVH7mcMCdd1tRIi
         6wUB+SAib6Oe1uUvM8j4S5YbGq3J789yK9zz3goZMIJ9QpTZzIb2oDO+uPutOpQwKP3S
         kYTOaxSm6EobXzKITxWhl8fqHWtSEXtxr6NbKbUO9xICTKRAi4ECh2BxaiG8Vny9+v2m
         Xydxj+QS45Jl+FSlT2X1rqc5/2nwhdIsmfx+ah34QwHZQ9VQVRhILcoqrFFST+Ff35vp
         cYfSXCrie9apEaJ5ViqRT2HLVqKc2hdZisDSsf89tTlIDXLg4dfhpsEF2QHcRUNuz6fI
         p6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rVKbXczfv+RzlB+yL++j1SAXIAyX+n3XTuzqDXSqkC8=;
        b=oAkyRy7OO5VonP3mH7Tto1Yd9yyHxyXFYPwv1eKVSQEAAPt5wEeHhuaWq+bOf2Zf1c
         ZcfZduagbvLMmI2sGvrKeYG+J4aWDc/DRuHXqYTCvaMfX6O+XRLEGcgoWujuy+QOSv4u
         URQQB3oRi9+bM6gNFjVOv6LcG17h1qetsMFtH2sARzteKL0+btQQ2qv5kDOlcawZo9Rp
         pQMxQsjPm6l0CdKawcKBynw2+V/8CDBPQ5ntWyqzRuZnaXqL3E6hCezRvEMHwIN8xmJo
         /xgwU2muD1U+D4Uj8rSRhS3aRu/8OlbXOszmJQXWN+DtH8ajh7BMswne6hOdzqBhPCoR
         7aIQ==
X-Gm-Message-State: AOUpUlFeVjU0FhsDk5MMta2S3XOlYUAxtL+xpB/IftbOR8SuvsQOxYSW
        H231TvC/6jYyRZ50YRAVhtU=
X-Google-Smtp-Source: AAOMgpd45o51qzDC4G+Bk5V2sg7+aAE/kKgs98p+JK4GZRa5MKfQY8whjd0n/H+S/hpzo8p/yoyU0g==
X-Received: by 2002:a65:6211:: with SMTP id d17-v6mr17444092pgv.450.1532450606002;
        Tue, 24 Jul 2018 09:43:26 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id j1-v6sm39410536pfk.125.2018.07.24.09.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:43:25 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/8] ARM: dts: tegra20: Add interrupt entry to External Memory Controller
Date:   Tue, 24 Jul 2018 19:42:17 +0300
Message-Id: <20180724164221.3307-5-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724164221.3307-1-digetx@gmail.com>
References: <20180724164221.3307-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt entry into the EMC DT node.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 15b73bd377f0..9eb4163a4390 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -632,6 +632,7 @@
 	memory-controller@7000f400 {
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-- 
2.18.0

