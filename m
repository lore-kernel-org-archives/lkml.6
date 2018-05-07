Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeEGDco (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 23:32:44 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:26187 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbeEGDcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 23:32:41 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180507033240epoutp0259854da55206c64b372c4fd2329a67e3~sP0nTTnJL2390723907epoutp02J
X-AuditID: b6c32a4a-a79ff700000010d4-52-5aefc8d7664e
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: robin.murphy@arm.com, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sst2005@gmail.com, madhur.verma@samsung.com,
        Satendra Singh Thakur <satendra.t@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH v2 03/13] drm/kms/mode/exynos-dsi: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
Date: Mon,  7 May 2018 09:02:17 +0530
Message-Id: <1525663938-4172-1-git-send-email-satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <920ac8d1-8d2d-1332-256d-21472f69fca5@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmhu71E++jDHY9VLLoPXeSyeLK1/ds
        Fq/Ov2G2mHR/AovFi3sXWSz6H79mtjh/fgO7xdmmN+wWmx5fY7W4vGsOm8WM8/uYLA5PXcJm
        cfDDE1aLtedbWSyWn77ObDFj8ks2BwGPNfPWMHrsnHWX3WPTqk42j+3fHrB63O8+zuSxeUm9
        R9+WVYwenzfJBXBEpdpkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5
        +AToumXmAH2gpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVijY0NNIzNDDXMzIy0jMxjbUy
        MgUqSUjN6Nl9ga3gE1fFsvULWBoYV3F2MXJySAiYSCxsWcQOYgsJ7GaUuH6TsYuRC8j+xChx
        Y2I3lPONUeLs0TY2mI6upXfZIRJ7GSXe/DnKAuF8ZZRY8n46M0gVG1DV8zkzWEFsEYH1zBJ7
        zxiAFDEL9DNKPO2/wwTiCAu0MUr8Wb4ZrIpFQFXi2aLZTCA2r4CrxLUXC9kh9slJ3DzXCTaV
        U8Ba4sq7xWDrJAS+s0ms3LAMqshF4vq6V1AHCku8Or4FKi4l8bK/jR2ioZlR4sG6hVBOD6NE
        R+cxqCp7iZYpB4DGcgAdqCmxfpc+RNhW4si+2WCbmQX4JHp/P2ECKZEQ4JXoaBOCKFGRWPni
        MDPMrj8LulghbA+JrvuroaY7Stw8e4ANEkZ9jBKzXpxlm8AoPwth2wJGxlWMkqkFxbnpqcWm
        BUZ5qeV6xYm5xaV56XrJ+bmbGMHJVctrB+Oycz6HGAU4GJV4eFdMeR8lxJpYVlyZe4hRgoNZ
        SYSX/yhQiDclsbIqtSg/vqg0J7X4EKMpMGgnMkuJJucDE39eSbyhiaWBiZmZuaGBgaWJkjjv
        zZP3ooQE0hNLUrNTUwtSi2D6mDg4pRoYOc9tbX/htWoul/eswFeKv79WRWhXeAa38S624t/+
        fJlgzPVmQWGho/OnVN+49rVx+yUTaUGu6DWHJF8/qUpbVL2rwOC602puzgyDY1E2eYevXWZR
        /3iabfPHeXFhsuw7LkUfv35bdcP6C9/rt97SdD1+dtlNgbDHrfbHF/5aEjjp11QfreZ7KUos
        xRmJhlrMRcWJAPkESTHEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSnO61E++jDA5/0rToPXeSyeLK1/ds
        Fq/Ov2G2mHR/AovFi3sXWSz6H79mtjh/fgO7xdmmN+wWmx5fY7W4vGsOm8WM8/uYLA5PXcJm
        cfDDE1aLtedbWSyWn77ObDFj8ks2BwGPNfPWMHrsnHWX3WPTqk42j+3fHrB63O8+zuSxeUm9
        R9+WVYwenzfJBXBEcdmkpOZklqUW6dslcGX07L7AVvCJq2LZ+gUsDYyrOLsYOTkkBEwkupbe
        Ze9i5OIQEtjNKHH03kR2iISUxLI329ggbGGJlf+eQxV9ZpQ4veQaWIINqPv5nBmsIAkRgd3M
        Ehu2T2AFSTALTGaUuP0hCCQhLNDCKPG4/woLSIJFQFXi2aLZTCA2r4CrxLUXC6HWyUncPNfJ
        DGJzClhLXHm3GKxeSMBK4tvUfcwTGPkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P
        3cQIDngtzR2Ml5fEH2IU4GBU4uFdMeV9lBBrYllxZe4hRgkOZiURXv6jQCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoYu9yk7Lx/P756cFZc6J6z+alq
        5xLSPOV5BV/wOBq9nrawV3TXGhmtdMZT8bfalppZiBdOVuf+2u9ocLOxa4KyZ9WSJZ0KakWL
        A08FZc/v9l/7TKSmOpYj/K5Q4Exp+cMX/x+O9GWrbV5QJ8Swf8o//swNz2NDvQxbHHOZp3/7
        81Hvz/XGx4eUWIozEg21mIuKEwHP/S/xdAIAAA==
X-CMS-MailID: 20180507033238epcas5p2601b5ccbba8fa02cdde4f1375e90abe9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180507033238epcas5p2601b5ccbba8fa02cdde4f1375e90abe9
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180507033238epcas5p2601b5ccbba8fa02cdde4f1375e90abe9
X-RootMTR: 20180507033238epcas5p2601b5ccbba8fa02cdde4f1375e90abe9
References: <920ac8d1-8d2d-1332-256d-21472f69fca5@arm.com>
        <CGME20180507033238epcas5p2601b5ccbba8fa02cdde4f1375e90abe9@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicate logic for the same

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Acked-by: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---

 v2: Removed Mr Robin from reviewed-by field	

 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 7904ffa..7fe84fd 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1490,17 +1490,8 @@ static void exynos_dsi_mode_set(struct drm_encoder *encoder,
 				struct drm_display_mode *adjusted_mode)
 {
 	struct exynos_dsi *dsi = encoder_to_dsi(encoder);
-	struct videomode *vm = &dsi->vm;
-	struct drm_display_mode *m = adjusted_mode;
-
-	vm->hactive = m->hdisplay;
-	vm->vactive = m->vdisplay;
-	vm->vfront_porch = m->vsync_start - m->vdisplay;
-	vm->vback_porch = m->vtotal - m->vsync_end;
-	vm->vsync_len = m->vsync_end - m->vsync_start;
-	vm->hfront_porch = m->hsync_start - m->hdisplay;
-	vm->hback_porch = m->htotal - m->hsync_end;
-	vm->hsync_len = m->hsync_end - m->hsync_start;
+
+	drm_display_mode_to_videomode(adjusted_mode, &dsi->vm);
 }
 
 static const struct drm_encoder_helper_funcs exynos_dsi_encoder_helper_funcs = {
-- 
2.7.4
