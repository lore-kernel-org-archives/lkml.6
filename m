Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDD2C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4588D20890
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cU9Bkj7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4588D20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeJOPyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:54:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39107 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeJOPyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:54:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so8901766plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AsySyd/VQYHHdyKEmHc5zLQv0326ukYcdPej0PIdj+g=;
        b=cU9Bkj7mGROw/PbCt/yCcVNKYTC7fexMcaWWdndev5ZTIh/0N9H6YVyiEHUbjN2VIf
         cmsgWHPFSBQd3ADW8+KhnaOY2YC6mnLzZw04X96yyZSRCUtXYHkE2RXNwgExxTf2bJOg
         3/eaZtspi+twinI4xfTClneGh1B+v31ECoP24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AsySyd/VQYHHdyKEmHc5zLQv0326ukYcdPej0PIdj+g=;
        b=NIyDs1cHilVkYeCrM8qiGQqrgbYPnp/VHtBntHPmCt9ecuq7PVXdAm+dxtwrfbJabV
         s0+2fqeR6ktKF/y5JXY5G50PtKHh6Jj4CPJPGWa/qOnahvV1NswIE3hpXOqHuhwQA8bm
         8X6vRBgXGMUiI+xUH9gdWbcJNIDzSesZl5mrFxZWMzQG7T/O/VPfWGo6DRCG3Yv85aA8
         LPD8SlBDBEL25RgX0Gr/r6uCHo1xbCsONaN2uxRNVmTJ3KHRrLYusvAodDafr6t+F5Lz
         uRlR1UHwDV14JFsDj6SeHmSBQ4rXlqvP+XPTB9a3H7vaUI94iwQ69SYlzbYGlMNSkiAZ
         GCUw==
X-Gm-Message-State: ABuFfoipdnxKI2rxlDKjjdyI2o1aYn0ILk3NZ8L8V9XQhhQ6ry/GJU5o
        qqE6tT0pIZnb4+xkgl0oIkDW0Q==
X-Google-Smtp-Source: ACcGV62faQhugumAv0nfFZHLhIGu+A3M4tkgwIrEB7/wu7/GRoQCreiQKYtwlNL85Cm1+sdpOjoD8A==
X-Received: by 2002:a17:902:b943:: with SMTP id h3-v6mr16197212pls.5.1539591041875;
        Mon, 15 Oct 2018 01:10:41 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m27-v6sm16375855pff.187.2018.10.15.01.10.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 01:10:40 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v4 2/6] power: supply: core: Add one field to present the battery internal resistance
Date:   Mon, 15 Oct 2018 16:09:21 +0800
Message-Id: <b70d55f008cfbbb79abf27018261d8a6f16e9673.1539587217.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one field for 'struct power_supply_battery_info' to present the battery
factory internal resistance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes from v3:
 - New patch in v3, which splits code into one separate patch.
 - Add Linusw reviewed tag.
---
 drivers/power/supply/power_supply_core.c |    3 +++
 include/linux/power_supply.h             |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index e853618..307e0995 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -579,6 +579,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->charge_term_current_ua         = -EINVAL;
 	info->constant_charge_current_max_ua = -EINVAL;
 	info->constant_charge_voltage_max_uv = -EINVAL;
+	info->factory_internal_resistance_uohm  = -EINVAL;
 
 	if (!psy->of_node) {
 		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
@@ -616,6 +617,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			     &info->constant_charge_current_max_ua);
 	of_property_read_u32(battery_np, "constant_charge_voltage_max_microvolt",
 			     &info->constant_charge_voltage_max_uv);
+	of_property_read_u32(battery_np, "factory-internal-resistance-micro-ohms",
+			     &info->factory_internal_resistance_uohm);
 
 	return 0;
 }
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index f807691..d089566 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -326,6 +326,7 @@ struct power_supply_battery_info {
 	int charge_term_current_ua;	    /* microAmps */
 	int constant_charge_current_max_ua; /* microAmps */
 	int constant_charge_voltage_max_uv; /* microVolts */
+	int factory_internal_resistance_uohm;   /* microOhms */
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
-- 
1.7.9.5

