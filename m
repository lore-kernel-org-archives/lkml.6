Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DF4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFEE20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFEE20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbeGSHDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:03:02 -0400
Received: from mx.socionext.com ([202.248.49.38]:35921 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbeGSHDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:03:02 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Jul 2018 15:21:30 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id D519F60034;
        Thu, 19 Jul 2018 15:21:30 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 19 Jul 2018 15:21:30 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 16E1F1A11BB;
        Thu, 19 Jul 2018 15:21:30 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     linus.walleij@linaro.org, yamada.masahiro@socionext.com,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] pinctrl: uniphier: add spi pin-mux settings
Date:   Thu, 19 Jul 2018 15:20:49 +0900
Message-Id: <1531981249-26329-1-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Add pin-mux settings for spi controller.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 10 ++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c | 20 ++++++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  |  5 +++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c | 10 ++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 10 ++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c | 15 +++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 10 ++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c | 10 ++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c |  5 +++++
 9 files changed, 95 insertions(+)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
index 58825f6..bce533f 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -517,6 +517,10 @@ static const int i2c4_muxvals[] = {1, 1};
 static const unsigned nand_pins[] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
 				     15, 16, 17};
 static const int nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned spi0_pins[] = {56, 57, 58, 59};
+static const int spi0_muxvals[] = {0, 0, 0, 0};
+static const unsigned spi1_pins[] = {169, 170, 171, 172};
+static const int spi1_muxvals[] = {1, 1, 1, 1};
 static const unsigned system_bus_pins[] = {1, 2, 6, 7, 8, 9, 10, 11, 12, 13,
 					   14, 15, 16, 17};
 static const int system_bus_muxvals[] = {0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
@@ -596,6 +600,8 @@ static const struct uniphier_pinctrl_group uniphier_ld11_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c3),
 	UNIPHIER_PINCTRL_GROUP(i2c4),
 	UNIPHIER_PINCTRL_GROUP(nand),
+	UNIPHIER_PINCTRL_GROUP(spi0),
+	UNIPHIER_PINCTRL_GROUP(spi1),
 	UNIPHIER_PINCTRL_GROUP(system_bus),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
 	UNIPHIER_PINCTRL_GROUP(uart0),
@@ -632,6 +638,8 @@ static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const i2c4_groups[] = {"i2c4"};
 static const char * const nand_groups[] = {"nand"};
+static const char * const spi0_groups[] = {"spi0"};
+static const char * const spi1_groups[] = {"spi1"};
 static const char * const system_bus_groups[] = {"system_bus",
 						 "system_bus_cs1"};
 static const char * const uart0_groups[] = {"uart0"};
@@ -657,6 +665,8 @@ static const struct uniphier_pinmux_function uniphier_ld11_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(i2c4),
 	UNIPHIER_PINMUX_FUNCTION(nand),
+	UNIPHIER_PINMUX_FUNCTION(spi0),
+	UNIPHIER_PINMUX_FUNCTION(spi1),
 	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
index 9f449b3..99f06fe 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
@@ -606,6 +606,14 @@ static const unsigned nand_pins[] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
 static const int nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned sd_pins[] = {10, 11, 12, 13, 14, 15, 16, 17};
 static const int sd_muxvals[] = {3, 3, 3, 3, 3, 3, 3, 3};  /* No SDVOLC */
+static const unsigned spi0_pins[] = {56, 57, 58, 59};
+static const int spi0_muxvals[] = {0, 0, 0, 0};
+static const unsigned spi1_pins[] = {169, 170, 171, 172};
+static const int spi1_muxvals[] = {1, 1, 1, 1};
+static const unsigned spi2_pins[] = {86, 87, 88, 89};
+static const int spi2_muxvals[] = {1, 1, 1, 1};
+static const unsigned spi3_pins[] = {74, 75, 76, 77};
+static const int spi3_muxvals[] = {1, 1, 1, 1};
 static const unsigned system_bus_pins[] = {1, 2, 6, 7, 8, 9, 10, 11, 12, 13,
 					   14, 15, 16, 17};
 static const int system_bus_muxvals[] = {0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
@@ -685,6 +693,10 @@ static const struct uniphier_pinctrl_group uniphier_ld20_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c4),
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(sd),
+	UNIPHIER_PINCTRL_GROUP(spi0),
+	UNIPHIER_PINCTRL_GROUP(spi1),
+	UNIPHIER_PINCTRL_GROUP(spi2),
+	UNIPHIER_PINCTRL_GROUP(spi3),
 	UNIPHIER_PINCTRL_GROUP(system_bus),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
 	UNIPHIER_PINCTRL_GROUP(uart0),
