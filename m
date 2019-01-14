Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC91C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A665320656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l3JRrbI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfANWdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:33:54 -0500
Received: from ozlabs.org ([203.11.71.1]:49161 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfANWdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:33:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dpCx73sDz9sBQ;
        Tue, 15 Jan 2019 09:33:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547505231;
        bh=Bn2wATY0GM8iF5+jDd90WZs8FyCiO3YM9PPlwnfcu3Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l3JRrbI1q/UwBXQcIcKbJGlomKGNKzW/V/SC8G+DBOw1CMfywflsW9XKKLBmq28XW
         hJjJouclcCm+U4rhEsn1Pp3+ZMjdwP2qGs6TCNDMIWesnjHmISk9a5PTIGJXEEg7IR
         YzvtWtd1k46JzSjdDpEHPO2LyHmtAjh71liP/7o/8CduvrdUjguq3sQNpsrQdrM5hV
         YeuUPDzcI74hfzw2tR8X5DyDgaddLdYdmpQnY++BHuk+jgn/rkTxKqqZjcfRnpmVvd
         xm1xldeR4+1OpCg0d7E+Id8FMIXslqYDMQgYQ4rfoWVQGnILpyarpPlwArVnwzSccB
         qSpTF13xfP22A==
Date:   Tue, 15 Jan 2019 09:33:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Walker <dwalker@fifo99.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: manual merge of the cisco tree with the vfs tree
Message-ID: <20190115093330.1cbb0625@canb.auug.org.au>
In-Reply-To: <20181002162923.13f3f8b1@canb.auug.org.au>
References: <20181002162923.13f3f8b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//A=/GjsJxw4P=Epi8/=Qf3V"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//A=/GjsJxw4P=Epi8/=Qf3V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, 2 Oct 2018 16:29:23 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the cisco tree got a conflict in:
>=20
>   arch/x86/kernel/setup.c
>=20
> between commit:
>=20
>   dcf8001d292b ("vfs: Suppress MS_* flag defs within the kernel unless ex=
plicitly enabled")
>=20
> from the vfs tree and commit:
>=20
>   2c070709ea75 ("This updates the x86 code to use the CONFIG_GENERIC_CMDL=
INE")
>=20
> from the cisco tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/x86/kernel/setup.c
> index e493202bf265,ee109f490b22..000000000000
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@@ -51,7 -51,7 +51,8 @@@
>   #include <linux/kvm_para.h>
>   #include <linux/dma-contiguous.h>
>   #include <xen/xen.h>
>  +#include <uapi/linux/mount.h>
> + #include <linux/cmdline.h>
>  =20
>   #include <linux/errno.h>
>   #include <linux/kernel.h>

This is now a conflict between the cicso tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_//A=/GjsJxw4P=Epi8/=Qf3V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw9DjoACgkQAVBC80lX
0GwNVQf/S0pWebPpo5F/IIino/Ko3GWl61ufOLwrj5mEgOxgGfI76sW6tV5YLZjL
4J2JzKwU9KF5vf/dwZE9LLE38HDEQnUI9iUT6TsJPQs7aUsgSWTvTPqWI1dSdg7l
tSYBmKRy+cpwiPpfcg5WIM+A0EKxKHo/dkceKbc3WSV9Oh4gnOXvmhdhoPlo8DuD
k1L+uWP+qbStHF7ejDFLKa50t3VGZ6zW/Qd7Ml0EI8atMl70XwvxVMZ+xZFl01FT
cN7Mgz8Cbcu8kJRCMJcD8gP/bGZ3eE20sZgnULWyJzpo/aDKVtBN68zjAXZMZ2mq
IBoWByOz8BwMGqaH5sbg4AT9/A1nCg==
=N42Y
-----END PGP SIGNATURE-----

--Sig_//A=/GjsJxw4P=Epi8/=Qf3V--
