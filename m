Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC65C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6142084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sh2LY1Wi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389166AbfAKPFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:05:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39575 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730940AbfAKPFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:05:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so6877075pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 07:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fve/F1/lKXEnfpzre5B+d6239UbIM50sDNUC8vj1UvQ=;
        b=sh2LY1WiZPIeUaF3MW5DJg/QEYmtg7MuKqRcV+ohKVqeLOX2kAj87/ncMa6egebbYo
         k294jPvUpvY8tWh/TVJyCnvyC/T/VHszUoQByu4+B0bLPUEBcCPJg3A6iuRrk0nL/SCc
         lpg3ZBT6tI1It72Jxe2UE98iYfsC88cR1xfpH7vrMx9OJMw9tL2Vr1vv2W8XZ4Xktn9H
         NZtgrvTlD3Ik9YbSkPstnCWGQNPhb3+vQLQJ5oV3oYtnxdhNYQ0n2lHyDmzWabMOBagm
         +fOV5sL4jmozsC4arWO7kSdaVEIRpgV9bHvSvYqaiApnZh3+zyi/XPtspSlyoMBygeU3
         sZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fve/F1/lKXEnfpzre5B+d6239UbIM50sDNUC8vj1UvQ=;
        b=o90pOzefIBz3B1B/6oUtM3PgOtPhEVGVneY+/iLSMHXJP5J+JNIM8cqId+ep128ZOB
         sSinuRnLMH+Lz0+r3b80yClN3V08C5q7ZrxlLvt1SsYX2+m88+1gnxlb+kBIOsB8QZyw
         qDna4/9mf3sBjVLOF/0cAHozJI4e/MLfWXOoTPrkZhg2FE2Ex09D5/ac8YcqjOZs1WAy
         enjmj5PjWt72eE9EGFBfXnnY1dbmtGj0DKbCyRxdAfgWU8L/9WsbrsEMeJUk6j9gvMLJ
         OiE6zceTFijFwKuEKxQt4rSTrFKoa2vwEwqyBzX3b5VQ49C/46NvwbxtaD1eHtrpgj/D
         Bdzg==
X-Gm-Message-State: AJcUukdlNmB9esHKA6p5B3ORXvZHZiWgKdPUnvAk398NsKJ0IpJ7Mdgf
        qlLABz21takkzNzuBSFa3Fk=
X-Google-Smtp-Source: ALg8bN5Rc2l8bWM7uxkHK8LK4e398s3Iy/tXK9itkSm2yPC22Yk8baS7VKxthK4Bra16e8DuO0AC9w==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr14463670pla.47.1547219137463;
        Fri, 11 Jan 2019 07:05:37 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.52.190])
        by smtp.gmail.com with ESMTPSA id h15sm98053997pgl.43.2019.01.11.07.05.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 07:05:36 -0800 (PST)
Date:   Fri, 11 Jan 2019 20:39:33 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: [PATCH 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20190111150933.GA2760@jordon-HP-15-Notebook-PC>
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

