Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeCDOBv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 09:01:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46066 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeCDOBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 09:01:50 -0500
Date: Sun, 4 Mar 2018 15:01:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        r.marek@assembler.cz, ricardo.neri-calderon@linux.intel.com,
        rkrcmar@redhat.com, Janakarajan.Natarajan@amd.com, x86@kernel.org,
        hpa@zytor.com, mingo@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] clarify how insecure CPU is
Message-ID: <20180304140147.GA7276@amd>
References: <20180108201017.GA20588@amd>
 <alpine.DEB.2.20.1801082125530.2253@nanos>
 <20180108230355.GA25349@amd>
 <alpine.DEB.2.20.1801090043160.2253@nanos>
 <20180303210653.GB22392@amd>
 <alpine.DEB.2.21.1803040825130.1654@nanos.tec.linutronix.de>
 <20180304085159.GB7931@amd>
 <20180304092918.GA1142@pd.tnic>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20180304092918.GA1142@pd.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-03-04 10:29:18, Borislav Petkov wrote:
> On Sun, Mar 04, 2018 at 09:51:59AM +0100, Pavel Machek wrote:
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/=
cpufeatures.h
> > index f41079d..4901742 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -341,7 +341,7 @@
> >  #define X86_BUG_FDIV			X86_BUG(1) /* FPU FDIV */
> >  #define X86_BUG_COMA			X86_BUG(2) /* Cyrix 6x86 coma */
> >  #define X86_BUG_AMD_TLB_MMATCH		X86_BUG(3) /* "tlb_mmatch" AMD Erratum=
 383 */
> > -#define X86_BUG_AMD_APIC_C1E		X86_BUG(4) /* "apic_c1e" AMD Erratum 400=
 */
> > +#define X86_BUG_AMD_APIC_C1E		X86_BUG(4) /* System is affected AMD Err=
atum 400, special idle routine is needed */
> >  #define X86_BUG_11AP			X86_BUG(5) /* Bad local APIC aka 11AP */
> >  #define X86_BUG_FXSAVE_LEAK		X86_BUG(6) /* FXSAVE leaks FOP/FIP/FOP */
> >  #define X86_BUG_CLFLUSH_MONITOR		X86_BUG(7) /* AAI65, CLFLUSH required=
 before MONITOR */
> > @@ -356,7 +356,7 @@
> >  #define X86_BUG_NULL_SEG		X86_BUG(10) /* Nulling a selector preserves =
the base */
> >  #define X86_BUG_SWAPGS_FENCE		X86_BUG(11) /* SWAPGS without input dep =
on GS */
> >  #define X86_BUG_MONITOR			X86_BUG(12) /* IPI required to wake up remot=
e CPU */
> > -#define X86_BUG_AMD_E400		X86_BUG(13) /* CPU is among the affected by =
Erratum 400 */
> > +#define X86_BUG_AMD_E400		X86_BUG(13) /* System may be affected by Err=
atum 400, X86_BUG_AMD_APIC_C1E might be needed  */
>=20
> Not "might be needed" - "X86_BUG_AMD_APIC_C1E will be set if platform is
> affected".

That's not what Thomas was explaining to me.

> And then you don't need the above comment change. And you can't remove
> "apic_c1e" there because it is magical.

So.. what's magical about it, why do we need two bits, and why is that
not explained in the header file?

Please go through the email thread, I'm trying to understand what is
going on here, and no, the comments in the header are not helpful.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqb/EsACgkQMOfwapXb+vKrBgCghVOlGUtFxWg395JCOU63/U5N
1/UAnil3OxoJJCEcV/lsFtM5QZW2DHGO
=BURI
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
