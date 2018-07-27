Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515F8C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1578C20891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1578C20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbeG0D5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:57:25 -0400
Received: from mx.socionext.com ([202.248.49.38]:23204 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731974AbeG0D5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:57:25 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 27 Jul 2018 11:37:47 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 2A042180D65;
        Fri, 27 Jul 2018 11:37:47 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 27 Jul 2018 11:37:47 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id B810240176;
        Fri, 27 Jul 2018 11:37:46 +0900 (JST)
Received: from aegis.e01.socionext.com (unknown [10.213.134.210])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 919CF120448;
        Fri, 27 Jul 2018 11:37:46 +0900 (JST)
From:   Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] ASoC: uniphier: change functions to static
Date:   Fri, 27 Jul 2018 11:37:44 +0900
Message-Id: <20180727023744.7865-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes some functions that are not used by other objects
to static.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 sound/soc/uniphier/aio-core.c | 6 +++---
 sound/soc/uniphier/aio.h      | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 8b09bbb0f8d0..9bcba06ba52e 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -327,7 +327,7 @@ static int aio_port_set_ch(struct uniphier_aio_sub *sub)
  *
  * Return: Zero if successful, otherwise a negative value on error.
  */
-int aio_port_set_rate(struct uniphier_aio_sub *sub, int rate)
+static int aio_port_set_rate(struct uniphier_aio_sub *sub, int rate)
 {
 	struct regmap *r = sub->aio->chip->regmap;
 	struct device *dev = &sub->aio->chip->pdev->dev;
@@ -446,7 +446,7 @@ int aio_port_set_rate(struct uniphier_aio_sub *sub, int rate)
  *
  * Return: Zero if successful, otherwise a negative value on error.
  */
-int aio_port_set_fmt(struct uniphier_aio_sub *sub)
+static int aio_port_set_fmt(struct uniphier_aio_sub *sub)
 {
 	struct regmap *r = sub->aio->chip->regmap;
 	struct device *dev = &sub->aio->chip->pdev->dev;
@@ -511,7 +511,7 @@ int aio_port_set_fmt(struct uniphier_aio_sub *sub)
  *
  * Return: Zero if successful, otherwise a negative value on error.
  */
-int aio_port_set_clk(struct uniphier_aio_sub *sub)
+static int aio_port_set_clk(struct uniphier_aio_sub *sub)
 {
 	struct uniphier_aio_chip *chip = sub->aio->chip;
 	struct device *dev = &sub->aio->chip->pdev->dev;
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index 23a5c3c68658..ca6ccbae0ee8 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -325,9 +325,6 @@ int aio_chip_set_pll(struct uniphier_aio_chip *chip, int pll_id,
 void aio_chip_init(struct uniphier_aio_chip *chip);
 int aio_init(struct uniphier_aio_sub *sub);
 void aio_port_reset(struct uniphier_aio_sub *sub);
-int aio_port_set_rate(struct uniphier_aio_sub *sub, int rate);
-int aio_port_set_fmt(struct uniphier_aio_sub *sub);
-int aio_port_set_clk(struct uniphier_aio_sub *sub);
 int aio_port_set_param(struct uniphier_aio_sub *sub, int pass_through,
 		       const struct snd_pcm_hw_params *params);
 void aio_port_set_enable(struct uniphier_aio_sub *sub, int enable);
-- 
2.18.0

