Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4035C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E662147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdZkluLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfBTKwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:52:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52387 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBTKwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:52:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so6145797wml.2;
        Wed, 20 Feb 2019 02:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lYnBEEmpFBDz1hV5pZ2bsdS3p6zU1mRjCvzLhQfwBdU=;
        b=JdZkluLz++Mx1C8JiA/Y2HkZRRrTukTquhr1Bc06g67MGdllzRv3YMEEw4PaAxmG87
         6v50islDKr6LIYHEvsb1vHlOPhKZPPedQmHNJhBVMFkKM6oouKGHCX/flTCxLyo5/flS
         z5zxh0ILplOBybnUXjZ8yn3BxwvX/iYECqw2lrRxk/JOydZmQchxQR6APeOwaHBlSJ1v
         f4/xjvmGsyHIUfEO5kLpSKrgTTvEa9/sseCa6orotADkdQf5SUQ5TNg2a1Qu5zq4qQMV
         hopl1QXwCGK1S/QueLT1P4LGfxCCjmcb8OPvB4qPcSbq9XyiuoNlB3PP2L6CfdCKtXr1
         H2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lYnBEEmpFBDz1hV5pZ2bsdS3p6zU1mRjCvzLhQfwBdU=;
        b=H/fTGdbQ4/Kfko+XtHL//bwWW6PKKaANAhiRSBbbIU46sEqO3NhXK8TYZ8r8O/ULNI
         ziROzx3BnVlZg9QyQqN/7AMMzZU3Hqm0CVVKTMZ4J0jpeaxX4Tdv91HFj4PjpJbs1gng
         6T3BGCX9W/5Xg22B/JzR8eGHG34/OA0jb8bUIIG/l5/Yy8D0g6AjeHNb2rzWLvB2WUlC
         PJlIVWZc3OljTPWv6FLPK66o8j9Ri68BG1yXA4z0IjuJxXylWonhZYGJJZx1ukvIIgkS
         NRk61SgXfbPr6NI8YccGFz6nTKa2zZnjYaf5oYGLHETPrDsw+ciSvd1KnPgxTaGSZL+W
         NyUA==
X-Gm-Message-State: AHQUAuZz5G3I9omtQRSr6NVELKUp7uiDfs/+I6JOPrEr6A9VdJ+BlYU9
        K6ZLj6WIMy99Dwa4SfK/imw=
X-Google-Smtp-Source: AHgI3Ib8tZOBhlpIHsUcatq1jFAnz6U4iN8Qjx/XBkj5nLUAi+WZZlM9GaBryPbNj5VL+diTxEtjoQ==
X-Received: by 2002:a1c:6789:: with SMTP id b131mr6172877wmc.22.1550659935752;
        Wed, 20 Feb 2019 02:52:15 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id 12sm10391904wme.25.2019.02.20.02.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 02:52:15 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: of: Restrict enable-gpio quirk to regulator-gpio
Date:   Wed, 20 Feb 2019 11:52:14 +0100
Message-Id: <20190220105214.26618-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Commit 0e7d6f940164 ("gpio: of: Apply regulator-gpio quirk only to
enable-gpios") breaks the device tree ABI specified in the device tree
bindings for fixed regulators (compatible "regulator-fixed"). According
to these bindings the polarity of the GPIO is exclusively controlled by
the presence or absence of the enable-active-high property. As such the
polarity quirk implemented in of_gpio_flags_quirks() must be applied to
the GPIO specified for fixed regulators.

However, commit 0e7d6f940164 ("gpio: of: Apply regulator-gpio quirk only
to enable-gpios") restricted the quirk to the enable-gpios property for
fixed regulators as well, whereas according to the commit message itself
it should only apply to "regulator-gpio" compatible device tree nodes.

Fix this by actually implementing what the offending commit intended,
which is to ensure that the quirk is applied to the GPIO specified by
the "enable-gpio" property for the "regulator-gpio" bindings only.

This fixes a regression on Jetson TX1 where the fixed regulator for the
HDMI +5V pin relies on the flags quirk for the proper polarity.

Fixes: 0e7d6f940164 ("gpio: of: Apply regulator-gpio quirk only to enable-gpios")
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpiolib-of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 1b4c741e0635..bddfc6102a50 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -84,10 +84,10 @@ static void of_gpio_flags_quirks(struct device_node *np,
 	 * Note that active low is the default.
 	 */
 	if (IS_ENABLED(CONFIG_REGULATOR) &&
-	    !strcmp(propname, "enable-gpio") &&
 	    (of_device_is_compatible(np, "regulator-fixed") ||
 	     of_device_is_compatible(np, "reg-fixed-voltage") ||
-	     of_device_is_compatible(np, "regulator-gpio"))) {
+	     (of_device_is_compatible(np, "regulator-gpio") &&
+	      strcmp(propname, "enable-gpio") == 0))) {
 		/*
 		 * The regulator GPIO handles are specified such that the
 		 * presence or absence of "enable-active-high" solely controls
-- 
2.20.1

