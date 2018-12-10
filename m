Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F45BC07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 02:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D322081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 02:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WgO7W59b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D322081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeLJCF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:05:29 -0500
Received: from ozlabs.org ([203.11.71.1]:38047 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeLJCF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 21:05:29 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Cmck4QDbz9s0t;
        Mon, 10 Dec 2018 13:05:26 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544407526;
        bh=/65Qe5odgMOE8SK3sgD+YqVdnybA6JRp/8g4DTTgJpk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WgO7W59b3C+da0pO37xifQ3bvtUdtRYs4BwjdKLlx+Imx2orFOOlQ3ijcxPcPdaVy
         i7clQybLA2DjJuY+dP160vJGb1KCxA73brZs+pmjSINWly4T4n1AQd+y4BdgvLthWU
         b/zl7uWuf3EfajiIe5VM26dxxPRrRVNYfh0hmLg2UwAQwQm1aAVPNcfQkMMDeKWhTl
         6mSYAOhNvXVwlHfsPm3G7lN+WEqZEM6V6a2cDRiilVWk5QSgKkZY8eGyUqMaCA0mZb
         K5nfbXau9r9GC6MF+UgQcVqIVywwLuZefzJKfRoFOzRWMcJ+0PQK0X9NMHP2peEa7/
         ijuwyf32zQI7A==
Date:   Mon, 10 Dec 2018 13:05:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>
Cc:     sd@queasysnail.net, andrew@lunn.ch, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com
Subject: Re: linux-next: Signed-off-by missing for commits in the net-next
 tree
Message-ID: <20181210130525.2586bfac@canb.auug.org.au>
In-Reply-To: <20181209.165443.617494663676711708.davem@davemloft.net>
References: <20181209232722.GA4425@bistromath.localdomain>
        <20181209.163152.1641648923109797638.davem@davemloft.net>
        <20181210114848.3f726482@canb.auug.org.au>
        <20181209.165443.617494663676711708.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9+/ZkCprHoHTAepI2YZ/Gm="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9+/ZkCprHoHTAepI2YZ/Gm=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Sun, 09 Dec 2018 16:54:43 -0800 (PST) David Miller <davem@davemloft.net>=
 wrote:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 10 Dec 2018 11:48:48 +1100
>=20
> > That is fine as a last resort, but it is probably less disruptive to
> > find these things before you try to push i.e. as part of the "apply the
> > patch" otherwise you could end up having to rebase a whole lot of later
> > commits. =20
>=20
> I meant to imply that we should do both, something I do pre-commit
> and something that double checks again when I push.
>=20
> Sorry if I wasn't clear.

No worries, belts and braces :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/9+/ZkCprHoHTAepI2YZ/Gm=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwNyeUACgkQAVBC80lX
0GxjiQf/WzApR3hqpqkxRKgT0v1hr+M9rt6VQl2D6Kc40LOEo/j8dHJBwuei/W8n
1WnRPHkvIcaV54u2srwUSZAnkwell7qh0bgePO1S73xQhMxuAeRcIYJjaB6fsh5c
OGdVcQFeRB4Z4yUsTkMgP2WPwKlolFNdbof8MKR/iP0YTKYH3+c/nzREbYGiqFA2
C6wlLIj3MlCYa0NZrsFmtqNsw5+LDskM0uQPx4nERsjSD7LsTUWjxI4wHscYVVGx
US2GnU1UUo06Ndh2113ewVWEBJNgCIuDf5aBBIs6rbd6+8SVHzZqdKqccxhIaO1I
g/bXxOvlR/2ppp4CRwXgkaKP+jOrmQ==
=pHwH
-----END PGP SIGNATURE-----

--Sig_/9+/ZkCprHoHTAepI2YZ/Gm=--
