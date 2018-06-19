Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAF5C5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3F82075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3F82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937190AbeFSBGx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:06:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:4843 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937125AbeFSBGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:06:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 18:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,241,1526367600"; 
   d="scan'208";a="58338136"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jun 2018 18:06:51 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 18 Jun 2018 18:06:51 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 18 Jun 2018 18:06:50 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.223]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.70]) with mapi id 14.03.0319.002;
 Tue, 19 Jun 2018 09:06:49 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "'Michael S. Tsirkin'" <mst@redhat.com>
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
Subject: RE: [virtio-dev] Re: [PATCH v33 2/4] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
Thread-Topic: [virtio-dev] Re: [PATCH v33 2/4] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
Thread-Index: AQHUBGb1uIuE7GdLXUGMzLE4+zixk6RgrO+AgACbr0D//5LxAIAAh+EwgANlzICAAQ0KgA==
Date:   Tue, 19 Jun 2018 01:06:48 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396AA10C@shsmsx102.ccr.corp.intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <1529037793-35521-3-git-send-email-wei.w.wang@intel.com>
 <20180615144000-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396A3D04@shsmsx102.ccr.corp.intel.com>
 <20180615171635-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396A5CB0@shsmsx102.ccr.corp.intel.com>
 <20180618051637-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180618051637-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWY2NzA0NDItOTM4YS00ZDg0LTg2YzUtZWFlMzY1ZGM5ZjhiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNFFRUnQyc045MnpxdlNiajVVZFpsb3lYdEQ4ak9wR1hrdFFSWUQwMjdGZDdtQ1Q4WlwvQk53eFVVYituRzRUT1MifQ==
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

On Monday, June 18, 2018 10:29 AM, Michael S. Tsirkin wrote:
> On Sat, Jun 16, 2018 at 01:09:44AM +0000, Wang, Wei W wrote:
> > Not necessarily, I think. We have min(4m_page_blocks / 512, 1024) above,
> so the maximum memory that can be reported is 2TB. For larger guests, e.g.
> 4TB, the optimization can still offer 2TB free memory (better than no
> optimization).
> 
> Maybe it's better, maybe it isn't. It certainly muddies the waters even more.
> I'd rather we had a better plan. From that POV I like what Matthew Wilcox
> suggested for this which is to steal the necessary # of entries off the list.

Actually what Matthew suggested doesn't make a difference here. That method always steal the first free page blocks, and sure can be changed to take more. But all these can be achieved via kmalloc by the caller which is more prudent and makes the code more straightforward. I think we don't need to take that risk unless the MM folks strongly endorse that approach.

The max size of the kmalloc-ed memory is 4MB, which gives us the limitation that the max free memory to report is 2TB. Back to the motivation of this work, the cloud guys want to use this optimization to accelerate their guest live migration. 2TB guests are not common in today's clouds. When huge guests become common in the future, we can easily tweak this API to fill hints into scattered buffer (e.g. several 4MB arrays passed to this API) instead of one as in this version.

This limitation doesn't cause any issue from functionality perspective. For the extreme case like a 100TB guest live migration which is theoretically possible today, this optimization helps skip 2TB of its free memory. This result is that it may reduce only 2% live migration time, but still better than not skipping the 2TB (if not using the feature).

So, for the first release of this feature, I think it is better to have the simpler and more straightforward solution as we have now, and clearly document why it can report up to 2TB free memory.


 
> If that doesn't fly, we can allocate out of the loop and just retry with more
> pages.
> 
> > On the other hand, large guests being large mostly because the guests need
> to use large memory. In that case, they usually won't have that much free
> memory to report.
> 
> And following this logic small guests don't have a lot of memory to report at
> all.
> Could you remind me why are we considering this optimization then?

If there is a 3TB guest, it is 3TB not 2TB mostly because it would need to use e.g. 2.5TB memory from time to time. In the worst case, it only has 0.5TB free memory to report, but reporting 0.5TB with this optimization is better than no optimization. (and the current 2TB limitation isn't a limitation for the 3TB guest in this case)

Best,
Wei
