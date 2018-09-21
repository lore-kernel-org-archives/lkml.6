Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B51BECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B5D21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SNQGeWBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B5D21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389470AbeIUOmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:42:24 -0400
Received: from ozlabs.org ([203.11.71.1]:33799 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeIUOmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:42:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42GnTf3t75z9sC7;
        Fri, 21 Sep 2018 18:54:30 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537520070;
        bh=fxeplYT2LrgQUF4P1brux0IyODL1ZXrf9cnTFGnBYFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SNQGeWBRdWGX8bXJYoTtpq4Swu03SG1a28bvNyQwseEarT3KM+WlSTrW2E39AHXCP
         fdZ5gMmwGi/T9hiahyPUepMw9GQbwALA5JpxFbodNyYZEVkvvC+2Mf3G+JdLpVn0Z0
         NcMwRD19loy6F+Iv8gEGRS55yHnBSRe0DVYpRPbRw8fltjoRrK5PEDS5RoJCT9Aolg
         mHCX6yWecsWDsq9htlaQFHnftlnQu4jh+LDaUeUn/LyCWalPmgEPZg1fgFCQxJpo8W
         cUGthPMUUFnARyPrCkMOmlVrKihkUJobr0XFXXc4xEj6baAR7b4ToLNECLf7dgvLZw
         Q5+j01CWESLtA==
Date:   Fri, 21 Sep 2018 18:54:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 7/9] signal/poewrpc: Specialize _exception_pkey
 for handling pkey exceptions
Message-ID: <20180921185429.4cda432e@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-7-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-7-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lFjDkxZKyUobxHjbwFpE2lL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lFjDkxZKyUobxHjbwFpE2lL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:48 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> Now that _exception no longer calls _exception_pkey it is no longer
> necessary to handle any signal with any si_code.  All pkey exceptions
> are SIGSEGV with paired with SEGV_PKUERR.  So just handle
> that case and remove the now unnecessary parameters from _exception_pkey.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Looks fine to me (small query below).

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

>  	clear_siginfo(&info);
> -	info.si_signo =3D signr;
> -	info.si_code =3D code;
> +	info.si_signo =3D SIGSEGV;
> +	info.si_code =3D SEGV_PKUERR;
>  	info.si_addr =3D (void __user *) addr;
>  	info.si_pkey =3D key;
> =20
> -	force_sig_info(signr, &info, current);
> +	force_sig_info(info.si_signo, &info, current);
                       ^^^^^^^^^^^^^
Why not just SIGSEGV?

--=20
Cheers,
Stephen Rothwell

--Sig_/lFjDkxZKyUobxHjbwFpE2lL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukscUACgkQAVBC80lX
0GwAXgf9F8yMklDfoP6e48FJaOXDueVFA9b53pNSfzFQugIKW1XsaxdbL8qI9LWJ
wpNJ8rZETfWnFtlnWG1KdFjUQB3oH5OqL3VXaDh1ABnZlcCPZ/NypUuDR7yp5lkr
v6nxgep+81ccgBacRK64s5k7m0FVbVvFRzQ2HdRmCCbOs7B+cLUeZu6ojjDVE/w7
G1xRb4l1sPZQ1tbxcTUkDNm0bySy66lc07N5bXKqh0oywxf0yZjFOilT2Z4QzuFW
b2Za5SvMlQRTW2mE2dcvvazFTBxavx01PBqq8/U/r7/tdP8c7IyTdq8+8rpC8lre
aL7CFmHgGNQXRIgvd510/NIX5dnYbA==
=eOVQ
-----END PGP SIGNATURE-----

--Sig_/lFjDkxZKyUobxHjbwFpE2lL--
