Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0229AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFDC217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gGWCANmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfBFUGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:06:18 -0500
Received: from ozlabs.org ([203.11.71.1]:51967 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfBFUGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:06:17 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43vss347Zdz9s6w;
        Thu,  7 Feb 2019 07:06:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549483576;
        bh=iKxpzjT3T4VqdCwHlt1D6bJh8xMiLy1vK6PtH51HotM=;
        h=Date:From:To:Cc:Subject:From;
        b=gGWCANmX5HF8x713IkgfnrlGNC2dl8gPyg2qLnIAF//qnOPuG2VIGeh3+QSXQC5U5
         vlOKn773JjU9CUj766of/S0LeM3BnArnTAWxKkRJaQLT5ohEePDR678meOhUvKVnxr
         VZRXTRa8G4MGORc6+50sfl2lVAi1J/j3iOxxEyBLk+EvvoxcXuvHGhxmjyFK2Jn7bw
         dc9XXNj1g57E5C4dGw+7KzGC3FQEy/97N8yIxqh/llhucUQCjBZmYFwD8Rnm/1Qcn+
         i3GLjKg4C89FDoZ3qoMamq5mOt9CYcbmVQ5hwf51aRKIeq8Z8WwaoH5p8x1MoKodaF
         xwWqgwB2xmdyw==
Date:   Thu, 7 Feb 2019 07:05:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc-fixes tree
Message-ID: <20190207070550.0b650148@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fLFIfflFhhi3=SPda+1M/tz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fLFIfflFhhi3=SPda+1M/tz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d9111d36024d ("ASoC: rsnd: fixup rsnd_ssi_master_clk_start() user count c=
heck")

Fixes tag

  Fixes: commit 4d230d1271064 ("ASoC: rsnd: fixup not to call clk_get/set u=
nder non-atomic")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/fLFIfflFhhi3=SPda+1M/tz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxbPh4ACgkQAVBC80lX
0GxsHwf/SfETPsPfrw/ESm5Uzxcza99r7DkZ5oa7WUcg7Mj3dmCQYnfL+9N0nnCC
Qd0WgIJGT12hPA89d44lPQ9/PJcUPFaDyWT6Mz2+7umrWwoKLFpyXVdmeVER0F9e
ghrKkBU3ImnixjV2wOfhw2mQSu+ld7u4u707WZfIfn55d4urkP1IUFeUAJ7VIB/H
E/8HhCVbnQMW7NoIMALTxLZtbH2PIGaWc6yVkFXNWjNsjREkTEkt0TFWxbZS7iPd
Su5L0olvYiZCRSFz3kZaHnSJXnhOM/HL89o+M3XHJQVIsypJOATHsZS9FMV74aQL
YADZAPUBdlyeU3IjB1SfDCG/R46scQ==
=oFdY
-----END PGP SIGNATURE-----

--Sig_/fLFIfflFhhi3=SPda+1M/tz--
