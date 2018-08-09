Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A88C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7BF21A8F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwKBsbfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7BF21A8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbeHIObW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:31:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42134 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbeHIObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:31:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id u202-v6so3908522lff.9;
        Thu, 09 Aug 2018 05:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XMcTrLv7g0UmMRXKzbazaRrzZ9y2Z6/KAhPIQuHwOEQ=;
        b=cwKBsbfO2r7Cc0PyicT3Fzq0iMoHeVFu6sFJnSGeJQbysS48xjCbfcfZ+EdmQtCMCD
         8VXLVlu9+w2NpAabl2Nmb+SMoq+GFxin6O364ub2IHlJzl/9+g3CskwsZpU4xmhMwPGW
         HIruE8XAFtQiWfLVkezTSKC3C77pL48CUsOgULeAZypMgQb5aa9lnW/13nleaeFkvE9e
         dfXkX0k5JW5KWJJ2qYoO2UC7pCi9UHT4rD+2md00MXtge7hZaFogbInZ9FZbAfwZLSAw
         VeXcZx5whY7d7gz/vMo9nK4vLKnmphGmDoHjcweZGhsHZ79nVNLYw7DPPFZDhKdIQnci
         0EAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XMcTrLv7g0UmMRXKzbazaRrzZ9y2Z6/KAhPIQuHwOEQ=;
        b=Q0iDzciiSTeXFAKYoKu3aU+PS1eczoWbOF1LRhBYLyiDsBY1BdbaUtSCaeUho6lgwQ
         j4SXI/gYr9L2WxsOH/eyhRkUDgn6Ia4p2tTaFMHb4wRoypNveq3TSN0Z8WvFKVbR350j
         JrlPlqnMaU3AAemyN8bzqpSUSuBwjgalFmMIv0XL78wbaWLPK/FmY4KtZ/Sg+pBngwBv
         dpwQiyPNj1JEJkrw5bTfjmK6aJkE7UMY6mbFgZUW7aI683aj/Fc76oFiaT5plyc34RDH
         qvJtUQUgsizxqpAslN2Yl1399kz1wanvuRfDOasTydzwXf6/TjR37Pr2+4CfRZqppPsA
         nnbA==
X-Gm-Message-State: AOUpUlEc8ubRMG7M6s0nR2zJHbKvmfrj3uno9ukvdsaVfONPoUt9EJPK
        mPlQoHEkjFTs9vPjlRr6OrI=
X-Google-Smtp-Source: AA+uWPyym6FQ6FmuiH1BpgQ7IQ8Qw5/fiw6smIMSSjv5MYk6NpU+F7AH5lbne2hYKGlfgZenCM801w==
X-Received: by 2002:a19:95c9:: with SMTP id x192-v6mr1390387lfd.37.1533816405622;
        Thu, 09 Aug 2018 05:06:45 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id 66-v6sm1136675ljz.8.2018.08.09.05.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:06:45 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yuan Yao <yao.yuan@freescale.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Phil Reid <preid@electromag.com.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Peter Rosin <peda@axentia.se>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] i2c: imx: Simplify stopped state tracking
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
        <20180709094304.8814-4-esben.haabendal@gmail.com>
        <20180724075919.iyysd7dtbddvbavq@pengutronix.de>
Date:   Thu, 09 Aug 2018 14:06:43 +0200
In-Reply-To: <20180724075919.iyysd7dtbddvbavq@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Tue, 24 Jul 2018 09:59:19
 +0200")
Message-ID: <87k1ozzquk.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> On Mon, Jul 09, 2018 at 11:43:03AM +0200, Esben Haabendal wrote:
>> From: Esben Haabendal <eha@deif.com>
>>=20
>> Always update the stopped state when busy status have been checked.
>> This is identical to what was done before, with the exception of error
>> handling.
>> Without this change, some errors cause the stopped state to be left in
>> incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read() and
>> i2c_imx_xfer().
>>=20
>> Signed-off-by: Esben Haabendal <eha@deif.com>
>> ---
>>  drivers/i2c/busses/i2c-imx.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>> index d86f152176a4..1db8e6790afc 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -421,10 +421,14 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct =
*i2c_imx, int for_busy)
>>  			return -EAGAIN;
>>  		}
>>=20=20
>> -		if (for_busy && (temp & I2SR_IBB))
>> +		if (for_busy && (temp & I2SR_IBB)) {
>> +			i2c_imx->stopped =3D 0;
>>  			break;
>> -		if (!for_busy && !(temp & I2SR_IBB))
>> +		}
>> +		if (!for_busy && !(temp & I2SR_IBB)) {
>> +			i2c_imx->stopped =3D 1;
>>  			break;
>> +		}
>
> Would it make sense to assign to ->stopped independent of for_busy?

What do you mean?

Assigning to ->stopped on each check for I2SR_IBB in loop, independent
of the for_busy argument?  I don't think so.  The additional assignments
would be to the same value as it is set to already.

>>  		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
>>  			dev_dbg(&i2c_imx->adapter.dev,
>>  				"<%s> I2C bus is busy\n", __func__);
>> @@ -538,7 +542,6 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_=
imx)
>>  	result =3D i2c_imx_bus_busy(i2c_imx, 1);
>>  	if (result)
>>  		return result;
>> -	i2c_imx->stopped =3D 0;
>>=20=20
>>  	temp |=3D I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
>>  	temp &=3D ~I2CR_DMAEN;
>> @@ -569,7 +572,6 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_=
imx)
>>=20=20
>>  	if (!i2c_imx->stopped) {
>>  		i2c_imx_bus_busy(i2c_imx, 0);
>> -		i2c_imx->stopped =3D 1;
>>  	}
>
> The braces can go away here.

Will do.

/Esben
