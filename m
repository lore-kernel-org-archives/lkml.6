Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A45C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD94321871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfADJdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:33:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41946 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfADJdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:33:43 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7895080961; Fri,  4 Jan 2019 10:33:36 +0100 (CET)
Date:   Fri, 4 Jan 2019 10:33:40 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave P Martin <dave.martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/13] arm64: add basic pointer authentication support
Message-ID: <20190104093340.GA28150@amd>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-8-kristina.martsenko@arm.com>
 <20190103202901.GA21564@amd>
 <681a2835-1a70-f3c3-3534-7b4cf6139cac@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <681a2835-1a70-f3c3-3534-7b4cf6139cac@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-01-04 09:21:30, Marc Zyngier wrote:
> On 03/01/2019 20:29, Pavel Machek wrote:
> > On Fri 2018-12-07 18:39:25, Kristina Martsenko wrote:
> >> From: Mark Rutland <mark.rutland@arm.com>
> >>=20
> >> This patch adds basic support for pointer authentication,
> >> allowing userspace to make use of APIAKey, APIBKey, APDAKey,
> >> APDBKey, and APGAKey. The kernel maintains key values for each
> >> process (shared by all threads within), which are initialised to
> >> random values at exec()
> > time.
> >=20
> > ...
> >=20
> >> +/* + * We give each process its own keys, which are shared by
> >> all threads. The keys + * are inherited upon fork(), and
> >> reinitialised upon exec*(). + */ +struct ptrauth_keys { +	struct
> >> ptrauth_key apia; +	struct ptrauth_key apib; +	struct ptrauth_key
> >> apda; +	struct ptrauth_key apdb; +	struct ptrauth_key apga; +};
> >=20
> > intstruction_a, data_a, generic_a? Should be easier to understand
> > than "apdb" ...
>=20
> ... until you realize that these names do match the documentation,
> which makes it even easier to understand how the code uses the
> architecture.

See how not even the commit log matches the documentation then?

Naming something "apdb" is just bad... Just because the documentation
is evil does not mean it should be followed...

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwvKHQACgkQMOfwapXb+vId1ACfZu1/2mlOKgYdetcH5OjGU8y2
f8oAnjknOWchHLjiz4DjrU/M29jxFfKp
=vyqJ
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