@@ -722,6 +734,10 @@ static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const i2c4_groups[] = {"i2c4"};
 static const char * const nand_groups[] = {"nand"};
 static const char * const sd_groups[] = {"sd"};
+static const char * const spi0_groups[] = {"spi0"};
+static const char * const spi1_groups[] = {"spi1"};
+static const char * const spi2_groups[] = {"spi2"};
+static const char * const spi3_groups[] = {"spi3"};
 static const char * const system_bus_groups[] = {"system_bus",
 						 "system_bus_cs1"};
 static const char * const uart0_groups[] = {"uart0"};
@@ -751,6 +767,10 @@ static const struct uniphier_pinmux_function uniphier_ld20_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c4),
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(sd),
+	UNIPHIER_PINMUX_FUNCTION(spi0),
+	UNIPHIER_PINMUX_FUNCTION(spi1),
+	UNIPHIER_PINMUX_FUNCTION(spi2),
+	UNIPHIER_PINMUX_FUNCTION(spi3),
 	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index 0b10ebc..b247011 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -576,6 +576,8 @@ static const unsigned nand_cs1_pins[] = {22, 23};
 static const int nand_cs1_muxvals[] = {0, 0};
 static const unsigned sd_pins[] = {44, 45, 46, 47, 48, 49, 50, 51, 52};
 static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned spi0_pins[] = {135, 136, 137, 138};
+static const int spi0_muxvals[] = {12, 12, 12, 12};
 static const unsigned system_bus_pins[] = {16, 17, 18, 19, 20, 165, 166, 167,
 					   168, 169, 170, 171, 172, 173};
 static const int system_bus_muxvals[] = {0, 0, 0, 0, 0, -1, -1, -1, -1, -1, -1,
@@ -640,6 +642,7 @@ static const struct uniphier_pinctrl_group uniphier_ld4_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
 	UNIPHIER_PINCTRL_GROUP(sd),
+	UNIPHIER_PINCTRL_GROUP(spi0),
 	UNIPHIER_PINCTRL_GROUP(system_bus),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs0),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
