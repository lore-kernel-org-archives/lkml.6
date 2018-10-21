Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977C4ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 12:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1501620779
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 12:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1501620779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeJUUv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 16:51:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58128 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJUUv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 16:51:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 951E580905; Sun, 21 Oct 2018 14:37:44 +0200 (CEST)
Date:   Sun, 21 Oct 2018 14:37:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Joerg Roedel <jroedel@suse.de>, Meelis Roos <mroos@linux.ee>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 32-bit PTI with THP = userspace corruption
Message-ID: <20181021123745.GA26042@amd>
References: <alpine.LRH.2.21.1808301639570.15669@math.ut.ee>
 <20180830205527.dmemjwxfbwvkdzk2@suse.de>
 <alpine.LRH.2.21.1808310711380.17865@math.ut.ee>
 <20180831070722.wnulbbmillxkw7ke@suse.de>
 <alpine.DEB.2.21.1809081223450.1402@nanos.tec.linutronix.de>
 <20180911114927.gikd3uf3otxn2ekq@suse.de>
 <alpine.LRH.2.21.1809111454100.29433@math.ut.ee>
 <20180911121128.ikwptix6e4slvpt2@suse.de>
 <20180918140030.248afa21@alans-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20180918140030.248afa21@alans-desktop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-09-18 14:00:30, Alan Cox wrote:
> On Tue, 11 Sep 2018 14:12:22 +0200
> Joerg Roedel <jroedel@suse.de> wrote:
>=20
> > On Tue, Sep 11, 2018 at 02:58:10PM +0300, Meelis Roos wrote:
> > > The machines where I have PAE off are the ones that have less memory.=
=20
> > > PAE is off just for performance reasons, not lack of PAE. PAE should =
be=20
> > > present on all of my affected machines anyway and current distributio=
ns=20
> > > seem to mostly assume 686 and PAE anyway for 32-bit systems. =20
> >=20
> > Right, most distributions don't even provide a non-PAE kernel for their
> > users anymore.
> >=20
> > How big is the performance impact of using PAE over legacy paging?
>=20
> On what system. In the days of the original 36bit PAE Xeons it was around
> 10% when we measured it at Red Hat, but that was long ago and as you go
> newer it really ought to be vanishingly small.
>=20
> There are pretty much no machines that don't support PAE and are still
> even vaguely able to boot a modern Linux kernel. The oddity is the
> Pentium-M but most distros shipped a hack to use PAE on the Pentium M
> anyway as it seems to work fine.

I do have some AMD Geode here, in form of subnotebook. Definitely
newer then Pentium Ms, but no PAE...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvMcxkACgkQMOfwapXb+vJ6pgCgu3iDvOnkmr4HLzuB2U2AzpSE
uwgAoKVSZZZk13M9JhHUdFhHkzV6VtfE
=ssuM
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
