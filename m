Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22EDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBED2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pm2saDLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBED2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbeKVBau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:30:50 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39460 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeKVBat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:30:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so5118310edt.6;
        Wed, 21 Nov 2018 06:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3zYuetRRSt4I8SVzeYgmJzVR+kUFiVYNC6hL6vvXBio=;
        b=pm2saDLtu9hxDbBpiXP2Ir6T60on3/nvF1skHKArNr79aiazvmCcSRmgA+09pb0wRt
         C3mr3jTu+/Q26S+/YWg4nFrFzwgtZGbfrD/j/6/yCQymnrPhwHsU7mIb1se5/f23H4ol
         fGh8/Cv56OgNep2DaxNcfWzTYWXNY/deCbChyPhSXGVGGdW48CbzKHeQN+YiYpw2enaw
         BdiSOxknXy+0JX8UYfkvwxfyDIQUD8bJejpkW7GhHigaN+9+GZUVRX8xK5RocTAW6ilM
         JfHgn2TgcGiRt1Dyr1rl1wVQCwg7IxHrEkMDULzPuCqDFgkA4LGdOi4KOuL9MDu7pdc8
         KAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3zYuetRRSt4I8SVzeYgmJzVR+kUFiVYNC6hL6vvXBio=;
        b=dLscdso3y7kaec3BpuCBWmOaL/soPkInuLo2i0c2HNFoHgCej+J4ZU5BE+ec7iEHcc
         300+JKPznsXrGFGGsJ5PbrQU05H1uMtiK+5aUuN9a0qHknm0h6Rhq0FTqGSr5kVKSHkZ
         Fp5uYQVGsY7Ro1kyumQB6n/2VrUpzkQ0CQXEDpElPwGmf/im4n+9WG8IectLkPeafR1f
         7VugknJFa8yMykFSoIjyPclvbn08Uc01G9wbRipAOwTqot0ZZKMNnHMfUjZZYkzYylpX
         dGAcT/blIu/gIkiHc8P9kTmwnztoaph1wbk2W0CYIZCggpTyd08s92MGnsknFLkoAUcI
         3FKA==
X-Gm-Message-State: AA+aEWbR3SnlBNqY5tB8dz4zCjPsoublo340xka8Uht3s89lnqYmgX7W
        uTfByjS57oy8Sy7j1IYBfi+ce4TS
X-Google-Smtp-Source: AFSGD/WOuoWtz0BnYD3YDBnmQoKnxjspffg3n5vPt3UoIIYZToAJqIr32pp6q6j0/8ctj5lZkLwKbA==
X-Received: by 2002:a50:abc5:: with SMTP id u63mr5915171edc.87.1542812162640;
        Wed, 21 Nov 2018 06:56:02 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id c2sm13147286edv.14.2018.11.21.06.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:56:02 -0800 (PST)
Date:   Wed, 21 Nov 2018 15:56:00 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Frank Lee <tiny.windzz@gmail.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: refactor soc_is_tegra()
Message-ID: <20181121145600.GA7739@ulmo>
References: <20181121141204.22819-1-tiny.windzz@gmail.com>
 <2d534bbb-7b75-8521-bf88-36b52c918d19@nvidia.com>
 <20181121144320.GA6446@ulmo>
 <CAEExFWswqoObtnjezRf-3u1ssJ04cwDaggg_HLXju72mannZ6w@mail.gmail.com>
 <bb47ae0d-3607-f396-b9e4-77e25777d6c2@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <bb47ae0d-3607-f396-b9e4-77e25777d6c2@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 02:50:54PM +0000, Jon Hunter wrote:
