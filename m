Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754087AbeC1Pxv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:53:51 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57255 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753816AbeC1Pxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:53:50 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>, Felix Kuehling <Felix.Kuehling@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] amdkfd: always select MMU_NOTIFIER
Date: Wed, 28 Mar 2018 17:53:32 +0200
Message-Id: <20180328155340.2253343-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:WgGORML7OESKfZOITBTxHB0FzdjS2ap01YdNwv1mLjXSF6R0gxZ
 fAcoTQ83zkbpJ8r2VzbcdK0kVlLuOEwYxlkyZuzzy5W1h/ZQMsUrHuicN/eKKyYRVxGwWcL
 HQgomRE7o7AX1J84mRZrsQrpMk/W38fgNd3hgb6Th86Pfb0Utbw69KRO0vKHplpGfnUxile
 /YllLKIOv838zWkfBQPWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uI+zreIlG34=:xkm3iT4RWtL4TeEnwT5hap
 j80egPif2aHKiwuwgcWNvPjsPn6afcMqYLkpw41qAYk6bFkzhxTLQdxl3jw/Lwe50A2gLwN3a
 2OxNLPcgmttVpNpMU8STV0hiS0vONDjNa7I/xZeBl33oqZZn2QCRqn+ekgvkcX4ZmRNHJBKZw
 bEhGaAXRfTew4anI1voGGI/wzEEYDLOWkVTYmZZlffC6ncRFemTb0mOTWc7ekDASY00vWbENJ
 v/jWQ/jEw0/eGLBcNbP1/3U38lssYC39iR4/tJ8ncXtIhWMr2kCMwBT81ZAkfbA3FwYzBSGzw
 Jh9anl54u2Xek+AJ9bG85j6ZdoAXzlOrhuDF+BdE7P4Javd0BwQQcCQ04XKUmRDkGcfaFc+yW
 yf6KG/NaVYpehTsq/G0ilVD7HbcOU6cUTl8VFOcyrktiOJiqn0/Z9Iu7gQ9LAgGIBldZvrZdT
 ivXwm/+ZK/DcYbFH26gOiyfAAGDcikHtv+AJU7QMEj07VZ93KdvlMB1w8d5nmwU1MOISd/h4U
 admNpezHvDPDdaivfwCoSq6fR1xQ/TlkdB3iHqjhMDu4TOhLSlNiwqXVNnyv2xP5nFefJc5a5
 f22k5nLM8YouyU96gfRCaDfxGYMkkBvux9iauAEY43xRNSPPfzcPTYzL6aEkpVUGmavqDQU+P
 jl0fmDWHuWogVGfMLUC1W9Rn/VewvRZIUR6tK/Ibfqg7R75gLkSLb7WQq8kjaZyfAOlYUbKU/
 /TnbYiXZ/EdV46JCxAN7ST7Y9fwzRg6YTFC/3A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building amdkfd without MMU notifiers is broken:

In file included from drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c:28:
drivers/gpu/drm/amd/amdkfd/kfd_priv.h:584:22: error: field 'mmu_notifier' has incomplete type

This adds the missing 'select MMU_NOTIFIER' line to make it build
cleanly all the time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdkfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index ed2f06c9f346..5a26acb90e19 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -4,6 +4,7 @@
 
 config HSA_AMD
 	tristate "HSA kernel driver for AMD GPU devices"
+	select MMU_NOTIFIER
 	depends on DRM_AMDGPU && X86_64
 	imply AMD_IOMMU_V2
 	help
-- 
2.9.0
