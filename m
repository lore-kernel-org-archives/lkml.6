Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753787AbeEaFRp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 01:17:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751660AbeEaFRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 01:17:44 -0400
From: NeilBrown <neilb@suse.com>
To: Arnd Bergmann <arnd@arndb.de>, Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        James Simmons <jsimmons@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 31 May 2018 15:17:32 +1000
Cc: Arnd Bergmann <arnd@arndb.de>, Doug Oucharek <dougso@me.com>,
        Dmitry Eremin <dmitry.eremin@intel.com>,
        Ingo Molnar <mingo@kernel.org>, lustre-devel@lists.lustre.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: lustre: include linux/highmem.h when needed
In-Reply-To: <20180530213941.772006-1-arnd@arndb.de>
References: <20180530213941.772006-1-arnd@arndb.de>
Message-ID: <874liov1xv.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, May 30 2018, Arnd Bergmann wrote:

> Something in recent linux-next kernels caused linux/highmem.h to
> no longer be included implicitly from o2iblnd_cb.c, causing a build
> failure:
>
> drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c: In function 'kibl=
nd_kvaddr_to_page':
> drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c:549:15: error: 'PK=
MAP_BASE' undeclared (first use in this function); did you mean 'RTM_BASE'?
>   if (vaddr >=3D PKMAP_BASE &&
>                ^~~~~~~~~~
>                RTM_BASE
> drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c:549:15: note: each=
 undeclared identifier is reported only once for each function it appears in
> drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c:550:28: error: 'LA=
ST_PKMAP' undeclared (first use in this function); did you mean 'AT_HWCAP'?
>       vaddr < (PKMAP_BASE + LAST_PKMAP * PAGE_SIZE)) {
>                             ^~~~~~~~~~
>                             AT_HWCAP
>
> This adds back an explicit include for the header.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for finding and fixing this.  I did recently reduce the number
of include files that were automatically included everywhere.  Clearly
some config combinations didn't get tested properly.

Reviewed-by: NeilBrown <neilb@suse.com>

Thanks,
NeilBrown


> ---
>  drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c b/dri=
vers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
> index 47eb8b4c28db..65b7a62943ad 100644
> --- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
> +++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
> @@ -35,6 +35,7 @@
>   * Author: Eric Barton <eric@bartonsoftware.com>
>   */
>=20=20
> +#include <linux/highmem.h>
>  #include "o2iblnd.h"
>=20=20
>  #define MAX_CONN_RACES_BEFORE_ABORT 20
> --=20
> 2.9.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsPhW0ACgkQOeye3VZi
gblryxAAs6ogZvlMxiFW2YhTfEB0ASt/EtGUEV1AStmJwEksJzOk0YKTdChr7TbP
T6hcSS2xWS46p/jZc13mqFqSOuic1sUwLIhCcidSoOLdhXzBmen6cr3zkFt9AZ3y
+8T7dGe5XTvUPMPskcSBzpQLszeV8jEvTsUWDvhkcy/tXx1kyTewq7BXQBsCDPXZ
dJJfZ8U9VbnL8sObF6W9APSDt633dRihEbGJV6ysXq3cI2pTR0SahF+O9NHc1okx
eJ58dRKxOX+K984s3mMvxiSTORpqi9VSm/wVmGlRo5BgfK9Xfl/c+UN4O+vifAid
74xV10+2/P9mC3EPIR7gFXSQ2aEwaIGTV9S9VSDGnX4kCAvH8AyevreUNusdy6k6
bVvDJRHHXOIONwVY6eNr/QDScq3uRTyXsdo5UQm7NBcRJ0STorc1oIUo2Dnfr6eS
nbM+PoDLViv7K+88ELt43WXndDW+JXgMUPqjPruwr57VJM2Vksa8U3r4IHHYfmIQ
7yxZQEwayoIRtWsE7RhTvo6y6MTqPWvXB/N8WTCt0Ag7iBuMbO0iiHnW+GnpswKh
QIoHlgeAWL0B+yKeGpU0DZr0s1th0/sYEeAuur7XCaEKoiaWcynzUdcwWAKvU7qc
L35Rz9lm726c7K77OSoVxNaoOKT1aq6XUZfJ52d9W0R6p5ZdmMQ=
=UL5a
-----END PGP SIGNATURE-----
--=-=-=--
