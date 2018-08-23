Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FF0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9427E2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="lQo1ptKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9427E2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbeHWQWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:22:40 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60650 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbeHWQWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:22:40 -0400
Date:   Thu, 23 Aug 2018 14:52:57 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: RE: [PATCH 3/4] memory: jz4780-nemc: Reduce size of const array
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alex Smith <alex@alex-smith.me.uk>, "od@zcrc.me" <od@zcrc.me>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <1535028777.27779.1@crapouillou.net>
In-Reply-To: <b8fdca29afcb48aa9ee33cc896c24e66@AcuMS.aculab.com>
References: <20180822172953.11281-1-paul@crapouillou.net>
        <20180822172953.11281-3-paul@crapouillou.net>
        <b8fdca29afcb48aa9ee33cc896c24e66@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535028781; bh=OdQWYeBO4PFFPaGdwc/B2Bq5zKDkqx2x0CZlkBEXH4g=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=lQo1ptKQxSdCFNRR6GENPzbSjACc6alIY0tfD3XQI/t/jx/+FKq679ppw5ilQFHjifh7zKyhtIXFd63DwvKrZIhGEgJPTwyxQBoDO5he/5Jf7QZmGgpmXd2sFXgRU+q2YcF03ALspuM5o0MpYf2iWLS/I8NIi7sg8LEojJZl0Yc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Le jeu. 23 ao=FBt 2018 =E0 12:41, David Laight <David.Laight@ACULAB.COM>=20
a =E9crit :
> From: Paul Cercueil
>>  Sent: 22 August 2018 18:30
>>  The maximum value found in that array is 15, there's no need to=20
>> store
>>  these values as uint32_t, a uint8_t is enough.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/memory/jz4780-nemc.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>>  diff --git a/drivers/memory/jz4780-nemc.c=20
>> b/drivers/memory/jz4780-nemc.c
>>  index bcf06adefc96..ef3f20e46590 100644
>>  --- a/drivers/memory/jz4780-nemc.c
>>  +++ b/drivers/memory/jz4780-nemc.c
>>  @@ -161,7 +161,7 @@ static bool jz4780_nemc_configure_bank(struct=20
>> jz4780_nemc *nemc,
>>   	 * Conversion of tBP and tAW cycle counts to values supported by=20
>> the
>>   	 * hardware (round up to the next supported value).
>>   	 */
>>  -	static const uint32_t convert_tBP_tAW[] =3D {
>>  +	static const u8 convert_tBP_tAW[] =3D {
>>   		0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
>>=20
>>   		/* 11 - 12 -> 12 cycles */
>>  @@ -232,7 +232,7 @@ static bool jz4780_nemc_configure_bank(struct=20
>> jz4780_nemc *nemc,
>>   			return false;
>>   		}
>>=20
>>  -		smcr |=3D convert_tBP_tAW[cycles] << NEMC_SMCR_TBP_SHIFT;
>>  +		smcr |=3D (u32)convert_tBP_tAW[cycles] << NEMC_SMCR_TBP_SHIFT;
>=20
> You don't need the cast here.

OK, I will remove them in V2.

>=20
> 	David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,=20
> MK1 1PT, UK
> Registration No: 1397386 (Wales)
>=20
=

