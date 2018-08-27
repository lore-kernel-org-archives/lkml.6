Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65755C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA04A2174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="u6axR+SF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA04A2174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeH0FYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 01:24:03 -0400
Received: from ozlabs.org ([203.11.71.1]:48195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbeH0FYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 01:24:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41zF1L4x4jz9ryn;
        Mon, 27 Aug 2018 11:39:34 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535333975;
        bh=6F8HNx6Ix9Cc8iZKXaUREM2+RPt0+qPvxA9FxYqFSQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u6axR+SFME+EMyvB7QCUQGFAtvC7pzGtu2bbpwTAdRkBFOtm4cTcKeUn7BSMdDIp9
         rtIa7zTCWwRfJHIZYuvwBGRQoNqyriMK+ysXv3PxDSHw8QLJtRoiG2hvWqo599XhME
         68nZJaAwsuRFZo67xrfFvyqv/AFLO5PFpqSzwH0Ht1xtYg0mLKYN0nI2Zz5hmaAIgh
         /aofE2uBvO5gMGjtwtG0oMVgNa3rGaUPSGcZQyziOzKgDz/BgU/d7i5puql7dhLeHv
         HTL+4UjmDSmvvtkZqmGxC9ark4oLhziQ0YxczLKZrtddDlWPvfOI4EBLXjzSWJj8jF
         wj9EWWFX8xSkA==
Date:   Mon, 27 Aug 2018 11:39:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: stats (Was: Linux 4.19-rc1)
Message-ID: <20180827113933.742fab04@canb.auug.org.au>
In-Reply-To: <CA+55aFw9mxNPX6OtOp-aoUMdXSg=gBkQudGGamo__sh_ts_LdQ@mail.gmail.com>
References: <CA+55aFw9mxNPX6OtOp-aoUMdXSg=gBkQudGGamo__sh_ts_LdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6lZxDU6/jpVvYjRZVhsMaxf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6lZxDU6/jpVvYjRZVhsMaxf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20180813 was the first linux-next after
the merge window opened.)

Commits in v4.19-rc1 (relative to v4.18):          12317
Commits in next-20180813:                          11958
Commits with the same SHA1:                        10973
Commits with the same patch_id:                      526 (1)
Commits with the same subject line:                   64 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20180813:     11563 93%

Some breakdown of the list of extra commits (relative to next-20180813)
in -rc1:

Top ten first word of commit summary:

     81 x86
     70 perf
     52 net
     40 drm
     32 powerpc
     30 tools
     22 ib
     18 ubifs
     14 s390
     14 kvm

Top ten authors:

     37 jolsa@kernel.org
     26 tglx@linutronix.de
     24 tz.stoyanov@gmail.com
     21 acme@redhat.com
     19 arnd@arndb.de
     17 yamada.masahiro@socionext.com
     16 richard@nod.at
     16 jgg@ziepe.ca
     13 jhs@mojatatu.com
     10 saeedm@mellanox.com

Top ten commiters:

    100 acme@redhat.com
     81 tglx@linutronix.de
     80 davem@davemloft.net
     38 torvalds@linux-foundation.org
     37 mpe@ellerman.id.au
     29 jgg@ziepe.ca
     27 alexander.deucher@amd.com
     24 yamada.masahiro@socionext.com
     22 richard@nod.at
     22 rafael.j.wysocki@intel.com

There are also 395 commits in next-20180813 that didn't make it into
v4.19-rc1.

Top ten first word of commit summary:

     34 mm
     26 vfs
     22 arm
     21 coresight
     18 leaking_addresses
     17 xarray
     15 page
     12 btrfs
     12 arm64
     11 nfc

Top ten authors:

     76 willy@infradead.org
     37 dhowells@redhat.com
     25 akpm@linux-foundation.org
     22 suzuki.poulose@arm.com
     18 me@tobin.cc
     13 olof@lixom.net
     11 peda@axentia.se
      9 ktkhai@virtuozzo.com
      7 dsterba@suse.com
      7 cminyard@mvista.com

Some of Andrew's patches are fixes for other patches in his tree (and
have been merged into those).

Top ten commiters:

     90 sfr@canb.auug.org.au
     76 willy@infradead.org
     39 dhowells@redhat.com
     23 mathieu.poirier@linaro.org
     18 me@tobin.cc
     14 paulmck@linux.vnet.ibm.com
     14 olof@lixom.net
     14 cminyard@mvista.com
     13 wsa@the-dreams.de
     12 dsterba@suse.com

Those commits by me are from the quilt series (mainly Andrew's mmotm
tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/6lZxDU6/jpVvYjRZVhsMaxf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluDVlUACgkQAVBC80lX
0GzreAf/dzX+2h0e8wMNz4jt1dPi0y2t3XiSicM839RbajhwJQY746T8Og5ECpcg
e7SIgMi6soD5hdU3Su83iKBYwcpBAACKJX4yRefIwDF0U73eHbP8JA+HtX/GBlWu
zvbrEYdv2uc8WqXleJXRvcNEzsN5cvSEZFSNxQAROVFO8x/PotTYgcPQXRqHpT3v
StEJlqMhIO2WZTTChw4IlT9v+zulFR/YeUxEoLfY+UUFNbiY8YkOWeC+MFPug1Ul
DSZe2J4wYX+c4klB7FIjEo3r2qmf1mYs3VKwPMWaFudgRKNczsLY1tnN5oLwoO9B
vqOnF1NfB9/tDGQFMI36fkojFrQCBw==
=RaJx
-----END PGP SIGNATURE-----

--Sig_/6lZxDU6/jpVvYjRZVhsMaxf--
