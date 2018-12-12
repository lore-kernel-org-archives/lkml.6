Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52EBC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FBC2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ctNXzdqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FBC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeLLUoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:44:13 -0500
Received: from ozlabs.org ([203.11.71.1]:59743 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbeLLUoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:44:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43FTLd4wVfz9s3l;
        Thu, 13 Dec 2018 07:44:09 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544647449;
        bh=jU3RBMY3aI9o3+QsinJkFe0/isdVydz2+D8NY+nxouo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ctNXzdqvuaJOTz7hYhTRdFRPPJKJEti5wfyLuLz0dOXH155MEPCNDUDNXyY1ceZnj
         xlMO4VeYNw+Mb0Zo8dgubGNFBZUOwFrFJr05IUV+mR1IVoaSUlFA4XMUboqDrwwQXC
         7T3AM9U3G+50lm2jeZPjTYHwJwV07lSn9Qi+Hm14dQPdeAFQlZQtdF9G9Ocn4jdRGE
         3Q2sj2xwJZNdtQG5acjtmvQ/djCc86XTA9VeLqWPjTkAlx5G0US9pWpjx+PTs2G3Bp
         ppDh7fFnmyynCuMWaFI7yHzHRiEuP57bnpMon8h8LEeKHzytKoiF/w6Nca8vOvfpCx
         gjtusYoaXWAgw==
Date:   Thu, 13 Dec 2018 07:44:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the akpm tree
Message-ID: <20181213074408.1355ab8b@canb.auug.org.au>
In-Reply-To: <8e677bb9-22c3-83c5-ff41-765d20fc0047@arm.com>
References: <20181203180037.0a54279b@canb.auug.org.au>
        <8e677bb9-22c3-83c5-ff41-765d20fc0047@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZmxodMAhsUdWwh9J.pBa5qf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZmxodMAhsUdWwh9J.pBa5qf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Anshuman,

On Wed, 12 Dec 2018 22:35:38 +0530 Anshuman Khandual <anshuman.khandual@arm=
.com> wrote:
>
> On 12/03/2018 12:30 PM, Stephen Rothwell wrote:
> > Hi Andrew,
> >=20
> > After merging the akpm tree, today's linux-next build (powerpc_le perf)
> > failed like this:
> >=20
> > bench/numa.c:37:10: fatal error: linux/numa.h: No such file or directory
> >  #include <linux/numa.h>
> >           ^~~~~~~~~~~~~~
> >=20
> > Caused by patches
> >=20
> >   "mm: replace all open encodings for NUMA_NO_NODE"
> >   "mm-replace-all-open-encodings-for-numa_no_node-fix"
> >=20
> > For linux/numa.h to be generally availble to the tools builds, it must
> > be copied into tools/include/linux ...
> >=20
> > I have done that copy for today:
> >=20
> > From 6dabc11d5513510d0ec0a6b0a4aa8b9051b71516 Mon Sep 17 00:00:00 2001
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 3 Dec 2018 17:57:27 +1100
> > Subject: [PATCH] linux/numa.h is now needed for the perf build
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au> =20
>=20
> Hello Stephen,
>=20
> I will respin the original patch (https://patchwork.kernel.org/patch/1069=
8089/)
> once more to accommodate new feedbacks from Lubomir Rintel. This patch fi=
xes the
> build problem related to tools/perf. As Lubomir suggested, it might be be=
tter to
> split the tools/perf changes ("tools: Replace open encodings for NUMA_NO_=
NODE")
> from the original patch and then fold this fix onto it with both signed-o=
ff-by.
> Does it sound good. Are you okay with it ?

Sounds fine to me.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZmxodMAhsUdWwh9J.pBa5qf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwRcxgACgkQAVBC80lX
0GzgEwf/YncIIrFSJ2eXIYSalgTGJjnTDa1fPICARIEhytg2mmTZYWHNqAuP2hnt
LwU2axyUBkqYRRmjYue8bIxApfhu35pwT3IwEF3HHlvGIqqZ4IIbcECUZxwznOG0
Slq5kyet6evkCmZm7i+dnSjmR/ESfJJrVhZ0ROs2GRpiSUrCz7nI6pxJWdsqwYy4
ghchrvGvcu9hKYrtuWhnqdYMatHo7wkg2oKU7c5PovwIOgDLtKRgJ/frw9B+6La1
pLUbmUHzhCxnz/s07bfASRU75f2m2CIdjvJ8ebOkKo1kArY8OZswTO0jVDPjfnwl
lmWHeqf54UrvTJDdC5U2JzUBOfro/A==
=HcRY
-----END PGP SIGNATURE-----

--Sig_/ZmxodMAhsUdWwh9J.pBa5qf--
