Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02B7C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897E620666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dqIwlVvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897E620666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJAH6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:58:07 -0400
Received: from ozlabs.org ([203.11.71.1]:49181 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbeJAH6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:58:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Nkzq4Qwjz9s3C;
        Mon,  1 Oct 2018 11:22:47 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538356967;
        bh=y23vuuEddFZzlqpDsxDAv5Pns1bo8I6X87C7XwSmCLs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dqIwlVvWaql9ZpP5/t1SCMyA5tOd4yTYRDPHcGz4dq+5A9nPKVr8SOKNfHJvGTKda
         K6k0vHeAXXk3lkV+xil1rgoufFs/B4tecRv0r3BnsRbB7RHw+xFJ0XaDSGj+r5IbJO
         9IorXbCha0AL5qLy4sAAlxHFP2oxfw4mDUYuqa3jCW+0URobjEmbQsV/HvjjIgtA3N
         c6dW59rKx0IXAm4G4Tfdr3pn7xQztsWpliR1YLT0Q6ybMltMviDfCaVxKSNDXE8VjP
         HWeEAXV25ax/A/OEGf7Kr8UtpbHDgo0wLHLDopTeBlW+p456A0DgONj5wYUavy98Eo
         XfW3Y8FaK22XQ==
Date:   Mon, 1 Oct 2018 11:22:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven French <Steven.French@microsoft.com>
Subject: Re: [PATCH AUTOSEL 4.18 39/65] fs/cifs: suppress a string overflow
 warning
Message-ID: <20181001112246.4dcbc4fd@canb.auug.org.au>
In-Reply-To: <20181001003754.146961-39-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
        <20181001003754.146961-39-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FB.wSKEEne+ng3sjN0gw3au"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FB.wSKEEne+ng3sjN0gw3au
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

On Mon, 1 Oct 2018 00:38:27 +0000 Sasha Levin <Alexander.Levin@microsoft.co=
m> wrote:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
>=20
> [ Upstream commit bcfb84a996f6fa90b5e6e2954b2accb7a4711097 ]
>=20
> A powerpc build of cifs with gcc v8.2.0 produces this warning:
>=20
> fs/cifs/cifssmb.c: In function =E2=80=98CIFSSMBNegotiate=E2=80=99:
> fs/cifs/cifssmb.c:605:3: warning: =E2=80=98strncpy=E2=80=99 writing 16 by=
tes into a region of size 1 overflows the destination [-Wstringop-overflow=
=3D]
>    strncpy(pSMB->DialectsArray+count, protocols[i].name, 16);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Since we are already doing a strlen() on the source, change the strncpy
> to a memcpy().
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>

Just wondering if this should be included as it only fixes a build
warning, there is no actual bug.  Same for the 4.9 and 4.14 versions.

--=20
Cheers,
Stephen Rothwell

--Sig_/FB.wSKEEne+ng3sjN0gw3au
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluxduYACgkQAVBC80lX
0Gx2Vgf/Uj49VQIpbqz6RklI7JG/+T6uaGbCoiHF5pM56P7nSI6sfo5uNUscI0pc
nmmHrkiyR8jtps79hcyaaqjsQU5hPzxD108ruKMJaOQmDeyKTmsgqPUS8hcaa1vd
RNvrktZ/76h/TJzn1Cb9VA8B/ylUIIKq8oS5M3cUc698vUhuZruCUTiIiHlFFB8N
DSPpaB+KJbsQZUoBIXQ/J1WKGYJ0tN16xutpsaYXgLXZanhudBDtoQRh6lpvxsnB
+nu/P7M96Rk4zs5mXhQFEkNVR8gQlDUf5E0zOsA0D+shR6XyetNlUwIvNdml3kjs
bhagg+KCUlO9h4DzODmW02mzli4Ryg==
=KRsJ
-----END PGP SIGNATURE-----

--Sig_/FB.wSKEEne+ng3sjN0gw3au--
