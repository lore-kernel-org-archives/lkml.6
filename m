Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65EBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6E0208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544123506;
	bh=IFvPGG9FK+ksTPaYImEW15a76nnXNPQTchmxZS3ur40=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=D52ZAkbIBC5DFjs5klLNPOlWlSJTaniisO0xGKLAcFlgaVGQ16AsW1AdFgbWwqX7E
	 hvDVr5uEHOoPs1tpZwxM9+rAVLckTC+XlTPy3D9G60Wbe0YZEZQyiJ9Ad4gr+auj6T
	 PC4Lqr7JnAG9FQ0RJzctLe2lIrsLRxN1rYt9s+0A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6E0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbeLFTLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:11:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43925 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFTLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:11:45 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so1333382oie.10;
        Thu, 06 Dec 2018 11:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B85wNpGoSP2V2mnXhKpVkuqFiCCFoHETPOMnmS1u0Z4=;
        b=nWqvp8mJsZGzd89yz328AGgvGotMLLm+/5uzzroobGGptCyg8nEcwHVFMYWJjFtJ2W
         f2RXu4M1lV+Prd/o/gzOU3pAUpXe9o4h8EByDqmp8dbd4eznNuBlUa8Ro3nCYJh6eRG7
         ZMcCqckf2vsmG4XnEZf6judBfKIQuIKg3vS6MB+wbjW1ygl8hasLn8XUaA248hWQE8re
         8RiPXxxNq7VUzVJgIH3HFNZ84mHHTwwe+CeKdVtZvlUcKgprhFjm4E0FxcaI1ozGr7jL
         Mtv7qjQcv6KDJGARpsPJyBXcD4CMHVUSwXBM9rOu0qDHD1JZCda/hg/FkP1peVLVOj9i
         8nLA==
X-Gm-Message-State: AA+aEWaJ/7j/kyAZj4VLNcbX27XlQyTMtTGTmahFuhuxBLl7IHCoDCXs
        KSTnuQ2gpw0h8+Tlexuz9+WSU2g=
X-Google-Smtp-Source: AFSGD/X1vwlhMHH8LkMsF82l6VrchCkhhYk66e1/gBFrN709SwTUaCHAKgjX6fMjSkx2jf4wTGsEIg==
X-Received: by 2002:aca:ba02:: with SMTP id k2mr19301532oif.177.1544123503792;
        Thu, 06 Dec 2018 11:11:43 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u19sm490821oia.31.2018.12.06.11.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:11:42 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] ARM: dts: sunxi: Fix PMU compatible strings
Date:   Thu,  6 Dec 2018 13:11:42 -0600
Message-Id: <20181206191142.14118-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"arm,cortex-a15-pmu" is not a valid fallback compatible string for an
Cortex-A7 PMU, so drop it.

Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index a960b8ef7822..9e7931d5e42a 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -202,7 +202,7 @@
 	};
 
 	pmu {
-		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
+		compatible = "arm,cortex-a7-pmu";
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 3c571dc599c3..5e413a5d9f6d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -199,7 +199,7 @@
 	};
 
 	pmu {
-		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
+		compatible = "arm,cortex-a7-pmu";
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 	};
-- 
2.19.1

