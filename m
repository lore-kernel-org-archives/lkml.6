Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02690C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22FF208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22FF208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeGaLTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:19:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34107 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbeGaLTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:19:53 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7C7BA80687; Tue, 31 Jul 2018 11:40:22 +0200 (CEST)
Date:   Tue, 31 Jul 2018 11:40:21 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180731094021.GC9836@amd>
References: <25489.1532953411@warthog.procyon.org.uk>
 <20180730143104.GB24051@amd>
 <20180730180842.GA5544@bombadil.infradead.org>
 <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com>
 <20180730183847.GB5544@bombadil.infradead.org>
 <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com>
 <20180730194938.GA12962@bombadil.infradead.org>
 <20180730210209.GY21725@thunk.org>
 <20180730235849.GA19692@bombadil.infradead.org>
 <20180731005802.GB21725@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <20180731005802.GB21725@thunk.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-07-30 20:58:02, Theodore Y. Ts'o wrote:
> On Mon, Jul 30, 2018 at 04:58:49PM -0700, Matthew Wilcox wrote:
> >=20
> > Way to poison the well by calling it VMS-style error reporting!  As I
> > understand it though, VMS reported errors in English with an error code
> > that could be looked up in The Wall of documentation.  I'd see David's
> > proposal as closer to plan9-style error reporting.
>=20
> And I'm quite happy with David's proposal.  What I was trying to
> strongly argue against (and, yes, I was using some dirty pool when I
> called it VMS-style error reporting) was trying to do something more
> structured and more I18N friendly.
>=20
> > But I think it has been a real problem.  I mean, look at ext4.
> >=20
> >                 if (test_opt2(sb, EXPLICIT_DELALLOC)) {
> >                         ext4_msg(sb, KERN_ERR, "can't mount with "
> >                                  "both data=3Djournal and delalloc");
> >                         goto failed_mount;
> > ...
>=20
> ... and in practice it's not been a problem, because a *vanishingly*
> small number of users actually try to use the more advanced features
> of most file systems.  And those that do, can look at dmesg output,
> and they can darned will do it in English.
>=20
> Doing returning something like %FSEXT4-E-NODJNLDELALLOC followed by
> English text, so that people who don't know English can look up

If you want to argue against proposal, you should select best form of
that proposal, not worst form.

> %FSEXT4-E-NODJNLDELALLOC in The Wall of 3-ring binders of
> documentation is just silly.  And saying we should remove all English
> text and returning the text string %FSEXT4-E-NODJNLDELALLOC so that
> people don't speak English aren't "disadvantaged" is even sillier.

You should really read https://en.wikipedia.org/wiki/Straw_man,
"Steelmanning" section.

Proposal is "message %s foo %s\0param 1\0param2\0", only strings
allowed. That's simple enough, yet allows translations.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltgLoUACgkQMOfwapXb+vLgcgCfcYDB1gTIxH3dOeEzTN2F5w9F
5y8AnjLIbmz7itG6zJec46McaKfNB8UV
=0/fy
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
