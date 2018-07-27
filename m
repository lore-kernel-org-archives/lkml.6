Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA80DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BAD20891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A6y0Qn4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BAD20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbeG0J7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:59:05 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:55293 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbeG0J7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:59:05 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180727083813epoutp04534675079aa284f264e2ff4570b5cdff~FLPh2Dtdd1084610846epoutp04L
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 08:38:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180727083813epoutp04534675079aa284f264e2ff4570b5cdff~FLPh2Dtdd1084610846epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532680693;
        bh=Q/Sz8QNq88iTG0a0b4FJ+xj37iMVNS+RaUoQPEle6ac=;
        h=From:To:Cc:Subject:Date:References:From;
        b=A6y0Qn4nd7ddUrVJ2ozcZuqZWAdzjlwBFJF9TFvD1lzGSJTNE/HQte7/k6tAtdttK
         /HnV/WXY5k5rekpZpVqLqPS5rP2hvzJbMwX0cmT5wpNVhbhkZakI/zTy2CQ4CPscdc
         00xNDjZfVqxRus2hqZzT7ihTCnYKoB2AEZNgg7Ks=
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.192]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20180727083813epcas5p1c523add2d4d70016b5391bc9f63005e3~FLPhPnRCH1188211882epcas5p1N;
        Fri, 27 Jul 2018 08:38:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.CB.04309.5F9DA5B5; Fri, 27 Jul 2018 17:38:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20180727083812epcas5p39f97180e85def2b4b4c1b68af2e83b41~FLPg9mkWQ2043620436epcas5p3U;
        Fri, 27 Jul 2018 08:38:12 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180727083812epsmtrp22f22b8706f3c992129921f88445ee0e0~FLPg8JbhL1071810718epsmtrp21;
        Fri, 27 Jul 2018 08:38:12 +0000 (GMT)
X-AuditID: b6c32a4a-9b3ff700000010d5-28-5b5ad9f51c80
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.D0.03889.4F9DA5B5; Fri, 27 Jul 2018 17:38:12 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.161.94]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180727083810epsmtip1414b65ec559ddb90b401eb7c44c372ae~FLPfHOETO0146801468epsmtip1D;
        Fri, 27 Jul 2018 08:38:10 +0000 (GMT)
From:   Satendra Singh Thakur <satendra.t@samsung.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com, sst2005@gmail.com,
        Satendra Singh Thakur <satendra.t@samsung.com>
Subject: [PATCH] drm/kms/atomic: Used existing func for checking fb geometry
Date:   Fri, 27 Jul 2018 14:08:02 +0530
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmlu7Xm1HRBgt+cVj0njvJZHHl63s2
        i50PdrFbvDr/htni8q45bBYLP25lsVh7vpXF4u6Gs4wWy09fZ7Y4tvUSuwOXx+yGiyweO2fd
        ZffY/u0Bq8e8k4Ee97uPM3nsnLSXyaNvyypGj8+b5AI4olJtMlITU1KLFFLzkvNTMvPSbZW8
        g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BuVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKkUbGhrpGRqY6xkZAWnTWCsjU6CShNSMf50L2QvWSFZMfLycvYHxqEgXIyeHhICJRPOR
        9+xdjFwcQgK7GSX+Te9lgnA+MUo8PviACaRKSOAbo8S6SeUwHd9uL2GEKNrLKPH55Bk2COcL
        o8Skd7PYQKrYgKqez5nBCpIQEXjJKHGz5QwrSIJZoFTiwc0mZhBbWMBH4sLGZ2BxFgFVifuX
        G5ggVshJ3DzXyQzSLCGwgU3i7YYWFpAEr0CZRNOzi2wQRS4Sy76uYISwhSVeHd/CDmFLSXx+
        txeqZjKjRPNZP4hBqxklzl7shSqyl2iZcgBoKAfQRZoS63fpQxzHJ9H7+wkTSFhCgFeio00I
        olpFYuWLw8ww4/8s6GKFsD0kFi/7wAIJoliJyWuPME1glJmFMHQBI+MqRsnUguLc9NRi0wKj
        vNRyveLE3OLSvHS95PzcTYzglKbltYNx2TmfQ4wCHIxKPLwBryOjhVgTy4orcw8xSnAwK4nw
        rrkOFOJNSaysSi3Kjy8qzUktPsRoCgy0icxSosn5wHSbVxJvaGpkZmZgaWBqbGFmqCTO+8Ev
        OFpIID2xJDU7NbUgtQimj4mDU6qB8YB266u5+w//dVeJM3hjd2rKeT0hw+rOFXqZuXvzmbRK
        37wu+6xQYvbr3E2XCXaOJ+MncjpLKv1s//H05kVHpQlX4+NWL16as7L7iMAsn6yjyvVd3gJX
        /x7Zde3NNGP7y1vk3ZymGby/vmxztnR6vfW7k1G1N3UOZOtMceg8eGZJ07pL/mlMZ5RYijMS
        DbWYi4oTAezk5WN/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSnO6Xm1HRBquP6Vn0njvJZHHl63s2
        i50PdrFbvDr/htni8q45bBYLP25lsVh7vpXF4u6Gs4wWy09fZ7Y4tvUSuwOXx+yGiyweO2fd
        ZffY/u0Bq8e8k4Ee97uPM3nsnLSXyaNvyypGj8+b5AI4orhsUlJzMstSi/TtErgy/nUuZC9Y
        I1kx8fFy9gbGoyJdjJwcEgImEt9uL2HsYuTiEBLYzShxfMIjNoiElMSyN9ugbGGJlf+es0MU
        fWKUWLdiEyNIgg2o+/mcGawgCRGBt4wSrTtPs4AkmAUqJc49nwxWJCzgI3Fh4zNWEJtFQFXi
        /uUGJhCbV8BN4vrnm4wQG+Qkbp7rZJ7AyLOAkWEVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpe
        cn7uJkZwCGpp7WA8cSL+EKMAB6MSD2/A68hoIdbEsuLK3EOMEhzMSiK8a64DhXhTEiurUovy
        44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgskycXBKNTC2youzdJ9Rvtty59mxy1WG
        zLu79H6umfV0dt0qn93BPh8WyB7Sbv+sNqvxv5nWA9V76m7rzpx8uWy+a7/mxDCDlLKrtuJb
        Si96zldhOfnKxO9hLJv3jwSplbF1IrzznI1f1ng+PcfWvuvfl8Vvd/xjEwgMj9jgcS75zSHX
        yL6yZK/uhX9+Wa1QYinOSDTUYi4qTgQAL9Ikgz0CAAA=
