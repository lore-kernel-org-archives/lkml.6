Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25329C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1132081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JSKA9RSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1132081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeLBVmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:42:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35796 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLBVmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:42:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so10186398wrb.2;
        Sun, 02 Dec 2018 13:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CuvFY+6dLlBT+VFi6SS4U4OErEC3e8Zy5c3H92jpjM0=;
        b=JSKA9RSvnMAhuPPi2c6Ro8dgQVzIgO1uEYf9+jD+dK1wkKrDWTlRRKgxF4vt3imjmN
         82104UQlovWlodX85f22q/VL43jeH6HsRwqzaQB9/srov+3G5gwWzDdp3bNgaQ//B8oe
         9kEjlgcnMU+arF3qAgESSup98ntbjjjB9b++uQdKGArAvAHQ6Xyk80Yp2IJOtHUVAgDi
         /Ilp+hOSPXbSnheGwnDEmQeygJYqr4NNk6QouULijpyPuCpnlTgLvH/WOq5Cj/ZAmftQ
         5VrtIvV+PnjAn2lcjjluTJW57WVo/RU/kBKeXw37xVZeGcGttMVMkMOzN3+0FC7UJG53
         yR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CuvFY+6dLlBT+VFi6SS4U4OErEC3e8Zy5c3H92jpjM0=;
        b=MH79I+ZQe66kjf1Fqm80nOJQr6212Y9xUYU522aRbJmQw3ioVl7jPp+CxEpckRdPSy
         ghfFoUp9Jrm/p/8DP9bpbUgZjjBzijOWJGsR18AWVFQgFJ7OejfvkdWsjXnviCh6oxaI
         qjtvFlgdVqEWMNVKpHi0g4jDKRoMUGS+spnFsaNpVdo7a2FVqC02oYknjzhb8FtRtvLd
         /DeKAzVSPHHWeWbqFdvRrr3TlaTljVoKxksLNlpzMoHE3/kvcBlZWq/W+E90O/npxtU/
         khKvvz7GKpap4UyzuarXXW+CtR+o8qi5e386xi1wb5qm52tmxiWvNbuvXJyCRRlD7eUI
         egiA==
X-Gm-Message-State: AA+aEWafqcbbAxOyYRHrSjSSl1x9bBE6CsNzWF1Ikt/LzhuJhCypbirJ
        V5K6Lzai0GirX+62ejvH1cs=
X-Google-Smtp-Source: AFSGD/W3FTfxealTTzWPoWdHT7fPnHOWIGCqUD4jam+6M5L2sXGj2tOcW3EpV3u5HVOARypW7mjPWA==
X-Received: by 2002:adf:e911:: with SMTP id f17mr12507680wrm.126.1543786960864;
        Sun, 02 Dec 2018 13:42:40 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00B1CC0EB38CD20A4E.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:b1cc:eb3:8cd2:a4e])
        by smtp.googlemail.com with ESMTPSA id a18sm13073110wrp.13.2018.12.02.13.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 13:42:40 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] clk: meson: meson8b: add the read-only video clock trees
Date:   Sun,  2 Dec 2018 22:42:20 +0100
Message-Id: <20181202214220.7715-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
References: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all clocks to give us the final video clocks within the Meson8,
Meson8b and Meson8m2 SoCs. The final video clocks are:
- cts_enct
- cts_encl
- cts_encp
- cts_enci
- cts_vdac0
- hdmi_tx_pixel
- hdmi_sys

Add multiple clocks in between which are needed to implement these
clocks:
- Opposed to GXBB there is no pre-multiplier for the PLL input. The
  assumption here is that the multiplier is required to achieve the HDMI
  2.0 clock rates (which are up to twice the rate of the HDMI 1.4
  rates).
- The main PLL is called "HDMI PLL" or "HPLL" in the datasheet. Rename
  our existing "vid_pll_dco" to "hdmi_pll_dco". The actual VID_PLL clock
  also exists further down the tree.
