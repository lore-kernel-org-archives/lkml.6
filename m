Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AEAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21794208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LBjQqP0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21794208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeH0Mwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:52:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44676 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbeH0Mwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:52:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so12875816wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C9hBFeW1XpyUI+s87+Cs1O83xuUM37jrL1J/FJogS0E=;
        b=LBjQqP0MOyHxfXCq/frcYGrk6XC51iaDTz0KAMn5CuQpdkv4hfrtJ1nzdEHey/KNCQ
         1Yud0TH4Vzvtx+qvSDNj+qOm0kqYs71ciloixt9/7q5C8fvattpIFq6xVwjeQKn280mj
         P2Ao2T7tToM1j9jF7k0QsXjRWgtMVmtq+OzkfO1BWrHwuquMSnkXj5N5rwyt1NW82I7a
         iqPzGblXU+9Rv4CEpzihmK7dt0P8jaQn/5n4kaKzqw2tuORpqw9Lba3LMZGWRUe1GrdN
         Up3kEurlO0Z5MfcF0PMMGhODL7IIvZvKtoy8WOqN8Um0MOrMMhec+Kpssj1ULQdYSe3U
         01mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C9hBFeW1XpyUI+s87+Cs1O83xuUM37jrL1J/FJogS0E=;
        b=BaCTbc6dyf0rUonerM2FZWZeS63rT6iTm73V0sHN3Js1dD4F4y4JL+24WKRDqnNW9u
         85HvRO3tWEjHK9fsB6MTMPJHLTBP7y9KUIDTsjXGSB5guOih90B731xvcxUlQQVP+TtO
         z4FoTuHjFcwje2KP0J9WDHtEY0dCOEOob155eZIJIzCVBQVBvfsOxRd+IYAJoVAp7209
         Zm/uZ4InXXPHDfsAEd/o+TBF0DSUlp6eZWzSQDV/2QS4pp/g8eAuyNBrxS75HMC8DjtN
         2U5k6/Pzm6Fzen2UzQQjcQQrRl6X16TeaYKaO4q4cHQHazYgjPO06uRbPNcIPnaio2n6
         ScpQ==
X-Gm-Message-State: APzg51B7OXEJAfO3dqRb78cR6oUqfuKQFqqyxl5UGHrLaFazZCPx3TlI
        eQGNS54ShMB8zRAJSv1KGSr8zQ==
X-Google-Smtp-Source: ANB0VdbrIAcc34mZ99oDtpmMTiZBVuSqDDMX6fsy5YCbQfMvcsAWa20DYHP/nuyJhU56DPNO2sMj0A==
X-Received: by 2002:adf:c4c9:: with SMTP id o9-v6mr8352121wrf.173.1535360820970;
        Mon, 27 Aug 2018 02:07:00 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-34-229.w90-86.abo.wanadoo.fr. [90.86.153.229])
        by smtp.gmail.com with ESMTPSA id j6-v6sm11470979wru.64.2018.08.27.02.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 02:07:00 -0700 (PDT)
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
        Frank Rowand <frowand.list@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v3 1/3] clocksource: timer-ti-dm: remove the early platform driver registration
Date:   Mon, 27 Aug 2018 11:06:49 +0200
Message-Id: <20180827090651.25062-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827090651.25062-1-brgl@bgdev.pl>
References: <20180827090651.25062-1-brgl@bgdev.pl>
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
2.18.0

