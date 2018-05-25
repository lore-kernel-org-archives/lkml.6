Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966391AbeEYP0A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:26:00 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964823AbeEYPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:25:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] media: v4l: cadence: include linux/slab.h
Date: Fri, 25 May 2018 17:25:09 +0200
Message-Id: <20180525152523.2821369-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180525152523.2821369-1-arnd@arndb.de>
References: <20180525152523.2821369-1-arnd@arndb.de>
X-Provags-ID: V03:K1:KI/N2Y1Kr1RwYWjgmmK++++u2SCer5bqrOASvTmTpLUo1rEzEUV
 CmXmNz7LxljthPWYVB1wByrVUvDBPY7R/BvSqQ61o0NvyAPHx7KLN5o8a/9eb6RZfkoW/hq
 Gyfss/+znVZ4CnsToMkcz141HnWT2FhOSs5LxNSr/xTFvZYeHfOc0SAVMf8fR/MzEYktbj1
 dLuGpwCFsQlkAlOjcOR9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UHTpZ6O17xo=:iUVVHxCuVEb0OSnXAcpkLV
 c7HoNxjIFNyf27w7btaFDdPocIPBZwErGPJXqr/sVOY1+ZhS7t4/w4FXo3AxpESEO0uqy1mox
 A18jeQ7YMLOlZyplQR2PKvZfuo5C+3bIf71JxEzIrmCORjxp/JQi91dQR+PI5WQ9D/F0WXrSg
 NsJMYBqZin+/S1N98M/oSoa9ewsaMbl0DkNGxh28isXunp/VPmNKLgqJFJR2ztqf/3Oazjgda
 ak0ycTTcLR+E/CciKTSCZvcRge84iKQb3/ebcpLa6N5J0HrDmpyz3O9WMbwGouO4B06l4CZ01
 j7XUtwCTvw4AKbYk8Exlel4cy2y1Vyg9XFHMyO+1OL778xPXrBolni79m3NIz5Vg4sK/v8s6i
 /+SzbaC9H2UTmHcktWWcaIzUtwHAolw9Uh3RZKedvqTNcfBDEXgnw+Owh64UuYO+ddhRVR4F2
 pVYAEiFQkaG/ar4+7E7Wgh0Ry2JU0JtQe5RlOZVhXDFZ2WlM04nOo0svxYnQyAzMLECKyTC44
 nmMbBc+OCIsApkQdOOh7KYjLweqBbSWlyXwwQw6jFanSWYsYOp5wwdZLnQ3AdKEU5wRs8gJAF
 VmrjspdfvpUW99P6evarZXpATpAy8x3mDWfd9JCg2qvQ+FdTn0xxKVfnOSkqAd73lgLGwd0Kg
 OdQnVZYt4U4gqTfdwxjIW9Zggri5iEDT1qfaM7FAMRnBmowR5ZZBTEyQ+XyGrqHD78EM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a randconfig build error with the new driver:

drivers/media/platform/cadence/cdns-csi2tx.c: In function 'csi2tx_probe':
drivers/media/platform/cadence/cdns-csi2tx.c:477:11: error: implicit declaration of function 'kzalloc'; did you mean 'd_alloc'? [-Werror=implicit-function-declaration]

kzalloc() is declared in linux/slab.h, so let's include this to make it
build in all configurations.

Fixes: 84b477e6d4bc ("media: v4l: cadence: Add Cadence MIPI-CSI2 TX driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 1 +
 drivers/media/platform/cadence/cdns-csi2tx.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index a0f02916006b..43e43c7b3e98 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -13,6 +13,7 @@
 #include <linux/of_graph.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
diff --git a/drivers/media/platform/cadence/cdns-csi2tx.c b/drivers/media/platform/cadence/cdns-csi2tx.c
index dfa1d88d955b..40d0de690ff4 100644
--- a/drivers/media/platform/cadence/cdns-csi2tx.c
+++ b/drivers/media/platform/cadence/cdns-csi2tx.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
-- 
2.9.0
