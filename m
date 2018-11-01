Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E0BC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AA8204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26AA8204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeKAUtB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:49:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:40485 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728326AbeKAUtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:49:01 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id
 uk-mta-152-Sf1JNgLxPSangJz-2cF3_w-1; Thu, 01 Nov 2018 11:46:22 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 1 Nov 2018 11:46:25 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 1 Nov 2018 11:46:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nathan Chancellor' <natechancellor@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pinctrl: generic: Avoid several implicit enum conversions
Thread-Topic: [PATCH] pinctrl: generic: Avoid several implicit enum
 conversions
Thread-Index: AQHUcXZfWFF0ThpGY0mJcH0ZoW+pwqU6zXsA
Date:   Thu, 1 Nov 2018 11:46:25 +0000
Message-ID: <2ddee1f762ab404a8acc8ce05c96da78@AcuMS.aculab.com>
References: <20180925061855.19557-1-natechancellor@gmail.com>
 <CACRpkdadODxsuae7uhwcfBBMQ-eZ8bvnV71fhDCuudbJEbhhYA@mail.gmail.com>
 <20180925161459.GA15840@flashbox>
 <CAKwvOdkh0rqWcw4r7Y=Ki_MNJPoJNnvm3uGp4Q726PaESxZAnQ@mail.gmail.com>
 <20181025210456.GA14792@flashbox>
 <CACRpkda9LhdQybgci8gYs13L5pHWvDx43_Ftn5s+ERLLFPvLjQ@mail.gmail.com>
 <20181101000338.GA32577@flashbox>
In-Reply-To: <20181101000338.GA32577@flashbox>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: Sf1JNgLxPSangJz-2cF3_w-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor
> Sent: 01 November 2018 00:04
...
> > A slightly lesser evil variant is to add a few PIN_CONFIG_CUSTOM_1
> > PIN_CONFIG_CUSTOM_2 etc at the end of the enum and just
> > #define MY_CONFIG PIN_CONFIG_CUSTOM_1
> > in all drivers that use these.
> >
> 
> Some drivers actually just define their pin config params like:
> 
> #define VAR (PIN_CONFIG_END + 1)

You probably want to add 'custom' definitions after PIN_CONFIG_END
so that a future compiler versions doesn't generate an error
because (PIN_CONFIG_END + 1) isn't a valid value for the enum.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

