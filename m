Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53B3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFC02084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="OXByrWY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfAXKCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:02:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38577 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbfAXKCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:02:23 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so2447534pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 02:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=CD48K4+Azgz+R4LjJGiWgSBIgTJ2lc3Ldtcmj26AZfY=;
        b=OXByrWY2PfsKY3pO6Osf7tLL5ELM5asbOMTThpvrxOO/bX3bg06eDRdTpYTEijNQD3
         mEBx80cIsVb9ZpY+SE7K9iDkkZjRgoihxd3qYxV6WEkTElHNF0RhRMRCzlU3nuri39Lu
         ePAvC0UeDWYcKVH49j2b58dU0NCHt/02TIBFeQDGkNSJtDz3QRs7G8If0Wnm4pNg/LN2
         7ax7fjhG6qLf6s/3BgAcZywzqKkHaYimXilOesiPWOFk8w7KYbU82C9+37YEg6aWPdgU
         3Au2axhxA/FwAKzxfZRUKmX0yu9btSTZY6W/vQYYL/aQveF85AhyZKUqAeMs9dFua87g
         Y8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CD48K4+Azgz+R4LjJGiWgSBIgTJ2lc3Ldtcmj26AZfY=;
        b=Vfb/6dwgbHUBSWfJm+K5KNKVCU1AFdkUEOMab6fYVtNPYc1Exd+J1YFQYpIbLniJ7e
         9iC0JJqHTnbK10RLxBx2CjYoHzrfPx6dyS6Bd9IWAX0PWx9lwVgjEDOxmJlTHuqw4SoI
         sLEdu0MRvjQE/3bqW/MX24UmN1981zrwAJAlk6PPvE2zgURwXKtsJNrnQ+fiYWsMIHwc
         U1fgtK8JaOT30Pc0X4e/rNQ/LBAWQGch7fGphHZ7nXTO5dNgnf4zk1MkAMi9xkI5AWLj
         k+IvbLrRjZAFrzEKM4KuEeGYCyY4U7VtUv0HrRE4AP3Pzt042qVOGMsqiGfbPeWd8rfQ
         xOIQ==
X-Gm-Message-State: AJcUukffhwxbAlA1ZGrrCI3zi2ZkaZsUQl9R9aAY/IAnKjviSsbRypB1
        cEpoEoYZ0Ms5iYA/yI7V0pvEOA==
X-Google-Smtp-Source: ALg8bN7g/49rL4FpBvtzMdNiUJCA1s44pHfmuw/D9nfEffMnRtw9qByEdXQD12CZ8UVb/dhXQmCs7A==
X-Received: by 2002:a62:fb07:: with SMTP id x7mr5784390pfm.71.1548324141805;
        Thu, 24 Jan 2019 02:02:21 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id h15sm24968523pgl.43.2019.01.24.02.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 02:02:20 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] regulator: bd70528: Constify regulator_linear_range and regulator_ops
Date:   Thu, 24 Jan 2019 18:02:07 +0800
Message-Id: <20190124100209.12275-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd70528-regulator.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index 0cf261c469b9..72c7f9aa84f3 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -21,22 +21,22 @@
 #define BUCK_RAMPRATE_125MV 1
 #define BUCK_RAMP_MAX 250
 
-static struct regulator_linear_range bd70528_buck1_volts[] = {
+static const struct regulator_linear_range bd70528_buck1_volts[] = {
 	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x1, 600000),
 	REGULATOR_LINEAR_RANGE(2750000, 0x2, 0xf, 50000),
 };
-static struct regulator_linear_range bd70528_buck2_volts[] = {
+static const struct regulator_linear_range bd70528_buck2_volts[] = {
 	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x1, 300000),
 	REGULATOR_LINEAR_RANGE(1550000, 0x2, 0xd, 50000),
 	REGULATOR_LINEAR_RANGE(3000000, 0xe, 0xf, 300000),
 };
-static struct regulator_linear_range bd70528_buck3_volts[] = {
+static const struct regulator_linear_range bd70528_buck3_volts[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0x00, 0xd, 50000),
 	REGULATOR_LINEAR_RANGE(1800000, 0xe, 0xf, 0),
 };
 
 /* All LDOs have same voltage ranges */
-static struct regulator_linear_range bd70528_ldo_volts[] = {
+static const struct regulator_linear_range bd70528_ldo_volts[] = {
 	REGULATOR_LINEAR_RANGE(1650000, 0x0, 0x07, 50000),
 	REGULATOR_LINEAR_RANGE(2100000, 0x8, 0x0f, 100000),
 	REGULATOR_LINEAR_RANGE(2850000, 0x10, 0x19, 50000),
@@ -83,7 +83,7 @@ static int bd70528_led_set_voltage_sel(struct regulator_dev *rdev,
 	return -EBUSY;
 }
 
-static struct regulator_ops bd70528_buck_ops = {
+static const struct regulator_ops bd70528_buck_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -94,7 +94,7 @@ static struct regulator_ops bd70528_buck_ops = {
 	.set_ramp_delay = bd70528_set_ramp_delay,
 };
 
-static struct regulator_ops bd70528_ldo_ops = {
+static const struct regulator_ops bd70528_ldo_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -105,7 +105,7 @@ static struct regulator_ops bd70528_ldo_ops = {
 	.set_ramp_delay = bd70528_set_ramp_delay,
 };
 
-static struct regulator_ops bd70528_led_ops = {
+static const struct regulator_ops bd70528_led_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -114,8 +114,7 @@ static struct regulator_ops bd70528_led_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
-
-static struct regulator_desc bd70528_desc[] = {
+static const struct regulator_desc bd70528_desc[] = {
 	{
 		.name = "buck1",
 		.of_match = of_match_ptr("BUCK1"),
-- 
2.17.1

