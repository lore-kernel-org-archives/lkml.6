Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E19C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BE3208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BE3208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbeG3TwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:52:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41675 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbeG3TwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:52:20 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4486080668; Mon, 30 Jul 2018 20:16:07 +0200 (CEST)
Date:   Mon, 30 Jul 2018 20:16:06 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180730181606.GB2416@amd>
References: <20180730143104.GB24051@amd>
 <20180729113749.GA7333@amd>
 <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
 <25489.1532953411@warthog.procyon.org.uk>
 <21165.1532964795@warthog.procyon.org.uk>
 <20180730173052.GA881@amd>
 <CA+55aFyzya1jiqXoWYtxzD+pRtg-oXXSs8z4ZS5gCKWAmmLrMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <CA+55aFyzya1jiqXoWYtxzD+pRtg-oXXSs8z4ZS5gCKWAmmLrMA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-07-30 10:54:19, Linus Torvalds wrote:
> On Mon, Jul 30, 2018 at 10:30 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Still userland needs a way to understand the errors.
>=20
> Not really.
>=20
> We don't internationalize kernel strings. We never have. Yes, some
> people tried to do some database of kernel messages for translation
> purposes, but I absolutely refused to make that part of the
> development process. It's a pain.
>=20
> For some GUI project, internationalization might be a big deal, and it
> might be "TheRule(tm)". For the kernel, not so much. We care about the
> technology, not the language.
>=20
> So we'll continue to give error numbers for "an error happened". And
> if/when people need more information about just what _triggered_ that
> error, they are as English-language strings. You can quote them and
> google them without having to understand them. That's just how things
> work.
>=20
> Let's face it, the mount options themselves are already (shortened)
> English language words. We talk about "mtime" and "create".
>=20
> There are places where localization is a good idea. The kernel is
> *not* one of those places.

Well, yes, we use english language words, and then we have
documentation explaining what those words mean. So it does not matter
if it is "mtime" or "auiasd", it is documented.

If we continue giving reasonable errnos, I guess that's fine. But I
believe man page should give list of errors that can happen, with
explanations, and it would be good to pass them in a way confusion
does not happen.

Yes, dmesg is confusing, and there's no way to translate that. But
dmesg is kernel debugging, not normal administration. Userspace does
good job translating errors, and it would be good to keep that
capability.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltfVeYACgkQMOfwapXb+vLQzACdEETkN4m0l326TWgSxyiodYLS
C4gAoKTO7p0Sg0XlRiOAeZ2tgSAtOthE
=78Lk
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
