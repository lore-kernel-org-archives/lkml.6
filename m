Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754691AbeDBXtI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 19:49:08 -0400
Received: from ozlabs.org ([103.22.144.67]:47815 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754550AbeDBXtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 19:49:06 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 3 Apr 2018 09:48:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: linux-next: manual merge of the tip tree with the arm-soc tree
Message-ID: <20180403094807.1466d120@canb.auug.org.au>
In-Reply-To: <20180319140657.223852a1@canb.auug.org.au>
References: <20180319140657.223852a1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MViTOkDLT6Otlh3illQAYas"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MViTOkDLT6Otlh3illQAYas
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi All,

On Mon, 19 Mar 2018 14:06:57 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the tip tree got a conflict in:
>=20
>   drivers/bus/arm-cci.c
>=20
> between commit:
>=20
>   3de6be7a3dd8 ("drivers/bus: Split Arm CCI driver")
>=20
> from the arm-soc tree and commit:
>=20
>   edb39592a587 ("perf: Fix sibling iteration")
>=20
> from the tip tree.
>=20
> I fixed it up (I added the following merge fix patch) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 19 Mar 2018 14:04:52 +1100
> Subject: [PATCH] perf/core: another merge fix for "drivers/bus: Split Arm=
 CCI
>  driver"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/perf/arm-cci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> index 192d23b760a0..383b2d3dcbc6 100644
> --- a/drivers/perf/arm-cci.c
> +++ b/drivers/perf/arm-cci.c
> @@ -1265,7 +1265,7 @@ static int validate_group(struct perf_event *event)
>  	if (!validate_event(event->pmu, &fake_pmu, leader))
>  		return -EINVAL;
> =20
> -	list_for_each_entry(sibling, &leader->sibling_list, sibling_list) {
> +	for_each_sibling_event(sibling, leader) {
>  		if (!validate_event(event->pmu, &fake_pmu, sibling))
>  			return -EINVAL;
>  	}
> --=20

This conflict is now between the arm-soc tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/MViTOkDLT6Otlh3illQAYas
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrCwTcACgkQAVBC80lX
0GytmggAiFJjDKf/6NcerucjA1K4Jg6ILMYyj7H9zvXZZdMT0+QfuZQg1mq7ukih
WdRKYHvuNNfqSZmWIiMzbBiaRb5elE7MOMOC0sau0E85w39V+uDo2lHD5OqHoa/7
zoIIWU1lDTuvuVRBTikBtOruErXFF+UX2GCnm4ixzPguLXMiGAAWmBdZioRX3CAy
3RlW9/VGLpDQDS/fer2l5Na5TtobwWlgovKVTrueDMwQIdC+IkXb+7DotsW/Y4Hn
rkpHXhHhuz9UHoTAeNg5+md9kxEtvpvIU/hjmJ0Etyfzmwg41rGfP8kpjoKxNZ9j
b3JSKF+KV2/zh0iyj3BCmt99QvS+qQ==
=0cT1
-----END PGP SIGNATURE-----

--Sig_/MViTOkDLT6Otlh3illQAYas--
