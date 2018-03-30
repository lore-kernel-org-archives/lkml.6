Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbeC3PaK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 11:30:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52838 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbeC3P3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 11:29:09 -0400
X-Google-Smtp-Source: AIpwx48lkFU0fY80J3JTAHiZ5XRv6uLCuvmMQw8f5UP7DWp3Nu81YLASlYQwh/po3a90No+aeQsqUA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 6/8] remoteproc/davinci: use octal permissions for module_param()
Date: Fri, 30 Mar 2018 17:28:54 +0200
Message-Id: <20180330152856.12297-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330152856.12297-1-brgl@bgdev.pl>
References: <20180330152856.12297-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Checkpatch recommends to use octal perms instead of S_IRUGO.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index f134192922e0..b668e32996e2 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -25,7 +25,7 @@
 #include "remoteproc_internal.h"
 
 static char *da8xx_fw_name;
-module_param(da8xx_fw_name, charp, S_IRUGO);
+module_param(da8xx_fw_name, charp, 0444);
 MODULE_PARM_DESC(da8xx_fw_name,
 		 "Name of DSP firmware file in /lib/firmware (if not specified defaults to 'rproc-dsp-fw')");
 
-- 
2.16.3
