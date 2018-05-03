Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeECIpB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:45:01 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:61503 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeECIon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:44:43 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180503084442epoutp0294a73ab40b0d687662116f36f4a5e720~rFf6gRuWL2301123011epoutp029
X-AuditID: b6c32a49-583ff700000010df-35-5aeacbf9835c
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Stefan Agner <stefan@agner.ch>,
        Alison Wang <alison.wang@freescale.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH 04/13] drm/kms/mode/fsl-dcu: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
Date: Thu,  3 May 2018 14:14:31 +0530
Message-Id: <c6c9496f9824b73322646d360ed9250ce89bde7d.1525087679.git.satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRju2znbjuLic2p9GaScLmDl3BmbHmPrTq0ysPwRzERP+qGS22xn
        6waBtC5uuq4aJWZ2x5UZJl1MU7QsjRxkUhmYUVZaXspWRGVtO0r/nve58Ly8vBQhHxdHUrkm
        K7aYuDxaEkzebI2Jif35eNCgfP+CYV2d7SL2kruGZJ95RyTsoOczwXbVl0vY1tILErbas59k
        b1w7KF1K6c//6CX0462HRfpb3/vE+tdFD0X6Q3VuoB+rnZUsMWBtDuaysCUamzLNWbmmbB29
        LiV9RbomXsnEMolsAh1t4oxYR69MSo5dlZvnW4iO3s7l2XxUMsfzdNxircVss+LoHDNv1dGp
        DKNSMMoEhUqlUqg1aYtUGp8lA+ecqGgX59sjdta2PCILQEeoEwRRCKrRk4E+0gmCKTm8C1Dd
        +9fAL8jhV4DcQxmC8B2gT29/iCYTX/ZWE4LQCNC9sTNSIeEF6OZxuR9LfKYP5SfFflM4rAHI
        Ya8JDAQsAsjVuC8QD4MFAFU+HRH7IySci6ru9AbKZXAzarr7fKJvFnrZ6fAFKCoILkIN37YI
        9HUJ6hrSCngl6qnrJwUchgYf1kkFHInGhhsl/i4E7QD1XTsrFYZigAodbROuJWhfSTPpLyBg
        DKqpjxNoHXrluhrYjYBTkevXO5HfgqAMFR6QC5Y5qOpjKzHZ9bvSKRawHlXcd07wy1Dlr2qp
        cC4XQMWj58AREFX2v60SADeYgfN5YzbmNfmMCe9Q8JyRt5myFZlmYy0I/N78NbdBWWdSC4AU
        oENkzU8GDHIxt53fZWwBiCLocFlJ0aBBLsvidu3GFnO6xZaH+Rag8R32KBEZkWn2fbLJms6o
        E5Xq+PgERqlMVNPTZS/bew1ymM1Z8VaM87FlMieigiILwCqDLgRuNDYoPG0daakD4urQqXF/
        bQua7fdCZjaNv2lICVYOtLsvj3qKuzPXR+10Hx9Z69gQtWLeaY96dHTPrYuq+uQHC7zbnCVp
        5xyy2W7dlZKN04alsIrw9pSap2SEzpx7sWN5zwbvaiebEneFOrXjj3ahqrvCvru/oXjTjWPh
        NMnncMx8wsJz/wAvYqGZkQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvO7P06+iDP7+lLToPXeSyWLZqvUs
        Fle+vmezeHX+DbPF5V1z2CwOT13CZrH2fCuLxeZ17ewOHB6Lv99j9vh3uJ/JY/u3B6we97uP
        M3n0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxrR5J1kLmkUrNh06wdLAeEqwi5GTQ0LAROJj
        01rmLkYuDiGB3YwSx5/NYIdISEkse7ONDcIWllj57zk7RNFnRoltd1aDFbEBdT+fM4MVJCEi
        sJlR4uGelUwgDrNAL6PEi/37waqEBeokfhzvYASxWQRUJVbuvAdm8wrESOzffZ0JYoWcxM1z
        nUB3cHBwClhJ7PmSBBIWErCUaO87zDqBkW8BI8MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS9
        5PzcTYzgYNTS3MF4eUn8IUYBDkYlHt6M0y+jhFgTy4orcw8xSnAwK4nwTul+FSXEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QD45xbL4svBXpbba7+Fm/H
        Z/h+tb79R3sDl5tGjH5Clw8zFumpHJgzZ5da8vuWs+LnnvWumb5lGWOAUr5Tx/TOdwdX/TVa
        v8fjqdbRiFn3c75/6H7um2wrnWwfvvnunRB53bez7702VvjOWVnI7vdx5kTxHyud00M8n6hr
        VB4w98/SqDC+MDNikRJLcUaioRZzUXEiAKzxuqZCAgAA
X-CMS-MailID: 20180503084441epcas5p371997e3772a2fe2bfb4dc26447dafe65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503084441epcas5p371997e3772a2fe2bfb4dc26447dafe65
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503084441epcas5p371997e3772a2fe2bfb4dc26447dafe65
X-RootMTR: 20180503084441epcas5p371997e3772a2fe2bfb4dc26447dafe65
References: <cover.1525087679.git.satendra.t@samsung.com>
        <CGME20180503084441epcas5p371997e3772a2fe2bfb4dc26447dafe65@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicate logic for the same

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index 0e37524..3c651f8 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -17,6 +17,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <video/videomode.h>
 
 #include "fsl_dcu_drm_crtc.h"
 #include "fsl_dcu_drm_drv.h"
@@ -85,19 +86,13 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
 	struct drm_connector *con = &fsl_dev->connector.base;
 	struct drm_display_mode *mode = &crtc->state->mode;
-	unsigned int hbp, hfp, hsw, vbp, vfp, vsw, index, pol = 0;
+	unsigned int  index, pol = 0;
+	struct videomode vm;
 
 	index = drm_crtc_index(crtc);
-	clk_set_rate(fsl_dev->pix_clk, mode->clock * 1000);
-
-	/* Configure timings: */
-	hbp = mode->htotal - mode->hsync_end;
-	hfp = mode->hsync_start - mode->hdisplay;
-	hsw = mode->hsync_end - mode->hsync_start;
-	vbp = mode->vtotal - mode->vsync_end;
-	vfp = mode->vsync_start - mode->vdisplay;
-	vsw = mode->vsync_end - mode->vsync_start;
-
+	/* Configure timings:*/
+	drm_display_mode_to_videomode(mode, &vm);
+	clk_set_rate(fsl_dev->pix_clk, vm.pixelclock);
 	/* INV_PXCK as default (most display sample data on rising edge) */
 	if (!(con->display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE))
 		pol |= DCU_SYN_POL_INV_PXCK;
@@ -109,13 +104,13 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
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
 		     DCU_DISP_SIZE_DELTA_Y(mode->vdisplay) |
 		     DCU_DISP_SIZE_DELTA_X(mode->hdisplay));
-- 
2.7.4
