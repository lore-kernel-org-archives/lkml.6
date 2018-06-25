Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B1CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B0225861
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B0225861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932936AbeFYLzD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:55:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38925 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932294AbeFYLzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:55:02 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 24A5D804F2; Mon, 25 Jun 2018 13:55:01 +0200 (CEST)
Date:   Mon, 25 Jun 2018 13:55:00 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Yu Chen <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Message-ID: <20180625115500.GC17001@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <20180621085332.GA21807@amd>
 <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com>
 <20180621191443.GB14623@amd>
 <20180622021410.GA30305@sandybridge-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <20180622021410.GA30305@sandybridge-desktop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-06-22 10:14:10, Yu Chen wrote:
> Hi,
> On Thu, Jun 21, 2018 at 09:14:43PM +0200, Pavel Machek wrote:
> > On Thu 2018-06-21 14:08:40, Rafael J. Wysocki wrote:
> > > On Thu, Jun 21, 2018 at 10:53 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > > > Hi!
> > > >
> > > >> As security becomes more and more important, we add the in-kernel
> > > >> encryption support for hibernation.
> > > > ...
> > > >> There was a discussion on the mailing list on whether this key sho=
uld
> > > >> be derived in kernel or in user space. And it turns out to be gene=
rating
> > > >> the key by user space is more acceptable[1]. So this patch set is =
divided
> > > >> into two parts:
> > > >> 1. The hibernation snapshot encryption in kernel space,
> > > >> 2. the key derivation implementation in user space.
> > > >
> > > > uswsusp was created so that this kind of stuff could be kept in
> > > > userspace. You get graphical progress bar (etc) too. As you already
> > > > have userspace component for key derivation, I see no advantages to
> > > > uswsusp.
> > > >
> > > > If you have some, please explain.
> > >=20
> > > Not having to transfer plain text kernel memory to user space is one
> > > IMO.
> >=20
> > Well, AFAICT in this case userland has the key and encrypted data are
> > on disk. That does not seem to be improvement.
> >=20
> uswsusp needs to read the snapshot from kernel first, while
> do encryption in kernel directly would reduce the IO. Besides,
> the kernel memory content is protect from been read from
> user space from first place, although finally they are
> encrypted on the disk.

If you believe you solution is faster, please benchmark it. I don't
believe it will be.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsw2BQACgkQMOfwapXb+vIZdQCbByX/k7dabVOX6HzJFQTjbxFF
IDwAnRVsqQDh29IQ2YA4+Yq4cmIimj01
=6hGn
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
