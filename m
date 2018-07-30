Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAB1FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9097B20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9097B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeG3KbX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:31:23 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:52038 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbeG3KbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:31:23 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-116-VjCxFj2rNcKUzMeAa31yiA-1; Mon, 30 Jul 2018 09:57:22 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 30 Jul 2018 09:59:01 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 30 Jul 2018 09:59:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Machek' <pavel@ucw.cz>, Kees Cook <keescook@chromium.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: RE: [PATCH v2] net: dsa: Remove VLA usage
Thread-Topic: [PATCH v2] net: dsa: Remove VLA usage
Thread-Index: AQHUJzEjE1REXOCsp0es6llOklBVg6Snd8Qw
Date:   Mon, 30 Jul 2018 08:59:01 +0000
Message-ID: <6e5b57f59ca6420489d65392a1e8dbc8@AcuMS.aculab.com>
References: <20180717041034.GA37382@beast> <20180729113806.GC7333@amd>
 <20180729114006.GA11104@amd>
In-Reply-To: <20180729114006.GA11104@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: VjCxFj2rNcKUzMeAa31yiA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek
> Sent: 29 July 2018 12:40
...
> > > +	unsigned long		*bitmap;
> > > +	unsigned long		_bitmap;
> >
> > This looks rather confusing. _bitmap -> bitmap_data? bitmap_bits?
> 
> Actually, AFAICT that long is not used as a long, but as array of
> bits. So maybe char bitmap_data[8] would be more appropriate?

Unfortunately the 'bitmap' functions are defined to work in a 
specific way on unsigned long[].
This means, for example, that they can't use the x86 'bit' instructions.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

