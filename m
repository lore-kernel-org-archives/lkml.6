Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8D0C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D142923F8C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D142923F8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeGBSYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:24:38 -0400
Received: from sauhun.de ([88.99.104.3]:43994 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752808AbeGBSYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:24:36 -0400
Received: from localhost (p54B33579.dip0.t-ipconnect.de [84.179.53.121])
        by pokefinder.org (Postfix) with ESMTPSA id DF80D56A485;
        Mon,  2 Jul 2018 20:24:34 +0200 (CEST)
Date:   Mon, 2 Jul 2018 20:24:34 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, peda@axentia.se
Subject: Re: [PATCH v10 5/7] i2c: fsi: Add transfer implementation
Message-ID: <20180702182434.5wxxszpgpf6wergl@ninjato>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023823.i3fmdegn2sric5kx@ninjato>
 <6713efb9-c4c3-f648-a1e9-7918110091e4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yhxnagpnshnqsemd"
Content-Disposition: inline
In-Reply-To: <6713efb9-c4c3-f648-a1e9-7918110091e4@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yhxnagpnshnqsemd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > +	if (msg->flags & I2C_M_RD)
> > > +		cmd |=3D I2C_CMD_READ;
> > Since you support MANGLING, I'd think you can easily support
> > I2C_M_REV_DIR_ADDR here, too?
>=20
> Hm, I don't really understand the purpose of that flag. From the docs:
>=20
> This toggles the Rd/Wr flag. That is, if you want to do a write, but
> =C2=A0=C2=A0=C2=A0 need to emit an Rd instead of a Wr, or vice versa, you=
 set this
> =C2=A0=C2=A0=C2=A0 flag. For example:
> S Addr Rd [A] Data [A] Data [A] ... [A] Data [A] P
>=20
> I don't think our hardware supports this type of operation.

I'd think something like this should do:

	if (msg->flags & I2C_M_REV_DIR_ADDR)
		cmd ^=3D I2C_CMD_READ;


--yhxnagpnshnqsemd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAls6beIACgkQFA3kzBSg
KbbaORAAswydmxmWNfNqtkPEkp+nF0CxGMkNxdsL0sGKq/fRpmUFApwZAu0f8eBm
z3mezjFVsYO99lb4WU4dzSWZgOWx293ruYoFLjza1CE3Vf5HQTpRZCM0eWSWP3/T
tmIIJwivXUbjEuhTQY4SJCAsNZyBMM6ehBotdvU5c9PDnhEqLoMUVJCX/aPIuJLr
AgDamRyUH2crRMx7kaP9fazU4UAGfOlljslFai9zf7+ojgc9YknXTy9tDhUi0EeW
XeRg6yiFygf6obS9d0E3VI3PiFckbqhM9Sq80YeHPNGAq7uQeW98lBRfy74ln+jh
SOWcP1sDz8quX0Hm0Hh5sSKW3GFqviovPbh+wVbKQDik71/i3vS98gcQgOEhYae4
6kUSFfk756f0qfWlzYNIUhABYaEgjOjzpkGu8RIbc2IxD9IAz4CwQAuKKcyuLqMt
QKIx8/g4IOHZlYTYL4VGZrcQ7hEkiBppUefA3vZBP159lByFU90ASCh3VqnDJ0VI
cBJdGkTGHriDOrfV+jGMh34GJtljDPfpYNoeh9wpqfvpXXf+Y29Nk73zHhJo4TWC
3ZRouWXbVyQT+AQGJCR7X6I3m4Vs3FJgD0nlViaDoD0hroQTI0R5p5mtiK3sqWhV
Zz7BPeJ9hiH/TsbgLqyTrWjrGnW+atIDSYnuas/q3qeuOCj743E=
=tcvP
-----END PGP SIGNATURE-----

--yhxnagpnshnqsemd--
