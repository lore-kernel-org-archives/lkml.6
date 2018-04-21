Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753386AbeDUR06 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 13:26:58 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44182 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbeDUR0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 13:26:32 -0400
X-Google-Smtp-Source: AB8JxZoOxoHppn1o5oB8NiizkRxERd1txyXgwR3fjbEaULX6lqqC/cktqCnee6oiE3Ul6TmUyiFmWw==
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: inki.dae@samsung.com, jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com
Cc: airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 1/2] drm/exynos: fimd: Add support for S5PV210 FIMD variant
Date: Sat, 21 Apr 2018 19:26:10 +0200
Message-Id: <1524331571-7420-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524331571-7420-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1524331571-7420-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

This patch adds support for FIMD variant found on S5PV210 SoC.
Except CLKSEL bit availability, it is identical to Exynos4210.

Tested-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---

Changes from v1:
  - Added missing signed-off-by
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index d42ae2bc3e56..01b1570d0c3a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -121,6 +121,12 @@ static struct fimd_driver_data s3c64xx_fimd_driver_data = {
 	.has_limited_fmt = 1,
 };
 
+static struct fimd_driver_data s5pv210_fimd_driver_data = {
+	.timing_base = 0x0,
+	.has_shadowcon = 1,
+	.has_clksel = 1,
+};
+
 static struct fimd_driver_data exynos3_fimd_driver_data = {
 	.timing_base = 0x20000,
 	.lcdblk_offset = 0x210,
@@ -193,6 +199,8 @@ struct fimd_context {
 static const struct of_device_id fimd_driver_dt_match[] = {
 	{ .compatible = "samsung,s3c6400-fimd",
 	  .data = &s3c64xx_fimd_driver_data },
+	{ .compatible = "samsung,s5pv210-fimd",
+	  .data = &s5pv210_fimd_driver_data },
 	{ .compatible = "samsung,exynos3250-fimd",
 	  .data = &exynos3_fimd_driver_data },
 	{ .compatible = "samsung,exynos4210-fimd",
-- 
2.7.4