>=20
> On 21/11/2018 14:47, Frank Lee wrote:
> > On Wed, Nov 21, 2018 at 10:43 PM Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> >>
> >> On Wed, Nov 21, 2018 at 02:34:57PM +0000, Jon Hunter wrote:
> >>>
> >>> On 21/11/2018 14:12, Yangtao Li wrote:
> >>>> of_find_node_by_path() acquires a reference to the node returned by
> >>>> it and that reference needs to be dropped by its caller.soc_is_tegra=
()
> >>>> doesn't do that, so fix it.Call of_machine_is_compatible() to refact=
or
> >>>> soc_is_tegra() whcih automatically manages the reference count.
> >>>>
> >>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >>>> ---
> >>>>  drivers/soc/tegra/common.c | 12 +++++++-----
> >>>>  1 file changed, 7 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> >>>> index cd8f41351add..0b40700b672a 100644
> >>>> --- a/drivers/soc/tegra/common.c
> >>>> +++ b/drivers/soc/tegra/common.c
> >>>> @@ -22,11 +22,13 @@ static const struct of_device_id tegra_machine_m=
atch[] =3D {
> >>>>
> >>>>  bool soc_is_tegra(void)
> >>>>  {
> >>>> -   struct device_node *root;
> >>>> +   struct of_device_id *match =3D tegra_machine_match;
> >>>>
> >>>> -   root =3D of_find_node_by_path("/");
> >>>> -   if (!root)
> >>>> -           return false;
> >>>> +   while(match->compatible){
> >>>> +           if(of_machine_is_compatible(match->compatible))
> >>>> +                   return true;
> >>>> +           match++;
> >>>> +   }
> >>>>
> >>>> -   return of_match_node(tegra_machine_match, root) !=3D NULL;
> >>>> +   return false;
> >>>>  }
> >>>
> >>> Ugh ... sorry, I thought that of_machine_is_compatible() looped throu=
gh
> >>> the matches. OK, let's stick with your initial fix.
> >>
> >> Actually I prefer this one. Even if it is slightly more verbose, I thi=
nk
> >> it's much clearer what's actually going on. Also this hides all of the
> >> OF node reference counting in a core function, so it's worth the extra
> >> line, in my opinion.
> >>
> >> Thierry
> > Hi Jon=EF=BC=9A
> >=20
> > I like both, how aboout you?
>=20
> Yes fine with me too. However, looks like there is some formatting that
> needs to be fixed up above. Please make sure you run checkpatch.pl on
> your patches. Otherwise ...
>=20
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>=20
> Thierry, pick up this version if you prefer.

Yeah, I noticed the formatting issues, but I can take care of them while
applying.

Thanks,
Thierry

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv1cf4ACgkQ3SOs138+
s6HURxAAgZLF0ApqMUdW8u+cYt5TdoxFRNBxdnCers9NjotDx930n4C8esF3FtGB
vORNyNEkCwuetSOBV5XaMkd1ZxedFfNPhD835gQD4wyRrqBABtDxn1SZ+M/TzLE3
ZPELjivuvfSKSbp6yDGOrgqdOIzF54WhRaCzgs65QOQp9BMGoAwESDfBsz5l+h3g
kHbYGuhCFrOd4oCzKyxMtsmUMFgkdqeGlzlXhDbb1NuixkeNK1abgUgElRVAliwO
lwYN7suaRwOAcgeZT6kQwykwgUcATJB82g592wvbkAKj13gSgxcpnt6mblFk63ko
cXUK5wIH3FUu0bn+g/c2eJl5zkUSq0B/0Uyqcxne54q6/Bw0s4ds4sQ2MLIwWduT
hSVvXCj6E1Y1iEMNey/Q5sH5Sl5QU3xdAuAqUuooAzP9Y7Q6eOszRBbu6c1dSfbw
NRFLQANtSr9hT05W64TKwHF52O4wIkLM+sHjBCEWS1YA7sLcrjoaErpXlcAkC3mv
g+uWU6vMD54Ipu8VEROROiyZj7AYu9/ndwm8vZtyZyf3/De6CFUGkZ7AVw34ZCNP
jL5VtdqtfO5n6pggkz2YIxmZbU75xg8vNvMGMbW2Xi3jhhkIcsxpYWGhkuTvG0rn
sOmZD1nrgrpC4NJukaWv6EYTdwsPGoT53hJHFw+NYiRHYXsfsoU=
=zobO
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
