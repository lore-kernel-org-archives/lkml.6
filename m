Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA84C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CDE20870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CDE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbeGaVU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:20:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52283 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729699AbeGaVU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:20:59 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 18BBC806A8; Tue, 31 Jul 2018 21:39:07 +0200 (CEST)
Date:   Tue, 31 Jul 2018 21:39:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180731193905.GA28700@amd>
References: <20180730183847.GB5544@bombadil.infradead.org>
 <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com>
 <20180730194938.GA12962@bombadil.infradead.org>
 <20180730210209.GY21725@thunk.org>
 <20180730235849.GA19692@bombadil.infradead.org>
 <20180731005802.GB21725@thunk.org>
 <18974.1533031913@warthog.procyon.org.uk>
 <20180731113422.GA22939@amd>
 <20180731120752.GA23378@bombadil.infradead.org>
 <4951.1533042037@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <4951.1533042037@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-07-31 14:00:37, David Howells wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
>=20
> > Regexes do not work in presence of arbitrary strings in the
> > message. If we had a way to tell start / end of string inserted in the
> > message, yes, the problem would be solved.
>=20
> You could use quotes around arbitrary insertions, ie. you always do '%s'
> inside the kernel if %s doesn't correspond to a specific set of text
> constants.

Yes, that would work. Except for strings that can contain 's, for
example filenames. \0 could be used to terminate arbitrary
strings.. AFAICT this goes over file descriptors, so length is
available, and we could use \0 to terminate strings.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltgutgACgkQMOfwapXb+vIcQQCghSIJbE0vhoOHn0oKsG0JcaQ4
5GkAn3cX3Umd/qo7HZat0BsJNWEVvIQz
=6RYh
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
