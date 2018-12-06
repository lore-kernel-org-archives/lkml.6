Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98359C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAEE214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAEE214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbeLFI5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:57:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53087 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbeLFI5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:57:51 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0646980954; Thu,  6 Dec 2018 09:57:45 +0100 (CET)
Date:   Thu, 6 Dec 2018 09:57:49 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Chanho Min <chanho.min@lge.com>
Cc:     'Oleg Nesterov' <oleg@redhat.com>,
        'Ingo Molnar' <mingo@kernel.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Linux List Kernel Mailing' <linux-kernel@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Peter Zijlstra' <a.p.zijlstra@chello.nl>,
        'Michal Hocko' <mhocko@suse.com>, seungho1.park@lge.com
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181206085748.GA16059@amd>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
 <20181203074700.GA21240@gmail.com>
 <20181203115601.GA31795@redhat.com>
 <20181204091736.GD73770@gmail.com>
 <20181205143618.GA9535@redhat.com>
 <02a901d48d41$40aff110$c20fd330$@lge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <02a901d48d41$40aff110$c20fd330$@lge.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > On 12/04, Ingo Molnar wrote:
> > >
> > > * Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > > we really need to narrow the (huge) scope of ->cred_guard_mutex in =
exec
> > paths.
> > > >
> > > > my attempt to fix this was nacked, and nobody suggested a better so=
lution
> > so far.
> > >
> > > Any link to your patch and the NAK?
> >=20
> > See https://lore.kernel.org/lkml/20170213141452.GA30203@redhat.com/
> >=20
> > No questions, the patch wasn't pretty. And imo we need to rework the se=
curity
> > hooks in the long term.
> >=20
> > Oleg.
>=20
> I am sorry for the reverting this patch. It's also my fault that
> I didn't check lockdep. But, We decided to keep this patch in our product.
> Freeze fail is a real problem we've had for the last two years,
> whereas lockdep's notice is not a real problem.
> We hope this issue will be resolved soon.

I guess it makes sense for your usage.

How often do you see the failures without the patch?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwI5IwACgkQMOfwapXb+vI34ACfUjQmktkk1wmaboYyS9Ssyp01
59oAoKonaVCj77TWq7EjcO9vb0FrOurW
=O45J
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
