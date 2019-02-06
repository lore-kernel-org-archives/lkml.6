Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F84C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB0420821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfBFQQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:16:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42846 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfBFQQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:16:16 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 814FA80332; Wed,  6 Feb 2019 17:16:07 +0100 (CET)
Date:   Wed, 6 Feb 2019 17:16:13 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Pan, Harry" <harry.pan@intel.com>
Cc:     "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gs0622@gmail.com" <gs0622@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / suspend: measure the time of filesystem syncing
Message-ID: <20190206161612.GA7868@amd>
References: <20190203052007.27392-1-harry.pan@intel.com>
 <20190205212308.GA2816@amd>
 <fb17e68f94236b1dd02419ebe01c9f76f6fe2259.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <fb17e68f94236b1dd02419ebe01c9f76f6fe2259.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-02-06 15:08:18, Pan, Harry wrote:
> On Tue, 2019-02-05 at 22:23 +0100, Pavel Machek wrote:
> > On Sun 2019-02-03 13:20:07, Harry Pan wrote:
> > > This patch gives the reader an intuitive metric of the time cost by
> > > the kernel issuing a filesystem sync during suspend; although
> > > developer
> > > can guess by the timestamp of next log or enable the ftrace power
> > > event
> > > for manual calculation, this manner is easier to read and benefits
> > > the
> > > automatic script.
> >=20
> > Do we really need this functionality?
> >=20
> > As you explained, developers can already use next timestamp or
> > ftrace... and this is really not that interesting number.
>=20
> The backdrop is some stress test script of suspend/resume, like Chrome
> OS, is designed to program an expected RTC wake-alarm then issue
> suspend command, while in rare case (or buggy software), the filesystem
> sync could cost longer time in seconds, this consumes the alarm budget
> causes suspend aborting, it could be abstruse to production line
> developers to realize it is not a platform issue in terms of drivers
> suspending; given a such metric might make the communication easier,
> this is my intuition.

I'd rather educate other developers that this may happen. dmesg
timestamps should already make it easy to see.

And actually... if you do "time sync" in userspace just before
programing the RTC and suspending, this whole issue should go away.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxbCEwACgkQMOfwapXb+vIKhgCaAnD9fPajXqwIhVuWFT72fKjh
KdQAn3hBYS5jaOiUEw44mzte/TprnrEL
=fRxm
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
