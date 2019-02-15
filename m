Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8EDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E1921A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZBET/v+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbfBOClK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:41:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33047 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfBOClF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:41:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id y10so4197036plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 18:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+cqpEOgVsQX6FuKbkjkqnPdK6JJEhfhSEvMIkCtIVgk=;
        b=PZBET/v+AvTm5uI6YhLQd/yhp9OJU4BXs5QA0Gv2/WEpddBD1QACIx3W+qj/R+DwpM
         B3BzpTqjks4wX/579seQjUOZNkBasPTeBbzS7Ts4S8uR/gAobhLKvuuBjPvnZ0p2M1+e
         UH/Gc2iPGBMYC4EV/ODk3qG1i7BTa624G4IbAyHgpQom75nwKU1TVfguAY8NM1SpQhag
         t/bnF90mVuhLmHwSRidYkQGL4uxY7KCT7jqdywdvHspXzYeX6exXlLeF+WVbzBFla7Za
         xrpAZoUBgGaI0ABuhCyNn+4AoykbvyaUO80m2jJbnwhHLhgC8kP1xoZ96ASplt0w6m2V
         UyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+cqpEOgVsQX6FuKbkjkqnPdK6JJEhfhSEvMIkCtIVgk=;
        b=bNZteLrYahCi8kVY6HCDbZSUr0YmqDe0fdFj2cLOPXBbMJOD2F0B2WOltnCBZDuZmo
         776zJXbKG6vaub4OrmGoN+8rmINbSaqoxalsQhHe7QIIMw+TtyQb/E3lf1FxmttWYS9h
         XhIa9OUXzkOiE3AxVjH8ZANUfDek2SZ9sMyvanTOBndBuknfwAC9O3eXANErgOiCLOxV
         A1MT0Tlft4h76F0gKFrl/jRg2cmMDA82pYKR94NHWQFWCXwpVuHal6Ki/3SgMYmML4db
         KjVN/d9gHI61uK/nTEC+ZJuJgYz/8cCcpkBy2N7lE4MjBqwBGz499k4YwsDJNxw9gIft
         mkMQ==
X-Gm-Message-State: AHQUAubutU8wDKIi9uTBdrP59d2PCx6tlqhB7ZwAxBKEexB0H4KylXA3
        p/SfYeJKVCmM4RDYZmXKE4I=
X-Google-Smtp-Source: AHgI3IZkR4bUjIEoJN1Iweg1I643mATKe+Qg6hd5B30hfMqsOz0sR+gJKonzI4eh8rnzPur2hIb3aQ==
X-Received: by 2002:a17:902:d83:: with SMTP id 3mr7519491plv.43.1550198464676;
        Thu, 14 Feb 2019 18:41:04 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.53.51])
        by smtp.gmail.com with ESMTPSA id g87sm9521109pfe.43.2019.02.14.18.41.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 18:41:03 -0800 (PST)
Date:   Fri, 15 Feb 2019 08:15:24 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_map_pages()
Message-ID: <20190215024524.GA26405@jordon-HP-15-Notebook-PC>
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

