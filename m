Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BC3C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACA920645
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="J9DSFo7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACA920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeJEGks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 02:40:48 -0400
Received: from ozlabs.org ([203.11.71.1]:40739 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbeJEGks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 02:40:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42R8cz5b49z9s9m;
        Fri,  5 Oct 2018 09:44:51 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538696693;
        bh=ZibloiZdFc3/EhLgNQ5Lfm6pYUQ09F79UjX0+Xaq3SU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J9DSFo7JCDoNdK8RL+0O1/lY9WDxjqKvqGEDlMhIMIbWwpBMXoB2mhhhFZh02cV4g
         ktTfTlm7HwgJoXiuzmm28ifn8KxOFV9+xZLrKNp3qy6UDMkX33lLSWQwR+vRs0T2we
         RdNjQvCqwnf95V24wMg62/8TAdpbZ4v48aoVLAKk4g0Iy0CEQy1qVbjd8NU5y0OyX8
         3r1wE7Gk2qmaKMEtORVvBKAfMG5LXhXtGzAoF7EPUjb+0Ow+Dqsv80uowdEfdIVJ4E
         Q2hJczj+Jdj49FKatI6PLBG9XCAJ+T8B8J8/V4v+qbSFkQWsp+EQPYtFlTlhHtNIFQ
         JP/Ld55sb0juw==
Date:   Fri, 5 Oct 2018 09:44:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: Tree for Oct 4
Message-ID: <20181005094445.4d0b68bc@canb.auug.org.au>
In-Reply-To: <CAMuHMdXfhbFi8HYtqd6BeACyG64_eQvoiSQ7DMpyOmdXEXPymg@mail.gmail.com>
References: <20181004183449.36bcc93b@canb.auug.org.au>
        <20181004134644.GA9130@roeck-us.net>
        <CAMuHMdXfhbFi8HYtqd6BeACyG64_eQvoiSQ7DMpyOmdXEXPymg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1Ambw=BwbLYFipXzDTvp3qv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1Ambw=BwbLYFipXzDTvp3qv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Thu, 4 Oct 2018 16:21:42 +0200 Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
>
> On Thu, Oct 4, 2018 at 3:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > Time for a status report.
> >
> > Build results:
> >         total: 135 pass: 121 fail: 14
> > Failed builds:
> >         arm:allmodconfig
> >         i386:allyesconfig
> >         i386:allmodconfig
> >         m68k:defconfig
> >         m68k:allmodconfig
> >         m68k:sun3_defconfig
> >         mips:allmodconfig
> >         parisc:allmodconfig
> >         powerpc:ppc6xx_defconfig
> >         s390:defconfig
> >         s390:allmodconfig
> >         s390:allnoconfig
> >         sparc32:allmodconfig
> >         xtensa:allmodconfig =20
>=20
> Most (all?) 32-bit builds are broken due to commit 571ed1fd2390f74e
> ("SUNRPC: Replace krb5_seq_lock with a lockless scheme"), presumably fixed
> by Arnd's "SUNRPC: use cmpxchg64() in gss_seq_send64_fetch_and_inc"
> (https://lore.kernel.org/patchwork/patch/994909/).

I have added that patch to the nfs tree merge in linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/1Ambw=BwbLYFipXzDTvp3qv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu2pe0ACgkQAVBC80lX
0GxyPgf/SZTNxWSN/TKpHs8ENfnrb9JjTE3pX6NSKe/UqoLVQDrxx72+AXfbbI26
gIVL5oawVL9Z0IcQvxv5c2vjbjtiBgvo/kH+ZACYQYHP2C4SY7SNMJc7NtbAwHJE
0mpEOfwSA5KXoBRsBvvpFHFabLi4ysaq57ExOM9aYOUTmvVUYMseJuy21FDuQaoc
HBhSwvrU09kYY6Mwz6Msma6poa0bjVskRaqJO/TERrD1in3LSuHv1tK37PDZxcB2
DIuRbADCTPPxlbWq5/+HtBix4IpxPT3Tg0T7A0oEiXQE7vlMQUusdGvwTbqi5oS9
eVGbGNHm4bfw6n+5LofdrcLZSsHEQg==
=eg9t
-----END PGP SIGNATURE-----

--Sig_/1Ambw=BwbLYFipXzDTvp3qv--
