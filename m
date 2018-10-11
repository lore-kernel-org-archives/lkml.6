Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C8CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8794B20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hFatRdYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8794B20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJKIMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 04:12:55 -0400
Received: from ozlabs.org ([203.11.71.1]:38259 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbeJKIMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 04:12:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42VslF3gvdz9s9N;
        Thu, 11 Oct 2018 11:48:09 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539218890;
        bh=9JACoV5Rnk5vAidKJbWWDzMiPbkbDdGvYW/56UOrPvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hFatRdYfhQ0hlf7lchOjBNfL58vqD19MC36PLQ8rxFSOrdLqTBJrCvoc7jsj6FuLJ
         2Fr1/V/OzRUnOP6pox70qqv67hZgSyMFhLBRn6ZG6+R0QGSTuzGenAyH8dqyzeYFaM
         lV2UukyHgHonmYJbp1Fx7R98eRCZSgeXc4pSEr6O1S0zFVvKTCYJkNmx3VnOY4QC/A
         qo6KaQj8b3c44Pe+hoT8WKCq+/+DsHWCpQ1TPoyFmWm7uJQNpfTkUcvQ82K838pNPL
         lSf6qmIi3zNI/zelLVRW1Rd7jQgF+JFPAXOMwz7szqs04P77AV02VmzhsRlB6HphWZ
         7lRyJvoXoXeBA==
Date:   Thu, 11 Oct 2018 11:48:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arnd@arndb.de
Subject: Re: linux-next: build warnings from the build of Linus' tree
Message-ID: <20181011114809.5590ecb3@canb.auug.org.au>
In-Reply-To: <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
References: <20180824133206.4218c2e5@canb.auug.org.au>
        <20180824172053.20fa197294f51496dcec5605@kernel.org>
        <20180824204756.e787765461975cd1e27502dc@kernel.org>
        <20180824224211.2934d7c0@canb.auug.org.au>
        <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
        <20180828072333.36af4d5d@canb.auug.org.au>
        <20180828094341.d20d8fbcb9dca310d44df951@kernel.org>
        <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/U9_eM7Cc2a7Mgcjo6GiLxsW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U9_eM7Cc2a7Mgcjo6GiLxsW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 6 Sep 2018 12:49:39 +0200 Peter Oberparleiter <oberpar@linux.ibm.co=
m> wrote:
>
> On 28.08.2018 02:43, Masami Hiramatsu wrote:
> > I recently added a gcov profiling for ftrace, following Documentation/d=
ev-tools/gcov.rst.
> > 6b7dca401cb1 ("tracing: Allow gcov profiling on only ftrace subsystem")
> >=20
> > and it caused may orphan section warnings/errors on arm and powerpc64.
> > We also found same error happens when CONFIG_GCOV_PROFILE_ALL=3Dy.
> > So I guess GCOV kernel subsystem broken in some environment. =20
>=20
> I can confirm that these issues are unrelated to your commit which only
> made the existing problems visible by enabling gcov-kernel profiling for
> allyesconfig builds. Both problems already exist in v4.18 and likely
> earlier versions.
>=20
> Problem 1: link failure on arm
> (https://lkml.org/lkml/2018/8/24/345)
>=20
> The root cause appears to be that the arm linker script only partially
> discards unneeded sections generated by the compiler when gcov-kernel
> profiling is enabled.
>=20
> Problem 2: linker warnings on powerpc
> (https://lkml.org/lkml/2018/8/24/72)
>=20
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=3Dy adds compiler flag
> -fdata-sections. This option causes GCC to create separate data sections
> for data objects, including those generated by GCC internally for gcov
> profiling. Since the name of these internal data objects starts with a .
> (.LPBX0, .LPBX1), the resulting section name starts with "data..". As
> section names starting with "data.." are used for specific purposes in
> the Linux kernel, the linker script does not automatically handle them,
> resulting in the "orphan section" linker warnings.
>=20
> I've attached a quick fix that should address both problems. I'd
> appreciate if this patch could get some testing before I post proper fix
> patches.
>=20
> -- >8 -- =20
> diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
> index ae5fdff18406..2ca33277a28b 100644
> --- a/arch/arm/kernel/vmlinux.lds.h
> +++ b/arch/arm/kernel/vmlinux.lds.h
> @@ -48,6 +48,7 @@
>=20
>  #define ARM_DISCARD							\
>  		*(.ARM.exidx.exit.text)					\
> +		*(.ARM.exidx.text.exit)					\
>  		*(.ARM.extab.exit.text)					\
>  		ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))		\
>  		ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))		\
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index 7b75ff6e2fce..5cf3b90c5592 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -68,7 +68,7 @@
>   */
>  #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
>  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> -#define DATA_MAIN .data .data.[0-9a-zA-Z_]*
> +#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..LPBX*
>  #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
>  #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]*
>  #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]*
> @@ -613,7 +613,7 @@
>=20
>  #define EXIT_DATA							\
>  	*(.exit.data .exit.data.*)					\
> -	*(.fini_array)							\
> +	*(.fini_array .fini_array.*)					\
>  	*(.dtors)							\
>  	MEM_DISCARD(exit.data*)						\
>  	MEM_DISCARD(exit.rodata*)
> --=20
> Peter Oberparleiter
> Linux on Z Development - IBM Germany
>=20

OK, I have been carrying this "quick fix" patch in linux-next since
September 7.  Is anyone going to pick this up and send it to
Greg/Linus, please?

--=20
Cheers,
Stephen Rothwell

--Sig_/U9_eM7Cc2a7Mgcjo6GiLxsW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu+nckACgkQAVBC80lX
0GzKIgf/UYK9xz5nJ9A05NiGDYe1Dpr1pbs3s2rMsugGG9LPW7ZWGiI3RrP3xno1
Og/gkxkW+MSRV9NP96LPUsuw3/HdIQeDCNXpJKzkSVIdIqEv5ODuQ3KWNxNHHzWf
nzU8yAYY/xoLgyHhjZW97gBVs2C+TXdeJE/SxXZLre+TI0HGml5Ya1yymR15KTSM
DhL9ZyZpm3BgERbBVExQ6HZsTe9eOSTFS1G0U8w7f0i1CHm84Wf2/lsgOnzUeJ2F
z8F2mdiwLpSriIlAHmFlk5miXtc4inT83S1Wvw3R2oikjJfziVZne+KGPn03QjMo
uUeRgilZ7GhLZgaNnjsRNrjyPxyoOQ==
=W7KP
-----END PGP SIGNATURE-----

--Sig_/U9_eM7Cc2a7Mgcjo6GiLxsW--
