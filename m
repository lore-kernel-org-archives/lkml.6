Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975B6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EE620823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EE620823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeKSWap convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:30:45 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:54492 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728660AbeKSWap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:30:45 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-169-kQSol00lMqGqmkexHxz3NQ-1; Mon, 19 Nov 2018 12:07:16 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 19 Nov 2018 12:07:16 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 19 Nov 2018 12:07:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Olof Johansson' <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: Explicitly mark 64-bit constant as unsigned long
Thread-Topic: [PATCH] arm64: Explicitly mark 64-bit constant as unsigned long
Thread-Index: AQHUfhiZwItjBBrszU+mUSyuKaet9KVXA/Iw
Date:   Mon, 19 Nov 2018 12:07:16 +0000
Message-ID: <51cf0f37dc694a858fcc422763f6ca72@AcuMS.aculab.com>
References: <20181117015456.101222-1-olof@lixom.net>
In-Reply-To: <20181117015456.101222-1-olof@lixom.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: kQSol00lMqGqmkexHxz3NQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olof Johansson
> Sent: 17 November 2018 01:55
...
> -#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffffffffffff
> +#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xfffffffffffffffful
>  #error "Inconsistent SCTLR_EL2 set/clear bits"
>  #endif

Wouldn't this be clearer if written:
	#if SCTLR_EL2_SET != ~SCTLR_EL2_CLEAR
which then begs the question of why there are separate 'set' and 'clear' masks.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

