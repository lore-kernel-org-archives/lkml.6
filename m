Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbeEHERE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 00:17:04 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:41935 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbeEHERC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 00:17:02 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180508041700epoutp043858a42abc80a30e8739719a65a251ce~skEnpo_XZ0066400664epoutp04T
X-AuditID: b6c32a49-56bff700000010df-b6-5af124bb48aa
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Stefan Agner <stefan@agner.ch>,
        Alison Wang <alison.wang@freescale.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: sst2005@gmail.com, Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH v1 04/13] drm/kms/mode/fsl-dcu: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
Date: Tue,  8 May 2018 09:45:55 +0530
Message-Id: <1525752955-9497-1-git-send-email-satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <ac53f43cece86178076bc78c94cf06d4@agner.ch>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTcRTH+9277V6jxW0ZnQRLbgUVuHbHptfIHmR5e0CjIGJR66a/nOnu
        1u60LCJ7OZ3ZKnqa2aK3pSuTHloUGokFipSWgeUfvam08hEY1ead9N/5nvM55/v7HQ5N6nya
        GDpT8mC3JGazmpGqWw3Tp8XXTfluNdzwA1/S3ETwFyuCKv55X7eG/9zyheSf1ZZp+Iaj5zV8
        Zcs+FX/p6QuSv1nlpeZFCecGXpPCnwY/Idwt7aSE2/1dauFNcSMhHKipQMLP6okWyopn27GY
        jt1xWEpzpmdKGcns0pW2BTZzgoGL55L4RDZOEh04mU1ZZolflJkdehoblytm54RSFlGW2Zlz
        ZrudOR4cZ3fKnmR2DccZ9ZwhUW80GvUm89pZRnMIWY/t1ZWHKVcwduv1mjqUj66CD0XRwJjg
        QHmxyodG0jqmDkHh83sR8QPB1+46jSL6ETQdC6qGW9rfVCGlcB/Bn9aBiOhDcO1WPxGmNCHq
        Q9kJdbgQzQQRFO0JDgmSCSA48/c0ClNjmT0ILlZNDscqZirsHxikwrGWWQgdl2sjfhOho7mI
        9CGajmJ46O1aFZ4DzCMN9PU+oxQmBXb39ET4sfC5sSaSj4FP/gJKaQh5dVWdjYj9ob8WPY5Q
        c2HvkYeqsAPJTIdg7UwlnQze7pKhoSQzGkoG3xJhBBgtFBboFGQKXPnYQA57/Q741EosQKO3
        jVDi+eDt8hPKiooRnH1ZSx1Ek0r/uwUQqkATsEt2ZGDZ7OIkvEUviw45R8rQpzkd1WjoDmcs
        voNKm5fVI4ZG7CjtL1ePVacWc+U8Rz0CmmSjtZNjv1t12nQxbxt2O23unGws1yNzaLOHyJhx
        ac7QVUseG2dKMpgSEhI5gyHJxI7XdjS9tuqYDNGDszB2YfdwH0FHxeSjXXmnGKL90bUlBbsa
        j5c9KE81nCnrqGwV5kqdbYXXe/3FfEWqxeoxf1zDxc5yBTcdfbJ0u7fyVX7rycD43BXSGK3t
        Xc0OaNnx/kJ0/qBO/aMtBZkCn9otLTJ1pHP18ksvN+ON9tQl3W03erPW5Y1wbRjYWa7OStJ9
        ext/F7/70M+qZLvIzSDdsvgP67u/Ap0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSvO4ulY9RBlefiln0njvJZLFs1XoW
        iytf37NZvDr/htni8q45bBaHpy5hs1h7vpXFYvnp68wWm9e1sztweiz+fo/Z49/hfiaPnbPu
        snts//aA1eN+93Emj74tqxg9Pm+SC2CP4rJJSc3JLEst0rdL4MrYtHYSe8F62YoNW3YzNjCu
        luhi5OSQEDCRuHZ/HWMXIxeHkMBuRokTFxYxQiSkJJa92cYGYQtLrPz3nB2i6DOjxMmz/Uwg
        CTag7udzZrCCJEQENjNKPNyzkgnEYRZYxChxYMIxMEdYoJFR4t2N1WBzWQRUJXq+/2YHsXkF
        XCVurtjFArFDTuLmuU7mLkYODk4BC4kvD8JAwkIC5hIz311imsDIt4CRYRWjZGpBcW56brFh
        gWFearlecWJucWleul5yfu4mRnCIamnuYLy8JP4QowAHoxIP74+CD1FCrIllxZW5hxglOJiV
        RHiVZT9GCfGmJFZWpRblxxeV5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbLxMEp1cAo
        vOlZ7rI7e89dlT7/9UD/J6ND/472PLh0PLL7wJK+ixnV281jfv45Yno9t14v5pzJwa6OAsHl
        qz0OHX38RrEyarr8I8lW1nVaywIKLRktP9h5BBwL/hafZx9opLkh5P7PtU/+nnb1XNS/OXPZ
        Lv9/4fpurqXWF/aK9Be9fnCz1bGrmv3sJv79SizFGYmGWsxFxYkA+h3NNU0CAAA=
