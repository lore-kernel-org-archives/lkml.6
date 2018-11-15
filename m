Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837C1C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4DE2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aBQYBOtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4DE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389130AbeKPIv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:51:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38698 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeKPIvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:51:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id f2-v6so19372114wme.3;
        Thu, 15 Nov 2018 14:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gZMD7wnXU4TaaGBEtiWhXDsupb7upfZU9u5SbgkwnA4=;
        b=aBQYBOtWevbWZAiKzp7qTMGntXPf6W7RXgqBtjykH4a9p+HWZX7vGJKoS062Ekb4c/
         uLw/bSYvtElXoW2wj4Pa5KeLSfLqodb+Q6K/v8vBpa+tPZ3Nk44HzzwvmkV5HYNIJi+g
         bnvxDw3Z9TtLa0vVLgfXgSfaT/Al0QUdKUCjrT91tb42OBRzIh4TwMN3HpQb65Lcnq63
         f+QCb50a3leYYun5+E/T1QwrKq5PJwEVxSVgPHAsKKsPx2v/vaeT3MuXvHdnCVGn2XER
         tUgOtzOPvH/kNvJN4S3C8DxLxtiqzb8a9s1sOSFxHNiv4WG7vVtFEn7WArz4N/Kfr/3m
         6VeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gZMD7wnXU4TaaGBEtiWhXDsupb7upfZU9u5SbgkwnA4=;
        b=lcqxcPis1a4FQZ3W5tl/Q2t/patWiuud3DvWVoYveOc8heou3iMrzUMgZoOoIYai9Z
         uGpm926QjWiPOKnC67iikX+bQTJpQFjR4mZOzlj3NSBpKrNB/4JJln7CygxcRwnaNy/H
         QoO4K5KErqwVXj/azPGcVf8fIT+xFkZ5vWeDCJDDlACJTA/6nfCsgsgKnqpCzy+AYg2Q
         ZlgXu1FCMXNz70ADhqTOPKcKpdvJYuWtYXYO1nm6jn7W3ya4mFCmCz3XNQlqyaT+0UK6
         4zho7/XVHH13wUlsCpuyox03V32WC6PvpQjp9B8W1rOoYbzy98TuCsOIgSvLWnq2mfpy
         9x5A==
X-Gm-Message-State: AGRZ1gJHhDssE8spCIC2GcTdCAcTqNODaSCS60wSBDZYUNqluSe1+R81
        LUmanjdbMLSn5nA3BuvaXjo=
X-Google-Smtp-Source: AJdET5dfq30sWDt296B3ZlWpVFJoJ12JjCSsBcxXitirCps+4fSPrq60NaSycUtzeswQu0ft05kGkw==
X-Received: by 2002:a1c:1c5:: with SMTP id 188mr528207wmb.133.1542321677860;
        Thu, 15 Nov 2018 14:41:17 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100B85ACE585A885C51.dip0.t-ipconnect.de. [2003:dc:d717:a100:b85a:ce58:5a88:5c51])
        by smtp.googlemail.com with ESMTPSA id x12sm2076388wmc.37.2018.11.15.14.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 14:41:17 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/6] clk: meson: meson8b: do not use cpu_div3 for cpu_scale_out_sel
Date:   Thu, 15 Nov 2018 23:40:44 +0100
Message-Id: <20181115224048.13511-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
References: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_div3 clock (cpu_in divided by 3) generates a signal with a duty
cycle of 33%. The CPU clock however requires a clock signal with a duty
cycle of 50% to run stable.
cpu_div3 was observed to be problematic when cycling through all
available CPU frequencies (with additional patches on top of this one)
while running "stress --cpu 4" in the background. This caused sporadic
hangs where the whole system would fully lock up.

Amlogic's 3.10 kernel code also does not use the cpu_div3 clock either
when changing the CPU clock.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson8b.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 9bd5920da0ff..a96bfee58a61 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -608,20 +608,27 @@ static struct clk_regmap meson8b_cpu_scale_div = {
 	},
 };
 
+static u32 mux_table_cpu_scale_out_sel[] = { 0, 1, 3 };
 static struct clk_regmap meson8b_cpu_scale_out_sel = {
 	.data = &(struct clk_regmap_mux_data){
 		.offset = HHI_SYS_CPU_CLK_CNTL0,
 		.mask = 0x3,
 		.shift = 2,
+		.table = mux_table_cpu_scale_out_sel,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_scale_out_sel",
 		.ops = &clk_regmap_mux_ro_ops,
+		/*
+		 * NOTE: We are skipping the parent with value 0x2 (which is
+		 * "cpu_div3") because it results in a duty cycle of 33% which
+		 * makes the system unstable and can result in a lockup of the
+		 * whole system.
+		 */
 		.parent_names = (const char *[]) { "cpu_in_sel",
 						   "cpu_div2",
-						   "cpu_div3",
 						   "cpu_scale_div" },
-		.num_parents = 4,
+		.num_parents = 3,
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
-- 
2.19.1

