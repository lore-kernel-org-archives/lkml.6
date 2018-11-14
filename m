Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10946C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD5B2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IbCQFyyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD5B2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeKOJDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:03:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37138 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeKOJDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:03:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so4888659wru.4;
        Wed, 14 Nov 2018 14:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqeqV0l+4ciF5RTVW9joEtdlIbRSvfaFdjva14ByRQM=;
        b=IbCQFyyVdMVMgwlkpg4LyGdG9lmHPNKlQgYIcye4QYFBer6s2lRBkfJvs6qwqZppJj
         62Qik7Lp8EqPJWqlpMEVzISczyfQbEuoNn7Bzhw7qjFD+7nk5K9BtJGG5po/O90z/Bep
         jZB0inDrIGa2tfHvXFruKc5rv339jmI2LMRV6W/QOrJ5L+pgAFe1RIYlK0uD/UZOd0xw
         kzrMCdye9eL0Ou1Y0XIM5Q//FZuUVWG41wuCpBrZwW8Sg87sfjKmpfwBqqzJiPSd9lt4
         4krMyKYLfODfnlGmj1vptcVe7x7MGEsKlRKIcnMfslVzqK7Zj5WVvn7u/6bllF191Egx
         1n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqeqV0l+4ciF5RTVW9joEtdlIbRSvfaFdjva14ByRQM=;
        b=XFDx6D3OZ8BaYMTpNxR0QlCaW4VDIqGnBp5TUKuSwC7SNctK06MsZ02I629dx/M/CH
         YRmxneXelCcspxkCm5fA188TPrNnLSbNHecqzRGWyjmMh0BOfkcJr/x6eceb/p9lP8eH
         ebEm01gkNkv3xCXcS0YjwH9X+Km3v10/h7mBTvGr9PwHk8qCD5GOEnrhKyqTWvkLV968
         OmyiEoFmsytm1zpE6txAmPBffOBSyt78tqIJBNhXF0yIUT9tt6KQ1NI5QjYbGklQHAFG
         FppVvWY5vrSivf1uZlpCX1Rk8sMKsLTiouLiL7jn+kfq9XVlla+yRqDcHXGt4oyp9ZEh
         +Hfg==
X-Gm-Message-State: AGRZ1gKdxVSf+KMFLgAvepDK/mCx9r4Wl7etORQaKUmT29Bl2m9V6Y1j
        bMSil2wIZvR1c8CEBH/cVb6V8Vpk
X-Google-Smtp-Source: AJdET5djTpjBY0KV3FDCcu2Viy0gYHjlh01ToHzIDSeMfzz24L1fdUVBnwr1RLhfhYimgYG7mh+3tQ==
X-Received: by 2002:a5d:48cc:: with SMTP id p12-v6mr3773836wrs.122.1542236271637;
        Wed, 14 Nov 2018 14:57:51 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100301AB549B11D5ACB.dip0.t-ipconnect.de. [2003:dc:d717:a100:301a:b549:b11d:5acb])
        by smtp.googlemail.com with ESMTPSA id n7-v6sm18987784wrt.60.2018.11.14.14.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:57:51 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v1 1/7] clk: meson: meson8b: run from the XTAL when changing the CPU frequency
Date:   Wed, 14 Nov 2018 23:57:19 +0100
Message-Id: <20181114225725.2821-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
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
---
 drivers/clk/meson/meson8b.c | 63 +++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 9bd5920da0ff..40e77fe4ba7c 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1103,6 +1103,53 @@ static const struct reset_control_ops meson8b_clk_reset_ops = {
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
@@ -1112,6 +1159,8 @@ static const struct regmap_config clkc_regmap_config = {
 static void __init meson8b_clkc_init(struct device_node *np)
 {
 	struct meson8b_clk_reset *rstc;
+	const char *notifier_clk_name;
+	struct clk *notifier_clk;
 	void __iomem *clk_base;
 	struct regmap *map;
 	int i, ret;
@@ -1166,6 +1215,20 @@ static void __init meson8b_clkc_init(struct device_node *np)
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

