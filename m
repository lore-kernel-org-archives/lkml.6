Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7A1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BC52173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YlHoknk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BC52173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeHCNqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:46:15 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:63266 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeHCNqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:46:15 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180803115014epoutp032351193df98da215d66baf4df30282f2~HXYLXYIGT0691706917epoutp03R
        for <linux-kernel@vger.kernel.org>; Fri,  3 Aug 2018 11:50:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180803115014epoutp032351193df98da215d66baf4df30282f2~HXYLXYIGT0691706917epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533297014;
        bh=a061vEp8woOABgHxDiQDuLaMYMmJxZ4qN7eLzGqvcW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YlHoknk0rhbuD4Vc7CHPJzFFaahTHdzSTS5NaPBqqY2LSfOsOSq3MfDAzQlMW9e6o
         EGPqswNH0/QsWyOHaj6TLuCdTCY1CAgZOp5ePKgHzg0U/Fdjae76xix/zYnugzaE1m
         x/K7hj8Drr0vlDVWZOSr+VfaJJ74dlK7WXbQJeoc=
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.196]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20180803115014epcas5p4a4147215470848b1c01a7088661a6b25~HXYKz6MgW1255012550epcas5p4r;
        Fri,  3 Aug 2018 11:50:14 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.5C.04309.571446B5; Fri,  3 Aug 2018 20:50:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20180803115013epcas5p2abd0af8d1ada31e66d5c6ae38ec1a9a8~HXYKay9FL3208432084epcas5p2v;
        Fri,  3 Aug 2018 11:50:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180803115013epsmtrp116089ccee2fd90307b60fa9adb079173~HXYKZbLMM0646606466epsmtrp1g;
        Fri,  3 Aug 2018 11:50:13 +0000 (GMT)
X-AuditID: b6c32a4a-9b3ff700000010d5-50-5b6441756d01
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.4F.03759.571446B5; Fri,  3 Aug 2018 20:50:13 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.161.94]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180803115011epsmtip26624a97bded54e6c12f7c4ca89d4e6d1~HXYIpugrs1566315663epsmtip2D;
        Fri,  3 Aug 2018 11:50:11 +0000 (GMT)
From:   Satendra Singh Thakur <satendra.t@samsung.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com, sst2005@gmail.com,
        Satendra Singh Thakur <satendra.t@samsung.com>
Subject: [PATCH v1] drm/kms/atomic: Improved the func
 drm_atomic_set_crtc_for_connector
