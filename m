Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571E7ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05245214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tx2ir1GR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05245214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeIQRVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:21:51 -0400
Received: from ozlabs.org ([203.11.71.1]:38423 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbeIQRVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:21:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42DPgT2hJcz9sj8;
        Mon, 17 Sep 2018 21:54:44 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537185287;
        bh=GGtqObIE6F0fsv/yDgGpF7AvNDynTVMrb+Jt2xFgFrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tx2ir1GR0Wq/d+o1RlZctouBxAVkCSMLs3t6U890UnG9LjJNoJ7MD3S91pUAUPiKf
         tp8JGeE9qlwBUYcKwpZABSsCTEOpyiPm9fmYlUXfFNR9xOea4MR/WIJIXkJ+lRUPQJ
         YIIaj1AE6f+G4lRvR8vtM9k/K3pHBaTOSzF5mpsj9lXEwLNbjAs4A+/5DGvvKlI0ih
         WWS1kdobhcevz6+LTUdsdIGoGLgmZmBMit+p5jdNcx2OuZeuTsUq8ShAXSxqk/Xskv
         eMZCcClMCGOUZmYxxr9aYfHTLgYl23hP5Dtdr3xbFT0OXez6Thh8qRAh0o4aOUSfio
         cE0CrGC0ZdK/g==
Date:   Mon, 17 Sep 2018 21:54:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        DTML <devicetree@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Peter Zijlstra <peterz@infradead.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Message-ID: <20180917215443.3b5808c5@canb.auug.org.au>
In-Reply-To: <b5bbb3e5-d970-dd82-400f-ae13ca782fd5@c-sky.com>
References: <cover.1536757532.git.ren_guo@c-sky.com>
        <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
        <b5bbb3e5-d970-dd82-400f-ae13ca782fd5@c-sky.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yEI4_c=IeDPHRljjUJxAYIO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yEI4_c=IeDPHRljjUJxAYIO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guo,

On Sun, 16 Sep 2018 12:53:26 +0800 Guo Ren <ren_guo@c-sky.com> wrote:
>
> I'm Guo Ren from C-SKY and I'm working on csky linux port upstream.
> I've prepared my git-tree based on linux-4.19-rc3:
> git clone -b linux-next https://github.com/c-sky/csky-linux.git
>=20
> Here is the pre-built cross compiler for fast test from our CI:
> https://gitlab.com/c-sky/buildroot/-/jobs/97941896/artifacts/file/output/=
images/csky_toolchain_csky_ck860_platform_defconfig_72371bf75a51f27ea59fc34=
eeaf236e06b75bf69.tar.xz
>=20
> You can also build newest gcc, binutils and they are upstreamed but not
> released on gnu.org. Glibc is uptreaming now.
>=20
> Please have a look and any feed back is welcome.

Added from today (called "csky").

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/yEI4_c=IeDPHRljjUJxAYIO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluflgMACgkQAVBC80lX
0Gy+0AgAi7LvoRN3SAZxDLH8U8IIVDVNkt7QObfeynIb1nTHO1dq3+SAHYC4+1p7
EcGP2c+4FVY8QX7Zdxx0aQqxvr4T2I7ej7A4LKFI20KQB0nXBip2u5kmwGYRUE/4
9y99/SyI6y8MXRURnM+bIB+qbXx1NJTTTgCR+UOVh4xSOmSIHiVpwoPpRHzsNevI
MN43Ntd3AZ6mwhjbLUBfIabtiDNkaQ3aLuPoheZqnhEF066w37oPwYhKgvwYGeQh
3wYwcVIvLm2xLJIJpy2jhHufjB1I5JG/r+kDzcuIey3/QHUUFKQmvCrexWE4bBZS
49URtExtPUzaBtVZ3ZZvz/x+u0JR/A==
=I9rI
-----END PGP SIGNATURE-----

--Sig_/yEI4_c=IeDPHRljjUJxAYIO--
