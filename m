Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeECLIm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:08:42 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:13563 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeECLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:08:37 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180503110835epoutp010b50a55a9ac3f7ad50be491d8a55be13~rHdjFvqzO2386323863epoutp01S
X-AuditID: b6c32a4a-a79ff700000010d4-8d-5aeaedb30af8
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH 11/13] drm/kms/mode/tegra: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
Date: Thu,  3 May 2018 16:38:16 +0530
Message-Id: <dc9f279708a7b9a363e2705d01ab3347e5336735.1525087679.git.satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUwTYRD16263hbiyqaifmCjZaAwmlG5tYSFFMaKpSggqalIldYXPlkhb
        7Lao/MADPCjWK2iwooHiEYmiIh7lENMm3iLeqBHxIGLFi6PRaNSWxfjvzZs382YmI8VkW4go
        aa7ZhqxmLo8mwvGLvpipsec/+XWKygck62y7KWIfDX4hWP+9Xowtcblx9mFjJcGWDrgI1rf/
        KMGevrcVZ380HsFTwrQe10uJ9lKgS6x9VXZdpHUWfya0uxpqgba/fmIGoUMaI+JykDUambMt
        OblmQzK9YLF+tl4dr2BimUQ2gY42cyaUTKemZcTOzc0LTkVHF3B59iCVwfE8HTdDY7XYbSja
        aOFtyfRyhlHKGUWCXKlUylXqrCSlOihZiYw9t/1Y/reI9e5zHtEmUEM6QJgUUir4p/QK7gDh
        UhnVBOC+u9cwIegDsLu1QyQEgWCmaQA4gHSoxNc1XeBbADxWv3O4fBDA6oE+cagvERS9r6wQ
        hxKRVAeA5YfuD7XCqDIAnS0lWEg1miqCNU/rQAjj1BTY/qWCCGGSWgHbrhwnhAknwmdtpVjI
        OoxKgs0DqwS6mYDtrbkCToUn7nTiAh4N/dcbJAKOgv2fW4iQL6SKAeyqq5YIwU4Ad5ReG1bN
        hCXlV/GQAUbFwDONcQKdDA8H7g81xahR0PnznUhYn4Q7tskEyWR4sseH/fP6VeUQC1gLj/o2
        D8tnwT3bpggHcgLoKG7H94BJrv9mVQDUgvEonzcZEK/OV5rROjnPmXi72SDPtpjqwdD/TZt/
        GRxvS/MCSgrokeTVux90MjFXwG8weQGUYnQkWV7m18nIHG5DIbJa9FZ7HuK9QB28614saky2
        JfjNZpueUSUqVPHxCYxCkaiix5HPbnbqZJSBs6E1COUj6786kTQsahMYOWfwwFty/8Kzi1s1
        t/mGxynobVZiem/3xiV/6ta/mec56dawerR78OCtDsX2G+QTSU1f4aWx6c8zv+qMP12ZBQnh
        fNmpyIai198XrT2yfFIH1ull7Mea0yV12YFlrOGC43em52MTv/R8pxJqnkyg5scUukekPKxw
        vlhdu/RiBE3jvJFjpmFWnvsLl9lNpZUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSvO6mt6+iDBZsZ7boPXeSyeLK1/ds
        Fq/Ov2G2aJm1iMXi8q45bBadX2axWRyeuoTNYu35VhaLn7vmsThweuycdZfdY/u3B6we97uP
        M3n0Nr9j8+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6MF6dfMRd85K9YtHEnUwPjYt4uRg4O
        CQETicMPjLsYuTiEBHYzSjxb/Juxi5ETKC4lsezNNjYIW1hi5b/n7BBFnxklVvT9ZAFJsAE1
        P58zgxUkISJwh1Hi0sqTLCAOs0Avo8SL/fvZQaqEBWokdt1aygpiswioSlx4PwNsLK9AjMS5
        fcugVshJ3DzXyQxyEqeAlcSeL0kgYSEBS4n2vsOsExj5FjAyrGKUTC0ozk3PLTYsMMpLLdcr
        TswtLs1L10vOz93ECA5KLa0djCdOxB9iFOBgVOLhPXD2ZZQQa2JZcWXuIUYJDmYlEd4p3a+i
        hHhTEiurUovy44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgskycXBKNTD2bHmY5Nhf
        FJeptq0sfNPeH6syrsvcTH5/QOP1yrivU+Imam+dKG404UnCVd2WuUUX2L2y+q/yaO7wmfNi
        T8qi/f42TPVbn1nvOWMhIcC1funneimjF6n3lr8ojd/5Kkh9+fKpe1zMHhid2Gg1ubbw4NzZ
        Vcy9nJNq+SuV5FJ29d++cu37ucAOJZbijERDLeai4kQAR3DqwEYCAAA=
X-CMS-MailID: 20180503110834epcas5p25cf074e5fe2292c8053dfa9ebe9f8dc7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503110834epcas5p25cf074e5fe2292c8053dfa9ebe9f8dc7
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503110834epcas5p25cf074e5fe2292c8053dfa9ebe9f8dc7
X-RootMTR: 20180503110834epcas5p25cf074e5fe2292c8053dfa9ebe9f8dc7
References: <cover.1525087679.git.satendra.t@samsung.com>
        <CGME20180503110834epcas5p25cf074e5fe2292c8053dfa9ebe9f8dc7@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicate logic for the same

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/tegra/dc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 9f83a65..f1d6f65 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -25,6 +25,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <video/videomode.h>
 
 static void tegra_dc_stats_reset(struct tegra_dc_stats *stats)
 {
@@ -1436,6 +1437,7 @@ static int tegra_dc_set_timings(struct tegra_dc *dc,
 	unsigned int h_ref_to_sync = 1;
 	unsigned int v_ref_to_sync = 1;
 	unsigned long value;
+	struct videomode vm;
 
 	if (!dc->soc->has_nvdisplay) {
 		tegra_dc_writel(dc, 0x0, DC_DISP_DISP_TIMING_OPTIONS);
@@ -1443,20 +1445,17 @@ static int tegra_dc_set_timings(struct tegra_dc *dc,
 		value = (v_ref_to_sync << 16) | h_ref_to_sync;
 		tegra_dc_writel(dc, value, DC_DISP_REF_TO_SYNC);
 	}
-
-	value = ((mode->vsync_end - mode->vsync_start) << 16) |
-		((mode->hsync_end - mode->hsync_start) <<  0);
+	drm_display_mode_to_videomode(mode, &vm);
+	value = (vm.vsync_len << 16) | vm.hsync_len;
 	tegra_dc_writel(dc, value, DC_DISP_SYNC_WIDTH);
 
-	value = ((mode->vtotal - mode->vsync_end) << 16) |
-		((mode->htotal - mode->hsync_end) <<  0);
+	value = (vm.vback_porch << 16) | vm.hback_porch;
 	tegra_dc_writel(dc, value, DC_DISP_BACK_PORCH);
 
-	value = ((mode->vsync_start - mode->vdisplay) << 16) |
-		((mode->hsync_start - mode->hdisplay) <<  0);
+	value = (vm.vfront_porch << 16) | vm.hfront_porch;
 	tegra_dc_writel(dc, value, DC_DISP_FRONT_PORCH);
 
-	value = (mode->vdisplay << 16) | mode->hdisplay;
+	value = (vm.vactive << 16) | vm.hactive;
 	tegra_dc_writel(dc, value, DC_DISP_ACTIVE);
 
 	return 0;
-- 
2.7.4
