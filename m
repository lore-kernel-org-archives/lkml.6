Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB383C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680AA216FF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Vf/vDPjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680AA216FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeHHDXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 23:23:08 -0400
Received: from ozlabs.org ([203.11.71.1]:45119 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbeHHDXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 23:23:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41lY9H1PS0z9s5H;
        Wed,  8 Aug 2018 11:05:54 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533690360;
        bh=rkDm7wxrpt08ntI+rc2e+SlSu14sxFz764dCC+FAa3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vf/vDPjcFRQzgD4Mf1RyxmH3wHvkcE8qZXhK3/MPMueeeyW5KgGVOZEzLwCfpNM9c
         r0TcVBq+/upHqKLyF8bNFMLJZ5+vy1Q4AYkYndsgMrfRrUTSwK9lMKIQelMxoaEHul
         TOrgy+yl/Nog68FPCEJ/u2qsVoonEZfFMIXrBC6wwrUgnr+w4go1b4jyS/4+pAlPPa
         FbioeEBJ9/BynDkfF63Rw0w/Aw5qY6GTWtiWr/z0+HPeYz8q1PsFuWzeHfCxq68kQ/
         kHYKBc5TbVY7bMiTpKdDe0l9uDQnuyIJOs+mqv5A5sGe2XwNAuTrDsTNUdiM+nzJoF
         6PrA+lCDa+6tQ==
Date:   Wed, 8 Aug 2018 11:05:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, vdavydov.dev@gmail.com,
        mhocko@suse.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 01/10] rcu: Make CONFIG_SRCU unconditionally enabled
Message-ID: <20180808110542.6df3f48f@canb.auug.org.au>
In-Reply-To: <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
        <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IP8rFemfHJulIaL8/xLQERN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IP8rFemfHJulIaL8/xLQERN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kirill,

On Tue, 07 Aug 2018 18:37:36 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrot=
e:
>
> This patch kills all CONFIG_SRCU defines and
> the code under !CONFIG_SRCU.
>=20
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  drivers/base/core.c                                |   42 --------------=
------
>  include/linux/device.h                             |    2 -
>  include/linux/rcutiny.h                            |    4 --
>  include/linux/srcu.h                               |    5 --
>  kernel/notifier.c                                  |    3 -
>  kernel/rcu/Kconfig                                 |   12 +-----
>  kernel/rcu/tree.h                                  |    5 --
>  kernel/rcu/update.c                                |    4 --
>  .../selftests/rcutorture/doc/TREE_RCU-kconfig.txt  |    5 --
>  9 files changed, 3 insertions(+), 79 deletions(-)

You left quite a few "select SRCU" statements scattered across Kconfig
files:

$ git grep -l 'select SRCU' '*Kconfig*'
arch/arm/kvm/Kconfig
arch/arm64/kvm/Kconfig
arch/mips/kvm/Kconfig
arch/powerpc/kvm/Kconfig
arch/s390/kvm/Kconfig
arch/x86/Kconfig
arch/x86/kvm/Kconfig
block/Kconfig
drivers/clk/Kconfig
drivers/cpufreq/Kconfig
drivers/dax/Kconfig
drivers/devfreq/Kconfig
drivers/hwtracing/stm/Kconfig
drivers/md/Kconfig
drivers/net/Kconfig
drivers/opp/Kconfig
fs/btrfs/Kconfig
fs/notify/Kconfig
fs/quota/Kconfig
init/Kconfig
kernel/rcu/Kconfig
kernel/rcu/Kconfig.debug
mm/Kconfig
security/tomoyo/Kconfig

--=20
Cheers,
Stephen Rothwell

--Sig_/IP8rFemfHJulIaL8/xLQERN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltqQeYACgkQAVBC80lX
0GzCAggAjky/YInwyHf0hhdtGhlsTa7vvLGJcP+elKvroDO5mdb3+Fpb6n+Qa7GN
YCDuTYv5Y8ZMGvn9FDcjy/KK9gpWyp/mvWXQ8+a7ZVCd4SqFMjk7FMNOiI2jotw8
bL3d0blzZoJGI6HCWSvGhLIVkXGZUizd+dGfDABj7AyuMZTbcs65PyeqwbrBGeHj
STNVtyYKb7zHpNwt2JEOqHOKnenOdvpKLzZK6S39IYxXvIzmlIFr/QdZRTY4j3jZ
xZKIKLhOixM6giSj0A8pP0m/KAUEcRaSCGuQh8DbBWQOUIix/4oeuwIwZ0yyS5Wr
unjIxdFN3gUGCchbuvecCCVE/y1p5A==
=hXsZ
-----END PGP SIGNATURE-----

--Sig_/IP8rFemfHJulIaL8/xLQERN--
