Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2150C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE5A21530
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE5A21530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeHWOUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:20:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35002 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeHWOUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:20:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so5354608wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 03:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WlfqviBghUm7D4MVryZrF7hJ8A6mrcUG+VQ+Se6BgZ4=;
        b=K4dqodqxXVlIm0aZPyOupp+x58wIzRf1f+4Jd7kOjRVh+60RW6CDV1UpvvPdN4jBwo
         dCrkUvol4ZI1cHje0pPE5+bYj/bke+uGc6MFCcuZqOu5hMpmhj3JPQ4OZDgwkv/794Tz
         dx0nhl/M1tI6NFCaaNSPCNWvi7r+0CPnVuMLgS8EobYdtQahv28QpPm8jKMncnf811Rx
         s0j3L67lZz3WZK1hkU/C5BnQwbxVEzz+Upi/gbsM/HZrwYE+EQ/SoJv/+N+9pljzalzx
         nEQ9Wbml8pv+11j0XuvCLuTgPE6n1UndpWk5jKdNdNFF9fWkadtgcIqK9L+5BD/ZxMpA
         zjVg==
X-Gm-Message-State: APzg51CwnToNQoRqAoXhuS08wypigFoPv0ifLh0sSFeS81gzRSbYiJ/4
        CywQ0tuZ7fEkpIYN0gS7Yrw=
X-Google-Smtp-Source: ANB0VdZVC7JnJ846i5sRGAOAIznS2hzjAM5oxiGsfVQbBVHEa5eJD6w6X0uje4Cq1dCdViUtwhBx8A==
X-Received: by 2002:a1c:908b:: with SMTP id s133-v6mr4938991wmd.69.1535021492540;
        Thu, 23 Aug 2018 03:51:32 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id l12-v6sm3390326wrv.29.2018.08.23.03.51.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 03:51:31 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id ED9C2124A75; Thu, 23 Aug 2018 12:51:30 +0200 (CEST)
Date:   Thu, 23 Aug 2018 12:51:30 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, tglx@linutronix.de,
        joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: Fix comment for NODEMASK_ALLOC
Message-ID: <20180823105130.GB14924@techadventures.net>
References: <20180820085516.9687-1-osalvador@techadventures.net>
 <20180820142440.1f9ccbebefc5d617c881b41e@linux-foundation.org>
 <20180821121734.GA29735@dhcp22.suse.cz>
 <20180821123024.GA9489@techadventures.net>
 <20180821135159.63b77492f44c21ad203cd7b1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821135159.63b77492f44c21ad203cd7b1@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 01:51:59PM -0700, Andrew Morton wrote:
> On Tue, 21 Aug 2018 14:30:24 +0200 Oscar Salvador <osalvador@techadventures.net> wrote:
> 
> > On Tue, Aug 21, 2018 at 02:17:34PM +0200, Michal Hocko wrote:
> > > We do have CONFIG_NODES_SHIFT=10 in our SLES kernels for quite some
> > > time (around SLE11-SP3 AFAICS).
> > > 
> > > Anyway, isn't NODES_ALLOC over engineered a bit? Does actually even do
> > > larger than 1024 NUMA nodes? This would be 128B and from a quick glance
> > > it seems that none of those functions are called in deep stacks. I
> > > haven't gone through all of them but a patch which checks them all and
> > > removes NODES_ALLOC would be quite nice IMHO.
> > 
> > No, maximum we can get is 1024 NUMA nodes.
> > I checked this when writing another patch [1], and since having gone
> > through all archs Kconfigs, CONFIG_NODES_SHIFT=10 is the limit.
> > 
> > NODEMASK_ALLOC gets only called from:
> > 
> > - unregister_mem_sect_under_nodes() (not anymore after [1])
> > - __nr_hugepages_store_common (This does not seem to have a deep stack, we could use a normal nodemask_t)
> > 
> > But is also used for NODEMASK_SCRATCH (mainly used for mempolicy):
> > 
> > struct nodemask_scratch {
> > 	nodemask_t	mask1;
> > 	nodemask_t	mask2;
> > };
> > 
> > that would make 256 bytes in case CONFIG_NODES_SHIFT=10.
> 
> And that sole site could use an open-coded kmalloc.

It is not really one single place, but four:

- do_set_mempolicy()
- do_mbind()
- kernel_migrate_pages()
- mpol_shared_policy_init()

They get called in:

- do_set_mempolicy()
	- From set_mempolicy syscall
	- From numa_policy_init()
	- From numa_default_policy()

	* All above do not look like they have a deep stack, so it should
	  be possible to get rid of NODEMASK_SCRATCH there.

- do_mbind
	- From mbind syscall

	* Should be feasible here as well.

- kernel_migrate_pages()

	- From migrate_pages syscall
	
	* Again, this should be doable.

- mpol_shared_policy_init()

	- From hugetlbfs_alloc_inode()
	- shmem_get_inode()
	
	* Seems doable for hugetlbfs_alloc_inode as well. 
	  I only got to check hugetlbfs_alloc_inode, because shmem_get_inode


So it seems that this can be done in most of the places.
The only tricky function might be mpol_shared_policy_init because of shmem_get_inode.
But in that case, we could use an open-coded kmalloc there.

Thanks
-- 
Oscar Salvador
SUSE L3