- Rename the existing "vid_pll" clock (which is the OD divider at
  HHI_VID_PLL_CNTL[17:16]) to "hdmi_pll_lvds_out" to match the naming
  from the datasheet.
- Add the second OD divider called "hdmi_pll_hdmi_out" at
  HHI_VID_PLL_CNTL[19:18].
- Add the "vid_pll_in_sel" which can choose between "hdmi_pll_dco" and
  another parent. However, the second parent is not use on Amlogic's
  3.10 kernel for HDMI or CVBS output so just leave a TODO in the code.
- Add the "vid_pll_in_en" which is located after "vid_pll_in_sel"
  according to the datasheet.
- Add "vid_pll_pre_div" which is used for divide-by-5 and divide-by-6 in
  Amlogic's 3.10 kernel sources.
- Add "vid_pll_post_div" which divides the output of "vid_pll_pre_div"
  further down. The Amlogic 3.10 kernel configures this as divide-by-2
  with "vid_pll_pre_div" being configured as divide-by-5 to achieve a
  total divider of 10.
- Add the real "vid_pll" clock which selects between "vid_pll_pre_div",
  "vid_pll_post_div" and a third "vid_pll_pre_div_mult7_div2" (which is
  "vid_pll_pre_div" divided by 3.5). The latter is not supported yet
  because it's not used in Amlogic's 3.10 kernel. The "vid_pll" clock
  rate can also be measured by clkmsr to check whether this
  implementation is correct.
- Add "vid_pll_final_div" which is a post-divider for "vid_pll" and it's
  used as input for "vclk" and "vclk2"
- Add the two symmetric "vclk" and "vclk" clock trees, each with a
  divide-by-1, divide-by-2, divide-by-4, divide-by-6 and divide-by-12
  clock and a divider for each clock.
- Add the "cts_enct", "cts_encp" and "hdmi_tx_pixel" clocks which each
  have their own gate and can select between any of the five "vclk"
  dividers.
- Add the "cts_encl" and "cts_vdac0" clocks which each have their own
  gate and can select between any of the five "vclk2" dividers.

The "hdmi_sys" clock is a different than these video clocks. It takes
"xtal" as input (there are three more but unknown parents). Add this
clock as well as it's used by the HDMI controller. Amlogic's 3.10 kernel
always configures this as "xtal divided by 1", so we can ignore the
other parents for now.

This was tested on Meson8b and Meson8m2 boards by comparing the common
clock framework output with the clock measurer output. The following
video modes were first set in u-boot (by running "video dev open $mode")
before booting Linux:
4K2K30HZ (only supported by Meson8m2, not tested on Meson8b):
- vid_pll: 297000000Hz
- cts_encp: 297000000Hz
- hdmi_tx_pixel: 297000000Hz
1080P:
- vid_pll: 148500000Hz
- cts_encp: 148500000Hz
- hdmi_tx_pixel: 148500000Hz
720P:
- vid_pll: 148500000Hz
- cts_encp: 148500000Hz
- hdmi_tx_pixel: 74250000Hz
480P:
- vid_pll: 216000000Hz
- cts_encp: 54000000Hz
- hdmi_tx_pixel: 27000000Hz

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 739 +++++++++++++++++++++++++++++++++++-
 drivers/clk/meson/meson8b.h |  53 ++-
 2 files changed, 782 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 0f3f4759fc92..950d0e548c75 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -120,7 +120,7 @@ static struct clk_regmap meson8b_fixed_pll = {
 	},
 };
 
