Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77E4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE8D21545
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE8D21545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbeHWOJP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:09:15 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:21760 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbeHWOJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:09:15 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-178-Lt8sPUcmNSq49cQNeoTuCw-1; Thu, 23 Aug 2018 11:40:06 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 23 Aug 2018 11:41:45 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 23 Aug 2018 11:41:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Paul Cercueil' <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alex Smith <alex@alex-smith.me.uk>
CC:     "od@zcrc.me" <od@zcrc.me>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] memory: jz4780-nemc: Reduce size of const array
Thread-Topic: [PATCH 3/4] memory: jz4780-nemc: Reduce size of const array
Thread-Index: AQHUOj4EIukyGz/Bhk+HU4+qNy5vHaTNJydA
Date:   Thu, 23 Aug 2018 10:41:45 +0000
Message-ID: <b8fdca29afcb48aa9ee33cc896c24e66@AcuMS.aculab.com>
References: <20180822172953.11281-1-paul@crapouillou.net>
 <20180822172953.11281-3-paul@crapouillou.net>
In-Reply-To: <20180822172953.11281-3-paul@crapouillou.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: Lt8sPUcmNSq49cQNeoTuCw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil
> Sent: 22 August 2018 18:30
> The maximum value found in that array is 15, there's no need to store
> these values as uint32_t, a uint8_t is enough.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/memory/jz4780-nemc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
> index bcf06adefc96..ef3f20e46590 100644
> --- a/drivers/memory/jz4780-nemc.c
> +++ b/drivers/memory/jz4780-nemc.c
> @@ -161,7 +161,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
>  	 * Conversion of tBP and tAW cycle counts to values supported by the
>  	 * hardware (round up to the next supported value).
>  	 */
> -	static const uint32_t convert_tBP_tAW[] = {
> +	static const u8 convert_tBP_tAW[] = {
>  		0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
> 
>  		/* 11 - 12 -> 12 cycles */
> @@ -232,7 +232,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
>  			return false;
>  		}
> 
> -		smcr |= convert_tBP_tAW[cycles] << NEMC_SMCR_TBP_SHIFT;
> +		smcr |= (u32)convert_tBP_tAW[cycles] << NEMC_SMCR_TBP_SHIFT;

You don't need the cast here.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

