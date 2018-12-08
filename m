Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61422C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129C62083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WorZom4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129C62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeLHRNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:13:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36351 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeLHRNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:13:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id u3so6598774wrs.3;
        Sat, 08 Dec 2018 09:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LJ3U5JqjaKzxdG8nIgvyVdatCQ3/Gh5QT7dpYuXepc4=;
        b=WorZom4Zgh6JBiOEgE+PITSK7idBEUaTHa5Bn8q4F6Lpd0Erl/MTrhfJBwTS7f+C/g
         IHGiS6KX9gGRBMorFvSK0g2wrRvz3uh8bdOcUfctK5qDHkXWEsNA1nDqlrmSoHMuILhg
         gQCv0KyCNdWVt/AJNoPuzj6RHzZKkTm+/afP6MXvnVWgFjEfu1jhrGCpJ2F5s0tMT85A
         kZaSqbTdayBQbQhgz/wifwHQ2xRs2jK3gs9xdVLTbdccg54pOh2x6WGMNxszAYI+ttZl
         vb06kLlz0Cil9dFlz2LwFsxJ6gbzJLRID/Q22bW5T7KjmoE4FUUREOdARw20nDrI4PBN
         05aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJ3U5JqjaKzxdG8nIgvyVdatCQ3/Gh5QT7dpYuXepc4=;
        b=dOpwmBWtZYs7u/ON3KLIXcPtxT3Pl2BN31CE8zHz4Qgy075QnC8x5+WJ9abRpX+9Bh
         9ZjWi1G3LIwTeYNJOTMigiNcVFYZbkPNQTxk062IIuHnQKkEhhJqcNGYj1LEknvSC98/
         vtttIlw7OndTML7eLxg4nWsvWg+8X1UTp4trTbbq3jxp+9TrKwXY8+pVi0O8vbaFL/5A
         gsRvs4CJaL2HUxA1SszxHpkqc5k079AX/zWTSrmlcy9l0Lw0OLWqYUfYfr+1PD7zobBK
         uarluBr2uahdITqEtgDedRk6StsCF6PcN/BBR4ov5ve0sS7jvDKjiaUaIkcGk7jzDYU7
         4DuA==
X-Gm-Message-State: AA+aEWYObX+EyGewWNUYv1dfNg3oJIPQyMIJBRxz0tRhOHyow1fVXrjP
        8BriBixLFHVJm0lgYBcHOHE=
X-Google-Smtp-Source: AFSGD/WzaT1ksln5FAjlFCjlVjK1OK5z1O3GXXcpqwJsM4tzDPvTLlm3vd2wZeOcGxTU3tdCm3Ec/g==
X-Received: by 2002:adf:9123:: with SMTP id j32mr5360234wrj.122.1544289192050;
        Sat, 08 Dec 2018 09:13:12 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r12sm4995851wrq.3.2018.12.08.09.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 09:13:11 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com,
        khilman@baylibre.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/5] clk: meson: meson8b: add the GPU clock tree
Date:   Sat,  8 Dec 2018 18:12:45 +0100
Message-Id: <20181208171247.22238-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
References: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the GPU clock tree on Meson8, Meson8b and Meson8m2.

The GPU clock tree on Meson8b and Meson8m2 is almost identical to the
one one GXBB:
- there's a glitch-free mux at HHI_MALI_CLK_CNTL[31]
- there are two identical parents for this mux: mali_0 and mali_1, each
  with a gate, divider and mux
- the parents of mali_0_sel and mali_1_sel are identical to GXBB except
  there's no GP0_PLL on these 32-bit SoCs

Meson8 is different because it does not have the glitch-free mux.
Instead if only has the mali_0 clock tree. The parents of mali_0_sel are
identical to the ones on Meson8b and Meson8m2.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 146 ++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/meson8b.h |   9 ++-
 2 files changed, 154 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 0b9353d8d4fd..748552c5f6c8 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1573,6 +1573,135 @@ static struct clk_regmap meson8b_hdmi_sys = {
 	},
 };
 
