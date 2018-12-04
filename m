Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399DFC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F191F20660
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OrY9HI5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F191F20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeLDQ6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:58:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35119 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeLDQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:58:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so10064245wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wJVyGLtCFC0e76IubhfRv1J+zqc3cu+QjOGSxAy/OS4=;
        b=OrY9HI5dHrgEl05gg4L5JsWStECOaFrTHEECl/2rKKA0DT+0qDdx2wP4EubHbq8FOM
         NcNOQSWITVlfMEi7qjYR22wtWUpENhWsPBJ4Cem/nXpflYiNbO0rkedcdYnWhzC2enxH
         5bnfC6OLEYZFsxXVlDLdK/OqYhKShttQElp7ADCey2DLnEnW2WitdsIbnMxEq7qvL7b+
         dtJakC2lQfu7fp8UeR70EIBV+eho2aI2qo7qDnWnXITYCi9RKyHoclnIQaw08QRAOTY9
         1IRCPMYeExz7z/e1+ordGEgrq1UjgJkGsHdtu/+iRk4NeYlUofFNamcnazsiLovHVIQU
         RtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wJVyGLtCFC0e76IubhfRv1J+zqc3cu+QjOGSxAy/OS4=;
        b=a2dkz096BUgqqpPMRx10HBTrPU4RJif0T04aV2xXblwzCap3vjO46/y977UhPCkN6n
         mkkiR0PehMhfNk8LLokvmQpCQVU65CmkAoUHrjU0oEhnT0pAd0Pevo+npJ8eF80/Y5Qk
         bND1++KwJb4nXadjhRdogqf+kvDY4C+HhM+sB6gSRI6sPHk1xC78XuNS2tBliT/uUIpN
         Je2RfgQO96ULBbOJpN7+J1maSeycaFvje0VKvfg3hf/5mOriGKCoPVopHeCKPiPikVcy
         obrsE2fOkZqDodQrVELh0+xVwwS0ow9gla8mK9guKm5aCa1+TtI0Dw31nkbm0aubXrm8
         qXDA==
X-Gm-Message-State: AA+aEWbdn/t1YLY6zpPR7qgrGvY7cmHPm8gPDcHH+JP2WPXdw0cIR0hs
        egoE1RaiyUR63cKu57e1h51QrQ==
X-Google-Smtp-Source: AFSGD/XCtQRzW+7kgW3/fYyh3qJUlzTx1r8MlcU+XPa4KWpHKWQoIlm2AKGBANnHGpp4bA1p5Wedvw==
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr12982144wmc.106.1543942710001;
        Tue, 04 Dec 2018 08:58:30 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id x81sm10152521wmg.17.2018.12.04.08.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 08:58:29 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] clk: meson: add clk-input helper function
Date:   Tue,  4 Dec 2018 17:58:18 +0100
Message-Id: <20181204165819.21541-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204165819.21541-1-jbrunet@baylibre.com>
References: <20181204165819.21541-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock input helper function. Several amlogic clock controllers
will now be registering bypass clock input. Instead of copying this
code in every of them, let's make an helper function for it

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Makefile    |  2 +-
 drivers/clk/meson/clk-input.c | 44 +++++++++++++++++++++++++++++++++++
 drivers/clk/meson/clkc.h      |  5 ++++
 3 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/clk-input.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 6da1d7082f1a..e8d1c727cf69 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-pll-div.o
-obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-dualdiv.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-dualdiv.o clk-input.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
diff --git a/drivers/clk/meson/clk-input.c b/drivers/clk/meson/clk-input.c
new file mode 100644
index 000000000000..06b3e3bb6a66
--- /dev/null
+++ b/drivers/clk/meson/clk-input.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include "clkc.h"
+
+static const struct clk_ops meson_clk_no_ops = {};
+
+struct clk_hw *meson_clk_hw_register_input(struct device *dev,
+					   const char *of_name,
+					   const char *clk_name,
+					   unsigned long flags)
+{
+	struct clk *parent_clk = devm_clk_get(dev, of_name);
+	struct clk_init_data init;
+	const char *parent_name;
+	struct clk_hw *hw;
+	int ret;
+
+	if (IS_ERR(parent_clk))
+		return (struct clk_hw *)parent_clk;
+
+	hw = devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
+	if (!hw)
+		return ERR_PTR(-ENOMEM);
+
+	parent_name = __clk_get_name(parent_clk);
+	init.name = clk_name;
+	init.ops = &meson_clk_no_ops;
+	init.flags = flags;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	hw->init = &init;
+
+	ret = devm_clk_hw_register(dev, hw);
+
+	return ret ? ERR_PTR(ret) : hw;
+}
+EXPORT_SYMBOL_GPL(meson_clk_hw_register_input);
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 1efa6be9cfe4..e3cd442db739 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -138,4 +138,9 @@ extern const struct clk_ops meson_vid_pll_div_ro_ops;
 extern const struct clk_ops meson_clk_dualdiv_ops;
 extern const struct clk_ops meson_clk_dualdiv_ro_ops;
 
+struct clk_hw *meson_clk_hw_register_input(struct device *dev,
+					   const char *of_name,
+					   const char *clk_name,
+					   unsigned long flags);
+
 #endif /* __CLKC_H */
-- 
2.19.1

