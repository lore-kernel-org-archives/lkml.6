Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E39FECDE3A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAC321476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e734OjKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAC321476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJRAqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbeJRAqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:46:53 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF1002145D;
        Wed, 17 Oct 2018 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539795021;
        bh=ZA4OaWW9mULJ1f+eOMjD0Ng4vMYKL8LVM/iR1J1qNZc=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=e734OjKyR7fgVVIEreuw9PJglWnUbSCW6wtFU5pNtjQMgU+w7+23H3OXP+S//Y78N
         fsCm0X4+r39DV511NtfNwWdXqMrP9Zb6EvptYBbC3egeYPwvcjaLDVIJO+z4qU4Odp
         EFM1Y4Sk3tkGji8xNjqfadCKKEgS9E7tGmDmqBlE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
Message-ID: <153979502020.5275.12406468543355327223@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 00/22] clk: at91: Rework DT bindings
Date:   Wed, 17 Oct 2018 09:50:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2018-10-16 07:21:38)
> This is the promised rework of the at91 PMC clocks driver. It is mainly
> necessary to remove the DTC warnings but it also complies with the CCF
> rule that there should be one node per controller instead of one node
> per clock.
> =

> This only handles the PMC, I'm planning to also rework the SCKC bindings
> later (without breaking the DT ABI).
> =

> The series is based on top of v4.19-rc1.
> =

> The first two patches are actually fixes and may be considered for this
> cycle.
> =

> I'll take the device tree changes through the at91 tree as DT backward
> compatibility is working.
> =


I get the following warnings and errors from my auto checker script:

