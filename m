Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFBFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8BF21762
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnev+QDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8BF21762
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeGCFWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:22:11 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46292 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753718AbeGCFWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:22:10 -0400
Received: by mail-qk0-f193.google.com with SMTP id o2-v6so351688qkc.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 22:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IQx5pjRLsKLjf8DcA5JPc/RcuC7gyOtjfxeDUlDRrfU=;
        b=Vnev+QDOcP13dTsQAbAa3eI9wPCo/2bRjeD0tYW50sjsL178fFsEkcSY1d+NuErY4e
         Y/kgN/dQ9NrkLioB2rbZ7CSpe5RFYyUZ+U89hc0fQRojB8jJpZsVNgaru5ol8/LK7xic
         0yOIJjPR06FEqy0Djl5ryXZxaCVXAMTVaoxK/pdHPj4qcw0aHHEWMSyH69IZC2nzQcv6
         3tJojzMM8yF8gMCHdUjEOlefagFlxAQLxiduXGFrRUtyncslwTwn9LQNhdp2Ui3lUBQz
         TEPCOV7FLXdUJKPnPmNnL39je9PC0endz+ZonrwY0ATPL75sVc2lHarBgzr4jMfZZVPO
         6tCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IQx5pjRLsKLjf8DcA5JPc/RcuC7gyOtjfxeDUlDRrfU=;
        b=bQIsiD18bvW9qN5MVJYdNe8jqV1i2V3Yj20DhZ+iJtU/hO61tyqN3kvFgaOWzSqFJR
         Cny82ASivNK74zH0HBa6uhqly9xRHBmkgyPBWubarUI4xBO0DEJYASgsr3P9g3RH0mho
         ih1GMgXLTydCinRodXy22YECR8kXDSsIE7kbmx8a6HdtRxo6oT2lU4BL57wVsRw/83Ni
         +hakDO/iszzhZc4Mt3kWdgdsWiPcU++irNwWVf5pwZKSnhQyOUb4u7hBC6jaP9UyvyWR
         pdPZeTr6SnxV1ncM698ikeXjLjK/S94C8zvfMaCM/2jJ5Uz4X9BuVbfSd+pQuOOUvv+I
         o+Kg==
X-Gm-Message-State: APt69E3mFDTjNrxDnJxjyr+b+JXOPFDmDxJm9GIuZcJLNo4hoQuQuP40
        biNMm4OxGDghQSmfImRxPJQ=
X-Google-Smtp-Source: AAOMgpcToAUSB7Egy/K4f/2nbNjBe5Wy2XiXsUTGBmqqrBIp5lDWPP195YMtuD1yX+WTIXsQXv0Tbg==
X-Received: by 2002:ae9:f449:: with SMTP id z9-v6mr25256586qkl.410.1530595330055;
        Mon, 02 Jul 2018 22:22:10 -0700 (PDT)
Received: from localhost.localdomain (d-74-214-40-72.cpe.metrocast.net. [74.214.40.72])
        by smtp.googlemail.com with ESMTPSA id k8-v6sm254823qti.4.2018.07.02.22.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 22:22:09 -0700 (PDT)
From:   Peter Vernia <peter.vernia@gmail.com>
Cc:     dan.carpenter@oracle.com, Peter Vernia <peter.vernia@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Christian=20L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        NeilBrown <neil@brown.name>, John Crispin <blogic@openwrt.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-pinctrl: Style fixes to pinctrl-rt2880
Date:   Tue,  3 Jul 2018 01:20:47 -0400
Message-Id: <1530595253-6539-1-git-send-email-peter.vernia@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaces instances of "unsigned" with "unsigned int"; fixes comma and tab
spacing.

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

