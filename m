Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8425C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D67F20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iqeSoEgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D67F20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933170AbeFUIXe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:23:34 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40898 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933067AbeFUIX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:23:29 -0400
Received: by mail-wr0-f196.google.com with SMTP id g18-v6so2176861wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 01:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KbqRNbnzbe8/Ey7Ugahl5d/208DbpM7Y5rKdzyITjp0=;
        b=iqeSoEghBiUCKbRKabSm+oToSgWOoJn9k33BJShfKSpFnTCVGk4+d/rq022sjyy9Ct
         zgkEvESxEfgxJmQXqDQh0FdCqwv0Ue3zHhF4NPl93E+6U2f3GpOV3lHM8QRq+nEdpEHV
         ewSm/HB+tLdF+4uSLQ5DaLGjY9FvBf8K+CFOBCN8Ubv8IrCiok5Gupf8X8djuhBI+r6P
         a+9/pghkzeuJGZ5kltbM8L+kSz/JOEz/r+6KLsbJHcJ09B6tvBe/QXhSayIja8dl+2/Q
         ghiBWMqrnrlXweed868hMxROlekfexXOVe3Ca8AipB8MQtGpoWtnkixUsqWVK5bAJGFD
         PM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KbqRNbnzbe8/Ey7Ugahl5d/208DbpM7Y5rKdzyITjp0=;
        b=HNsCmlWIk48eSzOpqE4v6b0fHl9bl8nYh8H1Jo2IOEEDTAgR5bxFdEn6jq+xE5pZk4
         FZi5tpDzfZ4ljbpY2cXrfC2+nGSRneGRlV8uuJaGGxv0n0ySU3FNfLFlTStMj85M3wvF
         AOA9eta+6hsoWwLEUqw1lmy40SNCkYQL67KEEJC8jD4vbgCWO4A/iAj5AeBNRTQgoIc5
         6BcKl3Sy7DWLcoczKzK+2DFoCVm74+xc6iBfMh40p6/SFsyXud1nsZDmCRyJrhKBP3nC
         7ZeBNOUZ8YEBUjRIvX6Mkho+YYAjkb5aSxwXMFlP3cUl5JnQ0bGOU3VkvzyG3XSWNdJu
         fQZQ==
X-Gm-Message-State: APt69E2dgIfH9ET349FrphlOeISJvSm9EP1yIJF3ZyxcRfMGNVTOvelb
        BDLXO3ZBqEohL68/lE4ninnDug==
X-Google-Smtp-Source: ADUXVKLLlV8gMK0O08XTha54FupNsGIIPMmNVyqCYjCyYl/QMnJSh22CV2SFTgbczH/X7EOkS1ecWg==
X-Received: by 2002:adf:f246:: with SMTP id b6-v6mr20125298wrp.235.1529569408131;
        Thu, 21 Jun 2018 01:23:28 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-1-7080-22.w90-116.abo.wanadoo.fr. [90.116.249.22])
        by smtp.gmail.com with ESMTPSA id t124-v6sm4264869wmt.29.2018.06.21.01.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 01:23:27 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v3 1/3] clocksource: timer-ti-dm: remove the early platform driver registration
Date:   Thu, 21 Jun 2018 10:23:19 +0200
Message-Id: <20180621082321.4259-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621082321.4259-1-brgl@bgdev.pl>
References: <20180621082321.4259-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This driver is no longer used as an early platform driver. Remove the
registration macro.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 4cce6b224b87..595124074821 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -991,7 +991,6 @@ static struct platform_driver omap_dm_timer_driver = {
 	},
 };
 
-early_platform_init("earlytimer", &omap_dm_timer_driver);
 module_platform_driver(omap_dm_timer_driver);
 
 MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
-- 
2.17.1

