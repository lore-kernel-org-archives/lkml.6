Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D02C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECAE20833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2aydX5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECAE20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeI3RKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 13:10:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34594 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbeI3RKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 13:10:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id q19-v6so11686123edr.1;
        Sun, 30 Sep 2018 03:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=otcrwZhRKHILP3SU5xbfm2T4okun74sqWB/4BTuS8Ig=;
        b=e2aydX5hcf/FH5bWNGpwv36rCztBnLzfrRPERHTw7OJ4Slaw6xvfkeljltNtlWV9tb
         xJY7t2lGb8P3sj3jcP52j9EkQFM9PFcFIDf1GIkOM4Ii78z/Tml1nvunUxnqhgTZ4Q7E
         /aLFus5zEtQUmigyd7GAcYhpF/0QzH2xBu/Fr1Jp6AIK1UToFMXR/hwtChKwWHkm6Nzy
         r0Ve0c5/fCn+V7fHF/cTQ1IOrDEIWK0mkAVd7nHayM7VsJg03MiDRpBqCQD6cVhd1T4q
         LUPXYrfcPyUxSnN0Rka8vlYCu8TKC61FQd58yUDiM/EABY04ldVppkxxFlk8uDdoSK0D
         +bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=otcrwZhRKHILP3SU5xbfm2T4okun74sqWB/4BTuS8Ig=;
        b=gtbjKVttwKzFuyqQU3DqIpWol7imhSysKMhtKHXKQpfR2rE+5GSmsyXrW+BtJGpsOU
         m4izSVcEPLAes3mj4MFRjnBQSBSTRiuvjeMoxjL45ZA0pJb4858fSxx+VJR4TmVtrVdn
         blc/Dtb5Q+X3PyQDLDdP89GQ9nW8uv9n3njzrgIVakkr30HvMwaeZBiCbjAOVKhmJXvC
         6zl8oSWizf3AoescjIXkovsiebytqihoD3QPZALUppAM5BgTqNoE9LWIkGk/dArIKtXh
         JKXDAkmMX8ZAW0Mvf+W/MYkT/BWJ2cmBmhXhYyOvOw9AXUHZTE1lajavCBTdkxt+6e/e
         XpyA==
X-Gm-Message-State: ABuFfogqRypdGKV/jNDODL0O9j0uKGUVkAOqVvO7QWc2MHiJpiZ7GdBm
        BkYmuxeNAXYkPdl5lxPbUit0fWGA
X-Google-Smtp-Source: ACcGV61BZB4H6H6TyWqN1laIbdl5B+2J1+0l7s0IkDeatDJtUyvYvAFKyJa13/MGtuGQKawYpVer9A==
X-Received: by 2002:a50:9747:: with SMTP id d7-v6mr12153099edb.244.1538303861255;
        Sun, 30 Sep 2018 03:37:41 -0700 (PDT)
Received: from localhost (87-49-147-65-mobile.dk.customer.tdc.net. [87.49.147.65])
        by smtp.gmail.com with ESMTPSA id y4-v6sm3353088edr.84.2018.09.30.03.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 03:37:40 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Chuanhua Han <chuanhua.han@nxp.com>,
        "broonie\@kernel.org" <broonie@kernel.org>,
        "linux-spi\@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] spi: spi-fsl-dspi: Fix delete the processing of undefined bitmask for rxdata
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930092535.24544-2-chuanhua.han@nxp.com>
        <20180930120659.71b0e1e5@bbrezillon>
        <AM0PR04MB4353B48117292E511AC1E09F97EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
        <20180930121707.4724edd6@bbrezillon>
Date:   Sun, 30 Sep 2018 12:37:38 +0200
In-Reply-To: <20180930121707.4724edd6@bbrezillon> (Boris Brezillon's message
        of "Sun, 30 Sep 2018 12:17:07 +0200")
Message-ID: <877ej36zkd.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris Brezillon <boris.brezillon@bootlin.com> writes:

> On Sun, 30 Sep 2018 10:10:14 +0000
> Chuanhua Han <chuanhua.han@nxp.com> wrote:
>
>> > -----Original Message-----
>> > From: Boris Brezillon <boris.brezillon@bootlin.com>
>> > Sent: 2018=E5=B9=B49=E6=9C=8830=E6=97=A5 18:07
>> > To: Chuanhua Han <chuanhua.han@nxp.com>
>> > Cc: broonie@kernel.org; linux-spi@vger.kernel.org;
>> > linux-kernel@vger.kernel.org; eha@deif.com
>> > Subject: Re: [PATCH v2 2/4] spi: spi-fsl-dspi: Fix delete the processi=
ng of
>> > undefined bitmask for rxdata
>> >=20
>> > On Sun, 30 Sep 2018 17:25:33 +0800
>> > Chuanhua Han <chuanhua.han@nxp.com> wrote:
>> >=20=20=20
>> > > This patch fixes the problem of rxdata being equal to 0 during the
>> > > XSPI mode transfer of the dspi controller.
>> > > In XSPI mode, If it is not deleted, the value of rxdata will be equal
>> > > to 0, and the data received will not be received correctly, causing
>> > > the receiving transfer of the spi to fail.
>> > >
>> > > Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
>> > > ---
>> > > Changes in v2:
>> > >  -The original patch is divided into multiple patches(the original
>> > > patch theme is "spi: spi-fsl-dspi: Fix support for XSPI transport
>> > > mode"),one of which is segmented.
>> > >
>> > >  drivers/spi/spi-fsl-dspi.c | 3 ---
>> > >  1 file changed, 3 deletions(-)
>> > >
>> > > diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
>> > > index 3082e72e4f6c..4dc1064bf408 100644
>> > > --- a/drivers/spi/spi-fsl-dspi.c
>> > > +++ b/drivers/spi/spi-fsl-dspi.c
>> > > @@ -243,9 +243,6 @@ static void dspi_push_rx(struct fsl_dspi *dspi, =
u32=20=20
>> > rxdata)=20=20
>> > >  	if (!dspi->rx)
>> > >  		return;
>> > >
>> > > -	/* Mask of undefined bits */
>> > > -	rxdata &=3D (1 << dspi->bits_per_word) - 1;
>> > > -=20=20
>> >=20
>> > Why not=20=20
>> In xspi mode, the value of rxdata after the statement is processed is eq=
ual
>> to 0 no matter what data is received.
>
> Only if dspi->bits_per_word is 0.
>
> Actually, I just had a look, and xfer->bits_per_word should never be 0
> because spi_validate() makes sure it's initialized [1]. Don't know
> where dpsi->bits_per_word comes from, but maybe you have a problem
> there (dpsi->bits_per_word and xfer->bits_per_word not in sync).
>
> [1]https://elixir.bootlin.com/linux/v4.19-rc5/source/drivers/spi/spi.c#L2=
869

dspi->bits_per_word =3D xfer->bits_per_word

https://elixir.bootlin.com/linux/v4.19-rc5/source/drivers/spi/spi-fsl-dspi.=
c#L697

So it should never be out of sync, and it should never be 0.

As I mentioned in another mail, I suspect what Han is observing is
caused by byte ordering, so that the mask masks the wrong data.
Maybe related to the byte-ordering fix patch.

/Esben
