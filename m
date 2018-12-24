Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E84C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9597821850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZlLJOIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbeLXNTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 08:19:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41624 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbeLXNTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 08:19:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so5798425pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 05:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ta45jCjTTw9h608mLSaRumjRsUxHErr+7YYhcRdk80Q=;
        b=bZlLJOImO/1bupplpSBgyvMTMpxNs0KKCyh9eTwdH+0uwPXfvhWmQ2pAF8DBwsk9Rh
         bUzZMgNq5nuyQY4GhD3gBu+bVpcBE11KxlyMH4e4GZcPAfuh33MQNhj1AdFZ3jCDGO80
         pw0nh5Zx//0/hc8/8FFns4JVjWJHJEPmTg/eT1k0ZUpBl00xFnUcKdIg5f+PdxVKKQa5
         FCwYRtJKVzzaeQlNqWS4BSXGJQUhPC21z/MJEvaiy2M9oJNQzcrFQKX4+e8lpIRSzbhj
         CXPgWhP0XbFWNCAtL9bP3cJwnXoT0RpNFDimxMCjz/XJnM+Mzti5wvF9ze4fxY1gPbV3
         yV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ta45jCjTTw9h608mLSaRumjRsUxHErr+7YYhcRdk80Q=;
        b=SnPCG/AleiGGHhnAXqRtQ2/xP+j+uqqEaU2W4L+kkyuOoEa64ugVcii4ApSf95i7A2
         jqBYzO1hMU9XprDNBsvafqPuAMKFSbGJEa90jJ5J22u1/WWqXWbts450sQaRTysa3tMm
         FNsP9MtRQZmWKBHGv+tdeE4IEWdCnkEKyG5PPsFNmy486+Wn2jogQLpSCYrOMz/wrXsD
         9coCRh5cR+aNnvfhDWTYfDHUNncJNirgLNagkT6JQsw7AKKI2jFZt/HscIMscSUoT5H9
         zt/gIpq+xKrImv9m45DApwAogZOl7ytopXr3/6uXDGXsHwwL5Ov8JqyUUDLmrKwY4LVQ
         37CA==
X-Gm-Message-State: AJcUukdWBjOOw0ebCLNkXwwocFDalQPafLmNjfcycnL6m20xLDYLq28X
        rDMHvhehXxCd/WEgw+7X7jg=
X-Google-Smtp-Source: ALg8bN5WlOmqbcy4mwSttJzqAgLDaKxP0MsWaY4oRqlS6nY5gpEXpC5t31E85FE+ygzeYcDzQuE9IQ==
X-Received: by 2002:a63:db48:: with SMTP id x8mr11898908pgi.365.1545657589149;
        Mon, 24 Dec 2018 05:19:49 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.181])
        by smtp.gmail.com with ESMTPSA id s9sm42516339pgl.88.2018.12.24.05.19.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 05:19:48 -0800 (PST)
Date:   Mon, 24 Dec 2018 18:53:40 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v5 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181224132340.GA22112@jordon-HP-15-Notebook-PC>
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
Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index a8db758..28458ae 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -221,26 +221,18 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
 					      struct vm_area_struct *vma)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
-	unsigned int i, count = obj->size >> PAGE_SHIFT;
+	unsigned int count = obj->size >> PAGE_SHIFT;
 	unsigned long user_count = vma_pages(vma);
-	unsigned long uaddr = vma->vm_start;
 	unsigned long offset = vma->vm_pgoff;
 	unsigned long end = user_count + offset;
-	int ret;
 
 	if (user_count == 0)
 		return -ENXIO;
 	if (end > count)
 		return -ENXIO;
 
-	for (i = offset; i < end; i++) {
-		ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
-		if (ret)
-			return ret;
-		uaddr += PAGE_SIZE;
-	}
-
-	return 0;
+	return vm_insert_range(vma, vma->vm_start, rk_obj->pages + offset,
+				user_count);
 }
 
 static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
-- 
1.9.1

