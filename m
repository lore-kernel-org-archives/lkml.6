Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA2C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368A7217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfBKVPA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:15:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:56354 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfBKVPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:15:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 13:14:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="scan'208";a="145995188"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2019 13:14:59 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 11 Feb 2019 13:14:58 -0800
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 11 Feb 2019 13:14:58 -0800
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.57]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.180]) with mapi id 14.03.0415.000;
 Mon, 11 Feb 2019 15:14:56 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH 0/3] Add gup fast + longterm and use it in HFI1
Thread-Topic: [PATCH 0/3] Add gup fast + longterm and use it in HFI1
Thread-Index: AQHUwkbGJiw3VF3kpESe1yhfT7MilqXbdCyA//+kDNA=
Date:   Mon, 11 Feb 2019 21:14:56 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E79BCF04C@CRSMSX101.amr.corp.intel.com>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190211204049.GB2771@ziepe.ca>
In-Reply-To: <20190211204049.GB2771@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDFlNTkxMjgtNDFmNi00OWJhLWIxNDUtZmUwNDU4NzYzYjBhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQytYTmd4U0ErY3oyVTdaUEw3K3VoZjBEOHlcL0hmcWI0ZmlWXC9uRVhLNHRNZGlhbGNtSVJFaEhRa3JjN1wvSERYRCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Mon, Feb 11, 2019 at 12:16:40PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > NOTE: This series depends on my clean up patch to remove the write
> > parameter from gup_fast_permitted()[1]
> >
> > HFI1 uses get_user_pages_fast() due to it performance advantages.
> > Like RDMA,
> > HFI1 pages can be held for a significant time.  But
> > get_user_pages_fast() does not protect against mapping of FS DAX pages.
> 
> If HFI1 can use the _fast varient, can't all the general RDMA stuff use it too?
> 
> What is the guidance on when fast vs not fast should be use?

Right now it can't because it holds mmap_sem across the call.  Once Shiraz's patches are accepted removing the umem->hugetlb flag I think we can change  umem.c.

Also, it specifies FOLL_FORCE which can't currently be specified with gup fast.  One idea I had was to change get_user_pages_fast() to use gup_flags instead of a single write flag.  But that proved to be a very big cosmetic change across a lot of callers so I went this way.

Ira

> 
> Jason
