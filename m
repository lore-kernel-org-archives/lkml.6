Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeDRLKW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:10:22 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:33381 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752153AbeDRLKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:10:21 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::,RULES_HIT:41:355:379:599:800:871:960:965:966:973:988:989:1000:1260:1313:1314:1345:1359:1381:1437:1516:1518:1534:1541:1575:1711:1730:1747:1777:1792:1978:1981:2194:2196:2199:2200:2393:2559:2562:2892:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4362:4385:4390:4395:4605:5007:6261:6506:6747:7281:7909:7974:10004:10848:11026:11232:11473:11658:11914:12050:12555:12895:13149:13230:14096:14180:14181:14721:21060:21080:21325:21433:21451:21627,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.14.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: ship70_76fdf5cb82802
X-Filterd-Recvd-Size: 3368
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/16] initrd: Add weakly-linked generic free_initrd_mem.
In-Reply-To: <20180401145931.7932-1-shea@shealevy.com>
References: <20180329113207.30674-1-shea@shealevy.com> <20180401145931.7932-1-shea@shealevy.com>
Date: Wed, 18 Apr 2018 07:10:16 -0400
Message-ID: <87tvs8rcrr.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

Shea Levy <shea@shealevy.com> writes:

> This function is effectively identical across 14 architectures, and
> the generic implementation is small enough to be negligible in the
> architectures that do override it. Many of the remaining divergent
> implementations can be included in the common code path in future,
> further reducing code duplication and sharing improvements between
> architectures.
>
> Series boot-tested on RISC-V (which now uses the generic
> implementation) and x86_64 (which doesn't).
>
> v6: Add information about build/run testing.
> v5: Add more complete commit messages.
> v4: Use weak symbols instead of Kconfig.
> v3: Make the generic path opt-out instead of opt-in.
> v2: Mark generic free_initrd_mem __init.
>
> Signed-off-by: Shea Levy <shea@shealevy.com>
> ---
>  init/initramfs.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 7e99a0038942..c8fe150f958a 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -526,6 +526,11 @@ extern unsigned long __initramfs_size;
>  #include <linux/initrd.h>
>  #include <linux/kexec.h>
>=20=20
> +void __init __weak free_initrd_mem(unsigned long start, unsigned long en=
d)
> +{
> +       free_reserved_area((void *)start, (void *)end, -1, "initrd");
> +}
> +
>  static void __init free_initrd(void)
>  {
>  #ifdef CONFIG_KEXEC_CORE
> --=20
> 2.16.2

This series has been quiet for a few weeks other than picking up some
arch-specific acks. What is the next step here?

Thanks,
Shea

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlrXJ5gACgkQXAvWlX2G
/iehCRAAvSK13Lts8c356lXL2EXVlNyDZRdrfpIns8Ey9AJfuR20W7PrU33tc4pb
N9tVp4tOHRSMVJO1joxE+4pX9IBF5EIZ3q051PHQN/aolwWba9TV8oag367+9xqu
JV354FWJpC0AY35FSx4xnonObqdT88FNQXKFeBA/aGnmS5ncnTjfXOs18r6QKWUs
Cwg8wh1/moyt8jP/vGt4pLQU1zVUU1qgs6DhBiE7Ezma+1u1m0ECFPnlvHlKNniu
7Bbi6Jc76cdx2wBS7jKFSiKNB3nnK+XirqhXgGdrrX+foZ6HxQ1nWU/ervBaRDQE
awGk+Ne2ngK3s7uIG2wmdCopDsiQfPfKdylHz47LwAaRWnJt4/GIvkQGHEHSglkN
jDD5dqjmOopCw+8dOYzDbE1uiI3vpYa+sdrrsQWitay+tPM2ZfCldE4oVbjZANNa
Odf5sS/SKJcmNiuYRvqJVGjMy262WtfvbsWHx/iAvX83CsW3uPDKu2OhNIoR8xeo
tU4gIuruuegbKZ/vec7O3HzarRoEStj+6G45jeWtUzoBhdQ7J0nPpxk58h8DvYbW
cPfBCGrb1I5EcjQhVV/xnHTi0KbZu1J5PAee7yODNUUpHMEV73yn+Lb8Cqh7XuDk
x0NNIpNpysaZzd9UH4EWBsoeyvrRdI2MkXEgKSlnUmAmFr2FVwo=
=T5Ps
-----END PGP SIGNATURE-----
--=-=-=--
