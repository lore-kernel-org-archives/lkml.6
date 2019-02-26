Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6250C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFA5217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfBZHnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:43:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfBZHnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:43:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CE1F8666B;
        Tue, 26 Feb 2019 07:43:08 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3B585D9CC;
        Tue, 26 Feb 2019 07:42:59 +0000 (UTC)
Date:   Tue, 26 Feb 2019 15:42:57 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
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
Subject: Re: [PATCH v2 24/26] userfaultfd: wp: UFFDIO_REGISTER_MODE_WP
 documentation update
Message-ID: <20190226074257.GM13653@xz-x1>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-25-peterx@redhat.com>
 <20190225211930.GG10454@rapoport-lnx>
 <20190226065342.GJ13653@xz-x1>
 <20190226070307.GE5873@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226070307.GE5873@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 26 Feb 2019 07:43:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 09:04:25AM +0200, Mike Rapoport wrote:
> On Tue, Feb 26, 2019 at 02:53:42PM +0800, Peter Xu wrote:
> > On Mon, Feb 25, 2019 at 11:19:32PM +0200, Mike Rapoport wrote:
> > > On Tue, Feb 12, 2019 at 10:56:30AM +0800, Peter Xu wrote:
> > > > From: Martin Cracauer <cracauer@cons.org>
> > > > 
> > > > Adds documentation about the write protection support.
> > > > 
> > > > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > > > [peterx: rewrite in rst format; fixups here and there]
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > 
> > > Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > Peter, can you please also update the man pages (1, 2)?
> > > 
> > > [1] http://man7.org/linux/man-pages/man2/userfaultfd.2.html
> > > [2] http://man7.org/linux/man-pages/man2/ioctl_userfaultfd.2.html
> > 
> > Sure.  Should I post the man patches after the kernel part is merged?
> 
> Yep, once we know for sure what's the API kernel will expose.

I see, thanks.  Then I'll probably wait until the series got merged to
be safe since so far we still have discussion on the interfaces
(especially the DONTWAKE flags).

-- 
Peter Xu
