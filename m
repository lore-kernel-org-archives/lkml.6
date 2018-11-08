Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE36ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C732081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C732081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeKHXSN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:18:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:58772 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbeKHXSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:18:12 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id
 uk-mta-115-7KhyVomYNzueKujuIcXFdA-1; Thu, 08 Nov 2018 13:42:36 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 8 Nov 2018 13:42:41 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 8 Nov 2018 13:42:41 +0000
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
Thread-Index: AQHUdrwX3PD+XlfhcUeFEtVp7YMP66VFxCRggAALTYCAABOvMA==
Date:   Thu, 8 Nov 2018 13:42:41 +0000
Message-ID: <47072118046a450b904556ca8154f5c9@AcuMS.aculab.com>
References: <20181031150625.147369-1-dancol@google.com>
 <CAKOZueu5aDtHDBzp6qKECTHEejjb=dyegQkuHh8NfwgNktzFow@mail.gmail.com>
 <20181107160015.GI27423@dhcp22.suse.cz> <4536090.43ZsV6LvYe@merkaba>
 <0c5610f128fa49fb9d8f7859e6f61b90@AcuMS.aculab.com>
 <20181108122747.GM3074@bombadil.infradead.org>
In-Reply-To: <20181108122747.GM3074@bombadil.infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 7KhyVomYNzueKujuIcXFdA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox
> Sent: 08 November 2018 12:28
>
> On Thu, Nov 08, 2018 at 12:02:49PM +0000, David Laight wrote:
> > From: Martin Steigerwald
> > > Sent: 07 November 2018 17:05
> > ...
> > > Its not quite on-topic, but I am curious now: AFAIK PID limit is 16
> > > bits. Right? Could it be raised to 32 bits? I bet it would be a major
> > > change throughout different parts of the kernel.
> >
> > It is probably 15 bits (since -ve pid numbers are used for process groups).
> >
> > My guess is that userspace and the system call interface will handle 32bit
> > (signed) pid numbers.
> > (I don't remember 'linux emulation' being one of the emulations that
> > would truncate 32bit pids when one of the BDSs went to 32bit pids.)
> > The main problem will be that big numbers will mess up the alignment
> > of printouts from ps and top (etc).
> > This can be mitigated by only allocating 'big' numbers on systems
> > that have a lot of pids.
> > You also really want an O(1) allocator.
> 
> The allocator is O(log n) -- it's the IDR allocator, used in cyclic mode.
> n in this case is the highest ID which is still in use.  The tree is
> log_64(n) levels high.  It walks to the bottom of the tree and puts a
> pointer into the tree.  If the cursor has wrapped to the beginning of
> the tree, it may encounter a PID which is still in use; if it does,
> it does a bitmap scan of that node, and will then walk up the tree,
> doing a bitmap scan forward at each level until it finds a free PID.

Right, but you can choose the pid so that you get a perfect hash.
You can then put a FIFO free list through the unused entries of
the hash table (just an array).
Then pid allocate just picks the oldest free entry and ups the
high bits (that the hash masks out) to make the old value stale.
Almost no cache lines are involved in the whole operation.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

