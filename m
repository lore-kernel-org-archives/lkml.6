Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DB6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38444206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDhkIV9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbeLPVzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 16:55:32 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:42827 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730853AbeLPVzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 16:55:32 -0500
Received: by mail-pg1-f179.google.com with SMTP id d72so5119367pga.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 13:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OeljkH5n44UpHpi5rGk9vz/vj7CgCFuZEyH/d99Iasg=;
        b=EDhkIV9DWJS8TJg7dKIo7qHUpGoaYqvnRafVvsuSRAoPj7DBUWJi39+6PZ1wdVby1+
         +weqz/ZZcp8j7ZtZSo3rqFj0pZAkc9qGD4ogIcbZ00bECDpcO3BvgEltQ2agDofq3SiF
         Zy6qM/bKx3T58tFzF+cU8f440S1d7QoaEqlctiqxhiRN+K2Qm46iP9cElz2KTQDPsMNq
         4GMYDiY14dBa+fjezyvM4T7Pi3ky/45uZHO17UQjnUWmPz6CO4aUpdL2p2FOenuVhSKn
         cp6MEj6o1kjZS4X7Qt1ICnDnEq730jQEnq5f36KtLmUvLD9YSjKiSr8ODRc/tmuI2qns
         oUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OeljkH5n44UpHpi5rGk9vz/vj7CgCFuZEyH/d99Iasg=;
        b=IlvI3sMOBi2nfNd+fXVquW0A8NuyyE6wdZ1GfGGq7fZ69Ui61dR1mSMUom1qUVMe3U
         81ZNdE4Hs0/ZNZMqVcIn8sNLmCW43JcDJpeSxbSWeSlcjkV9OWOW87BbP9mhMdy18HAw
         gCbzMJf7tSHsoHXfUVs4AmH7mv1FNDQ8x2aVT/tiS3GOgA3RSEtac+M0MspJ4YIBuXvc
         rToqY2ds/mb8dYKuvyf68clAX9WIQs5oHn4rv6n7NjY1K6hZGpWkqYqr1IkZuAQoSfSI
         mKt2hdTnSbkQC+LWQOChoKC9jShJipdCZtzvFOVhvlZUMGQAZEQ8qpPGqBljD1yuIy86
         eJUg==
X-Gm-Message-State: AA+aEWZE31k8SGyPWSPzcUPkQwCbBYgoMUDzs3xlvo4KT2WQxOncGLwc
        f1EvwR6xFF5jjfSH4y2ob3A=
X-Google-Smtp-Source: AFSGD/Ut+r35SZMfX6toJLBLo9YFegMmjSx4X0MRV3EKIVKFCyI5esmzua+es6ObzN1j/bYQCYEGVg==
X-Received: by 2002:a63:8149:: with SMTP id t70mr10288161pgd.172.1544997331048;
        Sun, 16 Dec 2018 13:55:31 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id r6sm23563976pgk.91.2018.12.16.13.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 13:55:28 -0800 (PST)
Date:   Sun, 16 Dec 2018 11:55:26 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC] LKML Archive in Maildir Format
Message-ID: <20181216215526.kmbrv2srsgqlqde4@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181216190639.6safwjqwdphkce67@gmail.com>
 <c7865616af2eab80f5e5a4cf756ba430f2293499.camel@perches.com>
 <20181216192135.hc7gykmwkfgil2j5@gmail.com>
 <20181216195505.GB7732@pure.paranoia.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ue54b77hefxhqtbv"
Content-Disposition: inline
In-Reply-To: <20181216195505.GB7732@pure.paranoia.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ue54b77hefxhqtbv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 16, 2018 at 02:55:05PM -0500, Konstantin Ryabitsev wrote:
> On Sun, Dec 16, 2018 at 09:21:35AM -1000, Joey Pabalinas wrote:
> > That was my first attempt, but the ducumentation for the public-inbox
> > format is sort of terrible,=20
>=20
> I'm surprised you think so, because it's basically a simple file called
> "m" that is updated on each commit and contains the body of the
> message.
>=20
> > and after a few hours trying to convert it to Maildir I just gave up.
>=20
> It's as easy as something like this:
>=20
> for commit in $(git rev-list master); do:
>   git show $commit:m > maildir/new/$commit
> done
>=20
> You have to do it per each of the shards for the complete archive.

Ah dang, I was trying to use stuff like ssoma to split it, no wonder it
didn't work.  Not sure why I didn't think to try any git commands...

Well, at least now I know, ha. Thanks!

--=20
Cheers,
Joey Pabalinas

--ue54b77hefxhqtbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwWyc0ACgkQ2rGdfm9D
tVKueA/+MeJmr1KrzXu74xk63vZjaG/NnY+lCQ2Snc5qHgLWeNRenFvexTjtNh4q
BO9jFzjdhLi6u/TkZRj74C08Yey2fXGkJ21QhU8yTxkERFjGw0/XVpCTPdf31XEv
twEuSfd1eAMwsUtA2Cxitrxn4iLvyHRCLlOfdxG2vplOpyrKAl+JD+knzo2MFGVh
u0iJ8fdy3JWGuDVz+YUO6SkkiDu/3h7czfMq5Hb1xafAFUHwsoIqYm+utoF4o7GS
41CmGXlapNNcQdN6wJLEtnP5zsT+xgr8SKx3IfJ8jzNp3Zk7POPvoAYdKyWISMiA
zzjZNdZvcT5gq7x0q0xzKlXads6aOPx6hzEWMmOMEzgEL+S4ddColssFaNMLX7do
WqGlWhvp5a3FEfmPzZcvaYT9NoDgYpSJyJTOw8MKc6Tvl3f9wvMPYaL0aYnKbowU
f6QZ2sbkFG0EV1nkQVC+CD/NbLpTk049AR0QH1eU6iD2ymg3E6/OVxaZd+7tc94X
zKMUDStRM/1327/XoSj+Z7N8tKSTsUK7PQOfTAGL6c4KONRp1GU1t+Z1tkhfczxL
Xu/xzSJCkshAb678z6prYHnYwqbJ3RPBTvDHgSEhkqoKi+ZdN+mJOapmkcTl1i/V
vicPHDH0dmMn+f9t+kq6EJ5Zwyhw5DGKSEwOry1nhIx9LG7HPEc=
=b3Fj
-----END PGP SIGNATURE-----

--ue54b77hefxhqtbv--
