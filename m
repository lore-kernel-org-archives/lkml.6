Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754671AbeBNIYO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:24:14 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35321 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754556AbeBNIYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:24:12 -0500
X-Google-Smtp-Source: AH8x227110W69L5ExixP1hCR+AtECk58EF2nNj6+Y9CtM+mMD6v9ySwLbFwY3DihOjBz4CRlCX0zhA==
Date: Wed, 14 Feb 2018 11:24:09 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm 3/3] proc: account "struct pde_opener"
Message-ID: <20180214082409.GC17157@avx2>
References: <20180214063033.GA15579@avx2>
 <20180214081935.GA17157@avx2>
 <20180214082306.GB17157@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214082306.GB17157@avx2>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation is persistent in fact as any fool can open a file in
/proc and sit on it.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -103,7 +103,7 @@ void __init proc_init_kmemcache(void)
 					     init_once);
 	pde_opener_cache =
 		kmem_cache_create("pde_opener", sizeof(struct pde_opener), 0,
-				  SLAB_PANIC, NULL);
+				  SLAB_ACCOUNT|SLAB_PANIC, NULL);
 }
 
 static int proc_show_options(struct seq_file *seq, struct dentry *root)
