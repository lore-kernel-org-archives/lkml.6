Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46861C5CFC1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B9C208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B9C208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754534AbeFRC2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 22:28:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754440AbeFRC2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 22:28:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFDE57D654;
        Mon, 18 Jun 2018 02:28:49 +0000 (UTC)
Received: from redhat.com (ovpn-121-19.rdu2.redhat.com [10.10.121.19])
        by smtp.corp.redhat.com (Postfix) with SMTP id 310E2111DCF0;
        Mon, 18 Jun 2018 02:28:43 +0000 (UTC)
Date:   Mon, 18 Jun 2018 05:28:43 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        "riel@redhat.com" <riel@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v33 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Message-ID: <20180618051637-mutt-send-email-mst@kernel.org>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <1529037793-35521-3-git-send-email-wei.w.wang@intel.com>
 <20180615144000-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396A3D04@shsmsx102.ccr.corp.intel.com>
 <20180615171635-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396A5CB0@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F7396A5CB0@shsmsx102.ccr.corp.intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 18 Jun 2018 02:28:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 18 Jun 2018 02:28:49 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 01:09:44AM +0000, Wang, Wei W wrote:
> On Friday, June 15, 2018 10:29 PM, Michael S. Tsirkin wrote:
> > On Fri, Jun 15, 2018 at 02:11:23PM +0000, Wang, Wei W wrote:
> > > On Friday, June 15, 2018 7:42 PM, Michael S. Tsirkin wrote:
> > > > On Fri, Jun 15, 2018 at 12:43:11PM +0800, Wei Wang wrote:
> > > > > Negotiation of the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature
> > > > > indicates the support of reporting hints of guest free pages to host via
> > virtio-balloon.
> > > > >
> > > > > Host requests the guest to report free page hints by sending a
> > > > > command to the guest via setting the
> > > > VIRTIO_BALLOON_HOST_CMD_FREE_PAGE_HINT
> > > > > bit of the host_cmd config register.
> > > > >
> > > > > As the first step here, virtio-balloon only reports free page
> > > > > hints from the max order (10) free page list to host. This has
> > > > > generated similar good results as reporting all free page hints during
> > our tests.
> > > > >
> > > > > TODO:
> > > > > - support reporting free page hints from smaller order free page lists
> > > > >   when there is a need/request from users.
> > > > >
> > > > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > > > Signed-off-by: Liang Li <liang.z.li@intel.com>
> > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > > Cc: Michal Hocko <mhocko@kernel.org>
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > ---
> > > > >  drivers/virtio/virtio_balloon.c     | 187
> > +++++++++++++++++++++++++++++--
> > > > -----
> > > > >  include/uapi/linux/virtio_balloon.h |  13 +++
> > > > >  2 files changed, 163 insertions(+), 37 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_balloon.c
> > > > > b/drivers/virtio/virtio_balloon.c index 6b237e3..582a03b 100644
> > > > > --- a/drivers/virtio/virtio_balloon.c
> > > > > +++ b/drivers/virtio/virtio_balloon.c
> > > > > @@ -43,6 +43,9 @@
> > > > >  #define OOM_VBALLOON_DEFAULT_PAGES 256  #define
> > > > > VIRTBALLOON_OOM_NOTIFY_PRIORITY 80
> > > > >
> > > > > +/* The size of memory in bytes allocated for reporting free page
> > > > > +hints */ #define FREE_PAGE_HINT_MEM_SIZE (PAGE_SIZE * 16)
> > > > > +
> > > > >  static int oom_pages = OOM_VBALLOON_DEFAULT_PAGES;
> > > > > module_param(oom_pages, int, S_IRUSR | S_IWUSR);
> > > > > MODULE_PARM_DESC(oom_pages, "pages to free on OOM");
> > > >
> > > > Doesn't this limit memory size of the guest we can report?
> > > > Apparently to several gigabytes ...
> > > > OTOH huge guests with lots of free memory is exactly where we would
> > > > gain the most ...
> > >
> > > Yes, the 16-page array can report up to 32GB (each page can hold 512
> > addresses of 4MB free page blocks, i.e. 2GB free memory per page) free
> > memory to host. It is not flexible.
> > >
> > > How about allocating the buffer according to the guest memory size
> > > (proportional)? That is,
> > >
> > > /* Calculates the maximum number of 4MB (equals to 1024 pages) free
> > > pages blocks that the system can have */ 4m_page_blocks =
> > > totalram_pages / 1024;
> > >
> > > /* Allocating one page can hold 512 free page blocks, so calculates
> > > the number of pages that can hold those 4MB blocks. And this
> > > allocation should not exceed 1024 pages */ pages_to_allocate =
> > > min(4m_page_blocks / 512, 1024);
> > >
> > > For a 2TB guests, which has 2^19 page blocks (4MB each), we will allocate
> > 1024 pages as the buffer.
> > >
> > > When the guest has large memory, it should be easier to succeed in
> > allocation of large buffer. If that allocation fails, that implies that nothing
> > would be got from the 4MB free page list.
> > >
> > > I think the proportional allocation is simpler compared to other
> > > approaches like
> > > - scattered buffer, which will complicate the get_from_free_page_list
> > > implementation;
> > > - one buffer to call get_from_free_page_list multiple times, which needs
> > get_from_free_page_list to maintain states.. also too complicated.
> > >
> > > Best,
> > > Wei
> > >
> > 
> > That's more reasonable, but question remains what to do if that value
> > exceeds MAX_ORDER. I'd say maybe tell host we can't report it.
> 
> Not necessarily, I think. We have min(4m_page_blocks / 512, 1024) above, so the maximum memory that can be reported is 2TB. For larger guests, e.g. 4TB, the optimization can still offer 2TB free memory (better than no optimization).

Maybe it's better, maybe it isn't. It certainly muddies the waters even
more.  I'd rather we had a better plan. From that POV I like what
Matthew Wilcox suggested for this which is to steal the necessary #
of entries off the list.

If that doesn't fly, we can allocate out of the loop and just retry with more
pages.

> On the other hand, large guests being large mostly because the guests need to use large memory. In that case, they usually won't have that much free memory to report.

And following this logic small guests don't have a lot of memory to report at all.
Could you remind me why are we considering this optimization then?

> > 
> > Also allocating it with GFP_KERNEL is out. You only want to take it off the free
> > list. So I guess __GFP_NOMEMALLOC and __GFP_ATOMIC.
> 
> Sounds good, thanks.
> 
> > Also you can't allocate this on device start. First totalram_pages can change.
> > Second that's too much memory to tie up forever.
> 
> Yes, makes sense.
> 
> Best,
> Wei
