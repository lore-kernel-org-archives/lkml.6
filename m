Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40855C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048FD2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ESVTL42d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048FD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeLKGMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:12:34 -0500
Received: from ozlabs.org ([203.11.71.1]:54475 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbeLKGMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:12:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43DV3L4YLYz9s47;
        Tue, 11 Dec 2018 17:12:30 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544508750;
        bh=vCwetUF8qOYUCoI3vNfr5pgXjkCLD8XVbktIRXcu7Es=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ESVTL42dwTx9437EcECouD+aXVWG34NzZWLls6Lfn2ilYhVFoEwPprZliAziTDK5B
         bNGWVKl5eyxWD8c94yaQ5+MYeqFLuOqtkvsGUl+igpoT9R8aYxWizUs9LgfWLr98P6
         gDkgQ5lQ+YLaV3ieNLl6aZ0cHKHo5lNBm7Neq+1zV7gGBtEgVpDkgJo1ZZvWTYxgxe
         epeAfcR6HGSt+SfwzrWX15CEXMYFWVMInKa1Fbe9gD4Ofg4h9ktRD8RFUarSDK3RZm
         pPSYCSmVVZtkiQa1bmCX9Z4aEFyRPqyipKZa+SSkKElNdMGejAJ/8pzfmvsslujf/p
         Xu9TexdUDEYHQ==
Date:   Tue, 11 Dec 2018 17:12:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Steve Capper <steve.capper@arm.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 arm64 tree
Message-ID: <20181211171230.7847fd48@canb.auug.org.au>
In-Reply-To: <20181211171102.14c0be9f@canb.auug.org.au>
References: <20181211171102.14c0be9f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zs=uUKhSg2DEOa8wELv.ec4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zs=uUKhSg2DEOa8wELv.ec4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[Sent to early with people missing ...]

On Tue, 11 Dec 2018 17:11:02 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   arch/arm64/mm/proc.S
>=20
> between commits:
>=20
>   67e7fdfcc682 ("arm64: mm: introduce 52-bit userspace support")
>   68d23da4373a ("rm64: Kconfig: Re-jig CONFIG options for 52-bit VA")
>=20
> from the arm64 tree and commit:
>=20
>   089dc516f651 ("kasan, arm64: enable top byte ignore for the kernel")
>=20
> from the akpm-current tree.
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
> diff --cc arch/arm64/mm/proc.S
> index e05b3ce1db6b,d861f208eeb1..73886a5f1f30
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@@ -449,16 -451,8 +455,16 @@@ ENTRY(__cpu_setup
>   	 */
>   	ldr	x10, =3DTCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
>   			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
> - 			TCR_TBI0 | TCR_A1
> + 			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
>  -	tcr_set_idmap_t0sz	x10, x9
>  +
>  +#ifdef CONFIG_ARM64_USER_VA_BITS_52
>  +	ldr_l		x9, vabits_user
>  +	sub		x9, xzr, x9
>  +	add		x9, x9, #64
>  +#else
>  +	ldr_l		x9, idmap_t0sz
>  +#endif
>  +	tcr_set_t0sz	x10, x9
>  =20
>   	/*
>   	 * Set the IPS bits in TCR_EL1.

--=20
Cheers,
Stephen Rothwell

--Sig_/zs=uUKhSg2DEOa8wELv.ec4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwPVU4ACgkQAVBC80lX
0GzQ/Qf/e1kLy/ifSXd/gNL5XDymN2SE+SQSIf0Kq77xus2H/IeD9MVQCaxnKKr6
b8Eeq3ksPeAshwo//5XpjJjMHX5PZ4aV0BjCccr9VKdTnhTNpHvUuI/HdPHZ/DUn
lEw3ANuQGeK60/DddV641B4E9CoXTcZ8vl0jL9Hge0jhEbinfo6nEhIGooLkQFIs
pi5RtilbhCeAMFnAZGaaI1vg/SP+eyV66DmDvYBiytqmeoz8FNbNdbz3KNmtP0MN
qWR68/Pi+m9UkWPgwj/1FEdt9q7D7Sy88HYyOP8/2xo+Fypf6PuTkmJRDkVszCZU
ZoA9J3XFeFBmv97Ad366Sqrw7CxlMw==
=PryC
-----END PGP SIGNATURE-----

--Sig_/zs=uUKhSg2DEOa8wELv.ec4--
