Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-105495-1523379075-2-2823845947252226789
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523379074; b=BPsI7/ZkDjrxQBPKv/GduiSCG5RXrZ8kms4qzq9TK0+yd7DTBT
    uZ/KddU08tIR45TsrHcAzP/+QdVtBCwKqoz9qz3WjaLhDqwo8SztpcSDqFgAR+rh
    wS8aqOz4E4cl4pWUBoPXKOhptDH5Me7lP4IP60m8EHH/QcwrUks2LgSm62lj/8VS
    C2X41pDeLGcP/LP+Q/Kx0VWla5KZThGoe6re6U14Zhss6jX51zVWqiPtnufij713
    p0+afNlW/cn8g/5+hJHIY4zP5WB3G+VX9BX+Twof/1aXMokgk8LQEXls0IpDM5BD
    XPdnFfRcXdnpxqUJimKDrM1GJhOH1GgOAQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523379074; bh=EnD6dfTswChQKYfUUs/TOK+2Pw2UAM
    3LTdNRyxjqpfE=; b=twjuAAv9wRhIosorznaQEjO3rxSk7oQoQWiJQ5zSxg1kBm
    51+Ea+toci4qO2LiX91S6pjtQZcqq+3Opkacg5F6rlklZB6CwZ+mXQBMro6xk9xs
    dQHKZGIfQs8PgZRLvCKufXaPTSyBoWisgsrYdKTHUbaQtG9H9TTFeUmOxC/wPeHh
    aJtm20Io0ydtWRo3mjVZdFAbLGgDPULuGgpwwQJAyCI8rwgR34Btz7oFCbdc5uJM
    jEoC5/dm+XkWPmU4Tfh7JKh/8YF8Lh+34zE6auj7KmRbp+UZFLBo/B+17aD1WiNh
    iPl6y0TKu2FiwpGd+lORLwMXeM3q1ZXL6iDBkUlg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=RmpzlPFD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=RmpzlPFD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBJ0XAghHjsWtS66m/ZEaAOhLvik4GCV+JJgjStGpnXvkpmCrgWHD0cVrUsyp9BMqeawtcuMge17JR3H0MllUKGdTXib4cAWHzGtZscIEDEWQ80r9i44
    bobF4X6d96umHlo3Vnsj0oHhoBV68BZ6xL/ytWvQlurm2fvFcHYcoijse93q6tz2IelsQb+QREIIAYHjDjQovRUEqHlVAZ+cj/yRGBM44pD5NQOyYwmDPvWx
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=eejXi4OVx3Re_XrXuE8A:9
    a=H32HvdtGcpMfrMW8:21 a=Sz1cIT2OlcuhnTDV:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeDJQvA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 12:51:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeDJQu7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 12:50:59 -0400
Date: Tue, 10 Apr 2018 09:50:54 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] slab: __GFP_ZERO is incompatible with a constructor
Message-ID: <20180410165054.GC3614@bombadil.infradead.org>
References: <20180410125351.15837-1-willy@infradead.org>
 <fee8a8bc-3db5-a66a-33cb-0729143ba615@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee8a8bc-3db5-a66a-33cb-0729143ba615@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 06:53:04AM -0700, Eric Dumazet wrote:
> On 04/10/2018 05:53 AM, Matthew Wilcox wrote:
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> > 
> > __GFP_ZERO requests that the object be initialised to all-zeroes,
> > while the purpose of a constructor is to initialise an object to a
> > particular pattern.  We cannot do both.  Add a warning to catch any
> > users who mistakenly pass a __GFP_ZERO flag when allocating a slab with
> > a constructor.
> > 
> > Fixes: d07dbea46405 ("Slab allocators: support __GFP_ZERO in all allocators")
> > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> > Cc: stable@vger.kernel.org
> 
> Since there are probably no bug to fix, what about adding the extra check
> only for some DEBUG option ?
> 
> How many caches are still using ctor these days ?

That's a really good question, and strangely hard to find out.  I settled
on "git grep -A4 kmem_cache_alloc" and then searching the 'less' output
with '[^L]);'.

