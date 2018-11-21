Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828B0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436752146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Edlvv18f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436752146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbeKVBSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:18:06 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34615 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeKVBSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:18:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so5108384ede.1;
        Wed, 21 Nov 2018 06:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DqZOsYSImtx/m4Mvs5BzR/wAix+gzzh1o9aws2BZZFw=;
        b=Edlvv18f+gNBASfaOzMnOwuUQi4nF1wm1j6k1mOLH2DXAsQ1jRIoqmtNVPzHo4q9nX
         skRKXy2/7GUN0LiozMstz/38CS6amDLCvICKZzWp8ewMqltfSVGgjq441Gc/ermKUPj+
         rQH5NDO7hoP3IjpDs5zMV6ZeDgq3oAvcwVCLPn/l6+CtZa+vEwVXj61AadofVc7UkSSJ
         5yVFXhyWjVjkIHpIyzwDqXMTpnHOXX/46G+dFTfDGbivLnmuATROF6AERnCjq5L8Colu
         yZx1O55lq1aABik2yIsCvggxUu5cZR+5YuQPPMB18mnbutv8hWaZKsVrg4yEeT4asPSi
         /kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DqZOsYSImtx/m4Mvs5BzR/wAix+gzzh1o9aws2BZZFw=;
        b=Iz4GJZcJmKAmjE1hJUjRtD1NhZamgDd9WscVOcJKVK17n+dCzi+eHyuVNcCH0gG46f
         Ff2z4TrKPy3y9VR3mUHoBryfdegSt/GlZcnctCcE7ohrtg3sNNaXKY6yhRMlmW/9x2/d
         duNNWeCWMhi6K1q9E+T7OXI+wqJx/9PMATqUfKqcqcs63WcpeZOoERPbLWa8p1UoiumQ
         hN3Fz4nv/iV4C6DaRm36C23UM/BEN5N/HvYDdCqmcuj4mDjJCmNiDC2a06fUfxKTq6A4
         7VVbc/KdN4WGjyLz6umSoQKBgoy6r0papRk+zpBth4A4fFtzN3zjtb7Na74Wv6CgnvQM
         7hjw==
X-Gm-Message-State: AA+aEWYZ/R8EVshrFhhKPKwf/dvPtZlwtfIg7nIv+6+78anC9kTObZzi
        sTiL+Vy006pNidoF9/tArNw=
X-Google-Smtp-Source: AFSGD/W/ReuWcEnCHzObj/nwSamdgrg5xIjSf6RIL2G029Oyde1j3KFS0ezmWtSI5EPMca5xkIitrQ==
X-Received: by 2002:aa7:d602:: with SMTP id c2mr5902437edr.203.1542811402130;
        Wed, 21 Nov 2018 06:43:22 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id n34-v6sm13676159edc.34.2018.11.21.06.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:43:21 -0800 (PST)
Date:   Wed, 21 Nov 2018 15:43:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: refactor soc_is_tegra()
Message-ID: <20181121144320.GA6446@ulmo>
References: <20181121141204.22819-1-tiny.windzz@gmail.com>
 <2d534bbb-7b75-8521-bf88-36b52c918d19@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <2d534bbb-7b75-8521-bf88-36b52c918d19@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 02:34:57PM +0000, Jon Hunter wrote:
>=20
> On 21/11/2018 14:12, Yangtao Li wrote:
> > of_find_node_by_path() acquires a reference to the node returned by
> > it and that reference needs to be dropped by its caller.soc_is_tegra()
> > doesn't do that, so fix it.Call of_machine_is_compatible() to refactor
> > soc_is_tegra() whcih automatically manages the reference count.
> >=20
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/soc/tegra/common.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> > index cd8f41351add..0b40700b672a 100644
> > --- a/drivers/soc/tegra/common.c
> > +++ b/drivers/soc/tegra/common.c
> > @@ -22,11 +22,13 @@ static const struct of_device_id tegra_machine_matc=
h[] =3D {
> > =20
> >  bool soc_is_tegra(void)
> >  {
> > -	struct device_node *root;
> > +	struct of_device_id *match =3D tegra_machine_match;
> > =20
> > -	root =3D of_find_node_by_path("/");
> > -	if (!root)
> > -		return false;
> > +	while(match->compatible){
> > +		if(of_machine_is_compatible(match->compatible))
> > +			return true;
> > +		match++;
> > +	}
> > =20
> > -	return of_match_node(tegra_machine_match, root) !=3D NULL;
> > +	return false;
> >  }
>=20
> Ugh ... sorry, I thought that of_machine_is_compatible() looped through
> the matches. OK, let's stick with your initial fix.

Actually I prefer this one. Even if it is slightly more verbose, I think
it's much clearer what's actually going on. Also this hides all of the
OF node reference counting in a core function, so it's worth the extra
line, in my opinion.

Thierry

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv1bwUACgkQ3SOs138+
s6Eksg//TwuKgBqk1HtsPEhiWVFzTb5mDYtG8SXlwIO1sLcdML57mPszrfU9Og9J
H+XTtiJobofywHxbEmkKBstNx+DOe5T4B8nnvVFpeyvraN+1Jsey2lkt04+rh7en
UfAlPgtWdhif6BKObnvlBv7L1wkYOWQYfF3HNCafnjxMgLBsImjbpq90PU50ykgT
bnfDI2ArcrwpbL+WIHmWETLGIHdNJ2BGQMweMdYTgZyh5J5VVkvBc/L5TqLkk06M
aclKBhRCc1XgULqTmLmXpBFeAKtFakSjivqJyoowrAaGo0hoiAeaRe53pqknvGU9
j8T4pAT8RK5rC3luRjz7qTJrKAqVrarIVAZS+mh1Flv1c4Yl7gTmFUGVWCnn595v
0EACE8YSgxGKONXySC3Pmd2upWHbf+ZLg5RErkL9TYwqgHuG61RpyzaiMqNDLWlt
2cSz9MQw4VktnvFJwSqOBKCYEQKGPG5HlQsABQ//LSDpsHETyc/arj8kW+JKNzvd
NgFs7SNWdlpeHb4BKIy34zMwaSL079MFIa772G4xmlMt1GLIdwEae4syMbvl/4c8
i8yCPyIe/Mni+n43GLpCx0cvrVUSJLMoNobWxW+BVW1HBHJp4zn9u1lICHYohxas
SW9U0DrK2SBRyhXxnQP+px0uW3HriWYyzEXggKeTndseSWW4nds=
=rH1v
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
