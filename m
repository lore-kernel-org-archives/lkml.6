Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E0AA3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B28208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B28208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936330AbeFOOL3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:11:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:51487 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932360AbeFOOL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:11:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 07:11:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,227,1526367600"; 
   d="scan'208";a="237753276"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2018 07:11:26 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 15 Jun 2018 07:11:26 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 15 Jun 2018 07:11:25 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.223]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.116]) with mapi id 14.03.0319.002;
 Fri, 15 Jun 2018 22:11:24 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
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
Subject: RE: [PATCH v33 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Thread-Topic: [PATCH v33 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Thread-Index: AQHUBGb1uIuE7GdLXUGMzLE4+zixk6RgrO+AgACbr0A=
Date:   Fri, 15 Jun 2018 14:11:23 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396A3D04@shsmsx102.ccr.corp.intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <1529037793-35521-3-git-send-email-wei.w.wang@intel.com>
 <20180615144000-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180615144000-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWZjN2JlMTQtYWZlYy00MTZjLWJiNDItZjc4YzliZTA5MjY5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieURsMUJOZElOamhUdGh5MWgzMEI3M0VZb3o3U09FUmQxNU1tZGJFaFFHQzNIeUY4XC9cL3plb0NjOGhcL254dmkycyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 15, 2018 7:42 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 15, 2018 at 12:43:11PM +0800, Wei Wang wrote:
> > Negotiation of the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature indicates
> > the support of reporting hints of guest free pages to host via virtio-balloon.
> >
> > Host requests the guest to report free page hints by sending a command
> > to the guest via setting the
> VIRTIO_BALLOON_HOST_CMD_FREE_PAGE_HINT
> > bit of the host_cmd config register.
> >
> > As the first step here, virtio-balloon only reports free page hints
> > from the max order (10) free page list to host. This has generated
> > similar good results as reporting all free page hints during our tests.
> >
> > TODO:
> > - support reporting free page hints from smaller order free page lists
> >   when there is a need/request from users.
> >
> > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > Signed-off-by: Liang Li <liang.z.li@intel.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  drivers/virtio/virtio_balloon.c     | 187 +++++++++++++++++++++++++++++--
> -----
> >  include/uapi/linux/virtio_balloon.h |  13 +++
> >  2 files changed, 163 insertions(+), 37 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c
> > b/drivers/virtio/virtio_balloon.c index 6b237e3..582a03b 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -43,6 +43,9 @@
> >  #define OOM_VBALLOON_DEFAULT_PAGES 256  #define
> > VIRTBALLOON_OOM_NOTIFY_PRIORITY 80
> >
> > +/* The size of memory in bytes allocated for reporting free page
> > +hints */ #define FREE_PAGE_HINT_MEM_SIZE (PAGE_SIZE * 16)
> > +
> >  static int oom_pages = OOM_VBALLOON_DEFAULT_PAGES;
> > module_param(oom_pages, int, S_IRUSR | S_IWUSR);
> > MODULE_PARM_DESC(oom_pages, "pages to free on OOM");
> 
> Doesn't this limit memory size of the guest we can report?
> Apparently to several gigabytes ...
> OTOH huge guests with lots of free memory is exactly where we would gain
> the most ...

Yes, the 16-page array can report up to 32GB (each page can hold 512 addresses of 4MB free page blocks, i.e. 2GB free memory per page) free memory to host. It is not flexible.

How about allocating the buffer according to the guest memory size (proportional)? That is,

/* Calculates the maximum number of 4MB (equals to 1024 pages) free pages blocks that the system can have */
4m_page_blocks = totalram_pages / 1024;

/* Allocating one page can hold 512 free page blocks, so calculates the number of pages that can hold those 4MB blocks. And this allocation should not exceed 1024 pages */
pages_to_allocate = min(4m_page_blocks / 512, 1024);

For a 2TB guests, which has 2^19 page blocks (4MB each), we will allocate 1024 pages as the buffer.

When the guest has large memory, it should be easier to succeed in allocation of large buffer. If that allocation fails, that implies that nothing would be got from the 4MB free page list.

I think the proportional allocation is simpler compared to other approaches like 
- scattered buffer, which will complicate the get_from_free_page_list implementation;
- one buffer to call get_from_free_page_list multiple times, which needs get_from_free_page_list to maintain states.. also too complicated.

Best,
Wei



