Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCC8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCA2222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438057AbfBNJuA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:50:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:53587 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403789AbfBNJuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:50:00 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-46-4jO5EVMhMMeOIp4H3WdmnA-1; Thu, 14 Feb 2019 09:49:56 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 14 Feb 2019 09:50:39 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 14 Feb 2019 09:50:39 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Tobin C. Harding'" <me@tobin.cc>
CC:     "'Tobin C. Harding'" <tobin@kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Tycho Andersen <tycho@tycho.ws>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] leaking_addresses: Expand tilde in output file name
Thread-Topic: [PATCH 3/3] leaking_addresses: Expand tilde in output file name
Thread-Index: AQHUvze0635TNBS/ZEmpDgH2942+BqXd6ssggABMtYCAAN7TwA==
Date:   Thu, 14 Feb 2019 09:50:39 +0000
Message-ID: <f775f497043e4e88a23a980c23d744b1@AcuMS.aculab.com>
References: <20190207225026.11723-1-tobin@kernel.org>
 <20190207225026.11723-4-tobin@kernel.org>
 <6aed136f16e8451dbcfa97f90c04438f@AcuMS.aculab.com>
 <20190213203033.GB31743@eros.localdomain>
In-Reply-To: <20190213203033.GB31743@eros.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 4jO5EVMhMMeOIp4H3WdmnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobin C. Harding
> Sent: 13 February 2019 20:31
> 
> On Wed, Feb 13, 2019 at 03:56:47PM +0000, David Laight wrote:
> > From: Tobin C. Harding
> > > Sent: 07 February 2019 22:50
> > >
> > > Currently if user passes an output file to the script via
> > > --output-raw we do not handle expansion of tilde.
> > >
> > > Use perl function glob() to expand tilde in output file name.
> >
> > What happens if glob() returns multiple files?
> > I'm guessing that it can...
> 
> Thanks for taking a look at this David.  Surely glob() cannot return
> multiple values when expanding tilde?  If someone passes a '*' into the
> command as an input/output file then they are clearly mad :)

Yes, but the perl script will go horribly wrong.

Actually, how do they get a ~ in there?
Whatever shell generated perl's argv[] would be expected to handle it.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

