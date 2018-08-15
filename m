Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E495CC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 04:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953EA21534
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 04:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ghT0REkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953EA21534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeHOHSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 03:18:04 -0400
Received: from ozlabs.org ([203.11.71.1]:39547 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbeHOHSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 03:18:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qxJj1W3Kz9s7Q;
        Wed, 15 Aug 2018 14:27:33 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534307255;
        bh=Vu4ZGaY/0dC9DuOmwScNTVaCN5lCLZVrlPTtHKjpVhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ghT0REkN8j6E4QL3gb8nwPi4jbuiZGQ9oIYOUPoJquUm0kNvSFM+ojZ3BzT7yi2E/
         7mTe6lg7PF1dBl5gT3v5GIHp3i3ixl0X+4fxAbq2/T5+NBfUxjlljvMjLSLDrB2GIT
         JKGdhRE1BMqvzd9+klEDzONbdcY0GGqvVWhtI/xcEVBVkyxgZfi5ms6baNfPWuwGza
         KUUquamcSp5OUSJtl39Kel69P7ga6XPWC/8kepHW2tWPSR2L67nzKi1VuNm2BybrGK
         Yi0a62Uu2ae2gGQagu+1JVJaxHhV8+r79Gb9vAouNEZ+FTihFDLqmUmFbOEiZIoFcs
         Vgb5Ok7BpUF1w==
Date:   Wed, 15 Aug 2018 14:27:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Wanpeng Li <wanpengli@tencent.com>
Subject: Re: linux-next: manual merge of the kvm tree with the tip tree
Message-ID: <20180815142732.6c9108a0@canb.auug.org.au>
In-Reply-To: <20180808135445.1a85f9b5@canb.auug.org.au>
References: <20180808135445.1a85f9b5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vogrmeqq0sIyF6..pcmK9xn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vogrmeqq0sIyF6..pcmK9xn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 8 Aug 2018 13:54:45 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Paolo pointed out a semantic conflict between the kvm tree and the tip
> tree in
>=20
>   arch/x86/kernel/kvm.c
>=20
> between commit:
>=20
>   368a540e0232 ("x86/kvmclock: Remove memblock dependency")
>=20
> from the tip tree and commit:
>=20
>   d63bae079b64 ("KVM: X86: Add kvm hypervisor init time platform setup ca=
llback")
>=20
> from the kvm tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> I applied the following (as suggested) after the automatic merge:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 8 Aug 2018 13:48:34 +1000
> Subject: [PATCH] kvm: x86: fix semantic conflict in platform init
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/x86/kernel/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 0906b8731393..e2499bad3209 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -714,13 +714,13 @@ static void __init kvm_apic_init(void)
>  static void __init kvm_init_platform(void)
>  {
>  	x86_platform.apic_post_init =3D kvm_apic_init;
> +	kvmclock_init();
>  }
> =20
>  const __initconst struct hypervisor_x86 x86_hyper_kvm =3D {
>  	.name			=3D "KVM",
>  	.detect			=3D kvm_detect,
>  	.type			=3D X86_HYPER_KVM,
> -	.init.init_platform	=3D kvmclock_init,
>  	.init.guest_late_init	=3D kvm_guest_init,
>  	.init.x2apic_available	=3D kvm_para_available,
>  	.init.init_platform	=3D kvm_init_platform,
> --=20
> 2.18.0

This is now a conflict between Linus' tree and the kvm tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/vogrmeqq0sIyF6..pcmK9xn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzq7QACgkQAVBC80lX
0Gw+XAgAo7NNTGWO2oKALvnbQ8tFT5Z10y4gi2XdjmCKX4G+6vsIb8qf9oioCz3L
DgTeBPyu5K1gZC1CBPGaipMNM76HvXFBuLxCXf26yfClbw0v0yyIjnxtvrCxNYCx
o0/OI2vv0nM8DviRP66dh4qxbH+U6nwECO92i1BYv/Y2gHDoNBErio0oMSJwsHRH
7mgBi/mH7mB3I6KdYZVtCeoUNMi4ZPxp/J7lVnAcxWwpFdom7nZckZgiXHO5qSrf
gfEKNWdjZ+7zgsd3+HJdxY2qvEO3RLdZIoj+ns/Eb4Shk0SvCSplIthXaotB7xyR
g1xl8CMoBVYaFocM8n2frm14Juqtbg==
=68dh
-----END PGP SIGNATURE-----

--Sig_/vogrmeqq0sIyF6..pcmK9xn--
