Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5871BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 12:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B8A21773
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 12:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbeLYMIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 07:08:20 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:18600 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeLYMIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 07:08:19 -0500
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id D62924A16E;
        Tue, 25 Dec 2018 13:08:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id C9l0FC2a7MHe; Tue, 25 Dec 2018 13:08:13 +0100 (CET)
Date:   Tue, 25 Dec 2018 23:07:57 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Florian Weimer <fweimer@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
Message-ID: <20181225120757.37w37lmyhxo6kekl@yavin>
References: <746B7C49-CC7B-4040-A7EF-82491796D360@brauner.io>
 <20181202100304.labt63mzrlr5utdl@brauner.io>
 <8736rebl9s.fsf@oldenburg.str.redhat.com>
 <20181203180224.fkvw4kajtbvru2ku@brauner.io>
 <874lbtjvtd.fsf@oldenburg2.str.redhat.com>
 <CALCETrViXJ0gD34yVd8QpB-CSeKZzzncvkPHReycTiQin4r4WQ@mail.gmail.com>
 <87y392h4b7.fsf@oldenburg2.str.redhat.com>
 <C5E71146-DE79-4145-B54B-E161E7372D95@brauner.io>
 <CAJhGHyC=Zc=iG+iL+Ny8GsMd-5xypxdk4Et_1ZViMao5aXreCw@mail.gmail.com>
 <CAJhGHyAHKm0q4FtHBgbbfaB3g4oix76vJWgjqLYoaHvKCD3gvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q4jdymnvoez454lh"
Content-Disposition: inline
In-Reply-To: <CAJhGHyAHKm0q4FtHBgbbfaB3g4oix76vJWgjqLYoaHvKCD3gvA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q4jdymnvoez454lh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-12-25, Lai Jiangshan <jiangshanlai+lkml@gmail.com> wrote:
> On Tue, Dec 25, 2018 at 1:32 PM Lai Jiangshan
> <jiangshanlai+lkml@gmail.com> wrote:
> >
> > Is it possible to avoid adding any syscall?
> >
> > Since holding /proc/pid/reg_file can also hold the pid.
> > With this guarantee, /proc/pid/uuid (universally unique identifier ) ca=
n be
> > introduced to identify tasks, the kernel generates
> > a uuid for every task when created.
> >
> > save_pid_uuid_pair_for_later_kill(int pid) {
> >   /* save via /proc/$pid/uuid */
> >   /* don't need to keep any fd after save */
> > }
> >
> > safe_kill(pid, uuid, sig) {
> >     fd =3D open(/proc/$pid/uuid); /* also hold the pid until close() if
> > open() successes */
> >     if (open successes and read uuid from fd and if it equals to uuid)
> >         kill(pid, sig)
> >     close(fd)
> > }
> >
> > All things needed to be done is to implement /proc/pid/uuid. And if pid=
 can't
> > be recycled within 1 ticket, or the user can ensure it. The user can use
> > starttime(in /proc/pid/stat) instead.
> >
> > save_pid_starttime_pair_for_later_kill(int pid) {
> >   /* save via /proc/$pid/stat */
> >   /* don't need to keep any fd after save or keep it for 1 ticket at mo=
st */
> > }
> >
> > safe_kill(pid, starttime, sig) {
> >     fd =3D open(/proc/$pid/stat); /* also hold the pid until close() if
> > open() successes */
> >     if (open successes and read starttime from fd and if it equals to s=
tarttime)
> >         kill(pid, sig)
> >     close(fd)
> > }
> >
> > In this case, zero LOC is added in the kernel. All of it depends on
> > the guarantee that holding /proc/pid/reg_file also holds the pid,
> > one of which I haven't checked carefully either.
> >
>=20
> Oh, Sorry, I was wrong, the pid isn't reserved even when
> the fd is kept in the user space. And I'm sorry that I had
> replied to an "old" email thread.

Don't worry, this was a common point of confusion during this (and
sister) threads. All the fd ensures is that access through that fd will
give you -ESRCH if the process is gone (and if the PID is reused it will
still give you -ESRCH).


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--q4jdymnvoez454lh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlwiHZ0ACgkQSnvnv3De
m591UxAAsfeV1mki8pGjp8ePXOEqSApU/bV4+S6N+8Xt7yZIAdzAMspeaibxXJ3r
zSqflUgH/KeYH72gaRSseAk14R30jt9jjf/Q5P7aPuN97kZsf/0+j+il5wj2mTDa
vXnopUyCeQpbcTcM4YktBvgZC1ZjTj99Jhy94petxRfFtQOurW+wblx4MF/6+/y3
3rpf8TyFTez9FCV+LLvwNekIyLVlG8QeuWl1N14qgdyNE+NWOETZup2QxhKBsoDj
fxZmNKD1ChwzQaKQNm/zSGlh1Xkm9R/SnM2Nr3YWsxdbboyigeRceDv5HDqltz/9
AN0s12V7iGcg5n4s4hyj+wWQKW7VJHEvxZ0aVjD+zPeSCwM6w2oTH3QcV7oCz3gN
tj5i1hOnFrsC/HszxFsXdQAYgaidAmO5lPpULasoTonsTNNRSUOnMuUMZ3CnAowB
OxmWrAKubLCzI0k4SqMlaQtbHkeqB3nlUBgTEgOUfLaXUYW1xQYNgmlZvbT5OG1e
ytQc/5E+2PaSLTLp6S/2AuBm8a7JOm13DZ341p+pWVGLrN5/L19CSTrtpJfIzMqT
SUKC7nkRse557h96bZnc38t/G0u7Ec4QIdNYqqrIcUFelyoS0WkBWcdpwi+ZH5n6
V1jLxVD3OonKoPqcTSZOBDwaw9k0QVbk/exxn9GM41NJI9fc78k=
=3gq/
-----END PGP SIGNATURE-----

--q4jdymnvoez454lh--
