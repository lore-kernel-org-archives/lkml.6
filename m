Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66F3C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95211208A0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95211208A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbeG0LlQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:41:16 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:40621 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730244AbeG0LlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:41:15 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-96-CY0F_BACMpiGhIxL7VMmiw-1; Fri, 27 Jul 2018 11:19:58 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 27 Jul 2018 11:21:37 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 27 Jul 2018 11:21:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] checkpatch: check for function calls with struct or
 union on stack
Thread-Topic: [RFC PATCH] checkpatch: check for function calls with struct or
 union on stack
Thread-Index: AQHUJRcFUx4+BuOgSky66zuZVVqB+6Si1nhw///yOQCAABM5YA==
Date:   Fri, 27 Jul 2018 10:21:37 +0000
Message-ID: <9f0377fa74bd4964912ba5a4fc76526d@AcuMS.aculab.com>
References: <1236369d28b2f1f5389ff652c4eb89e699e6481e.camel@perches.com>
         <20180726122533.104f6eea950853ef50ebc680@linux-foundation.org>
         <20180726122807.fad0566951e36d930edb6874@linux-foundation.org>
         <9d7441a14897426f8ed5befe8da0cad3@AcuMS.aculab.com>
 <0a6d2ecfacf3786228de664c8e01f6de10314c1b.camel@perches.com>
In-Reply-To: <0a6d2ecfacf3786228de664c8e01f6de10314c1b.camel@perches.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: CY0F_BACMpiGhIxL7VMmiw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches
> Sent: 27 July 2018 11:09
> On Fri, 2018-07-27 at 10:04 +0000, David Laight wrote:
> > From: Andrew Morton
> > > Sent: 26 July 2018 20:28
> > > On Thu, 26 Jul 2018 12:25:33 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > > I'll give it a spin, see how noisy it is.
> > >
> > > Actually, I would prefer if the message, changelog and title
> > > used the term "passed by value".  It's a more familiar term
> > > and it is possible for a passed-by-value aggregate to in fact
> > > be passed in registers.
> >
> > You need to detect (and ignore) 'small' structures.
> 
> checkpatch is stupid and basically can't do that
> as it has no context other than the current line.
> 
> It would need a list of specific struct types to
> ignore.  Care to create and send that list to me?

Does it even have the type?
If it has the prototype it could ignore aggregates that
are marked 'const'.

At least we're not in the K&R days where missing out the
& got very confusing.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

