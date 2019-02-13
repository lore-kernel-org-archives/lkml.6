Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF64C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21AF20836
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpMiZSwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391523AbfBMODL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:03:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39692 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfBMODL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:03:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so1175586pgp.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 06:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=H3f1MfvSqhk7fYk2/rKXnYTMr6+lbY/NU0rOXhC8O5U=;
        b=VpMiZSwr42h7RxTwV/fk8d9BvpQX7IxZRgpbvLieA3dNWhefjo4gx9DsgkSJxHG5xY
         wC8gs8rhLMdhakzvA7oL3jNRziwz7HEyOTtO2L3OQIzTamDfB/biwjzged3RE0GG3ATU
         xuWbBjt2GRG8opSicVG2QUTYyUnn+GGduoR+U6oEElaJScHfTOMoRrcwP5w0vms4QADZ
         9VBDPI8ieNLKUwgTj1XSYpg8Ft8L5J7CWA6BmuBq/Ue9jTcjw/QWui/8DSIihzIKTXLv
         OQeBIirsIL7XlCwp3H6auQQD2MIsgvPcgl9fMY7o0nzmpEMK84/HhiQq7ryFqw3J6BLN
         P70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=H3f1MfvSqhk7fYk2/rKXnYTMr6+lbY/NU0rOXhC8O5U=;
        b=VtMti/muM2GhBerQnh5RE3nGssJUWw9EVjnitbaOL5EWOjIDOJrHMLsGkFCrpbAzMq
         MgwR/10wRAqJ2j+TjkHZ+ec1YLPcsiJw75rEZ+isXnPXsf5YreQ2K7lcI2VQWiOGC3j1
         7w0kWxKlVcFvDNxT7h3eTvGLAESst4zqbcxodcj/XR107z8k2siFgppf9yDh0G3Tezt4
         TIUIOaOpYjf1u+OnAmNC44+0ptJ6P7oWj4lZuK9QpNjoJ9oFrXm0Tdo991/qdlSiORco
         Yp/vru/NbQMwZQPDOoWxyhm0Pqe5M3LZVPHOwVtlmjC7LD6lP5qx2HcTi6A6vP2nij5j
         eFwg==
X-Gm-Message-State: AHQUAubLgJHRTVZMNHsSeiGfeS3nAcqemv6y2X/5f3LCpZBj4PMcDFDv
        unsEWzocjeCWsMJYArn5cWw=
X-Google-Smtp-Source: AHgI3Iak/rjAyAcN8Vw2WTjmvGMW4dx0H2O1oZmqXhf6ReElXpJJUKu4heHYpMVKWTk/KCbDtzDT8g==
X-Received: by 2002:aa7:8497:: with SMTP id u23mr631577pfn.253.1550066590259;
        Wed, 13 Feb 2019 06:03:10 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.48.54])
        by smtp.gmail.com with ESMTPSA id o2sm27533402pfa.149.2019.02.13.06.03.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 06:03:09 -0800 (PST)
Date:   Wed, 13 Feb 2019 19:37:28 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 8/9] xen/gntdev.c: Convert to use vm_map_pages()
Message-ID: <20190213140728.GA22080@jordon-HP-15-Notebook-PC>
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

map->count is passed to vm_map_pages() and internal API
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
index 5efc5ee..7f65ba3 100644
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
+		err = vm_map_pages(vma, map->pages, map->count);
+		if (err)
+			goto out_put_map;
 	} else {
 #ifdef CONFIG_X86
 		/*
-- 
1.9.1

