Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0452C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915862073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="LgHxixDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeL1XvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 18:51:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46311 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeL1XvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 18:51:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so10549731ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 15:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MoVIau6lj/M7bIoLJfdoRPJzHMal1oek4dyFIMUguU0=;
        b=LgHxixDNlHIk+usBjf8uxWLtWb8jNkl9rsQrt6DouWeAgRV7/Cu0lghFvyNSSdyVqU
         W09z2cXrhg47I7wDZkGp55Ne3FThFk6fD1SUJZX0SR1lXpnhkJ0tGYi76Bvpj+7RiXr5
         hgr579Rh5AkVPOzaTK7DGgJfKaMTlHVeROqvuzWGNm+/Bc5M4Ft8isw+s2gMp+vGkW0k
         eDXCck55nuLXHOZex4lz/HWU1GRskNyxrfm2QW5ILYhn0NIF0NShfnBFtMDau3NTLojK
         rdexxwvZKsNYLDTAWc2M8GBHblFrK3R1cWZTBOauC4gW5WeXV6gS+NVSb5d2v1tlr5Bb
         pHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MoVIau6lj/M7bIoLJfdoRPJzHMal1oek4dyFIMUguU0=;
        b=GHW2i4xZKmKx9mRzLxrWbAcprwZ3M9qGeEut67MpeFrVS2OHlyBbY0O4lRZqNoW0lk
         bNQRcUEpiZfhA/x8Zqrtmyl8vJhpZ6rc+7nkIo/WfrN9C0hx9ImJTlBRfBK+96+LmeLy
         jrSLOI3a5Pvmc2xMgF2W2nojFBJ5DqXEICFmqdhlQl/kr2LaR7cvdgcTqMIlE7W7C4lH
         XznIj8RwyEgkvzTp1qkVAoG36YXT5x+K2ig6lsQSZlgLu8ssjDeD5izfS5DJMlz7JSqT
         1yu7/LJj1ectUd8AN7AVfq6cLBnSmaNkHBWuDnG+ukPQ7njLGTp8STjinrqyZ2GdpSHZ
         SNkA==
X-Gm-Message-State: AJcUukdELpq6cDTMddoabnsWu9ndkR/V/nMvrV8j+XAK+wQnN98V0xM9
        rLkzGqhDMTFa5NxRgtOU9yBOyw==
X-Google-Smtp-Source: ALg8bN4sUOKoabfbWYKJAXnrwwlsjmAfN33+nKBmr5g9zZF8pn/U4dD7LmeEYtMPhHjYzkYLzM6cJA==
X-Received: by 2002:a17:902:59c8:: with SMTP id d8mr29374586plj.116.1546041070807;
        Fri, 28 Dec 2018 15:51:10 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id d13sm48040777pfd.58.2018.12.28.15.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 15:51:09 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 91CA83000D9; Sat, 29 Dec 2018 02:51:06 +0300 (+03)
Date:   Sat, 29 Dec 2018 02:51:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+b437b5a429d680cf2217@syzkaller.appspotmail.com>,
        darrick.wong@oracle.com, hannes@cmpxchg.org, hughd@google.com,
        jack@suse.cz, josef@toxicpanda.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: KASAN: use-after-free Read in filemap_fault
Message-ID: <20181228235106.okk3oastsnpxusxs@kshutemo-mobl1>
References: <000000000000b57d19057e1b383d@google.com>
 <20181228130938.c9e42c213cdcc35a93dd0dac@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228130938.c9e42c213cdcc35a93dd0dac@linux-foundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 01:09:38PM -0800, Andrew Morton wrote:
> On Fri, 28 Dec 2018 12:51:04 -0800 syzbot <syzbot+b437b5a429d680cf2217@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following crash on:
> 
> uh-oh.  Josef, could you please take a look?
> 
> :	page = find_get_page(mapping, offset);
> : 	if (likely(page) && !(vmf->flags & FAULT_FLAG_TRIED)) {
> : 		/*
> : 		 * We found the page, so try async readahead before
> : 		 * waiting for the lock.
> : 		 */
> : 		fpin = do_async_mmap_readahead(vmf, page);
> : 	} else if (!page) {
> : 		/* No page in the page cache at all */
> : 		fpin = do_sync_mmap_readahead(vmf);
> : 		count_vm_event(PGMAJFAULT);
> : 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
> 
> vmf->vma has been freed at this point.
> 
> : 		ret = VM_FAULT_MAJOR;
> : retry_find:
> : 		page = pagecache_get_page(mapping, offset,
> : 					  FGP_CREAT|FGP_FOR_MMAP,
> : 					  vmf->gfp_mask);
> : 		if (!page) {
> : 			if (fpin)
> : 				goto out_retry;
> : 			return vmf_error(-ENOMEM);
> : 		}
> : 	}
> 

Here's a fixup for "filemap: drop the mmap_sem for all blocking operations".

do_sync_mmap_readahead() drops mmap_sem now, so by the time of
dereferencing vmf->vma for count_memcg_event_mm() the VMA can be gone.

diff --git a/mm/filemap.c b/mm/filemap.c
index 00a9315f45d4..65c85c47bdb1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2554,10 +2554,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		fpin = do_async_mmap_readahead(vmf, page);
 	} else if (!page) {
 		/* No page in the page cache at all */
-		fpin = do_sync_mmap_readahead(vmf);
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
 		ret = VM_FAULT_MAJOR;
+		fpin = do_sync_mmap_readahead(vmf);
 retry_find:
 		page = pagecache_get_page(mapping, offset,
 					  FGP_CREAT|FGP_FOR_MMAP,
-- 
 Kirill A. Shutemov