Message-Id: <20180727083812epcas5p39f97180e85def2b4b4c1b68af2e83b41~FLPg9mkWQ2043620436epcas5p3U@epcas5p3.samsung.com>
X-CMS-MailID: 20180727083812epcas5p39f97180e85def2b4b4c1b68af2e83b41
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180727083812epcas5p39f97180e85def2b4b4c1b68af2e83b41
References: <CGME20180727083812epcas5p39f97180e85def2b4b4c1b68af2e83b41@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.In the func drm_atomic_plane_check, the fb geometry checking code
can be replaced by func drm_framebuffer_check_src_coords, this will
remove several redundant lines of code.
2. Currently, in the func drm_atomic_plane_check;
there are 3 if statements in the beginning with total 5 conditions.
these conditions are
crtc is NULL but fb is non-NULL
if (state->crtc && !state->fb)
crtc is non-NULL but fb is NULL
if (state->fb && !state->crtc)
crtc is NULL (and fb is also NULL)
if (!state->crtc)

The same code can be re-written using 2 if statements and 4 conditions.
first we check whether crtc and fb both are NULL
if (!state->crtc && !state->fb)
then we check either crtc or fb is NULL
if (!state->crtc || !state->fb)

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
---
 drivers/gpu/drm/drm_atomic.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 895741e..1cddab8 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -909,22 +909,16 @@ plane_switching_crtc(struct drm_atomic_state *state,
 static int drm_atomic_plane_check(struct drm_plane *plane,
 		struct drm_plane_state *state)
 {
-	unsigned int fb_width, fb_height;
 	int ret;
 
-	/* either *both* CRTC and FB must be set, or neither */
-	if (state->crtc && !state->fb) {
-		DRM_DEBUG_ATOMIC("CRTC set but no FB\n");
-		return -EINVAL;
-	} else if (state->fb && !state->crtc) {
-		DRM_DEBUG_ATOMIC("FB set but no CRTC\n");
-		return -EINVAL;
-	}
-
 	/* if disabled, we don't care about the rest of the state: */
-	if (!state->crtc)
+	if (!state->crtc && !state->fb)
 		return 0;
-
+	/* both CRTC and FB must be set*/
+	if (!state->crtc || !state->fb) {
+		DRM_DEBUG_ATOMIC("Either no CRTC or no FB\n");
+		return -EINVAL;
+	}
 	/* Check whether this plane is usable on this CRTC */
 	if (!(plane->possible_crtcs & drm_crtc_mask(state->crtc))) {
 		DRM_DEBUG_ATOMIC("Invalid crtc for plane\n");
@@ -954,24 +948,11 @@ static int drm_atomic_plane_check(struct drm_plane *plane,
 		return -ERANGE;
 	}
 
-	fb_width = state->fb->width << 16;
-	fb_height = state->fb->height << 16;
-
 	/* Make sure source coordinates are inside the fb. */
-	if (state->src_w > fb_width ||
-	    state->src_x > fb_width - state->src_w ||
-	    state->src_h > fb_height ||
-	    state->src_y > fb_height - state->src_h) {
-		DRM_DEBUG_ATOMIC("Invalid source coordinates "
-				 "%u.%06ux%u.%06u+%u.%06u+%u.%06u (fb %ux%u)\n",
-				 state->src_w >> 16, ((state->src_w & 0xffff) * 15625) >> 10,
-				 state->src_h >> 16, ((state->src_h & 0xffff) * 15625) >> 10,
-				 state->src_x >> 16, ((state->src_x & 0xffff) * 15625) >> 10,
-				 state->src_y >> 16, ((state->src_y & 0xffff) * 15625) >> 10,
-				 state->fb->width, state->fb->height);
+	ret = drm_framebuffer_check_src_coords(state->src_x, state->src_y,
+		state->src_w, state->src_h, state->fb);
+	if (ret)
 		return -ENOSPC;
-	}
-
 	if (plane_switching_crtc(state->state, plane, state)) {
 		DRM_DEBUG_ATOMIC("[PLANE:%d:%s] switching CRTC directly\n",
 				 plane->base.id, plane->name);
-- 
2.7.4

