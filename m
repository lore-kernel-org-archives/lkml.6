Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2EAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F146220892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBs8m2G8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F146220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeLEVJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:09:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33082 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLEVJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:09:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so21163116wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VQDin7JGSc3ZPWPhExhQGZc77SPAprQij9lLAd7C/eo=;
        b=jBs8m2G8FW3msmaU9pyRmoen4GtnA8Qgqh1qPolkfRZqk6/tR2W8BCLfhXA4v2m0WX
         JlIo2kDDoBzntoRYD0rbbk2a/1r1/MmQnX49D/xFjLvVKTn059zjOanjie9XoU5tPtD5
         9gIcWxi05uBirE0Stiz60MMGAFHG12klz77GqeTpnQHJ4p0xiH0un+7VA+nspQVlJ9+Q
         KJ0gUXMx3Hph5LEfgHMGfoREjdC7zWegXL4pw17q2AwAJirmdPijqoa8vZP/CJ0j/eOC
         9tpMYrv1Cl2jplhv7gRUwrwkgfFmpyZW+lfJsRcythP8dxBHJFWfcqoWl/AnYfvaUj9r
         fcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VQDin7JGSc3ZPWPhExhQGZc77SPAprQij9lLAd7C/eo=;
        b=KyrlJ+jg4+gYqVumty1OpQiGIOiYtAAaMl1J/FI0p5EnCcz9g28HSq680ZrpfpqouL
         lZsM6EBnCuQdLw232LBcbHCLXg2La/O6qtselppBzdUzF0Zm7k4GCq2IQaZ6nS+uKnVR
         kMKJLD42jJiyakd8OHVuQl/p/RcV81PNpEqSvGt2z7+59VMjIt9ux8ubJOWKVWAS7dV1
         2IiBnKXZQ387V4YrG1kPYn8GmNrD2kO20K+jEAsxQ1RAxb8wxyf8VKsSE0gE58LG3FoC
         yEDgxDCl0ip8esmesZjUTkj4J2iRmUesg79LgtIIsU6RJ0YymeAUBMAoGk76qrJ3cxJ7
         T4VQ==
X-Gm-Message-State: AA+aEWYP7LlYIKRqVjPbPDprA7jwDI5YvoQ2f4KXX86JLe8bUJ1AY+1v
        +F1I0oSgzil5WAZMqgdtkPpEWNDfubA=
X-Google-Smtp-Source: AFSGD/Vo2b1wj+sFRxNfc6cxiBriNoaYzBJz++aRez6k+8jDafmH2jvYgLkihQQvOlTTWJr8SE/DDA==
X-Received: by 2002:adf:be8d:: with SMTP id i13mr24043049wrh.235.1544044194815;
        Wed, 05 Dec 2018 13:09:54 -0800 (PST)
Received: from peano (host93-127-dynamic.50-79-r.retail.telecomitalia.it. [79.50.127.93])
        by smtp.gmail.com with ESMTPSA id g188sm14922020wmf.32.2018.12.05.13.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 13:09:54 -0800 (PST)
Date:   Wed, 5 Dec 2018 22:09:51 +0100
From:   Sicilia Cristian <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bryan O Donoghue <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH 1/2] staging: greybus: Align function call parameters to
 parenthesis
Message-ID: <20181205210951.GA24993@peano>
References: <cover.1543956271.git.sicilia.cristian@gmail.com>
 <6087f45a8a4544fa6c671d8b42928fb48194e66e.1543956271.git.sicilia.cristian@gmail.com>
 <20181205084603.GA4987@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20181205084603.GA4987@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 09:46:03AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 04, 2018 at 09:58:14PM +0100, Cristian Sicilia wrote:
> > Aligned some parameters to the previous parenthesis.
> >=20
> > Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> > ---
> >  drivers/staging/greybus/loopback.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greyb=
us/loopback.c
> > index e4d42c1..1085e06 100644
> > --- a/drivers/staging/greybus/loopback.c
> > +++ b/drivers/staging/greybus/loopback.c
> > @@ -638,7 +638,8 @@ static int gb_loopback_async_transfer(struct gb_loo=
pback *gb, u32 len)
> >  	retval =3D gb_loopback_async_operation(gb, GB_LOOPBACK_TYPE_TRANSFER,
> >  					     request, len + sizeof(*request),
> >  					     len + response_len,
> > -					     gb_loopback_async_transfer_complete);
> > +					     gb_loopback_async_transfer_complete
> > +					     );
>=20
> Ick, why do this?  That's not really needed.
>=20

Ok, better to leave it unchanged

> thanks,
>=20
> greg k-h

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJcCD6eAAoJEAnJ2Lo5pAXyvhQP/16vTeHBKpmXlijHktcypkxp
wIR5wyZLlyiazKu5W1COZU5xrxDyWj3R8X+ViUn0MMGBQkDejYP6YvAm0VvgeKp3
Wr3kXlqkAj+5Q/GrRA1yX9UonxPyJhohYxW0OVzngr720xKg8WbTNRpVMBp2FVdD
OUNAJyB6+Vt+sEh0H2vJHlkH0+/cCQv0+orqQDpO1dfmswYmi2qExFH/EJ6x20qC
GIBLSqy9UR9T52dDjB7ehG8AupYefEX7HTyBfuCMn1y7YYGZWg6ajGwELlQKD9ir
AB8E5UIvA3a1sgRmSRcjgNKED4xLE7RSWqhRpX+Dg8QWtGnDucuG/bTY1pjd7mW8
LpFvsOppo0ojWeRnX+tWHj+mUzOGJxB1sjIGYkpp5eJRUe572/srPg+hZLWMgTen
lgRx6oAok8aQ0F8Gy3IhC2lFsZe7ULG7yjVjb1oUjxhZG3bE6seBEDU7JEscjv8U
en+qjML/zleJMMq90p0HaH7nuskGScdltvEnIMi+lQJ0rJnBJWPup692k2LAUbB4
DLYV2heK9I9YhKhF580MZWQoRoCQ1gjzUBURYLYxd26CtRE0pDld8VmHzhtB+t7f
5LfnifZz6ZY2TlHWjMe9V/O3UxSj3U1XmAteA/hPfif1I89lY2oss1qVdrjx4pOk
kE4huxRgl9aL4Mpk8Mt6
=8W48
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
