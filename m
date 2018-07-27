Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E74CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90395208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rGDpRnoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90395208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbeG0M1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:27:04 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:62992 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbeG0M1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:27:03 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180727110535epoutp042b085ef2dff6e1b89960ca60e2531d87~FNQL8Fk7i1059510595epoutp04y
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:05:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180727110535epoutp042b085ef2dff6e1b89960ca60e2531d87~FNQL8Fk7i1059510595epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532689535;
        bh=d/EAgjLT2REwOl8ErjS23C6chCj3zDOMSscwmt3Q0fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rGDpRnoZw1QTjTTZHlMGHo5tmeXBpVc+jxwzwbz7Re9mwYpbW780b6j3oXQRxJcIe
         NkGL82dWw3qdfdENnVgslHOqyVbbmV6Wn9T96a5LwSaskh867BEF9vRTqkeA4wKwcu
         WthIUf/UargnR8HmggvqMY6bheYDYhCuXpPxLKZU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.196]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20180727110534epcas5p2e63583907a88db513b362bf24e78b3d9~FNQLRiv5l1284912849epcas5p2b;
        Fri, 27 Jul 2018 11:05:34 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.28.04303.E7CFA5B5; Fri, 27 Jul 2018 20:05:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20180727110534epcas5p1b5d48f9f92b7d6874bbe15c2f80dce1c~FNQK6sJPs2704827048epcas5p1Q;
        Fri, 27 Jul 2018 11:05:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180727110534epsmtrp25b8ec7ee9eb58daf1a5d6106d8bdcb6f~FNQK5O5n52255822558epsmtrp2R;
        Fri, 27 Jul 2018 11:05:34 +0000 (GMT)
X-AuditID: b6c32a49-94fff700000010cf-1b-5b5afc7e96ef
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.25.03759.D7CFA5B5; Fri, 27 Jul 2018 20:05:33 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.161.94]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180727110531epsmtip26e5aec1b766038d3e95bd4c5aeafbca8~FNQI-Z8kQ0875008750epsmtip2e;
        Fri, 27 Jul 2018 11:05:31 +0000 (GMT)
From:   Satendra Singh Thakur <satendra.t@samsung.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com, sst2005@gmail.com,
        Satendra Singh Thakur <satendra.t@samsung.com>
