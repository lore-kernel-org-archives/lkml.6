Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA20C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A12D205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A12D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeHaAnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:43:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51818 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHaAnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:43:50 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8BD6380552; Thu, 30 Aug 2018 22:39:49 +0200 (CEST)
Date:   Thu, 30 Aug 2018 22:39:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v3 05/24] Documentation/x86: Add CET description
Message-ID: <20180830203948.GB1936@amd>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com>
 <20180830143904.3168-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20180830143904.3168-6-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 9871e649ffef..b090787188b4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2764,6 +2764,12 @@
>  			noexec=3Don: enable non-executable mappings (default)
>  			noexec=3Doff: disable non-executable mappings
> =20
> +	no_cet_ibt	[X86-64] Disable indirect branch tracking for user-mode
> +			applications
> +
> +	no_cet_shstk	[X86-64] Disable shadow stack support for user-mode
> +			applications

Hmm, not too consistent with "nosmap" below. Would it make sense to
have cet=3Don/off/ibt/shstk instead?

> +++ b/Documentation/x86/intel_cet.rst
> @@ -0,0 +1,252 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Control Flow Enforcement Technology (CET)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +[1] Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Control Flow Enforcement Technology (CET) provides protection against
> +return/jump-oriented programing (ROP) attacks.

Can you add something like "It attempts to protect process from
running arbitrary code even after attacker has control of its stack"
-- for people that don't know what ROP is, and perhaps link to
wikipedia explaining ROP or something...

> It can be implemented
> +to protect both the kernel and applications.  In the first phase,
> +only the user-mode protection is implemented for the 64-bit kernel.
> +Thirty-two bit applications are supported under the compatibility

32-bit (for consistency).

Ok, so CET stops execution of malicious code before architectural
effects are visible, correct? Does it prevent micro-architectural
effects of the malicious code? (cache content would be one example;
see Spectre).

> +[3] Application Enabling
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

"Enabling CET in applications" ?

> +Signal
> +------
> +
> +The main program and its signal handlers use the same SHSTK.  Because
> +the SHSTK stores only return addresses, we can estimate a large
> +enough SHSTK to cover the condition that both the program stack and
> +the sigaltstack run out.

English? Is it estimate or is it large enough? "a large" -- "a" should
be deleted AFAICT.
=20
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluIVhQACgkQMOfwapXb+vJ0KACgu6nabChmCkBFO6OaHfHWveVH
9MgAn36uXjrnPChLkXN2JkbfiY+qF9bI
=mbZW
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
