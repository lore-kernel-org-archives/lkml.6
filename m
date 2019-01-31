Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60081C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F93218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJa1+zh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfAaDG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:06:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42092 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaDG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:06:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so793493pfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 19:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fve/F1/lKXEnfpzre5B+d6239UbIM50sDNUC8vj1UvQ=;
        b=VJa1+zh8xHi3tI1io1YyR1jW4Ql0L2HM/0G/TqGLCYIRuEUfaDMSQLwWgfnv/q2VCK
         iMQgvcHSc2/MMEr41Z3VcXIJpBynXvCLMm+MCb5Ony0kLh1P+43S1EyOZ0c2VVcXfUDi
         zyUHlPc92S25kuxJL0xxi6q5K7621sWC7v7ZPljG/f/9EmAD7+iDx7aFSG3OZ8ScP0cF
         VzOGvcgsG44tSmhzqBnqDDYP/OTdVImNeD06R22jMcUhnzLmqtpjiveuyfIVjBd7x9Me
         M4s/fGqqA5tbzFW8w6RcVcyXN17XcXe3Wf1t1LgEPIqHODKKlYApfWHRPjE12iaJHekM
         stRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fve/F1/lKXEnfpzre5B+d6239UbIM50sDNUC8vj1UvQ=;
        b=D2Z4J1NHG9smLYn5ymmM+hhmBzhbf2BvBI4wk92ph44mcF195/dqggTjtFkkLbFe1+
         9PTCMvNwkUqF8fLeCoj7iydaQM3Ws9S2j0e6/pYHdy8IIPvmdolZI0D6lcPE5I7X0liC
         rfAP0Gu77q15AlXxq9mKZcYBgb6v6iEKU4eNrHcGYeWs1FbVrHsqhEQytVIgrskprLxP
         2TdgPQjS4Tvn7cwAsaoz71OUllNW5hcmlskFzj0vMUzaslEQAbBNzolij57jeihbWq1o
         gOUbGESdVBRvs1hvIYLc3RzasL3Fe/XMC+SnbaRNxsBUeXidCJotN4dhsg+brYUZFS/q
         7gZg==
X-Gm-Message-State: AJcUukdmOvM+f2nhPcayqY5tEHTbXhzRTQLB6OaMuiQrm04fMnw7Fyvo
        zCCWGP9fHTWI3vAFi4Tyx54=
X-Google-Smtp-Source: ALg8bN6rRzXK6nfBRBSHhIlA85333gGdTjbHnrt6wuJpi13BssALmTS8VMglE5ur30io8jYwjS7LDQ==
X-Received: by 2002:a62:1f9d:: with SMTP id l29mr33146546pfj.14.1548903987795;
        Wed, 30 Jan 2019 19:06:27 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.20.103])
        by smtp.gmail.com with ESMTPSA id v2sm4236663pgs.0.2019.01.30.19.06.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 19:06:27 -0800 (PST)
Date:   Thu, 31 Jan 2019 08:40:40 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: [PATCHv2 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20190131031040.GA2320@jordon-HP-15-Notebook-PC>
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
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index a8db758..c9e207f 100644
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
+	return vm_insert_range(vma, rk_obj->pages, count);
 }
 
 static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
-- 
1.9.1

