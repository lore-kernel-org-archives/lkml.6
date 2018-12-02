Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCCEC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDD720881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy2BvgZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDD720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbeLBGTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:19:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42946 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLBGTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:19:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so13045plp.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 22:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ng6k7XN2+E7qu+YJG+ewVaHjUak4Dnv0s5kVr6uQuLI=;
        b=Uy2BvgZZkqOXNK7hWBYo3ARMJUfASECRH1vDxiNUgHBWwBso/Dw5MVQ3h240LKOn9r
         NhpjK25eGn1477k5XxEo8EOyY+Y9o+E/DUJKbzrcAxAiamgY14sFBQ5e4pPJJZIPgx0x
         NzFau/vgdlUWyYjWlRMcagejTL6DGAwAmAsSxpCb68yXr9XBuwp/SaCrwZvvzqcGm0L3
         4PgcxWbXzJwKYve3R9DhlAzPDVVBxKO/xslBA5HeS47vJGvTrlgakEwa4L493x3uvLwo
         PdxNdGZOUlyPHJ+JMUkdbANMZcGvWiGUFFuBO0DsdK/adiQyQW7EAu9QSeBXHtYH1PiP
         vFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ng6k7XN2+E7qu+YJG+ewVaHjUak4Dnv0s5kVr6uQuLI=;
        b=ug4erC5koMOytZLCipCzswbWzhFFn4bWS6OdHX77ldtmFKkS/HimP75PE2XnKpdHf1
         0DPXM9wCykiP8WpBjAszz3sW3GbsZ2fvq82IzkNImIyAT40YoLdoU2Wur5Go8Jk/R1SN
         Hn86DOA2eK6rKIad1wgh5HO7fuTCtRPP8HZKjX6p9Gra8GLjSRsCksqne6gD3QGUCvr5
         pFG9Qp8pOkEhiTdMfTZZvawsSQG8dDHmwnit7O2s9dXzOFuhGiqLY5SHTmP5v7CDEfwV
         +pBet/AiMv0M0ELYe/E12qPxQwxDajmMwczFowdwibriYHXenSWVbPJWhpTZp4EIOyRf
         IZfA==
X-Gm-Message-State: AA+aEWbXJfhh8aTcyP0hQdg9+mXftGNsd9LDfjg5D8LF17Fr/mk2J8JK
        J81XrgNgc3dSLs+bCyQPzuQ=
X-Google-Smtp-Source: AFSGD/WRNjFD6zB7/hjn8Xn+aoz1dyOHhd/PEH2NIgt7PDmUyJF+fZfXXjivwgpQAMMMOqZJ+B9xkw==
X-Received: by 2002:a17:902:e085:: with SMTP id cb5mr11348736plb.24.1543731551018;
        Sat, 01 Dec 2018 22:19:11 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
        by smtp.gmail.com with ESMTPSA id n73sm14870007pfj.148.2018.12.01.22.19.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Dec 2018 22:19:10 -0800 (PST)
Date:   Sun, 2 Dec 2018 11:52:55 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v2 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181202062255.GA3159@jordon-HP-15-Notebook-PC>
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

