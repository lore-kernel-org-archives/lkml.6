Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF26C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAA420854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfAVIb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:31:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbfAVIb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:31:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 907F741116;
        Tue, 22 Jan 2019 08:31:58 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E64B61101;
        Tue, 22 Jan 2019 08:31:48 +0000 (UTC)
Date:   Tue, 22 Jan 2019 16:31:46 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH RFC 05/24] userfaultfd: wp: add helper for writeprotect
 check
Message-ID: <20190122083146.GD14907@xz-x1>
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-6-peterx@redhat.com>
 <20190121102312.GD19725@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121102312.GD19725@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 22 Jan 2019 08:31:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 12:23:12PM +0200, Mike Rapoport wrote:
> On Mon, Jan 21, 2019 at 03:57:03PM +0800, Peter Xu wrote:
> > From: Shaohua Li <shli@fb.com>
> > 
> > add helper for writeprotect check. Will use it later.
> 
> I'd merge this with the commit that actually uses this helper.

Hi, Mike,

Yeah actually that's what I'd prefer for most of the time.  But I'm
trying to avoid doing that because I wanted to keep the credit of the
original authors, not only for this single patch, but also for the
whole series.  Meanwhile, since this work has been there for quite a
few years (starting from 2015), IMHO keeping the old patches mostly
untouched at least in the RFC stage might also help the reviewers if
they have read or prior knowledge of the previous work.

And if the patch cannot even stand on itself (this one can; it only
introduces new functions) I'll do the merge no matter what.

Please correct me if this is not the good way to do.

Thanks!

>  
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Pavel Emelyanov <xemul@parallels.com>
> > Cc: Rik van Riel <riel@redhat.com>
> > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Shaohua Li <shli@fb.com>
> > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/userfaultfd_k.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index 37c9eba75c98..38f748e7186e 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -50,6 +50,11 @@ static inline bool userfaultfd_missing(struct vm_area_struct *vma)
> >  	return vma->vm_flags & VM_UFFD_MISSING;
> >  }
> > 
> > +static inline bool userfaultfd_wp(struct vm_area_struct *vma)
> > +{
> > +	return vma->vm_flags & VM_UFFD_WP;
> > +}
> > +
> >  static inline bool userfaultfd_armed(struct vm_area_struct *vma)
> >  {
> >  	return vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP);
> > @@ -94,6 +99,11 @@ static inline bool userfaultfd_missing(struct vm_area_struct *vma)
> >  	return false;
> >  }
> > 
> > +static inline bool userfaultfd_wp(struct vm_area_struct *vma)
> > +{
> > +	return false;
> > +}
> > +
> >  static inline bool userfaultfd_armed(struct vm_area_struct *vma)
> >  {
> >  	return false;
> > -- 
> > 2.17.1
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 

Regards,

-- 
Peter Xu
