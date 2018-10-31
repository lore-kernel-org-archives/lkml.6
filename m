Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD31DC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9433A20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9433A20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeJaLxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 07:53:10 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:11372 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbeJaLxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 07:53:10 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 459BA436E9;
        Wed, 31 Oct 2018 03:57:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id z6eZO1ogo3qa; Wed, 31 Oct 2018 03:57:02 +0100 (CET)
Date:   Wed, 31 Oct 2018 13:56:55 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@canonical.com>
Cc:     Daniel Colascione <dancol@google.com>, joel@joelfernandes.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
Message-ID: <20181031025655.yz7lfhswk7igb3ty@yavin>
References: <20181029221037.87724-1-dancol@google.com>
 <20181030050012.u43lcvydy6nom3ul@yavin>
 <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
 <20181030204501.jnbe7dyqui47hd2x@yavin>
 <20181030214243.GB32621@google.com>
 <20181030222339.ud4wfp75tidowuo4@yavin>
 <20181030223343.GB105735@joelaf.mtv.corp.google.com>
 <CAKOZueuBdY_b=CVk29pzn0NAt9sJtzr6yqx9Y00WCppCm1JFWQ@mail.gmail.com>
 <CAPP7u0VQqDvFr=-52+Tmv_K=vT730wG7w9VQqJggsXTPFvaUBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="naxofbleg4r3agoj"
Content-Disposition: inline
In-Reply-To: <CAPP7u0VQqDvFr=-52+Tmv_K=vT730wG7w9VQqJggsXTPFvaUBQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--naxofbleg4r3agoj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-31, Christian Brauner <christian.brauner@canonical.com> wrote:
> > I think Aleksa's larger point is that it's useful to treat processes
> > as other file-descriptor-named, poll-able, wait-able resources.
> > Consistency is important. A process is just another system resource,
> > and like any other system resource, you should be open to hold a file
> > descriptor to it and do things to that process via that file
> > descriptor. The precise form of this process-handle FD is up for
> > debate. The existing /proc/$PID directory FD is a good candidate for a
> > process handle FD, since it does almost all of what's needed. But
> > regardless of what form a process handle FD takes, we need it. I don't
> > see a case for continuing to treat processes in a non-unixy,
> > non-file-descriptor-based manner.
>=20
> That's what I'm proposing in the API for which I'm gathering feedback.
> I have presented parts of this in various discussions at LSS Europe last =
week
> and will be at LPC.
> We don't want to rush an API like this though. It was tried before in
> other forms
> and these proposals didn't make it.

:+1: on a well thought-out and generic proposal. As we've discussed
elsewhere, this is an issue that really would be great to (finally)
solve.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--naxofbleg4r3agoj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvZGfcACgkQSnvnv3De
m5/pag//SU3VinHvE9UyYs7Yc7Uozsd7tbDxL2rHD9aaFd7/FrjVnDIf0Bh1J0Pt
X13u3Po8laIKDaaEMeOuXlkCqfY9zDGKqQQ7FvMtvifaNyZP1jetTlICuQfLMmRf
QbcUvh9eAXgmBjp2Gk71bqtdeePhbytnaFLiOHhX9cwWKsKZh6K1Q0ma6l5bl9sH
ryvyBwkDFfgzbwQ3wF6pMfPyi7tdjJ75UMI7vRLyD19D6XPxTYQDN3IhUV2w5osY
dHH+24iP8LoyCl5+moqzoQJuJhQTtkr3z+6AI8tNQEhgkcg7bwHqMFhqX6WpMo8/
t14R7I3p2mMymzNo7K1H2Jty8vvT2FINP5vIA4fNWO+o7H+Ko8Tr1ZjcIzBs0n2q
VylDvz1q/ZAb4neX4Jl9lncD1Hd2PfeOVIJ5hOYk87L9zCpIV5ZsvkNRHuq7z6u0
C7g/5EZVDGkkhjimbJS/4HckSLsmmxXUynl6qiaelrKmIGPk1mzytzvtYvma6qfL
kpeh7mnA6rDytGeu1wditzBtIU/IYQcb1g97JiB1A2cbC9FP3jDVBHzLA9Drh7PH
2P41lwoBXmq0epe9OPy4r7z4CcqtC3qax+wm8HA4UsGrRuBBGGIMnPaEPqzOGz0s
Tt/+nGw5an50vOh8BHNRC78raC1dtSNtrfETGOKegqL8qVEef7o=
=gqx4
-----END PGP SIGNATURE-----

--naxofbleg4r3agoj--
