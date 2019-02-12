Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD680C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9B0217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="G0p7LSCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbfBLQqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:46:32 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:60268 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfBLQqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:46:31 -0500
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 40AC924E0DA5;
        Tue, 12 Feb 2019 08:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549989991; bh=HWsvClWX2kPfrptDXuoXHXWUbCC38TBMKUaxiFwTtcs=;
        h=From:To:CC:Subject:Date:References:From;
        b=G0p7LSCrPrqKAwyDaw4w3dbaR4HALgD7rHa4C4jj7lrSb9mGYIN9dLJwHRzcXRa7c
         6E7EiGFw3EcAMpWe/hl7bRuyP7u8MMXyqpHqHWOI8YqJjzvMB6FLLxE/q9J9IbZn8M
         SPilrrwFiGgpqiR0fRMnnyDA/EqSTj8dyAXVXyGjWBdazTMyYZDIMAHnA+0EOf6yw1
         Ly7j2m3739yFOUUZwqqqQ2+0Kxsaot0MXBft/MA/memrTBPo8smVKOsrTWaKcDQjT0
         G1+4fOW2hMYPTq4/X3l0Kx3gu8HFVgl+vEq0cIhBBbbrAuFUG3RmL+DLh5AuRetd4l
         ISkyqWIqIRTRw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2E112A0070;
        Tue, 12 Feb 2019 16:46:30 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 12 Feb 2019 08:45:05 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>
Subject: Re: [PATCH 1/2] ARC: U-boot: check arguments paranoidly
Thread-Topic: [PATCH 1/2] ARC: U-boot: check arguments paranoidly
Thread-Index: AQHUwukx1Fnw5f+naU+WRGyYwF4mHg==
Date:   Tue, 12 Feb 2019 16:45:05 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014643364E@US01WEMBX2.internal.synopsys.com>
References: <20190212153932.28371-1-Eugeniy.Paltsev@synopsys.com>
 <20190212153932.28371-2-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 7:39 AM, Eugeniy Paltsev wrote:=0A=
