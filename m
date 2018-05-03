Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeECIgS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:36:18 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:56519 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeECIgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:36:12 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180503083610epoutp02890cabe6cab4989b59a64852787bf8a2~rFYeUSER21669716697epoutp029
X-AuditID: b6c32a4a-a79ff700000010d4-98-5aeac9fa548c
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH 01/13] drm/kms/mode/atmel-hlcdc: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
Date: Thu,  3 May 2018 14:06:00 +0530
Message-Id: <b9ad5cb3c236c149b14df031d0a50226ee1fbff7.1525087679.git.satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTcRjtt7tdp7W6TKtfgjpuD5jg2p2bXkV7mq0XWP7VKtxNf+houxv3
        bvbClNLK2UxBQc1qlZXZC1ZkWppopYYZPQiiJxlUaz3IR5K97rxK/53zfedwDh+fHFOW4pFy
        C+tEHMtYSTxMeq1LrY772es3ab3DobSnv1dCH/hyJoRuv3dYSj8Z/orT/gcBjPYNPJXRj1vr
        cbqrugGnm6+cwOiLD0qkS8KMxy7sNjaPvJEZX5d1S4xXGgqNL0ZPA2P51SZgHPRFZ4SYUEoe
        YnIQp0Jstj3Hwuamkmsys5ZnGRK0VByVRCeSKpaxoVQybW1GXLrFKrQjVfmM1SWMMhieJxcu
        SuHsLidS5dl5Zyq5iaJ0GkqbqNHpdBq9YUuyziBIzCjv25F0R9GsHf4fdBE4pHSDUDkk9PDt
        hSEQxEriBoA3RyJE/B3A6mOr3CBMwCMA+qp7QiYNfY3PZeKiDcBPrR4gkmEAD5adlQRVuKB6
        X18zroogjkrg17pOaZBgRBmAnrZiLEjCiWIA3S0D4xYpMR96y8vHsYLYDP/03QJiYDR81l8q
        GOTyUCIZ3hzaGvRCogOH3+6dx0VNGnxad1si4nDo7746UTYSDn5pw0XDPgDfXDoRIpJDQtnS
        uxOqxbC4qkMaTMAINbzculAcp8KHLbWyIMaI6dAz9k4SlEBCAQ/un7jePHjuQxc2mfXL65aJ
        2Aj3Bionui2F7QGPTLyqB8AS38oKEFP3P8wLQBOYgxy8LRfxBoeORds1PGPjXWyuJttu84Hx
        N4xdfR2c6V/bCQg5IKcpOu5/NCllTD6/09YJoBwjIxRVZX6TUpHD7NyFOHsW57IivhMYhMNW
        YpEzs+3CU7POLEqfpNUnJCRSWm2SnpyteNb7yqQkchkn2oaQA3GTPok8NLIIrO+fUbTnd80N
        NPCXGz1V8GlKclSsJX5FvC3zTmb21L51VTXqnpLGs4PtMwcstZs+x0c1Pio2O8g7XHPghRVq
        58XcLTBXn3QHji6IYu3HayrcFQ959YIIrG5u7+VoC5FQTy1bbc4fedmkHyrsuaUyd6dsyNwY
        vnvM62rwu8ymFlLK5zFULMbxzD+bUBjtnAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnO6Pk6+iDA51m1n0njvJZNH+bhm7
        xb5T/SwWV76+Z7N4df4Ns8Wmx9dYLS7vmsNmcXjqEjaL7ZsXMlusPd/K4sDlMW9Ntcf2bw9Y
        Pe53H2fy2Lyk3uPOj6WMHn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJXxYbZbQYNYxavvFg2M
        PUJdjJwcEgImEmdW3GbtYuTiEBLYzSgxaf82NoiElMSyNzC2sMTKf8/ZIYo+M0psmXWJGSTB
        BtT9fM4MsG4RgcVMErfn/mUEcZgFehklXuzfD9YiLNDEKLFhw1x2kBYWAVWJBX19TCA2r0CM
        xL8z+xkhdshJ3DzXCTSWg4NTwEpiz5ckkLCQgKVEe99h1gmMfAsYGVYxSqYWFOem5xYbFhjl
        pZbrFSfmFpfmpesl5+duYgQHqZbWDsYTJ+IPMQpwMCrx8B44+zJKiDWxrLgy9xCjBAezkgjv
        lO5XUUK8KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeWpGanphakFsFkmTg4pRoY57V/
        kH68wve6b3ytJ7vZHWVhockLteYZNf5Wuux/Jm5z+vu7U/ymq6e4TNvvaM0sYeqwpobbyybD
        QOIci5pEzJ2zMsdXcSmYVwV9ufXw991ZBU5b+hf/NTjGfzVs9tO9Qjf9dRc0l+8zu/vT1n8C
        54/gBesffpSb/UTqocgkHamXF464nfwkqsRSnJFoqMVcVJwIALAvAi9OAgAA
