Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEDIQT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:16:19 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:23128 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbeEDIQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:16:16 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180504081614epoutp036da8e0ea17e9f1559b43b4875cd77718~rYwWi0d0F0749007490epoutp03P
X-AuditID: b6c32a4b-19dff70000001094-db-5aec16cda4fd
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: robin.murphy@arm.com, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madhur.verma@samsung.com, sst2005@gmail.com,
        Satendra Singh Thakur <satendra.t@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH v1 03/13] drm/kms/mode/exynos-dsi: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
Date: Fri,  4 May 2018 13:45:26 +0530
Message-Id: <1525421726-2817-1-git-send-email-satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <00b4a624-d2b6-dc6a-71c0-9c7642480a44@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmuu5ZsTdRBqe2WFv0njvJZHHl63s2
        i1fn3zBbTLo/gcXixb2LLBb9j18zW5w/v4Hd4mzTG3aLTY+vsVpc3jWHzWLG+X1MFoenLmGz
        OPjhCavF2vOtLBbLT19ntpgx+SWbg4DHmnlrGD12zrrL7rFpVSebx/ZvD1g97ncfZ/LYvKTe
        o2/LKkaPz5vkAjiiUm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVc
        fAJ03TJzgD5QUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqRRsaGukZGpjrGRkZ6ZmYxloZ
        mQKVJKRmXDslV/CRq+JCk1sD4ybOLkZODgkBE4lzLbvYuhi5OIQEdjNKLF/6mxnC+cQoseXZ
        f1YI5xujxJ8Vq1hhWjY8OQmV2MsoMXfbBiYI5yujxOvPnxlBqtiAqp7PmQHWISKwnlli7xkD
        kCJmgX5GiRevJoO1Cwu0AS05MRGsg0VAVaJ3NYTNK+Aq8eToR3aIfXISN891MoPYnALWEq8m
        vANrlhD4zCYxqX0LE0SRi8S5Nx+ZIWxhiVfHt0A1S0l8freXDaKhmVHiwbqF7BBOD6NER+cx
        qCp7iZYpB1i6GDmADtSUWL9LHyJsK3HwYDPYRcwCfBK9v58wgZRICPBKdLQJQZSoSKx8cZgZ
        ZtefBV3QQPKQ2L1mC1TcUeLahGnQAOtjlPi65Rb7BEb5WQjbFjAyrmKUTC0ozk1PLTYtMM5L
        LdcrTswtLs1L10vOz93ECE6tWt47GDed8znEKMDBqMTDu8P2dZQQa2JZcWXuIUYJDmYlEd5Z
        h4BCvCmJlVWpRfnxRaU5qcWHGE2BQTuRWUo0OR+Y9vNK4g1NLA1MzMzMDQ0MLE2UxHlvnrwX
        JSSQnliSmp2aWpBaBNPHxMEp1cBoLrvbNKyrzHTftcB3QQvnLfQJT+Y+OmHvbIvemoOLuX89
        OqNnJi8ruuTSmwPXpTd+5pvgO+XNzdRmxw8vTX7KVDPu3C0x0Wem6zGW6b6Shz+XJRyU3s3G
        KMZY/L3bY5JF42IVF4//bxssF0ooHGGQNlDnUZBpWtCQ7plkNXUys6XsHavvHNeUWIozEg21
        mIuKEwFhRwiUwwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSvO5ZsTdRBudXCFn0njvJZHHl63s2
        i1fn3zBbTLo/gcXixb2LLBb9j18zW5w/v4Hd4mzTG3aLTY+vsVpc3jWHzWLG+X1MFoenLmGz
        OPjhCavF2vOtLBbLT19ntpgx+SWbg4DHmnlrGD12zrrL7rFpVSebx/ZvD1g97ncfZ/LYvKTe
        o2/LKkaPz5vkAjiiuGxSUnMyy1KL9O0SuDKunZIr+MhVcaHJrYFxE2cXIyeHhICJxIYnJ1lB
        bCGB3YwSXTMiIeJSEsvebGODsIUlVv57zt7FyAVU85lR4tTL2YwgCTag5udzZrCCJEQEdjNL
        bNg+AcxhFpjMKNEy8RlYi7BAC6PEjq1P2UFaWARUJXpXTwRr5xVwlXhy9CM7xA45iZvnOplB
        bE4Ba4lXE95B3WQlcfnfROYJjHwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIE
        B7uW5g7Gy0viDzEKcDAq8fAKOLyOEmJNLCuuzD3EKMHBrCTCO+sQUIg3JbGyKrUoP76oNCe1
        +BCjNAeLkjjv07xjkUIC6YklqdmpqQWpRTBZJg5OqQbGNvUfjtGz7cyeSgc8UZLXepgn7TLj
        ymxW1QWv73of/J11artt9fxg/aRt+vJsHPnPxCXuXL6qn744Yo5c3cV9jZMseL+bMoYUiN8u
        i/ysIa8wf/O0+x579LRybreYvLTLMw2QexUvH6fK8qe163jC/cLOD/tWSSiuKzX3Uby/3/Os
        Kfel91eUWIozEg21mIuKEwHalE4LcgIAAA==
X-CMS-MailID: 20180504081613epcas5p405d342fe333975048175c4a360067f52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180504081613epcas5p405d342fe333975048175c4a360067f52
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180504081613epcas5p405d342fe333975048175c4a360067f52
X-RootMTR: 20180504081613epcas5p405d342fe333975048175c4a360067f52
References: <00b4a624-d2b6-dc6a-71c0-9c7642480a44@arm.com>
        <CGME20180504081613epcas5p405d342fe333975048175c4a360067f52@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicate logic for the same

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Acked-by: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
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
