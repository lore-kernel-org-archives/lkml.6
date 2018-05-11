Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeEKAnf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 20:43:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:38066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbeEKAne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 20:43:34 -0400
From: NeilBrown <neilb@suse.com>
To: Justin Skists <justin.skists@juzza.co.uk>, devel@driverdev.osuosl.org,
        lustre-devel@lists.lustre.org, James Simmons <jsimmons@infradead.org>,
        Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>
Date: Fri, 11 May 2018 10:43:23 +1000
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: lustre: lnet: add static to libcfs_dev declaration
In-Reply-To: <20180510194128.GA19653@tanglefoot>
References: <20180510194128.GA19653@tanglefoot>
Message-ID: <87d0y39g44.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, May 10 2018, Justin Skists wrote:

> Add a static prefix to the declaration for libcfs_dev. This would fix
> the following sparse warning:
>
> drivers/staging/lustre/lnet/libcfs/module.c:317:19: warning: symbol
> 'libcfs_dev' was not declared. Should it be static?

Thanks - that was my fault. (b4ded66db93b)
Reviewed-by: NeilBrown <neilb@suse.com>

Thanks,
NeilBrown

>
> Signed-off-by: Justin Skists <justin.skists@juzza.co.uk>
> ---
>  drivers/staging/lustre/lnet/libcfs/module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/lustre/lnet/libcfs/module.c b/drivers/stagin=
g/lustre/lnet/libcfs/module.c
> index ca942f474a55..e021e439f140 100644
> --- a/drivers/staging/lustre/lnet/libcfs/module.c
> +++ b/drivers/staging/lustre/lnet/libcfs/module.c
> @@ -314,7 +314,7 @@ static const struct file_operations libcfs_fops =3D {
>  	.unlocked_ioctl	=3D libcfs_psdev_ioctl,
>  };
>=20=20
> -struct miscdevice libcfs_dev =3D {
> +static struct miscdevice libcfs_dev =3D {
>  	.minor =3D MISC_DYNAMIC_MINOR,
>  	.name =3D "lnet",
>  	.fops =3D &libcfs_fops,
> --=20
> 2.17.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlr05ywACgkQOeye3VZi
gblZwA//RE4ywCRcp1E/cowFjkJ+aL9/VylOJwXb25cx0A5jaopZtObQ8n5eZwJ7
pbzmJ9n8Ma6SbWQA4jpJEcIdc8y9PxW+RywfD1bsIuYbokpw0A23qz8tVfp7V5tg
C4VxlAcGcZ5mfj9EeA09OIlWrrHvLDgaqV03a+YG7Bve0wV2dBWObvd3oPalk39w
/LN3EAVXmOXs5Ae8sW1dzDK1OikRgrMPI9HvGdlQHKNLAgH7da3vJUMt53ZQxuOl
GE8gZwuQts7P0sqUUcgqFLp7MM3hFoGDi3038wkiNFK+7ziUR2zS9pUBNvJ25npt
2I23sSqsGxPG6jT70oZmD+xzhFB3y6oE5P8fd4pZP7ehjJALApetxWAjm73bd2XE
bpGJslvZjG1BQ4FC1m6UHNE9UTvAnwl+EjaXVg038a8En7lMl5U18fRy3klEkowv
9aobv8rZzyUbtBU+5X/OV4LrOkviIMgzqhtPWaSsbjUPpu0aIPFtNoPE0EqHCv2s
v9/6Ma61uuVpmJLnWJwOew814BCymeH5IhnJjD3J5g/TN3Ab30eMwaVkV3E1e6T7
MtjoDbZPHLFWca8w5rmzH9m9DDSyIjVvLfad3oI9v7Va7vBYoAwqwhq3QC8V587j
k60NipePvgRAwS9P01yAfLsx1hDuKnubGhQC+xYcEVMSn6PIiSk=
=9LCa
-----END PGP SIGNATURE-----
--=-=-=--
