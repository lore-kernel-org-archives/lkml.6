Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DC1C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1698C224D9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu1ObuiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1698C224D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934095AbeFUWmd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:42:33 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34033 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933653AbeFUWm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:42:27 -0400
Received: by mail-lf0-f65.google.com with SMTP id e13-v6so6649291lfc.1;
        Thu, 21 Jun 2018 15:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dZMcQjZGyGgzmNfiUwUeEHTFirCqtMMoxCTH6m+rFvI=;
        b=iu1ObuiMiekmTXMnE+ZFy867JP+V0lVBlirpr7w1f/dbbgMyNKauZAWOah/O9e0Cdf
         JS9n8xzfsFoplkVIr70uQFhvR+LoA41mmjyJ/oFtue4eoK9Sb5GtGaDfZGXu34iz/dut
         jvkjpikgb9xUpa2TUr+NlG3dF+L7dewH6VH6N1BwYGav7UerdBdgwsxpFW0YqprMwQWe
         2yGcxWJ9ynnRbQiwIBx8Adr/9xYSXDvjYaKY9G66R2zJlvB7FDXf8sxW5brxeNgoscz4
         VmY+7qhOmzs56LyO/vgsrxhkXleKVNc0G3b75i1RhPgxGFEbwsCo40GvtXhK2OoEzirw
         ZV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dZMcQjZGyGgzmNfiUwUeEHTFirCqtMMoxCTH6m+rFvI=;
        b=iYRkOKdL0h/eCfi7vdpP6eNyyvOsyLq5drhMNxRkTUn5swJ2roJ3j2tJVf21rXd+oP
         2sOaifPw/TqulEFBC5U0DuQ/KFhPpwpIaF4LSpvDhVMHop/kiYedHI17TDwe/ronl/vF
         Ujb5lczuwRIbDfvsJn4ddK2vvPE0YrgTOdhnpP/F+rnzzxz4p7jMC4v81kWNU8RLZ0N7
         zKzGVfKEnUIe5aDY+pMgdCAIaXikTUuGRFyNIe0jnNkM7HCVtcBJq5abPu6Q7AI7i+D1
         EW3BOEmfgfMWXhTObiYKC4hSVxHpg7cbtGdegmJ/SK91fdJEFM2JFjzSQvnkvo2GHGoW
         4pWg==
X-Gm-Message-State: APt69E0g0veHJGkKO3S9rMwB6pPrwZH4tCNIMANszBQ4dEsET3QebXJx
        ACzSbd7/9R8+LDPFPIYWtl8=
X-Google-Smtp-Source: ADUXVKJuVrVyMd9HIMaRt5ue5sFL5k+ZEOuti5ITQ9eCTubh0vFy5T8kBerSsaDsT5EeuVBtkPuGXg==
X-Received: by 2002:a2e:200f:: with SMTP id g15-v6mr18184793ljg.63.1529620945699;
        Thu, 21 Jun 2018 15:42:25 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id t6-v6sm1046153lje.18.2018.06.21.15.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:42:25 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "David S . Miller " <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 05/10] ARM: OMAP1: ams-delta: Hog "keybrd_dataout" GPIO pin
Date:   Fri, 22 Jun 2018 00:41:23 +0200
Message-Id: <20180621224128.17623-5-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180621224128.17623-1-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"keybrd_dataout" GPIO pin used to be initialized by ams-delta-serio
driver to a state safe for ams-delta-serio device function and not
changed thereafter.  As such, it may be assumed not under the driver
control and responsibility for its initialization handed over to board
init file.

Introduce a GPIO hog table and take over control of the
"keybrd_dataout" GPIO pin from the ams-delta-serio driver.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2: rebased on v4.18-rc1, no conflicts

 arch/arm/mach-omap1/board-ams-delta.c | 8 ++++++++
 drivers/input/serio/ams_delta_serio.c | 5 -----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 706eb2f9301d..2821284aa0c9 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -574,6 +574,12 @@ static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
 	&ams_delta_nand_gpio_table,
 };
 
+static struct gpiod_hog ams_delta_gpio_hogs[] = {
+	GPIO_HOG(LATCH2_LABEL, LATCH2_PIN_KEYBRD_DATAOUT, "keybrd_dataout",
+		 GPIO_ACTIVE_HIGH, GPIOD_OUT_LOW),
+	{},
+};
+
 static void __init ams_delta_init(void)
 {
 	/* mux pins for uarts */
@@ -594,6 +600,8 @@ static void __init ams_delta_init(void)
 	omap_cfg_reg(J19_1610_CAM_D6);
 	omap_cfg_reg(J18_1610_CAM_D7);
 
+	gpiod_add_hogs(ams_delta_gpio_hogs);
+
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 854d0d3ada52..b955c6a72e99 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -121,11 +121,6 @@ static const struct gpio ams_delta_gpios[] __initconst_or_module = {
 		.flags	= GPIOF_DIR_IN,
 		.label	= "serio-clock",
 	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_DATAOUT,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "serio-dataout",
-	},
 };
 
 static int ams_delta_serio_init(struct platform_device *pdev)
-- 
2.16.4

