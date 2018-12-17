Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBAFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0578021473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUpc9hwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389535AbeLQUWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:22:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43532 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbeLQUWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:22:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so6908785pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 12:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5oYSW/GvpO5Jr2lAVUEKxgPmdiaC90t9yQ4KohCOQbY=;
        b=uUpc9hwqBACC1ZZmRW2aJsERMSJYQSVWUZFU0pgyeaJfu045oCUzYU8kMbaQ6ZcswG
         cFnF7lbG8tboEYSgWHBixo5XTCn6nKmuO3d8msyYCleyVTR2qX22tayUeQ1wmuMoVRwJ
         VrbmiaIaYzoTlf4ZGENyW19EFsqEHXYXe9bvt3o4HL03lfBc/25uinXGuzEpMxuGiNNb
         vP/QGj4O7JdWYnb4pQ4Sp++kzTjEym3CCaLCMzy2ECrFxoW1FDGtTK/6IYn2AuBSNMJr
         bJ9VX56znbPJzTEv4tUW1S/bmY7fT2QSIaDklkp7DHN7svgrhsUTgRGVzN5ZtM0wLrV0
         GX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5oYSW/GvpO5Jr2lAVUEKxgPmdiaC90t9yQ4KohCOQbY=;
        b=Y6A6rosx20er65SPBa5VqomZ62Owyo5lguEcbgSG5RHWiuGHb2wpQUVmaVNqgXnwYu
         ZDp/izPDqb2WIHBcQdb7GN0g234v3tUKcTh52s1GWgbP5yCeRK53eex4UB/xX9UzWWmm
         /4K4GJNl6AoHI4qGu2q+DRc7g8rMJ1tq36XT7xQqGvShqh2j1/mswwKx6jbQwVS+G+Ai
         56vYsJG+ae1jYaagUiGdn/y6mVNyFiFGeh0ia7tTqpAsNLbXyx0fcdpyGYrSO5ThD6TF
         DrP+AJqG27bEAVFc0mKo1K12jHUFZ/g1Ron6wH0XbeEgPYFttVbFEDrocshiDti3ILec
         FgoQ==
X-Gm-Message-State: AA+aEWY6qfshk3ZdJOK8pjRXTuwPy/ofGsR2LxKUiICXL5F6We0+YUDk
        4nv1VZwtI7sXRBi2lwqFQZ7vn6mc
X-Google-Smtp-Source: AFSGD/UQwbbHHDgaOIDkqKpoGY4JfB62/5kRzA0kZTM7mwQtu/OWvxDxGYC44oQHanjoZ9eudkvANg==
X-Received: by 2002:a62:5f07:: with SMTP id t7mr6183800pfb.108.1545078172823;
        Mon, 17 Dec 2018 12:22:52 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.98.208])
        by smtp.gmail.com with ESMTPSA id b68sm21581385pfg.160.2018.12.17.12.22.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 12:22:51 -0800 (PST)
Date:   Tue, 18 Dec 2018 01:56:44 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 9/9] xen/privcmd-buf.c: Convert to use vm_insert_range
Message-ID: <20181217202644.GA19376@jordon-HP-15-Notebook-PC>
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
 drivers/xen/privcmd-buf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index df1ed37..d31b837 100644
--- a/drivers/xen/privcmd-buf.c
+++ b/drivers/xen/privcmd-buf.c
@@ -180,12 +180,8 @@ static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma_priv->n_pages != count)
 		ret = -ENOMEM;
 	else
-		for (i = 0; i < vma_priv->n_pages; i++) {
-			ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
-					     vma_priv->pages[i]);
-			if (ret)
-				break;
-		}
+		ret = vm_insert_range(vma, vma->vm_start, vma_priv->pages,
+					vma_priv->n_pages);
 
 	if (ret)
 		privcmd_buf_vmapriv_free(vma_priv);
-- 
1.9.1

