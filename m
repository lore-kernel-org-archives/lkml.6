Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54C3C04EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE1A22507
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="q838D237"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE1A22507
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbeKOJDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:03:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53086 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbeKOJDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:03:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so16974729wmb.2;
        Wed, 14 Nov 2018 14:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVZ5uvw2/86wt6Serx6lIpgnovwRR9rOzr4LZhzakUs=;
        b=q838D237yNSrJ16Jo5GXvOyCzWY0h6dPjzT8TAAOqnENilInt7Rgzx8PbCRwdBCFNZ
         1WfIhM6RVjUQsMcym/TvPDUr+Lczqhbx+aiCgkxLCwkflW/0dhRtUqz+ahhkiaVEOpX2
         FL9GBa56vajhsvQADxxeyNMgMbrOD4vqDz8LqmK1P4rVeceL/O4koJBqx/DK6ZMKAYYM
         2PgFT3sS4tprwq11Fl0bVm/uaPKGypKQYMLhcWEPVN/arL1kGpeK3Vj9w8+CazOdMQe+
         r0F0WiPVJBBlRtlxrPdjqorQ4CIDSQOiY2IQR0hXcI5li456SVHqf1/FlPJIvclY9r/K
         3F+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVZ5uvw2/86wt6Serx6lIpgnovwRR9rOzr4LZhzakUs=;
        b=HWNvZYUA+C0SI8fYS6quepsbuDcUziFTrc4rR8SN9i7s1Te8MeyIXidWCfkJqnhzlu
         HmExUU3EyBxKJLH4q3QBIyVqPRfAAULtEmfVaciplRE9RLruuE+IFprTP7rj681+Jx9W
         0ThFrfFGm/IVMh701QuowRAP7Vl1fm0YHnU6DnIPARtxegkq+5qcejvfZsvRMpWuQjIg
         pqm/D/f59p9rcqo9BEPmoTqFFt9pI8ingzf3X7sISuV8YwepWf0G7d1zU7iyunAYqbsS
         iflUnnQubVSEe3z3//uCcmIFkZX6ao6NRlSIukNRHwiNilRiZqvsSXqNpn1wBLGVnHV5
         M2MQ==
X-Gm-Message-State: AGRZ1gKcfv+PGGOj0pJ7aQDPbFZCrnIclxqlnCU5ACB6o+EDHWZ0Xb8Q
        gNxa+s3SDITKHapHDkapoMI=
X-Google-Smtp-Source: AJdET5fO7/YSWljnTaW+mruQlXqAqxjkoELr3BtA3Q58whJchNx5/o6Vn+yRcvQ/iKviEPBiqVgqlQ==
X-Received: by 2002:a1c:ac85:: with SMTP id v127mr3350283wme.62.1542236278624;
        Wed, 14 Nov 2018 14:57:58 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100301AB549B11D5ACB.dip0.t-ipconnect.de. [2003:dc:d717:a100:301a:b549:b11d:5acb])
        by smtp.googlemail.com with ESMTPSA id n7-v6sm18987784wrt.60.2018.11.14.14.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:57:57 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v1 7/7] clk: meson: meson8b: allow changing the CPU clock tree
Date:   Wed, 14 Nov 2018 23:57:25 +0100
Message-Id: <20181114225725.2821-8-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all clocks in the CPU clock tree are marked as read-only
(using the corresponding _ro_ clk_ops). This was correct since changing
the clock tree could cause the system to lock up.
Switch all clocks to their corresponding clk_ops variant which is not
read-only to allow changing the CPU clock tree since the bug which
locked up the system is now fixed (by switching the CPU clock temporary
to run off XTAL while changing the CPU clock tree).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index c06a1a7faa4c..b3bdc7e05441 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -203,7 +203,7 @@ static struct clk_regmap meson8b_sys_pll_dco = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll_dco",
-		.ops = &meson_clk_pll_ro_ops,
+		.ops = &meson_clk_pll_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
 	},
@@ -218,7 +218,7 @@ static struct clk_regmap meson8b_sys_pll = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll",
-		.ops = &clk_regmap_divider_ro_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "sys_pll_dco" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -552,7 +552,7 @@ static struct clk_regmap meson8b_cpu_in_sel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_in_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_names = (const char *[]){ "xtal", "sys_pll" },
 		.num_parents = 2,
 		.flags = (CLK_SET_RATE_PARENT |
@@ -606,7 +606,7 @@ static struct clk_regmap meson8b_cpu_scale_div = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_scale_div",
-		.ops = &clk_regmap_divider_ro_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "cpu_in_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -623,7 +623,7 @@ static struct clk_regmap meson8b_cpu_scale_out_sel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_scale_out_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		/*
 		 * NOTE: We are skipping the parent with value 0x2 (which is
 		 * "cpu_div3") because it results in a duty cycle of 33% which
@@ -646,7 +646,7 @@ static struct clk_regmap meson8b_cpu_clk = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_names = (const char *[]){ "xtal",
 						  "cpu_scale_out_sel" },
 		.num_parents = 2,
-- 
2.19.1

