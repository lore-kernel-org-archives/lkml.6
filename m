Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeCDIZu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 03:25:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37832 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeCDIZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 03:25:49 -0500
Date: Sun, 4 Mar 2018 09:25:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Woody Suwalski <terraluna977@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Re: Hibernation on i386 failure...
Message-ID: <20180304082547.GA7931@amd>
References: <1cd7fdbb-3b3e-02b5-743b-2cc8c4d755b5@intel.com>
 <92900026-5110-bde7-fba2-89d545bca29a@gmail.com>
 <20180109223047.GA26431@amd>
 <cf0cf715-a8bb-9bc9-e308-223712498f31@gmail.com>
 <20180303210617.GA22392@amd>
 <f840d714-2a84-505f-35c4-3bf22c95e907@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <f840d714-2a84-505f-35c4-3bf22c95e907@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-03-03 19:03:48, Woody Suwalski wrote:
> Pavel Machek wrote:
> >Hi!
> >
> >>>On Tue 2018-01-09 16:54:51, Woody Suwalski wrote:
> >>>>Hey Pavel, so you have found that issue earlier... Do you have a patc=
h to
> >>>>try?
> >>>Did I? I do not remember clearly.
> >>>
> >>>Anyway, here are my hibernation-related patches... Absolutely no
> >>>guarantees.
> >>Pavel, here is my attempt to convert your patch to 4.15 git, it builds
> >>cleanly, and it does not work. If you have a moment to spare - could you
> >>check if it is a classic case "everything is good, just does not
> >>work"?
> >Sorry for the delay.
> >
> >I've tested today's linux-next, and hibernation works for me, no
> >patches needed.
> >
> >Best regards,
> >									Pavel
> My January tests have showed that hibernation does work if I turn off the
> CONFIG_RELOCATABLE option.
> So can you confirm that you have it enabled and it works again? I will try
> it on 4.16-rc4 tomorrow...

I was actually testing with linux-next:

commit 80253003d5da3b82d6bebfb755a04c24011e90e2
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Fri Mar 2 14:17:11 2018 +1100

    Add linux-next specific files for 20180302

# git clone
  git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  # git fetch linux-next
  # git fetch --tags linux-next
  git remote update
  # then: git checkout next-20170201

And yes, I do have CONFIG_RELOCATABLE on:

CONFIG_RELOCATABLE=3Dy
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=3Dy

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqbrYsACgkQMOfwapXb+vLjdQCfbD0238Do2rdvErow6Z13evGR
vMQAn38McV1+Qv+pdlccp4EgLUizh3eN
=IILT
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
