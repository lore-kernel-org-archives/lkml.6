Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71915C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAAB214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAAB214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbeLJX5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:57:54 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52033 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbeLJX5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:57:54 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 676DD80734; Tue, 11 Dec 2018 00:57:48 +0100 (CET)
Date:   Tue, 11 Dec 2018 00:57:51 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 0/4] Static calls
Message-ID: <20181210235751.GA22352@amd>
References: <cover.1543200841.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <cover.1543200841.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> These patches are related to two similar patch sets from Ard and Steve:
>=20
> - https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.=
org
> - https://lkml.kernel.org/r/20181006015110.653946300@goodmis.org
>=20
> The code is also heavily inspired by the jump label code, as some of the
> concepts are very similar.
>=20
> There are three separate implementations, depending on what the arch
> supports:
>=20
>   1) CONFIG_HAVE_STATIC_CALL_INLINE: patched call sites - requires
>      objtool and a small amount of arch code
>  =20
>   2) CONFIG_HAVE_STATIC_CALL_OUTLINE: patched trampolines - requires
>      a small amount of arch code
>  =20
>   3) If no arch support, fall back to regular function pointers

Well, it would be nice to mention what these patches do :-).

I guess they are expected to make things slightly faster? If so it
would be nice to mention benchmarks...

(There are even statistics later in the series, but I guess at least
short explanation should be in cover letter).

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwO/X8ACgkQMOfwapXb+vKKEgCgpPJ0EiKOdTFuOiCLM2bwftpC
4hwAoLKXVb4ZKI9JRx8NShJgH4MFuXT6
=JChk
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
