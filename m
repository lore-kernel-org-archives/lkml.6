Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276EAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 08:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11BD2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 08:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11BD2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeKRSwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 13:52:07 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:21620 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeKRSwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 13:52:07 -0500
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 72D8AA1107;
        Sun, 18 Nov 2018 09:32:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id 6UG0l63JLQtF; Sun, 18 Nov 2018 09:32:27 +0100 (CET)
Date:   Sun, 18 Nov 2018 19:32:20 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Kris Van Hees <kris.van.hees@oracle.com>
Cc:     Brendan Gregg <bgregg@netflix.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [RFC] DTrace based on eBPF and other tracing facilities
Message-ID: <20181118083220.vxwcy2oq6uln3wa2@yavin>
References: <201811160602.wAG62uAu005007@aserv0121.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c6jycfkzpz7gqluq"
Content-Disposition: inline
In-Reply-To: <201811160602.wAG62uAu005007@aserv0121.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c6jycfkzpz7gqluq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-15, Kris Van Hees <kris.van.hees@oracle.com> wrote:
> A lot of work has been done on various aspects of the tracing infrastruct=
ure
> in Linux in the past years and with the further development of BPF a quite
> powerful execution engine has become available as well.
>=20
> One of the difficulties we have experienced in furthering DTrace on Linux=
 is
> that we have to duplicate functionality already available in the kernel
> because that functionality is not easy to make use of.
>=20
> In the past year or so we have been working towards changing that.  There=
 is
> no point in having multiple projects reinvent the same wheel a couple of =
times
> over, especially when there are ways where everyone can benefit from actu=
ally
> cooperating.  Our current (lofty) goal is to rework the DTrace implementa=
tion=20
> that we currently have to make it more modular and less self-sufficient. =
 We
> are envisioning a future for DTrace where we can leverage its strengths i=
n the
> areas where it matters most (e.g. very efficient handling of large amount=
s of
> kernel probes, well defined and understood D language, user familiarity w=
ith
> existing providers, ...) while building on the existing tracing infrastru=
cture
> in Linux.  That also means that we can contribute better to existing piec=
es
> in the infrastructure and work together with other tracing projects to co=
ntinue
> to improve tracing on Linux.
>=20
> Ideally we would like to see an infrastructure where any tracers can atta=
ch
> actions to any kind of probe source, and have data generated according to=
 the
> actions the tracer associated with the probe source when a specific probe
> fires.  The execution of those actions would be done using BPF.
>=20
> We believe that this proposal would be a benefit to all because it allows=
 us
> to pool resources in the areas that really need it.  E.g. if we all depen=
d on
> BPF as execution engine we invariably work together to make it as solid a=
s can
> be.
>=20
> Obviously we cannot do this work on our own, and we cannot do it behind c=
losed
> doors.  We've created a github repository for the kernel with DTrace adde=
d in
> at:
>=20
>   https://github.com/ezannoni/dtrace-linux-kernel/tree/master
>=20
> We also have a branch there with the most recent BPF-based work:
>=20
>   https://github.com/ezannoni/dtrace-linux-kernel/tree/nix/bpf/4.19/helpe=
rs
>=20
> Since most (if not all) tracing tools have similar requirements for what =
may
> need to be done when a probe fires, we really want to join forces.

Have you taken a look at bpftrace[1]? It uses LLVM to compile to BPF
bytecode and has a DTrace-like syntax. Yes, it's a from-scratch
reimplementation, but as a user of tracing I don't really mind either
way (I think most people like DTrace because of how seamlessly all
aspects of probing work -- but I believe that most of this is a result
of the DTrace kernel infrastructure more than the user-space tooling).

I'm not entirely sure how USDT interacts with the current Linux tracing
tools, but it would be nice if USDT worked on Linux the same way it
worked on Solaris (though I will admit I haven't played with it much on
Linux, I'm sure the other tracing folks will be able to comment on this
far more than myself).

[1]: https://github.com/iovisor/bpftrace

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--c6jycfkzpz7gqluq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvxI5AACgkQSnvnv3De
m5+ahA//WC08iKxtTHnSkkG8/w4fKJs0hSsGX3I5/n403i8L8fIrls1KnDdy8WJh
mGkncHrSAkKqSI2JBR0r9B9tbKwSwpPBhQuxUOgYdI0i67nExc7QNU9sI7U1Peeb
GojEdkHrNAdSGwJlY30lUolPkjqfJAGM6mLPLCfLRhFOP3IV37c9V0xu4+38ou54
d18YLlSGDkJP88sbR6HXL+phOHFSZ1QnXxH+TUw2ggjN4uih2GBQopJHssub2v9l
IfkG5xrumXaTciNmr4N8bEhWYZF91ZjIje4douOZl3NGonnQS4BCkmzL1DTIvrcj
MgkWoXE3k5c2J6SvFyUY4KAUSossFEUqZvWbp3u+eLU88T+WKM5qPMUTgYRZXAqX
46QLDf/NpPoQEWvwhxvjT159PkkkVvAVEr+5tPE0zgwn428vXqrc4kXvyIauCIzc
hLF/AaS4bcYYD4H9SSyKRcUiHH0OM9stB6zNSS/72tuF4GbPNkdyyKR3Yk+blrWW
yXV6j+ocwuuCzHBF9i3vqZyQGL7S3xVyhyzhrq++hm4dHLp4LwX2QNPqOjn8TZYp
N36FvBf8UIUIrjIJZBW43ZC3qgiANDoh45rI6a+pf+f+Khs/8srnsQIalqUzL9HB
jPRCZuulzCEGc7YpZ/bOcZ/cev3SJtc01wf4iJWxGq2ASxNqUGA=
=Jgm+
-----END PGP SIGNATURE-----

--c6jycfkzpz7gqluq--
