Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05208C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBB920811
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XORVw7Hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbfBFQmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:42:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35088 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731288AbfBFQmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:42:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id z18so7569652wrh.2;
        Wed, 06 Feb 2019 08:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p109q4PWOfgrWRA81GgtAFhAzRz67GvtSu9J+Ow81zc=;
        b=XORVw7Hg9LiM2dBd6lF+YInITVjoeEZUBYY/zk5hPx7vpZF2g7VSZ7CS5wm+pN6Xan
         9USJUII9BLjCFM0xaE7f5oH0RLBcHFgTwdrd9uAMUqrmxShFvMwoyT2BObpKsJd4LIVt
         9AVoMDUDwqExTOrBxE8n3hnzcveA/pPgjN+cBEHwd021GCrcsHCfWqid92L3Lj9u0TT5
         8wUJ11+5EjI8JeNiVXDL/zKb0T9d5rw7twsQzIyDD633PhIdnIxprylNYv7m6exwRelr
         dBkQwLUYzeveH+mQkLyCudBH9G/dgUJdt5YFG7T0mLzhB1k12kWRr8LycHOarzFFXiD4
         H8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p109q4PWOfgrWRA81GgtAFhAzRz67GvtSu9J+Ow81zc=;
        b=cGsTOdTncrWoByMMYGP4KQf81mcAbSE+Rk1iol92dYRfL/HLJ+cEv3rFnBG5Y1eIx/
         SLogMrvrkHTrHLlgFjcE3VQNP5tAgFWdC+mlKfFFgV3Ojzp9mf/374PkiwJfVBBdOt9W
         6SaCNKBc0pX7zgJrXuV6CQZmk+cfpDOTdYXUNtToeJKtiaMtZq6o3aAxLItksdjm5RNP
         O5RRHCGnm4O/d/eRfeIlxXBzjqF6XtVA0CKv9RnQShzTNcVcaTlA1mF7BQ3CjF1lqDOw
         YwwdFQev4IzM7fOhlhhmVrk+py8c8MIhDZi6j0Ek7qlDMPkGGF5VT1rd0scSm/kUD+NM
         SyEw==
X-Gm-Message-State: AHQUAuYDjhK6bZR+2OU1w8z4Qz403pT0vpzuxyRR01oaRIWNOkarbGZm
        Q0IddYLCLOUXLLT3cD+WiO8=
X-Google-Smtp-Source: AHgI3IZmBKCACWHwrpUFIZdplnySlLGHIo/3dKbk5FVW2knPLE2Wbm0Q24P2KqM4OcYTR9ERYvnckw==
X-Received: by 2002:adf:efcb:: with SMTP id i11mr2592757wrp.295.1549471320056;
        Wed, 06 Feb 2019 08:42:00 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id q8sm23719074wrr.9.2019.02.06.08.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 08:41:59 -0800 (PST)
Date:   Wed, 6 Feb 2019 17:41:58 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V13 3/5] i2c: tegra: Add DMA support
Message-ID: <20190206164158.GA6205@ulmo>
References: <1549464441-1836-1-git-send-email-skomatineni@nvidia.com>
 <1549464441-1836-3-git-send-email-skomatineni@nvidia.com>
 <4ecd3894-a1cb-20dd-8675-26e6e84254e7@gmail.com>
 <BYAPR12MB3398A6C76EC731D259FC3EA4C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33988DCC1F4997AAF2112447C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <9c6524ec-b40b-5b0f-eb70-f9ce2c426fd9@gmail.com>
 <8eccb125-b771-fe10-492f-41dcda00c3b0@gmail.com>
 <BYAPR12MB33980C126166D851B91AB187C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB33980C126166D851B91AB187C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 04:38:55PM +0000, Sowjanya Komatineni wrote:
