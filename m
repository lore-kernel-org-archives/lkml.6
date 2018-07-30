Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB30BC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4889D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ASzyShy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4889D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeG3Hjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:39:35 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:48459 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeG3Hjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:39:35 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180730060610epoutp0450583a3e57f332e547cf1578243f7e10~GEGn0wLk02692726927epoutp04j
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 06:06:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180730060610epoutp0450583a3e57f332e547cf1578243f7e10~GEGn0wLk02692726927epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532930770;
        bh=FQQwvZOT1XA5KFYuylI/WqlYAMUMm3Zab4Eq3q4xvwk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ASzyShy4b8f0KTU25Dgy3M4HNWINNO0hYanChGm00xzq+XwkmGQubACeSd4rvMq0D
         7UJyb7SmpaZNX1iQXMRw9kt83aelyQ2Iyfm6CqaGYsfN/ekFO2y+r8E3u5kUSot8t7
         +ccqofmeFK2nl9iJ9JybAbT4boUNKHl8bw3Zdywc=
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.195]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20180730060609epcas5p1b643651d922c033815919775b0a42bbb~GEGmygcV32461924619epcas5p1L;
        Mon, 30 Jul 2018 06:06:09 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.9B.04303.0DAAE5B5; Mon, 30 Jul 2018 15:06:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20180730060607epcas5p18565ae86e1c88e82469554aa3c0e1664~GEGlfPEp_2913429134epcas5p1v;
        Mon, 30 Jul 2018 06:06:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180730060607epsmtrp2eb4a0029dfeb048655e94c3ea0cb1f14~GEGldb5M92122621226epsmtrp2S;
        Mon, 30 Jul 2018 06:06:07 +0000 (GMT)
X-AuditID: b6c32a49-94fff700000010cf-f8-5b5eaad084d7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.1B.03889.FCAAE5B5; Mon, 30 Jul 2018 15:06:07 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.161.94]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180730060605epsmtip154f9b1390b20fc959c2333bf1b25a7fb~GEGjhh34V3252732527epsmtip14;
        Mon, 30 Jul 2018 06:06:05 +0000 (GMT)
From:   Satendra Singh Thakur <satendra.t@samsung.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com,
        nishant.y08@samsung.com, sst2005@gmail.com,
        Satendra Singh Thakur <satendra.t@samsung.com>
Subject: [PATCH] drm/kms/crtc: Saving crtc->primary into a drm_plane pointer
 instead of dereferencing it every time.
Date:   Mon, 30 Jul 2018 11:35:58 +0530
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmpu6FVXHRBid/8Fr0njvJZHHl63s2
        i50PdrFbvDr/htni8q45bBYLP25lseh7d5zNYu35VhaLuxvOMlosP32d2eLY1kvsDtwesxsu
        snjsnHWX3WP7twesHvNOBnrc7z7O5LFz0l4mj74tqxg9Pm+SC+CISrXJSE1MSS1SSM1Lzk/J
        zEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpUSaEsMacUKBSQWFyspG9nU5Rf
        WpKqkJFfXGKrFG1oaKRnaGCuZ2QEpE1jrYxMgUoSUjOOtrxkLVjBX7Hx8gO2BsYtPF2MnBwS
        AiYScxr+sXQxcnEICexmlNg//SQThPOJUeJp12pWkCohgW+MEofuecJ0TGhbxAxRtJdRYsm8
        R2wQzhdGiblPLoB1sAFVPZ8zgxUkISLwklHiZssZMIdZoI9R4mj/Y7AqYYEyiQkzHoDZLAKq
        EtvutTNC7JCTuHmuE2yHhMAONonul1NZQBK8QA2t91rZIYpcJHYsO8UGYQtLvDq+BSouJfH5
        3V6o+GRGieazfhCDVjNKnL3YC1VkL9Ey5QDQUA6gkzQl1u/SBwkzC/BJ9P5+wgQSlhDgleho
        E4KoVpFY+eIwM8z4Pwu6WCFsD4mfe5qYIGEUK9G+4xXzBEaZWQhDFzAyrmKUTC0ozk1PLTYt
        MMxLLdcrTswtLs1L10vOz93ECE5vWp47GGed8znEKMDBqMTDKyARFy3EmlhWXJl7iFGCg1lJ
        hDfpfmy0EG9KYmVValF+fFFpTmrxIUZTYKBNZJYSTc4Hpt68knhDUyMzMwNLA1NjCzNDJXHe
        D37B0UIC6YklqdmpqQWpRTB9TBycUg2M3temzmnPfX/qicEZDoavqRsFJiteklZ4xb4j0bbk
        8OvgJT/espXvjHS/2bbNZMP9TTtDv/+7vPpZKufUiRcm3SlPKPvdcl5sU96y9tvh82Y2dym7
        rQ7TXfHBSPjy/vqTE35lWPLrH133JMuRNd7l22699ZIHE8U2SawqDNKIu+Urq1275kIYrxJL
        cUaioRZzUXEiAKImXIeFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnO75VXHRBrvOG1r0njvJZHHl63s2
        i50PdrFbvDr/htni8q45bBYLP25lseh7d5zNYu35VhaLuxvOMlosP32d2eLY1kvsDtwesxsu
        snjsnHWX3WP7twesHvNOBnrc7z7O5LFz0l4mj74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4Mo4
        2vKStWAFf8XGyw/YGhi38HQxcnJICJhITGhbxNzFyMUhJLCbUWLX6m4WiISUxLI329ggbGGJ
        lf+es0MUfWKUOHXjCVgRG1D38zkzWEESIgJvGSVad55mAXGYBaYwSqxZcZ4JpEpYoESi9+kx
        RhCbRUBVYtu9djCbV8BVovHSCiaIFXISN891Mk9g5FnAyLCKUTK1oDg3PbfYsMAoL7Vcrzgx
        t7g0L10vOT93EyM4HLW0djCeOBF/iFGAg1GJhzdDKi5aiDWxrLgy9xCjBAezkghv0v3YaCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTBycUg2Mmm3TsgrunrHf
        yGHEnLJr6qunZ8+f1szh3iCx1Fe4vlVT1e16ZekMEzZe2967Nbv2cvwq/BMb0P4jhGNT/tW8
        PXqCqevW7XlnOWHloYtMakpJQhsvOMufNKz+PVvlRhqz3k7hXUrJdXHtv//pbHj5/DvnCu60
        dr7lBUfsfpa7Oi/btUa/bekqJZbijERDLeai4kQASovx7EMCAAA=
