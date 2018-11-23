Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559ADC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FEE20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FEE20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503549AbeKWVhV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:37:21 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:29247 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390373AbeKWVhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:37:21 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-99-GPDCUzThP7OsQ6S8j4J4iA-1; Fri, 23 Nov 2018 10:53:30 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 23 Nov 2018 10:53:37 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 23 Nov 2018 10:53:37 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vincent Chen' <vincentc@andestech.com>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nickhu <nickhu@andestech.com>
Subject: RE: [PATCH v4 2/5] nds32: Support FP emulation
Thread-Topic: [PATCH v4 2/5] nds32: Support FP emulation
Thread-Index: AQHUghG4/qfbmySOskGwd6CmLmV7sqVdK4Ig
Date:   Fri, 23 Nov 2018 10:53:37 +0000
Message-ID: <f0d20a4682b740659f28184c1278ae7d@AcuMS.aculab.com>
References: <1542856478-795-1-git-send-email-vincentc@andestech.com>
 <1542856478-795-3-git-send-email-vincentc@andestech.com>
In-Reply-To: <1542856478-795-3-git-send-email-vincentc@andestech.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: GPDCUzThP7OsQ6S8j4J4iA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen
> Sent: 22 November 2018 03:15
> 
> The Andes FPU coprocessor does not support denormalized number handling.
> According to the specification, FPU generates a denorm input exception
> that requires the kernel to deal with this instrution operation when it
> encounters denormalized operands. Hence an nds32 FPU ISA emulator in the
> kernel is required to meet requirement.

What does the FPU generate for results near zero?
If it doesn't generate denormalised results (but does detect them)
then I assume it never generates FP values with exponent zero.
(So the gap around zero is even larger than it would be if exponent
zero values had a hidden bit.)
So is it really worth doing anything other than treating
denormalised values as zero?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

