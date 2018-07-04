Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58F3C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1DC21A74
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fCaGOPFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1DC21A74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeGDQ5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:57:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38046 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752406AbeGDQ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:57:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so6825216wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=FdWw7I7qUXkkSwxpjKRH75348Fh8svvw5X5RxcvAGAU=;
        b=fCaGOPFjdxuN6tA6GMwS+L4CjVIxx8zryhpSzMz/NNfMHgM6Chu6hJ4Qvjd3CXwL68
         T8IOAS9oyz7H+qUDa/P7VcYIHp+59rWWpkPu+GJ2JBQ9zKj34J9u9xZC1B410y8rRIvH
         l9uiEiejk8LJc8GI9G9i9PKinvcUIdchs6o2IQHchOs49A6c6SGocP5qvpQLKSibf5Kr
         Qq5v8rL1rbWVdxuHVzjpbcS6wZJAhhtN515AGWFv4fFYu+v6fgXJDNM9uFzTUa5CVL6i
         OrBeKieytPzdUNNa+NtEH84BKp/TJFpe8STqVjCEYW1vgGj0EiHu7IpLzcFYxeJhwP/P
         h57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FdWw7I7qUXkkSwxpjKRH75348Fh8svvw5X5RxcvAGAU=;
        b=K3h6SPyXFJTeD+cJaIzNmQNHUsJsZlPPCHnYasEHCaH8Tk1J2KagSfCF3Gim533XGr
         lohedr2iFgIaRibdRgsHDgUwKZKFyJd1UvljTw3ZOPF6Vth2S8u41tS8ept63X1T9ijl
         YOy7O9FVMqJqknpaP0cQlQegitmkXAMyntouTdS4yHnu+7X3U9ovTUZSn15ymmmyAgF+
         9P1cKk0Y/L+l6BCvn67jCz3OCe81KE+lt7MMHIGgrfFxkz3uq2gjgWNs6XXYCYMurbQ1
         C2bAgdGqUpN/w3JGbM+JdCqoNTb3Osce0tj7YAr8ODQ3/BZ+gSwq2P802ih62KJVXOEs
         bliQ==
X-Gm-Message-State: APt69E32hNZUqUPEJn15xS3VTUH0zcOvyD7fQLDYa3l0NatdTKACbVKv
        6lyHZDba8VEac3chnT7nUeXQNg==
X-Google-Smtp-Source: AAOMgpcfpzNph3ncaT/89QOWWyqYe7/rg/00iIUsOEeOLoWZHzVNaCsyY/jXDU3/hFnKpdh+eJNElA==
X-Received: by 2002:a1c:9ec5:: with SMTP id h188-v6mr2225418wme.76.1530723449209;
        Wed, 04 Jul 2018 09:57:29 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n16-v6sm6995655wrg.58.2018.07.04.09.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 09:57:28 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: meson: add gen_clk pins
Date:   Wed,  4 Jul 2018 18:57:24 +0200
Message-Id: <20180704165724.3387-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pinctrl configuration for gen_clk on gxbb and axg.
gen_clk allows to output and devide several internal clocks of SoC,
including most of the plls.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-axg.c  | 9 +++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index 46a0918bd284..ad502eda4afa 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -672,6 +672,9 @@ static const unsigned int jtag_ao_tdo_pins[] = {GPIOAO_4};
 static const unsigned int jtag_ao_clk_pins[] = {GPIOAO_5};
 static const unsigned int jtag_ao_tms_pins[] = {GPIOAO_7};
 
+/* gen_clk */
+static const unsigned int gen_clk_ee_pins[] = {GPIOAO_13};
+
 static struct meson_pmx_group meson_axg_aobus_groups[] = {
 	GPIO_GROUP(GPIOAO_0),
 	GPIO_GROUP(GPIOAO_1),
@@ -718,6 +721,7 @@ static struct meson_pmx_group meson_axg_aobus_groups[] = {
 	GROUP(jtag_ao_tdo, 4),
 	GROUP(jtag_ao_clk, 4),
 	GROUP(jtag_ao_tms, 4),
+	GROUP(gen_clk_ee, 4),
 };
 
 static const char * const gpio_periphs_groups[] = {
@@ -947,6 +951,10 @@ static const char * const tdmb_groups[] = {
 	"tdmb_din2", "tdmb_dout2", "tdmb_din3",	"tdmb_dout3",
 };
 
+static const char * const gen_clk_ee_groups[] = {
+	"gen_clk_ee",
+};
+
 static struct meson_pmx_func meson_axg_periphs_functions[] = {
 	FUNCTION(gpio_periphs),
 	FUNCTION(emmc),
@@ -992,6 +1000,7 @@ static struct meson_pmx_func meson_axg_aobus_functions[] = {
 	FUNCTION(pwm_ao_c),
 	FUNCTION(pwm_ao_d),
 	FUNCTION(jtag_ao),
+	FUNCTION(gen_clk_ee),
 };
 
 static struct meson_bank meson_axg_periphs_banks[] = {
diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 2c97a2e07a5f..4ceb06f8a33c 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -243,6 +243,8 @@ static const unsigned int i2s_out_ch67_y_pins[]	= { GPIOY_10 };
 
 static const unsigned int spdif_out_y_pins[]	= { GPIOY_12 };
 
+static const unsigned int gen_clk_out_pins[]	= { GPIOY_15 };
+
 static const struct pinctrl_pin_desc meson_gxbb_aobus_pins[] = {
 	MESON_PIN(GPIOAO_0),
 	MESON_PIN(GPIOAO_1),
@@ -453,6 +455,7 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GROUP(i2s_out_ch45_y,	1,	6),
 	GROUP(i2s_out_ch67_y,	1,	7),
 	GROUP(spdif_out_y,	1,	9),
+	GROUP(gen_clk_out,	6,	15),
 
 	/* Bank Z */
 	GROUP(eth_mdio,		6,	1),
@@ -706,6 +709,10 @@ static const char * const spdif_out_groups[] = {
 	"spdif_out_y",
 };
 
+static const char * const gen_clk_out_groups[] = {
+	"gen_clk_out",
+};
+
 static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
 	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
@@ -790,6 +797,7 @@ static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 	FUNCTION(hdmi_i2c),
 	FUNCTION(i2s_out),
 	FUNCTION(spdif_out),
+	FUNCTION(gen_clk_out),
 };
 
 static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
-- 
2.14.4

