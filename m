Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1525254508; cv=none;
        d=google.com; s=arc-20160816;
        b=c2lhQz6Z7FwOZqOMDxgzJ6Q+9BZIhpZoXo1fbVDvK1m1NwPlVrDmkL/8MDBeeoYDHw
         e7dAnVt+JuSnfRD/hA5ZjeuIK8Q/Rttuk6SKEndv4K2IR7+rh3DDKy7Tq0LG9mF+/FAp
         GS+iaFOrQ52iW0c5Kyvl5RYmTK5W6WHkeeW58S3TvJBR9dKutIufuVnG7HzWqZ8nGitW
         qvs66M2eTSWuJ4AWypEnVyGFcM9HDDtsEthnENV4lsX3GpoJWwkoz/Ys+hRPxvaH8cgw
         M4ZEVRnkJuXD/9puNmjbc0zFwYdRnwyrw8vg/evoooaMyZzSEr+reb40Ypw014wIZcp+
         MYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=8oh/OIT/9h7vCEGTmCnH0Ht+WYiSAYFVks6ovjWTYxY=;
        b=tV3y/2hm6Yi+yb3hvOlqLSGzhCrkOQEnnEawfOLHon6lytNcnilEtWYqD+8BLlZFpR
         3XQRnkmjbGgUnxfkGAYi9J1zeDiw9uWemTali+FrThgxDZbjR/1UyH9kV4x8AVx1063u
         sRPSMtWI5fKqtF78dIVR7sM0o8q4xgun9wOh21qlZZSFiWpZCojgIr/2LRYn7JCxEpci
         eXd6wh5JRCbpt6zON4tEdYmPV0NNVFUn67FBYx4e+eBTcaHqKj3z1m3n+PwBvjUc5H/3
         ITaBdUvKr0uvIQfPsOSDbq4ymWUe3qJGuz+ceHWK+WaRaBwOuHriPqfrnPZD0ytR68Dn
         V2AA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=z515WefC;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=z515WefC;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AB8JxZoLqgmlhumqI05D8PZFN3xsuI52hrK9OWhLbBhKTtYQvnujf8EffrgHp3XMHddOc3Xsvjnq6w==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Peter Rosin <peda@axentia.se>,
	Jiri Slaby <jslaby@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/3] clocksource: timer-ti-dm: remove the early platform driver registration
Date: Wed,  2 May 2018 11:48:19 +0200
Message-Id: <20180502094821.2907-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502094821.2907-1-brgl@bgdev.pl>
References: <20180502094821.2907-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599345271215291308?=
X-GMAIL-MSGID: =?utf-8?q?1599345271215291308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This driver is no longer used as an early platform driver. Remove the
registration macro.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
2.17.0
