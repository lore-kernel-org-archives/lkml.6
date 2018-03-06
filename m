Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1605358-1520378291-2-10946574989214742775
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520378291; b=hJ1/SXXdhM1VnE7hfso61tNWvTOf7oBsOtnJ4NV51ZF3wJs
    3NgVTF28vl0WQdx3QE8egnMMVY9Q1T7B/y4dk5PzxJ6pcbA/2+/KamaR7kp7FoOp
    OqPTAxgDZX2I/Hj6m/zIlQPO4sAaY8zln/nFUZTcrZxMIq2s1EPvH5XXmX2TbPfp
    AwlLHOQbMdlEz+SiNHsV62ps2+m1MuzTuzp8WDlsO72DWCQ2q4JHbsr72Y+vRZ8T
    WzucxW6tmI47MkAb/ELHS+cO6aZ0rxx/0llqwd15Mi1pDg8jotAxejDQUHBa6dhS
    VhYLWMKaDAUogl6UxjQ9X/jA245Ypq/dyYLtgRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520378291; bh=bRriMp6n2K80uqw9Rbb57R/p+k
    1Hgqkb7mzJWq9aq08=; b=YHh2jeWxlm11ovW/YzsxoTsxlB1pXVofQMZLLqUNwV
    rFUg3voxwOrxIr11++rENBv8rsqT6M+vAaxBFSb7bifgsB9WCFQvx8CUDONmZZkP
    Jndi2wwy4rKk1vmRmgrwnguE2h6CCLSltl1cMzDgUEUU2l1ZkPCVZ1UabbfGIFGY
    AEyukcp/6mcexreU75Uy3MPbtScLDePcPpjXmqAw4SToT1BXJ5BeoesxxTQsJEDe
    e0Y9x5BumcDcVjFunKWCP+SYYax2w5Tw9Qx/XXeFh0w6kW3aDSBIOqoWqMJgjkoU
    3U1MuDkUMeERhuWeBchiH+YtWgw3kxlc+rpRt9xjfwDg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbeCFXSI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 18:18:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53651 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753971AbeCFXSH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Mar 2018 18:18:07 -0500
Date: Wed, 7 Mar 2018 00:18:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        cyrille.pitchen@wedev4u.fr, marek.vasut@gmail.com,
        boris.brezillon@free-electrons.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, dedekind1@gmail.com, tharvey@gateworks.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] ubi: Reject MLC NAND
Message-ID: <20180306231805.GA28183@amd>
References: <20180303104554.5958-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20180303104554.5958-1-richard@nod.at>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-03-03 11:45:54, Richard Weinberger wrote:
> While UBI and UBIFS seem to work at first sight with MLC NAND, you will
> most likely lose all your data upon a power-cut or due to read/write
> disturb.
> In order to protect users from bad surprises, refuse to attach to MLC
> NAND.
>=20
> Cc: stable@vger.kernel.org

That sounds like _really_ bad idea for stable. All it does is it
removes support for hardware that somehow works.

Now... Yes, handling flash is hard, MLC NAND is worst of the
bunch. But...

Read disturb is not unique to MLC, right? Happens to all the flashes,
its just that MLC has tighter margins for error.

Power-cut. UBIFS is just not power-cut safe, right? My notes say that
power-cut during erase could result in flash that contains all 1s, but
will start showing errors very quickly. Again, not MLC specific. Can
be solved with battery...

(And yes, there are some problems specific to MLC, where parts of page
need to be written in specific order. Not sure how it affects
ubifs. But it was not listed as a reason for the patch.)

> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/mtd/ubi/build.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index e941395de3ae..753494e042d5 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -854,6 +854,17 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi=
_num,
>  		return -EINVAL;
>  	}
> =20
> +	/*
> +	 * Both UBI and UBIFS have been designed for SLC NAND and NOR flashes.
> +	 * MLC NAND is different and needs special care, otherwise UBI or UBIFS
> +	 * will die soon and you will lose all your data.
> +	 */
> +	if (mtd->type =3D=3D MTD_MLCNANDFLASH) {
> +		pr_err("ubi: refuse attaching mtd%d - MLC NAND is not supported\n",
> +			mtd->index);
> +		return -EINVAL;
> +	}
> +
>  	if (ubi_num =3D=3D UBI_DEV_NUM_AUTO) {
>  		/* Search for an empty slot in the @ubi_devices array */
>  		for (ubi_num =3D 0; ubi_num < UBI_MAX_DEVICES; ubi_num++)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqfIa0ACgkQMOfwapXb+vJ6ZQCgqFe1Pe55Q2kgHjXoMClPat83
iCAAn2HkaKl7ZEWEuffl0iDyWmSFI405
=OGEp
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
