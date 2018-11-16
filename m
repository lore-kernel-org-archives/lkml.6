Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54E7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801492089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPcUwKTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801492089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389637AbeKPVOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:14:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37503 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389582AbeKPVOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:14:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so10471833pge.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 03:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SRjHqre43wUKPvvX7pz11akDR7cvUF9OTxM3rE3wtFs=;
        b=PPcUwKTDELEs2H6qRWEVBMOqPWZPT1r4mocWQTAPi2KSslFbxMaxJy+M85FunIkHxu
         T2ggfExjh6dD6Hq2yTWuOF2Bp/cic513KqQij3KpckKq6dSq0Ug8XCTq6ayk0ldTcc+O
         1SNUkCNH92XdoWmL/81Yp9FfQFadyMciFaiN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SRjHqre43wUKPvvX7pz11akDR7cvUF9OTxM3rE3wtFs=;
        b=hYediiVrnE1dEVgVsDluJzRhwQ4jo3QUiJMri9lZ8voe1pN6MO+E1vEq73z3FGyA9X
         Ya6/eS6qVtzD4khQ5doP3Z3CtwZSJhahtxUfAMkgnFyxzE0IPbR//3+C2JiwqajFPWdv
         uI8q/DTSNVCJQ1FLqetMfWQUWlOs84RG7vhBDGEENkRG7KctBPxsrBNrP2OjK2xoiIOu
         acoeIoASMs7HxXhAV8uxEDsktnP4HmqsqbXKLASqWLbJxqrMhjrcrEXJp9JE00IBS/db
         i8jb1AjoLFaW43pMInd5RZ5VobnvnKiecrBsdpwZjE+fbedsBpsIv+Ea0g/7gCssyZum
         Rp4w==
X-Gm-Message-State: AGRZ1gJxVI7gbjU5r7vWLNrDo7KdYtbgv8ySzwZIoLyp3LFfOW7u4UZC
        XIfudUU0Xi8vsLsH5sRF/EmGsQ==
X-Google-Smtp-Source: AJdET5fbJ3eNh+INMwDji2/km92/5BoHTI6IynzkyeYkhDhXi8AZyULLU+oszrVc0fbe/zEygstphg==
X-Received: by 2002:a63:d604:: with SMTP id q4mr9374494pgg.175.1542366138298;
        Fri, 16 Nov 2018 03:02:18 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 202sm21268106pfy.87.2018.11.16.03.02.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Nov 2018 03:02:17 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org
Subject: [PATCH 6/6] power: supply: charger-manager: Add new method to start/stop charging
Date:   Fri, 16 Nov 2018 19:01:13 +0800
Message-Id: <c920cab7a1e4caedcab0636eccdebec88fbaab9f.1542362262.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some chargers (such as Spreadtrum SC2731 charger), they don't use
regulators to control charging, instead charging control was implemented
in their drivers, so we can add some supports to start or stop charging
by POWER_SUPPLY_PROP_STATUS property.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/charger-manager.c |   35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 4f28c03..d0d0b82 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -348,6 +348,32 @@ static bool is_polling_required(struct charger_manager *cm)
 	return false;
 }
 
+static int try_charger_enable_by_psy(struct charger_manager *cm, bool enable)
+{
+	struct charger_desc *desc = cm->desc;
+	union power_supply_propval val;
+	struct power_supply *psy;
+	int i, err;
+
+	for (i = 0; desc->psy_charger_stat[i]; i++) {
+		psy = power_supply_get_by_name(desc->psy_charger_stat[i]);
+		if (!psy) {
+			dev_err(cm->dev, "Cannot find power supply \"%s\"\n",
+				desc->psy_charger_stat[i]);
+			continue;
+		}
+
+		val.intval = enable;
+		err = power_supply_set_property(psy, POWER_SUPPLY_PROP_STATUS,
+						&val);
+		power_supply_put(psy);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /**
  * try_charger_enable - Enable/Disable chargers altogether
  * @cm: the Charger Manager representing the battery.
@@ -378,6 +404,10 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 		cm->charging_start_time = ktime_to_ms(ktime_get());
 		cm->charging_end_time = 0;
 
+		err = try_charger_enable_by_psy(cm, enable);
+		if (!err)
+			goto out;
+
 		for (i = 0 ; i < desc->num_charger_regulators ; i++) {
 			if (desc->charger_regulators[i].externally_control)
 				continue;
@@ -396,6 +426,10 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 		cm->charging_start_time = 0;
 		cm->charging_end_time = ktime_to_ms(ktime_get());
 
+		err = try_charger_enable_by_psy(cm, enable);
+		if (!err)
+			goto out;
+
 		for (i = 0 ; i < desc->num_charger_regulators ; i++) {
 			if (desc->charger_regulators[i].externally_control)
 				continue;
@@ -422,6 +456,7 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 		}
 	}
 
+out:
 	if (!err)
 		cm->charger_enabled = enable;
 
-- 
1.7.9.5