X-CMS-MailID: 20180508041658epcas5p2deee8f1a13c2b00d7d628063d8b16b00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180508041658epcas5p2deee8f1a13c2b00d7d628063d8b16b00
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180508041658epcas5p2deee8f1a13c2b00d7d628063d8b16b00
X-RootMTR: 20180508041658epcas5p2deee8f1a13c2b00d7d628063d8b16b00
References: <ac53f43cece86178076bc78c94cf06d4@agner.ch>
        <CGME20180508041658epcas5p2deee8f1a13c2b00d7d628063d8b16b00@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-Using drm_display_mode_to_videomode to avoid duplicate logic
-Removed index = drm_crtc_index(crtc) as it is unused
-Replaced DRM_MODE_FLAG_* flags with DISPLAY_FLAGS_* flags
-Replaced mode->h/vdisplay with vm.h/vactive

Acked-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---

 v1: 
 	Thanks for the comments Mr Stefan. I fixed most of them, other ones can't be fixed as explained below:
     	Header <video/videomode.h> defines struct vm, therefore we can't remove it.
     	Tried to add new line below clk_set_rate but checkpatch gave error.

	Other changes in the patch:
     	Removed index = drm_crtc_index(crtc) line as it is unused
     	Replaced DRM_MODE_FLAG_* flags with DISPLAY_FLAGS_* flags
     	Replaced mode->h/vdisplay with vm.h/vactive
	Added acked-by field

 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c | 37 ++++++++++++------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index 0e37524..d6ea667 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -17,6 +17,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <video/videomode.h>
 
 #include "fsl_dcu_drm_crtc.h"
 #include "fsl_dcu_drm_drv.h"
@@ -85,40 +86,32 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
 	struct drm_connector *con = &fsl_dev->connector.base;
 	struct drm_display_mode *mode = &crtc->state->mode;
-	unsigned int hbp, hfp, hsw, vbp, vfp, vsw, index, pol = 0;
-
-	index = drm_crtc_index(crtc);
-	clk_set_rate(fsl_dev->pix_clk, mode->clock * 1000);
-
-	/* Configure timings: */
-	hbp = mode->htotal - mode->hsync_end;
-	hfp = mode->hsync_start - mode->hdisplay;
-	hsw = mode->hsync_end - mode->hsync_start;
-	vbp = mode->vtotal - mode->vsync_end;
-	vfp = mode->vsync_start - mode->vdisplay;
-	vsw = mode->vsync_end - mode->vsync_start;
+	unsigned int pol = 0;
+	struct videomode vm;
 
+	drm_display_mode_to_videomode(mode, &vm);
+	clk_set_rate(fsl_dev->pix_clk, vm.pixelclock);
 	/* INV_PXCK as default (most display sample data on rising edge) */
 	if (!(con->display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE))
 		pol |= DCU_SYN_POL_INV_PXCK;
 
-	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+	if (vm.flags & DISPLAY_FLAGS_HSYNC_LOW)
 		pol |= DCU_SYN_POL_INV_HS_LOW;
 
-	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+	if (vm.flags & DISPLAY_FLAGS_VSYNC_LOW)
 		pol |= DCU_SYN_POL_INV_VS_LOW;
 
 	regmap_write(fsl_dev->regmap, DCU_HSYN_PARA,
-		     DCU_HSYN_PARA_BP(hbp) |
-		     DCU_HSYN_PARA_PW(hsw) |
-		     DCU_HSYN_PARA_FP(hfp));
+		     DCU_HSYN_PARA_BP(vm.hback_porch) |
+		     DCU_HSYN_PARA_PW(vm.hsync_len) |
+		     DCU_HSYN_PARA_FP(vm.hfront_porch));
 	regmap_write(fsl_dev->regmap, DCU_VSYN_PARA,
-		     DCU_VSYN_PARA_BP(vbp) |
-		     DCU_VSYN_PARA_PW(vsw) |
-		     DCU_VSYN_PARA_FP(vfp));
+		     DCU_VSYN_PARA_BP(vm.vback_porch) |
+		     DCU_VSYN_PARA_PW(vm.vsync_len) |
+		     DCU_VSYN_PARA_FP(vm.vfront_porch));
 	regmap_write(fsl_dev->regmap, DCU_DISP_SIZE,
-		     DCU_DISP_SIZE_DELTA_Y(mode->vdisplay) |
-		     DCU_DISP_SIZE_DELTA_X(mode->hdisplay));
+		     DCU_DISP_SIZE_DELTA_Y(vm.vactive) |
+		     DCU_DISP_SIZE_DELTA_X(vm.hactive));
 	regmap_write(fsl_dev->regmap, DCU_SYN_POL, pol);
 	regmap_write(fsl_dev->regmap, DCU_BGND, DCU_BGND_R(0) |
 		     DCU_BGND_G(0) | DCU_BGND_B(0));
-- 
2.7.4
