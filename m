Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEC6C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 19:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E84208FE
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 19:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7YF81dK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E84208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeHSWvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 18:51:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44886 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeHSWvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 18:51:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so9328674lfb.11;
        Sun, 19 Aug 2018 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3qcH3GSNYYORXngoLsreulqygMpgePkyua1LtPlglY0=;
        b=a7YF81dKJ++3vOG0HYa8vTIJzxudnnrOdRsyYGFYH/VFzORbAWV3zKY0IrUUggq+DW
         E9M4NLpImpm7YOf+v5qxjIRO9yKaBrQEH6AOu25nlh48A9AE6RV3NGPBfDKKh8fT7WWX
         /EcA9jMTujxmCvyX5B+OOB0rMDacyYjdWJtpyUR0U4d6VI3UgEHyyz49XOjmoZWNJFTF
         WSazwk5ld0rUX2EtwDswcPfG2pn8qIOoNGKlLom43JzgpMcqZAlq/LUztoTaGYMzS9cy
         INJakRNJivzgJFZjoEQfsl1uhQk0CNQal/eYwdzJF1V30M1k+lDVPv8ghmTj40dy34Kh
         qcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qcH3GSNYYORXngoLsreulqygMpgePkyua1LtPlglY0=;
        b=LJOjNKDKQ8BnlYO0N5jKlig8gvGG2PCwW+kP8F/u1dCvUqfBafdIhZnnsPR+xjJHHq
         XNV6qGKz2QTFw291M2nz7NaJp6AGcLTybNHsX+TSGec8HthiexF5eNx5fGdINFEhVxm6
         0Vr0SwSs/Ewfdy4h9nqhkR4OhflEAbPd4cXq+Ii/ZCBXjOq57msVPQJ4NY0zy7IL5HK6
         FRDAwGAZ6HxZEAsRS4VTiqu6h9dUDbhe9ZB396L4hGS6Tfdu/xPs314df3MnNMNfS468
         oLLeVBKK8E9Jwe0ca5Vr5AydgrxdnNjJdQUue/gDJjXzIsyykh8OLDwt09TQcO8H6oLe
         M8Xw==
X-Gm-Message-State: AOUpUlH+DGc6ucf/+wv4Iv3OfAA1cBOM4WJEzp7Dum+FPklbvaQf7B0P
        W3uo8g7LgVFsjNwZXwtf6Zc=
X-Google-Smtp-Source: AA+uWPwsqRfKXQQ1S8kdyyFNwNcJLTa7VWUbbf1jJS8LIMUW7P3GUTTTsQIoe28s+NC289iE2zj6vQ==
X-Received: by 2002:a19:d484:: with SMTP id l126-v6mr26352851lfg.28.1534707504782;
        Sun, 19 Aug 2018 12:38:24 -0700 (PDT)
Received: from gmail.com (c-2ec26f18-74736162.cust.telenor.se. [46.194.111.24])
        by smtp.gmail.com with ESMTPSA id n129-v6sm1428268lfb.3.2018.08.19.12.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Aug 2018 12:38:23 -0700 (PDT)
Date:   Sun, 19 Aug 2018 21:38:46 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: add support for mcp3911
Message-ID: <20180819193846.GC5217@gmail.com>
References: <20180808080917.2427-1-marcus.folkesson@gmail.com>
 <20180819200257.3e465759@archlinux>
 <20180819191751.GB5217@gmail.com>
 <20180819202943.66ac0a72@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <20180819202943.66ac0a72@archlinux>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 19, 2018 at 08:29:43PM +0100, Jonathan Cameron wrote:
> On Sun, 19 Aug 2018 21:17:51 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20
> > On Sun, Aug 19, 2018 at 08:02:57PM +0100, Jonathan Cameron wrote:
> > > On Wed,  8 Aug 2018 10:09:15 +0200
> > > Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
> > >  =20
> > > > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > > > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> > > >=20
> > > > Co-Developed-by: Kent Gustavsson <kent@minoris.se> =20
> > > checkpatch points out..
> > > Co-developed-by is the 'official' form of the tag. I'll fixup.
> > > (first time I've seen one of these ;) =20
> >=20
> > Yep, I also noticed that checkpatch is not Co-developed-by-aware yet.
> > I tried to fix it, but Perl is just such a terrible language that I
> > considered it impossible.
>=20
> The version in mainline seems to be aware, it just wants
> Co-developed-by not Co-Developed-by!
>=20
> (lower case d)

I just noticed that the tag was renamed from Co-Developed-by to
Co-developed-by in e474785a12b46230ecf9f3663166b0de1175bcdc.

I must have been reading the documentation from an older tree...

/Marcus

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlt5x0EACgkQiIBOb1ld
UjKiHBAAioQitq9+jKw66ybaJ+6b9ra5ZEJ/Qpvi6/rWdqeq7WkENXltwhZoXy7p
Uf0H2iJJ328XfNNZ+l5Q9eVPq8qcJzBQhwN+pKB31ISWf+4SCMYO/u+q7VliKL8j
peANbHBexsQUsvXsnKEEIr0HklmzDAXnhKk0cGeVkXMMRvhx5ymy1bxfWPHW5WZD
gDEwgUl5mMYqkoNpEN2UZWL2XSToO42zel7c9AOFrBxfxNTy3fpkr2DXW9iRjkUI
XSQcfVQCzcn9rzggS9V3EozsqAmtHV4AkJkQpLbmTYOCfC5kW/HLJ+oAm1D31nO5
l8tFKu8HznsuGDAu6zS6F1ApLxCUVTy1WP2TwjIHxr/VJ+Ms3qnyiFNI3L6Qu84a
DW6q8Z0t1dKjpdH+z4S2jeH0in09Gxgb66pl/qno4wxZipgCrYZ1WJhAr31lHdA3
kIPnA4j9D60u5iXJb0pqf5ATbGfLtLSQ2feupXkV90XvOouTxeDYFq3wYt+wiRjw
LvNq85W6WJD9D3KEUff+IDdpeJbrkpkYNBiLKu+E2t/XNw+K5SVvTSbZuar1VjIW
PJFzCIhcSNDMFLS9VBXrJBSOPSMeywfBZtQzNzsscuaEjGCqaKKIMH8OjbvHALLi
MmoXiL5WH7gIyiiJIjSzdKDxJfah56hEqIUcL29ZspPfpC6OsVc=
=fUli
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