-static struct clk_regmap meson8b_vid_pll_dco = {
+static struct clk_regmap meson8b_hdmi_pll_dco = {
 	.data = &(struct meson_clk_pll_data){
 		.en = {
 			.reg_off = HHI_VID_PLL_CNTL,
@@ -154,14 +154,15 @@ static struct clk_regmap meson8b_vid_pll_dco = {
 		},
 	},
 	.hw.init = &(struct clk_init_data){
-		.name = "vid_pll_dco",
+		/* sometimes also called "HPLL" or "HPLL PLL" */
+		.name = "hdmi_pll_dco",
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_regmap meson8b_vid_pll = {
+static struct clk_regmap meson8b_hdmi_pll_lvds_out = {
 	.data = &(struct clk_regmap_div_data){
 		.offset = HHI_VID_PLL_CNTL,
 		.shift = 16,
@@ -169,9 +170,25 @@ static struct clk_regmap meson8b_vid_pll = {
 		.flags = CLK_DIVIDER_POWER_OF_TWO,
 	},
 	.hw.init = &(struct clk_init_data){
-		.name = "vid_pll",
+		.name = "hdmi_pll_lvds_out",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "hdmi_pll_dco" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_hdmi_pll_hdmi_out = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VID_PLL_CNTL,
+		.shift = 18,
+		.width = 2,
+		.flags = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_pll_hdmi_out",
 		.ops = &clk_regmap_divider_ro_ops,
-		.parent_names = (const char *[]){ "vid_pll_dco" },
+		.parent_names = (const char *[]){ "hdmi_pll_dco" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -930,6 +947,632 @@ static struct clk_regmap meson8b_l2_dram_clk_gate = {
 	},
 };
 
+static struct clk_regmap meson8b_vid_pll_in_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VID_DIVIDER_CNTL,
+		.mask = 0x1,
+		.shift = 15,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vid_pll_in_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		/*
+		 * TODO: depending on the SoC there is also a second parent:
+		 * Meson8: unknown
+		 * Meson8b: hdmi_pll_dco
+		 * Meson8m2: vid2_pll
+		 */
+		.parent_names = (const char *[]){ "hdmi_pll_dco" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vid_pll_in_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_DIVIDER_CNTL,
+		.bit_idx = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vid_pll_in_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "vid_pll_in_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vid_pll_pre_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset =  HHI_VID_DIVIDER_CNTL,
+		.shift = 4,
+		.width = 3,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vid_pll_pre_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "vid_pll_in_en" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vid_pll_post_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset =  HHI_VID_DIVIDER_CNTL,
+		.shift = 12,
+		.width = 3,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vid_pll_post_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "vid_pll_pre_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vid_pll = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VID_DIVIDER_CNTL,
+		.mask = 0x3,
+		.shift = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vid_pll",
+		.ops = &clk_regmap_mux_ro_ops,
+		/* TODO: parent 0x2 is vid_pll_pre_div_mult7_div2 */
+		.parent_names = (const char *[]){ "vid_pll_pre_div",
+						  "vid_pll_post_div" },
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vid_pll_final_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset =  HHI_VID_CLK_DIV,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vid_pll_final_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "vid_pll" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const char * const meson8b_vclk_mux_parents[] = {
+	"vid_pll_final_div", "fclk_div4", "fclk_div3", "fclk_div5",
+	"vid_pll_final_div", "fclk_div7", "mpll1"
+};
+
+static struct clk_regmap meson8b_vclk_in_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VID_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_in_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = meson8b_vclk_mux_parents,
+		.num_parents = ARRAY_SIZE(meson8b_vclk_mux_parents),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vclk_in_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_DIV,
+		.bit_idx = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_in_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "vclk_in_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vclk_div1_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_DIV,
+		.bit_idx = 0,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div1_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "vclk_in_en" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_fixed_factor meson8b_vclk_div2_div = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div2",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk_in_en" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	}
+};
+
+static struct clk_regmap meson8b_vclk_div2_div_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_DIV,
+		.bit_idx = 1,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div2_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "vclk_div2" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_fixed_factor meson8b_vclk_div4_div = {
+	.mult = 1,
+	.div = 4,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div4",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk_in_en" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	}
+};
+
+static struct clk_regmap meson8b_vclk_div4_div_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_DIV,
+		.bit_idx = 2,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div4_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "vclk_div4" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_fixed_factor meson8b_vclk_div6_div = {
+	.mult = 1,
+	.div = 6,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div6",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk_in_en" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	}
+};
+
+static struct clk_regmap meson8b_vclk_div6_div_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_DIV,
+		.bit_idx = 3,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div6_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "vclk_div6" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_fixed_factor meson8b_vclk_div12_div = {
+	.mult = 1,
+	.div = 12,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div12",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk_in_en" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	}
+};
+
+static struct clk_regmap meson8b_vclk_div12_div_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_DIV,
+		.bit_idx = 4,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div12_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "vclk_div12" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vclk2_in_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VIID_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_in_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = meson8b_vclk_mux_parents,
+		.num_parents = ARRAY_SIZE(meson8b_vclk_mux_parents),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vclk2_clk_in_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VIID_CLK_DIV,
+		.bit_idx = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_in_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "vclk2_in_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vclk2_div1_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VIID_CLK_DIV,
+		.bit_idx = 0,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div1_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "vclk2_in_en" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_fixed_factor meson8b_vclk2_div2_div = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div2",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk2_in_en" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	}
+};
+
+static struct clk_regmap meson8b_vclk2_div2_div_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VIID_CLK_DIV,
+		.bit_idx = 1,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div2_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "vclk2_div2" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_fixed_factor meson8b_vclk2_div4_div = {
+	.mult = 1,
+	.div = 4,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div4",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk2_in_en" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	}
+};
+
+static struct clk_regmap meson8b_vclk2_div4_div_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VIID_CLK_DIV,
+		.bit_idx = 2,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div4_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "vclk2_div4" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_fixed_factor meson8b_vclk2_div6_div = {
+	.mult = 1,
+	.div = 6,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div6",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk2_in_en" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	}
+};
+
+static struct clk_regmap meson8b_vclk2_div6_div_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VIID_CLK_DIV,
+		.bit_idx = 3,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div6_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "vclk2_div6" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_fixed_factor meson8b_vclk2_div12_div = {
+	.mult = 1,
+	.div = 12,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div12",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk2_in_en" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	}
+};
+
+static struct clk_regmap meson8b_vclk2_div12_div_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VIID_CLK_DIV,
+		.bit_idx = 4,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div12_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "vclk2_div12" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const char * const meson8b_vclk_enc_mux_parents[] = {
+	"vclk_div1_en", "vclk_div2_en", "vclk_div4_en", "vclk_div6_en",
+	"vclk_div12_en",
+};
+
+static struct clk_regmap meson8b_cts_enct_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VID_CLK_DIV,
+		.mask = 0xf,
+		.shift = 20,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_enct_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = meson8b_vclk_enc_mux_parents,
+		.num_parents = ARRAY_SIZE(meson8b_vclk_enc_mux_parents),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_cts_enct = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL2,
+		.bit_idx = 1,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_enct",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "cts_enct_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_cts_encp_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VID_CLK_DIV,
+		.mask = 0xf,
+		.shift = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_encp_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = meson8b_vclk_enc_mux_parents,
+		.num_parents = ARRAY_SIZE(meson8b_vclk_enc_mux_parents),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_cts_encp = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL2,
+		.bit_idx = 2,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_encp",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "cts_encp_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_cts_enci_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VID_CLK_DIV,
+		.mask = 0xf,
+		.shift = 28,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_enci_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = meson8b_vclk_enc_mux_parents,
+		.num_parents = ARRAY_SIZE(meson8b_vclk_enc_mux_parents),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_cts_enci = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL2,
+		.bit_idx = 0,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_enci",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "cts_enci_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_hdmi_tx_pixel_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_HDMI_CLK_CNTL,
+		.mask = 0xf,
+		.shift = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_tx_pixel_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = meson8b_vclk_enc_mux_parents,
+		.num_parents = ARRAY_SIZE(meson8b_vclk_enc_mux_parents),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_hdmi_tx_pixel = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL2,
+		.bit_idx = 5,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_tx_pixel",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "hdmi_tx_pixel_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const char * const meson8b_vclk2_enc_mux_parents[] = {
+	"vclk2_div1_en", "vclk2_div2_en", "vclk2_div4_en", "vclk2_div6_en",
+	"vclk2_div12_en",
+};
+
+static struct clk_regmap meson8b_cts_encl_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VIID_CLK_DIV,
+		.mask = 0xf,
+		.shift = 12,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_encl_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = meson8b_vclk2_enc_mux_parents,
+		.num_parents = ARRAY_SIZE(meson8b_vclk2_enc_mux_parents),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_cts_encl = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL2,
+		.bit_idx = 3,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_encl",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "cts_encl_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_cts_vdac0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VIID_CLK_DIV,
+		.mask = 0xf,
+		.shift = 28,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_vdac0_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = meson8b_vclk2_enc_mux_parents,
+		.num_parents = ARRAY_SIZE(meson8b_vclk2_enc_mux_parents),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_cts_vdac0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL2,
+		.bit_idx = 4,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_vdac0",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "cts_vdac0_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_hdmi_sys_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_HDMI_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 9,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_sys_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		/* FIXME: all other parents are unknown */
+		.parent_names = (const char *[]){ "xtal" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_NO_REPARENT,
+	},
+};
+
+static struct clk_regmap meson8b_hdmi_sys_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_HDMI_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_sys_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "hdmi_sys_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_hdmi_sys = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_HDMI_CLK_CNTL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hdmi_sys",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "hdmi_sys_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /* Everything Else (EE) domain gates */
 
 static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
