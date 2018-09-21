Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19E3ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2692154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L/+kvYtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2692154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389358AbeIUOPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:15:10 -0400
Received: from ozlabs.org ([203.11.71.1]:50605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeIUOPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:15:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42GmtK32FTz9sBJ;
        Fri, 21 Sep 2018 18:27:21 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537518441;
        bh=7GiG+9sFo5GyIO6Gg/kEPRGGGarPyPAzJ89/Ervw6DQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L/+kvYtXo64bSQjFEJF7noxdJhJ5xvC1u8kZxzL1NaiaFSbfXDPxTCNDbn4l/AbSv
         EULJlxDGt1KRcgeCQbrneMzYTELZuwRE0+2B2ghUvWNIkvKdzKHu2ZXjtFD7GRTycm
         gSNBAsLr2CzcvbRDw1zsOLyH+ncCglB+d/XKxfcm3nCf0yKOrvJ7hvbip977qBlL0c
         6HsX5MbJTqwSrZTvec1Mn/B33D/A2eWlCLpb41qUeVL5CfjGzipydHjQqavrnOxKOz
         oT0eqXzQvaI1/lStECz1zpRuNKjRNEoX9dDgTMEgRBlMjO8IkGSaAsxpqEXCUHZ3dH
         VRjaYqF924qYw==
Date:   Fri, 21 Sep 2018 18:27:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 3/9] signal/powerpc: Call _exception_pkey
 directly from bad_key_fault_exception
Message-ID: <20180921182720.33c3f8a9@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-3-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-3-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qUkmP+t.roKV2=ucn=23vo3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qUkmP+t.roKV2=ucn=23vo3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:44 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> This removes the need for other code paths to deal with pkey exceptions.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Straight forward expansion.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/qUkmP+t.roKV2=ucn=23vo3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukq2gACgkQAVBC80lX
0GxTxwgAouidowtsKnuRFonlSwPPyq6/LhjukwRpy5HKd8fqAVfPRLhgusBr3qUG
f34npGhGWwsIcVZWNjJbT4yOHxf04qgdhWMTRkxKpLa3nyT0Z7lpVUKflCGFaZQc
toJivHkVpYNygR5N1lrcwxkEFLKESkQNqYD5k5j6uS5UzXClElC5mshVludpU5ga
5sAdIEBB3fJtMtnOTkimgSRLS6guKXeRYgv8ea7T7QoJ8+VIujlt/sEhS+sLWrsq
MhcjfmyomAyvo2ubmYxn7ycr8JhO2bodd84MSzQLedwCuVOhqOqXURE0q+kagvlT
mRBHVKpaKPHBsADOYYhH+8BmJdUFzg==
=3nK3
-----END PGP SIGNATURE-----

--Sig_/qUkmP+t.roKV2=ucn=23vo3--
