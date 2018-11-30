Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85EBC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2B2213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2B2213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeK3NsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:48:12 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:45800 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbeK3NsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:48:11 -0500
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id B69F9446AA;
        Fri, 30 Nov 2018 03:40:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id VY1w_i9MfIrj; Fri, 30 Nov 2018 03:40:21 +0100 (CET)
Date:   Fri, 30 Nov 2018 13:40:10 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     christian@brauner.io, Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
Message-ID: <20181130024010.ikugzs3lqodrjvz2@yavin>
References: <20181120105124.14733-1-christian@brauner.io>
 <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net>
 <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
 <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
 <20181129195551.woe2bl3z3yaysqb6@brauner.io>
 <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
 <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
 <20181129213458.4h44dpg6ltqow4k4@brauner.io>
 <CAK8P3a1_if7+Ak2eefU6JeZT9KW827gkLHaObX-QOsHrB5ZwfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3kiedqe65sfjnl3g"
Content-Disposition: inline
In-Reply-To: <CAK8P3a1_if7+Ak2eefU6JeZT9KW827gkLHaObX-QOsHrB5ZwfA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3kiedqe65sfjnl3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-29, Arnd Bergmann <arnd@arndb.de> wrote:
> waitid() probably remains on my plate anyway, and I hope understand
> where we're at with it.

Having a way to wait on a processfd is something we'll eventually need,
though the semantics of zombies might get a little bit hairy. I propose
we work through that rewrite in a future series once this one goes in.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--3kiedqe65sfjnl3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlwAowoACgkQSnvnv3De
m582NA//fFDU2xF9A6ZovuFclronOEz3qdBj97uN+MSisMh+RjuoFFsQT25BB9zz
SNrbF0c/D+lYeoBQPdxvAHfYUQAkFZOnWVYn9eDXYtCjgcfBsKq4Q7nJ4szOqMph
a6dmw6vRZ0fIv11d8aCAkhMfA+CRSy4tmyZQjg2xhQ7Dw+6jY8wspplxDJwWwg5l
+o9NkoyV51Ca9wglbl6tlT6qQ/G2Cn1Vaj31Yt0fjbw+Pnx3LYmR42r8is5/HBSB
/gEl86WJjpvdT5pTMaqjb0+/r/0fQrpEdtOOIbE2APejwmZzJTUdAqAe7DZSPhP7
7u2yyo16paDWvk4WmAGLBYQYBICd71NwvJUxMiEg2T1p0EvUuhBVvaYH/+I0dLbw
3GRLXMzkTBumHk8n8WzlFpz/6yDwYI+E3eHvLDOjDoa5SMuvJ2ab6DnvTqlEfTVr
uNbEWIB3DWba+RJbqggu1hPWCa6PhVnck12lYE+oC24YJ4971JC1kNZbgL3Oc+Pw
3i386mmXtPCZOc3n6QFRQyI9bpBHXxiIoOmmcOkO6CIzv73vxoY8CU0q8weiQEuq
bgzBBPJiEAjv7mYnaKt1LEqCAsNdDtp5TvAY38qlT1UBy8cux9+6TDWlgJekffPH
JeuO05BHpwF2CotFGt33Az/vojbmXykmPvHHJ1+dXnOi5C9kBZo=
=RGMe
-----END PGP SIGNATURE-----

--3kiedqe65sfjnl3g--
