Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACAAC4151A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 21:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701E220869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 21:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="c9171XmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfBBV2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 16:28:14 -0500
Received: from ozlabs.org ([203.11.71.1]:53047 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfBBV2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 16:28:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43sRsQ3hGjz9sDX;
        Sun,  3 Feb 2019 08:28:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549142890;
        bh=6YaefKLBFiVfnn3LNeSByys/+suYzLb55PQTVnQhosc=;
        h=Date:From:To:Cc:Subject:From;
        b=c9171XmR7FOphjy1bbKmMGqDy+vL5/KeW9kWnOgnQ7AjohvOWHmvqiYF5fxrLWOJP
         eT54ia61o5QMyrluCand5RcBNi0HLZUuJPE6FtoalgQitX5H/WonvxBGzZa0KeHl4Z
         54XwcE6md92z5ykxhraVbpbSeoNZEqOYyC/Zbc1jXWDRVL+8S9exH4igrgGRy7X7c2
         /IGt7jstm8HkacBsrQ9L68mkd+WGT7LTYv2Uj4tfIdP0MBJJyAIc+rSKk69OwO/Qk3
         akxJrT8ZC34Z/vVCvvCyIHWofFajlrns8qNDGo7H8v7wcMvzl24LMTo45KTtRRzgbo
         hpBnVU5MILYWw==
Date:   Sun, 3 Feb 2019 08:28:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: linux-next: Fixes tag needs some work in Linus' tree
Message-ID: <20190203082803.5f7fc82e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WQfnB1TBUNONhsJ5OCl6FnW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WQfnB1TBUNONhsJ5OCl6FnW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

[Just a reminder for the future.]

Hi all,

In commit

  85bd6e61f34d ("blk-mq: fix a hung issue when fsync")

Fixes tag

  Fixes: bd166ef1 (blk-mq-sched: add framework for MQ capable IO schedulers)

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/WQfnB1TBUNONhsJ5OCl6FnW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxWC2MACgkQAVBC80lX
0GwuIAgAk2onIopY2IFHDyz3J32pg835WL186IdxMJ/R8MhRXl1HI01AFQnCR5aw
RKpuDzlrlX/yBIHFPI3ZacaD38VgPfA7QGsR9smSUSF/WtGJBQXgAHVw4AxC+cMM
rKIZdh2O7UBU1ICLXTxLpeiV18N1nqR9Pmi1ZeUBBJGqNlc6/y2dVptg6YbPCbHH
hFEVLrCv4mwpWxBQArF0Mvtw/P/7AdnUnrAv/Bo21/WsVOd9623OBy2RzeFg/rFY
bnW7NqVeNCrFh5PUbtP6tH/WHBpJSEvxOL32tmjG/qYrPw46LL2h01P2meqAA0pM
EbXh5N1FKZEym5CpyBX8unIiNYWHrQ==
=6IJF
-----END PGP SIGNATURE-----

--Sig_/WQfnB1TBUNONhsJ5OCl6FnW--
