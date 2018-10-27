Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB8C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 07:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421502085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 07:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421502085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeJ0P5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 11:57:37 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:55626 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728206AbeJ0P5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 11:57:37 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 5E7F74B3C8;
        Sat, 27 Oct 2018 09:17:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id I41kJURv4Vlu; Sat, 27 Oct 2018 09:17:33 +0200 (CEST)
Date:   Sat, 27 Oct 2018 18:17:29 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Ed Maste <emaste@freebsd.org>
Cc:     David Drysdale <drysdale@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] namei: implement O_BENEATH-style AT_* flags
Message-ID: <20181027071729.xbnvfii6iwdwymrn@ryuk>
References: <20181009065300.11053-3-cyphar@cyphar.com>
 <20181027014114.GA52393@freebsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rqlehc5c4ca2xn3a"
Content-Disposition: inline
In-Reply-To: <20181027014114.GA52393@freebsd.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rqlehc5c4ca2xn3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-27, Ed Maste <emaste@freebsd.org> wrote:
> On Tue, 9 Oct 2018 at 02:53, Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > +#ifndef O_BENEATH
> > +#define O_BENEATH      00040000000 /* *Not* the same as capsicum's O_B=
ENEATH! */
> > +#endif
> [...]
> O_BENEATH originally came from the Capsicum Linux port, and inherited the
> restriction against ".." path components from years ago when the port was
> done.  In addition, FreeBSD did not originally implement O_BENEATH as the
> "beneath" behaviour is inherently provided once a process enters a
> capability mode sandbox.  However, Capsicum now allows ".." paths, and
> FreeBSD supports O_BENEATH separately from capability mode.  Absolute pat=
hs
> are not yet allowed with O_BENEATH but a change is in review to permit th=
em.

What is the proposed semantic of O_BENEATH with absolute paths -- I
believe you don't have an openat(2) on FreeBSD (but please feel free to
correct me)?

> Ideally I would like to see us have the same API; none of this work has y=
et
> shipped in a FreeBSD release and there is an opportunity for us to make
> changes to match the interface and errors Linux may adopt.

I'm going to send out a v4 "soon" but I would like to know what folks
think about having resolveat(2) (or similar) to separate the scoping O_*
flags and produce an O_PATH -- since unsupported O_* flags are ignored
by older kernels userspace will have to do some plenty of checking after
each path operation.

Personally, I believe this (along with AT_EMPTY_PATH for openat(2))
would help with some other O_PATH issues.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--rqlehc5c4ca2xn3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlvUEQkACgkQnhiqJn3b
jbQeHA/+Jg2+M95VA/odwUZX6NTOQ/uf9PbRMQlz5IX3Z0Z1HbVjZa6yg9mZtc7W
47nVNzpNPo/r0kwP2hCZB0VKhgqwj0vlcFSlWVnNjfg3RZa8D47C8sanDzXX/R+K
Nf9wZ0ISRGrZobMZOgdjC7Zh3Fj0ymA44MmILbDHvGopED0EpQu9hqxje8W1UjMg
wYbxh4wntPvr99yKRpu86wcO/JNruktBCtRcqKyaYV821kb1651aiHf4DVsKIiQA
SyZtAfwrg41uA8j/bqFGwLUn1Fy7LuTftiOUQRpPHVprUUEuvYu0yct0auHPQrLM
q88VJtLpOlSgit1nL0jmksYhLf4qTuU7xzj7XYvvKfjTCXpvIFZC4RdmpXXrUXSH
eJiAgHGOKFq48m4hxZF7jcpSyg4cIh/IGL4OEBoBieRL1r3V4sKX5pSQwWA7focO
H/8YDwPVkzReMQKvY8WcNgL5lCK/v8vu72qZaUR3zc+prS3+SavQc+CjM5fGWooF
gsRMfkzfKuReIl4rMsln0M/vXJ+cErPQZvwvLJr0FlqpvemlQpS37AaDrQb0dxEv
wzCu7+W5fQ9vyeB3CiTa/3/hzD5TK7/lNxUZOUnsI78y4DF/qWm1Skv+iLZQB0Wj
MljUox4YH6g9SD9SxtbLbmzi+9o7Mh05/oO7+DHbnd/6TIALJ88=
=ucUf
-----END PGP SIGNATURE-----

--rqlehc5c4ca2xn3a--
