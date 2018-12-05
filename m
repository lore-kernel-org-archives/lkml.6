Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0CEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D6620989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D6620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbeLEXES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:04:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbeLEXES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:04:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7042630820F3;
        Wed,  5 Dec 2018 23:04:17 +0000 (UTC)
Received: from redhat.com (ovpn-116-101.phx2.redhat.com [10.3.116.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CDB960E3F;
        Wed,  5 Dec 2018 23:04:15 +0000 (UTC)
Date:   Wed, 5 Dec 2018 18:04:13 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mm/mmu_notifier: use structure for
 invalidate_range_start/end callback
Message-ID: <20181205230413.GN3536@redhat.com>
References: <20181205053628.3210-1-jglisse@redhat.com>
 <20181205053628.3210-2-jglisse@redhat.com>
 <b76dfbdd-a017-4032-d8a1-860ff62dfb59@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b76dfbdd-a017-4032-d8a1-860ff62dfb59@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 05 Dec 2018 23:04:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 09:42:45PM +0000, Kuehling, Felix wrote:
> The amdgpu part looks good to me.
> 
> A minor nit-pick in mmu_notifier.c (inline).
> 
> Either way, the series is Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> 
> On 2018-12-05 12:36 a.m., jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> >
> > To avoid having to change many callback definition everytime we want
> > to add a parameter use a structure to group all parameters for the
> > mmu_notifier invalidate_range_start/end callback. No functional changes
> > with this patch.
> >
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Matthew Wilcox <mawilcox@microsoft.com>
> > Cc: Ross Zwisler <zwisler@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Krčmář <rkrcmar@redhat.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Felix Kuehling <felix.kuehling@amd.com>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: kvm@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  | 43 +++++++++++--------------
> >  drivers/gpu/drm/i915/i915_gem_userptr.c | 14 ++++----
> >  drivers/gpu/drm/radeon/radeon_mn.c      | 16 ++++-----
> >  drivers/infiniband/core/umem_odp.c      | 20 +++++-------
> >  drivers/infiniband/hw/hfi1/mmu_rb.c     | 13 +++-----
> >  drivers/misc/mic/scif/scif_dma.c        | 11 ++-----
> >  drivers/misc/sgi-gru/grutlbpurge.c      | 14 ++++----
> >  drivers/xen/gntdev.c                    | 12 +++----
> >  include/linux/mmu_notifier.h            | 14 +++++---
> >  mm/hmm.c                                | 23 ++++++-------
> >  mm/mmu_notifier.c                       | 21 ++++++++++--
> >  virt/kvm/kvm_main.c                     | 14 +++-----
> >  12 files changed, 102 insertions(+), 113 deletions(-)
> >
> [snip]
> > diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> > index 5119ff846769..5f6665ae3ee2 100644
> > --- a/mm/mmu_notifier.c
> > +++ b/mm/mmu_notifier.c
> > @@ -178,14 +178,20 @@ int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
> >  				  unsigned long start, unsigned long end,
> >  				  bool blockable)
> >  {
> > +	struct mmu_notifier_range _range, *range = &_range;
> 
> I'm not sure why you need to access _range indirectly through a pointer.
> See below.
> 
> 
> >  	struct mmu_notifier *mn;
> >  	int ret = 0;
> >  	int id;
> >  
> > +	range->blockable = blockable;
> > +	range->start = start;
> > +	range->end = end;
> > +	range->mm = mm;
> 
> This could just assign _range.blockable, _range.start, etc. without the
> indirection. Or you could even use an initializer instead:
> 
> struct mmu_notifier_range range = {
>     .blockable = blockable,
>     .start = start,
>     ...
> };
> 
> 
> > +
> >  	id = srcu_read_lock(&srcu);
> >  	hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list, hlist) {
> >  		if (mn->ops->invalidate_range_start) {
> > -			int _ret = mn->ops->invalidate_range_start(mn, mm, start, end, blockable);
> > +			int _ret = mn->ops->invalidate_range_start(mn, range);
> 
> This could just use &_range without the indirection.
> 
> Same in ..._invalidate_range_end below.

So explaination is that this is a temporary step all this code is
remove in the second patch. It was done this way in this patch to
minimize the diff within the next patch.

I did this because i wanted to do the convertion in 2 steps the
first step i convert all the listener of mmu notifier and in the
second step i convert all the call site that trigger a mmu notifer.

I did that to help people reviewing only the part they care about.

Apparently it end up confusing people more than it helped :)

Do people have strong feeling about getting this code that is
deleted in the second patch fix in the first patch anyway ?

I can respin if so but i don't see much value in formating code
that is deleted in the serie.

Thank you for reviewing

Cheers,
Jérôme
