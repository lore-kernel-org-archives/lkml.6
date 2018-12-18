Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCF0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E0E218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151413;
	bh=sM1mv4hX+6+iZR3Uo6X6o24Mo2/jsIZ+lBMnESUtmEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=todNZcHXkPzJn76G8o23qWm8srC36FE5ZOMot9X5u1qqScv4gQ0ZAbryhyaw0PfN2
	 XmkkxVboWX/FYofIABDKDuzJoBFzQUCrFYSUw8w/HYg4fWOmZlOaDlMtEyLz/v7TIs
	 JtKzFrus3EYBXJ8XE4C/hMzPgDWBUs1jnznfecxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeLRQnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:43:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:38886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbeLRQlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A135E218A2;
        Tue, 18 Dec 2018 16:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151284;
        bh=sM1mv4hX+6+iZR3Uo6X6o24Mo2/jsIZ+lBMnESUtmEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcSyvflQVLG0LBaXglasgGrDr00YRIeR8Z0+z0cawJer9sbn37WhF/kMhPOTzv3WW
         cfVlpzseNlbEgwzKo4T+951qKIWIJh7BG+D4uW5GDndVPbtJWuou/Vl2UkutxdbH4v
         ozHl5nQFmrIePTfWECC8mEVkigYkzW88GdRw3dts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 4.19 36/44] drm/i915/gvt: Fix tiled memory decoding bug on BDW
Date:   Tue, 18 Dec 2018 17:39:48 +0100
Message-Id: <20181218163931.674655690@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tina Zhang <tina.zhang@intel.com>

commit a40fa231bb64b33e2cd54cf8ef44a9f89875fa11 upstream.

Commit b244ffa15c8b ("drm/i915/gvt: Fix drm_format_mod value for vGPU
plane") introduced a regression issue to the tiled memory decoding on BDW.

This patch can fix this issue.

Here is the issue detail: https://github.com/intel/gvt-linux/issues/61

v1->v2:
- Refine the commit message. (Zhenyu)

Fixes: b244ffa15c8b("drm/i915/gvt: Fix drm_format_mod value for vGPU plane")
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Cc: stable@vger.kernel.org # v4.19+
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gvt/fb_decoder.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/gvt/fb_decoder.c
+++ b/drivers/gpu/drm/i915/gvt/fb_decoder.c
@@ -235,7 +235,7 @@ int intel_vgpu_decode_primary_plane(stru
 		plane->bpp = skl_pixel_formats[fmt].bpp;
 		plane->drm_format = skl_pixel_formats[fmt].drm_format;
 	} else {
-		plane->tiled = !!(val & DISPPLANE_TILED);
+		plane->tiled = val & DISPPLANE_TILED;
 		fmt = bdw_format_to_drm(val & DISPPLANE_PIXFORMAT_MASK);
 		plane->bpp = bdw_pixel_formats[fmt].bpp;
 		plane->drm_format = bdw_pixel_formats[fmt].drm_format;


