Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8848BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB9B208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB9B208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeLCSz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:55:58 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57452 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeLCSz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:55:58 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 39AC78091E; Mon,  3 Dec 2018 19:55:50 +0100 (CET)
Date:   Mon, 3 Dec 2018 19:55:53 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mhocko@kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, chanho.min@lge.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181203185553.GA29795@amd>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
 <20181203074700.GA21240@gmail.com>
 <20181203083942.GF31738@dhcp22.suse.cz>
 <20181203123149.GB31795@redhat.com>
 <20181203123857.GS31738@dhcp22.suse.cz>
 <20181203131006.GA10054@amd>
 <20181203135351.GU31738@dhcp22.suse.cz>
 <20181203141459.GA14789@amd>
 <20181203141737.GY31738@dhcp22.suse.cz>
 <CAHk-=wibyrfrpRoyGRwFrLZvrxAg=j5ueTje=4GckJcJSy-pwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <CAHk-=wibyrfrpRoyGRwFrLZvrxAg=j5ueTje=4GckJcJSy-pwg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-12-03 09:06:18, Linus Torvalds wrote:
> On Mon, Dec 3, 2018 at 6:17 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > This argument just doesn't make any sense. Rare bugs are maybe even more
> > annoying because you do not expect them to happen.
>=20
> Absolutely.
>=20
> And valid lockdep complaints are a real issue too.
>=20
> So I don't think there's any question that this should be reverted,
> the only question is whether I take the revert directly or get it from
> the PM tree.

I agree this to be reverted. (And the problem is bigger than lockdep,
and apparently not limited to suspend).

But we merged hacky solution because we wanted something simple for
stable, and I don't think that was good idea. (And I'm not sure this
is worth fixing in stable, as we don't have reports of people hitting
that in that kernels).

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwFfDgACgkQMOfwapXb+vL0jQCdG1E+E+qYM/sOGqUikmGTeB8Z
uUkAn0THxWd5rRA1qD3THwBuBHPcQoq6
=sfqZ
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
