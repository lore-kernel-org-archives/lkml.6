Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C882C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3D322419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPUlk2x5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3D322419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbeKPBxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:53:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43878 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPBxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:53:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id n10-v6so9174445pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 07:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aM1C42m8xdOqFETa7vpI1nSS13dxTXWD/5chbQoQBa8=;
        b=WPUlk2x5CRHbvpM1bKX0kitApnk9BOX9wd6CvD1uXCrRKIH6tLEay2hxykg+jfsOB5
         J3wKWSBsuJ6udvfS4G6bvMcO6ox+2kzBEBlokR74eBZjoMw6d8x1PN71smAmcbb6mBup
         OdgkIHjtmqbhHbuOLy/q3SSyLzA2k+Xpsv24H8M3CFunfT0Vso70i7cPyZZzP0niaf+O
         JGIryGQnwC1aAak8kAS+Qx8SqdiY8zDRVlIBvvktT+IuNNm53fGMh6V+fHDKJ1kl3EAv
         aNkn5Ps0QTpVVhzhG4tLFaxNej9aYPChR96QL/bg7V+spivBI26bw5QPRPmo5pwul8kV
         BkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aM1C42m8xdOqFETa7vpI1nSS13dxTXWD/5chbQoQBa8=;
        b=PiaU5NPM1gbAaKwaPr5QbGoQ28od4hi0Wjwgs7ARBb/j9QVBOBjYPpc3zn+sWnNggp
         iB53i2WkWecFPkNUyLDvkcZKwmYiO0pwQqL0ZI8ai6rb0KS9e114c6Z/PYhn+2pwM4cy
         RWSpTg1PA5TU2kZhUyV92ccYcoaZkGHYe8xCZFlRVM4OtMWWGxFiwXcxX2Oci6ElHsqh
         HTTysG1ByBBt0kJxUl7zwlRYEJZNAdp6x3w+Q+Lq0Z1TBEHPiOYkMmoExu+xKSxy73VT
         3AvbF8quihv4DPrH/69Xp8R0aDDOMyQR/yOhjhtOTZAi9xsJDuX/VK7/ZhDRJvxCQNAU
         OawA==
X-Gm-Message-State: AGRZ1gJepdw9AjEGD04gu/DxKyL/+8jOnjQkiUe49xOxKxH11hzo2PvB
        J4m1cNcP5LyuHbfTiOoiVrI=
X-Google-Smtp-Source: AJdET5e7n4pF+rhd6dDpXXTPWo1Rru/vt9norA53b2YS+zYvPSJKdhFnnXdL8xxj4jhF0QHgnmIpvw==
X-Received: by 2002:a62:6241:: with SMTP id w62-v6mr6901975pfb.69.1542296690923;
        Thu, 15 Nov 2018 07:44:50 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.97.233])
        by smtp.gmail.com with ESMTPSA id z127-v6sm32794856pfz.135.2018.11.15.07.44.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 07:44:49 -0800 (PST)
Date:   Thu, 15 Nov 2018 21:18:26 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: [PATCH 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181115154826.GA27948@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index a8db758..2cb83bb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -221,26 +221,10 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
 					      struct vm_area_struct *vma)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
-	unsigned int i, count = obj->size >> PAGE_SHIFT;
 	unsigned long user_count = vma_pages(vma);
-	unsigned long uaddr = vma->vm_start;
-	unsigned long offset = vma->vm_pgoff;
-	unsigned long end = user_count + offset;
-	int ret;
-
-	if (user_count == 0)
-		return -ENXIO;
-	if (end > count)
-		return -ENXIO;
 
-	for (i = offset; i < end; i++) {
-		ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
-		if (ret)
-			return ret;
-		uaddr += PAGE_SIZE;
-	}
-
-	return 0;
+	return vm_insert_range(vma, vma->vm_start, rk_obj->pages,
+				user_count);
 }
 
 static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
-- 
1.9.1