@@ -667,6 +670,7 @@ static const char * const i2c2_groups[] = {"i2c2"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
 static const char * const sd_groups[] = {"sd"};
+static const char * const spi0_groups[] = {"spi0"};
 static const char * const system_bus_groups[] = {"system_bus",
 						 "system_bus_cs0",
 						 "system_bus_cs1",
@@ -690,6 +694,7 @@ static const struct uniphier_pinmux_function uniphier_ld4_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(sd),
+	UNIPHIER_PINMUX_FUNCTION(spi0),
 	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
index 8e4d45fe..cb58797 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -769,6 +769,10 @@ static const unsigned nand_cs1_pins[] = {37, 38};
 static const int nand_cs1_muxvals[] = {0, 0};
 static const unsigned sd_pins[] = {47, 48, 49, 50, 51, 52, 53, 54, 55};
 static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned spi0_pins[] = {199, 200, 201, 202};
+static const int spi0_muxvals[] = {8, 8, 8, 8};
+static const unsigned spi1_pins[] = {93, 94, 95, 96};
+static const int spi1_muxvals[] = {1, 1, 1, 1};
 static const unsigned system_bus_pins[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
 					   11, 12, 13};
 static const int system_bus_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -851,6 +855,8 @@ static const struct uniphier_pinctrl_group uniphier_ld6b_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
 	UNIPHIER_PINCTRL_GROUP(sd),
+	UNIPHIER_PINCTRL_GROUP(spi0),
+	UNIPHIER_PINCTRL_GROUP(spi1),
 	UNIPHIER_PINCTRL_GROUP(system_bus),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs2),
@@ -882,6 +888,8 @@ static const char * const i2c2_groups[] = {"i2c2"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
 static const char * const sd_groups[] = {"sd"};
+static const char * const spi0_groups[] = {"spi0"};
+static const char * const spi1_groups[] = {"spi1"};
 static const char * const system_bus_groups[] = {"system_bus",
 						 "system_bus_cs1",
 						 "system_bus_cs2",
@@ -907,6 +915,8 @@ static const struct uniphier_pinmux_function uniphier_ld6b_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(sd),
+	UNIPHIER_PINMUX_FUNCTION(spi0),
+	UNIPHIER_PINMUX_FUNCTION(spi1),
 	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 24788a7..89148f8 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -1050,6 +1050,10 @@ static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned sd1_pins[] = {319, 320, 321, 322, 323, 324, 325, 326,
 				    327};
 static const int sd1_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned spi0_pins[] = {199, 200, 201, 202};
+static const int spi0_muxvals[] = {11, 11, 11, 11};
+static const unsigned spi1_pins[] = {195, 196, 197, 198, 235, 238, 239};
+static const int spi1_muxvals[] = {11, 11, 11, 11, 11, 11, 11};
 static const unsigned system_bus_pins[] = {25, 26, 27, 28, 29, 30, 31, 32, 33,
 					   34, 35, 36, 37, 38};
 static const int system_bus_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -1138,6 +1142,8 @@ static const struct uniphier_pinctrl_group uniphier_pro4_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
 	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP(sd1),
+	UNIPHIER_PINCTRL_GROUP(spi0),
+	UNIPHIER_PINCTRL_GROUP(spi1),
 	UNIPHIER_PINCTRL_GROUP(system_bus),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs0),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
@@ -1171,6 +1177,8 @@ static const char * const i2c6_groups[] = {"i2c6"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
 static const char * const sd_groups[] = {"sd"};
 static const char * const sd1_groups[] = {"sd1"};
+static const char * const spi0_groups[] = {"spi0"};
+static const char * const spi1_groups[] = {"spi1"};
 static const char * const system_bus_groups[] = {"system_bus",
 						 "system_bus_cs0",
 						 "system_bus_cs1",
@@ -1202,6 +1210,8 @@ static const struct uniphier_pinmux_function uniphier_pro4_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(sd),
 	UNIPHIER_PINMUX_FUNCTION(sd1),
+	UNIPHIER_PINMUX_FUNCTION(spi0),
+	UNIPHIER_PINMUX_FUNCTION(spi1),
 	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
index d5d5e57..d77d6b37 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -818,6 +818,12 @@ static const unsigned nand_cs1_pins[] = {26, 27};
 static const int nand_cs1_muxvals[] = {0, 0};
 static const unsigned sd_pins[] = {250, 251, 252, 253, 254, 255, 256, 257, 258};
 static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned spi0_pins[] = {120, 121, 122, 123};
+static const int spi0_muxvals[] = {0, 0, 0, 0};
+static const unsigned spi1_pins[] = {134, 139, 85, 86};
+static const int spi1_muxvals[] = {1, 1, 1, 1};
+static const unsigned spi2_pins[] = {55, 56, 57, 58, 82, 83, 84};
+static const int spi2_muxvals[] = {0, 0, 0, 0, 1, 1, 1};
 static const unsigned system_bus_pins[] = {4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
 					   14, 15, 16, 17};
 static const int system_bus_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -904,6 +910,9 @@ static const struct uniphier_pinctrl_group uniphier_pro5_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c5c),
 	UNIPHIER_PINCTRL_GROUP(i2c6),
 	UNIPHIER_PINCTRL_GROUP(sd),
+	UNIPHIER_PINCTRL_GROUP(spi0),
+	UNIPHIER_PINCTRL_GROUP(spi1),
+	UNIPHIER_PINCTRL_GROUP(spi2),
 	UNIPHIER_PINCTRL_GROUP(system_bus),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs0),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
@@ -934,6 +943,9 @@ static const char * const i2c5_groups[] = {"i2c5", "i2c5b", "i2c5c"};
 static const char * const i2c6_groups[] = {"i2c6"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
 static const char * const sd_groups[] = {"sd"};
+static const char * const spi0_groups[] = {"spi0"};
+static const char * const spi1_groups[] = {"spi1"};
+static const char * const spi2_groups[] = {"spi2"};
 static const char * const system_bus_groups[] = {"system_bus",
 						 "system_bus_cs0",
 						 "system_bus_cs1",
@@ -961,6 +973,9 @@ static const struct uniphier_pinmux_function uniphier_pro5_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c6),
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(sd),
+	UNIPHIER_PINMUX_FUNCTION(spi0),
+	UNIPHIER_PINMUX_FUNCTION(spi1),
+	UNIPHIER_PINMUX_FUNCTION(spi2),
 	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index 032619a..90199da 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -778,6 +778,10 @@ static const unsigned nand_cs1_pins[] = {37, 38};
 static const int nand_cs1_muxvals[] = {8, 8};
 static const unsigned sd_pins[] = {47, 48, 49, 50, 51, 52, 53, 54, 55};
 static const int sd_muxvals[] = {8, 8, 8, 8, 8, 8, 8, 8, 8};
+static const unsigned spi0_pins[] = {199, 200, 201, 202};
+static const int spi0_muxvals[] = {8, 8, 8, 8};
+static const unsigned spi1_pins[] = {93, 94, 95, 96};
+static const int spi1_muxvals[] = {1, 1, 1, 1};
 static const unsigned system_bus_pins[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
 					   11, 12, 13};
 static const int system_bus_muxvals[] = {8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
@@ -861,6 +865,8 @@ static const struct uniphier_pinctrl_group uniphier_pxs2_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
 	UNIPHIER_PINCTRL_GROUP(sd),
+	UNIPHIER_PINCTRL_GROUP(spi0),
+	UNIPHIER_PINCTRL_GROUP(spi1),
 	UNIPHIER_PINCTRL_GROUP(system_bus),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
 	UNIPHIER_PINCTRL_GROUP(uart0),
@@ -897,6 +903,8 @@ static const char * const i2c5_groups[] = {"i2c5"};
 static const char * const i2c6_groups[] = {"i2c6"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
 static const char * const sd_groups[] = {"sd"};
+static const char * const spi0_groups[] = {"spi0"};
+static const char * const spi1_groups[] = {"spi1"};
 static const char * const system_bus_groups[] = {"system_bus",
 						 "system_bus_cs1"};
 static const char * const uart0_groups[] = {"uart0", "uart0b", "uart0b_ctsrts"};
@@ -928,6 +936,8 @@ static const struct uniphier_pinmux_function uniphier_pxs2_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c6),
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(sd),
+	UNIPHIER_PINMUX_FUNCTION(spi0),
+	UNIPHIER_PINMUX_FUNCTION(spi1),
 	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
index 535bb2e..3b860da 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
@@ -808,6 +808,10 @@ static const unsigned int nand_pins[] = {16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
 static const int nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned int sd_pins[] = {43, 44, 45, 46, 47, 48, 49, 50, 51};
 static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned spi0_pins[] = {100, 101, 102, 103};
+static const int spi0_muxvals[] = {0, 0, 0, 0};
+static const unsigned spi1_pins[] = {112, 113, 114, 115};
+static const int spi1_muxvals[] = {2, 2, 2, 2};
 static const unsigned int system_bus_pins[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
 					       11, 12, 13, 14};
 static const int system_bus_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -886,6 +890,8 @@ static const struct uniphier_pinctrl_group uniphier_pxs3_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c3),
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(sd),
+	UNIPHIER_PINCTRL_GROUP(spi0),
+	UNIPHIER_PINCTRL_GROUP(spi1),
 	UNIPHIER_PINCTRL_GROUP(system_bus),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
 	UNIPHIER_PINCTRL_GROUP(uart0),
@@ -913,6 +919,8 @@ static const char * const i2c2_groups[] = {"i2c2"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const nand_groups[] = {"nand"};
 static const char * const sd_groups[] = {"sd"};
+static const char * const spi0_groups[] = {"spi0"};
+static const char * const spi1_groups[] = {"spi1"};
 static const char * const system_bus_groups[] = {"system_bus",
 						 "system_bus_cs1"};
 static const char * const uart0_groups[] = {"uart0", "uart0_ctsrts"};
@@ -936,6 +944,8 @@ static const struct uniphier_pinmux_function uniphier_pxs3_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(sd),
+	UNIPHIER_PINMUX_FUNCTION(spi0),
+	UNIPHIER_PINMUX_FUNCTION(spi1),
 	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index 0f921a6..f912999 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -504,6 +504,8 @@ static const unsigned nand_cs1_pins[] = {22, 23};
 static const int nand_cs1_muxvals[] = {0, 0};
 static const unsigned sd_pins[] = {32, 33, 34, 35, 36, 37, 38, 39, 40};
 static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned spi0_pins[] = {118, 119, 120, 121};
+static const int spi0_muxvals[] = {3, 3, 3, 3};
 static const unsigned system_bus_pins[] = {136, 137, 138, 139, 140, 141, 142,
 					   143, 144, 145, 146, 147, 148, 149};
 static const int system_bus_muxvals[] = {-1, -1, -1, -1, -1, -1, -1, -1, -1,
@@ -570,6 +572,7 @@ static const struct uniphier_pinctrl_group uniphier_sld8_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
 	UNIPHIER_PINCTRL_GROUP(sd),
+	UNIPHIER_PINCTRL_GROUP(spi0),
 	UNIPHIER_PINCTRL_GROUP(system_bus),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs2),
@@ -598,6 +601,7 @@ static const char * const i2c2_groups[] = {"i2c2"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
 static const char * const sd_groups[] = {"sd"};
+static const char * const spi_groups[] = {"spi0"};
 static const char * const system_bus_groups[] = {"system_bus",
 						 "system_bus_cs1",
 						 "system_bus_cs2",
@@ -622,6 +626,7 @@ static const struct uniphier_pinmux_function uniphier_sld8_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(sd),
+	UNIPHIER_PINMUX_FUNCTION(spi0),
 	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
-- 
2.7.4

