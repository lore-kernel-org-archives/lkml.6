Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF8FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D350320892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D350320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeLEQtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:49:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:48130 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727195AbeLEQtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:49:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 17569B0ED;
        Wed,  5 Dec 2018 16:49:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D492C1E0DBB; Wed,  5 Dec 2018 17:49:32 +0100 (CET)
Date:   Wed, 5 Dec 2018 17:49:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm/mmu_notifier: use structure for
 invalidate_range_start/end callback
Message-ID: <20181205164932.GI30615@quack2.suse.cz>
References: <20181205053628.3210-1-jglisse@redhat.com>
 <20181205053628.3210-2-jglisse@redhat.com>
 <20181205163520.GG30615@quack2.suse.cz>
 <20181205164052.GE3536@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205164052.GE3536@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-12-18 11:40:52, Jerome Glisse wrote:
> On Wed, Dec 05, 2018 at 05:35:20PM +0100, Jan Kara wrote:
> > On Wed 05-12-18 00:36:26, jglisse@redhat.com wrote:
> > > diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> > > index 5119ff846769..5f6665ae3ee2 100644
> > > --- a/mm/mmu_notifier.c
> > > +++ b/mm/mmu_notifier.c
> > > @@ -178,14 +178,20 @@ int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
> > >  				  unsigned long start, unsigned long end,
> > >  				  bool blockable)
> > >  {
> > > +	struct mmu_notifier_range _range, *range = &_range;
> > 
> > Why these games with two variables?
> 
> This is a temporary step i dediced to do the convertion in 2 steps,
> first i convert the callback to use the structure so that people
> having mmu notifier callback only have to review this patch and do
> not get distracted by the second step which update all the mm call
> site that trigger invalidation.
> 
> In the final result this code disappear. I did it that way to make
> the thing more reviewable. Sorry if that is a bit confusing.

Aha, right. Thanks for clarification. You can add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
