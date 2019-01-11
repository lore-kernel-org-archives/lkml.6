Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB64C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FB221841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2l48CPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388808AbfAKPIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:08:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36491 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbfAKPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:08:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so6890812plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 07:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vHKS//TZxZR6+MbFM/21TvVXK2jPLls5Bm50Y+Ae0UU=;
        b=X2l48CPqdu0frS3K3KzOnOT/wmG6wGo1EqRuCPkedTt5YZOuAUEF2j2JuISSDFg3BB
         +gMBjsDEfs74tgp6sGQktkRbEEwE+4OyUL6m09SMLZ2Zf9fRo4W30YKLfxtg9i3gJ/4n
         0z3gaZBnL/DSYiChTec94Kid/dscMX348zoSRjHa9Nb8IzbXGOI5xAu7AgeVwQtDmuFu
         +AzXD0pz0dIQ5HI5CvA6LVWiieatC5fGrZpEVRmxPXGuzKWRstkm8100YxCMdK8oLi/8
         ZtCpQyDhPmYLbeg2MtfFrhJdINQfZmpKjB1GpWLFd3riQDyB7RKNxa3mBG8iqylyBI9v
         ciEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vHKS//TZxZR6+MbFM/21TvVXK2jPLls5Bm50Y+Ae0UU=;
        b=P3FQcrfhW0qOaT+LoxZA8FpehVmjjsdhqrRTlOt2KB/YmGoeHuWH5ko/gwJXj1m8JI
         QRhDVpZB9hikgyt9TOKfPlAAnLBqfRHboK1ano/5+supJSbCQ+ZevfjBxvDfXOCkjST7
         y4wU3vrmm/9cm3C+D7CKiEWt1GW4iK2l/kt/32rRpudrSfo9FR1cYAlcKavvB+dlsT5u
         xuRxL1F+pn/ZGvuATahapscTRV43n0Xltb95lU08scOSycRZ3OycMlz1Xo5W9HQHEIZn
         2mM6N2LyfobbdD7iyhko7I0abu4wVm/pegO7Wj44l9H6pO4wBcLCpMbeBcqGfttYWCAF
         FkMg==
X-Gm-Message-State: AJcUukdJI8Ibmnno+nMBNIOWfHtBNPh8wpNLOjviRmyTpQThNltaSB7G
        xqqqZKZAqATTcNlJoC+0UG4=
X-Google-Smtp-Source: ALg8bN5aDkgg5ldDKHA6yfV1TZQA+qcq0ZDkBcWhCzbgmdJ8IDlZXXhK+dZ6M/q0tbISuC4LhMUrgg==
X-Received: by 2002:a17:902:2c83:: with SMTP id n3mr15194441plb.104.1547219314683;
        Fri, 11 Jan 2019 07:08:34 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.52.190])
        by smtp.gmail.com with ESMTPSA id l22sm132710551pfj.179.2019.01.11.07.08.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 07:08:33 -0800 (PST)
Date:   Fri, 11 Jan 2019 20:42:35 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 8/9] xen/gntdev.c: Convert to use vm_insert_range
Message-ID: <20190111151235.GA2836@jordon-HP-15-Notebook-PC>
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
 drivers/xen/gntdev.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index b0b02a5..ca4acee 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -1082,18 +1082,17 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 {
 	struct gntdev_priv *priv = flip->private_data;
 	int index = vma->vm_pgoff;
-	int count = vma_pages(vma);
 	struct gntdev_grant_map *map;
-	int i, err = -EINVAL;
+	int err = -EINVAL;
 
 	if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
 	pr_debug("map %d+%d at %lx (pgoff %lx)\n",
-			index, count, vma->vm_start, vma->vm_pgoff);
+			index, vma_pages(vma), vma->vm_start, vma->vm_pgoff);
 
 	mutex_lock(&priv->lock);
-	map = gntdev_find_map_index(priv, index, count);
+	map = gntdev_find_map_index(priv, index, vma_pages(vma));
 	if (!map)
 		goto unlock_out;
 	if (use_ptemod && map->vma)
@@ -1145,12 +1144,9 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 		goto out_put_map;
 
 	if (!use_ptemod) {
-		for (i = 0; i < count; i++) {
-			err = vm_insert_page(vma, vma->vm_start + i*PAGE_SIZE,
-				map->pages[i]);
-			if (err)
-				goto out_put_map;
-		}
+		err = vm_insert_range(vma, map->pages, map->count);
+		if (err)
+			goto out_put_map;
 	} else {
 #ifdef CONFIG_X86
 		/*
-- 
1.9.1

