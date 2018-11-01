Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EB1C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBE820820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DhgXrzVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBE820820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbeKAMzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 08:55:18 -0400
Received: from ozlabs.org ([203.11.71.1]:39085 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbeKAMzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 08:55:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42lrt53d6gz9sPp;
        Thu,  1 Nov 2018 14:54:05 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541044446;
        bh=W3Pgfygs0tB9nGNZq3RmpICPjaT3AK2N9oD5Lxfboik=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DhgXrzVY86xxYRgw0JLSlIZCjO71K5oz1mdEOSy0PxFNuowHtPEbzLXqeKbw20JBs
         c3QFr+4+jy3J0eNcc7913CRD2Mcx2Y0YHA0L9aTQ/xgl05uyFsfCyJKfqu9nuaQirv
         hxOM4n+TemAkQdgGnWejwZzJ4B4dBWMpgkkN3lNJnyUiuWLg/NIpkEhTjkHQohS7XC
         Zc4jlWIPFLXALCGKjPwDHQb0lxhD0HI0juDyJZyYtx+yVQGPfu3PQ40+jN/I+fdMLL
         1VWLK8sDew3uQ+Y4wP+2KKxejE2d8xndNIQsdiB1rc4yuySznHq2BRQ0RVO7RGT+hA
         wDXhzugw8xHRw==
Date:   Thu, 1 Nov 2018 14:54:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, LKP <lkp@01.org>
Subject: Re: [LKP] b179f0826c BUG: kernel hang in boot stage
Message-ID: <20181101145404.396c0973@canb.auug.org.au>
In-Reply-To: <20181101011307.GW24195@shao2-debian>
References: <20181101011307.GW24195@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/i9A6T4lRLSjTyiH8kXZSqyR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i9A6T4lRLSjTyiH8kXZSqyR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 1 Nov 2018 09:13:07 +0800 kernel test robot <rong.a.chen@intel.com>=
 wrote:
>
> Greetings,
>=20
> 0day kernel testing robot got the below dmesg and the first bad commit is
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
>=20
> commit b179f0826c6a13563c5ce0554c6da6748a1fa699
> Author:     Stephen Rothwell <sfr@canb.auug.org.au>
> AuthorDate: Mon Oct 29 16:55:21 2018 +1100
> Commit:     Stephen Rothwell <sfr@canb.auug.org.au>
> CommitDate: Mon Oct 29 16:55:21 2018 +1100
>=20
>     Add linux-next specific files for 20181029
>    =20
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>=20
> a3bbfc79c4  Merge branch 'akpm/master'
> b179f0826c  Add linux-next specific files for 20181029
> +------------------------------------------------+------------+----------=
-----+
> |                                                | a3bbfc79c4 | next-2018=
1029 |
> +------------------------------------------------+------------+----------=
-----+
> | boot_successes                                 | 33         | 0        =
     |
> | boot_failures                                  | 2          | 30       =
     |
> | BUG:kernel_hang_in_boot_stage                  | 1          | 30       =
     |
> | IP-Config:Auto-configuration_of_network_failed | 1          |          =
     |
> +------------------------------------------------+------------+----------=
-----+

That is really hard to believe given that the commit above only adds
documentation to the tree :-)

$ git log --stat -1 next-20181029
commit b179f0826c6a13563c5ce0554c6da6748a1fa699 (tag: next-20181029)
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Mon Oct 29 16:55:21 2018 +1100

    Add linux-next specific files for 20181029
   =20
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

 Next/SHA1s            |   292 +
 Next/Trees            |   294 +
 Next/merge.log        | 14253 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 Next/quilt-import.log |     2 +
 localversion-next     |     1 +
 5 files changed, 14842 insertions(+)

--=20
Cheers,
Stephen Rothwell

--Sig_/i9A6T4lRLSjTyiH8kXZSqyR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvaeNwACgkQAVBC80lX
0GxOLggAnpk6HxvLIYKe/CZLw9/oOqmU/ixfyjjnScAZwP1353VTSaUClwtTQ7gs
2HiWBR+7IKqmjkFrzdrOMj999LvRdsmsp1Da5sr7fdSmc6xYBinCorwkwd3jR4RA
sMsmvTJSn1mgwbe7ENDqz8JMZ2wy2mift2D5BLqWSfS1OogInAqzZVU6EV1nuzXO
navO+D07GIXanphTw5ct3e/XLYU/IEMvDdge/ApJ9pClKOPO80kI+BLn2ngeZaeR
Ss5Exs9MJvFh4/0uzT+HVozJLNTlDBrfaxB53QvCQanfCTIh3Ax81isDBWuSI+Od
fadFxwSTiFPX3GMJ8yQQJhuSIkdsTQ==
=Wmy1
-----END PGP SIGNATURE-----

--Sig_/i9A6T4lRLSjTyiH8kXZSqyR--
