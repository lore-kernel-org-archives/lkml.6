Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeECFuP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 01:50:15 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:26423 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbeECFuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 01:50:11 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180503055009epoutp047ab76fb8738dc00ad0d82fe731fc81d2~rDHg6CbC90999209992epoutp04z
X-AuditID: b6c32a4a-a61ff700000010d4-f4-5aeaa310d96e
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH] drm/atomic: Handling the case when setting old crtc for
 plane
Date: Thu,  3 May 2018 11:19:32 +0530
Message-Id: <1525326572-25854-1-git-send-email-satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmuq7A4ldRBkvP61j0njvJZHHl63s2
        i50PdrFbvDr/htni8q45bBYLP25lsTg8dQmbxdrzrSwWdzecZXTg9JjdcJHFY/u3B6we804G
        etzvPs7ksXPSXiaPvi2rGD0+b5ILYI9KtclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0
        tDBXUshLzE21VXLxCdB1y8wBukxJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYqsUbWhopGdo
        YK5nZGSkZ2Iaa2VkClSSkJoxqfsTU0EvV8X0a49YGhg3cnQxcnJICJhILPy6grWLkYtDSGA3
        o8TK1plQzidGiUWLHkA53xglGg6+Y4Vpuf7xKiNEYi+jxIq5r5ggnK+MEic7G1lAqtiAqp7P
        mQHWLiLwklHiZssZMIdZoJtRondvCzNIlbBAgMSZiUfZQGwWAVWJzju/wXbwCrhJrLk+gRli
        n5zEzXOdzCDNEgIr2CS+rbsNlXCR2HN5BwuELSzx6vgWdghbSuJlfxs7REMzo8SDdQuhnB5G
        iY7OY1BV9hItUw4AdXMA3aQpsX6XPkTYVuLf//1gJcwCfBK9v58wgZRICPBKdLQJQZSoSKx8
        cZgZZtefBV3QgPGQmLR6BxuE7SgxfdYXMFtIIFaibfYktgmMcrMQli1gZFzFKJlaUJybnlps
        WmCUl1quV5yYW1yal66XnJ+7iRGc9LS8djAuO+dziFGAg1GJh/fA2ZdRQqyJZcWVuYcYJTiY
        lUR4p3S/ihLiTUmsrEotyo8vKs1JLT7EaAoMzYnMUqLJ+cCEnFcSb2hiaWBiZmZuaGBgaaIk
        znvz5L0oIYH0xJLU7NTUgtQimD4mDk6pBsatH+KqFin/N2yVkRCv/70x/m7q/Nd1H6dUSsjt
        WX3t/GTLxtRy9s1MGr/s+ZI/eTn0smr8/9o6u5XDqeHvnC/Hnq6OvFD5YO/kRUkBLAKvYmfK
        Bhnlcr//m/7VvmC+3Is/Tw471y86MfPzVekzy4qzOSSi/+8UvpzMrvGZUUNtH4Og5utJE3Yp
        sRRnJBpqMRcVJwIAHqbKfpADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSvK7A4ldRBvf281j0njvJZHHl63s2
        i50PdrFbvDr/htni8q45bBYLP25lsTg8dQmbxdrzrSwWdzecZXTg9JjdcJHFY/u3B6we804G
        etzvPs7ksXPSXiaPvi2rGD0+b5ILYI/isklJzcksSy3St0vgypjU/YmpoJerYvq1RywNjBs5
        uhg5OSQETCSuf7zK2MXIxSEksJtRounpAkaIhJTEsjfb2CBsYYmV/56zg9hCAp8ZJdougdls
        QM3P58xgBWkWEXjLKNG68zQLiMMs0Mso8WL/fqAqDg5hAT+J40uZQRpYBFQlOu/8ZgWxeQXc
        JNZcn8AMsUBO4ua5TuYJjDwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEB5uW
        5g7Gy0viDzEKcDAq8fBmnH4ZJcSaWFZcmXuIUYKDWUmEd0r3qygh3pTEyqrUovz4otKc1OJD
        jNIcLErivE/zjkUKCaQnlqRmp6YWpBbBZJk4OKUaGJlaRfbWX22es2nZI6/9MV0WTjcX8M1N
        t804VNR5yrj6ZMyyAz01j07e3Lui6ZHDK+dKeXb315HW23/MmPBetDpkTjvny8SQa1Kl52/s
        UL31Mfl+hhlb66UjEz6F/5puEn8i++xdr/9BMd9CX/7ZsPUP15aHDUmMAZ6dosdqBK5VRM08
        +jFrPZcSS3FGoqEWc1FxIgBX0yOjMgIAAA==
X-CMS-MailID: 20180503055008epcas5p2e98aff943c031a90a14df1a85e359d6c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503055008epcas5p2e98aff943c031a90a14df1a85e359d6c
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503055008epcas5p2e98aff943c031a90a14df1a85e359d6c
X-RootMTR: 20180503055008epcas5p2e98aff943c031a90a14df1a85e359d6c
References: <CGME20180503055008epcas5p2e98aff943c031a90a14df1a85e359d6c@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the func drm_atomic_set_crtc_for_plane, with the current code,
if crtc of the plane_state and crtc passed as argument to the func
are same, entire func will executed in vein.
It will get state of crtc and clear and set the bits in plane_mask.
All these steps are not required for same old crtc.
Ideally, we should do nothing in this case, this patch handles the same,
and causes the program to return without doing anything in such scenario.

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/drm_atomic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 7d25c42..5bd3365 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1421,7 +1421,9 @@ drm_atomic_set_crtc_for_plane(struct drm_plane_state *plane_state,
 {
 	struct drm_plane *plane = plane_state->plane;
 	struct drm_crtc_state *crtc_state;
-
+	/* Nothing to do for same crtc*/
+	if (plane_state->crtc == crtc)
+		return 0;
 	if (plane_state->crtc) {
 		crtc_state = drm_atomic_get_crtc_state(plane_state->state,
 						       plane_state->crtc);
-- 
2.7.4
