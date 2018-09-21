Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC633ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735E12147C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EisbaGCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735E12147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389426AbeIUO0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:26:00 -0400
Received: from ozlabs.org ([203.11.71.1]:39621 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeIUOZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:25:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Gn6m12ppz9sBJ;
        Fri, 21 Sep 2018 18:38:08 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537519088;
        bh=zLyWfVJEvbY8Tl0ebz9R3mreR3oAtZlcnM9ba0ZvKfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EisbaGCZVee4FgGpIDTu1ZaFrhd1lmZIADzZbT0r/3kmjz+IprJhwhlenhKuXEUMY
         Up+VoX4WV4P5iy9haiePCYmWR6ZFxHmrK04QTyXEJcv4GEMJdOOYHHGbFsIGCOkUbo
         0WA8Oyr67I9J3t5f11OQOxHLChv7aCUBHpKJ8OaMvGsmQtNmyQhkxks9kSRhCNUD01
         OolQvEUOtp2SwrzkW47dLfHIo0CvGDST0+n/zJe79OcGlwDUVjkOaFep9DoKlXrQDj
         IgPLwooEua703a8D6Yq9ylYxj+ecMnXO/wrbk2Q0CUJw9m8851wzXyT/U54O632pRo
         sg018txOByMqQ==
Date:   Fri, 21 Sep 2018 18:38:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 5/9] signal/powerpc: Factor the common exception
 code into exception_common
Message-ID: <20180921183807.700623bd@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-5-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-5-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//TK0bzvZq/Kez6spvh++oVH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//TK0bzvZq/Kez6spvh++oVH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:46 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> It is brittle and wrong to populate si_pkey when there was not a pkey
> exception.  The field does not exist for all si_codes and in some
> cases another field exists in the same memory location.
>=20
> So factor out the code that all exceptions handlers must run
> into exception_common, leaving the individual exception handlers
> to generate the signals themselves.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Clearly no change in semantics.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_//TK0bzvZq/Kez6spvh++oVH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukre8ACgkQAVBC80lX
0Gwkigf/bA/DSSCczbH5itXP3jjiTRk4KR/N1QmKfnFTXvrspspJjGyXr+88oGeY
rVK+HHbcdXuNQmi2dGL3UYhAcBPqmHb/MVEtblEpi9/zxCCku2evwJqQKryfGaKA
fhskO18ZMSD1aRqrJ61YY7kC/ZqQ+oYGIlpZidTX50Usf6Dl1zXmb9mewggnzX24
94ObFYt7duEt5lW+NII1dCxPZMxZM4T1O79efhgPU3IGP9UEjHYzin6Of/AVjU6R
o34/Oo6S7jBAXBTf8sgo2QEwnEz4xu27NQuFHtkG2/LwBlKrKPw/ngHGQiWbzahX
oOWqoaiphleG4+40GHtmmxCLe8VDwA==
=FL4j
-----END PGP SIGNATURE-----

--Sig_//TK0bzvZq/Kez6spvh++oVH--
