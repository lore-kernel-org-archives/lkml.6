Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E515C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B39820896
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Bhc4gk/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390498AbfAOVet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:34:49 -0500
Received: from ozlabs.org ([203.11.71.1]:42791 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730508AbfAOVet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:34:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fNsK6dqJz9sDT;
        Wed, 16 Jan 2019 08:34:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547588086;
        bh=PhoXp/f+riK0m1tbRDlpXlm6595oHGFhDQpHfBHHSgI=;
        h=Date:From:To:Cc:Subject:From;
        b=Bhc4gk/s4HXGJUtQoxWSuUFU6CNED4lM2sDKjXTT6kxE++xH5s5lKGbzEJOVBxHIC
         EPF0hH8d9cWE3oh/Qau2xQuuN5nUxiK3ADyvKR52nB+79OVBGEfLcqPR/lHb8t0nf1
         QXsqshJI/I/zMr/bbowDMFKu/5Dgu/agoLAtw3CLlNLVgwd6ubJdZdgNrrElAHwy1w
         zER/50BFutJvcN+IhVghzm+6H0o3XxuSrvt05TQyihwL8RJ6r5F4rBVrtgSkN7J7Kx
         Pqt277ZI3XG4b9L4JiKGhD1cE00KCpcmXQsYjokH99VSHgNaYZdqOGlf4U5HafG9rd
         t0sOgJ/UFsR1g==
Date:   Wed, 16 Jan 2019 08:34:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: linux-next: Fixes tag needs some work in the clk tree
Message-ID: <20190116083440.11b6839c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LUD=LGqnB_f5UgHKR.0CxKt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LUD=LGqnB_f5UgHKR.0CxKt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

[I am experimenting with checking the Fixes tags in commits in linux-next.
Please let me know if you think I am being too strict.]

Hi all,

Commit

  b488517b28a4 ("clk: socfpga: stratix10: fix naming convention for the fix=
ed-clocks")

has a malformed Fixes tag:

  Fixes: 07afb8db7340 ("clk: socfpga: stratix10: add clock driver for
  Stratix10 platform")

It should not be split over 2 lines.

--=20
Cheers,
Stephen Rothwell

--Sig_/LUD=LGqnB_f5UgHKR.0CxKt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw+UfAACgkQAVBC80lX
0Gx63gf/dAKugoyaKtZoTxvkBM7rUSXFDmIMyek1ikXkkAVEGAG6FCsMDOoL7wwZ
aSy4gIHouoSfiMPp2bvNtyWe98ztjYul6qQlR2TOURsMNF8cy1vzulDpteDITaPY
w+VGAVmmd5M+HmM8FO1g+56w3wwoZT0mexO+eqbeaoAcsaKEYhathKlksUPoQ9EW
l3DO1cc0BQ4bEIKcmtEvAjvi5+sOnjFYBBeaZ/e5oq3vRjfyDv8JDayI9UeZ3+SS
s8V4cYlcDnVJ0HS0nj+xbdnQj0qFXeLI/SYG3iIIpxyAv/qIHO9OpnVfb6MH2jcE
RCI69JqkqswyNSN3Ymxz0KKXlb5tmQ==
=FQSz
-----END PGP SIGNATURE-----

--Sig_/LUD=LGqnB_f5UgHKR.0CxKt--
