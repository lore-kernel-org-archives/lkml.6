Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBDAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBA2214DE
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBA2214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbeKUW3G convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:29:06 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:49517 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729391AbeKUW3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:29:06 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-156-3Rosp5WGPzWokpHn58AxCA-1; Wed, 21 Nov 2018 11:54:57 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 21 Nov 2018 11:55:04 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 21 Nov 2018 11:55:04 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jan Beulich' <JBeulich@suse.com>, "mingo@elte.hu" <mingo@elte.hu>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] x86: modernize sync_bitops.h
Thread-Topic: [PATCH v2] x86: modernize sync_bitops.h
Thread-Index: AQHUgYKYAz8XcFA8pkaOqgSV6G3YUKVaHKgQ
Date:   Wed, 21 Nov 2018 11:55:04 +0000
Message-ID: <92f590595593498eaa1f91a17875126f@AcuMS.aculab.com>
References: <5B30C2C302000078001CD6D1@prv1-mh.provo.novell.com>
 <5B30C2C302000000000FA99B@prv1-mh.provo.novell.com>
 <5B30C2C302000078001FE5A0@prv1-mh.provo.novell.com>
 <5BF52F4D02000078001FE5C1@prv1-mh.provo.novell.com>
In-Reply-To: <5BF52F4D02000078001FE5C1@prv1-mh.provo.novell.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 3Rosp5WGPzWokpHn58AxCA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Beulich
> Sent: 21 November 2018 10:11
> 
> Add missing insn suffixes and use rmwcc.h just like was (more or less)
> recently done for bitops.h as well.

Why? bts (etc) on memory don't really have an 'operand size'.
IIRC the suffix determines the width of the %cx register that selects the bit number.
I'd have to look up what the "Ir" constraint means.

IIRC the i386 book just said that the cpu might (aka will) read/write 4 bytes
surrounding the required byte.
More recent books say it does an aligned 4 byte read/write.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

