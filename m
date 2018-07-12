Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231B4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EBB21479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uP5VWGV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EBB21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeGLHDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:03:19 -0400
Received: from ozlabs.org ([203.11.71.1]:57959 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbeGLHDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:03:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41R6Bf0xpWz9s1R;
        Thu, 12 Jul 2018 16:55:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531378506;
        bh=LjBxex1UdvBWEjrWgp4qcrOQazmIWiobB0GSMMVQwrs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uP5VWGV3Flk8Yb2zaVaZydH7OjZd6jR9/3lIGaW8WQt8r11F+8UMV+kXORCwraVdq
         2HRC5QsPeXjm0t4ZLwj7fjMI9IXqjsWstniDZ1//+bICohQVV1fVEsuj0SsFhgVTNV
         d1VwlK7ATACnG7VMzHjI8vaBIxoxic0F4/54ctWQCVdEkIug1Z0HeBsNvGBL+Gywno
         m2e2cW5vrzrUH5mlev20g8K6tyFOuWDy26TXf5xKmsGL0ZG6R5t7ha1oAqwUm1HN3S
         WKhaeGUnh16nMat5jizVGG90CLCSBV+UzNrfteBVgx3JpdVyzQep4stQlVBnVl0cu8
         79sdxRPdwRttQ==
Date:   Thu, 12 Jul 2018 16:55:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        osalvador@techadventures.net, mpe@ellerman.id.au,
        broonie@kernel.org, mhocko@suse.cz, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, mm-commits@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bhe@redhat.com,
        aneesh.kumar@linux.ibm.com, khandual@linux.vnet.ibm.com
Subject: Re: Boot failures with "mm/sparse: Remove
 CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER" on powerpc (was Re: mmotm
 2018-07-10-16-50 uploaded)
Message-ID: <20180712165505.0a0d4214@canb.auug.org.au>
In-Reply-To: <20180712094729.1112f290@canb.auug.org.au>
References: <20180710235044.vjlRV%akpm@linux-foundation.org>
        <87lgai9bt5.fsf@concordia.ellerman.id.au>
        <20180711133737.GA29573@techadventures.net>
        <CAGM2reYsSi5kDGtnTQASnp1v49T8Y+9o_pNxmSq-+m68QhF2Tg@mail.gmail.com>
        <20180711141344.10eb6d22b0ee1423cc94faf8@linux-foundation.org>
        <20180712094729.1112f290@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9VtbG/=2abtdT+J+ZGKDtty"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9VtbG/=2abtdT+J+ZGKDtty
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 12 Jul 2018 09:47:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Wed, 11 Jul 2018 14:13:44 -0700 Andrew Morton <akpm@linux-foundation.o=
rg> wrote:
> >
> > OK, I shall drop
> > mm-sparse-remove-config_sparsemem_alloc_mem_map_together.patch for now.=
 =20
>=20
> I have dropped it from linux-next today (in case you don't get time).

I am certain I did drop it, but some how it is still in there :-(

I will drop it for tomorrow.
--=20
Cheers,
Stephen Rothwell

--Sig_/9VtbG/=2abtdT+J+ZGKDtty
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltG+0kACgkQAVBC80lX
0GzE8gf/fUdfa84A9Rm5btRmAOAHWKjSdaNqQP89D2p0DFJHL8Urv9aFxTctkwNH
gTd98JpxjiIdHIFOt5Ct29OD6D1p/6Z2bLLu4o4R1DZOBITQ5ky+07oYXSEEv6zh
0TT0moiaKnXY38SmpYIvYj3QzIvZIRKaiSstkktY7Y8s6EUPOREV4sCOTK8d7NBY
nmFHt4w9pn+maq81lPha0n+PVGCdOTLPFGXYt/Q51xxDoV69XSpa+XagDgXKPURr
PQuisARvCX4Xv47262d2X8v9eS/Cqi2zGWYPx5i+rXW1lEopjEZ/Ry6iGtlux2EU
rMZVqBfDfp643ZRF02MXA16fIIFIJQ==
=FLOl
-----END PGP SIGNATURE-----

--Sig_/9VtbG/=2abtdT+J+ZGKDtty--
