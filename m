Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0A9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36D8218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8J4KOjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbfAaMGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:06:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37876 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfAaMGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:06:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so3006728wrt.4;
        Thu, 31 Jan 2019 04:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6TkyGIoTSVLyQTgWZK5IMJTlZ+YDq0Xrvmr1iqus8/I=;
        b=u8J4KOjfJuZhQnD71rujCYC3OA6hBa32a3z6Hf2YWROCW4ByJV6NrUB9OQ2+q8Y561
         P/HIK4rHBxuAlMPwtCRjt84uVm84DGV4zjPu4v+s483neEyRUW7Ha//nixhxeSGHmyoF
         o4TSYByyYTlR8CSYtnGjYyq3DkNhftJb3TCUnZvxtZEGVlKQy/Y8C/n3wQmkVqgxI5Nl
         lXHEboaw1Y0x5Rg3kc2lTxlAFvgA/p6xHRNYA8sHLtgkaGsrCiKwxKJyyFG94fv7qY50
         G5xA+0DRaVSehid9AMhaIbMnXjWGrRJTR0XiQskF0DtoY42Tf9YiJa4P42W6o7og1zh2
         v8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6TkyGIoTSVLyQTgWZK5IMJTlZ+YDq0Xrvmr1iqus8/I=;
        b=PpJCpC1cSJK9oDWG75DBqE7tujFCypt3BMMBuAx5UTeEYeOFeejOIPnyF1AQDCRSzU
         VoHMgvlRga6aQN0cxz7MC6z8V2zWHEqQwnDnYmRMebwN4SR/oOnHIhUmGdVI8jgqWDx9
         c1TK1Foj2MB9EHISOlwifsPjVn/DpE6L4GKJaTPup/xa0XkqFda8zA6x6Jkpk2dHDIXz
         I970mr0MjW+wYLdBezX5wDByULU6adWMNTZihjUWwh2sZS/EXyQJRwtsGoCMKGxct9NR
         ms7fNMThRryXS1Xc3wnzANGofJqNNgCTIEpghbD9d8dtRGiwN1Ybv6G2CL+9nTxSUodz
         2RNw==
X-Gm-Message-State: AJcUukcTArtBDS0V+T6S83TGzYjw/HoAPIMt/eYWRIc8mQDM+5IiAq/q
        ayM1TQorc41VeF+QKds8xdo=
X-Google-Smtp-Source: ALg8bN5qZqmuUd9xDsOeWBgiWb3UYnKS73AxVudD9rs6ZrR1iwO3C9244FE4RLF7wFwn3YySIlryvQ==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr33269068wrm.309.1548936402642;
        Thu, 31 Jan 2019 04:06:42 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id w125sm12217008wmb.45.2019.01.31.04.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 04:06:41 -0800 (PST)
Date:   Thu, 31 Jan 2019 13:06:40 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V7 3/5] i2c: tegra: Add DMA Support
Message-ID: <20190131120640.GF23438@ulmo>
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
 <1548864096-20974-3-git-send-email-skomatineni@nvidia.com>
 <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline
In-Reply-To: <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 03:05:48AM +0300, Dmitry Osipenko wrote:
> 30.01.2019 19:01, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
[...]
> > diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-te=
gra.c
[...]
> > +		return -EIO;
> > +	}
> > +
> > +	dma_desc->callback =3D tegra_i2c_dma_complete;
> > +	dma_desc->callback_param =3D i2c_dev;
> > +	dmaengine_submit(dma_desc);
> > +	dma_async_issue_pending(chan);
> > +	return 0;
> > +}
> > +
> > +static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev,
> > +				    bool dma_to_memory)
> > +{
> > +	struct dma_chan *dma_chan;
> > +	u32 *dma_buf;
> > +	dma_addr_t dma_phys;
> > +	int ret;
> > +	const char *chan_name =3D dma_to_memory ? "rx" : "tx";
>=20
> What about to move out chan_name into the function arguments?

That opens up the possibility of passing dma_to_memory =3D true and
chan_name as "tx" and create an inconsistency.

> > @@ -884,6 +1187,8 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_de=
v *i2c_dev)
> > =20
> >  	i2c_dev->is_multimaster_mode =3D of_property_read_bool(np,
> >  			"multi-master");
> > +
> > +	i2c_dev->has_dma =3D of_property_read_bool(np, "dmas");
>=20
> Not only the existence of "dmas" property defines whether DMA is availabl=
e. DMA subsystem could be disabled in the kernels configuration.
>=20
> Hence there is a need to check for DMA driver presence in the code:
>=20
> 	if (IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
> 		i2c_dev->has_dma =3D of_property_read_bool(np, "dmas");

Do we even need the ->has_dma at all? We can just go ahead and request
the channels at probe time and respond accordingly. If there's no dmas
property in DT, dma_request_slave_channel_reason() returns an error so
we can just deal with it at that time.

So if we get -EPROBE_DEFER we can propagate that, for any other errors
we can simply fallback to PIO. Or perhaps we want to restrict fallback
to PIO for -ENODEV?

I wouldn't want to add an IS_ENABLED(CONFIG_TEGRA20_APB_DMA) in here.
The purpose of these subsystems it to abstract all of that away.
Otherwise we could just as well use custom APIs, if we're tying together
drivers in this way anyway.

> Also Tegra I2C driver should select DMA driver in Kconfig to make DMA
> driver built-in when I2C driver is built-in:

I don't think there's a requirement for that. The only dependency we
really have here is the one on the DMA engine API. Since dmaengine.h
already provides dummy implementations, there's really no need for
us to have the dependency. If the DMA engine API is completely disabled,
a call to dma_request_slave_channel_reason() will return -ENODEV and we
should just deal with that the same way we would if there was no "dmas"
property present.

Thierry

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxS5M4ACgkQ3SOs138+
s6FDEw/+JxOcZL0QNOUsgqN799nEJ7ytF+t9JghF5uJacTi7Ez0ievlZVZk+kpTb
xRLHMY67MlcuiW4zKB9H6qAPUj0vXJLrSOFR6P0DXf23KOtRsmavgUzO3tp6EI1h
23TPmPwQJE1my4Q2VOovaJ9Oc0UrL3r5mYZBf+2eqJcFHZwgCKTo1OwUCOO9rELK
gaYX1lkWC0MLO5LbSSJqVi3y13V983C5WWrn3KTzzZVSI4oYafknAAE2248E0UQZ
cuF+4XWsPi8iEbk0fsKe8/rrDOcd5cA3YxjMHQ1N3SiwQx0817jtqgOaavQkee8F
51Z/yyQrWCPkPiBjaPyoWs3eTWTmg2Kl6ukItnU8rQok5nWdAiVfsDRev6gvV8oD
N+z8x/m/xuQ+ucqz+7NhEtyp2dWUOuhtRDjdFivr2Yoo5ye1f11CUuNRVHpd9Qbd
2AXwZFqSsPHaLM6lwYRL0eJA4vyRNI9fnKxRi+ng+1Z1H5LXInvdWYE4TpoyhY81
zOMw183VtmP9uJXbf9TZOQ84ims8RNamHKTyd2AEKWwUu4fmIkkxh057RA34iQuK
iXGv/cJPRE6KiR8ZIq66Usro+YZE2hya+lnWNWS3p0gPdiLqYhSZO/0UZWyqXH9k
C/0VdaxE6hVpYCkQhFFV4B1YOwmgFsuE+nt/izyJO9i794CuA/I=
=p6wt
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--
