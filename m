Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E18C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A6B20836
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTkvJIhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390331AbfBMOAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:00:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46185 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733126AbfBMOAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:00:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so1165412pfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 06:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+cqpEOgVsQX6FuKbkjkqnPdK6JJEhfhSEvMIkCtIVgk=;
        b=FTkvJIhiZxuB2UN3OVrDxEf8j3emEZw9A9itD1oPd+tVJ0e8g/nDyZISMfbdyXaAP6
         Ku+f1/oU09s8dZXMCE15EC/lZ4jhE9XpyVezCzRAsRLdy/21AR6rTdyIxoZbfsMxmQYr
         o1QFAdcjEMZ4hpVPbwUZfbKD3bP3YaF5W6bCDSkoV9uE7cMXX9QTOFBJsVTZFBub3vD/
         tLP1kpXdfL6PFeEz95+peYCFGB2V3ZREDDgo2MiHR2YRRTInP7Ujlzf+v8xIEwW/acLG
         YYBPMe+meJlZK/PpLg21XpK/Zqy+ohSuq8qV9XGFBs8K15TIr80jXNZJz+mddYFSLU45
         kSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+cqpEOgVsQX6FuKbkjkqnPdK6JJEhfhSEvMIkCtIVgk=;
        b=njo2XawSfQ3PyWy3tuQA/C+E1ouhcfU1egFqvGWkM0HuuhFAwVLsY9HCbSfGEoxIqa
         bI+Vu1ltKIC9BlKAJHzvPeQm28bfuftobP1fzjBtGNFjtvpfD70IFeKDFP/FFX69j55P
         +D9FRHKzxK71qiLkCOahBL0ytQbJmx2cBLYPLqoeLDd8gMQ4gA0eSsjodqGMQO/C6n/V
         3U9SF/fgFWkJIZutk4JO2V3uifYE/IFLtGVdCdaradyUT4ia2LsoaRBQQ08hUHY6e3za
         VMsu1VfFtv4T4CbVg7hNj3qIoDDdMpRFNkZZw9l7wAKA2Yj1r7FBKfS+gZdB9WyaHM+E
         gECw==
X-Gm-Message-State: AHQUAubZ9QekW+H2bT11HO2Z+Gfj/Q99kjnaLfyd+nK9PmzJPBqc7SK4
        PvFFWg5iban+tNC2UhtTgE0=
X-Google-Smtp-Source: AHgI3IYGzYQtaDAzpRnw4j6/fnsbGP2OWM7ItsKgcpabtFzajnCQ7pxNpaBmZJle8XOTxzleQFh85A==
X-Received: by 2002:a63:5442:: with SMTP id e2mr628034pgm.282.1550066419102;
        Wed, 13 Feb 2019 06:00:19 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.48.54])
        by smtp.gmail.com with ESMTPSA id o2sm27521833pfa.149.2019.02.13.06.00.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 06:00:18 -0800 (PST)
Date:   Wed, 13 Feb 2019 19:34:36 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v3 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_map_pages()
Message-ID: <20190213140436.GA22010@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_map_pages() to map range of kernel
memory to user vma.

Tested on Rockchip hardware and display is working,
including talking to Lima via prime.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index a8db758..a2ebb08 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -221,26 +221,13 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
 					      struct vm_area_struct *vma)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
-	unsigned int i, count = obj->size >> PAGE_SHIFT;
+	unsigned int count = obj->size >> PAGE_SHIFT;
 	unsigned long user_count = vma_pages(vma);
-	unsigned long uaddr = vma->vm_start;
-	unsigned long offset = vma->vm_pgoff;
-	unsigned long end = user_count + offset;
-	int ret;
 
 	if (user_count == 0)
 		return -ENXIO;
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
+	return vm_map_pages(vma, rk_obj->pages, count);
 }
 
 static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
-- 
1.9.1

