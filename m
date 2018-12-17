Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68068C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BC7206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDTJCfgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389457AbeLQUTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:19:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38833 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbeLQUTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:19:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so6663095plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 12:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vHtNG5YY7oqAEcnnEFXV1qkzWXHTgkZmEB/ZXAxtcsE=;
        b=HDTJCfgnh+j0eG6OnfEpzoBfilcO9b+44SSH+rczBsLIYMzVoHJCuW+pyMCFqzu1V/
         Zy29YyLtOwX2UDdP/SXCBW97juLvRF2DVYMvTzi4i7gL6TPz9Limk1pxhoJF2ZR2gdCa
         7tJqkTGxerJpUQ4Okn3XGjeaWWgwbzll56yffTbkYAxyfBuv/nGBVByby04RrCEOGLBh
         iw4KiWfDMyasNKW7SRmZWh7oGNwhOdjF9l+eHcRuO4ZmQmXbT2DzCdawrCDVnJ6qPfsO
         1gQeUUbdnGeiVu6w6a6Y+0opTR0MRZS8NcET2Nm32kXGicA27G+cCt8iUbI/NAzK56ww
         TNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vHtNG5YY7oqAEcnnEFXV1qkzWXHTgkZmEB/ZXAxtcsE=;
        b=jPlU7FliLzceOkEZ2Rwjb4xiIRS0hBE1fc1RfNgkCtUFAD/AkS8UCg8t3snVJAVmZA
         YJCyVRqlBCfZIUurKEomQQRPM/ZFoOD+w4SK4b3wFSVL6lA9KTYva/JgJWM8WGFx++1E
         c7icSOowPlcbvvewR/FbV+j11gH+pFIoakDPFlXwQH/k+5CU2iMwuAa8QRL3S/AppHEq
         jSuV0nUDj8fkJe7+1M8qK+XPocMtz/mqieIe8o3v0e4iNvhZV9K3lkUKd2Yjpu8GVcDW
         D4GDpVSUBmJP1dL4i2LG+4/Ia4KCk9Hb0uj+4m1xZS5N8o33RAKldCQUC1Y0c/KJ24wC
         ps/A==
X-Gm-Message-State: AA+aEWZzmOQtgLbxNaRiFUb6FQPSxy8BbgBm+IOyqnxM+o7bMIIP+KKI
        p8G4TU38O/xIM5/c15yiXMs=
X-Google-Smtp-Source: AFSGD/VztJFrJiCc5TxrvjdoAMM5foV3+t6D91QTlRMzDwrlUkxArWBo7WpY83vLc2dZ2XXJU04Cxw==
X-Received: by 2002:a17:902:8a8a:: with SMTP id p10mr14060709plo.50.1545077982019;
        Mon, 17 Dec 2018 12:19:42 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.98.208])
        by smtp.gmail.com with ESMTPSA id u87sm31872783pfi.2.2018.12.17.12.19.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 12:19:41 -0800 (PST)
Date:   Tue, 18 Dec 2018 01:53:34 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
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
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index a8db758..8279084 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -221,26 +221,11 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
 					      struct vm_area_struct *vma)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
-	unsigned int i, count = obj->size >> PAGE_SHIFT;
 	unsigned long user_count = vma_pages(vma);
-	unsigned long uaddr = vma->vm_start;
 	unsigned long offset = vma->vm_pgoff;
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
+	return vm_insert_range(vma, vma->vm_start, rk_obj->pages + offset,
+				user_count - offset);
 }
 
 static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
-- 
1.9.1

