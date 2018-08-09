Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0277C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C909217D0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFN6/pPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C909217D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbeHIOVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:21:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34244 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730132AbeHIOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:21:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so4280903ljk.1;
        Thu, 09 Aug 2018 04:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=NZtKWJZmI/+iULgMd76pqfONx3FfTQ36HyLoKRhah34=;
        b=KFN6/pPCf92rCe/qON2TlllzIuKVdNiUiBi8oLNSG9Vva2WL9n2+Oq0qyoqQrOHRtr
         DP9p+C8xaEt6mwUV7MPHJyJSIu6nGv6B+d0USEPn79K6ZMT14gV1oIhP6IffE9gMTcGe
         SdL1gNwOBjiz0OZJijEQIO8KUccVaHIK5XERVGDnfrkvrNmT7PQ1Z3NP6EeVpx36443z
         yrTcO8uHa5YLtEURqpA6BT3vZudGwcAVHvTZD2TZZVzE7wAPc4ge0dSdSPIbMR6FUNTl
         OiuVawNqE7YdIqEQQqtvclPwj9vNz20gO5Oeo/dJB1BN/OQCJWKNsxY57U7ke3RHswUH
         YkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=NZtKWJZmI/+iULgMd76pqfONx3FfTQ36HyLoKRhah34=;
        b=eGFKmRz3Efh8CzyN3Q+TQ08yLtSvwQwtwP/el5KHjcXsF+LtcLngO7Dhwtow/+ciyk
         g1sUQVThzX9xF0/bYN1vfTBoKfmaFM9t6EajZP4v7a86VxaPgI5j7wy846HuEZMfqyYV
         1MbaZHxS5A91lkA5Gsp21F2i5Y/Xc6XsbtI1yh8O2jkLh8q8BWaiLN+XFYY1csJcE+hW
         +wkD7nqYitJIm4fz4E0q6JsMC1ppgWBk1mQGO0Zj5F5S+qaiFQ5hFWQNPtiT2NfYAKmD
         v1Z9D5c3mPmAgHw7FmC/r7QmvWMHK0TEd8OzCViHNCcW7EwGBz5G/0E/ibJ7qARvJPey
         P8qg==
X-Gm-Message-State: AOUpUlF4fxyygm589BClTlzFqMaGEE2PTbYy0niTxB+fIuGfOvZvhdJJ
        54ChqHvv57qs9uwsnhGPo0A=
X-Google-Smtp-Source: AA+uWPzYX/0VQORKzdIbpklWHa0JDTDRHKw2IREqIAjTnRGaAbHJAqrhzEUQw2WLXlG3uH/cYvrofA==
X-Received: by 2002:a2e:4103:: with SMTP id o3-v6mr1448308lja.3.1533815831254;
        Thu, 09 Aug 2018 04:57:11 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id q14-v6sm1336342lfq.7.2018.08.09.04.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 04:57:10 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yuan Yao <yao.yuan@freescale.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Phil Reid <preid@electromag.com.au>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] i2c: imx: Fix race condition in dma read
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
        <20180709094304.8814-3-esben.haabendal@gmail.com>
        <20180724075707.7wrqltjj54gjrl4y@pengutronix.de>
Date:   Thu, 09 Aug 2018 13:57:08 +0200
In-Reply-To: <20180724075707.7wrqltjj54gjrl4y@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Tue, 24 Jul 2018 09:57:07
 +0200")
Message-ID: <87o9ebzraj.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> On Mon, Jul 09, 2018 at 11:43:02AM +0200, Esben Haabendal wrote:
>> From: Esben Haabendal <eha@deif.com>
>>=20
>> This fixes a race condition, where the DMAEN bit ends up being set after
>> I2C slave has transmitted a byte following the dummy read.  When that
>> happens, an interrupt is generated instead, and no DMA request is genera=
ted
>> to kickstart the DMA read, and a timeout happens after DMA_TIMEOUT (1 se=
c).
>>=20
>> Fixed by setting the DMAEN bit before the dummy read.
>>=20
>> Signed-off-by: Esben Haabendal <eha@deif.com>
>> ---
>>  drivers/i2c/busses/i2c-imx.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>> index 39cfd98c7b23..d86f152176a4 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -668,9 +668,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i=
2c_imx,
>>  	struct imx_i2c_dma *dma =3D i2c_imx->dma;
>>  	struct device *dev =3D &i2c_imx->adapter.dev;
>>=20=20
>> -	temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>> -	temp |=3D I2CR_DMAEN;
>> -	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>>=20=20
>>  	dma->chan_using =3D dma->chan_rx;
>>  	dma->dma_transfer_dir =3D DMA_DEV_TO_MEM;
>> @@ -810,6 +807,11 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_=
imx, struct i2c_msg *msgs, bo
>>  	if ((msgs->len - 1) || block_data)
>>  		temp &=3D ~I2CR_TXAK;
>>  	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>> +	if (i2c_imx->dma && msgs->len >=3D DMA_THRESHOLD && !block_data) {
>> +		temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>> +		temp |=3D I2CR_DMAEN;
>> +		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>> +	}
>
> Does this need to be a separate write to the I2CR register? Just before
> the if there is temp written to this register, so probably this can be
> changed to just:
>
> 	if (i2c_imx->dma && msgs->len >=3D DMA_THRESHOLD && !block_data)
> 		temp |=3D I2CR_DMAEN;
>
> when moved before up one line.

Sure, that is clearly better.

> I don't find documentation for the LS processors where this
> register is described though (and the imx family doesn't seem to support
> DMA for i2c).

Yes, unfortunately, I think the LS1021A reference manual requires NDA.

> Other than that this looks reasonable and warrants a
>
> 	Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver=
")

I will add that.

/Esben
