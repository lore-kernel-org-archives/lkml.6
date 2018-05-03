Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeECIkB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:40:01 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:30879 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeECIj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:39:58 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180503083957epoutp0369c3aa567438d59076eab67e08e7a753~rFbxOMqTB2544225442epoutp037
X-AuditID: b6c32a49-56bff700000010df-c4-5aeacadcfa0e
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH 03/13] drm/kms/mode/exynos-dsi: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
Date: Thu,  3 May 2018 14:09:38 +0530
Message-Id: <e21d94cdd60e8c83140c5a917c255baf88f0e90a.1525087679.git.satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmpu6dU6+iDLZMl7foPXeSyeLK1/ds
        Fq/Ov2G2mHR/AovFi3sXWSz6H79mtjh/fgO7xdmmN+wWmx5fY7W4vGsOm8WM8/uYLA5PXcJm
        sfZ8K4vFjMkv2Rz4PDat6mTz2P7tAavH/e7jTB6bl9R79G1ZxejxeZNcAFtUqk1GamJKapFC
        al5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0LVKCmWJOaVAoYDE4mIl
        fTubovzSklSFjPziElulaENDIz1DA3M9IyMjPRPTWCsjU6CShNSMC5fjC7ZxVnxv38bcwNjP
        0cXIySEhYCJx9d4yxi5GLg4hgd2MEgdbtjFDOJ8YJdY82csK4XxjlNjxcD0jTMvBlh1MEIm9
        jBId19rZQBJCAl8ZJd5ddgex2YCKns+ZwQpiiwjMZJa49VsbpIFZoJtRondvC9gOYYFmRonW
        OztYQKpYBFQltt1cxgxi8wrESKyde4YJYp2cxM1znUBxDg5OASuJPV+SQHolBG6zSfQvecAC
        UeMicbb5ISuELSzx6vgWdghbSuJlfxs7RAPQsgfrFkI5PUB3dx6DqrKXaJlygAVkA7OApsT6
        XfoQYVuJfRcPgC1gFuCT6P39hAmkREKAV6KjTQiiREVi5YvDzDC7/izoYoUo8ZDY9JkTIuwo
        cXr9ZxZIaPUySty985BlAqP8LIRlCxgZVzFKphYU56anFpsWGOallusVJ+YWl+al6yXn525i
        BKdLLc8djLPO+RxiFOBgVOLhPXD2ZZQQa2JZcWXuIUYJDmYlEd4p3a+ihHhTEiurUovy44tK
        c1KLDzGaAgN2IrOUaHI+MJXnlcQbmlgamJiZmRsaGFiaKInz3jx5L0pIID2xJDU7NbUgtQim
        j4mDU6qB0WDXhSsSzBbrl8tufcKo+bVu4ZXWZ8In5v/NVbmVu975x5+pVivEJkptnMC/d9ri
        jhcX7haJWS74pf/eTHldsdDNojn3DX5+X6l2n8WrmW2ZWvXHjpq9DMLRn8K59u/f18X22tzu
        z+fjXazbvt7OXyQpvq3XPn9zVGzmEtZzXzdapzRpzrtix6HEUpyRaKjFXFScCACPDNKErQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvO7tU6+iDHZPsbboPXeSyeLK1/ds
        Fq/Ov2G2mHR/AovFi3sXWSz6H79mtjh/fgO7xdmmN+wWmx5fY7W4vGsOm8WM8/uYLA5PXcJm
        sfZ8K4vFjMkv2Rz4PDat6mTz2P7tAavH/e7jTB6bl9R79G1ZxejxeZNcAFsUl01Kak5mWWqR
        vl0CV8aFy/EF2zgrvrdvY25g7OfoYuTkkBAwkTjYsoOpi5GLQ0hgN6PE0v5GVoiElMSyN9vY
        IGxhiZX/nrNDFH1mlFh5dxUTSIINqPv5nBlgDSICi5kl7tyNACliFuhllHixfz9Yh7BAI6PE
        6ws/wKpYBFQltt1cxgxi8wrESKyde4YJYoWcxM1znUBxDg5OASuJPV+SQMJCApYS7X2HWScw
        8i1gZFjFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcxFqaOxgvL4k/xCjAwajEw5tx
        +mWUEGtiWXFl7iFGCQ5mJRHeKd2vooR4UxIrq1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5Y
        kpqdmlqQWgSTZeLglAIG2Jw7hz2aDhqZbrTqMezikfmqpHV68dH8zU/Tt3mFOTGxrVy+R1Vb
        LtZR73rWzB//k8WMbDl3q06c6m4SnLC17779sz0pe45vuCwWtvDSF/uPBWs3v787+/r+Zjn7
        a6saPvAuuvnnTNWdzMiIxSULHk660mqZJFJzqXWHdshaXX6lv19E3dN+KbEUZyQaajEXFScC
        APubtlpeAgAA
X-CMS-MailID: 20180503083956epcas5p1eb97f7bd534e58e7154f5f11733e7aa0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503083956epcas5p1eb97f7bd534e58e7154f5f11733e7aa0
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503083956epcas5p1eb97f7bd534e58e7154f5f11733e7aa0
X-RootMTR: 20180503083956epcas5p1eb97f7bd534e58e7154f5f11733e7aa0
References: <cover.1525087679.git.satendra.t@samsung.com>
        <CGME20180503083956epcas5p1eb97f7bd534e58e7154f5f11733e7aa0@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicate logic for the same

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 7904ffa..9397e5c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1493,14 +1493,7 @@ static void exynos_dsi_mode_set(struct drm_encoder *encoder,
 	struct videomode *vm = &dsi->vm;
 	struct drm_display_mode *m = adjusted_mode;
 
-	vm->hactive = m->hdisplay;
-	vm->vactive = m->vdisplay;
-	vm->vfront_porch = m->vsync_start - m->vdisplay;
-	vm->vback_porch = m->vtotal - m->vsync_end;
-	vm->vsync_len = m->vsync_end - m->vsync_start;
-	vm->hfront_porch = m->hsync_start - m->hdisplay;
-	vm->hback_porch = m->htotal - m->hsync_end;
-	vm->hsync_len = m->hsync_end - m->hsync_start;
+	drm_display_mode_to_videomode(m, vm);
 }
 
 static const struct drm_encoder_helper_funcs exynos_dsi_encoder_helper_funcs = {
-- 
2.7.4
