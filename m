Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeBLP0d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:26:33 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43104 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbeBLP0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:26:31 -0500
Date: Mon, 12 Feb 2018 16:26:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] x86/cpu, x86/pti: Do not enable PTI on AMD processors
Message-ID: <20180212152630.GD13962@amd>
References: <20171227054354.20369.94587.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline
In-Reply-To: <20171227054354.20369.94587.stgit@tlendack-t1.amdoffice.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-12-26 23:43:54, Tom Lendacky wrote:
> AMD processors are not subject to the types of attacks that the kernel
> page table isolation feature protects against.  The AMD microarchitecture
> does not allow memory references, including speculative references, that
> access higher privileged data when running in a lesser privileged mode
> when that access would result in a page fault.
>=20
> Disable page table isolation by default on AMD processors by not setting
> the X86_BUG_CPU_INSECURE feature, which controls whether X86_FEATURE_PTI
> is set.

PTI was originally meant to protect KASLR from memory leaks, before
Spectre was public. I guess that's still valid use on AMD cpus?
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqBsiYACgkQMOfwapXb+vI0CgCfVrZd5vC5OX/hitH4ItrbOUMC
ZusAn0aXDXi+ymU4jXez0o+WoLC+1sJ4
=mMm8
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
