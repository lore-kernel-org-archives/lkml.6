Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeDTQdA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:33:00 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44823 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbeDTQc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:32:58 -0400
X-Google-Smtp-Source: AIpwx4+v5u/JF4FLbUXaZ62HxgyBenN846f8a1/2gHpaNfmFRMqyutIAYsEUuwZyNWyp488YhztnWw==
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: inki.dae@samsung.com, jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com
Cc: airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 2/2] drm/exynos: Allow DRM_EXYNOS on s5pv210
Date: Fri, 20 Apr 2018 18:32:16 +0200
Message-Id: <1524241936-10295-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524241936-10295-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1524241936-10295-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch brings back possibility to use drivers depending on
DRM_EXYNOS, on Samsung S5PV210/S5PC110 series based systems.

Fixes: dbbc925bb83a ("drm/exynos: depend on ARCH_EXYNOS for DRM_EXYNOS")
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/gpu/drm/exynos/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
index 735ce47688f9..1548a784ef71 100644
--- a/drivers/gpu/drm/exynos/Kconfig
+++ b/drivers/gpu/drm/exynos/Kconfig
@@ -1,6 +1,6 @@
 config DRM_EXYNOS
 	tristate "DRM Support for Samsung SoC EXYNOS Series"
-	depends on OF && DRM && (ARCH_S3C64XX || ARCH_EXYNOS || ARCH_MULTIPLATFORM)
+	depends on OF && DRM && (ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_MULTIPLATFORM)
 	select DRM_KMS_HELPER
 	select VIDEOMODE_HELPERS
 	select SND_SOC_HDMI_CODEC if SND_SOC
-- 
2.7.4
