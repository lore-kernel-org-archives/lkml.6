Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796B3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353A82133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="getxhgJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353A82133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389100AbeKPIvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:51:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34545 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388956AbeKPIvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:51:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so22904130wre.1;
        Thu, 15 Nov 2018 14:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ocpvr4v/IalymL6Cfmgpy4xn0IPt/TDny70HjBkIVnQ=;
        b=getxhgJC6hg+ji7gWowQYLqG6ApfFgAi5irT4hgOttWDJ2K5Ue43mcY6Q4+G4Mn0Gz
         dNqRkvnKtHZLfN67jsl4daQMygYdeuJNohCyMd+vTKUwaWkahzV+PXoHQd7qcN22P3uz
         4rgdFgcYmqL3FRBd+HqWgFSojTa8Ldkp+Ec4kNXIJiP8HY3Oc5OXmnDgL7YGAcXCQygO
         i081ts666V//8taGxtWTWjElOlF0eGUkcSwpnk8mc3NAmtoMHkqyC2yEEKzuAbefHt28
         hVRyvdasfqbqPmczYQPZ3SCAHufoaDMN95IYMEVk80MHs7UIvhWyWlcR8UWIul+v9kWa
         10VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ocpvr4v/IalymL6Cfmgpy4xn0IPt/TDny70HjBkIVnQ=;
        b=nju+sdLxJ7JHL4lNEWN+zZ/gicc8J4cEBMzeIgtSGL5OG9ZYxbXTsFKvMxSFJs/ERH
         3p5Oak/I6odIkcl+0W+Zis40G9H3gRDsGDwkO2HLNBMNqFnPMiFZzI+i5gUDpwgMaPh8
         wl6Qmj4G0EjBx8tJNIrQbY5gWYjyX10xr/025YDVkECm+saAfPWAM9ucjAA5I/Z5Wm0O
         2wY/IfgNOXteizoA7B0Ho0eQ11OuDa2aGzp5qNg4sNK6fE58Wf/Lywhf2jdXQPOGwgdr
         0qxm3jIUuQ1RE0fCdb8fs70xSLQRcpACLeHieLgcaMTy2fWpRzl4WSCe+UwDZoUhlwRe
         mDlw==
X-Gm-Message-State: AGRZ1gIYAR3sLZQgsWn0k5TvA2jbnTncSEZx8CQGDe+cMSVMNaei2iuM
        Kkw6xxlGRVtz+9VCBzIyQSzEtEr4
X-Google-Smtp-Source: AJdET5eIxNcbjlEsDJBwlBm8xGH49dS6nqNXq9wH7vfwUtUr9BuKp18Y1KLrN0CrQmMIX3O5E8P1Lg==
X-Received: by 2002:a5d:5745:: with SMTP id q5-v6mr7165566wrw.161.1542321681386;
        Thu, 15 Nov 2018 14:41:21 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100B85ACE585A885C51.dip0.t-ipconnect.de. [2003:dc:d717:a100:b85a:ce58:5a88:5c51])
        by smtp.googlemail.com with ESMTPSA id x12sm2076388wmc.37.2018.11.15.14.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 14:41:20 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 5/6] clk: meson: meson8b: run from the XTAL when changing the CPU frequency
Date:   Thu, 15 Nov 2018 23:40:47 +0100
Message-Id: <20181115224048.13511-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
References: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the CPU clock requires changing various clocks including the
SYS PLL. The existing meson clk-pll and clk-regmap drivers can change
all of the relevant clocks already.
However, changing for exampe the SYS PLL is problematic because as long
as the CPU is running off a clock derived from SYS PLL changing the
latter results in a full system lockup.
Fix this system lockup by switching the CPU clock to run off the XTAL
while we are changing the any of the clocks in the CPU clock tree.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson8b.c | 63 +++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index b07a92ed7de3..c06a1a7faa4c 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1116,6 +1116,53 @@ static const struct reset_control_ops meson8b_clk_reset_ops = {
 	.deassert = meson8b_clk_reset_deassert,
 };
 
+struct meson8b_nb_data {
+	struct notifier_block nb;
+	struct clk_hw_onecell_data *onecell_data;
+};
+
+static int meson8b_cpu_clk_notifier_cb(struct notifier_block *nb,
+				       unsigned long event, void *data)
+{
+	struct meson8b_nb_data *nb_data =
+		container_of(nb, struct meson8b_nb_data, nb);
+	struct clk_hw **hws = nb_data->onecell_data->hws;
+	struct clk_hw *cpu_clk_hw, *parent_clk_hw;
+	struct clk *cpu_clk, *parent_clk;
+	int ret;
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		parent_clk_hw = hws[CLKID_XTAL];
+		break;
+
+	case POST_RATE_CHANGE:
+		parent_clk_hw = hws[CLKID_CPU_SCALE_OUT_SEL];
+		break;
+
+	default:
+		return NOTIFY_DONE;
+	}
+
+	cpu_clk_hw = hws[CLKID_CPUCLK];
+	cpu_clk = __clk_lookup(clk_hw_get_name(cpu_clk_hw));
+
+	parent_clk = __clk_lookup(clk_hw_get_name(parent_clk_hw));
+
+	ret = clk_set_parent(cpu_clk, parent_clk);
+	if (ret)
+		return notifier_from_errno(ret);
+
+	udelay(100);
+
+	return NOTIFY_OK;
+}
+
+static struct meson8b_nb_data meson8b_cpu_nb_data = {
+	.nb.notifier_call = meson8b_cpu_clk_notifier_cb,
+	.onecell_data = &meson8b_hw_onecell_data,
+};
+
 static const struct regmap_config clkc_regmap_config = {
 	.reg_bits       = 32,
 	.val_bits       = 32,
@@ -1125,6 +1172,8 @@ static const struct regmap_config clkc_regmap_config = {
 static void __init meson8b_clkc_init(struct device_node *np)
 {
 	struct meson8b_clk_reset *rstc;
+	const char *notifier_clk_name;
+	struct clk *notifier_clk;
 	void __iomem *clk_base;
 	struct regmap *map;
 	int i, ret;
@@ -1179,6 +1228,20 @@ static void __init meson8b_clkc_init(struct device_node *np)
 			return;
 	}
 
+	/*
+	 * FIXME we shouldn't program the muxes in notifier handlers. The
+	 * tricky programming sequence will be handled by the forthcoming
+	 * coordinated clock rates mechanism once that feature is released.
+	 */
+	notifier_clk_name = clk_hw_get_name(&meson8b_cpu_scale_out_sel.hw);
+	notifier_clk = __clk_lookup(notifier_clk_name);
+	ret = clk_notifier_register(notifier_clk, &meson8b_cpu_nb_data.nb);
+	if (ret) {
+		pr_err("%s: failed to register the CPU clock notifier\n",
+		       __func__);
+		return;
+	}
+
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
 				     &meson8b_hw_onecell_data);
 	if (ret)
-- 
2.19.1