Message-Id: <20180730060607epcas5p18565ae86e1c88e82469554aa3c0e1664~GEGlfPEp_2913429134epcas5p1v@epcas5p1.samsung.com>
X-CMS-MailID: 20180730060607epcas5p18565ae86e1c88e82469554aa3c0e1664
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180730060607epcas5p18565ae86e1c88e82469554aa3c0e1664
References: <CGME20180730060607epcas5p18565ae86e1c88e82469554aa3c0e1664@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the func __drm_mode_set_config_internal,
objects (fb, old_fb, crtc) of crtc->primary are used at many places.
To access the objects of primary, it is dereferenced from crtc every
time. It's better to save it into drm_plane pointer.
This will make the code look simple.

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
---
 drivers/gpu/drm/drm_crtc.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 98a36e6..9644f5b 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -462,6 +462,7 @@ static int __drm_mode_set_config_internal(struct drm_mode_set *set,
 	struct drm_crtc *crtc = set->crtc;
 	struct drm_framebuffer *fb;
 	struct drm_crtc *tmp;
+	struct drm_plane *plane;
 	int ret;
 
 	/*
@@ -469,23 +470,27 @@ static int __drm_mode_set_config_internal(struct drm_mode_set *set,
 	 * connectors from it), hence we need to refcount the fbs across all
 	 * crtcs. Atomic modeset will have saner semantics ...
 	 */
-	drm_for_each_crtc(tmp, crtc->dev)
-		tmp->primary->old_fb = tmp->primary->fb;
+	drm_for_each_crtc(tmp, crtc->dev) {
+		plane = tmp->primary;
+		plane->old_fb = plane->fb;
+	}
 
 	fb = set->fb;
-
 	ret = crtc->funcs->set_config(set, ctx);
 	if (ret == 0) {
-		crtc->primary->crtc = fb ? crtc : NULL;
-		crtc->primary->fb = fb;
+		plane = crtc->primary;
+		plane->crtc = fb ? crtc : NULL;
+		plane->fb = fb;
 	}
 
 	drm_for_each_crtc(tmp, crtc->dev) {
-		if (tmp->primary->fb)
-			drm_framebuffer_get(tmp->primary->fb);
-		if (tmp->primary->old_fb)
-			drm_framebuffer_put(tmp->primary->old_fb);
-		tmp->primary->old_fb = NULL;
+		plane = tmp->primary;
+		if (plane->fb)
+			drm_framebuffer_get(plane->fb);
+		if (plane->old_fb) {
+			drm_framebuffer_put(plane->old_fb);
+			plane->old_fb = NULL;
+		}
 	}
 
 	return ret;
-- 
2.7.4

