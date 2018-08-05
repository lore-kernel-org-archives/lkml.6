Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C73C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F022170D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F022170D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeHEWon convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:44:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:30704 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbeHEWon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:44:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2018 13:38:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,449,1526367600"; 
   d="scan'208";a="77679024"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2018 13:38:34 -0700
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 5 Aug 2018 13:38:33 -0700
Received: from hasmsx111.ger.corp.intel.com (10.184.198.39) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 5 Aug 2018 13:38:33 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.74]) by
 HASMSX111.ger.corp.intel.com ([169.254.5.49]) with mapi id 14.03.0319.002;
 Sun, 5 Aug 2018 23:38:31 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next 06/12] mei: dma ring buffers allocation
Thread-Topic: [char-misc-next 06/12] mei: dma ring buffers allocation
Thread-Index: AQHUKjltDKYvISzkK0S9cPf5ayuMQKSsHpuggAACJHA=
Date:   Sun, 5 Aug 2018 20:38:30 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D97F93D@hasmsx108.ger.corp.intel.com>
References: <20180731063544.25540-1-tomas.winkler@intel.com>
 <20180731063544.25540-7-tomas.winkler@intel.com>
 <20180802081809.GA8969@kroah.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjk5ODM0NTUtNzZiZC00NzgzLWJhODMtNGIxZjNjNzdmZDIyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMW5UWG5RXC9LekV2QzJqaW5Mc21NZG52K0FuNGtCYzdkZ2hNTFNuVHRjeEVhOHhYM3d2UmxWQVBHdVJVa3JuMjUifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.252.10.236]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: RE: [char-misc-next 06/12] mei: dma ring buffers allocation
> 
> 
> > On Tue, Jul 31, 2018 at 09:35:38AM +0300, Tomas Winkler wrote:
> > > --- /dev/null
> > > +++ b/drivers/misc/mei/dma-ring.c
> > > @@ -0,0 +1,103 @@
> > > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> >
> > I thought Intel was not doing this type of crazy nonsense anymore and
> > just properly creating new files that were GPL-2.0.
> >
> > Are you _sure_ you want to do this?
I would prefer to keep it that way actually,  hoping eventually relicense most of the files in the driver under the dual license, 
currently it's really kind of mix. 
I'm not sure where this was discussed before, so you've surprised me with this comment.
There is no hidden agenda behind this move, just let the BSD and virtualization world look at the code more freely we have quite a gap there.

Thanks
Tomas

