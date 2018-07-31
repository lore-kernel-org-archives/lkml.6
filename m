Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2213C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DA9208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DA9208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbeGaNOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:14:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37446 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbeGaNOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:14:19 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 08DCE80694; Tue, 31 Jul 2018 13:34:23 +0200 (CEST)
Date:   Tue, 31 Jul 2018 13:34:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180731113422.GA22939@amd>
References: <20180730143104.GB24051@amd>
 <20180730180842.GA5544@bombadil.infradead.org>
 <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com>
 <20180730183847.GB5544@bombadil.infradead.org>
 <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com>
 <20180730194938.GA12962@bombadil.infradead.org>
 <20180730210209.GY21725@thunk.org>
 <20180730235849.GA19692@bombadil.infradead.org>
 <20180731005802.GB21725@thunk.org>
 <18974.1533031913@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <18974.1533031913@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-07-31 11:11:53, David Howells wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
>=20
> > Proposal is "message %s foo %s\0param 1\0param2\0", only strings
> > allowed.
>=20
> I think that's too strict and you will need to allow integer values, IP
> addresses and possibly other things also.  It could certainly have a limi=
ted
> set (e.g. no kernel pointers).

I'd always use strings at kernel->user interface. Yes, we should
support integers and IP addresses in kernel, but I'd convert them to
strings before passing them to userspace.

> You also haven't proposed what you think the internal interface should lo=
ok
> like.

No, I did not.

> and then the kernel has to render the whole lot into=20
>=20
> Another example, in ext4 we have:
>=20
> 	printk(KERN_NOTICE "EXT4-fs (%s): last error at time %u: %.*s:%d",
>=20
> so we could do something like:
>=20
> 	infof(fc, "EXT4-fs (%s): last error at time %u: %.*s:%d", ...);
>=20
> on mount.  But the use of "%.*s" is a pain for your interface.  We can't =
pass
> qualifiers like "*" to userspace, so either the caller would have to copy=
 the
> string first or the logging routines would have to edit the format string.
> Though I suppose we could leave the editing to userspace.

I guess internal interface can stay the same, at expense of complexity
in infof function. It would data according to %blablax into string,
then replace %blablax with %s. I guess we can keep infof function
simpler by only allowing certain format specifiers...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltgST4ACgkQMOfwapXb+vIzUQCeKcj4yN5CrHq8n4t/qQ95ZXRr
7hgAn37+AHooUtvh4THq+lGOf2+uTxwt
=9TuI
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
