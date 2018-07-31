Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001B0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A6E20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A6E20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeGaOIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:08:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38938 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732000AbeGaOIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:08:09 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 70FBE8068C; Tue, 31 Jul 2018 14:28:02 +0200 (CEST)
Date:   Tue, 31 Jul 2018 14:28:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180731122801.GA14972@amd>
References: <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com>
 <20180730183847.GB5544@bombadil.infradead.org>
 <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com>
 <20180730194938.GA12962@bombadil.infradead.org>
 <20180730210209.GY21725@thunk.org>
 <20180730235849.GA19692@bombadil.infradead.org>
 <20180731005802.GB21725@thunk.org>
 <18974.1533031913@warthog.procyon.org.uk>
 <20180731113422.GA22939@amd>
 <20180731120752.GA23378@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20180731120752.GA23378@bombadil.infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-07-31 05:07:52, Matthew Wilcox wrote:
> On Tue, Jul 31, 2018 at 01:34:22PM +0200, Pavel Machek wrote:
> > On Tue 2018-07-31 11:11:53, David Howells wrote:
> > > Pavel Machek <pavel@ucw.cz> wrote:
> > > > Proposal is "message %s foo %s\0param 1\0param2\0", only strings
> > > > allowed.
> > >=20
> > > I think that's too strict and you will need to allow integer values, =
IP
> > > addresses and possibly other things also.  It could certainly have a =
limited
> > > set (e.g. no kernel pointers).
> >=20
> > I'd always use strings at kernel->user interface. Yes, we should
> > support integers and IP addresses in kernel, but I'd convert them to
> > strings before passing them to userspace.
>=20
> Then you haven't solved the translation problem at all; you've just made
> the in-kernel implementation harder.  One example from the gettext docs:
>=20
>   In Polish we use e.g. plik (file) this way:
>=20
>     1 plik
>     2,3,4 pliki
>     5-21 plik=F3w
>     22-24 pliki
>     25-31 plik=F3w
>=20
> Your proposal means that userspace needs to detect "%s file", determine
> if the corresponding string consists of ^[0-9]*$, then parse the string
> to figure out which of the plik* words is the correct one to use.

Have you actually used computer set in slavic language? Receiving "5
soubor(u) zkopirovano" is still preferable to message in english.

> In my preferred solution of just sending the damned english string,
> it's no more complex to regex match the string for "[0-9]* file", and
> choose the appropriate plik* translation.

Regexes do not work in presence of arbitrary strings in the
message. If we had a way to tell start / end of string inserted in the
message, yes, the problem would be solved.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltgVdEACgkQMOfwapXb+vKmQQCfVXU6GDtXvZK7L3EqOME4lqZQ
h4IAn0fHutBDMGTB1mSw3+9wRrKTr6yc
=OJPq
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
