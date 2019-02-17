Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7235EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F10F222EC
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="kf/v+nsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfBQNs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:48:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41665 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbfBQNs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 08:48:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so7109612pgq.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 05:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J2omg+d01a7cRUxf5JplPdcgtOJxqISNI4t3rCkg27E=;
        b=kf/v+nsanPyTJ6duyep47HwaJqCcReGz5W7sXwkPXaTZIuxfux+zvJj0c/Mvdq66lb
         1zPrcyoNKe4h/ARrRxPS1zQUMQn/zcEB3InSML5il6Dbo3RNVjT18ylVSKVdYnrL9RbP
         80UQ4jvv7HsZRtepHs83ArsijGP8f9sRnYkTRh16UOpJqY66jR7EGKWceay+5tpUFgpI
         QbYyeOXWlVw4759TSYfEJSCCRFh5dTdhoYiZqZc5L61D+1Gfgdridn0pp/w6Claij5q0
         OIVhb9IXMUCtftk30JkfFYCSFI8EgEMkkG6Jmi9FwTolbhLBQo2ZkFo14zuYWu9JaKv9
         IBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J2omg+d01a7cRUxf5JplPdcgtOJxqISNI4t3rCkg27E=;
        b=oBFbe6dkh5kSd9djdiWoPtlVhtGysLsziZ328oVxtPSf2puup/93ly2OgkTtFyeZFt
         OyfUXLysy3RAMubaE465ZRN4RkCtfZpKANGAHSiZEeh1iGpJohdVftbpuVTlLhMs6I5O
         KuD35AdkFP/aQLZTomVvSQOnJ8QDvI65VRvoPzuUWFPCwbIb/ZamrfqewMKva/zZqx7A
         Qy1r+LwZPFmdPPDX7LmZIy+Hs0z8rf6HYQNLVnmA7sIy7VQpayyaEszI08p362Jr4eM0
         nc70m4uGGJ7jFGe7tfCF/DOkPe/zM4HgvXJ9aowCL+0JRLhNmP91g0x3+T62mebfo8mV
         6+bg==
X-Gm-Message-State: AHQUAuYlgCSJTh8nX7I1WIraGw7xR2JMN5LJlQaLOogCQ8SIYY7gOknl
        DbWVei7I4+QC2iIJljpouesXrA==
X-Google-Smtp-Source: AHgI3IZ2KzrbRKFin2xZiaUlg2gMS60809Q4chfeTSbLYV0CAJvCs5QQwH/f26Oozg2NVcDp3JD1bQ==
X-Received: by 2002:a63:2705:: with SMTP id n5mr14551822pgn.429.1550411337014;
        Sun, 17 Feb 2019 05:48:57 -0800 (PST)
Received: from localhost.localdomain (36-239-208-250.dynamic-ip.hinet.net. [36.239.208.250])
        by smtp.gmail.com with ESMTPSA id y13sm10940780pfm.65.2019.02.17.05.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 05:48:56 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolae Rosia <Nicolae_Rosia@mentor.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: twl6030: Constify regulator_ops
Date:   Sun, 17 Feb 2019 21:48:09 +0800
Message-Id: <20190217134809.18108-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190217134809.18108-1-axel.lin@ingics.com>
References: <20190217134809.18108-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/twl6030-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index dcaa6512d760..15f19df6bc5d 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -244,7 +244,7 @@ static int twl6030coresmps_get_voltage(struct regulator_dev *rdev)
 	return -ENODEV;
 }
 
-static struct regulator_ops twl6030coresmps_ops = {
+static const struct regulator_ops twl6030coresmps_ops = {
 	.set_voltage	= twl6030coresmps_set_voltage,
 	.get_voltage	= twl6030coresmps_get_voltage,
 };
@@ -266,7 +266,7 @@ static int twl6030ldo_get_voltage_sel(struct regulator_dev *rdev)
 	return vsel;
 }
 
-static struct regulator_ops twl6030ldo_ops = {
+static const struct regulator_ops twl6030ldo_ops = {
 	.list_voltage	= regulator_list_voltage_linear_range,
 
 	.set_voltage_sel = twl6030ldo_set_voltage_sel,
@@ -281,7 +281,7 @@ static struct regulator_ops twl6030ldo_ops = {
 	.get_status	= twl6030reg_get_status,
 };
 
-static struct regulator_ops twl6030fixed_ops = {
+static const struct regulator_ops twl6030fixed_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 
 	.enable		= twl6030reg_enable,
@@ -472,7 +472,7 @@ static int twl6030smps_get_voltage_sel(struct regulator_dev *rdev)
 	return twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS);
 }
 
-static struct regulator_ops twlsmps_ops = {
+static const struct regulator_ops twlsmps_ops = {
 	.list_voltage		= twl6030smps_list_voltage,
 	.map_voltage		= twl6030smps_map_voltage,
 
-- 
2.17.1

