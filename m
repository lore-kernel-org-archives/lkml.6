Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473E4C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB0C20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB0C20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeJMCbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:31:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48704 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeJMCbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 22:31:12 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 81EC080A64; Fri, 12 Oct 2018 20:57:16 +0200 (CEST)
Date:   Fri, 12 Oct 2018 20:57:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>, arnd@arndb.de,
        akpm@linux-foundation.org, luto@kernel.org,
        dave.hansen@linux.intel.com, jroedel@suse.de,
        keescook@chromium.org, torvalds@linux-foundation.org,
        toshi.kani@hpe.com, Thomas Gleixner <tglx@linutronix.de>,
        sfr@canb.auug.org.au, kernel list <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Subject: Re: Avoid VLA in pgd_alloc kills boot on 32-bit machines was Re:
 -next20181010,1011 regression: thinkpad x60 (32 bit) dies during boot.
Message-ID: <20181012185715.GA16126@amd>
References: <20181010195920.GA13860@amd>
 <20181010200331.GA13975@amd>
 <20181011180328.GA6740@amd>
 <alpine.DEB.2.21.1810112208200.1457@nanos.tec.linutronix.de>
 <20181012102459.GA4469@amd>
 <20181012105254.GA114888@gmail.com>
 <20181012181011.GA9098@amd>
 <20181012181335.GG12328@zn.tnic>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20181012181335.GG12328@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-10-12 20:13:35, Borislav Petkov wrote:
> On Fri, Oct 12, 2018 at 08:10:11PM +0200, Pavel Machek wrote:
> > And the winner is...
> >=20
> > [1be3f247c2882a82279cbcf43717581ea943b692] x86/mm: Avoid VLA in
> > pgd_alloc()
>=20
> That should be fixed now:
>=20
> https://git.kernel.org/tip/184d47f0fd365108bd06ab26cdb3450b716269fd

Aha, ok.

-next20181012 indeed works.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvA7osACgkQMOfwapXb+vK7XgCggLlNsJz1djA9DA+d1t0dTaBU
6ZIAoKOM/j8VAC3XCfC94qjohdVojdFc
=MHSa
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
