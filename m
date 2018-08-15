Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C477C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9E72154D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hsfr6HaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9E72154D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeHODBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 23:01:03 -0400
Received: from ozlabs.org ([203.11.71.1]:50297 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbeHODBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 23:01:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qqd53HCKz9s9N;
        Wed, 15 Aug 2018 10:11:21 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534291883;
        bh=j7eOPR16RVcNrkpd2enyGHJ3Rebz193rMONDWAurHyY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hsfr6HaWndCDRUnC6jYBAeZTs7oFQOdWJMM9RDWpVHpAQ6HnGChXw81W1S0TIArll
         mDr4v9aAeSeCo30jEAcy5AYbAWZvyLZlwY2MMIQexSV5dBhe/nNW8a73Syuk9/UcOX
         Nwt9bSkIqTUOxBT7r01PplwiY8NnwfRONcogIbyXZVkgNdUGXwreHv97PEtV2TVznc
         cof0WvnMDwBu3iAKLc83+vHgAG6kYmAshbJLw/4k4v1brNw71L/AVen3n4Ww0wayTm
         1hwCpJigFsPYh6ENWQUgYyLmIGzrye4sT7Dn0uzXkAj3uWO6rM/iun7YUOp9dk3FeE
         zRsbSNW9y4NaQ==
Date:   Wed, 15 Aug 2018 10:11:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        syzbot <syzbot+1f371ca19b341a276761@syzkaller.appspotmail.com>,
        jlayton@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: general protection fault in send_sigurg_to_task
Message-ID: <20180815101120.019f069e@canb.auug.org.au>
In-Reply-To: <CACT4Y+YujnbvrgRU6xc+=8rHLctrjQbRP+wq-08UmbH_oOfAKA@mail.gmail.com>
References: <0000000000007f59610573509684@google.com>
        <000000000000f4136d0573512103@google.com>
        <20180814191129.GN7906@fieldses.org>
        <CACT4Y+YujnbvrgRU6xc+=8rHLctrjQbRP+wq-08UmbH_oOfAKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/I8o_MI0gUdV6LA/b8SpCkwp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I8o_MI0gUdV6LA/b8SpCkwp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bruce,

On Tue, 14 Aug 2018 13:50:20 -0700 Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Aug 14, 2018 at 12:11 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
> > On Mon, Aug 13, 2018 at 06:33:02AM -0700, syzbot wrote: =20
> >> syzbot has found a reproducer for the following crash on:
> >>
> >> HEAD commit:    5ed5da74de9e Add linux-next specific files for 20180813
> >> git tree:       linux-next =20
> >
> > I fetched linux-next but don't have 5ed5da74de9e. =20
>=20
> +Stephen for the disappeared linux-next commit.

That is just the HEAD commit on linux-next that day.  If you fetched
linux-next after I released next-20180814 yesterday, then it would have
a different HEAD commit.  If you check out the tag next-20180813, you
will get the above HEAD commit.

> On the dashboard link you can see that it also happened on a more
> recent commit 4e8b38549b50459a22573d756dd1f4e1963c2a8d that I do see
> now in linux-next.

Which is just the HEAD commit of next-20180814.

Linux-next is rebuilt every day based on Linus' tree of the day,
followed by merging all the other branches, so its HEAD is different
every day.
--=20
Cheers,
Stephen Rothwell

--Sig_/I8o_MI0gUdV6LA/b8SpCkwp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzb6gACgkQAVBC80lX
0GwWkQgAkQotgz77Nk2wu/Zy8M2g8vT+tez8J0FYXe5IhrCyNKujLIpavlSb+HS5
gVzyxnswvPs89Bl95q7VhYGnTnu/+A4wWFV56QRlKgqSZRtClBkMX84UB92KQpaF
e5SPnf59xZzz3auIzgz5YAnq8jQ3xLSkCNH/8fUH1cnqPmp3nW0iQFNQvX7zgIP1
It5m4QJhm6b0BNM0WJ1ePPU0Kg2oBYRjYnH4JQBaVVi5RIHYJJEwgNEeIkH/NePB
NgoWiKEqo7Fw4LkxDeCpDR21/B12ZEbigLx1DnyZOTa3vTMnceoJ8DQbUEcOUjLh
r6/kTOgBaN71fXOfh+Aso/UbYUt8QA==
=iwCW
-----END PGP SIGNATURE-----

--Sig_/I8o_MI0gUdV6LA/b8SpCkwp--
