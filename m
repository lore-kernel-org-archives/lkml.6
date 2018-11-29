Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38F3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8B1206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8B1206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeK2XxI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:53:08 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:57543 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726949AbeK2XxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:53:08 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-120-AwjBjboGOSCCN_ZmRIyF1w-1; Thu, 29 Nov 2018 12:47:50 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 29 Nov 2018 12:47:59 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 29 Nov 2018 12:47:59 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jose Abreu' <jose.abreu@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "Vitor Soares" <vitor.soares@synopsys.com>
Subject: RE: [PATCH] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Topic: [PATCH] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Index: AQHUh+ESdH/rG0Kzu06tJT42U+4QdqVms3xQ
Date:   Thu, 29 Nov 2018 12:47:59 +0000
Message-ID: <f634eb3e39284e48923552a0c21562c6@AcuMS.aculab.com>
References: <bdcc49c9eab45bda6815b1419590943e603d8dc2.1543484040.git.joabreu@synopsys.com>
In-Reply-To: <bdcc49c9eab45bda6815b1419590943e603d8dc2.1543484040.git.joabreu@synopsys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: AwjBjboGOSCCN_ZmRIyF1w-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu
> Sent: 29 November 2018 12:42
> 
> Some ARC CPU's do not support unaligned loads/stores. Currently, generic
> implementation of reads{b/w/l}()/writes{b/w/l}() is being used with ARC.
> This can lead to misfunction of some drivers as generic functions do a
> plain dereference of a pointer that can be unaligned.
> 
> Let's use {get/put}_unaligned() helper instead of plain dereference of
> pointer in order to fix this.

Is it worth adding a check for the pointer being aligned?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

