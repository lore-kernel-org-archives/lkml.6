Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CE9C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10B820672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WGuJNcjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10B820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeLJPKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:10:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37814 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeLJPKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:10:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so10845974wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wb/fLbhHyqXf8iwaRFvhIRMTSVTgEgTB9jz/yncINeA=;
        b=WGuJNcjpjAZsu/Z8PLX2a4eWisWNnxBiVrBtZHwfn4ctfRDUHzNR9Jr050oA6UUPfy
         fyzFNRM4ga7BE+XcVr18nwpPu3Yg6XpLKOYI/tfPmUq3fTPbF6axOkx/EcXw7ERELLSB
         A/tIr++cN0HBF1PPmHWq1jaxXrCrYxbeCNFzvABLt4bj1olAs/0Vt/44gYT5ewHLkdKc
         g6CwOPyiVwevRDeDQ0BaWlHzjHMF8r5RoW+94TqbS3d3k3tj44slzw0ne25MD+a8ceGJ
         MA1jwIgZPQb629qgw2yWnDM9B6+R4dfxwvjYqG2hr5SHWULu8WG+3JotJ6HlgaZ+UPAX
         FVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wb/fLbhHyqXf8iwaRFvhIRMTSVTgEgTB9jz/yncINeA=;
        b=kOtRs1i5m2cb6gOC+J1zUrQKAwwwo97JuTmN9KmEvJYm3NvLqQKlIbr6J7Bm0HRmzf
         dnMJq9UhFLpSRLNTjmoa7HCEgqFaqgH05LjjRLTlbOBfmdpPuCVJ3UlQmnf/WC2SXuI3
         J5m81U5FJvOvflseQfzI4BRyl8HWlTVY/nRm5YqVPdpvy6ZuPLvZ9fGX5Pif0Kx3SR0g
         4G5E9i/FLc2pDJFkXApOyUK6xTt0agzB3bsvuOqoeWYpI1y/jHo81p9bf9REUM4COrTI
         vebeSKOKLFDQghaNtHVt+w0UDeOAujqqu7QgJ6SVUsOQNoNiU5vQ1cmhg+Wfq3sW74u0
         AjVQ==
X-Gm-Message-State: AA+aEWYYECjgfurvQnEIf/feGi4vBxhdA4EvsYEVBMnvRPJVHUxbkU2s
        geLtcyDVbX7Q2EI47F+bBfaQYw==
X-Google-Smtp-Source: AFSGD/W5lpqD3IMO4FMqBHb+4urq3H8Ok5z+qwN1XUkH+2micJX2B5ypnhWrYxHQgmkYFQ6kLnhgpw==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr9738365wru.33.1544454641938;
        Mon, 10 Dec 2018 07:10:41 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y8sm11755720wmg.13.2018.12.10.07.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 07:10:41 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/2] regulator: provide regulator_set_voltage_sel_regmap_step() helper
Date:   Mon, 10 Dec 2018 16:10:24 +0100
Message-Id: <20181210151024.3906-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181210151024.3906-1-brgl@bgdev.pl>
References: <20181210151024.3906-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

On some devices we need to manually ramp the regulators to desired
voltage one step at a time. This patch adds a helper routine for
regmap users that checks if the regulator is enabled and, if so,
iterates over all selectors between the current one and the one
representing the targeted voltage setting.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/regulator/helpers.c      | 48 ++++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 5686a1335bd3..6eb0e147bbc9 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -19,6 +19,8 @@
 #include <linux/regulator/driver.h>
 #include <linux/module.h>
 
+#include "internal.h"
+
 /**
  * regulator_is_enabled_regmap - standard is_enabled() for regmap users
  *
@@ -279,6 +281,52 @@ int regulator_set_voltage_sel_regmap(struct regulator_dev *rdev, unsigned sel)
 }
 EXPORT_SYMBOL_GPL(regulator_set_voltage_sel_regmap);
 
+/**
+ * regulator_set_voltage_sel_regmap_step - stepping set_voltage_sel for regmap
+ *                                         users
+ *
+ * @rdev: regulator to operate on
+ * @sel: Selector to set
+ *
+ * Regulators that use regmap for their register I/O but want to ramp up/down
+ * to the selected voltage one step at a time can use this routine as their
+ * set_voltage_sel operation.
+ */
+int regulator_set_voltage_sel_regmap_step(struct regulator_dev *rdev,
+					  unsigned int sel)
+{
+	int ret, curr, diff, i, end;
+	bool asc;
+
+	/*
+	 * If the regulator is disabled, we can program the desired
+	 * voltage right away.
+	 */
+	if (!_regulator_is_enabled(rdev))
+		return regulator_set_voltage_sel_regmap(rdev, sel);
+
+	curr = regulator_get_voltage_sel_regmap(rdev);
+	if (curr < 0)
+		return curr;
+
+	diff = curr - sel;
+	if (diff == 0)
+		return 0; /* Already there. */
+
+	asc = diff > 0 ? false : true;
+	end = asc ? sel + 1 : sel - 1;
+	asc ? curr++ : curr--;
+
+	for (i = curr; i != end; asc ? i++ : i--) {
+		ret = regulator_set_voltage_sel_regmap(rdev, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(regulator_set_voltage_sel_regmap_step);
+
 /**
  * regulator_map_voltage_iterate - map_voltage() based on list_voltage()
  *
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index a9c030192147..eedd8b495900 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -530,6 +530,8 @@ int regulator_set_voltage_sel_pickable_regmap(struct regulator_dev *rdev,
 						unsigned int sel);
 int regulator_get_voltage_sel_regmap(struct regulator_dev *rdev);
 int regulator_set_voltage_sel_regmap(struct regulator_dev *rdev, unsigned sel);
+int regulator_set_voltage_sel_regmap_step(struct regulator_dev *rdev,
+					  unsigned int sel);
 int regulator_is_enabled_regmap(struct regulator_dev *rdev);
 int regulator_enable_regmap(struct regulator_dev *rdev);
 int regulator_disable_regmap(struct regulator_dev *rdev);
-- 
2.19.1

