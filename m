Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeCNPKW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:10:22 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34690 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeCNPKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:10:20 -0400
X-Google-Smtp-Source: AG47ELuy+TFyehMRpj4z5uaN97X659jZuxbI0EGhhP+XVR7CONJfa50t/g7qYRQLHqyoSMJsR4pSMA==
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 2/2] microblaze: switch to NO_BOOTMEM
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
References: <77785f26fa882362b5e72e71845bb607f2cec757.1521039689.git.michal.simek@xilinx.com>
 <b7aa87fcf06143e9cabf18fa0e98a2c7f321e821.1521039689.git.michal.simek@xilinx.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <6fd76f9a-13b8-3047-57db-4b190bc3f1c1@monstr.eu>
Date: Wed, 14 Mar 2018 16:10:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b7aa87fcf06143e9cabf18fa0e98a2c7f321e821.1521039689.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WRBL08s4kukBh7N954UWfWxURNDlN368V"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WRBL08s4kukBh7N954UWfWxURNDlN368V
Content-Type: multipart/mixed; boundary="FCdoMycMskRB83YdrSzdr0F3O6Ngu4Z84";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
Message-ID: <6fd76f9a-13b8-3047-57db-4b190bc3f1c1@monstr.eu>
Subject: Re: [PATCH 2/2] microblaze: switch to NO_BOOTMEM
References: <77785f26fa882362b5e72e71845bb607f2cec757.1521039689.git.michal.simek@xilinx.com>
 <b7aa87fcf06143e9cabf18fa0e98a2c7f321e821.1521039689.git.michal.simek@xilinx.com>
In-Reply-To: <b7aa87fcf06143e9cabf18fa0e98a2c7f321e821.1521039689.git.michal.simek@xilinx.com>

--FCdoMycMskRB83YdrSzdr0F3O6Ngu4Z84
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.3.2018 16:01, Michal Simek wrote:
> From: Rob Herring <robh@kernel.org>
>=20
> Microblaze doesn't set CONFIG_NO_BOOTMEM and so memblock_virt_alloc()
> doesn't work for CONFIG_HAVE_MEMBLOCK && !CONFIG_NO_BOOTMEM.
>=20
> Similar change was already done by others architectures
> "ARM: mm: Remove bootmem code and switch to NO_BOOTMEM"
> (sha1: 84f452b1e8fc73ac0e31254c66e3e2260ce5263d)
> or
> "openrisc: Consolidate setup to use memblock instead of bootmem"
> (sha1: 266c7fad157265bb54d17db1c9545f2aaa488643)
> or
> "parisc: Drop bootmem and switch to memblock"
> (sha1: 4fe9e1d957e45ad8eba9885ee860a0e93d13a7c7)
> or
> "powerpc: Remove bootmem allocator"
> (sha1: 10239733ee8617bac3f1c1769af43a88ed979324)
> or
> "s390/mm: Convert bootmem to memblock"
> (sha1: 50be634507284eea38df78154d22615d21200b42)
> or
> "sparc64: Convert over to NO_BOOTMEM."
> (sha1: 625d693e9784f988371e69c2b41a2172c0be6c11)
> or
> "xtensa: drop sysmem and switch to memblock"
> (sha1: 0e46c1115f5816949220d62dd3ff04aa68e7ac6b)
>=20
> Issue was introduced by:
> "of/fdt: use memblock_virt_alloc for early alloc"
> (sha1: 0fa1c579349fdd90173381712ad78aa99c09d38b)
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> Tested-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
> Tested-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
>  arch/microblaze/Kconfig   |  1 +
>  arch/microblaze/mm/init.c | 55 ++++++---------------------------------=
--------
>  2 files changed, 7 insertions(+), 49 deletions(-)
>=20
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 4f798aa671dd..3817a3e2146c 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -24,6 +24,7 @@ config MICROBLAZE
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_TRACER
> +	select NO_BOOTMEM
>  	select HAVE_MEMBLOCK
>  	select HAVE_MEMBLOCK_NODE_MAP
>  	select HAVE_OPROFILE
> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> index 5bc9c7fbb541..6ab1ef2daf1d 100644
> --- a/arch/microblaze/mm/init.c
> +++ b/arch/microblaze/mm/init.c
> @@ -32,9 +32,6 @@
>  #ifndef CONFIG_MMU
>  unsigned int __page_offset;
>  EXPORT_SYMBOL(__page_offset);
> -
> -#else
> -static int init_bootmem_done;
>  #endif /* CONFIG_MMU */
> =20
>  char *klimit =3D _end;
> @@ -174,17 +171,6 @@ void __init setup_memory(void)
>  	pr_info("%s: max_low_pfn: %#lx\n", __func__, max_low_pfn);
>  	pr_info("%s: max_pfn: %#lx\n", __func__, max_pfn);
> =20
> -	/*
> -	 * Find an area to use for the bootmem bitmap.
> -	 * We look for the first area which is at least
> -	 * 128kB in length (128kB is enough for a bitmap
> -	 * for 4GB of memory, using 4kB pages), plus 1 page
> -	 * (in case the address isn't page-aligned).
> -	 */
> -	map_size =3D init_bootmem_node(NODE_DATA(0),

map_size variable should be also removed. Fixed in v2.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--FCdoMycMskRB83YdrSzdr0F3O6Ngu4Z84--

--WRBL08s4kukBh7N954UWfWxURNDlN368V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqpO1UACgkQykllyylKDCG1mgCfZcUEcJaciXIwLgwlROEwFsdp
eVwAn1xptOsI0rAZl7DASJvZYMYycSyP
=C+/c
-----END PGP SIGNATURE-----

--WRBL08s4kukBh7N954UWfWxURNDlN368V--
