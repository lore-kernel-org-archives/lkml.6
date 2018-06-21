Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8777C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D79B21A70
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D79B21A70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754280AbeFUTOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:14:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39498 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754071AbeFUTOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:14:45 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E9FEC805A3; Thu, 21 Jun 2018 21:14:43 +0200 (CEST)
Date:   Thu, 21 Jun 2018 21:14:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Message-ID: <20180621191443.GB14623@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <20180621085332.GA21807@amd>
 <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-06-21 14:08:40, Rafael J. Wysocki wrote:
> On Thu, Jun 21, 2018 at 10:53 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> As security becomes more and more important, we add the in-kernel
> >> encryption support for hibernation.
> > ...
> >> There was a discussion on the mailing list on whether this key should
> >> be derived in kernel or in user space. And it turns out to be generati=
ng
> >> the key by user space is more acceptable[1]. So this patch set is divi=
ded
> >> into two parts:
> >> 1. The hibernation snapshot encryption in kernel space,
> >> 2. the key derivation implementation in user space.
> >
> > uswsusp was created so that this kind of stuff could be kept in
> > userspace. You get graphical progress bar (etc) too. As you already
> > have userspace component for key derivation, I see no advantages to
> > uswsusp.
> >
> > If you have some, please explain.
>=20
> Not having to transfer plain text kernel memory to user space is one
> IMO.

Well, AFAICT in this case userland has the key and encrypted data are
on disk. That does not seem to be improvement.

> Besides, the user space part of what you are calling uswsusp has not
> been actively maintained for years now and honestly I don't know how
> many users of it there are.

I'd assume distros want progress bars so they still use it?

Anyway, there's solution for encrypted hibernation. If Intel wants to
invent different solution for that, and put it into kernel, they
should explain what the advantages are, relative to existing solution.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsr+SMACgkQMOfwapXb+vKDngCfXJJv3RBXD2AhfIHRs03Y2uhR
osYAoJ6Irtf8oJPZDOtvLwfAcgsM1EMA
=yyF8
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
