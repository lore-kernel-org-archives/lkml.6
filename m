Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeDXTzX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:55:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33321 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbeDXTzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:55:22 -0400
X-Google-Smtp-Source: AIpwx48KTE7XK7KYrTjb+g3BMn2rwIgbtDU8ARxOIYDWnxCAcMvgX69Px+JwfwIY2kZMXzIECpVUew==
From: Mathieu Malaterre <malat@debian.org>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Mathieu Malaterre <malat@debian.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: Change the default to PCI on PowerPC
Date: Tue, 24 Apr 2018 21:55:11 +0200
Message-Id: <20180424195512.491-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AGP mode is unstable on PowerPC. Symptoms are generally of the form:

[ 1228.795711] radeon 0000:00:10.0: ring 0 stalled for more than 10240msec

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index b28288a781ef..2a7977a23b31 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -168,7 +168,12 @@ int radeon_no_wb;
 int radeon_modeset = -1;
 int radeon_dynclks = -1;
 int radeon_r4xx_atom = 0;
+#ifdef __powerpc__
+/* Default to PCI on PowerPC (fdo #95017) */
+int radeon_agpmode = -1;
+#else
 int radeon_agpmode = 0;
+#endif
 int radeon_vram_limit = 0;
 int radeon_gart_size = -1; /* auto */
 int radeon_benchmarking = 0;
-- 
2.11.0
