Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeC0JVs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:21:48 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37458 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbeC0JUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:20:44 -0400
X-Google-Smtp-Source: AG47ELsnMS7vDi8uqUQnoH++al3QeGdkZCAvzqD6TY3/5CNoVs19D9QP6fcWtLTk6PM+c5tGGK/jKg==
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
Subject: [PATCH v3 6/8] remoteproc/davinci: use octal permissions for module_param()
Date: Tue, 27 Mar 2018 11:20:29 +0200
Message-Id: <20180327092031.11251-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180327092031.11251-1-brgl@bgdev.pl>
References: <20180327092031.11251-1-brgl@bgdev.pl>
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
2.16.1
