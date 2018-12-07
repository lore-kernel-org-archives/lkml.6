Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C33DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175AB20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NWg31SMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175AB20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeLGCiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:38:54 -0500
Received: from ozlabs.org ([203.11.71.1]:58819 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGCix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:38:53 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439xVg2Txyz9s8F;
        Fri,  7 Dec 2018 13:38:51 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544150331;
        bh=8eC3JWOTGrIv8sKD0kbqILf94eahFKmz2MxRfsDOL0w=;
        h=Date:From:To:Cc:Subject:From;
        b=NWg31SMjZSgwBR2tvJonKOYLsDJk8Kq0s7H5vQPayOViBlGT828LdrXraeSGfD3V/
         Kh6FQerX/J4sMmyrOM3RSFA9EQbmcXEchZtnw1KuyKAHd1I0Gv2N+rZxMfEEx77yze
         BnSDG+6CxaP6z3piSyYqNTRMv+DjLfGc8EmnKib0yHZF4dpVHxVRZtu3G5F0WOp0kD
         G8QKk/i8snfnjbJp9e9WK+quYpTxStR0aUcQUKR3LBM8B69+gbgazNpnjXQkKhKt3E
         BhXrrJsclTKq5Ley5u2Ycnj72StN55KnxiMr69ZBG5MXodzb9JVTmvvO/jRDqyKKuD
         fsbAI1ZfHNOpA==
Date:   Fri, 7 Dec 2018 13:38:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Roman Li <Roman.Li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <20181207133850.4eb17ff9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/i7zUcvo/4Wa+SUB/TjYDXiC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i7zUcvo/4Wa+SUB/TjYDXiC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c

between commit:

  c6888879fd55 ("drm/amd/display: Fix 6x4K displays light-up on Vega20 (v2)=
")

from the drm-fixes tree and commit:

  24f7dd7ea98d ("drm/amd/display: move pplib/smu notification to dccg block=
")

from the drm tree.

I fixed it up (I am not sure how to fix this up, so I just dropped the
drm-fixes change) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/i7zUcvo/4Wa+SUB/TjYDXiC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwJ3ToACgkQAVBC80lX
0GwNjQgAnwWb1OlQkcjjG/UeKM6qgrydyFJCPsuRyWPyJYZEvE9CHrnOQfIJzuEV
GwjJHhM93oiwUlPHvrkO7UTcJc0z09hkoXPUK0X/2L0oqkx7m0KGllJIh4yF2ynK
lR3eKbkHKXo5zQcX9Jr6hMM0ONWevAdC3bGpss/9DFAGemG36hBYESyxpaxu9ICP
OTUaE48yHahKpNnmZdUslnC/z7GHMb8PrmHAAoy2q97ZkA3Wke/PnQiyQs2GH5Jw
HJwCezabEEBRo/9u//iRtwV7Jwule4tFVfhdNu/QKRmd6W0cqBTlIqVvuoHVsYdQ
K3CrHjyw83TZZgC1BDgzvv02NZUcUg==
=EfWq
-----END PGP SIGNATURE-----

--Sig_/i7zUcvo/4Wa+SUB/TjYDXiC--
