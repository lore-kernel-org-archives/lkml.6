Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D5AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D631321749
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D631321749
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeHMQbh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:31:37 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:28209 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729031AbeHMQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:31:36 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-3-9DGzGHwIPAaxmVITDc-rAQ-1; Mon, 13 Aug 2018 14:49:11 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 13 Aug 2018 14:50:50 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 13 Aug 2018 14:50:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Jeff Lien' <jeff.lien@wdc.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-crypto@vger.kernel.org'" <linux-crypto@vger.kernel.org>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
CC:     "'herbert@gondor.apana.org.au'" <herbert@gondor.apana.org.au>,
        "'tim.c.chen@linux.intel.com'" <tim.c.chen@linux.intel.com>,
        "'martin.petersen@oracle.com'" <martin.petersen@oracle.com>,
        "'david.darrington@wdc.com'" <david.darrington@wdc.com>,
        "'jeff.furlong@wdc.com'" <jeff.furlong@wdc.com>
Subject: RE: [PATCH] Performance Improvement in CRC16 Calculations.
Thread-Topic: [PATCH] Performance Improvement in CRC16 Calculations.
Thread-Index: AQHUMN5vktn+vtPDWUaxGdn9R1jbpaS9kfkwgAAla0A=
Date:   Mon, 13 Aug 2018 13:50:50 +0000
Message-ID: <73795193e598470188953bab268e7af6@AcuMS.aculab.com>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
 <8508c92d70dc41ffb66557e13c988dca@AcuMS.aculab.com>
In-Reply-To: <8508c92d70dc41ffb66557e13c988dca@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: 9DGzGHwIPAaxmVITDc-rAQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A more interesting version would be to generate the lookup table
> for a byte followed by 3 zero bytes.
> You could then run four separate register dependency chains using the
> same 256 entry lookup table.

Not sure that works with a table lookup :-(

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

