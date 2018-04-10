Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeDJOyR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:54:17 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:51782 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753767AbeDJOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:54:15 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] vfio: platform: Make printed error messages more consistent
Date: Tue, 10 Apr 2018 16:54:11 +0200
Message-Id: <1523372051-23716-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Capitalize the first word of error messages,
  - Unwrap statements that fit on a single line,
  - Use "VFIO" instead of "vfio" as the error message prefix.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
v2:
  - Add Reviewed-by.
---
 drivers/vfio/platform/vfio_platform_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 4c27f4be3c3d0385..35469af87f88678e 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -630,8 +630,7 @@ static int vfio_platform_of_probe(struct vfio_platform_device *vdev,
 	ret = device_property_read_string(dev, "compatible",
 					  &vdev->compat);
 	if (ret)
-		pr_err("VFIO: cannot retrieve compat for %s\n",
-			vdev->name);
+		pr_err("VFIO: Cannot retrieve compat for %s\n", vdev->name);
 
 	return ret;
 }
@@ -673,7 +672,7 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 
 	ret = vfio_platform_get_reset(vdev);
 	if (ret && vdev->reset_required) {
-		pr_err("vfio: no reset function found for device %s\n",
+		pr_err("VFIO: No reset function found for device %s\n",
 		       vdev->name);
 		return ret;
 	}
-- 
2.7.4