ERROR: need consistent spacing around '+' (ctx:WxV)
#167: FILE: drivers/clk/at91/sama5d4.c:137:
+       sama5d4_pmc =3D pmc_data_allocate(PMC_MCK2 +1,
                                                 ^

drivers/clk/at91/clk-i2s-mux.c:49:15: warning: symbol 'at91_clk_i2s_mux_reg=
ister' was not declared. Should it be static?
drivers/clk/at91/clk-audio-pll.c:447:15: warning: symbol 'at91_clk_register=
_audio_pll_frac' was not declared. Should it be static?
drivers/clk/at91/clk-audio-pll.c:477:15: warning: symbol 'at91_clk_register=
_audio_pll_pad' was not declared. Should it be static?
drivers/clk/at91/clk-audio-pll.c:508:15: warning: symbol 'at91_clk_register=
_audio_pll_pmc' was not declared. Should it be static?
drivers/clk/at91/sama5d4.c:123 sama5d4_pmc_setup() warn: unsigned 'i' is ne=
ver less than zero.
drivers/clk/at91/sama5d4.c:129 sama5d4_pmc_setup() warn: unsigned 'i' is ne=
ver less than zero.
drivers/clk/at91/sama5d2.c:140 sama5d2_pmc_setup() warn: unsigned 'i' is ne=
ver less than zero.
drivers/clk/at91/sama5d2.c:146 sama5d2_pmc_setup() warn: unsigned 'i' is ne=
ver less than zero.
drivers/clk/at91/at91sam9x5.c:132 at91sam9x5_pmc_setup() warn: unsigned 'i'=
 is never less than zero.
drivers/clk/at91/at91sam9x5.c:138 at91sam9x5_pmc_setup() warn: unsigned 'i'=
 is never less than zero.
drivers/clk/at91/at91sam9rl.c:76 at91sam9rl_pmc_setup() warn: unsigned 'i' =
is never less than zero.
drivers/clk/at91/at91sam9rl.c:82 at91sam9rl_pmc_setup() warn: unsigned 'i' =
is never less than zero.
drivers/clk/at91/at91sam9260.c:341 at91sam926x_pmc_setup() warn: unsigned '=
i' is never less than zero.
drivers/clk/at91/at91sam9260.c:347 at91sam926x_pmc_setup() warn: unsigned '=
i' is never less than zero.

I fixed them with the below patch, that I'll squash into the right
place. Things look good!

diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 49aeee6c31a6..b1af5a395423 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -334,7 +334,7 @@ static void __init at91sam926x_pmc_setup(struct device_=
node *np,
 	const char *slck_name;
 	struct regmap *regmap;
 	struct clk_hw *hw;
-	unsigned int i;
+	int i;
 	bool bypass;
 =

 	i =3D of_property_match_string(np, "clock-names", "slow_xtal");
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 5532fba5825b..5aeef68b4bdd 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -70,7 +70,7 @@ static void __init at91sam9rl_pmc_setup(struct device_nod=
e *np)
 	const char *parent_names[6];
 	struct regmap *regmap;
 	struct clk_hw *hw;
-	unsigned int i;
+	int i;
 =

 	i =3D of_property_match_string(np, "clock-names", "slow_clk");
 	if (i < 0)
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 3cdf227ce159..2fe225a697df 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -125,7 +125,7 @@ static void __init at91sam9x5_pmc_setup(struct device_n=
ode *np,
 	const char *parent_names[6];
 	struct regmap *regmap;
 	struct clk_hw *hw;
-	unsigned int i;
+	int i;
 	bool bypass;
 =

 	i =3D of_property_match_string(np, "clock-names", "slow_clk");
diff --git a/drivers/clk/at91/clk-audio-pll.c b/drivers/clk/at91/clk-audio-=
pll.c
index 96e3c6405351..36d77146a3bd 100644
--- a/drivers/clk/at91/clk-audio-pll.c
+++ b/drivers/clk/at91/clk-audio-pll.c
@@ -43,6 +43,8 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 =

+#include "pmc.h"
+
 #define AUDIO_PLL_DIV_FRAC	BIT(22)
 #define AUDIO_PLL_ND_MAX	(AT91_PMC_AUDIO_PLL_ND_MASK >> \
 					AT91_PMC_AUDIO_PLL_ND_OFFSET)
diff --git a/drivers/clk/at91/clk-i2s-mux.c b/drivers/clk/at91/clk-i2s-mux.c
index dfdffa5409e6..fe6ce172b8b0 100644
--- a/drivers/clk/at91/clk-i2s-mux.c
+++ b/drivers/clk/at91/clk-i2s-mux.c
@@ -14,6 +14,8 @@
 =

 #include <soc/at91/atmel-sfr.h>
 =

+#include "pmc.h"
+
 struct clk_i2s_mux {
 	struct clk_hw hw;
 	struct regmap *regmap;
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 07f1f1d613ff..d69ad96fe988 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -133,7 +133,7 @@ static void __init sama5d2_pmc_setup(struct device_node=
 *np)
 	const char *parent_names[6];
 	struct regmap *regmap, *regmap_sfr;
 	struct clk_hw *hw;
-	unsigned int i;
+	int i;
 	bool bypass;
 =

 	i =3D of_property_match_string(np, "clock-names", "slow_clk");
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 64b9f438f73b..e358be7f6c8d 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -116,7 +116,7 @@ static void __init sama5d4_pmc_setup(struct device_node=
 *np)
 	const char *parent_names[5];
 	struct regmap *regmap;
 	struct clk_hw *hw;
-	unsigned int i;
+	int i;
 	bool bypass;
 =

 	i =3D of_property_match_string(np, "clock-names", "slow_clk");
@@ -134,7 +134,7 @@ static void __init sama5d4_pmc_setup(struct device_node=
 *np)
 	if (IS_ERR(regmap))
 		return;
 =

-	sama5d4_pmc =3D pmc_data_allocate(PMC_MCK2 +1,
+	sama5d4_pmc =3D pmc_data_allocate(PMC_MCK2 + 1,
 					nck(sama5d4_systemck),
 					nck(sama5d4_periph32ck), 0);
 	if (!sama5d4_pmc)
