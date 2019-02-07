Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1496C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B4221904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfBGRCT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:02:19 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:58419 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbfBGRCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:02:14 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-141-nYivnlAcOrqQ7bOGiVEBbw-1; Thu, 07 Feb 2019 17:02:09 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 7 Feb 2019 17:02:52 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 7 Feb 2019 17:02:52 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Derek Robson' <robsonde@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] aout: incorrct use of strncpy fixed.
Thread-Topic: [PATCH] aout: incorrct use of strncpy fixed.
Thread-Index: AQHUupHMiLEkETxgzUKWAVSQWpeIzqXUmBFQ
Date:   Thu, 7 Feb 2019 17:02:52 +0000
Message-ID: <79884abb973a4116a16e940db66c6e28@AcuMS.aculab.com>
References: <20190202005512.3144-1-robsonde@gmail.com>
In-Reply-To: <20190202005512.3144-1-robsonde@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: nYivnlAcOrqQ7bOGiVEBbw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Derek Robson
> Sent: 02 February 2019 00:55
> 
> Found a bug with the source / dest length
> updated to have size limit as the size of dest not size or source.
> 
> Signed-off-by: Derek Robson <robsonde@gmail.com>
> ---
>  arch/x86/ia32/ia32_aout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
> index f65b78d32f5e..1e7f71723ee0 100644
> --- a/arch/x86/ia32/ia32_aout.c
> +++ b/arch/x86/ia32/ia32_aout.c
> @@ -157,7 +157,7 @@ static int aout_core_dump(struct coredump_params *cprm)
>  	fs = get_fs();
>  	set_fs(KERNEL_DS);
>  	has_dumped = 1;
> -	strncpy(dump.u_comm, current->comm, sizeof(current->comm));
> +	strncpy(dump.u_comm, current->comm, sizeof(dump.u_comm));

That can be right if the destination is guaranteed to be longer than
the source and the source might not be '\0' terminated
(and the target has been zeroed).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

