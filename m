Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509A7C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16ED6218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ug/q8ewV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfAYXKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:10:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35959 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAYXKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:10:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so8114748wmc.1;
        Fri, 25 Jan 2019 15:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NGQyhMWCAKQudxPje4yjoi6+vwo4V+5m9laW1eKBEaI=;
        b=ug/q8ewVtLJFvFCOpHJ+0BG48XvM/APjhVIL6a5u3BshXkCDdr7DJHds2C49XYxudg
         /qMEX+YcuhPLAHOsTAy0TAaduFra6W0rt8dCDKnVfna7NPCBVaXJGoWxDZGQ4j0aXKhs
         pjt0gQL3VvtSNk8z+EufyNZDcgx2opNjB+siQ4qAC0VbYGm/XXpY5fY2pbeUOd9Tvg5Q
         eHWB8qgTdnInVNwOPablDA8YJI2w3ZzWAe4aqmP54s7V3CCacjehqXHF65u6RE18Kbiv
         qfldFhsoog2LpmvianHm0uRuKBFz3dRyZ+GONMf+x9okgwIqS4NH0KuKX0O8ATsmxJHp
         OWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NGQyhMWCAKQudxPje4yjoi6+vwo4V+5m9laW1eKBEaI=;
        b=ikwiJtWocPh1eCzdpSHFZmmR+Lk5ofEsCu8dH4IHVe54hhc0AORHK/YXpVA1Dmcal6
         eKFw4w2/BNsEm95FZ9T+lVWkyjKyB6KO/zf5xrq0kwWD6sev6AmJ1S1cAp1YDfVFAuAA
         d1ni9FX6dlVCwqC+otEs3HWjssUWy+Wg0EGnvK57GBq3RprMftTDK6EEQgAwkWmD2qRR
         G57V+uGPKd/tJlmM+4T1mf4Z1YlIx4THVeER+nW0jss5yYhEfQX8GsXoj1PHBM34MNaW
         ROw863BtRGcCQo6r+N6zGkas8rkEIAiYfJPGG+lAEfhyhZVfWJqbScqOuK68WmimyKl6
         Wv5Q==
X-Gm-Message-State: AJcUukckMjse9QWvDMe1LGO0v4AXPLtRX1XATAfW2Umpp/Q8ctrFWTiV
        fVHy+KMp58ptSME/uQ6vhLc=
X-Google-Smtp-Source: ALg8bN6TGU7LIOhYlhJgVnGlF9YamKomlI8BLHMJqA3jcZpOklq+P4loqj6fel7zrV+PUowQEjV8Eg==
X-Received: by 2002:a1c:180a:: with SMTP id 10mr8424472wmy.92.1548457843883;
        Fri, 25 Jan 2019 15:10:43 -0800 (PST)
