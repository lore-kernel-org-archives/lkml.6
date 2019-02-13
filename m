Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B542AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE0B21904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7RAT97Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392653AbfBMTMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:12:10 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35193 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfBMTMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:12:08 -0500
Received: by mail-lf1-f67.google.com with SMTP id v7so2677445lfd.2;
        Wed, 13 Feb 2019 11:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F/KhtUTVYzeplfUmn3LKbi5rvF5rs8POUhFELFQtZsk=;
        b=p7RAT97YTlBXw/YIT7/wlPZws3hCIX7QrN1+MS/F3nFGN1hcy83hMKihSmB5mBNTlP
         yifwAXSiFSp8RkI/f6XE9aswOacA30cGPPeE1X1Q2BLKun2dvc+M+KqmW91vS7TBTW9Q
         a5MhpbxHG+FbH9VXnWt8dbW1e3NKeb9Xa4PskGUEen1XtmORcvBaQgDsk13+UEGPp/bL
         zXmM3iEKKanjWonn+DDXBsXhLf4Q95gtBflGLM99nb83WudpJ4U7BWkR/e8ua6A6cKy5
         07chTEkouqIwbDirNE1giJ2NL/9/AWwT33W+eGg/7OhIWoKZtxfKfjGuitHGvJQsCO+o
         V61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=F/KhtUTVYzeplfUmn3LKbi5rvF5rs8POUhFELFQtZsk=;
        b=Ue/qAeupNDOHet/gLc6Ab5pkeSsb+MRLLSTDQnmstVm2i8LYuehjz2fRhLDdjA/5/b
         dRcEzMwjn1X3DQTH6UGNgK3vA8RyRohZqolVLstzNkUGQIf4+Cm1R2T45BfkVpvM24gj
         gs+S8Co3crfTF7aYzs6vpEaPJlC8fI7bxUN63OCxCS6LGWih14o3Onw2EU75y9ZW57co
         aXSRvbGIp+VIrzmBnjnLp9NxoF0Fxi2V7Km4VAESF2rjZz4hABc7+FczsgEe1fNqLedv
         7YlxN/u0dAsTFYwS7L64xM/zd02xNpyEzxVnUoVtsIV0v0i+uc1gEfkKZaIqZkpCVfYN
         wT3A==
X-Gm-Message-State: AHQUAuaW0nrQ1Kj9HgixFZDp4ySRQfJoKg0dejoItQX/LqhInThZAL9x
        TM0rCKF0v+Gjv2s8Tz4e+tZJs1CtRac=
X-Google-Smtp-Source: AHgI3IZMA+IQddASlA1nqtEISSj1r17DHG1702Fbhg4WhMYjpWY9J+YhFRLJQZY7zbYVR88I5MIMLQ==
X-Received: by 2002:ac2:43c6:: with SMTP id u6mr1314803lfl.102.1550085125959;
        Wed, 13 Feb 2019 11:12:05 -0800 (PST)
Received: from localhost (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id c8-v6sm18347lja.46.2019.02.13.11.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 11:12:05 -0800 (PST)
Date:   Wed, 13 Feb 2019 20:11:43 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] iio: chemical: sps30: mark expected switch fall-throughs
Message-ID: <20190213191142.GA23470@arch>
References: <20190213024842.GA25131@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190213024842.GA25131@embeddedor>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 08:48:42PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>

That have been already fixed by this commit available at Greg's staging tre=
e:

59b9bb0 iio:chemical:sps30 Suppress some switch fallthrough warnings.


> drivers/iio/chemical/sps30.c: In function =E2=80=98sps30_read_raw=E2=80=
=99:
> drivers/iio/chemical/sps30.c:289:4: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>     switch (chan->channel2) {
>     ^~~~~~
> drivers/iio/chemical/sps30.c:299:3: note: here
>    default:
>    ^~~~~~~
> drivers/iio/chemical/sps30.c: In function =E2=80=98sps30_do_cmd=E2=80=99:
> drivers/iio/chemical/sps30.c:120:10: warning: this statement may fall thr=
ough [-Wimplicit-fallthrough=3D]
>    buf[1] =3D (u8)SPS30_AUTO_CLEANING_PERIOD;
>           ^
> drivers/iio/chemical/sps30.c:121:2: note: here
>   case SPS30_READ_DATA_READY_FLAG:
>   ^~~~
> drivers/gpio/gpio-eic-sprd.c: In function =E2=80=98sprd_eic_irq_set_type=
=E2=80=99:
> drivers/gpio/gpio-eic-sprd.c:403:3: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>    switch (flow_type) {
>    ^~~~~~
> drivers/gpio/gpio-eic-sprd.c:435:2: note: here
>   default:
>   ^~~~~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/iio/chemical/sps30.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> index e03a28a67146..f308d8ddceec 100644
> --- a/drivers/iio/chemical/sps30.c
> +++ b/drivers/iio/chemical/sps30.c
> @@ -118,6 +118,7 @@ static int sps30_do_cmd(struct sps30_state *state, u1=
6 cmd, u8 *data, int size)
>  	case SPS30_READ_AUTO_CLEANING_PERIOD:
>  		buf[0] =3D SPS30_AUTO_CLEANING_PERIOD >> 8;
>  		buf[1] =3D (u8)SPS30_AUTO_CLEANING_PERIOD;
> +		/* fall through */
>  	case SPS30_READ_DATA_READY_FLAG:
>  	case SPS30_READ_DATA:
>  	case SPS30_READ_SERIAL:
> @@ -296,6 +297,7 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
>
>  				return IIO_VAL_INT_PLUS_MICRO;
>  			}
> +			/* fall through */
>  		default:
>  			return -EINVAL;
>  		}
> --
> 2.20.1
>