--
arch/powerpc/kvm/book3s_64_mmu_radix.c: kvm_pte_cache = kmem_cache_create("kvm-pte", size, size, 0, pte_ctor);
--
arch/powerpc/mm/init-common.c:  new = kmem_cache_create(name, table_size, align, 0, ctor);
--
arch/powerpc/platforms/cell/spufs/inode.c:      spufs_inode_cache = kmem_cache_create("spufs_inode_cache",
arch/powerpc/platforms/cell/spufs/inode.c-                      sizeof(struct spufs_inode_info), 0,
arch/powerpc/platforms/cell/spufs/inode.c-                      SLAB_HWCACHE_ALIGN|SLAB_ACCOUNT, spufs_init_once);
--
arch/sh/mm/pgtable.c:   pgd_cachep = kmem_cache_create("pgd_cache",
arch/sh/mm/pgtable.c-                                  PTRS_PER_PGD * (1<<PTE_MAGNITUDE),
arch/sh/mm/pgtable.c-                                  PAGE_SIZE, SLAB_PANIC, pgd_ctor);
--
arch/sparc/mm/tsb.c:    pgtable_cache = kmem_cache_create("pgtable_cache",
arch/sparc/mm/tsb.c-                                      PAGE_SIZE, PAGE_SIZE,
arch/sparc/mm/tsb.c-                                      0,
arch/sparc/mm/tsb.c-                                      _clear_page);
--
drivers/dax/super.c:    dax_cache = kmem_cache_create("dax_cache", sizeof(struct
 dax_device), 0,
drivers/dax/super.c-                    (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT
|
drivers/dax/super.c-                     SLAB_MEM_SPREAD|SLAB_ACCOUNT),
drivers/dax/super.c-                    init_once);
--
drivers/staging/ncpfs/inode.c:  ncp_inode_cachep = kmem_cache_create("ncp_inode_
cache",
drivers/staging/ncpfs/inode.c-                                       sizeof(stru
ct ncp_inode_info),
drivers/staging/ncpfs/inode.c-                                       0, (SLAB_RE
CLAIM_ACCOUNT|
drivers/staging/ncpfs/inode.c-                                          SLAB_MEM
_SPREAD|SLAB_ACCOUNT),
drivers/staging/ncpfs/inode.c-                                       init_once);
--
drivers/usb/mon/mon_text.c:     rp->e_slab = kmem_cache_create(rp->slab_name,
drivers/usb/mon/mon_text.c-         sizeof(struct mon_event_text), sizeof(long),
 0,
drivers/usb/mon/mon_text.c-         mon_text_ctor);
--
fs/9p/v9fs.c:   v9fs_inode_cache = kmem_cache_create("v9fs_inode_cache",
fs/9p/v9fs.c-                                     sizeof(struct v9fs_inode),
fs/9p/v9fs.c-                                     0, (SLAB_RECLAIM_ACCOUNT|
fs/9p/v9fs.c-                                         SLAB_MEM_SPREAD|SLAB_ACCOUNT),
fs/9p/v9fs.c-                                     v9fs_inode_init_once);
--
fs/adfs/super.c:        adfs_inode_cachep = kmem_cache_create("adfs_inode_cache",
fs/adfs/super.c-                                             sizeof(struct adfs_inode_info),
fs/adfs/super.c-                                             0, (SLAB_RECLAIM_ACCOUNT|
fs/adfs/super.c-                                                SLAB_MEM_SPREAD|SLAB_ACCOUNT),
fs/adfs/super.c-                                             init_once);
... snip a huge number of filesystems ...
--
ipc/mqueue.c:   mqueue_inode_cachep = kmem_cache_create("mqueue_inode_cache",
ipc/mqueue.c-                           sizeof(struct mqueue_inode_info), 0,
ipc/mqueue.c-                           SLAB_HWCACHE_ALIGN|SLAB_ACCOUNT, init_once);
--
kernel/fork.c:  sighand_cachep = kmem_cache_create("sighand_cache",
kernel/fork.c-                  sizeof(struct sighand_struct), 0,
kernel/fork.c-                  SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_R
CU|
kernel/fork.c-                  SLAB_ACCOUNT, sighand_ctor);
--
lib/radix-tree.c:       radix_tree_node_cachep = kmem_cache_create("radix_tree_n
ode",
lib/radix-tree.c-                       sizeof(struct radix_tree_node), 0,
lib/radix-tree.c-                       SLAB_PANIC | SLAB_RECLAIM_ACCOUNT,
lib/radix-tree.c-                       radix_tree_node_ctor);
--
mm/rmap.c:      anon_vma_cachep = kmem_cache_create("anon_vma", sizeof(struct an
on_vma),
mm/rmap.c-                      0, SLAB_TYPESAFE_BY_RCU|SLAB_PANIC|SLAB_ACCOUNT,
mm/rmap.c-                      anon_vma_ctor);
--
mm/shmem.c:     shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
mm/shmem.c-                             sizeof(struct shmem_inode_info),
mm/shmem.c-                             0, SLAB_PANIC|SLAB_ACCOUNT, shmem_init_inode);
--
net/sunrpc/rpc_pipe.c:  rpc_inode_cachep = kmem_cache_create("rpc_inode_cache",
net/sunrpc/rpc_pipe.c-                          sizeof(struct rpc_inode),
net/sunrpc/rpc_pipe.c-                          0, (SLAB_HWCACHE_ALIGN|SLAB_RECL
AIM_ACCOUNT|
net/sunrpc/rpc_pipe.c-                                          SLAB_MEM_SPREAD|
SLAB_ACCOUNT),
net/sunrpc/rpc_pipe.c-                          init_once);
--
security/integrity/iint.c:          kmem_cache_create("iint_cache", sizeof(struc
t integrity_iint_cache),
security/integrity/iint.c-                            0, SLAB_PANIC, init_once);

So aside from the filesystems, about fourteen places use it in the kernel.

If we want to get rid of the concept of constructors, it's doable,
but somebody needs to do the work to show what the effects will be.

For example, I took a quick look at the sighand_struct in kernel/fork.c.
That initialises the spinlock and waitqueue head which are at the end
of sighand_struct.  The caller who allocates sighand_struct touches
the head of the struct.  So if we removed the ctor, we'd touch two
cachelines on allocation instead of one ... but we could rearrange the
sighand_struct to put all the initialised bits in the first cacheline
(and we probably should).
