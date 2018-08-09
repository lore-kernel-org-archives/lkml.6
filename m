Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C743DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7328321A5D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPJphCCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7328321A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbeHIPhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:37:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39157 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbeHIPhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:37:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so243031wmq.4;
        Thu, 09 Aug 2018 06:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EGqJcWzR/kMYaPs5e+iAnhcJryaxFNCOiLLWQfKdnZo=;
        b=YPJphCCQNzF0WLq8hIdFOaMRrUZpeZEIVIin9AOeB7DA1B0D/n2xfqy7QBmPmTp2Cn
         CeIDQpYL90cTUjdebQbmUVILR6LdwLXDpaz3rd3LHclCc6msdXN2yytASvi/IXBbxLj7
         nVTNYwZsmcn/yCP6zTAxAyPk9Ww40WkRyOC3AxNHQxOVcTR+nfETFuM/WEXx0RQdLGNm
         Q5LWneEMZyggxcDJHKJ4vc5m8KwuPNANOGhVgb+HO/0+3P9EUwSBUtDuoJaM43E02Rum
         1GxkjxO3LNb8tdQSglEHqYxhzRvFGm0i6iXqgfmBmf0hS07hJE3Iykz0drmuCfgZMsMQ
         JcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGqJcWzR/kMYaPs5e+iAnhcJryaxFNCOiLLWQfKdnZo=;
        b=c5/weWWJP+wxv2lsif8D9Ull1f8++mm4pM3F1KInM8Tb0kPTx81MRLfWZCc/Yceq+l
         G9/bxXzJ/4ANKkVwc4977yavSzciOipsS04w0X46tHWS1BKOxJ1FlMMff7jRn/zO3c2C
         aiTqUWc4bSU+phZof0z2Icd9fU9x5kA+lARuY7rhwpyc5o8laPXpKm+OnA+J8kBmT+vY
         4RvQwiz+julOKq+luLhGr7Fd9IWKeUoAp+tMa591Z3G9XnELb1Fmx6m/O5eFbl/amus/
         KWjtsMSIjmIT1IwZaqrjanfE28iBIYfOriTLk/KRs673sOXmETbHOpbbo9DwMaXouoAt
         UbkQ==
X-Gm-Message-State: AOUpUlFlziOj90VMz3W6c0uiM0RouFu/IT0g3XwZZkTCkvCh7kOFBS5i
        zYG7zVcN3aeMu/D6AtQ2YIU=
X-Google-Smtp-Source: AA+uWPxFUSu6b3yA8aV+D/fUaCWIvtRRFuP5YBPSjnHE5xDSYmGW9C9sgfYA3xixBwLQicSCFbq20Q==
X-Received: by 2002:a1c:f03:: with SMTP id 3-v6mr1600885wmp.129.1533820333354;
        Thu, 09 Aug 2018 06:12:13 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id q1-v6sm4893315wrw.42.2018.08.09.06.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 06:12:12 -0700 (PDT)
Date:   Thu, 9 Aug 2018 15:12:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 10/40] soc/tegra: pmc: Implement pad configuration via
 pinctrl
Message-ID: <20180809131211.GA21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-11-git-send-email-avienamo@nvidia.com>
 <20180809122706.GT21639@ulmo>
 <20180809154412.4e7fe9b3@dhcp-10-21-25-168>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ELawpaRm0uGyL1wg"
Content-Disposition: inline
In-Reply-To: <20180809154412.4e7fe9b3@dhcp-10-21-25-168>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ELawpaRm0uGyL1wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 03:44:12PM +0300, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 14:27:06 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Wed, Aug 01, 2018 at 07:32:00PM +0300, Aapo Vienamo wrote:
> > > Register a pinctrl device and implement get and set functions for
> > > PIN_CONFIG_LOW_POWER_MODE and PIN_CONFIG_POWER_SOURCE parameters.
> > >=20
> > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > Acked-by: Jon Hunter <jonathanh@nvidia.com>
> > > ---
> > >  drivers/soc/tegra/pmc.c | 187 ++++++++++++++++++++++++++++++++++++++=
+++++++++-
> > >  1 file changed, 185 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c =20
> > [...]
> > > @@ -1704,6 +1863,12 @@ static const u8 tegra124_cpu_powergates[] =3D {
> > >  		.name	=3D (_name),			\
> > >  	})
> > > =20
> > > +#define TEGRA_IO_PIN_DESC(_id, _dpd, _voltage, _name)	\
> > > +	((struct pinctrl_pin_desc) {			\
> > > +		.number =3D (_id),			\
> > > +		.name	=3D (_name)			\
> > > +	})
> > > + =20
> >=20
> > Do we really need the explicit cast to struct pinctrl_pin_desc here?
> >=20
>=20
> No, but I prefer to have it as it makes the type of the value the macro
> expands to explicit. In a way it hints at how and where the macro should
> be used and arguably improves readability.

It's a rather uncommon pattern in the kernel, and most issues are easily
caught by the compiler.

But it's fine with me if you want to keep it.

Thierry

--ELawpaRm0uGyL1wg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsPasACgkQ3SOs138+
s6Ft+Q//ZlGl3OuUBrz8aBjmgApj4optY/PujiMt8F0ObC/Br+s2gQVJPYmrhI4q
dR2ARZaVA9Br9Fkq5z5zRkD6YDle07p9kj7RjSrVdXnMbCM4dNspfD04XBmveqsT
6wtaJinLd9FVF55UkLGApwL0dlMq06fyu1947GOMmFTAVlrKkS7LT5AtQICgX9Yr
FJVVYmVF8ZKtJphokEhdtlbu6ZV/jiqVDyWKWEY2bPaJx/4rUcGbZNKar4BYOuXu
6fNSPJ6umDXNsUJwwheGd0r+1na75zGm/Zd6cCvtI0BjVh/xpKzfF8A5FzOYKjfM
M5Rr0lDilDqI1tcr5vIiZiI+WLV+Bkr/ZfC96+usHibkESiC+Ow5J1v8kbjPOmiT
16xHCwAHDUwvkmYCrolw/sf1m0RsWweIC+y0BOl4meBbhMkLQDUhBG6TxPTU32+/
0U9jw9d9iIDOWsqMKzjGhB9WmvPJO2w720wQtRCn2nX6lR+ROmlT/BGZWujXN730
CBHnx+LbL7pw4GrhYf1EfY8E+YgVZA6Ql3Uyb6Z7/I7UNyH9MMjyPH1HnuET1nst
wBUtAQSNLXqgVdtZ4p3ryfMfu0PhNmgbjrnBgbSGDOmOcQJHquRWqiWn1uPPe7od
c8VLH5COAFJuZmthAtG/RW/vQxsH1vkqqnkxlVxKZE/ei8bqLl4=
=lAWZ
-----END PGP SIGNATURE-----

--ELawpaRm0uGyL1wg--
