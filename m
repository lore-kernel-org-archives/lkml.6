Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFF5C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B0820700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfBVPg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:36:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49967 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBVPgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:36:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5508D820FF;
        Fri, 22 Feb 2019 15:36:24 +0000 (UTC)
Received: from redhat.com (ovpn-126-14.rdu2.redhat.com [10.10.126.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8EBD611D1;
        Fri, 22 Feb 2019 15:36:17 +0000 (UTC)
Date:   Fri, 22 Feb 2019 10:36:15 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 15/26] userfaultfd: wp: drop _PAGE_UFFD_WP properly
 when fork
Message-ID: <20190222153615.GF7783@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-16-peterx@redhat.com>
 <20190221180631.GO2813@redhat.com>
 <20190222090919.GM8904@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222090919.GM8904@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 22 Feb 2019 15:36:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 05:09:19PM +0800, Peter Xu wrote:
> On Thu, Feb 21, 2019 at 01:06:31PM -0500, Jerome Glisse wrote:
> > On Tue, Feb 12, 2019 at 10:56:21AM +0800, Peter Xu wrote:
> > > UFFD_EVENT_FORK support for uffd-wp should be already there, except
> > > that we should clean the uffd-wp bit if uffd fork event is not
> > > enabled.  Detect that to avoid _PAGE_UFFD_WP being set even if the VMA
> > > is not being tracked by VM_UFFD_WP.  Do this for both small PTEs and
> > > huge PMDs.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > 
> > This patch must be earlier in the serie, before the patch that introduce
> > the userfaultfd API so that bisect can not end up on version where this
> > can happen.
> 
> Yes it should be now? Since the API will be introduced until patch
> 21/26 ("userfaultfd: wp: add the writeprotect API to userfaultfd
> ioctl").

No i was confuse when reading this patch i had the feeling it was
after the ioctl ignore my comment.

> 
> > 
> > Otherwise the patch itself is:
> > 
> > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> 
> Unless I found anything I've missed above... I'll temporarily pick
> this R-b for now then.

It is fine, the patch ordering was my confusion.

Cheers,
Jérôme
