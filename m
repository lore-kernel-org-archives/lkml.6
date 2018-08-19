Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EDEC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 22:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B69520BED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 22:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WldTBrW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B69520BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeHTB3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 21:29:23 -0400
Received: from ozlabs.org ([203.11.71.1]:50315 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeHTB3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 21:29:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41trr30Z0Gz9s4c;
        Mon, 20 Aug 2018 08:16:19 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534716979;
        bh=bEAAWqzO4jZko/PrIYB/rK9bN5T7PkeekrYirOW1vPA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WldTBrW6L6avLGAMkqMqpXTvSfFYu6pBHPVnJbRdNAeozXpATEnQYjaVF7hWPSZel
         2RbuKUqG6okSOeXn4pBrH3eRCBaWm1FEZcv1Uf+5/XcXs3fK7yerCbfXK0DXcdDYPa
         H0CTKXwVQuvISDnO26ESLCh1kUFQjs2q6ug7w+3N/1iDWNotTYILU249Omq+wlziAH
         FW5hUC0NI2AZDMiJ03NhiQd7qxnPLgMm6wuSXin4jgqWmwr0dhSNbieeapsosYGlwr
         qoVQ63xeq0FkViYa50tCfHgHnJfiPqtpP0J0JUjXfBhLFPVJ56szhq2Lb+RJcqq2Ws
         o91EdHWLwcQYQ==
Date:   Mon, 20 Aug 2018 08:16:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings from Linus' tree
Message-ID: <20180820081618.1338cd47@canb.auug.org.au>
In-Reply-To: <20180820081323.23a47af3@canb.auug.org.au>
References: <20180820081323.23a47af3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9Guif6RW=SifqoZH+9=HrwM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9Guif6RW=SifqoZH+9=HrwM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Aug 2018 08:13:23 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next build (powerpc ppc64_defconfig) produced these
> warnings:
>=20
...
>=20
> Presumably caused by my update to gcc 8.2.0.

And this from the x86_64 allmodconfig build:

scripts/unifdef.c: In function 'Mpass':
scripts/unifdef.c:453:28: warning: 'strncpy' output truncated before termin=
ating nul copying 4 bytes from a string of the same length [-Wstringop-trun=
cation]
 static void Mpass (void) { strncpy(keyword, "if  ", 4); Pelif(); }
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~

--=20
Cheers,
Stephen Rothwell

--Sig_/9Guif6RW=SifqoZH+9=HrwM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt57DIACgkQAVBC80lX
0GwNfQf+K07qdPYpBe/JqgsTFLM1DkDt/Yh4ojmyyjpYP6+s28meOItV3+y9dVXQ
q3mMSSmCXo0s6ZmzWZduy8QTWgqeGpMivOleesjiz3miG3IT3uZXz0URcUy6ewTP
MduAC6q4kEemRAtWmbn9HUDDVhBRq/b+hM7hiOluEETlWvwHVKRzhhUDGiawzRHy
RDyo+rCpLhBFb27A/FSVvcd48qFgRX4LlS7T54OG59vHPy9nbWWcf/+yRFGSOF/+
W6gRj2Px7+nSYvapjli1Otbi+AVhZmDOPYWMN+q7BBG/GjyBAhALOvu7cEWL49BK
WYgJ433vXlT1+qmxl0KsLyZ8ae2blw==
=H6HO
-----END PGP SIGNATURE-----

--Sig_/9Guif6RW=SifqoZH+9=HrwM--