Date:   Fri,  3 Aug 2018 17:18:37 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <4fd92ffb-2518-1e9a-881e-5f4b0e4d4922@linux.intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmlm6pY0q0QfcUa4vecyeZLK58fc9m
        sfPBLnaLV+ffMFtc3jWHzWLhx60sFmvPt7JY3N1wltFi+enrzBbHtl5id+DymN1wkcVj56y7
        7B7bvz1g9Zh3MtDjfvdxJo+dk/YyefRtWcXo8XmTXABHVKpNRmpiSmqRQmpecn5KZl66rZJ3
        cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCNSgpliTmlQKGAxOJiJX07m6L80pJUhYz8
        4hJbpWhDQyM9QwNzPSMjIG0aa2VkClSSkJqx+N1CpoI/XBUrJl9namDs4+xi5OSQEDCROLyh
        l6WLkYtDSGA3o8TNPf1MEM4nRomlF89DOd8YJRa/2s4E0zLx/hlWiMReRonl/XOYIZwvjBI3
        9l8Cq2IDqno+ZwZYlYjAS6DBLSAtnBzMAqUSD242MYPYwgKREoc7j7CA2CwCqhK3p3QzQ6yQ
        k7h5rhPM5hRwlvizbD3YBgmBE2wSnS+Ws4MkeAXKJO48/AzV4CJxcdsvqPuEJV4d38IOYUtJ
        vOxvg7InM0o0n/WDGLSaUeLsxV6ohL1Ey5QDQFdwAF2nKbF+lz7EoXwSvb+fMIGEJQR4JTra
        hCCqVSRWvjjMDDP+z4IuVgjbQ2L/gZvQkJjGKPH11lHWCYyysxCmLmBkXMUomVpQnJueWmxa
        YJSXWq5XnJhbXJqXrpecn7uJEZzutLx2MC4753OIUYCDUYmH94JqcrQQa2JZcWXuIUYJDmYl
        Ed63nUAh3pTEyqrUovz4otKc1OJDjKbAEJzILCWanA9MxXkl8YamRmZmBpYGpsYWZoZK4rwf
        /IKjhQTSE0tSs1NTC1KLYPqYODilGhgn5B6Wuq270+QAv4Dce6+niWxJE0/bHGbi2fh5m0bx
        YgfZ5gu9L1ee+1E6W1roefAd/s4c7pY7RxbkuvBnzrA5M/eKlqv/1B09Z6NnM65eNSXO1yzx
        SdMqJ7F46xiZUxND3wkyZviLHLnKZXDZnnOfRGqHdKI1Z9cZbpanYeUMuhmFda+V9ZVYijMS
        DbWYi4oTAfdR22mNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSvG6pY0q0wfWjyha9504yWVz5+p7N
        YueDXewWr86/Yba4vGsOm8XCj1tZLNaeb2WxuLvhLKPF8tPXmS2Obb3E7sDlMbvhIovHzll3
        2T22f3vA6jHvZKDH/e7jTB47J+1l8ujbsorR4/MmuQCOKC6blNSczLLUIn27BK6Mxe8WMhX8
        4apYMfk6UwNjH2cXIyeHhICJxMT7Z1i7GLk4hAR2M0ocXHiFHSIhJbHszTY2CFtYYuW/5+wQ
        RZ8YJdqebGQESbABdT+fMwOsW0TgLaNE687TLCAJZoFKiXPPJwMVcXAIC4RLnG6PBQmzCKhK
        3J7SzQxi8wq4SXzdtxNqmZzEzXOdYHFOAWeJP8vWg9lCAk4SfefusE5g5FvAyLCKUTK1oDg3
        PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4YLU0dzBeXhJ/iFGAg1GJh/eCanK0EGtiWXFl7iFG
        CQ5mJRHet51AId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqemFqQWwWSZODil
        Ghjzd5+4suPCl5bk+fe8jRaZz2pkOCC7RU9d289QgTV97jlDxSWG7x5sne/GseG2yJLH01Sf
        KxnGqdb8Cb+3Weg6byrD41MXr0/PkBZT+pjFEb9o15yqrUdmcUXt11W81SsY1FX3/869rxp3
        dy6xPj0j8oL12qJmLVH7Q43sGr3Pm9u63ReWdAQpsRRnJBpqMRcVJwIAD+h+jlQCAAA=
Message-Id: <20180803115013epcas5p2abd0af8d1ada31e66d5c6ae38ec1a9a8~HXYKay9FL3208432084epcas5p2v@epcas5p2.samsung.com>
X-CMS-MailID: 20180803115013epcas5p2abd0af8d1ada31e66d5c6ae38ec1a9a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180803115013epcas5p2abd0af8d1ada31e66d5c6ae38ec1a9a8
References: <4fd92ffb-2518-1e9a-881e-5f4b0e4d4922@linux.intel.com>
        <CGME20180803115013epcas5p2abd0af8d1ada31e66d5c6ae38ec1a9a8@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Currently conn_state->crtc is getting assigned a value at two places
   We can just reduce this assignment to one

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
---
 v1: Hi Mr Maarten, Thanks for the comments.
 I have modified the patch suitably. Please review.
 
 drivers/gpu/drm/drm_atomic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 895741e..560b01c 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1559,7 +1559,6 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
 			~(1 << drm_connector_index(conn_state->connector));
 
 		drm_connector_put(conn_state->connector);
-		conn_state->crtc = NULL;
 	}
 
 	if (crtc) {
@@ -1571,7 +1570,6 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
 			1 << drm_connector_index(conn_state->connector);
 
 		drm_connector_get(conn_state->connector);
-		conn_state->crtc = crtc;
 
 		DRM_DEBUG_ATOMIC("Link connector state %p to [CRTC:%d:%s]\n",
 				 conn_state, crtc->base.id, crtc->name);
@@ -1579,6 +1577,7 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
 		DRM_DEBUG_ATOMIC("Link connector state %p to [NOCRTC]\n",
 				 conn_state);
 	}
+	conn_state->crtc = crtc;
 
 	return 0;
 }
-- 
2.7.4

