Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F58C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EE7246AA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOPE5CqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EE7246AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755023AbeF0RjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbeF0RjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:39:15 -0400
Received: from localhost (unknown [5.29.173.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D895246AA;
        Wed, 27 Jun 2018 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530121155;
        bh=IPb96xCtoB74xokkG0VfPtlUCMgSX2xzikr1//2vOhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TOPE5CqWADbzA4Vq59wIimpws06WkAi86nr3COcVaJDkfmFe8ThHnIIGqktd4ebQz
         EPVVa9Qa2/LmDm2QatYsLLAmvFe1buDJs3h4dSM+q4EqosUCo/wHp/RLFPMhHrloP2
         e47e6SRZIvpljx+Pe43kSkTyQdeF0BJnvDG7Gj6I=
Date:   Wed, 27 Jun 2018 20:39:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Hadar Hen Zion <hadarh@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Michael J Ruhl <michael.j.ruhl@intel.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Raed Salem <raeds@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 08/12] overflow.h: Add arithmetic shift helper
Message-ID: <20180627173911.GS30877@mtr-leonro.mtl.com>
References: <20180624082353.16138-1-leon@kernel.org>
 <20180624082353.16138-9-leon@kernel.org>
 <CAKwiHFhgsyWYD+q+JFb2HJEphnjiiOp=o4Airv3MW031q2jx8w@mail.gmail.com>
 <20180625171157.GE5356@mellanox.com>
 <CAKwiHFiRYbyiJqDYCgKXKZYRr0KjCt8q9AwKwfqoCA1sT2KFyQ@mail.gmail.com>
 <20180626175435.GQ5356@mellanox.com>
 <CAKwiHFgchr+6HYOZ4e4e1vzL9cFabe6eonNNM8NTWZypazcuKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="L1c6L/cjZjI9d0Eq"
Content-Disposition: inline
In-Reply-To: <CAKwiHFgchr+6HYOZ4e4e1vzL9cFabe6eonNNM8NTWZypazcuKA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L1c6L/cjZjI9d0Eq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 27, 2018 at 11:36:03AM +0200, Rasmus Villemoes wrote:
> On 26 June 2018 at 19:54, Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> > On Tue, Jun 26, 2018 at 10:07:07AM +0200, Rasmus Villemoes wrote:
> > >    On 25 June 2018 at 19:11, Jason Gunthorpe <[1]jgg@mellanox.com>
> > wrote:
> > >
> >
> > When thinking about signed cases.. The explicit u64 cast, and
> > implict promotion to typeof(d), produce something counter intuitive,
> > eg:
> >
> >   (u64)(s32)-1 == 0xffffffffffffffff
> >
> > Which would result in a shift oucome that is not what anyone would
> > expect, IMHO... So the first version isn't what I'd expect either..
> >
>
> Wouldn't check_shift_overflow(-1, 4, &someint) just put -16 in someint and
> report no overflow? That's what I'd expect, if negative values are to be
> supported at all.

Most if not all the times we don't do shifts on negative values, so I
don't think that we should support them.

Thanks

--L1c6L/cjZjI9d0Eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbM8u/AAoJEORje4g2clink0cP/jiV+QHPOXCNak2/1uDE3ugE
f5JtCuus5clIWuNmzOKPrTuWIsaCRgqz7jwiyjUTRlbU0+c4JPQRaB27Rht2mzT1
YqVAVSUj3EW4Fxkxm5Fj38MRs+2z9DScpx+WxNkKeJ1+woqnaYerddCihRiaGM9l
dC0WlPbrDcT70DGHga2zIUKZd6COHcRbtZM5DgmsOtleVxM+4mTYsELwtgZFd1xT
NE0Uux83Xut0tnwolvnN3M6VsBSJuwY/rC/Mzyx7YXlNOzNCJxQx8YSORa7eD2Fb
Gn//gZvk4XQb45+dNrMNHELOd7z9TXmpddY6KZBgbo0PK5hexiKNfOyZb6fgLnlS
TmSa8qTj3EKMLaDTZXNqx3dkWnKv8PwGQ5F/19n4T+6/If7dRRrRZ/TgpFaDZQE7
yFVBQsY0t4HH105UYx4Pog1oMK8KvOWF8ZkAc5iuh0HfgZjfqDjzNtF8px1+ri0F
69tZ4tPkSF4imFB7n3f4RTA+dB/A/r0Z9FO0MIDxIteIj8x6MuEo+QnHNMdS4RG+
xphjQ3S4ZtZE9JlPdPzSRA02rbjvkK6KBNFm+QdQy0venKn1WajyN4qXGwEsfJGe
ISvTO5q1ck16wFLOW/A5l4BYXg07My3kEnf87PTYtkmD8TcjwkYKh01Lf15xhbEy
f3YosVgvAUwJV3KzBurG
=r7+A
-----END PGP SIGNATURE-----

--L1c6L/cjZjI9d0Eq--