Received: from localhost (p200300E41F128C00021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f12:8c00:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id 125sm116032323wmm.26.2019.01.25.15.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 15:10:43 -0800 (PST)
Date:   Sat, 26 Jan 2019 00:10:41 +0100
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
Subject: Re: [PATCH V2 3/4] i2c: tegra: Add DMA Support
Message-ID: <20190125231040.GA2013@mithrandir>
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
 <1548363113-25969-3-git-send-email-skomatineni@nvidia.com>
 <dcc1e094-638e-5b04-7a61-bdbc24ee068f@gmail.com>
 <BYAPR12MB339829FC6F2F95F833FE45A1C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <ad177c2e-3801-ddad-b359-ac83530ee1d6@gmail.com>
 <BYAPR12MB33982ED3A9EC34819D2490F8C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB33982ED3A9EC34819D2490F8C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 09:11:54PM +0000, Sowjanya Komatineni wrote:
>=20
>=20
> > >>> +	if (i2c_dev->has_dma) {
> > >>> +		ret =3D tegra_i2c_init_dma_param(i2c_dev, true);
> > >>> +		if (ret =3D=3D -EPROBE_DEFER)
> > >>> +			goto disable_div_clk;
> > >>> +		ret =3D tegra_i2c_init_dma_param(i2c_dev, false);
> > >>> +		if (ret =3D=3D -EPROBE_DEFER)
> > >>> +			goto disable_div_clk;
> > >>
> > >> So tegra_i2c_init_dma_param() could fail, printing a error
> > >> message, and probe will succeed? If allocation fails during the
> > >> driver's probe, then just fail the probe. Please give the
> > >> rationale.
> > >=20
> > > If APB DMA probe doesn=E2=80=99t happen prior to tegra i2c, DMA is not
> > > available by the time tegra_init_dma_param tries to request slave
> > > channel and in those cases dma_request_slave_channel_reason will
> > > return EPROBE_DEFER for tegra I2C probe to retry
> > >=20
> > > In case if DMA is available but DMA buffer allocation fails, then
> > > tegra_i2c_init_dma_param returns ENOMEM and probe also fails
> > > returning same ENOMEM
> >
> > Is that what you're going to change in the next version? Your
> > current variant of the code doesn't fail the probe on ENOMEM and
> > there is duplicated attempt to invoke tegra_i2c_init_dma_param()
> > during the transfer.
>=20
> Sorry correction to my previous reply.  If DMA buffer allocation
> fails, tegra_i2c_init_dma_param returns ENOMEM but probe will succeed
> as i2c transaction need to happen during  boot for some platform
> device programming for successful boot and they use PIO mode as xfer
> bytes is less and deferring i2c probe for ENOMEM causes boot to fail
> so during probe EPROBE_DEFER is only taken care.
>=20
> Re-attempt of tegra_i2c_init_dma_param in xfer happens only if no
> successful DMA channel allocation happens prior to that ( during probe
> in case of ENOMEM).
> DMA mode is mainly for large transfer, and i2c xfer returning failure
> due to failing DMA buffer allocation causes boot to hang as platform
> device programming need to happen which doesn=E2=80=99t need to use DMA.
> Will fix this and will send updated patch to reattempt DMA request and
> buffer allocation during DMA mode transfer and will return fail for
> DMA mode I2C transfer...

I'm wondering if we shouldn't gracefully to PIO if we fail to allocate
DMA buffers. Even if it is unlikely that large transfers (> than the
threshold that activates the DMA paths) will be needed by critical I2C
clients, there's really no reason why we can't do PIO if DMA doesn't
work for some reason.

Thierry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxLl2cACgkQ3SOs138+
s6EAChAAgRTjQd9z+3Aml48f+zbaN2Q/mCW+W7xsYZ/iFvP7I7mJY8DaZlC5VaGG
2aqpoOMkzJicc3gNaVbqhQo3xhcUYM99qgFLbbHOPZpxJsv6BToT0oA8U1E/YOGs
JmNiFZj8wykc7jCMRF0nNG/x0fSP556CF53RAb4rzNIwCm3S+VdO1bUwUVzPbWWS
yV0IC7X51EE1+86uFMry9UEs8KSVw9VTcjq17Bzdte85ysbysgvC3ei8vyDHKYWS
Jxc+0dOGP3riLn8ulW4uWI7GlZZI6SL5uGtyOo3Lmzyuf9yq2Yz/8XIlZCsedZAg
1TES1tOKc14T4AOEdBVwONUeaUg1v/i5oubkL3QW7bmfygNDc8lHIX1QszlpK+Q1
B+5QPzIDNf/G+VkZ3RLpwym/WCp8iSsLOJEdSEVMzCMdN28bmK6c//YT2//mEYKX
2BrFk8Lybg3ccyShQ/bBpiGnUz3lkqUtKL7N3imt1en17eatNm3oVrb+b7nG/Oyh
dJ6UYg1H1CoQxfMAYMWq3wRyJ29e6P12a9epG2c39/yvOCbH8me3aD9CTokiifm2
2YAsZMibs3inCpQw58HT0qE94eMEkA5PnzJ22Xe8JaLz45OkPsxZtMdPSCL8uHUe
aN18Jis3MRSCqF1FrySeekiugyPlHeYyv45uQ3jN6rC3NIF0zGA=
=LQPk
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
