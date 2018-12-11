Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADBFC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755CA2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755CA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeLKRmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:42:45 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49135 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKRmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:42:45 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6F4F3807C8; Tue, 11 Dec 2018 18:42:39 +0100 (CET)
Date:   Tue, 11 Dec 2018 18:42:42 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / sleep: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181211174242.GA11538@amd>
References: <20181211162048.21906-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20181211162048.21906-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-12-11 11:20:48, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  kernel/power/main.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>=20
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 35b50823d83b..98e76cad128b 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -318,23 +318,12 @@ static int suspend_stats_show(struct seq_file *s, v=
oid *unused)
> =20
>  	return 0;
>  }
> -
> -static int suspend_stats_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, suspend_stats_show, NULL);
> -}
> -
> -static const struct file_operations suspend_stats_operations =3D {
> -	.open           =3D suspend_stats_open,
> -	.read           =3D seq_read,
> -	.llseek         =3D seq_lseek,
> -	.release        =3D single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(suspend_stats);
> =20
>  static int __init pm_debugfs_init(void)
>  {
>  	debugfs_create_file("suspend_stats", S_IFREG | S_IRUGO,
> -			NULL, NULL, &suspend_stats_operations);
> +			NULL, NULL, &suspend_stats_fops);
>  	return 0;
>  }
> =20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwP9xIACgkQMOfwapXb+vKOTACfQkC9w7fYmHq5sQtRwojm06t3
AlIAoJLYeRpmPZXu2SVWl06YDMp3n2zx
=m7Lp
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
