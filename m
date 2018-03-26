Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeCZWgv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:36:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54522 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeCZWgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:36:49 -0400
Date: Mon, 26 Mar 2018 15:36:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH v9 00/61] XArray v9
Message-Id: <20180326153648.27f53e9a1398812203745257@linux-foundation.org>
In-Reply-To: <20180313132639.17387-1-willy@infradead.org>
References: <20180313132639.17387-1-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 06:25:38 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> This patchset is, I believe, appropriate for merging for 4.17.
> It contains the XArray implementation, to eventually replace the radix
> tree, and converts the page cache to use it.

I looked at this from a for-4.17 POV and ran out of nerve at "[PATCH v9
09/61] xarray: Replace exceptional entries".  It's awfully late.

"[PATCH v9 08/61] page cache: Use xa_lock" looks sufficiently
mechanical to be if-it-compiles-it-works, although perhaps that
shouldn't be in 4.17 either.  Mainly because it commits us to merging
the rest of XArray and there hasn't been a ton of review and test
activity.



It looks like btrfs has changed in -next:

--- a/fs/btrfs/inode.c~page-cache-use-xa_lock-fix
+++ a/fs/btrfs/inode.c
@@ -7445,7 +7445,7 @@ out:
 
 bool btrfs_page_exists_in_range(struct inode *inode, loff_t start, loff_t end)
 {
-	struct radix_tree_root *root = &inode->i_mapping->page_tree;
+	struct radix_tree_root *root = &inode->i_mapping->i_pages;
 	bool found = false;
 	void **pagep = NULL;
 	struct page *page = NULL;
_
