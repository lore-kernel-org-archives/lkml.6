Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0596C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813882084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZpC51WIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813882084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeJEOBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:01:00 -0400
Received: from ozlabs.org ([203.11.71.1]:38991 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbeJEOBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:01:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 42RLMG0SGFz9s4s; Fri,  5 Oct 2018 17:03:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1538723018;
        bh=iGfXefrW3GtICYauZ3CU0H8ZZv2YnDzee2iX6qnY0uQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=ZpC51WILVF2O5PrVDOrM0SG4h4yGhFhuKtBMptPBIV2KktBFXs993QnaKOVztD+jW
         oWpg5Dk5XoLT15KFOguO3fVP18+IfK0GWuLc16CU/nRiJNLAxpTYKDwBU4WKVXNudr
         fXTaMj0BkBpmSSt5X0cj1a7sDutK7Pl34UjZi4RU=
Date:   Fri, 5 Oct 2018 15:09:59 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        prudo@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, bhsharma@redhat.com,
        kexec@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v15 06/16] of/fdt: add helper functions for handling
 properties
Message-ID: <20181005050959.GP7004@umbus.fritz.box>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-7-takahiro.akashi@linaro.org>
 <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
 <6a8d3ddb-c3bc-c044-4d6c-55e110d89e72@gmail.com>
 <20181005050627.GL32578@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="movZSYdJ761vCHaE"
Content-Disposition: inline
In-Reply-To: <20181005050627.GL32578@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--movZSYdJ761vCHaE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2018 at 02:06:29PM +0900, AKASHI, Takahiro wrote:
[snip]
> > >> +{
> > >> +       return (strlen(prop_name) + 1) +
> > >> +               sizeof(struct fdt_property) +
> > >> +               FDT_TAGALIGN(len);
> > >=20
> > > Looks like you are using this to calculate how much space you need to
> > > allocate in addition to the current DTB for a couple of new or
> > > replaced properties. I'm not sure that this calculation is completely
> > > accurate. And it is strange there doesn't seem to be any libfdt
> > > function for this already. It would be simpler to just add some fixed
> > > additional amount.
> > >=20
> > > Maybe David G has comments on this?
>=20
> I'm not quit sure why it's not that accurate, but as I said in a reply to
> David's comment, I will take your suggestion.

I think it is accurate, but it is not robust.  It might not be
accurate if we ever make further tweaks to the libfdt format.  libfdt
is supposed to abstract those changes away, but if you make
assumptions like this, you break that abstraction.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--movZSYdJ761vCHaE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu28iUACgkQbDjKyiDZ
s5LH/xAAh/vDxj2xanbrQLZ61bxAfKiW22OR2z7VIuRvPfYqjJaXsEal1uX1BNYW
qYhYO6/VqBHvI56fs0EDNQT5PSc5NWK4v2xHgm+SfJACkNhMvHHLaWxFPw3pTSHT
+X4HjyiFV4FLw3lgP8AyuL/1ZHUkEEJyLvfUtwEcZLQ7gyO7KXJYk8tvZaZTbnNy
U3vbrwlrJ8FDXtuV1udW4nMAOV5uWC3QjjERbz/tIllajFNV4JwUAsIpIN79VDRn
eSMoKFQwzlLUjQ0sqSEb0fLu8EDz06hS2jJ6E33qIiUsZmvK3tJuriKbRAXaKZ4C
ZZ7o1x8g0Sgwjzv1Thm4fVB/eG/b4aMzpNzcEPoiT8n3cMUEsA/2Ukxfl1DtcJC/
+H1X/hnQcJlltualZ5AjRlslJ4BA15w2GGTOlVCk9V9EYsp49f8oItATVoR+EUOj
pau5CqQyT6CwRDqvAajsRNOr9+zIAfNS8WZo75Twhj7iqBGxodFqaCNayvJtX93U
oASIp61DcVaSohRqOaaBoQUS0ye+xMEbDGr1gOLZGDoQI9sS0mElWOHsN967Ua/q
xAxyB3jrNbQPp/qFqRWcq6F+Dsnbp11wONiao1wDEQCx4z1EKnRZdIPyari72B65
vUKObiGBU+XRUE6tkzN/YWTGbtzVIbjdKKc5P53oM4lVh0PnZzU=
=MPmg
-----END PGP SIGNATURE-----

--movZSYdJ761vCHaE--
