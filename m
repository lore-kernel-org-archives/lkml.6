Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE40C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6382184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU6lU6IJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfAaDJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:09:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45820 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaDJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:09:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so787878pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 19:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+gTPMCxXNjJoF0/n+ZWKrD0/ywZQWm6nRUnBrn1+xaM=;
        b=mU6lU6IJNCLpuAcuJxrPEZ1u3GAeO+o0KiIBw8WOJ7nHkvQ/IRblpfpIe7nKGE7SRS
         Jg/T/3v0UNJFS2ktWc5+OgfeOuKABQn/qSDh9+tKHK1j6397KBeQm3i1CVZMMARZoL3u
         B6B8kBVJCO7f7uHnWzxHim/3AfChVmfnNtnvesAqnmMkFkGOnxIO+M8Df5usoBeDldYE
         g5trqSbU9wGgzK5DmVX9Twt/Nu/aUuItzZvMs4icY7h8Xm9U4Ns30dICFjWvsRwcLg0j
         PCwe83KHpSqzmkWOFkQH0lWMijXrL5IVqPElMGZbADLzAoDuWK5KCHbF4SBiqNu0V2H8
         0VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+gTPMCxXNjJoF0/n+ZWKrD0/ywZQWm6nRUnBrn1+xaM=;
        b=BDj/Za3MAy8mglEiuDD42e2mYqBK/DSX6mx0JeM/DkOvpiWc3WPll0IY9IdwYUeXXn
         I91exTM5KvNsRy+143rSozIdKQpY4lHrarOQpOlT1a3KGM9JtkBajmZrIXLSiTlmZZK1
         +U7v454mDQTEgHHmb13rzP/7js0NKhW8V7XCCIq0kZ/3YGsbmzoS9I6jlAPW+Y2HUP4t
         4b3s3KGb7FAkcDfpiumgObkwvrPz9vxxkJnRkdys7bGn8lOU/W3AqUWw+7SMkLkX3O02
         m+qLroJgGdQRtqWxnRgU/5uWMQ5NE8D8Ha/qmGtIIRSn7EHwNWlwWvGXyzzqa7HBlwXA
         6EBA==
X-Gm-Message-State: AJcUukc5D46DtR1dvaOKLVO7Bvn8bUlhquhzl06Jv+qhkpQJ1skgKrF7
        GQIbBdIKMEEPEvNnY5TtxUw=
X-Google-Smtp-Source: ALg8bN6YIgFd5TO8T3mweJGXLOhL/Ot0Mn0pImW/qnzib4a+Il1p86aJ+miihranjEIIU0R7Kc0BbQ==
X-Received: by 2002:a63:6b05:: with SMTP id g5mr29145840pgc.15.1548904192746;
        Wed, 30 Jan 2019 19:09:52 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.20.103])
        by smtp.gmail.com with ESMTPSA id 5sm8349874pfz.149.2019.01.30.19.09.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 19:09:51 -0800 (PST)
Date:   Thu, 31 Jan 2019 08:44:05 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCHv2 8/9] xen/gntdev.c: Convert to use vm_insert_range
Message-ID: <20190131031405.GA2418@jordon-HP-15-Notebook-PC>
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

map->count is passed to vm_insert_range and internal API
verify map->count against count ( count = vma_pages(vma))
for page array boundary overrun. With this count is not
needed inside gntdev_mmap() and it could be replaced with
vma_pages(vma).

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/gntdev.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 5efc5ee..a930309 100644
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

