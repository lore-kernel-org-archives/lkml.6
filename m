Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76690ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1199021547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="koA8N1qG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1199021547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389338AbeIUOL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:11:26 -0400
Received: from ozlabs.org ([203.11.71.1]:37663 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeIUOLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:11:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Gmp12wT8z9sBJ;
        Fri, 21 Sep 2018 18:23:37 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537518217;
        bh=2p0UA6zQqcPc5VphS0BqoO87bQnWAbzJX6D3fJwhHFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=koA8N1qGcBy0Vdfq0ii1CRSj8EWCvp3Zi2iAk4AC52MqXy/3L1rMwbrCEDbHqBh2W
         x7vZjw5Pb9WX5de3hr1qkep6TXVDy9u1AQck/yMH8hpSPcjC5kZGMePPrDNMrGrn4l
         tTYHCMiHpPBMIVLNx2mX7Oc8Plr19bFt3WCSzZULQIX5Y8boGTcj2JTaDRJqjCSHHg
         4hvYNZ7mMB+Yby5vujaGw+myIP6KOV3y+TZFki8NhSEm+ZK/DuN0YniaaFWoqIRsQi
         qudmw8xLq/uDNlGdfWc7k33FBpQI5mkyLMd10vsY6Ufdl3e8K82Bk/Yv+vy5jhsTXb
         r3G/w1br4JBFQ==
Date:   Fri, 21 Sep 2018 18:23:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 2/9] signal/powerpc: Remove pkey parameter from
 __bad_area
Message-ID: <20180921182336.34eb93bb@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-2-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+1fvc78zun2mu//N77zcj6u"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+1fvc78zun2mu//N77zcj6u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:43 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> There are no callers of __bad_area that pass in a pkey parameter so it ma=
kes
> no sense to take one.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Fairly straight forward.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/+1fvc78zun2mu//N77zcj6u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukqogACgkQAVBC80lX
0Gzg/gf/WX4pu1mmKoOigaEl4I8FeP/UYJwLdW5/Pzh2ZHt3wSwPa83m9llUlgO+
WA0pEchtVOFP8EEWEJz+kjwtM6tKUNKssgtS47svKZv5neMAZCOCgOSmMPM5WU+b
oEhbdgJdeKKZ+4SRk5VhbmfUk6XdEqZ6AWP9i+CM9RdBNbAXHunVQ0o28WUJircl
8bnZNblQ0Zrqd2jbc4tEcSBjmibUA2NLzvLM9Q3LBJP5GVHZo1iFxzNBYGVNbfhP
0xLluK6fhtNg2V28geP2KKbRMDzQDnWRMGjHhJQibiwDpXMvf4rgPgb4fn5CdCz+
4YG4NyhPLvJIj2hSX/KUTYkTgcsn/A==
=h6+X
-----END PGP SIGNATURE-----

--Sig_/+1fvc78zun2mu//N77zcj6u--
