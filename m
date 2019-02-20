Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A29EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DD520823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="niDPt5RK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfBTByD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:54:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42001 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTByB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:54:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id b2so5288021pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 17:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Dlf9v6dnTgQSQXrrmpNU7zWj0OuSqXk5bwXEm/vTKM=;
        b=niDPt5RKv8ZbcMhCxYaqSE8yuZVdgd6rdTFFsz99JImmzywWov0WoSZP1uuJi0qlhu
         uU7qaCrkRlzfBBXWYARwRYMnQqAK9dp2+S5gsBhAgzBvL/PsqJwA4pSlZ5prKun0jpNl
         yC05rKhRcF+6pbtnxpc61kc6Ud094upLqOTR3lXHca05vlhGRDLKCVvi2NIQTwkcalIM
         hbaTcKBVWYhsvJPja6VCf7IcWzbpyH6TcIRASFhs0E6BrSN+F+hueZg6YNcv97MfJVly
         /vf0RWsiC40MKYmmqXFRYcgTjXfYig2WzD1ww42r/AwhIVj3gYAuVKRrj8QjDFLMmqYi
         s9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Dlf9v6dnTgQSQXrrmpNU7zWj0OuSqXk5bwXEm/vTKM=;
        b=BExB53OmgKUmCPzo1U7AppajiPSA5ps+cFzivpxAuEyW6NTkpWWC/hrTz/dYKVQg9J
         /SJ+HHt11Yv6PpDAinPGZLb1MF/dQspwqTY3NXSrwi+y5UKKJ3aCGBDzvg6imdya5x1v
         eaOQyNG+Zc99/+pAJyr6xr0l8xEvtDHMjvqWN31BPl5gsy/9fFm+X9zGlG+weVo6wRvM
         Kq3lQdzuDpnJ8HMbm9KoQC4rcOd2U1/ovC2s8sy+KPmwvewXWV0vYogE03wf5QSIZqr6
         x4fP9mq1DtHHrBm+2hCAaJ5HN4c0RAIGzN0RxC6ObR0Cz99S/2ioUCnDRI3YZuAzOh8j
         mPow==
X-Gm-Message-State: AHQUAuavy9Cx4i0w8UCuYaG/KPPWSK6Yz6cbFKSpfME0Ru3pO7utKm/s
        auQ2fHCBbFndL27hrDG1FgV0Aw==
X-Google-Smtp-Source: AHgI3IYjagtwbtXhFQGXyWIdh+MqBm0lWMXN6xQeL/T2XJN7DTAjezIzKAqufX6KNaKmcPdJ2Zu/vQ==
X-Received: by 2002:a63:2bc6:: with SMTP id r189mr26236366pgr.201.1550627640446;
        Tue, 19 Feb 2019 17:54:00 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id k7sm5605296pgr.28.2019.02.19.17.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 17:53:59 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Zhang <markz@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [RESEND][PATCH 2/2] regulator: max77650: Add missing .owner field in regulator_desc
Date:   Wed, 20 Feb 2019 09:53:28 +0800
Message-Id: <20190220015328.30158-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220015328.30158-1-axel.lin@ingics.com>
References: <20190220015328.30158-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing .owner field in regulator_desc, which is used for refcounting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
This patch was sent on https://lkml.org/lkml/2019/1/30/467

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

