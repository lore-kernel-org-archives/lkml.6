Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB7FECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD9020827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD9020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeKHXtv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:49:51 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33476 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbeKHXtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:49:51 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id
 uk-mta-170-YmVjI1zYPXiXgm4h7P2Yug-1; Thu, 08 Nov 2018 14:14:08 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 8 Nov 2018 14:14:14 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 8 Nov 2018 14:14:13 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>
CC:     'Martin Steigerwald' <martin@lichtvoll.de>,
        Michal Hocko <mhocko@kernel.org>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v2] Document /proc/pid PID reuse behavior
Thread-Topic: [PATCH v2] Document /proc/pid PID reuse behavior
Thread-Index: AQHUdrwX3PD+XlfhcUeFEtVp7YMP66VFxCRggAALTYCAABOvMIAACBKAgAAA+qA=
Date:   Thu, 8 Nov 2018 14:14:13 +0000
Message-ID: <c022428101b54a4d9522cd9c5b479379@AcuMS.aculab.com>
References: <20181031150625.147369-1-dancol@google.com>
 <CAKOZueu5aDtHDBzp6qKECTHEejjb=dyegQkuHh8NfwgNktzFow@mail.gmail.com>
 <20181107160015.GI27423@dhcp22.suse.cz> <4536090.43ZsV6LvYe@merkaba>
 <0c5610f128fa49fb9d8f7859e6f61b90@AcuMS.aculab.com>
 <20181108122747.GM3074@bombadil.infradead.org>
 <47072118046a450b904556ca8154f5c9@AcuMS.aculab.com>
 <20181108140707.GO3074@bombadil.infradead.org>
In-Reply-To: <20181108140707.GO3074@bombadil.infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: YmVjI1zYPXiXgm4h7P2Yug-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox
> Sent: 08 November 2018 14:07
...
> 
> You'd be looking for something like dynamic perfect hashing then?
> I think that'd make a great project for someone to try out.  I don't
> have the time to look into it myself, and I'm not convinced there's
> a real workload that would benefit.  But it'd be a great project for
> a university student.

Been there, done that several times.
Half an afternoon's work.

I'm surprised there isn't a C++ container class that will give
you a 'id' for a pointer (or other large value).
But they all do it the other way around.

It is also trivial to double the size of the array and 'unzip'
the allocated items into their correct halves while adding the
other entry to the free list.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

