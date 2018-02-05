Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753031AbeBEMsP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:48:15 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34576 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752918AbeBEMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:48:00 -0500
X-Google-Smtp-Source: AH8x226ZhkGJHfoIbdXaEN1VZmfYt32Qhqy9FQf191V7VUZ5JGDKLKg6j99ANYbgmaLPbJFqqGsa/Q==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: meson-gx-mmc: Explicitly include pinctr/consumer.h
Date: Mon,  5 Feb 2018 13:47:50 +0100
Message-Id: <20180205124750.19305-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180205124750.19305-1-thierry.reding@gmail.com>
References: <20180205124750.19305-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The Meson GX MMC driver fails to build after commit 23c35f48f5fb
("pinctrl: remove include file from <linux/device.h>") because it relies
on the pinctrl/consumer.h being pulled in by the device.h header
implicitly.

Include the header explicitly to avoid the build failure.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 32a6a228cd12..22438ebfe4e6 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -37,6 +37,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/bitfield.h>
+#include <linux/pinctrl/consumer.h>
 
 #define DRIVER_NAME "meson-gx-mmc"
 
-- 
2.15.1
