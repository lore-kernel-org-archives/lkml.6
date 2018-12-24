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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551B9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222BC21850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRR1LFZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbeLXNX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 08:23:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44301 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbeLXNX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 08:23:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so5796787pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 05:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=w2N1lFnP7lwgyibZCv3zxC5CB8Y6AOTQeCb4v428osI=;
        b=TRR1LFZv4DfYv/CLFab1H5gXj9FSE49ggM9pEjq+0mbLtB24XCJVWTEVNxu0Jr9jfP
         aXbKP2W1rQImrZhnsPScKg7NvHRhWsdijVauyLC8/q8oJt9aXNkvOTG+GaQHcE5pxbm6
         /59fC4l6pTS+IZajcvb/jzZViGymmogxlrCI16XH1zhfCvxeCGty+kKPo3aHKl8+RdZo
         MI2IYw/aF6aDHfPUint+1oUR14/QseDL4JSYv2rWDOEAubkmzlmurj4Ur7Z3MVCx04V/
         XZkEMqDeY8uT1l/YnM82QqZIRuKbwbzLb81ZIRdTXIFOWwGOvoUNEOBI/XET/IrHk1B6
         9I5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=w2N1lFnP7lwgyibZCv3zxC5CB8Y6AOTQeCb4v428osI=;
        b=gAcmpKcWOtqHN73RTog+N2x0pfYiyqRJ+rFA++REuHO1QzKfd+b48xb59TGL3hAJZG
         Fl+6stItTt7aBXVD3LPi4rDw7+OdZt0PvWFb5l/QSpgWeABs0qQLf29hOUuXv22nmh9C
         4kW6Del6485Gx4qYtwJdAAsIZz2HD2d9y5ZMVkJ9+3cFrS4m+gqwkbepn9uPrOw7vJWn
         GVQ62XO1JOoGNljYAtE7VYfDifay+7OKF73m+KaNsfwCerVfl7ZYZH9BZmy2EllUa1wP
         d8taNc3LPFUyMesyAYriE6HqXtV5iemdaM5CXcDtelNGBMsQQg7kmtpGUlXq37hJ6iO3
         zOog==
X-Gm-Message-State: AA+aEWb9Mc9iHB1mcKv4MrrnCY1byyV85Ytl4YBgoGknfVm/64TmP8Gt
        gT9Wz2u6NEe1e8UD4vha1oY=
X-Google-Smtp-Source: AFSGD/XNCF/AELM92N+4p9/KZr4mLV4IU7b+ZllrdzFyHIFG9XuHFhwnCGsyXsvCDA2cnfQI83lO8g==
X-Received: by 2002:a62:11c7:: with SMTP id 68mr13037815pfr.21.1545657836303;
        Mon, 24 Dec 2018 05:23:56 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.181])
        by smtp.gmail.com with ESMTPSA id b26sm71332999pfe.91.2018.12.24.05.23.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 05:23:55 -0800 (PST)
Date:   Mon, 24 Dec 2018 18:57:52 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v5 8/9] xen/gntdev.c: Convert to use vm_insert_range
Message-ID: <20181224132751.GA22184@jordon-HP-15-Notebook-PC>
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
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/gntdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index b0b02a5..430d4cb 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -1084,7 +1084,7 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 	int index = vma->vm_pgoff;
 	int count = vma_pages(vma);
 	struct gntdev_grant_map *map;
-	int i, err = -EINVAL;
+	int err = -EINVAL;
 
 	if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
@@ -1145,12 +1145,9 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 		goto out_put_map;
 
 	if (!use_ptemod) {
-		for (i = 0; i < count; i++) {
-			err = vm_insert_page(vma, vma->vm_start + i*PAGE_SIZE,
-				map->pages[i]);
-			if (err)
-				goto out_put_map;
-		}
+		err = vm_insert_range(vma, vma->vm_start, map->pages, count);
+		if (err)
+			goto out_put_map;
 	} else {
 #ifdef CONFIG_X86
 		/*
-- 
1.9.1

