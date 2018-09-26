Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1E5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EAB21537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="HyDmgN7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EAB21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeI0BH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:07:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46918 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeI0BH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:07:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id q4-v6so16099741otf.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oS6YZlZxSl4vHIksOvycCSDix91/LSZmXH6NehzvYZE=;
        b=HyDmgN7YhFLgNaWUBPMkkqhO3mm+I8mWzFzACspPKMvpDFLxNLGRh2r20yFvNBBBLQ
         /3MvqViQ2BdsfS77IAYa/XfjrjNPsZvPJZg1bjKsXnIR02g5mpitrx93UnLDPVgPDw4m
         HOGgbQEDuSPbQV5A3jDK34oVLCkvopQQkLLv6IFB73ZXuH8sK9tZjh2NUcB8DhRQr/Ic
         CxTBClAU7SJlOJQCOxrKE2m6a2Qg1gdM9yIZhOorWLN94xl+Ap+KzPMQmzclDeJjXjAU
         CHpsWm6qdj0gDSIZlzvk0pp5sv+DquzV8CG8leLZU1t4Exfsbsd1WWwVHdt9jm6XkFpn
         gSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oS6YZlZxSl4vHIksOvycCSDix91/LSZmXH6NehzvYZE=;
        b=aLfnLP6/2H3IcT9WZ4OImodhmoSWpTrMpcpHOXfj/N3R28MTUm8A3VluoDMkw7hsGC
         6QkooR+v4njf8SDPHjKmXX+WP6qK0GhrwiGJ7VYMvBzHK4vma6K1nCTMaAgtn3leUMT6
         daWFHlSnfXNr4i237Xnu7nUNOUaDC97jbre4lIChU7Rzqu+eE9pMKJCAmvYqpYMyiBnl
         jGnIhaiCtI07jG5T8q+KokVQ0Wx58cT5MQJ42VYbwAdBsaoQIr/GqMNTYCmtU/t0owWV
         ZX4mehiKlFJ6crDVgBY3vE2SNX3NTkeKbdDcqtVFENFalxE/BNZs8rCgeNRPsGBpEhpU
         OXlA==
X-Gm-Message-State: ABuFfogbQCqC/oXlqVPaQzalmUFvIAO42VQ4Go99ANQqlGUP6d7/8af4
        2G/XWOsmCTv3npbi/LDrsE2ua7KuFzwCGav2P+gtvQ==
X-Google-Smtp-Source: ACcGV62VGhr2f+K42nqQu2oAHJPcYvgKS/w9znB4aEnJwqA++prR9tI3kOjTE5kqJEibpRIFm4awXlbs3mK+Rp3BjMo=
X-Received: by 2002:a9d:da2:: with SMTP id 31-v6mr4982708ots.33.1537987988156;
 Wed, 26 Sep 2018 11:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain> <20180926075540.GD6278@dhcp22.suse.cz>
 <6f87a5d7-05e2-00f4-8568-bb3521869cea@linux.intel.com>
In-Reply-To: <6f87a5d7-05e2-00f4-8568-bb3521869cea@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 26 Sep 2018 11:52:56 -0700
Message-ID: <CAPcyv4iVnodai0bB74yeSCD2H+hoLsZYUk4sR9jV0pPAE+Zorw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     alexander.h.duyck@linux.intel.com
Cc:     Michal Hocko <mhocko@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Logan Gunthorpe <logang@deltatee.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:25 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
>
>
> On 9/26/2018 12:55 AM, Michal Hocko wrote:
> > On Tue 25-09-18 13:21:24, Alexander Duyck wrote:
> >> The ZONE_DEVICE pages were being initialized in two locations. One was with
> >> the memory_hotplug lock held and another was outside of that lock. The
> >> problem with this is that it was nearly doubling the memory initialization
> >> time. Instead of doing this twice, once while holding a global lock and
> >> once without, I am opting to defer the initialization to the one outside of
> >> the lock. This allows us to avoid serializing the overhead for memory init
> >> and we can instead focus on per-node init times.
> >>
> >> One issue I encountered is that devm_memremap_pages and
> >> hmm_devmmem_pages_create were initializing only the pgmap field the same
> >> way. One wasn't initializing hmm_data, and the other was initializing it to
> >> a poison value. Since this is something that is exposed to the driver in
> >> the case of hmm I am opting for a third option and just initializing
> >> hmm_data to 0 since this is going to be exposed to unknown third party
> >> drivers.
> >
> > Why cannot you pull move_pfn_range_to_zone out of the hotplug lock? In
> > other words why are you making zone device even more special in the
> > generic hotplug code when it already has its own means to initialize the
> > pfn range by calling move_pfn_range_to_zone. Not to mention the code
> > duplication.
>
> So there were a few things I wasn't sure we could pull outside of the
> hotplug lock. One specific example is the bits related to resizing the
> pgdat and zone. I wanted to avoid pulling those bits outside of the
> hotplug lock.
>
> The other bit that I left inside the hot-plug lock with this approach
> was the initialization of the pages that contain the vmemmap.
>
> > That being said I really dislike this patch.
>
> In my mind this was a patch that "killed two birds with one stone". I
> had two issues to address, the first one being the fact that we were
> performing the memmap_init_zone while holding the hotplug lock, and the
> other being the loop that was going through and initializing pgmap in
> the hmm and memremap calls essentially added another 20 seconds
> (measured for 3TB of memory per node) to the init time. With this patch
> I was able to cut my init time per node by that 20 seconds, and then
> made it so that we could scale as we added nodes as they could run in
> parallel.

Yeah, at the very least there is no reason for devm_memremap_pages()
to do another loop through all pages, the core should handle this, but
cleaning up the scope of the hotplug lock is needed.

> With that said I am open to suggestions if you still feel like I need to
> follow this up with some additional work. I just want to avoid
> introducing any regressions in regards to functionality or performance.

Could we push the hotplug lock deeper to the places that actually need
it? What I found with my initial investigation is that we don't even
need the hotplug lock for the vmemmap initialization with this patch
[1].

Alternatively it seems the hotplug lock wants to synchronize changes
to the zone and the page init work. If the hotplug lock was an rwsem
the zone changes would be a write lock, but the init work could be
done as a read lock to allow parallelism. I.e. still provide a sync
point to be able to assert that no hotplug work is in-flight will
holding the write lock, but otherwise allow threads that are touching
independent parts of the memmap to run at the same time.

[1]: https://patchwork.kernel.org/patch/10527229/ just focus on the
mm/sparse-vmemmap.c changes at the end.
