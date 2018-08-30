Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63A6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA6D20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="d5weP3xL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA6D20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeHaCuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:50:05 -0400
Received: from ozlabs.org ([203.11.71.1]:57701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbeHaCuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:50:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 421cym3SDrz9s3Z;
        Fri, 31 Aug 2018 08:45:36 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535669136;
        bh=grO5b9fxw9vlcH5fZ7gu6EWaMaaKKAxNi6NpUNJ9b1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d5weP3xLXrutGa+6jLIaScTyG4LMOxohr6zmt+tP1H+Jdq3blaH4aqnNVFSpwqIC6
         J56FnfXZE84uAlJ2gT31GVGhWrgXslfGQVgxVSPPqfRBRPzyLpSUPrJGxkGjjxLscC
         gtUH386uJC74L8EXLXRI9ABLeVvbK0nA7vjAyZsyz+jnjBM+e2hH/CVCzkYD7a1pSN
         pkxBc3NV9F2eRe8Gpw8sjB12FpVoY17Niao1d1nSKqZvmRkBoAtMsCjMbW9sLYK8OJ
         /qX5xTqmcHxo/OP1IF9BVHdxUpRkO3itfLc0t4RrgeGCfnmOdbWJAcggDXZZmI0g2t
         dN0+7nBPvvqVA==
Date:   Fri, 31 Aug 2018 08:45:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Linus <torvalds@linux-foundation.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: disabling -Wstringop-truncation
Message-ID: <20180831084535.505d1822@canb.auug.org.au>
In-Reply-To: <87in3r32qh.fsf@linux.intel.com>
References: <20180831080714.4f94fba9@canb.auug.org.au>
        <87in3r32qh.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4fmv1BG0UF8lscL5tpTU31Q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4fmv1BG0UF8lscL5tpTU31Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andi,

On Thu, 30 Aug 2018 15:32:06 -0700 Andi Kleen <ak@linux.intel.com> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>=20
> > I am now mainly using gcc v8.2 for my builds and -Wstringop-truncation
> > causes so many warnings that I am sure to miss others, so I have
> > applied the below to my fixes tree until the noise reduces. =20
>=20
> I have the same problem.
>=20
> However It's not clear if they're all false positives (I suspect not)

Right.

> It would be better to move the warning to W=3D2 or so, and also needs
> someone actually looking at them.

Sure, my patch was just a quick fix for linux-next to make it more
manageable.  Also, I am not worse off than when I was using older
compilers.

--=20
Cheers,
Stephen Rothwell

--Sig_/4fmv1BG0UF8lscL5tpTU31Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluIc48ACgkQAVBC80lX
0GwI7wf/e5+zFNmRn20g1fNNeGZndTt01o1cFmXlelq2oEtJ+Wt3d4ZQnqm9w/YF
KKf5kfKw2UeWRW14mgRac9mXH9mfMljQznFez9M28n5/8zNxbt4cIUOKaIreHdPM
vZzetEJQ0qldKupuLXQjBC7ye4L5PSUed63Vzkzw8hO5G2hDPcaNjrt6KaB8o8k6
apQ2CA8xN1LZ9kmm9nL6yP7WQa0PPq3HBNOpCOtRaIAca7VP7PVXTnhZMNaJletg
4wVwYtegtxUJ5NAuHTuc99FT3tEusT4XbAbFqARikzj7mcjgP8oNuZF01+sVz1nk
l4CBslYgpnzKsi+7/ugF+e+xnEiu4g==
=dsnB
-----END PGP SIGNATURE-----

--Sig_/4fmv1BG0UF8lscL5tpTU31Q--