+/*
+ * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
+ * muxed by a glitch-free switch on Meson8b and Meson8m2. Meson8 only
+ * has mali_0 and no glitch-free mux.
+ */
+static const char * const meson8b_mali_0_1_parent_names[] = {
+	"xtal", "mpll2", "mpll1", "fclk_div7", "fclk_div4", "fclk_div3",
+	"fclk_div5"
+};
+
+static u32 meson8b_mali_0_1_mux_table[] = { 0, 2, 3, 4, 5, 6, 7 };
+
+static struct clk_regmap meson8b_mali_0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_MALI_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 9,
+		.table = meson8b_mali_0_1_mux_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_0_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = meson8b_mali_0_1_parent_names,
+		.num_parents = ARRAY_SIZE(meson8b_mali_0_1_parent_names),
+		/*
+		 * Don't propagate rate changes up because the only changeable
+		 * parents are mpll1 and mpll2 but we need those for audio and
+		 * RGMII (Ethernet). We don't want to change the audio or
+		 * Ethernet clocks when setting the GPU frequency.
+		 */
+		.flags = 0,
+	},
+};
+
+static struct clk_regmap meson8b_mali_0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_MALI_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_0_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "mali_0_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_mali_0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MALI_CLK_CNTL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "mali_0_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_mali_1_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_MALI_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 25,
+		.table = meson8b_mali_0_1_mux_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_1_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = meson8b_mali_0_1_parent_names,
+		.num_parents = ARRAY_SIZE(meson8b_mali_0_1_parent_names),
+		/*
+		 * Don't propagate rate changes up because the only changeable
+		 * parents are mpll1 and mpll2 but we need those for audio and
+		 * RGMII (Ethernet). We don't want to change the audio or
+		 * Ethernet clocks when setting the GPU frequency.
+		 */
+		.flags = 0,
+	},
+};
+
+static struct clk_regmap meson8b_mali_1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_MALI_CLK_CNTL,
+		.shift = 16,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_1_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "mali_1_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_mali_1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MALI_CLK_CNTL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "mali_1_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_mali = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_MALI_CLK_CNTL,
+		.mask = 1,
+		.shift = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mali",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "mali_0", "mali_1" },
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /* Everything Else (EE) domain gates */
 
 static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
@@ -1833,6 +1962,9 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
 		[CLKID_HDMI_SYS_SEL]	    = &meson8b_hdmi_sys_sel.hw,
 		[CLKID_HDMI_SYS_DIV]	    = &meson8b_hdmi_sys_div.hw,
 		[CLKID_HDMI_SYS]	    = &meson8b_hdmi_sys.hw,
+		[CLKID_MALI_0_SEL]	    = &meson8b_mali_0_sel.hw,
+		[CLKID_MALI_0_DIV]	    = &meson8b_mali_0_div.hw,
+		[CLKID_MALI]		    = &meson8b_mali_0.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2012,6 +2144,13 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_HDMI_SYS_SEL]	    = &meson8b_hdmi_sys_sel.hw,
 		[CLKID_HDMI_SYS_DIV]	    = &meson8b_hdmi_sys_div.hw,
 		[CLKID_HDMI_SYS]	    = &meson8b_hdmi_sys.hw,
+		[CLKID_MALI_0_SEL]	    = &meson8b_mali_0_sel.hw,
+		[CLKID_MALI_0_DIV]	    = &meson8b_mali_0_div.hw,
+		[CLKID_MALI_0]		    = &meson8b_mali_0.hw,
+		[CLKID_MALI_1_SEL]	    = &meson8b_mali_1_sel.hw,
+		[CLKID_MALI_1_DIV]	    = &meson8b_mali_1_div.hw,
+		[CLKID_MALI_1]		    = &meson8b_mali_1.hw,
+		[CLKID_MALI]		    = &meson8b_mali.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2167,6 +2306,13 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_hdmi_sys_sel,
 	&meson8b_hdmi_sys_div,
 	&meson8b_hdmi_sys,
+	&meson8b_mali_0_sel,
+	&meson8b_mali_0_div,
+	&meson8b_mali_0,
+	&meson8b_mali_1_sel,
+	&meson8b_mali_1_div,
+	&meson8b_mali_1,
+	&meson8b_mali,
 };
 
 static const struct meson8b_clk_reset_line {
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index 87fba739af81..f212e2304ff5 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -33,6 +33,7 @@
 #define HHI_VID_CLK_CNTL2		0x194 /* 0x65 offset in data sheet */
 #define HHI_VID_DIVIDER_CNTL		0x198 /* 0x66 offset in data sheet */
 #define HHI_SYS_CPU_CLK_CNTL0		0x19c /* 0x67 offset in data sheet */
+#define HHI_MALI_CLK_CNTL		0x1b0 /* 0x6c offset in data sheet */
 #define HHI_HDMI_CLK_CNTL		0x1cc /* 0x73 offset in data sheet */
 #define HHI_NAND_CLK_CNTL		0x25c /* 0x97 offset in data sheet */
 #define HHI_MPLL_CNTL			0x280 /* 0xa0 offset in data sheet */
@@ -139,8 +140,14 @@
 #define CLKID_HDMI_SYS_SEL	172
 #define CLKID_HDMI_SYS_DIV	173
 #define CLKID_HDMI_SYS		174
+#define CLKID_MALI_0_SEL	175
+#define CLKID_MALI_0_DIV	176
+#define CLKID_MALI_0		177
+#define CLKID_MALI_1_SEL	178
+#define CLKID_MALI_1_DIV	179
+#define CLKID_MALI_1		180
 
-#define CLK_NR_CLKS		175
+#define CLK_NR_CLKS		181
 
 /*
  * include the CLKID and RESETID that have
-- 
2.19.2

