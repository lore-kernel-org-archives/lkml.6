Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD19C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61812084D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IofMVvVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389210AbfBRQ2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:28:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40755 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731218AbfBRQ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:28:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15so9616241wmi.5;
        Mon, 18 Feb 2019 08:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8O2q7XMWgEXWgbA5Jkf93rrMOjIFB/gms4utDAPLF68=;
        b=IofMVvVbEd4zieHbHQysP2cxWbqCQ2NK5IwgZys2v7eUqLElURjvGIQpPBnDpYfLXo
         Ntfz9EP+QDfvSgaCcJzw7BnorSL6w0AyAQ0kuhasHWZuetkmNI+s6vmZYqHDnwg19vRt
         Gsgwmpv3sIwVLYRSwj6rLZ+9rpPP6t8zUIhNnv7oGS9xhjoT5HHzTr6Lhkho6gZiQcyB
         Zm7m+DLvlhXabjdb/jZQKeC9VL1HKx+XNdR3bm9quFrUptyQFfvoSmoeA1/CHMk4JApS
         nrI076nSNBYfGw9h5Ou1VAfYc1Ustm8aXf48IJ28ZUxSIAKNjx9dlw2ZWW1WTbCTD0ZM
         dcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8O2q7XMWgEXWgbA5Jkf93rrMOjIFB/gms4utDAPLF68=;
        b=O0IvoxY1v7bDdPqLPSzhaF1+4SvOwuORlK5xQfRI4svxMwMANQEEXorYNpUapcS7Hg
         b4G1XwFhvEQjGcPYjiMrLOQUX+m56zRdxb712zFCW3A0aT4eMa7MuCfFM6g+Ytx83PC/
         5d4eYd6Znks06kOhWXS/sGbyTpllektvzOvjh219NEgePQg12Nmgdd1siIOyJhnlZxpk
         IuGD9CVxEA/oU2xUi68aznsNGF1hBCnFMbkQgRlq1b7YHIGaqB8HdQRLt/sAXLiWbroB
         dTZEmTibVkZthQ2GRJB2V5QEJCmKdi9PXorerj0KVgwI/bGWJ0UohrT964n3zNeLdfZI
         1m+A==
X-Gm-Message-State: AHQUAubO1ZFGunIEJIGeh67gXYUoeRcEpc6v9p/NbKPQe/osoFFRvMPO
        /LgCYTV4cN+jQom0522HzGi3NAUS
X-Google-Smtp-Source: AHgI3Iavvj9TvtCQnxSrEalamRwiEKKEpIXTCiiP901DRBVAiKxrnnhxDOFi9sAGkx8I4pbXZL9QlQ==
X-Received: by 2002:a1c:f406:: with SMTP id z6mr16228839wma.107.1550507306525;
        Mon, 18 Feb 2019 08:28:26 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id p6sm18507003wre.63.2019.02.18.08.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 08:28:25 -0800 (PST)
Date:   Mon, 18 Feb 2019 17:28:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V1] i2c: tegra: fix tegra186 hw supported features
Message-ID: <20190218162824.GA11872@ulmo>
References: <1550334787-27703-1-git-send-email-skomatineni@nvidia.com>
 <20190218084227.GB19363@ulmo>
 <42aa92c1-309e-88c1-1cd6-07592990730b@nvidia.com>
 <20190218145002.GC19190@ulmo>
 <BYAPR12MB3398E17BB92CC0D33996FBD4C2630@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398E17BB92CC0D33996FBD4C2630@BYAPR12MB3398.namprd12.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 04:13:46PM +0000, Sowjanya Komatineni wrote:
> > >=20
> > > On 18/02/2019 08:42, Thierry Reding wrote:
> > > > On Sat, Feb 16, 2019 at 08:33:07AM -0800, Sowjanya Komatineni wrote:
> > > >> Tegra186 does not support multi-master mode and also there is no=
=20
> > > >> master fifo control register.
> > > >>
> > > >> This patch fixes supported features of Tegra186 and prevents=20
> > > >> crashing during boot as master fifo control register are not=20
> > > >> present on Tegra186 and prior.
> > > >>
> > > >> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > > >> ---
> > > >>  drivers/i2c/busses/i2c-tegra.c | 4 ++--
> > > >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > We really should've caught this earlier. Jon, let's think about way=
s=20
> > > > to make it easier to catch these things in the future on our test s=
ystem.
> > >=20
> > > Indeed. This has fixed the boot regression I was seeing over the=20
> > > weekend on -next for Tegra186. However, I am bit confused here,=20
> > > because when I look at the Tegra186 TRM it states that the I2C=20
> > > supports multi-master mode which disagrees with this patch.=20
> > > Furthermore, it seems odd that
> > > Tegra210 and Tegra194 would support multi-master mode but Tegra186=20
> > > does not. So is this really correct?
> > >
> > > I would expect at least the missing master FIFO registers to cause a =
crash on Tegra186. The internal architecture specification also says that m=
ulti-master is supported.
> > >
> > > Sowjanya: do you have other documents that suggest we don't support m=
ulti-master on Tegra186 specifically? Or is this to work around an issue sp=
ecific to Tegra186?
> > >
> > > As it is this contradicts documentation, so we need to either fix the=
 commit to remove only master FIFO support or we need to fix the docs to re=
flect reality.
> > >
> > > Thierry
>=20
> Thierry/Jonathan,
>=20
> Design wise we support but due to known hw bugs we defeatured
> multi-master mode. TRM docs also says no multi master support for
> T210, T186 and multi-master is supported only on T194.
>=20
> T210 also has multi master enabled in driver. We should disable that
> also.

Okay, I think it makes sense to split this into two patches:

1) remove master FIFO support on Tegra186 because that leads to a
   crash

2) remove multi-master support on Tegra210 and Tegra186 with a commit
   message that explains that it was defeatured because of known bugs

Thierry

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxq3R0ACgkQ3SOs138+
s6FyNg/9FmE505MLO02XvVpembnhWWl72D4/dpuYn65dXmc7Sq8W/RwPq3q4UJp+
bU78qzpjEHbq07W3mfdWRXNKmmWTvFFSdG9a+p7wk3wvZHT64e0oYG6rS69aZbg4
p5xN1jDsbAWAANYpQzaPQWrykme5JN/9C0OkjYZ7c3Ps2TMZ1ug9JASUluceaDHg
XHwvWaQZXP1z0Pin1R5OAKEdy5JYwiwHvMwsdbRJVZn1VK8S1efDJUuAdKW6uPvU
9A5Oc0WypwyNq296HDOtAhoTNFI5lJhaHZIUqD6CkAG798YMOoZNYKvfOaxfd0yl
EOISEAjXDNKVMSVY9nV9HhzX6MdFj/8QHd0Pd3P2zA9E88JS4t88vV1fPErUBP17
hQxfz9TXn5NMKz+alKeLTZjFW1ZaxgN5JlyA7AWBDEDZAx6JNDghYr6rfMtY6wam
4YWsCMiWZwifUEobIk4XqpZCyzCEEeoRdcnKye3kTbglg2nnYpWRxP5lOTXe4J1s
yrDfpUq716JiaFRHtTHuU2s152yGz9r40tWQfAWrAQ9p3eAb3cV9wb/ZLGvFc4Xz
hxCoR61PVxJt44Wwj5BzOq9q9uEhHst9H1vF3Nv07e0jnWeqB+1Mfe0tFm/indlq
vLhnzSkxMAsOXWCF8e5Vg7HRikUz5l8JlkhW+y0BeF14xoomt1Q=
=kqM0
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
