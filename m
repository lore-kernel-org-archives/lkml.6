Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD689C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BD020879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="r6gb9Yi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BD020879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeLNIpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:45:43 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:50697 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeLNIpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:45:42 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wBE8iqhk003955;
        Fri, 14 Dec 2018 17:44:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wBE8iqhk003955
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544777093;
        bh=z0uwSdaydpD9I/+05H5gNU+80agE48VVeoYEk5qp76E=;
        h=From:To:Cc:Subject:Date:From;
        b=r6gb9Yi7ZDr/knggZsqBHmv7ZL2UkC0taZyq92EsNMG/chtmLMPTgqyrNNbNhYiKX
         IYHr/mTkcl+AoiBcJsDF3NLTBga/mbPdvrPj+f1F22/fgIqgYQMyLjvbLgAQcyYE87
         9BZ7NMgLyN1WDVEMzix6umYEzzqmq/56Hb+d5FzwaCD7gwwslZyFZTWcxqd2WXgFmY
         FSjPhbRzv4gBYFEn7oTsk9Mhge+RB2mQUqIHiNr7wTin8Bm3ryZfwl8sWiezZbWDTE
         d8QoGUKTTjHNXRrljzxog67bdV4KoPhfWNgnJ2NOtA8TnRhUBawdulfAOP7go/nMZV
         bpWqZcadU4jSQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: uniphier: constify uniphier_pinctrl_socdata
Date:   Fri, 14 Dec 2018 17:44:46 +0900
Message-Id: <1544777086-24510-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are constant data.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 4 ++--
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 2 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c | 2 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  | 2 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c | 2 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 2 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c | 2 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 2 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c | 2 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c | 2 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier.h      | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index add8e87..2b819c1 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -46,7 +46,7 @@ struct uniphier_pinctrl_priv {
 	struct pinctrl_desc pctldesc;
 	struct pinctrl_dev *pctldev;
 	struct regmap *regmap;
-	struct uniphier_pinctrl_socdata *socdata;
+	const struct uniphier_pinctrl_socdata *socdata;
 	struct list_head reg_regions;
 };
 
@@ -869,7 +869,7 @@ const struct dev_pm_ops uniphier_pinctrl_pm_ops = {
 };
 
 int uniphier_pinctrl_probe(struct platform_device *pdev,
-			   struct uniphier_pinctrl_socdata *socdata)
+			   const struct uniphier_pinctrl_socdata *socdata)
 {
 	struct device *dev = &pdev->dev;
 	struct uniphier_pinctrl_priv *priv;
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
index 280dca7..7b61aa4 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -690,7 +690,7 @@ static int uniphier_ld11_get_gpio_muxval(unsigned int pin,
 	return 15;
 }
 
-static struct uniphier_pinctrl_socdata uniphier_ld11_pindata = {
+static const struct uniphier_pinctrl_socdata uniphier_ld11_pindata = {
 	.pins = uniphier_ld11_pins,
 	.npins = ARRAY_SIZE(uniphier_ld11_pins),
 	.groups = uniphier_ld11_groups,
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
index d2d56c9..9850f24 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
@@ -795,7 +795,7 @@ static int uniphier_ld20_get_gpio_muxval(unsigned int pin,
 	return 15;
 }
 
-static struct uniphier_pinctrl_socdata uniphier_ld20_pindata = {
+static const struct uniphier_pinctrl_socdata uniphier_ld20_pindata = {
 	.pins = uniphier_ld20_pins,
 	.npins = ARRAY_SIZE(uniphier_ld20_pins),
 	.groups = uniphier_ld20_groups,
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index 03d87ad..b75844d 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -723,7 +723,7 @@ static int uniphier_ld4_get_gpio_muxval(unsigned int pin,
 	}
 }
 
-static struct uniphier_pinctrl_socdata uniphier_ld4_pindata = {
+static const struct uniphier_pinctrl_socdata uniphier_ld4_pindata = {
 	.pins = uniphier_ld4_pins,
 	.npins = ARRAY_SIZE(uniphier_ld4_pins),
 	.groups = uniphier_ld4_groups,
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
index 31f36ea..9fc2e29 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -938,7 +938,7 @@ static int uniphier_ld6b_get_gpio_muxval(unsigned int pin,
 	return 15;
 }
 
-static struct uniphier_pinctrl_socdata uniphier_ld6b_pindata = {
+static const struct uniphier_pinctrl_socdata uniphier_ld6b_pindata = {
 	.pins = uniphier_ld6b_pins,
 	.npins = ARRAY_SIZE(uniphier_ld6b_pins),
 	.groups = uniphier_ld6b_groups,
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 4326f5c..0de0576 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -1232,7 +1232,7 @@ static int uniphier_pro4_get_gpio_muxval(unsigned int pin,
 	return 7;
 }
 
-static struct uniphier_pinctrl_socdata uniphier_pro4_pindata = {
+static const struct uniphier_pinctrl_socdata uniphier_pro4_pindata = {
 	.pins = uniphier_pro4_pins,
 	.npins = ARRAY_SIZE(uniphier_pro4_pins),
 	.groups = uniphier_pro4_groups,
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
index ae79815..2902ef4 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -996,7 +996,7 @@ static int uniphier_pro5_get_gpio_muxval(unsigned int pin,
 	return 15;
 }
 
-static struct uniphier_pinctrl_socdata uniphier_pro5_pindata = {
+static const struct uniphier_pinctrl_socdata uniphier_pro5_pindata = {
 	.pins = uniphier_pro5_pins,
 	.npins = ARRAY_SIZE(uniphier_pro5_pins),
 	.groups = uniphier_pro5_groups,
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index 7975bd7..42e226b 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -960,7 +960,7 @@ static int uniphier_pxs2_get_gpio_muxval(unsigned int pin,
 	return 15;
 }
 
-static struct uniphier_pinctrl_socdata uniphier_pxs2_pindata = {
+static const struct uniphier_pinctrl_socdata uniphier_pxs2_pindata = {
 	.pins = uniphier_pxs2_pins,
 	.npins = ARRAY_SIZE(uniphier_pxs2_pins),
 	.groups = uniphier_pxs2_groups,
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
index b16ce28..26c6867 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
@@ -971,7 +971,7 @@ static int uniphier_pxs3_get_gpio_muxval(unsigned int pin,
 	return 15;
 }
 
-static struct uniphier_pinctrl_socdata uniphier_pxs3_pindata = {
+static const struct uniphier_pinctrl_socdata uniphier_pxs3_pindata = {
 	.pins = uniphier_pxs3_pins,
 	.npins = ARRAY_SIZE(uniphier_pxs3_pins),
 	.groups = uniphier_pxs3_groups,
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index cb44568..d7f15c6 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -652,7 +652,7 @@ static int uniphier_sld8_get_gpio_muxval(unsigned int pin,
 	}
 }
 
-static struct uniphier_pinctrl_socdata uniphier_sld8_pindata = {
+static const struct uniphier_pinctrl_socdata uniphier_sld8_pindata = {
 	.pins = uniphier_sld8_pins,
 	.npins = ARRAY_SIZE(uniphier_sld8_pins),
 	.groups = uniphier_sld8_groups,
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier.h b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
index c63e3c8..1f32bea 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier.h
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
@@ -190,7 +190,7 @@ struct uniphier_pinctrl_socdata {
 	}
 
 int uniphier_pinctrl_probe(struct platform_device *pdev,
-			   struct uniphier_pinctrl_socdata *socdata);
+			   const struct uniphier_pinctrl_socdata *socdata);
 
 extern const struct dev_pm_ops uniphier_pinctrl_pm_ops;
 
-- 
2.7.4

