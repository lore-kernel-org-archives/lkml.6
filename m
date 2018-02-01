Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeBAQHH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:07:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751760AbeBAQHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:07:04 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692B12178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 1 Feb 2018 16:06:58 +0000
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: Watch: Avoid duplication of bits in
 mips_install_watch_registers.
Message-ID: <20180201160657.GM7637@saruman>
References: <1514892682-30328-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GeDkoc8jIzHasOdk"
Content-Disposition: inline
In-Reply-To: <1514892682-30328-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GeDkoc8jIzHasOdk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2018 at 11:31:21AM +0000, Matt Redfearn wrote:
> Currently the bits to be set in the watchhi register in addition to that
> requested by the user is defined inline for each register. To avoid
> this, define the bits once and or that in for each register.
>=20
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Both patches applied to my 4.16 branch,

Thanks
James

> ---
>=20
>  arch/mips/kernel/watch.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/mips/kernel/watch.c b/arch/mips/kernel/watch.c
> index 19fcab7348b1..329d2209521d 100644
> --- a/arch/mips/kernel/watch.c
> +++ b/arch/mips/kernel/watch.c
> @@ -18,27 +18,24 @@
>  void mips_install_watch_registers(struct task_struct *t)
>  {
>  	struct mips3264_watch_reg_state *watches =3D &t->thread.watch.mips3264;
> +	unsigned int watchhi =3D MIPS_WATCHHI_G |		/* Trap all ASIDs */
> +			       MIPS_WATCHHI_IRW;	/* Clear result bits */
> +
>  	switch (current_cpu_data.watch_reg_use_cnt) {
>  	default:
>  		BUG();
>  	case 4:
>  		write_c0_watchlo3(watches->watchlo[3]);
> -		/* Write 1 to the I, R, and W bits to clear them, and
> -		   1 to G so all ASIDs are trapped. */
> -		write_c0_watchhi3(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
> -				  watches->watchhi[3]);
> +		write_c0_watchhi3(watchhi | watches->watchhi[3]);
>  	case 3:
>  		write_c0_watchlo2(watches->watchlo[2]);
> -		write_c0_watchhi2(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
> -				  watches->watchhi[2]);
> +		write_c0_watchhi2(watchhi | watches->watchhi[2]);
>  	case 2:
>  		write_c0_watchlo1(watches->watchlo[1]);
> -		write_c0_watchhi1(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
> -				  watches->watchhi[1]);
> +		write_c0_watchhi1(watchhi | watches->watchhi[1]);
>  	case 1:
>  		write_c0_watchlo0(watches->watchlo[0]);
> -		write_c0_watchhi0(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
> -				  watches->watchhi[0]);
> +		write_c0_watchhi0(watchhi | watches->watchhi[0]);
>  	}
>  }
> =20
> --=20
> 2.7.4
>=20
>=20

--GeDkoc8jIzHasOdk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpzOyEACgkQbAtpk944
dnqcEA//ey4MjAsAsgt4tVImD9hWyqv3sJzrevqq9ivESDGML3z6Tq3bJJ1Mzzc6
X7Ss/vAD806bw4mQzNBy2tB4RD+0rnwuHboO88JTfaqsBkNqsxmW6924hIkXEPsS
7jG1VlvU/XQroEODEVn+XpV5HhWNVAK6etRqfMfWrcJ0STAkYLIFfpO03fQcIcRV
DgsNdhjuQ9c4b39XM34nTZkNYOueVoTXcxjak8DmCTKuptQx2ZS7+KqJfmUnRTYL
W7FFjpou3+WTz91gj5P8DDybycAN49hSO4C9mgTiZTlRAEDce9Wk8YRnwn2kNQTc
wsakg0NVTBe2ErbPOVCnubXCtJKRMoyG1BlDqqbrP/v094Gh2Z+M5cJTnOa8AcMT
5cnFQHT4UtFrcCElFhYionfR3uT5j550wOFCIK6qAOwSGqOWXzfEECKPLNoyPpKv
B0EMHlx0MbxBcXZ21sPFg5oEroV2WBZK+HqVUzlpkHQ22OiMKh0Iti9WR5SDzEkO
3td+6Av20M3cxpqw42BkrgkdhsEng7dUpNZr6xwHISIEhLpELwu9Lqa73So90/Cq
DJJ/eom+2pURA0tP4pKpdw/n3MpjrdT6Resg7+5WgEAkBB1mxXET8dvY2KFmQZ1/
hziXlGoxNoN0lZzJNRsVnrPtl8DF/QINrBJxWFjLveV5xdGxbdw=
=WzTH
-----END PGP SIGNATURE-----

--GeDkoc8jIzHasOdk--
