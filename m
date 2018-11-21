Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E53C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B547214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDV3GiDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B547214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbeKVFHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53563 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733287AbeKVFHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so3288656wmi.3;
        Wed, 21 Nov 2018 10:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DFY3DydABVbR33exQJlwKtWgpi3dRu2TYxEKXuiiXVU=;
        b=ZDV3GiDUMApGuzeTfxHv7lhlySgjpPxSE3KBoB0KaT9T8OBVMRKPtkUDH0NIWTF1cY
         izeDlsnY3Ggyfp8jJEMeXnMBYNSYDkG3BPBJWfPq4VcCH17e6M2+gp32CBN4qiM+efqM
         Wvv9icmxUUyevTmRHuN0TrAjXcEl+300LH1zY/7doU3F4tqsawmDIz4UlnVb85cFuOOQ
         Hil51RpuEJBwA1dXZrX/iFRIUS6bPLmyTYu+DemUEJUuIEL2ILmQbE19pR/EnuS6865A
         VVTJ8037iw4HPziJXNUNWFtB4J3hLRVeAek5RTp9U/WdytY4VckdLZUa0+IgYzugEGVr
         mESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DFY3DydABVbR33exQJlwKtWgpi3dRu2TYxEKXuiiXVU=;
        b=nOc9L4iW6snno6vrl3bTc1wiDCCn2OYSQumGJI2dKKZc+kJ/uRLUkWBMC9jF6CmoAO
         22R1vanGYuLqbMk9EUMjq9qWUyXhWlHiQaIM7TXbPgqdviWIoYLFDllli716ESsP9eaA
         xoz7sAY86pfvuefrlPvFzy6WYuUTS5XIpq2D1STq29eHMSoMmbfze/YXVD1CLE2lt/y8
         wB8QIVGdFPuCF3ChbRYGFoDJ5SMYn1Tdr7kDgtIHd3PkZeoMP6DyKzqAJAijsXbxNz5I
         r+TEquUby2uyDYQz3R+Ln3VRCdouCNaJ/R9xHSKL0LQCgg0eBwVk0bNElBYGEireUvLh
         wDHw==
X-Gm-Message-State: AA+aEWaLjc2w/iQEdTfARZAu5BWZxaczE0JryCtGXtLk8sEsZwhD8EO2
        YL8RNpxaXF7MR56n1kAZTV2CwRddmDI=
X-Google-Smtp-Source: AJdET5fia/mb8AzgOcR/ZQEMV3r3rdEEkOV6SfmB56ChZCZh+RTvGaDxSG+t3Fz+m5TkKgvldCR4vA==
X-Received: by 2002:a1c:9690:: with SMTP id y138-v6mr7153266wmd.67.1542825127187;
        Wed, 21 Nov 2018 10:32:07 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:32:06 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [RFC PATCH v3 13/17] SoC: sunxi: Add support for Allwinner ARMv5 F1C100s sram
Date:   Wed, 21 Nov 2018 21:30:46 +0300
Message-Id: <89f6179c17a98f160301fdeef27df35b359847e3.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner ARMv5 F1C100s has similar sram controller to sun4i A10
Add compatible strings for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index b4b0f34..27f0607 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -99,6 +99,10 @@ static const struct of_device_id sunxi_sram_dt_ids[] = {
 		.compatible	= "allwinner,sun50i-a64-sram-c",
 		.data		= &sun50i_a64_sram_c.data,
 	},
+	{
+		.compatible	= "allwinner,suniv-f1c100s-sram-d",
+		.data		= &sun4i_a10_sram_d.data,
+	},
 	{}
 };
 
@@ -389,6 +393,10 @@ static const struct of_device_id sunxi_sram_dt_match[] = {
 		.compatible = "allwinner,sun50i-a64-system-control",
 		.data = &sun50i_a64_sramc_variant,
 	},
+	{
+		.compatible = "allwinner,suniv-f1c100s-system-control",
+		.data = &sun4i_a10_sramc_variant,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sunxi_sram_dt_match);
-- 
2.7.4