@@ -1129,7 +1772,7 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_NAND_DIV]	    = &meson8b_nand_clk_div.hw,
 		[CLKID_NAND_CLK]	    = &meson8b_nand_clk_gate.hw,
 		[CLKID_PLL_FIXED_DCO]	    = &meson8b_fixed_pll_dco.hw,
-		[CLKID_PLL_VID_DCO]	    = &meson8b_vid_pll_dco.hw,
+		[CLKID_HDMI_PLL_DCO]	    = &meson8b_hdmi_pll_dco.hw,
 		[CLKID_PLL_SYS_DCO]	    = &meson8b_sys_pll_dco.hw,
 		[CLKID_CPU_CLK_DIV2]	    = &meson8b_cpu_clk_div2.hw,
 		[CLKID_CPU_CLK_DIV3]	    = &meson8b_cpu_clk_div3.hw,
@@ -1146,6 +1789,50 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_AXI]		    = &meson8b_axi_clk_gate.hw,
 		[CLKID_L2_DRAM_SEL]	    = &meson8b_l2_dram_clk_sel.hw,
 		[CLKID_L2_DRAM]		    = &meson8b_l2_dram_clk_gate.hw,
+		[CLKID_HDMI_PLL_LVDS_OUT]   = &meson8b_hdmi_pll_lvds_out.hw,
+		[CLKID_HDMI_PLL_HDMI_OUT]   = &meson8b_hdmi_pll_hdmi_out.hw,
+		[CLKID_VID_PLL_IN_SEL]	    = &meson8b_vid_pll_in_sel.hw,
+		[CLKID_VID_PLL_IN_EN]	    = &meson8b_vid_pll_in_en.hw,
+		[CLKID_VID_PLL_PRE_DIV]	    = &meson8b_vid_pll_pre_div.hw,
+		[CLKID_VID_PLL_POST_DIV]    = &meson8b_vid_pll_post_div.hw,
+		[CLKID_VID_PLL_FINAL_DIV]   = &meson8b_vid_pll_final_div.hw,
+		[CLKID_VCLK_IN_SEL]	    = &meson8b_vclk_in_sel.hw,
+		[CLKID_VCLK_IN_EN]	    = &meson8b_vclk_in_en.hw,
+		[CLKID_VCLK_DIV1]	    = &meson8b_vclk_div1_gate.hw,
+		[CLKID_VCLK_DIV2_DIV]	    = &meson8b_vclk_div2_div.hw,
+		[CLKID_VCLK_DIV2]	    = &meson8b_vclk_div2_div_gate.hw,
+		[CLKID_VCLK_DIV4_DIV]	    = &meson8b_vclk_div4_div.hw,
+		[CLKID_VCLK_DIV4]	    = &meson8b_vclk_div4_div_gate.hw,
+		[CLKID_VCLK_DIV6_DIV]	    = &meson8b_vclk_div6_div.hw,
+		[CLKID_VCLK_DIV6]	    = &meson8b_vclk_div6_div_gate.hw,
+		[CLKID_VCLK_DIV12_DIV]	    = &meson8b_vclk_div12_div.hw,
+		[CLKID_VCLK_DIV12]	    = &meson8b_vclk_div12_div_gate.hw,
+		[CLKID_VCLK2_IN_SEL]	    = &meson8b_vclk2_in_sel.hw,
+		[CLKID_VCLK2_IN_EN]	    = &meson8b_vclk2_clk_in_en.hw,
+		[CLKID_VCLK2_DIV1]	    = &meson8b_vclk2_div1_gate.hw,
+		[CLKID_VCLK2_DIV2_DIV]	    = &meson8b_vclk2_div2_div.hw,
+		[CLKID_VCLK2_DIV2]	    = &meson8b_vclk2_div2_div_gate.hw,
+		[CLKID_VCLK2_DIV4_DIV]	    = &meson8b_vclk2_div4_div.hw,
+		[CLKID_VCLK2_DIV4]	    = &meson8b_vclk2_div4_div_gate.hw,
+		[CLKID_VCLK2_DIV6_DIV]	    = &meson8b_vclk2_div6_div.hw,
+		[CLKID_VCLK2_DIV6]	    = &meson8b_vclk2_div6_div_gate.hw,
+		[CLKID_VCLK2_DIV12_DIV]	    = &meson8b_vclk2_div12_div.hw,
+		[CLKID_VCLK2_DIV12]	    = &meson8b_vclk2_div12_div_gate.hw,
+		[CLKID_CTS_ENCT_SEL]	    = &meson8b_cts_enct_sel.hw,
+		[CLKID_CTS_ENCT]	    = &meson8b_cts_enct.hw,
+		[CLKID_CTS_ENCP_SEL]	    = &meson8b_cts_encp_sel.hw,
+		[CLKID_CTS_ENCP]	    = &meson8b_cts_encp.hw,
+		[CLKID_CTS_ENCI_SEL]	    = &meson8b_cts_enci_sel.hw,
+		[CLKID_CTS_ENCI]	    = &meson8b_cts_enci.hw,
+		[CLKID_HDMI_TX_PIXEL_SEL]   = &meson8b_hdmi_tx_pixel_sel.hw,
+		[CLKID_HDMI_TX_PIXEL]	    = &meson8b_hdmi_tx_pixel.hw,
+		[CLKID_CTS_ENCL_SEL]	    = &meson8b_cts_encl_sel.hw,
+		[CLKID_CTS_ENCL]	    = &meson8b_cts_encl.hw,
+		[CLKID_CTS_VDAC0_SEL]	    = &meson8b_cts_vdac0_sel.hw,
+		[CLKID_CTS_VDAC0]	    = &meson8b_cts_vdac0.hw,
+		[CLKID_HDMI_SYS_SEL]	    = &meson8b_hdmi_sys_sel.hw,
+		[CLKID_HDMI_SYS_DIV]	    = &meson8b_hdmi_sys_div.hw,
+		[CLKID_HDMI_SYS]	    = &meson8b_hdmi_sys.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -1239,7 +1926,6 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_mpll1_div,
 	&meson8b_mpll2_div,
 	&meson8b_fixed_pll,
