Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFC0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51302063F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="r0r6bKq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfBUCOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 21:14:00 -0500
Received: from ozlabs.org ([203.11.71.1]:50915 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBUCOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 21:14:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 444dLr74SRz9s5c;
        Thu, 21 Feb 2019 13:13:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550715237;
        bh=ZgdCGCSioTEYVpFPWAlqG17Gq+Jfkc1BzwwnY7pFYXY=;
        h=Date:From:To:Cc:Subject:From;
        b=r0r6bKq53N85yX2WPlTI448bYFCVtaznrBPFeyGxKIufLB1nCssLyqW29bGfaA+Ad
         G0dWkEoOEgyd8xdoSSxYqO4Mw7V4H2RoTosg4zS/1mPq286eDXegJ1O3vL4HM9ePAX
         EBL1ykONDtKbuZxUu8LOA9WTF/m6l3iWP+lu08ex5sPL6ElBCYXZTx9AfGZOEy83Nr
         XVXZf5OKRytIRC0C1817O8H+5rItb+BJYsEfTOlf9Rtbl4LIgVBi8HedSN4QVHFT4d
         HVzUmXEZ1uCJX5FYka2MqjMFmPCX0ZewcwMaB8McSxrLnzy4yKEvwSAjhCSb9YELCV
         wQ+EIc+eFmElw==
Date:   Thu, 21 Feb 2019 13:13:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20190221131356.6a477727@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D.353ghiToqxg5gJzzMiy=o"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D.353ghiToqxg5gJzzMiy=o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

sound/soc/samsung/odroid.c: In function 'odroid_audio_probe':
sound/soc/samsung/odroid.c:298:22: warning: 'cpu_dai' may be used uninitial=
ized in this function [-Wmaybe-uninitialized]
  priv->clk_i2s_bus =3D of_clk_get_by_name(cpu_dai, "iis");
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  d832d2b246c5 ("ASoC: samsung: odroid: Fix of_node refcount unbalance")

--=20
Cheers,
Stephen Rothwell

--Sig_/D.353ghiToqxg5gJzzMiy=o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxuCWQACgkQAVBC80lX
0GzLKgf+I8LD/4hoM5MTxufQtLAdqo9N5W4ueLqdsa3QLgsBmn8zF3jXEtYVehTB
aatLJJl/ePg0hZwnkSUYqvW1JIhDVRZNJyNM2scBsIOZ0F5yswbWB2v+6V+mkIga
uoSb0z/UksnJspbwlNvh8hLr1ryVqWm+PsvYfyRuaGo+x29TKiJ9RFV5FCJj21Ib
XwXuhe5V7qa7iT9HoHz1k/1oAcQGtZW5HYQBUL4Qz+nGYaAhBZs9BRQelYF5M9fC
S+CZaN7OH2wakyksTDIhhKty6BNhF90T/Sn+OXcaykKz2W0GKOMB/nC1ZZpzrcWF
3l2QpujD5w4s+L2mTwZ53tR2oaa+TA==
=ANSR
-----END PGP SIGNATURE-----

--Sig_/D.353ghiToqxg5gJzzMiy=o--
