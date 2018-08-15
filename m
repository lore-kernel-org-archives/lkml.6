Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B63C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4199C214ED
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hmjQQNog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4199C214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeHPCuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:50:07 -0400
Received: from ozlabs.org ([203.11.71.1]:54451 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbeHPCuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:50:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rRDN345vz9s0R;
        Thu, 16 Aug 2018 09:55:31 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534377334;
        bh=wZNpPFiZyYdh5lctdQs5RoKAQhnwH+dRs/afHtXNbaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hmjQQNoglDojzVb5wJPm5m7gqM18g9Cc78p7SD+Ffqf0qjVrxIe7FfVJWuE6zNKLP
         XV5OLijorHlzPQwTCI5DjykXqRCwhbvIMiKXJMtMyiOe5SOX/MxLqWMWSFdQKH22M9
         s2MLFBM6up6A8Z0Ns78+IhLqYrZ+vNVyEtRY1DXBScPuUd6fwU9aRR5/1+P+aiiaKd
         kPs8Y+awVmH9LL9lASgOH+RVAKq8IXWD5oRk2t64Q3l8ucVzZIFOqWdfsKThAgE3kY
         rXOVpRpaScU0WPMqcqEQvYryCb3R0YV8e9wm9yidRNxfcvZ7NtVwqUdJkZUdb4VHLY
         l7gj5v2wMW4pw==
Date:   Thu, 16 Aug 2018 09:55:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 kbuild tree
Message-ID: <20180816095530.5b3c9ecb@canb.auug.org.au>
In-Reply-To: <20180803183653.4d394bcf@canb.auug.org.au>
References: <20180803183653.4d394bcf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WhVJZ.73GqrZNRLQbxG=4.T"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WhVJZ.73GqrZNRLQbxG=4.T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 3 Aug 2018 18:36:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   lib/Kconfig.debug
>=20
> between commit:
>=20
>   06ec64b84c35 ("Kconfig: consolidate the "Kernel hacking" menu")
>=20
> from the kbuild tree and commit:
>=20
>   bbd89226bb66 ("fs/buffer.c: add debug print for __getblk_gfp() stall pr=
oblem")
>=20
> from the akpm-current tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc lib/Kconfig.debug
> index 46f755a60872,01ec99f1cf2e..000000000000
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@@ -1729,10 -1713,9 +1727,9 @@@ config KPROBES_SANITY_TES
>   	bool "Kprobes sanity tests"
>   	depends on DEBUG_KERNEL
>   	depends on KPROBES
> - 	default n
>   	help
>   	  This option provides for testing basic kprobes functionality on
>  -	  boot. A sample kprobe, jprobe and kretprobe are inserted and
>  +	  boot. Samples of kprobe and kretprobe are inserted and
>   	  verified for functionality.
>  =20
>   	  Say N if you are unsure.
> @@@ -1851,12 -1820,8 +1844,11 @@@ config TEST_HAS
>   	  This is intended to help people writing architecture-specific
>   	  optimized versions.  If unsure, say N.
>  =20
>  +config TEST_IDA
>  +	tristate "Perform selftest on IDA functions"
>  +
>   config TEST_PARMAN
>   	tristate "Perform selftest on priority array manager"
> - 	default n
>   	depends on PARMAN
>   	help
>   	  Enable this option to test priority array manager on boot
> @@@ -2062,6 -2018,8 +2045,12 @@@ config IO_STRICT_DEVME
>  =20
>   	  If in doubt, say Y.
>  =20
> + config DEBUG_AID_FOR_SYZBOT
> +        bool "Additional debug code for syzbot"
> +        default n
> +        help
> +          This option is intended for testing by syzbot.
> ++
>  +source "arch/$(SRCARCH)/Kconfig.debug"
>  +
>  +endmenu # Kernel hacking

This is now a conflict between Linus' tree and the akpm-current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/WhVJZ.73GqrZNRLQbxG=4.T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt0vXIACgkQAVBC80lX
0GxqSwgAmOSJNo/nYCfFHZbZr7ytCrplrCElefErP1QoQ3j+2Xc41Hs76EqbW+OL
bTB4zIphHd1B297WS0qjUpE/ZaBHESJl8+d8qDUn9/BrVfQSwGUtV49ZU6MlyhBD
8Lw2Ev597TwxDqw1w6Ay7BKDi9sfXfiIhO5POwr/a20cuTWXhnDLat3a4ZTYKmLg
XS9VQ/jwtAnCXu3VEjejg7NrU7aBOaVAvkRn2yErZ4jpLiLzQ0h5ZpItBrj5AiRf
l/ZVMt8G8ZlR1bC5V7ByMYV4j24NQzexX3EWniU9qSWVFzKwPHtmSMAm+Hfm7kkV
5vJrEGyApqDCWglIsxQGITZ6JZnNIg==
=qcvH
-----END PGP SIGNATURE-----

--Sig_/WhVJZ.73GqrZNRLQbxG=4.T--