-	&meson8b_vid_pll,
 	&meson8b_sys_pll,
 	&meson8b_cpu_in_sel,
 	&meson8b_cpu_scale_div,
@@ -1255,7 +1941,7 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_nand_clk_div,
 	&meson8b_nand_clk_gate,
 	&meson8b_fixed_pll_dco,
-	&meson8b_vid_pll_dco,
+	&meson8b_hdmi_pll_dco,
 	&meson8b_sys_pll_dco,
 	&meson8b_abp_clk_sel,
 	&meson8b_abp_clk_gate,
@@ -1265,6 +1951,43 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_axi_clk_gate,
 	&meson8b_l2_dram_clk_sel,
 	&meson8b_l2_dram_clk_gate,
+	&meson8b_hdmi_pll_lvds_out,
+	&meson8b_hdmi_pll_hdmi_out,
+	&meson8b_vid_pll_in_sel,
+	&meson8b_vid_pll_in_en,
+	&meson8b_vid_pll_pre_div,
+	&meson8b_vid_pll_post_div,
+	&meson8b_vid_pll,
+	&meson8b_vid_pll_final_div,
+	&meson8b_vclk_in_sel,
+	&meson8b_vclk_in_en,
+	&meson8b_vclk_div1_gate,
+	&meson8b_vclk_div2_div_gate,
+	&meson8b_vclk_div4_div_gate,
+	&meson8b_vclk_div6_div_gate,
+	&meson8b_vclk_div12_div_gate,
+	&meson8b_vclk2_in_sel,
+	&meson8b_vclk2_clk_in_en,
+	&meson8b_vclk2_div1_gate,
+	&meson8b_vclk2_div2_div_gate,
+	&meson8b_vclk2_div4_div_gate,
+	&meson8b_vclk2_div6_div_gate,
+	&meson8b_vclk2_div12_div_gate,
+	&meson8b_cts_enct_sel,
+	&meson8b_cts_enct,
+	&meson8b_cts_encp_sel,
+	&meson8b_cts_encp,
+	&meson8b_cts_enci_sel,
+	&meson8b_cts_enci,
+	&meson8b_hdmi_tx_pixel_sel,
+	&meson8b_hdmi_tx_pixel,
+	&meson8b_cts_encl_sel,
+	&meson8b_cts_encl,
+	&meson8b_cts_vdac0_sel,
+	&meson8b_cts_vdac0,
+	&meson8b_hdmi_sys_sel,
+	&meson8b_hdmi_sys_div,
+	&meson8b_hdmi_sys,
 };
 
 static const struct meson8b_clk_reset_line {
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index e953923792d7..87fba739af81 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -19,16 +19,21 @@
  *
  * [0] http://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
  */
+#define HHI_VIID_CLK_DIV		0x128 /* 0x4a offset in data sheet */
+#define HHI_VIID_CLK_CNTL		0x12c /* 0x4b offset in data sheet */
 #define HHI_GCLK_MPEG0			0x140 /* 0x50 offset in data sheet */
 #define HHI_GCLK_MPEG1			0x144 /* 0x51 offset in data sheet */
 #define HHI_GCLK_MPEG2			0x148 /* 0x52 offset in data sheet */
 #define HHI_GCLK_OTHER			0x150 /* 0x54 offset in data sheet */
 #define HHI_GCLK_AO			0x154 /* 0x55 offset in data sheet */
 #define HHI_SYS_CPU_CLK_CNTL1		0x15c /* 0x57 offset in data sheet */
+#define HHI_VID_CLK_DIV			0x164 /* 0x59 offset in data sheet */
 #define HHI_MPEG_CLK_CNTL		0x174 /* 0x5d offset in data sheet */
 #define HHI_VID_CLK_CNTL		0x17c /* 0x5f offset in data sheet */
+#define HHI_VID_CLK_CNTL2		0x194 /* 0x65 offset in data sheet */
 #define HHI_VID_DIVIDER_CNTL		0x198 /* 0x66 offset in data sheet */
 #define HHI_SYS_CPU_CLK_CNTL0		0x19c /* 0x67 offset in data sheet */
+#define HHI_HDMI_CLK_CNTL		0x1cc /* 0x73 offset in data sheet */
 #define HHI_NAND_CLK_CNTL		0x25c /* 0x97 offset in data sheet */
 #define HHI_MPLL_CNTL			0x280 /* 0xa0 offset in data sheet */
 #define HHI_SYS_PLL_CNTL		0x300 /* 0xc0 offset in data sheet */
@@ -77,7 +82,7 @@
 #define CLKID_NAND_SEL		110
 #define CLKID_NAND_DIV		111
 #define CLKID_PLL_FIXED_DCO	113
-#define CLKID_PLL_VID_DCO	114
+#define CLKID_HDMI_PLL_DCO	114
 #define CLKID_PLL_SYS_DCO	115
 #define CLKID_CPU_CLK_DIV2	116
 #define CLKID_CPU_CLK_DIV3	117
@@ -90,8 +95,52 @@
 #define CLKID_PERIPH_SEL	125
 #define CLKID_AXI_SEL		127
 #define CLKID_L2_DRAM_SEL	129
+#define CLKID_HDMI_PLL_LVDS_OUT	131
+#define CLKID_HDMI_PLL_HDMI_OUT	132
+#define CLKID_VID_PLL_IN_SEL	133
+#define CLKID_VID_PLL_IN_EN	134
+#define CLKID_VID_PLL_PRE_DIV	135
+#define CLKID_VID_PLL_POST_DIV	136
+#define CLKID_VID_PLL_FINAL_DIV	137
+#define CLKID_VCLK_IN_SEL	138
+#define CLKID_VCLK_IN_EN	139
+#define CLKID_VCLK_DIV1		140
+#define CLKID_VCLK_DIV2_DIV	141
+#define CLKID_VCLK_DIV2		142
+#define CLKID_VCLK_DIV4_DIV	143
+#define CLKID_VCLK_DIV4		144
+#define CLKID_VCLK_DIV6_DIV	145
+#define CLKID_VCLK_DIV6		146
+#define CLKID_VCLK_DIV12_DIV	147
+#define CLKID_VCLK_DIV12	148
+#define CLKID_VCLK2_IN_SEL	149
+#define CLKID_VCLK2_IN_EN	150
+#define CLKID_VCLK2_DIV1	151
+#define CLKID_VCLK2_DIV2_DIV	152
+#define CLKID_VCLK2_DIV2	153
+#define CLKID_VCLK2_DIV4_DIV	154
+#define CLKID_VCLK2_DIV4	155
+#define CLKID_VCLK2_DIV6_DIV	156
+#define CLKID_VCLK2_DIV6	157
+#define CLKID_VCLK2_DIV12_DIV	158
+#define CLKID_VCLK2_DIV12	159
+#define CLKID_CTS_ENCT_SEL	160
+#define CLKID_CTS_ENCT		161
+#define CLKID_CTS_ENCP_SEL	162
+#define CLKID_CTS_ENCP		163
+#define CLKID_CTS_ENCI_SEL	164
+#define CLKID_CTS_ENCI		165
+#define CLKID_HDMI_TX_PIXEL_SEL	166
+#define CLKID_HDMI_TX_PIXEL	167
+#define CLKID_CTS_ENCL_SEL	168
+#define CLKID_CTS_ENCL		169
+#define CLKID_CTS_VDAC0_SEL	170
+#define CLKID_CTS_VDAC0		171
+#define CLKID_HDMI_SYS_SEL	172
+#define CLKID_HDMI_SYS_DIV	173
+#define CLKID_HDMI_SYS		174
 
-#define CLK_NR_CLKS		131
+#define CLK_NR_CLKS		175
 
 /*
  * include the CLKID and RESETID that have
-- 
2.19.2

