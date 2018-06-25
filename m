Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881B9C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 04:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1E625430
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 04:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nLYpT7N4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1E625430
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750933AbeFYEWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 00:22:14 -0400
Received: from ozlabs.org ([203.11.71.1]:36515 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750800AbeFYEWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 00:22:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Dbc20ZdCz9s2L;
        Mon, 25 Jun 2018 14:22:08 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529900530;
        bh=taiUhsnXHw+UfZ7CmZKOeQ8C1L/nciqUoTvn5H1/h3o=;
        h=Date:From:To:Cc:Subject:From;
        b=nLYpT7N4JZvXvHs0VarCgu4IImamDeQ3wbXPSAhYfSaVFYT1IucvRKL0sZEtRCpYB
         bAA3b2YGJSI6rrP7DsvxNqe34QMTwp2oqpjUpxQ5k8uonx4xkyglcY6wLRWQ5nnCKg
         h5+7ofZkUSNAhHX3/rLCEfTxCUBNkRpi+jUHqL3VdEwo79Bb3gZUNLJaT1g39PocHy
         yXIDr825AM1bvEDBSwlbbaJCcx0p3DCGW/bTh3ciLCxZ1fuws1gtCBRWiQOy8OUfIk
         qeDPOQ0otahUjw1AQmkrY8RvX6f8uUqvTtR32LGPuYNNnrYcRIKOyofMPlgOb0T/il
         b8Q2251f4+QTg==
Date:   Mon, 25 Jun 2018 14:22:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Stone <daniels@collabora.com>
Subject: linux-next: build warning after merge of the drm tree
Message-ID: <20180625142207.5feecdcf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Jlphf=sM222pYyKzfbW+7+G"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Jlphf=sM222pYyKzfbW+7+G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

After merging the drm tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/gpu/drm/gma500/mdfld_intel_display.c: In function 'mdfld__intel_pip=
e_set_base':
drivers/gpu/drm/gma500/mdfld_intel_display.c:170:26: warning: unused variab=
le 'psbfb' [-Wunused-variable]
  struct psb_framebuffer *psbfb =3D to_psb_fb(fb);
                          ^~~~~

Introduced by commit

  c7cbed560ce2 ("drm/gma500: Fix Medfield for drm_framebuffer move")

--=20
Cheers,
Stephen Rothwell

--Sig_/Jlphf=sM222pYyKzfbW+7+G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlswbe8ACgkQAVBC80lX
0GxsiQgAnt9jTEnL2m++nJWHMI9uMyz1mxnpm26mfy90UQvnn1AXeHsu4O9SqzZZ
wk50mX1QqoEbzEg+JG7lQlEPzNOPCvN2tzRzKS9Ok4R2VTBQJl3yM32I0DqD7ubX
3LM1hEBWAZQWC4n7dX7wqhSuUlWvONUNiTqvA0anE0zdv1qnBFM5T90DaibIOoQh
bZNN+R6n3Vg8b8h917HRhgtdutefL7klMRuVkv/W8oPy4MCbnavgIXzxdQnXV0mp
CUT9VgrxASbg7747Eq8d+BtvWEReNhNE4o1/dIeyTB1atAlzrR9wnG94NaZPtiVX
1TeLBy4rU9U3WLToUoso4M+Ntj/WrA==
=nla+
-----END PGP SIGNATURE-----

--Sig_/Jlphf=sM222pYyKzfbW+7+G--
