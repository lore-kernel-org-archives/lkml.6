Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFBBC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282992147C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ1WOC7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282992147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbeJEWhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:37:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42077 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbeJEWhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:37:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id s10-v6so9655020lfc.9;
        Fri, 05 Oct 2018 08:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CguVuh97a9Y3y6PgH3GDIr5XBaGX/zUX4wXfiW1S58E=;
        b=RZ1WOC7Xq3FEq+c682MbN0B+AL0DpP5bWgFQF6hl811THOvS+krYRtsm3O5U7+4HKd
         xExgXwFhe3lx2JT3m5o6E/dXjdwZkeMo0AJ6tGjTjz3McGOYA56wHzndr+PLcrSqiY1y
         xXiEYtdN8/1N7I7Vc4LM/bcZb72TfWS5+Q/bZ/vw10YVN/sQZwzZ2/KOHsbVyzYaxb50
         Tu01tcIe310hN7U6STrPBUY/cLpkUYSlZ1eNdmTTOOWQMQBmAFPpc7mQ7T8hUDR0d02X
         4iHMXjnqNhQFkNhd/BDsJYNXsAVM6ixyTVSqkUO9/RElrVm3ITZyxinykUzWnvr3Il9k
         ygxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CguVuh97a9Y3y6PgH3GDIr5XBaGX/zUX4wXfiW1S58E=;
        b=djmJoAh3Jq/PAlekbiaESE0aWyeBg9zgKUJnQ+bp7rGKQsdQozamy/BbzHdzeAI2BO
         gjnadTMH32zBvssogQADRVP8iZkblZ6NEdff0Ak0ihrOxJDFQw6S4WDdRjTiyTEyQlHI
         OHo9LNQATDOO3d5mK1S74CMyRvA469Kv9zreUaDvckrJyRwnVjv47EcGXkY8NZh1FVXb
         vpxcN2MjX9bI0WOL7N3lRmsfGdM9lNIpYTe9VFmAZ8jVTaSn9vVSv1gCyLfOdxzIMrIM
         itgUuj6YeimL2nhig5X3qbV9seXS8WDDvts3ij0cJE7kMDd9f5ghr9W8SYaARSlf7Xgz
         CLtQ==
X-Gm-Message-State: ABuFfoisYaaSEGmsscX0fRM6n4s02RQVHq7ogn4gqs27r5gy1zNboPhQ
        JLTOCo8Vxpv8TJ4+SnXwS1A=
X-Google-Smtp-Source: ACcGV62cfbreUlEwnz9rPd+BycQycAvxzJxycWIfFeLm9WSaT9ta7vDkyyufeaxzUtQHdunHhDU9wg==
X-Received: by 2002:a19:54c1:: with SMTP id b62-v6mr6960846lfl.14.1538753883054;
        Fri, 05 Oct 2018 08:38:03 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1879373lfd.72.2018.10.05.08.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:38:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maciej Purski <m.purski@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v1 08/11] regulator: core: Add new max_uV_step constraint
Date:   Fri,  5 Oct 2018 18:36:35 +0300
Message-Id: <20181005153638.1886-9-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On NVIDIA Tegra30 there is a requirement for regulator "A" to have voltage
higher than voltage of regulator "B" by N microvolts, the N value changes
depending on the voltage of regulator "B". This is similar to min-spread
between voltages of regulators, the difference is that the spread value
isn't fixed. This means that extra carefulness is required for regulator
"A" to drop its voltage without violating the requirement, hence its
voltage should be changed in steps so that its couple "B" could follow
(there is also max-spread requirement).

Add new "max_uV_step" constraint that breaks voltage change into several
steps, each step is limited by the max_uV_step value.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c          | 41 +++++++++++++++++++++++++++++++
 drivers/regulator/of_regulator.c  |  4 +++
 include/linux/regulator/machine.h |  3 +++
 3 files changed, 48 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 089e8ad8ef57..ba03bdf3716f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3191,6 +3191,36 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 	return ret;
 }
 
+static int regulator_limit_voltage_step(struct regulator_dev *rdev,
+					int *current_uV, int *min_uV)
+{
+	struct regulation_constraints *constraints = rdev->constraints;
+
+	/* Limit voltage change only if necessary */
+	if (!constraints->max_uV_step || !_regulator_is_enabled(rdev))
+		return 1;
+
+	if (*current_uV < 0) {
+		*current_uV = _regulator_get_voltage(rdev);
+
+		if (*current_uV < 0)
+			return *current_uV;
+	}
+
+	if (abs(*current_uV - *min_uV) <= constraints->max_uV_step)
+		return 1;
+
+	/* Clamp target voltage within the given step */
+	if (*current_uV < *min_uV)
+		*min_uV = min(*current_uV + constraints->max_uV_step,
+			      *min_uV);
+	else
+		*min_uV = max(*current_uV - constraints->max_uV_step,
+			      *min_uV);
+
+	return 0;
+}
+
 static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 					 int *current_uV,
 					 int *min_uV, int *max_uV,
@@ -3302,6 +3332,17 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 	desired_min_uV = possible_uV;
 
 finish:
+	/* Apply max_uV_step constraint if necessary */
+	if (state == PM_SUSPEND_ON) {
+		ret = regulator_limit_voltage_step(rdev, current_uV,
+						   &desired_min_uV);
+		if (ret < 0)
+			return ret;
+
+		if (ret == 0)
+			done = false;
+	}
+
 	/* Set current_uV if wasn't done earlier in the code and if necessary */
 	if (n_coupled > 1 && *current_uV == -1) {
 
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index c4223b3e0dff..a732f09d207b 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -170,6 +170,10 @@ static void of_get_regulation_constraints(struct device_node *np,
 				  &pval))
 		constraints->max_spread = pval;
 
+	if (!of_property_read_u32(np, "regulator-max-step-microvolt",
+				  &pval))
+		constraints->max_uV_step = pval;
+
 	constraints->over_current_protection = of_property_read_bool(np,
 					"regulator-over-current-protection");
 
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index a459a5e973a7..1d34a70ffda2 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -158,6 +158,9 @@ struct regulation_constraints {
 	/* used for coupled regulators */
 	int max_spread;
 
+	/* used for changing voltage in steps */
+	int max_uV_step;
+
 	/* valid regulator operating modes for this machine */
 	unsigned int valid_modes_mask;
 
-- 
2.19.0

