Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84894C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F7B2562B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx82h0Ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F7B2562B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeF3RUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 13:20:38 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38167 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeF3RUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 13:20:37 -0400
Received: by mail-qk0-f193.google.com with SMTP id y4-v6so6680524qka.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JXJCfCZvXkVY2Xw2VARq+JOK/pUAVqrMyUzXG1Uv3g0=;
        b=Tx82h0TsHMH02lMUTYas4qHs1U0kzdLEbFKpdKQV3H/OtVY2ZAoywiMpG9L9lfBP8S
         uoAF0g5wyM8QOxhT1LZr14zWFPdzGEouVLO2KXguh5ZPgSf9UcSP69Dvwvzm77eoHNKy
         JY4xLj6vzbaiD6255xHBlTH8gvnE4FbbL5XjPWkxPeEIMCursTgLRotlSAML9CemVrJC
         rdujwb47hQWxHUHXgHbeCqm7KEjJdi9YE7Ovz2cfR0L0riJUbJEdGxf4eNlKxBt0f8/a
         7LQ9seUINb3oqiTx4mNvejN6I7AqIxOguz0VBGCm9jUMqqgkfNFwoxo2P9PIAtMmLIpi
         WcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JXJCfCZvXkVY2Xw2VARq+JOK/pUAVqrMyUzXG1Uv3g0=;
        b=LIJ4VOYcJwkbi3dZN84/LApRvwC/QCi4JwZiZFq1qNIfOUniqSzRcZ2wlQXg9Hqov5
         NTRKdYlkFy1m9AFh7mX/Yul2ZZL5O66gEyO0qMCrHMdtdmyP4l7JVixPjy6U5YnDliOj
         PYDwbuvOaz8ieJc5BKacVIyIZYWvizcIkDHES0poZJEDIkAVBRdvMnU0cSQbiAayECn7
         n+1rneek9S2xrJchUSlh3ZyX2qUTDZV0tVD2CibsptXiacG7z345hOYnPDZxQWHS5G/Z
         p6NuCcoGfSxukPnTfEdZmR3a1VtTTFUa3IBIHxIiNbC1YE0HZFdhoYTtYUOhtutpi526
         K5cQ==
X-Gm-Message-State: APt69E0gH3Oc0k+Av9nG8Tj7uXd53muJskT3g2xOk5Z4B0edtqRWXn8+
        Ii5IMlOWlLdUffdAkrrAWtc=
X-Google-Smtp-Source: AAOMgpciIaP3jKbcBkbin66v72l84LY7Pk9wL7gxYOHVc6OApyM+SU8jdiVNGzTcf1vNku6fraoxmg==
X-Received: by 2002:a37:7101:: with SMTP id m1-v6mr16934037qkc.19.1530379236840;
        Sat, 30 Jun 2018 10:20:36 -0700 (PDT)
Received: from localhost.localdomain (d-74-214-40-72.cpe.metrocast.net. [74.214.40.72])
        by smtp.googlemail.com with ESMTPSA id t12-v6sm6891625qtn.86.2018.06.30.10.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jun 2018 10:20:36 -0700 (PDT)
From:   Peter Vernia <peter.vernia@gmail.com>
Cc:     Peter Vernia <peter.vernia@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Christian=20L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        John Crispin <blogic@openwrt.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-pinctrl: Replaces "unsigned" with "unsigned int", fixes mixed indentation, and puts spaces after commas.
Date:   Sat, 30 Jun 2018 13:17:29 -0400
Message-Id: <1530379055-6713-1-git-send-email-peter.vernia@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Peter Vernia <peter.vernia@gmail.com>
---
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 35 +++++++++++++------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
index 0c3e498..6894510 100644
--- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -54,7 +54,7 @@ static int rt2880_get_group_count(struct pinctrl_dev *pctrldev)
 }
 
 static const char *rt2880_get_group_name(struct pinctrl_dev *pctrldev,
-					 unsigned group)
+					 unsigned int group)
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
 
@@ -65,9 +65,9 @@ static const char *rt2880_get_group_name(struct pinctrl_dev *pctrldev,
 }
 
 static int rt2880_get_group_pins(struct pinctrl_dev *pctrldev,
-				 unsigned group,
-				 const unsigned **pins,
-				 unsigned *num_pins)
+				 unsigned int group,
+				 const unsigned int **pins,
+				 unsigned int *num_pins)
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
 