> Handle U-boot arguments paranoidly:=0A=
>  * don't allow to pass unknown tag.=0A=
>  * try to use external device tree blob only if corresponding tag=0A=
>    (TAG_DTB) is set.=0A=
>  * check that magic number is correct.=0A=
>  * don't check uboot_tag if kernel build with no ARC_UBOOT_SUPPORT.=0A=
>=0A=
> NOTE:=0A=
> If U-boot args are invalid we skip them and try to use embedded device=0A=
> tree blob. We can't panic on invalid U-boot args as we really pass=0A=
> invalid args due to bug in U-boot code.=0A=
> This happens if we don't provide external DTB to U-boot and=0A=
> don't set 'bootargs' U-boot environment variable (which is default=0A=
> case at least for HSDK board) In that case we will pass=0A=
> {r0 =3D 1 (bootargs in r2); r1 =3D 0; r2 =3D 0;} to linux which is invali=
d.=0A=
>=0A=
> NOTE:=0A=
> We can safely check U-boot magic value (0x0) in linux passed via=0A=
> r1 register as U-boot pass it from the beginning.=0A=
>=0A=
> While I'm at it refactor U-boot arguments handling code.=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
>  arch/arc/kernel/head.S  |  5 +--=0A=
>  arch/arc/kernel/setup.c | 92 +++++++++++++++++++++++++++++++++++--------=
------=0A=
>  2 files changed, 69 insertions(+), 28 deletions(-)=0A=
>=0A=
> diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S=0A=
> index 8b90d25a15cc..fccea361e896 100644=0A=
> --- a/arch/arc/kernel/head.S=0A=
> +++ b/arch/arc/kernel/head.S=0A=
> @@ -93,10 +93,11 @@ ENTRY(stext)=0A=
>  #ifdef CONFIG_ARC_UBOOT_SUPPORT=0A=
>  	; Uboot - kernel ABI=0A=
>  	;    r0 =3D [0] No uboot interaction, [1] cmdline in r2, [2] DTB in r2=
=0A=
> -	;    r1 =3D magic number (board identity, unused as of now=0A=
> +	;    r1 =3D magic number (always zero as of now)=0A=
=0A=
This is technically changing the ABI - I think we don't need to enforce thi=
s -=0A=
keep ignoring this=0A=
=0A=
>  	;    r2 =3D pointer to uboot provided cmdline or external DTB in mem=0A=
> -	; These are handled later in setup_arch()=0A=
> +	; These are handled later in handle_uboot_args()=0A=
>  	st	r0, [@uboot_tag]=0A=
> +	st      r1, [@uboot_magic]=0A=
>  	st	r2, [@uboot_arg]=0A=
>  #endif=0A=
>  =0A=
> diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c=0A=
> index feb90093e6b1..84d394a37e79 100644=0A=
> --- a/arch/arc/kernel/setup.c=0A=
> +++ b/arch/arc/kernel/setup.c=0A=
> @@ -36,7 +36,8 @@ unsigned int intr_to_DE_cnt;=0A=
>  =0A=
>  /* Part of U-boot ABI: see head.S */=0A=
>  int __initdata uboot_tag;=0A=
> -char __initdata *uboot_arg;=0A=
> +int __initdata uboot_magic;=0A=
> +unsigned int __initdata uboot_arg;=0A=
>  =0A=
>  const struct machine_desc *machine_desc;=0A=
>  =0A=
> @@ -462,43 +463,82 @@ void setup_processor(void)=0A=
>  	arc_chk_core_config();=0A=
>  }=0A=
>  =0A=
> -static inline int is_kernel(unsigned long addr)=0A=
> +static inline bool uboot_arg_invalid(unsigned int addr)=0A=
>  {=0A=
> -	if (addr >=3D (unsigned long)_stext && addr <=3D (unsigned long)_end)=
=0A=
> -		return 1;=0A=
> -	return 0;=0A=
> +	/*=0A=
> +	 * Check that it is a untranslated address (although MMU is not enabled=
=0A=
> +	 * yet, it being a high address ensures this is not by fluke)=0A=
> +	 */=0A=
> +	if (addr < PAGE_OFFSET)=0A=
> +		return true;=0A=
> +=0A=
> +	/* Check that address doesn't clobber resident kernel image */=0A=
> +	return addr >=3D (unsigned int)_stext && addr <=3D (unsigned int)_end;=
=0A=
>  }=0A=
>  =0A=
> -void __init setup_arch(char **cmdline_p)=0A=
> +#define IGNORE_ARGS		"Ignore U-boot args: "=0A=
> +=0A=
> +/* uboot_{tag, magic} values for U-boot - kernel ABI revision 0; see hea=
d.S */=0A=
> +#define UBOOT_TAG_NONE		0=0A=
> +#define UBOOT_TAG_CMDLINE	1=0A=
> +#define UBOOT_TAG_DTB		2=0A=
> +/* We always pass 0 as magic from U-boot */=0A=
> +#define UBOOT_MAGIC_VAL		0=0A=
> +=0A=
> +void __init handle_uboot_args(void)=0A=
>  {=0A=
> +	bool use_embedded_dtb =3D true;=0A=
> +	bool append_cmdline =3D false;=0A=
> +=0A=
>  #ifdef CONFIG_ARC_UBOOT_SUPPORT=0A=
> -	/* make sure that uboot passed pointer to cmdline/dtb is valid */=0A=
> -	if (uboot_tag && is_kernel((unsigned long)uboot_arg))=0A=
> -		panic("Invalid uboot arg\n");=0A=
> +	/* check that we know this tag */=0A=
> +	if (uboot_tag !=3D UBOOT_TAG_NONE &&=0A=
> +	    uboot_tag !=3D UBOOT_TAG_CMDLINE &&=0A=
> +	    uboot_tag !=3D UBOOT_TAG_DTB) {=0A=
> +		pr_warn(IGNORE_ARGS "invalid uboot tag: '%08x'\n", uboot_tag);=0A=
> +		goto ignore_uboot_args;=0A=
> +	}=0A=
> +=0A=
> +	if (uboot_magic !=3D UBOOT_MAGIC_VAL) {=0A=
> +		pr_warn(IGNORE_ARGS "non zero uboot magic\n");=0A=
> +		goto ignore_uboot_args;=0A=
> +	}=0A=
=0A=
Not needed per above.=0A=
=0A=
> +=0A=
> +	if (uboot_tag !=3D UBOOT_TAG_NONE && uboot_arg_invalid(uboot_arg)) {=0A=
> +		pr_warn(IGNORE_ARGS "invalid uboot arg: '%08x'\n", uboot_arg);=0A=
> +		goto ignore_uboot_args;=0A=
> +	}=0A=
> +=0A=
> +	/* see if U-boot passed an external Device Tree blob */=0A=
> +	if (uboot_tag =3D=3D UBOOT_TAG_DTB) {=0A=
> +		machine_desc =3D setup_machine_fdt((void *)uboot_arg);=0A=
> +=0A=
> +		/* external Device Tree blob is invalid - use embedded one */=0A=
> +		use_embedded_dtb =3D !machine_desc;=0A=
> +	}=0A=
> +=0A=
> +	if (uboot_tag =3D=3D UBOOT_TAG_CMDLINE)=0A=
> +		append_cmdline =3D true;=0A=
>  =0A=
> -	/* See if u-boot passed an external Device Tree blob */=0A=
> -	machine_desc =3D setup_machine_fdt(uboot_arg);	/* uboot_tag =3D=3D 2 */=
=0A=
> -	if (!machine_desc)=0A=
> +ignore_uboot_args:=0A=
>  #endif=0A=
> -	{=0A=
> -		/* No, so try the embedded one */=0A=
> +=0A=
> +	if (use_embedded_dtb) {=0A=
>  		machine_desc =3D setup_machine_fdt(__dtb_start);=0A=
>  		if (!machine_desc)=0A=
>  			panic("Embedded DT invalid\n");=0A=
> +	}=0A=
>  =0A=
> -		/*=0A=
> -		 * If we are here, it is established that @uboot_arg didn't=0A=
> -		 * point to DT blob. Instead if u-boot says it is cmdline,=0A=
> -		 * append to embedded DT cmdline.=0A=
> -		 * setup_machine_fdt() would have populated @boot_command_line=0A=
> -		 */=0A=
=0A=
Don't drop this comment, specially the last line. If was tempted to move th=
e cmd=0A=
line processing before but this saved me since we rely on setup_machine_fdt=
()=0A=
being called aprioiri.=0A=
> -		if (uboot_tag =3D=3D 1) {=0A=
> -			/* Ensure a whitespace between the 2 cmdlines */=0A=
> -			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);=0A=
> -			strlcat(boot_command_line, uboot_arg,=0A=
> -				COMMAND_LINE_SIZE);=0A=
> -		}=0A=
> +	if (append_cmdline) {=0A=
> +		/* Ensure a whitespace between the 2 cmdlines */=0A=
> +		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);=0A=
> +		strlcat(boot_command_line, (char *)uboot_arg, COMMAND_LINE_SIZE);=0A=
>  	}=0A=
> +}=0A=
> +=0A=
> +void __init setup_arch(char **cmdline_p)=0A=
> +{=0A=
> +	handle_uboot_args();=0A=
>  =0A=
>  	/* Save unparsed command line copy for /proc/cmdline */=0A=
>  	*cmdline_p =3D boot_command_line;=0A=
=0A=