X-CMS-MailID: 20180503083608epcas5p4c9cda0f0b42af8232691baa7cbde96c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503083608epcas5p4c9cda0f0b42af8232691baa7cbde96c9
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503083608epcas5p4c9cda0f0b42af8232691baa7cbde96c9
X-RootMTR: 20180503083608epcas5p4c9cda0f0b42af8232691baa7cbde96c9
References: <cover.1525087679.git.satendra.t@samsung.com>
        <CGME20180503083608epcas5p4c9cda0f0b42af8232691baa7cbde96c9@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicate logic for the same:
There is a function in drm-core to calculate display timing parameters:
horizontal front porch, back porch, sync length,
vertical front porch, back porch, sync length and
clock in Hz.
However, some drivers are still calculating these parameters themselves.
Therefore, there is a duplication of the code.
This patch series replaces this redundant code with the function
drm_display_mode_to_videomode.
This removes nearly 100 redundant lines from the related drivers.

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index c1ea5c3..3dfeef0 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 
 #include "atmel_hlcdc_dc.h"
+#include <video/videomode.h>
 
 #define ATMEL_HLCDC_LAYER_IRQS_OFFSET		8
 
@@ -393,27 +394,24 @@ enum drm_mode_status
 atmel_hlcdc_dc_mode_valid(struct atmel_hlcdc_dc *dc,
 			  const struct drm_display_mode *mode)
 {
-	int vfront_porch = mode->vsync_start - mode->vdisplay;
-	int vback_porch = mode->vtotal - mode->vsync_end;
-	int vsync_len = mode->vsync_end - mode->vsync_start;
-	int hfront_porch = mode->hsync_start - mode->hdisplay;
-	int hback_porch = mode->htotal - mode->hsync_end;
-	int hsync_len = mode->hsync_end - mode->hsync_start;
-
-	if (hsync_len > dc->desc->max_spw + 1 || hsync_len < 1)
+	struct videomode vm;
+
+	drm_display_mode_to_videomode(mode, &vm);
+
+	if (vm.hsync_len > dc->desc->max_spw + 1 || vm.hsync_len < 1)
 		return MODE_HSYNC;
 
-	if (vsync_len > dc->desc->max_spw + 1 || vsync_len < 1)
+	if (vm.vsync_len > dc->desc->max_spw + 1 || vm.vsync_len < 1)
 		return MODE_VSYNC;
 
-	if (hfront_porch > dc->desc->max_hpw + 1 || hfront_porch < 1 ||
-	    hback_porch > dc->desc->max_hpw + 1 || hback_porch < 1 ||
-	    mode->hdisplay < 1)
+	if (vm.hfront_porch > dc->desc->max_hpw + 1 || vm.hfront_porch < 1 ||
+	    vm.hback_porch > dc->desc->max_hpw + 1 || vm.hback_porch < 1 ||
+	    vm.hactive < 1)
 		return MODE_H_ILLEGAL;
 
-	if (vfront_porch > dc->desc->max_vpw + 1 || vfront_porch < 1 ||
-	    vback_porch > dc->desc->max_vpw || vback_porch < 0 ||
-	    mode->vdisplay < 1)
+	if (vm.vfront_porch > dc->desc->max_vpw + 1 || vm.vfront_porch < 1 ||
+	    vm.vback_porch > dc->desc->max_vpw || vm.vback_porch < 0 ||
+	    vm.vactive < 1)
 		return MODE_V_ILLEGAL;
 
 	return MODE_OK;
-- 
2.7.4