> > >> Looking into timestamps and transactions, DMA timeouts after start o=
f DMA for I2C1 to touch during this transaction.
> > >> While it is waiting for I2C1 DMA transfer, lots of DVC transactions=
=20
> > >> happened thru DMA which are successful
> > >>
> > >> What is the I2C1 speed?
> > >=20
> > > 400KHz
> > >=20
> > >> Also incase if device is running slow for some reason, probably time=
out was not enough as this patch series changes timeout with base 100mS + m=
sg transfer time based on transfer size.
> > >> Can you give quick try with increased timeout incase if device is ru=
nning slow?
> > >>
> > >=20
> > > Tried to increase the timeout to 1 second, doesn't help.
> > >=20
> > > What helped again is the I2C HW resetting after each transfer. Likely=
 that means that HW isn't programmed correctly, please carefully check ever=
y bit.
> > >=20
> > > DMA-only + I2C HW reset: http://dpaste.com/26AQXFM.txt
> >
> > Seems I found what's the problem. Here is the fix, please include it to=
 v14 if it is correct.
> >
> > diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-te=
gra.c index a9391c3646b6..5ad54da70304 100644
> > --- a/drivers/i2c/busses/i2c-tegra.c
> > +++ b/drivers/i2c/busses/i2c-tegra.c
> > @@ -912,7 +912,7 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev=
_id)  static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
> >                                        size_t len)  {
> > -       u32 val, reg;
> > +       u32 val =3D 0, reg;
> >         u8 dma_burst =3D 0;
> >         struct dma_slave_config slv_config =3D {0};
> >         struct dma_chan *chan;
> > @@ -922,7 +922,6 @@ static void tegra_i2c_config_fifo_trig(struct tegra=
_i2c_dev *i2c_dev,
> >                 reg =3D I2C_MST_FIFO_CONTROL;
> >         else
> >                 reg =3D I2C_FIFO_CONTROL;
> > -       val =3D i2c_readl(i2c_dev, reg);
>  >
>  >        if (i2c_dev->is_curr_dma_xfer) {
>  >                if (len & 0xF)
>=20
> Thanks dmitry. Good catch. Didn't caught to my eyes. Yes FIFO_CONTROL is =
set based on read value without masking and oring causing back-back DMA tra=
nsfers resulting in incorrect trig levels
> We can directly set trig levels.

It might be safer to explicitly clear the trigger levels before we
overwrite them. Though, admittedly, this register hasn't changed in
years, so it's unlikely we'll ever see it change in a way that might
result in breakage if we construct the register value from scratch.

Thierry

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxbDk4ACgkQ3SOs138+
s6E+gw/7BuIA9nsgkSewN3mFgTPz+ByW1qpNbrE7BWQepc1CYa//ugvqg+3zjr2b
F7p7l+SKy+Se4vs3g84gDC5o3eXuUcJiL4nUas7AdVBPy3cmb1Oaf7P2eycQvu25
MC+XVwQzl/zKHUJRdIe73b9U5srFbyz27ZwMVI5Ye0Fn9Y6ffAkpRDuA9Yjht9bR
syoeO/yHIDGQCdiSIg3ccCv6qF2zv8gF2dgp82BFv/f1BHcRnCaqO8nzYLPij8ri
Yaa50EVq87k6ahwBnvgCB9O0meHZs5CybyBMBg3nE7afRfBVui6cRL3MyBPQCLue
k0C11Ov+QWoveKWZZXA002YfJj68cndxwEa0besj9Tn5pGsJrEDFItV8o577EA1O
PK/dxgiWo4B+3Z7afkLnZ87jDSKPbNyK7fb6SJfmRW7H/K443P9Jkdvh2Girflzc
9+2NXZnIhDt8e936L+/dbD3RMe1ypxy/zWtf+ifav6ZPmOeCULK18fUVFzSsf31T
+3eCzfkFgoxCmDzucs/aC8mT4DokwcJnfx/8xj/lbqrzb4PtiwGOb40DEwZAv5/q
Qzj8cRhYkfVweMksIAyPTzzND4rnrvEPovceQNcvNhZwRvynLShZSz6jIy1No38C
OsO8bQ9ynqqRBnETztVJbamNPj8hz0aXYPgbP7rxXkqQKzDOPGE=
=X++c
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
