Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8502C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951A12081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="XHh5Uhb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951A12081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeKBXcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:32:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39371 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeKBXcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:32:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so1063817pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=w519/YG26fbhkRkJFweLtcv6T6LTAB1HkD6Jg6FYlIA=;
        b=XHh5Uhb80zYjSkaiv/1qBZ7h4kDITFp/Q3TVXaJRHU+ipObgCTKk838lSR/jjS/ckF
         dtbeyS/KdaEfl4Zd55aki8xnoWxgV8nTcPdiUx60VT5cIG738utoouNmUTxAXxgHbT+I
         3f+rVrT+p6+rsm+SImDWSsClOBib5H53O1ETgwPzHJ3sx8/ROW3HQa5vp/NhrXAnGHKK
         QbSuhDyiaLVRtspjo26LzB6Qd1+J1wk9bhWXn2JBzEKSJqmwjJxuSA6qjGa3YrEggama
         lgTXqb9Xq/JCnEWXoOX3FzLH+wseRlIjEjQAXGxtaidn5U87Iff27VqM9DTke4vVjXLl
         vIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w519/YG26fbhkRkJFweLtcv6T6LTAB1HkD6Jg6FYlIA=;
        b=dFBJC+2QlWb9pnJq3zT/esdaxVb82MjkWDpseZ1cFcEorxM9gUkHVCcIbYdwhiUKOG
         D1xImsy8pY4z1fRYoUqPO4Qc6zFTGuHkQjXerlErAosCgKePgMtuoCMZAgT4Xqh7p9U4
         fK3sdkZOZMnjdjn8ZCNJcObn4r0pj9kXXBwwYNJCWBRaAwa5IPMxzq5ZFRCenLJXvV7w
         0qw6RkhPI/Tovlg5KHPM7iDtovBqA1oV3+nwhGFVFGBpH/CIX4ApgbXneTbT7zoEhlMo
         OY/wuGbOpey8SvMiuIVaJa6CZwlT//UVSL2svS4HnM4X56pUlkmp6YfiW78/D8UX9bSj
         0AVQ==
X-Gm-Message-State: AGRZ1gJpXPLgLS61Ni497V3fu1gweNuOK+2gy8YC8cVBceQuM59lQxLf
        2P5tFjOlzARe/ye/iVY1DVbIIw==
X-Google-Smtp-Source: AJdET5etAMEgI94H61ZeBEv+NoQ1alqFstkVJKg+Uw10XeC07QoYRK97xbRt8Wbu5eWmW6xhOLOdow==
X-Received: by 2002:a63:8f09:: with SMTP id n9-v6mr11026252pgd.222.1541168727798;
        Fri, 02 Nov 2018 07:25:27 -0700 (PDT)
Received: from localhost.localdomain (36-237-254-223.dynamic-ip.hinet.net. [36.237.254.223])
        by smtp.gmail.com with ESMTPSA id z63-v6sm38958386pfz.31.2018.11.02.07.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 07:25:26 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     pascal paillet <p.paillet@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: stpmic1: Remove explicitly enable_val and disable_val settings
Date:   Fri,  2 Nov 2018 22:25:15 +0800
Message-Id: <20181102142515.14777-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enable_val is the same as enable_mask and disable_val is 0,
the regulator core will use enable_mask as enable_val by default.
So don't need to explicitly set enable_val and disable_val.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/stpmic1_regulator.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index e15634edb8ce..22d9b5f779c5 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -224,8 +224,6 @@ static struct regulator_ops stpmic1_switch_regul_ops = {
 	.vsel_mask = LDO_VOLTAGE_MASK, \
 	.enable_reg = ids##_ACTIVE_CR, \
 	.enable_mask = LDO_ENABLE_MASK, \
-	.enable_val = 1, \
-	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
 	.pull_down_reg = ids##_PULL_DOWN_REG, \
 	.pull_down_mask = ids##_PULL_DOWN_MASK, \
@@ -245,8 +243,6 @@ static struct regulator_ops stpmic1_switch_regul_ops = {
 	.vsel_mask = LDO_VOLTAGE_MASK, \
 	.enable_reg = LDO3_ACTIVE_CR, \
 	.enable_mask = LDO_ENABLE_MASK, \
-	.enable_val = 1, \
-	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
 	.bypass_reg = LDO3_ACTIVE_CR, \
 	.bypass_mask = LDO_BYPASS_MASK, \
@@ -268,8 +264,6 @@ static struct regulator_ops stpmic1_switch_regul_ops = {
 	.fixed_uV = 3300000, \
 	.enable_reg = LDO4_ACTIVE_CR, \
 	.enable_mask = LDO_ENABLE_MASK, \
-	.enable_val = 1, \
-	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
 	.pull_down_reg = ids##_PULL_DOWN_REG, \
 	.pull_down_mask = ids##_PULL_DOWN_MASK, \
@@ -289,8 +283,6 @@ static struct regulator_ops stpmic1_switch_regul_ops = {
 	.vsel_mask = BUCK_VOLTAGE_MASK, \
 	.enable_reg = ids##_ACTIVE_CR, \
 	.enable_mask = BUCK_ENABLE_MASK, \
-	.enable_val = 1, \
-	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
 	.of_map_mode = stpmic1_map_mode, \
 	.pull_down_reg = ids##_PULL_DOWN_REG, \
@@ -309,15 +301,13 @@ static struct regulator_ops stpmic1_switch_regul_ops = {
 	.fixed_uV = 500000, \
 	.enable_reg = VREF_DDR_ACTIVE_CR, \
 	.enable_mask = BUCK_ENABLE_MASK, \
-	.enable_val = 1, \
-	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
 	.pull_down_reg = ids##_PULL_DOWN_REG, \
 	.pull_down_mask = ids##_PULL_DOWN_MASK, \
 	.supply_name = #base, \
 }
 
-#define REG_SWITCH(ids, base, reg, mask, val) { \
+#define REG_SWITCH(ids, base, reg, mask) { \
 	.name = #ids, \
 	.id = STPMIC1_##ids, \
 	.n_voltages = 1, \
@@ -328,8 +318,6 @@ static struct regulator_ops stpmic1_switch_regul_ops = {
 	.fixed_uV = 5000000, \
 	.enable_reg = (reg), \
 	.enable_mask = (mask), \
-	.enable_val = (val), \
-	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
 	.supply_name = #base, \
 }
@@ -412,21 +400,18 @@ struct stpmic1_regulator_cfg stpmic1_regulator_cfgs[] = {
 	},
 	[STPMIC1_BOOST] = {
 		.desc = REG_SWITCH(BOOST, boost, BST_SW_CR,
-				   BOOST_ENABLED,
 				   BOOST_ENABLED),
 		.icc_reg = BUCKS_ICCTO_CR,
 		.icc_mask = BIT(6),
 	},
 	[STPMIC1_VBUS_OTG] = {
 		.desc = REG_SWITCH(VBUS_OTG, pwr_sw1, BST_SW_CR,
-				   USBSW_OTG_SWITCH_ENABLED,
 				   USBSW_OTG_SWITCH_ENABLED),
 		.icc_reg = BUCKS_ICCTO_CR,
 		.icc_mask = BIT(4),
 	},
 	[STPMIC1_SW_OUT] = {
 		.desc = REG_SWITCH(SW_OUT, pwr_sw2, BST_SW_CR,
-				   SWIN_SWOUT_ENABLED,
 				   SWIN_SWOUT_ENABLED),
 		.icc_reg = BUCKS_ICCTO_CR,
 		.icc_mask = BIT(5),
-- 
2.17.1

