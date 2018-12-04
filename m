Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3031C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4702082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4702082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeLDRKX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:10:23 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:47846 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726367AbeLDRKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:10:23 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-130-lQ7aur7HOVqDgSvQvocyiA-1; Tue, 04 Dec 2018 17:10:19 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 4 Dec 2018 17:10:28 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 4 Dec 2018 17:10:28 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'john.hubbard@gmail.com'" <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Jan Kara <jack@suse.cz>, Tom Talpey <tom@talpey.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: RE: [PATCH 0/2] put_user_page*(): start converting the call sites
Thread-Topic: [PATCH 0/2] put_user_page*(): start converting the call sites
Thread-Index: AQHUi2bDGCD6zYfsq0K8yN3qDVFoEKVu0VeA
Date:   Tue, 4 Dec 2018 17:10:28 +0000
Message-ID: <b31c7b3359344e778fc525013eeece64@AcuMS.aculab.com>
References: <20181204001720.26138-1-jhubbard@nvidia.com>
In-Reply-To: <20181204001720.26138-1-jhubbard@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: lQ7aur7HOVqDgSvQvocyiA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: john.hubbard@gmail.com
> Sent: 04 December 2018 00:17
> 
> Summary: I'd like these two patches to go into the next convenient cycle.
> I *think* that means 4.21.
> 
> Details
> 
> At the Linux Plumbers Conference, we talked about this approach [1], and
> the primary lingering concern was over performance. Tom Talpey helped me
> through a much more accurate run of the fio performance test, and now
> it's looking like an under 1% performance cost, to add and remove pages
> from the LRU (this is only paid when dealing with get_user_pages) [2]. So
> we should be fine to start converting call sites.
> 
> This patchset gets the conversion started. Both patches already had a fair
> amount of review.

Shouldn't the commit message contain actual details of the change?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

