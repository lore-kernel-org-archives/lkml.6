Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B0EC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101B62089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tRgMLOFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101B62089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbeG0MQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:16:38 -0400
Received: from ozlabs.org ([203.11.71.1]:35699 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbeG0MQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:16:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41cQpm5CZfz9rxx;
        Fri, 27 Jul 2018 20:55:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532688913;
        bh=Ubnn77/sZOoOAAqvNdcj7tubXGe3XyWrojXu/inmsh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tRgMLOFXMktUwUJAz2k/jRYGcxh9s6Kxo/xYvjjUyDMjaaGQSeoZCtLjRbuf19HNg
         qXpvyPxjgAAFrHHSJcipilXCBYtNedpIioru4ArKRPUKeTWXOYY7YIfRANtF9cPZ9E
         udcobV91C4vkQkDI+msOUovhktmLtMpaYykbRUJuM6cQ8KyFToq5bF4wh2pMNtz6Fm
         B+eeA5JtOq2LdbHUPwsgXK8BYwMeec+VDWATE6Exqv/o7XCduHv7Lwn9XcE5GZgENd
         Vc6WnBZB+4WLkS7WlFRov8fUD5UDHxrKIS/OhcGP/bAhe1QUAXAyqfaEl3Sab20GWx
         K3UOOpV4dlmPg==
Date:   Fri, 27 Jul 2018 20:55:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@google.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20180727205511.7c0f2e62@canb.auug.org.au>
In-Reply-To: <20180727190647.3525f5f7@canb.auug.org.au>
References: <20180727190207.7ce1c9b0@canb.auug.org.au>
        <20180727190647.3525f5f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//MxW2J=yvZSzDuys=8bHiKQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//MxW2J=yvZSzDuys=8bHiKQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 27 Jul 2018 19:06:47 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Fri, 27 Jul 2018 19:02:07 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > After merging the kspp tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >=20
> > cc1: error: plugin stackleak_plugin should be specified before -fplugin=
-arg-stackleak_plugin-disable in the command line
> >=20
> > Maybe caused by commit
> >=20
> >   a8b9eaddb9c0 ("gcc-plugins: Add STACKLEAK plugin for tracking the ker=
nel stack")
> >=20
> > I have used the kspp tree from next-20180726 for today. =20
>=20
> Well, that obviously didn't work since the tree hasn't changed for a
> few days.
>=20
> I can't see what has interacted to make this happen, so I have dropped
> the kspp tree for today.

Actually, it may have been caused by commit

  0b3e336601b8 ("arm64: Add support for STACKLEAK gcc plugin")

from the arm64 tree.
--=20
Cheers,
Stephen Rothwell

--Sig_//MxW2J=yvZSzDuys=8bHiKQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlta+g8ACgkQAVBC80lX
0GyW5Af/Y2U/8zWYM6WuJoKtsZqilpTLFdQTb6qu1uonQZvNl7BrVSTLVsNx8Bqf
XCxyp7kpi8MU5PPcZIz9uzpZFlSyERGC8RLz+8lYF9eTTMwZ3tj1bv51GZiY7odK
6uuFelrtmzwbRzkvGJg5ixcVLL3RMRjW51Y8QnEgQTPKHuV3Db6LtjYrm5tY6HJb
HqI7aQqjrmiXU8SsMpYc/7uNJqmUEk8CoQb9mOULy5q935T7KKjx62+1GedlNhY5
1wGKxCmjPrzJoqi9Lu/z5DCvlwR2cjMxVehOHmA9O8f6PMP3RS2kWDab6demzBvo
slqxP9aY3hewkb8/Hn+2rFOhQazF5Q==
=G802
-----END PGP SIGNATURE-----

--Sig_//MxW2J=yvZSzDuys=8bHiKQ--
