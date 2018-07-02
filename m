Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E40C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C12254C6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7CE4bqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C12254C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932590AbeGBBSO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:18:14 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40420 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932297AbeGBBSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:18:10 -0400
Received: by mail-qk0-f194.google.com with SMTP id b129-v6so7892613qke.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 18:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lN2Pq1saiBG4wfLJN7GLEiEf8rOPNTtftxsJAbD7OW8=;
        b=h7CE4bqc6jumqzpkJ7mdoGhuWgT04eHrnIk7YtdbtbjTChVAlo5PhVzrocugkWzxuj
         5ijAWPHjCH9poLXTG1vFBkcSYFnOGX12Tlft3rWfzY51AEhGrI2MYQnizwb1WQ70lhP3
         jQJbqYxvQXAtyaGMWHSU2L2GHZ4mQXfFi6HuQDDOlizSq14LyhV9KN85zS5PzbdktyGk
         dbVHOlvSkwsjO6J3g6ICs+q17YPNiKAphV4l46xDBYZp4MlV4Wz8GUn42XAuSTIK0lpU
         gbPs1HGiDWti4YeboO+oeZniXcA1FC0Yc4mAPh73mVwv13QQa9smHcQTIwxwkxFku8IE
         1CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lN2Pq1saiBG4wfLJN7GLEiEf8rOPNTtftxsJAbD7OW8=;
        b=ZvnnPkcaxmvx8qz3bu9UolvOWlIgAIuT8nsdD6176MbKA3owdTxtvAxAOlEy50BF/w
         oi94DxGRiyKV50n9tlCwRwnbfiVfH6WyU5RxFdbtCHtaC8VbmKi/fsxLhqYxvQ1djtZL
         YAO9JagN05JbJRnv4xiu5+5J5v7SOhnzoqQp+rfvBj0iWeqqEDD5vvP13fiHa+U9uNVx
         ESwbEAD9r9G6sb3f4jH/1mWi6FnZSXkerin+BUBZBG1M9cmdKDtqB1CYQEFODh/5mZmG
         deyJkZLYxBvkihByaMyftBcgYQ0rU6Kgld//NNx6i/7XqN2dIPiGiDPoSkqTMBCzSwxa
         0PaQ==
X-Gm-Message-State: APt69E3npH5YqGD7pesvnhU19s49va6E9+5tZEm52gdsPeS/aIukUOoO
        /2Z2ItVgVaIo3Ty7PMZ2LS8=
X-Google-Smtp-Source: AAOMgpcwszhOOxdMxskbzBO+iz2lDLaFx7O+9PHTGQ/lj9PIdCRTcPL1TNavedW/pQdQdyk+VWt1Vw==
X-Received: by 2002:a37:99c3:: with SMTP id b186-v6mr20308645qke.261.1530494290059;
        Sun, 01 Jul 2018 18:18:10 -0700 (PDT)
Received: from localhost.localdomain ([179.156.203.219])
        by smtp.gmail.com with ESMTPSA id q5-v6sm4056269qtp.52.2018.07.01.18.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 18:18:09 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     shawnguo@kernel.org, anson.huang@nxp.com,
        linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] regulator: Revert "regulator: pfuze100: add enable/disable for switch"
Date:   Sun,  1 Jul 2018 22:18:27 -0300
Message-Id: <1530494307-9234-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

This reverts commit 5fe156f1cab4f340ddb6283c993912be77594016.

Commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")
causes boot regression on some platforms such as imx6sl-evk and
imx6sll-evk.

After this commit the SW4 regulator will be turned
off and since it supplies the DDR voltage on these boards, a
kernel hang is observed.

Revert it to avoid breaking old dtb's.

Fixes: 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/regulator/pfuze100-regulator.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 32f9af7..cde6eda 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -163,9 +163,6 @@ static const struct regulator_ops pfuze100_fixed_regulator_ops = {
 };
 
 static const struct regulator_ops pfuze100_sw_regulator_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
 	.list_voltage = regulator_list_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -212,11 +209,6 @@ static const struct regulator_ops pfuze100_swb_regulator_ops = {
 			.uV_step = (step),	\
 			.vsel_reg = (base) + PFUZE100_VOL_OFFSET,	\
 			.vsel_mask = 0x3f,	\
-			.enable_reg = (base) + PFUZE100_MODE_OFFSET,	\
-			.enable_val = 0xc,	\
-			.disable_val = 0x0,	\
-			.enable_mask = 0xf,	\
-			.enable_time = 500,	\
 		},	\
 		.stby_reg = (base) + PFUZE100_STANDBY_OFFSET,	\
 		.stby_mask = 0x3f,	\
-- 
2.7.4

