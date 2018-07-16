Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82735ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FFB208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FFB208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388775AbeGPIR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:17:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60923 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbeGPIR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:17:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 13D4280558; Mon, 16 Jul 2018 09:51:48 +0200 (CEST)
Date:   Mon, 16 Jul 2018 09:51:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>, jroedel@suse.de
Subject: Re: [PATCH 00/39 v7] PTI support for x86-32
Message-ID: <20180716075148.GA10794@amd>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> here is version 7 of my patches to enable PTI on x86-32.
> Changes to the previous version are:
>=20
> 	* Rebased to v4.18-rc4
>=20
> 	* Introduced pti_finalize() which is called after
> 	  mark_readonly() and used to update the kernel
> 	  mappings in the user page-table after RO/NX
> 	  protections are in place.
>=20
> The patches need the vmalloc/ioremap fixes in tip/x86/mm to
> work correctly, because this enablement makes the issues
> fixed there more likely to happen.
>=20
> I did the load-testing again with 'perf top', the ldt_gdt
> self-test and a kernel-compile running in a loop again. The
> patches posted here were tested for 16 hours without any
> regression showing up. An earlier version of these patches
> based on v4.18-rc1 survived this test for over a week before
> I canceled the test. The test ran with enabled CR3 debugging
> added in the last patch of this series.

Would it make sense to merge the part of the series that was reviewed
without comments? It would get at least part of the series testing in
-next....

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltMTpQACgkQMOfwapXb+vLIKACbB/Q+v4hVGhChiR3UgMdV4XP4
GG0AoI3pzik+gBn6LveC+9+75BpALLw2
=CyC3
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
