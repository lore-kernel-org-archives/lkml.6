Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A94C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7A220671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7A220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbeGSSCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:02:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:39164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731832AbeGSSCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:02:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC655AD8D;
        Thu, 19 Jul 2018 17:18:06 +0000 (UTC)
Date:   Fri, 20 Jul 2018 03:18:59 +1000
From:   Aleksa Sarai <asarai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Eric W Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] pty: fix O_CLOEXEC for TIOCGPTPEER
Message-ID: <20180719171859.sn6a7n2mhmyx7mvs@mikami>
References: <20180719084346.GA2360@squirrel.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ul57f4zoo4fzqir"
Content-Disposition: inline
In-Reply-To: <20180719084346.GA2360@squirrel.local>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ul57f4zoo4fzqir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-07-19, Matthijs van Duin <matthijsvanduin@gmail.com> wrote:
> It was being ignored because the flags were not passed to fd allocation.
>=20
> Fixes: 54ebbfb16034 ("tty: add TIOCGPTPEER ioctl")

Acked-by: Aleksa Sarai <asarai@suse.de>

> Signed-off-by: Matthijs van Duin <matthijsvanduin@gmail.com>
> ---
>  drivers/tty/pty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index b0e2c4847a5d..678406e0948b 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -625,7 +625,7 @@ int ptm_open_peer(struct file *master, struct tty_str=
uct *tty, int flags)
>  	if (tty->driver !=3D ptm_driver)
>  		return -EIO;
> =20
> -	fd =3D get_unused_fd_flags(0);
> +	fd =3D get_unused_fd_flags(flags);
>  	if (fd < 0) {
>  		retval =3D fd;
>  		goto err;

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--4ul57f4zoo4fzqir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAltQyAAACgkQnhiqJn3b
jbSzZA//Z+P5kiceP6dNRh3Lvgl1Xqs98CVy8XZ1KTFsMRqAU6gF+hYOsmVAJy8A
Qf2mlDKFIN0+jKvO09dy7fUJJveTWUo2rAcSL9i6fK549lbYthV2KyeU4JF/31zc
Lai5n1bCEc3YpF7YQ+VF4uF8uh766EQDdhkA3CDcT9m/dwlHFd2QJ0w79L94UgIN
bwU8XdIL1NevPBGq9sQ8vWYwIOf+7R7PNE86UutDxBlJUJVuuToCLlVrIyb8bFMO
xj4vtYBusJ0bJnatQgiJ7wLv7/xPJUVV5RMju+ho4QI4LJ1hEZrtMaM221fqOkbp
M4E1ELDiLE4dkV79Qg/SbyqwYFQ3RvdsJ1rTQ7GRdPIHnPW7QQh2PaXSA3xn4S/p
6BEl+w4gyy7Ct+bnCEQTeS28G37QDUBKm9tWjDcFya6gdO1OfULSEANN6TTA2Qli
svq7ao2I11NWRPfgWzW/jflOzEKb1iWxKvolR00y4XBgZB0tXAFJU1OkSubby3FA
7IPKoGihFHKChT405hk9Hla6FxxAhdkFQ8Od4XWuqQIFTtEM10pz1o0KP4hD2Z0m
1YBIsh1+XpyT1TK5eaPtyr9RHJwfnlTsn/+VEMGDsEISQ/VMsJEBiptF5MZeY5TB
fcIEQvfRqvpyvOFJF1zCMgqX2zrJYN1+NXh7Ik5NTs2WV5RHejM=
=EUtR
-----END PGP SIGNATURE-----

--4ul57f4zoo4fzqir--
