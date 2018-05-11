Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeEKQVm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:21:42 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42788 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbeEKQVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:21:37 -0400
X-Google-Smtp-Source: AB8JxZpRvn5r8Ql0ms9vDGBpVqiyG9YCbH+m9Qr0ZQvQPVoK0Nfi2Em1rvj5qJdsmFtKk618qIaxsg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
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
        Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 05/12] platform: export platform_device_release() locally
Date: Fri, 11 May 2018 18:20:21 +0200
Message-Id: <20180511162028.20616-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The early platform driver mechanism will use this function as the
device release callback. Make it available in drivers/base.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/base.h     | 1 +
 drivers/base/platform.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 7a72ae72a98e..514a6d198f14 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -164,3 +164,4 @@ extern void device_links_unbind_consumers(struct device *dev);
 
 /* Platform device helpers. */
 extern int platform_match(struct device *dev, struct device_driver *drv);
+extern void platform_device_release(struct device *dev);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 0ba4effb9618..417ab6071350 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -239,7 +239,7 @@ void platform_device_put(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(platform_device_put);
 
-static void platform_device_release(struct device *dev)
+void platform_device_release(struct device *dev)
 {
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
-- 
2.17.0
