Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB02C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660E420890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660E420890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbeG3W7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:59:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46214 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeG3W7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:59:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B815D80624; Mon, 30 Jul 2018 23:23:00 +0200 (CEST)
Date:   Mon, 30 Jul 2018 23:23:00 +0200
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
Message-ID: <20180730212300.GA17452@amd>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
 <25489.1532953411@warthog.procyon.org.uk>
 <20180730143104.GB24051@amd>
 <20180730180842.GA5544@bombadil.infradead.org>
 <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com>
 <20180730183847.GB5544@bombadil.infradead.org>
 <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com>
 <20180730194938.GA12962@bombadil.infradead.org>
 <20180730210209.GY21725@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20180730210209.GY21725@thunk.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-07-30 17:02:09, Theodore Y. Ts'o wrote:
> On Mon, Jul 30, 2018 at 12:49:38PM -0700, Matthew Wilcox wrote:
> > > That said, people have wanted these kinds of extended error
> > > descriptors forever, and the reason we haven't added them is that it
> > > generally is more pain than it is necessarily worth. I'm not actually
> > > at all convinced that has magically changed with the mount
> > > configuration thing.
> >=20
> > I'm not convinced we want to do this either, but if there's anywhere we
> > do want to do it then mount seems like one of the few places it might be
> > worth doing.  The reasons that a mount failed are many, and it doesn't
> > seem like a good idea to introduce a new errno every time a network
> > filesystem finds a new failure mode.
>=20
> We've lived without VMS-style error reporting for a long time, and it
> *that* much of a real problem.  Even with network file systems, I

?

> So it might be that we're seriously over-thinking things.  Most of the
> really complicated error messages are at connection setup time, and
> that can be done in userspace, and then userspace can handle all of
> that awful gettext, or VMS-style error messages, or whatever other
> horrors the I18N community want to inflict on us.  :-)

Well, this is designing brand-new error reporting channel to the
userspace. I see that changing dmesg to provide something usable for
gettext would be hard, but it is quite trivial to do it right this
time.

I agree we survived without that for a long time, but we have chance
to do it right for a minimum price (because the interface is new we
don't need compatibility).

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltfgbQACgkQMOfwapXb+vIZnwCbBsE2Vih3Of6Jg+1lOejACDdA
ytQAnAm4RkdrUXN5HMaOR9L1WW58IJyS
=9eL7
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
