Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727DAC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E73320870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Jh4RrTEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E73320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeG3JIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:08:17 -0400
Received: from ozlabs.org ([203.11.71.1]:47147 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbeG3JIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:08:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41fBCs52v1z9ryt;
        Mon, 30 Jul 2018 17:34:32 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532936074;
        bh=qDz3y4DWUnYzIqoBAX49S5aiH+98telFByFMElaGEUw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jh4RrTELgW3XNS8e79AQ66brs4Ckn7Nq3ua8rPbGAc/8LbNKxaltGY5IBJ3FMlrs/
         7spj8Ij0gjYe8BY3mjpm+u0JsQRYYwernpyM0Jyp+wTe5IztGJTDQWGHyIo2GTsyvD
         jZAc+4z40DcDb6cYB02peEGhBjeQ3eImHJD95PGQdVdWhoD4r0ggDN804dmLTXCGg1
         yVe/CIMxwE/CdUteqgszF4JrBROV8h/8Qbb3tVgUmzdeSgu4mXmJtwoSGOJVw9chrw
         u4qApAcwtYtm2T23Tl4MgTFFheU+XutcZrWa87HCNOVV/npSzZvumtD30q9K0cMNXI
         I5lOB6HW2naBw==
Date:   Mon, 30 Jul 2018 17:33:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Kees Cook <keescook@google.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Laura Abbott <labbott@redhat.com>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20180730173356.694fbf4e@canb.auug.org.au>
In-Reply-To: <20180727125522.GA6173@arm.com>
References: <20180727190207.7ce1c9b0@canb.auug.org.au>
        <20180727190647.3525f5f7@canb.auug.org.au>
        <20180727205511.7c0f2e62@canb.auug.org.au>
        <20180727125522.GA6173@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Fiy+PxQW0/MKhR+VtiALeCT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Fiy+PxQW0/MKhR+VtiALeCT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 27 Jul 2018 13:55:22 +0100 Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Jul 27, 2018 at 08:55:11PM +1000, Stephen Rothwell wrote:
> > On Fri, 27 Jul 2018 19:06:47 +1000 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> > >
> > > On Fri, 27 Jul 2018 19:02:07 +1000 Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote: =20
> > > >
> > > > After merging the kspp tree, today's linux-next build (x86_64
> > > > allmodconfig) failed like this:
> > > >=20
> > > > cc1: error: plugin stackleak_plugin should be specified before -fpl=
ugin-arg-stackleak_plugin-disable in the command line
> > > >=20
> > > > Maybe caused by commit
> > > >=20
> > > >   a8b9eaddb9c0 ("gcc-plugins: Add STACKLEAK plugin for tracking the=
 kernel stack")
> > > >=20
> > > > I have used the kspp tree from next-20180726 for today.   =20
> > >=20
> > > Well, that obviously didn't work since the tree hasn't changed for a
> > > few days.
> > >=20
> > > I can't see what has interacted to make this happen, so I have dropped
> > > the kspp tree for today. =20
> >=20
> > Actually, it may have been caused by commit
> >=20
> >   0b3e336601b8 ("arm64: Add support for STACKLEAK gcc plugin")
> >=20
> > from the arm64 tree. =20
>=20
> Thanks, Stephen. I managed to reproduce this by merging for-next/kspp from
> Kees's tree and for-next/core from the arm64 tree. The failure happens wh=
en
> building the EFI stub, so the commit you mention above is almost certainly
> the culprit.
>=20
> We build the stub with the following GCC invocation:
>=20
>  gcc -Wp,-MD,drivers/firmware/efi/libstub/.efi-stub-helper.o.d  -nostdinc=
 -isystem /usr/lib/gcc/x86_64-linux-gnu/4.9/include -I./arch/x86/include -I=
./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arc=
h/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -i=
nclude ./include/linux/kconfig.h -include ./include/linux/compiler_types.h =
-D__KERNEL__ -mcmodel=3Dsmall -m64 -D__KERNEL__ -O2 -fPIC -fno-strict-alias=
ing -mno-red-zone -mno-mmx -mno-sse -fshort-wchar -DDISABLE_BRANCH_PROFILIN=
G -D__NO_FORTIFY -ffreestanding -fno-stack-protector -fplugin-arg-stackleak=
_plugin-disable   -fno-builtin      -DKBUILD_BASENAME=3D'"efi_stub_helper"'=
 -DKBUILD_MODNAME=3D'"efi_stub_helper"' -c -o drivers/firmware/efi/libstub/=
.tmp_efi-stub-helper.o drivers/firmware/efi/libstub/efi-stub-helper.c
>=20
> so given that we're not passing any -fplugin=3D option anyway (because we
> override KBUILD_CFLAGS for the stub), I don't understand why we need
> to the disable option at all.
>=20
> Laura?

So today I am just trying reverting that arm64 tree commit.

--=20
Cheers,
Stephen Rothwell

--Sig_/Fiy+PxQW0/MKhR+VtiALeCT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltev2QACgkQAVBC80lX
0Gxb+wf+P4UdIy5U3y3xgTWs4oq1pcp5iovuKt3zTZepwJuRTlWqRUo4hiAe266u
zxc1a0w+Ri/+nSsPj5+qkUorZV6wtS8jz1egF/h3qP9oABVtheYg8496ncQCKYZU
uX1ggMNuXeGnhR1msAGqisQD/RjTSAxIbTrNGBJBqrCw2BUCitMF06wa8QEK1eoe
wJTRN+JSNCT7i9YLx61t0Y1A51jo2Ew/wPD+LdTlNHbeGjj67WV4MN9u/FXbJSvk
RKrSo5dx3yw4MFHkAFFrljfXDvuoiFCAYCKV0DkqWgCbFBU0HO7b5rUr6tJe5SLo
eMVmeuCcKE3QGI27nu7KAekq4Wrb9w==
=+Eni
-----END PGP SIGNATURE-----

--Sig_/Fiy+PxQW0/MKhR+VtiALeCT--