Subject: [PATCH v1] drm/kms/atomic: Improving func drm_atomic_plane_check
Date:   Fri, 27 Jul 2018 16:34:05 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <0fe3bbc5-d10b-7c95-e77d-f4cd5ee6016b@linux.intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmum7dn6hog69vhS16z51ksrjy9T2b
        xc4Hu9gtXp1/w2xxedccNouFH7eyWKw938picXfDWUaL5aevM1sc23qJ3YHLY3bDRRaPnbPu
        snts//aA1WPeyUCP+93HmTx2TtrL5NG3ZRWjx+dNcgEcUak2GamJKalFCql5yfkpmXnptkre
        wfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUA3KimUJeaUAoUCEouLlfTtbIryS0tSFTLy
        i0tslaINDY30DA3M9YyMgLRprJWRKVBJQmrG7MX9TAUP+Sq6755jamD8wN3FyMkhIWAi8fLX
        evYuRi4OIYHdjBLHn/ZCOZ8YJZavecwG4XxjlPi3YgJTFyMHWMuu5d4Q8b2MEn+/LGGFcL4w
        Sux8uZkVZC4bUNHzOTPAEiICLxklbracAUswC5RKPLjZxAxiCwt4SlxbOpsNxGYRUJU4ueM1
        E8RRchI3z3WC1XAKOEu8XbGNBSJ+hk2i+VM0iM0rUCax5/ctNoi4i8TODw8YIWxhiVfHt7BD
        2FISn9/thaqZzCjRfNYP5CAJgdWMEmcv9kIV2Uu0TDnAAvIas4CmxPpd+hB38kn0/n4C9TGv
        REebEES1isTKF4eZYcb/WdDFCmF7SCxsuwINiGmMEht6X7BPYJSdhTB1ASPjKkbJ1ILi3PTU
        YtMCw7zUcr3ixNzi0rx0veT83E2M4FSn5bmDcdY5n0OMAhyMSjy8Aa8jo4VYE8uKK3MPMUpw
        MCuJ8K65DhTiTUmsrEotyo8vKs1JLT7EaAoMwInMUqLJ+cA0nFcSb2hqZGZmYGlgamxhZqgk
        zvvBLzhaSCA9sSQ1OzW1ILUIpo+Jg1OqgdFG6WROzEcd/lXJp7LDrK5KcPwOSGNY4Cni+dXz
        XFZE2gJjfqE9rQd1p7Eeql/8/flrE4t3wWfXnvJiPjlBau6p1XfyFslp8l99PmftwSq+a0/s
        pqT/8Zvae+1P4s6E5zekTOfkBHkfNUxa/sRB9s6MEJcX7lO0Zl7Ou7WPnXXt8RbukNq5yRVK
        LMUZiYZazEXFiQBRofuBiwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSvG7tn6hogzvfzCx6z51ksrjy9T2b
        xc4Hu9gtXp1/w2xxedccNouFH7eyWKw938picXfDWUaL5aevM1sc23qJ3YHLY3bDRRaPnbPu
        snts//aA1WPeyUCP+93HmTx2TtrL5NG3ZRWjx+dNcgEcUVw2Kak5mWWpRfp2CVwZsxf3MxU8
        5KvovnuOqYHxA3cXIweHhICJxK7l3l2MXBxCArsZJY49vM/YxcgJFJeSWPZmGxuELSyx8t9z
        doiiT4wSU97uZwdJsAE1P58zgxUkISLwllGidedpFpAEs0ClxLnnk8EmCQt4SlxbOhtsEouA
        qsTJHa+ZQGxeAVeJledmQ22Qk7h5rpMZxOYUcJZ4u2Ib2BwhASeJ+ZOamScw8i1gZFjFKJla
        UJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcsFqaOxgvL4k/xCjAwajEwxvwOjJaiDWxrLgy
        9xCjBAezkgjvmutAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqemFqQWwWSZ
        ODilGhh5vhnvyI9dcubHIn+hrin7VlQXTru94vGXp2pLZm6IWrD93MfJSVd8WJ8cnzwtpEql
        6dCWlcYWmT5eP/p3XmPIyb5ftXt535vuxoeeQsmnf3g80K3I2ZDm3Hrur5PLBf+FW1s/FLvt
        PyQUbiau8fxHTUGGqJjctNgHK3I+dyfU3LjC2ie8T3GWEktxRqKhFnNRcSIA9zn6XlQCAAA=
Message-Id: <20180727110534epcas5p1b5d48f9f92b7d6874bbe15c2f80dce1c~FNQK6sJPs2704827048epcas5p1Q@epcas5p1.samsung.com>
X-CMS-MailID: 20180727110534epcas5p1b5d48f9f92b7d6874bbe15c2f80dce1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180727110534epcas5p1b5d48f9f92b7d6874bbe15c2f80dce1c
References: <0fe3bbc5-d10b-7c95-e77d-f4cd5ee6016b@linux.intel.com>
        <CGME20180727110534epcas5p1b5d48f9f92b7d6874bbe15c2f80dce1c@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in the func drm_atomic_plane_check;
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
 v1: Hi Mr Maarten, Thanks for the comments.
     I have splitted them into two patches.  
 
 drivers/gpu/drm/drm_atomic.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 895741e..0415bbf 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -912,18 +912,15 @@ static int drm_atomic_plane_check(struct drm_plane *plane,
 	unsigned int fb_width, fb_height;
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
+	/* both CRTC and FB must be set*/
+	if (!state->crtc || !state->fb) {
+		DRM_DEBUG_ATOMIC("Either invalid CRTC [%p] or invalid FB [%p]\n",
+		state->crtc, state->fb);
+		return -EINVAL;
+	}
 
 	/* Check whether this plane is usable on this CRTC */
 	if (!(plane->possible_crtcs & drm_crtc_mask(state->crtc))) {
-- 
2.7.4

