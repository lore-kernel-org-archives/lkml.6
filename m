Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB66FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C0621473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="vTrkBtI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfA3Nvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:51:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43653 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfA3Nvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:51:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so11067423plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4LGoj48btTJiInyHnmdpP/ZMhO9Fb9hDLc+t3Rm/xL0=;
        b=vTrkBtI5WD9Ex78BjKBvMMTg6Jda9IMU67XS1O9OGpINP6UvO+nQ+jgjUrcrW7yh/M
         VansGlQwjn/fOIhdUjAq95HptfkX/IC1AVYrZHFNPlf7u5sL0wXiezlysiBcC2UmuZm5
         3LASrRbiBP+MkJbUWYgiAlWOi9JgujeX1efqXgWsLtOQNQhwdoC46vILhkHbmO3v1d6n
         f2BUG2lKjHucTu6UYxIqv8MFf4zKJnu53GrKCMd/gSgm9RRC0x6h/GqdMU1IJlj776Ea
         KD7kI0asuwfJfb45BtAe4cBFnw3f/+Q1I6qtI7NKtUYY3CNJAYPx0LUuB08Vg84SXrLr
         60kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4LGoj48btTJiInyHnmdpP/ZMhO9Fb9hDLc+t3Rm/xL0=;
        b=n7U5ub7UxA56dGbhtS2n2FzMJhPXPVMkXz1WEP/i+1aw3Duij/ZEzUPqzt6lrXfUMx
         G96FgJ1skrk9Wl3TpSWMZE3kJsB4quUY9xuNZC7YGBzJ/DmJ8zHCZcXiGAA2D2PQNLOy
         fk+6RIGVhWQr1VwSQOKos2Eupob5B5GMEmkQWWG+O6E6OI6M/3x3BGC7CKa4HGV7Gs6H
         L9MBoZuTYJHzVvTsmM27FZaHkFDRZNd2MTKksx++lpeLRWRqwSkVRPtENAtqHp4AX8i/
         PSWmS8M6ACMToZNRn3MtewvvNyE4gIUVRRBkBr6CAOarveSbOm7q3+ND5bS1Nc63+lv7
         VYLA==
X-Gm-Message-State: AJcUukdSU0WpSAOnzkAsYuMkHFG+v7cU/IYtw9RPY5xEZa7ToCsuUofb
        WNplUHh4jRv4da8PXsS6SG8NiQ==
X-Google-Smtp-Source: ALg8bN63aWkwp38uu/E9fTBFkwK2LBLKOv8t6vHOKCU2fxC2JTO4iOVl+fFHdnBw63HrvELjB1uFbw==
X-Received: by 2002:a17:902:33c2:: with SMTP id b60mr30416262plc.211.1548856291540;
        Wed, 30 Jan 2019 05:51:31 -0800 (PST)
Received: from localhost.localdomain (36-239-242-165.dynamic-ip.hinet.net. [36.239.242.165])
        by smtp.gmail.com with ESMTPSA id f20sm2314338pfn.177.2019.01.30.05.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 05:51:30 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: max77650: Add missing .owner field in regulator_desc
Date:   Wed, 30 Jan 2019 21:50:56 +0800
Message-Id: <20190130135056.13535-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130135056.13535-1-axel.lin@ingics.com>
References: <20190130135056.13535-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing .owner field in regulator_desc, which is used for refcounting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max77650-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index 5afb91400832..411912d5278b 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -319,6 +319,7 @@ static struct max77650_regulator_desc max77650_LDO_desc = {
 		.active_discharge_reg	= MAX77650_REG_CNFG_LDO_B,
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
+		.owner			= THIS_MODULE,
 	},
 	.regA		= MAX77650_REG_CNFG_LDO_A,
 	.regB		= MAX77650_REG_CNFG_LDO_B,
@@ -343,6 +344,7 @@ static struct max77650_regulator_desc max77650_SBB0_desc = {
 		.active_discharge_reg	= MAX77650_REG_CNFG_SBB0_B,
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
+		.owner			= THIS_MODULE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB0_A,
 	.regB		= MAX77650_REG_CNFG_SBB0_B,
@@ -367,6 +369,7 @@ static struct max77650_regulator_desc max77650_SBB1_desc = {
 		.active_discharge_reg	= MAX77650_REG_CNFG_SBB1_B,
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
+		.owner			= THIS_MODULE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB1_A,
 	.regB		= MAX77650_REG_CNFG_SBB1_B,
@@ -390,6 +393,7 @@ static struct max77650_regulator_desc max77651_SBB1_desc = {
 		.active_discharge_reg	= MAX77650_REG_CNFG_SBB1_B,
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
+		.owner			= THIS_MODULE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB1_A,
 	.regB		= MAX77650_REG_CNFG_SBB1_B,
@@ -414,6 +418,7 @@ static struct max77650_regulator_desc max77650_SBB2_desc = {
 		.active_discharge_reg	= MAX77650_REG_CNFG_SBB2_B,
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
+		.owner			= THIS_MODULE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB2_A,
 	.regB		= MAX77650_REG_CNFG_SBB2_B,
@@ -438,6 +443,7 @@ static struct max77650_regulator_desc max77651_SBB2_desc = {
 		.active_discharge_reg	= MAX77650_REG_CNFG_SBB2_B,
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
+		.owner			= THIS_MODULE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB2_A,
 	.regB		= MAX77650_REG_CNFG_SBB2_B,
-- 
2.17.1