@@ -81,7 +81,8 @@ static int rt2880_get_group_pins(struct pinctrl_dev *pctrldev,
 }
 
 static void rt2880_pinctrl_dt_free_map(struct pinctrl_dev *pctrldev,
-				    struct pinctrl_map *map, unsigned num_maps)
+				    struct pinctrl_map *map,
+				    unsigned int num_maps)
 {
 	int i;
 
@@ -94,7 +95,7 @@ static void rt2880_pinctrl_dt_free_map(struct pinctrl_dev *pctrldev,
 
 static void rt2880_pinctrl_pin_dbg_show(struct pinctrl_dev *pctrldev,
 					struct seq_file *s,
-					unsigned offset)
+					unsigned int offset)
 {
 	seq_printf(s, "ralink pio");
 }
@@ -103,7 +104,7 @@ static void rt2880_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctrldev,
 				struct device_node *np,
 				struct pinctrl_map **map)
 {
-        const char *function;
+	const char *function;
 	int func = of_property_read_string(np, "ralink,function", &function);
 	int grps = of_property_count_strings(np, "ralink,group");
 	int i;
@@ -112,7 +113,7 @@ static void rt2880_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctrldev,
 		return;
 
 	for (i = 0; i < grps; i++) {
-	        const char *group;
+		const char *group;
 
 		of_property_read_string_index(np, "ralink,group", i, &group);
 
@@ -127,7 +128,7 @@ static void rt2880_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctrldev,
 static int rt2880_pinctrl_dt_node_to_map(struct pinctrl_dev *pctrldev,
 				struct device_node *np_config,
 				struct pinctrl_map **map,
-				unsigned *num_maps)
+				unsigned int *num_maps)
 {
 	int max_maps = 0;
 	struct pinctrl_map *tmp;
@@ -173,7 +174,7 @@ static int rt2880_pmx_func_count(struct pinctrl_dev *pctrldev)
 }
 
 static const char *rt2880_pmx_func_name(struct pinctrl_dev *pctrldev,
-					 unsigned func)
+					 unsigned int func)
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
 
@@ -181,7 +182,7 @@ static const char *rt2880_pmx_func_name(struct pinctrl_dev *pctrldev,
 }
 
 static int rt2880_pmx_group_get_groups(struct pinctrl_dev *pctrldev,
-				unsigned func,
+				unsigned int func,
 				const char * const **groups,
 				unsigned * const num_groups)
 {
@@ -198,11 +199,11 @@ static int rt2880_pmx_group_get_groups(struct pinctrl_dev *pctrldev,
 }
 
 static int rt2880_pmx_group_enable(struct pinctrl_dev *pctrldev,
-				unsigned func,
-				unsigned group)
+				unsigned int func,
+				unsigned int group)
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
-        u32 mode = 0;
+	u32 mode = 0;
 	u32 reg = SYSC_REG_GPIO_MODE;
 	int i;
 	int shift;
@@ -243,7 +244,7 @@ static int rt2880_pmx_group_enable(struct pinctrl_dev *pctrldev,
 
 static int rt2880_pmx_group_gpio_request_enable(struct pinctrl_dev *pctrldev,
 				struct pinctrl_gpio_range *range,
-				unsigned pin)
+				unsigned int pin)
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
 
@@ -355,13 +356,13 @@ static int rt2880_pinmux_pins(struct rt2880_priv *p)
 	}
 
 	/* the buffer that tells us which pins are gpio */
-	p->gpio = devm_kcalloc(p->dev,p->max_pins, sizeof(uint8_t),
+	p->gpio = devm_kcalloc(p->dev, p->max_pins, sizeof(uint8_t),
 			       GFP_KERNEL);
 	/* the pads needed to tell pinctrl about our pins */
 	p->pads = devm_kcalloc(p->dev,
 		p->max_pins, sizeof(struct pinctrl_pin_desc),
 		GFP_KERNEL);
-	if (!p->pads || !p->gpio ) {
+	if (!p->pads || !p->gpio) {
 		dev_err(p->dev, "Failed to allocate gpio data\n");
 		return -ENOMEM;
 	}
-- 
2.7.4

