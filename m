Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F59AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD46B20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfANMCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:02:02 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37632 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfANMCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:02:01 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AC10A809E1; Mon, 14 Jan 2019 13:01:52 +0100 (CET)
Date:   Mon, 14 Jan 2019 13:01:57 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/speculation: Add document to describe Spectre and
 its mitigations
Message-ID: <20190114120157.GB21544@amd>
References: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
 <20181228103437.4c03c181@lwn.net>
 <aed62eaa-93b4-8dc5-1920-6a5547e349c8@linux.intel.com>
 <20190113231001.GB18710@amd>
 <nycvar.YFH.7.76.1901140012110.6626@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1901140012110.6626@cbobk.fhfr.pm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-01-14 00:12:59, Jiri Kosina wrote:
> On Mon, 14 Jan 2019, Pavel Machek wrote:
>=20
> > That one really is Intel-specific (not even all x86s are affectd). Same=
=20
> > for Meltdown.
>=20
> At least for Meltdown, your claim is simply not correct.

You are right, there may be few ARM chips affected by meltdown.

I don't know about any non-Intel affected by l1tf.

=2E..and its documentation is just plain wrong, explaining I'm protected
when I'm not...

commit f372cd79be31382ae6030a1f15638cc7fe9eeb9f
Author: Pavel <pavel@ucw.cz>
Date:   Thu Jan 3 00:48:40 2019 +0100

    Ok, I guess L1TF was a lot of fun, and there was not time for a good
    documentation.
   =20
    There's admin guide that is written as an advertisment, and
    unfortunately is slightly "inaccurate" at places (to the point of
    lying).
   =20
    Plus, I believe it should go to x86/ directory, as this is really
    Intel issue, and not anything ARM (or RISC-V) people need to know.
   =20
    Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/Documentation/admin-guide/l1tf.rst b/Documentation/admin-guide=
/l1tf.rst
index 9af9773..05c5422 100644
--- a/Documentation/admin-guide/l1tf.rst
+++ b/Documentation/admin-guide/l1tf.rst
@@ -1,10 +1,11 @@
 L1TF - L1 Terminal Fault
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-L1 Terminal Fault is a hardware vulnerability which allows unprivileged
-speculative access to data which is available in the Level 1 Data Cache
-when the page table entry controlling the virtual address, which is used
-for the access, has the Present bit cleared or other reserved bits set.
+L1 Terminal Fault is a hardware vulnerability on most recent Intel x86
+CPUs which allows unprivileged speculative access to data which is
+available in the Level 1 Data Cache when the page table entry
+controlling the virtual address, which is used for the access, has the
+Present bit cleared or other reserved bits set.
=20
 Affected processors
 -------------------
@@ -76,12 +77,14 @@ Attack scenarios
    deterministic and more practical.
=20
    The Linux kernel contains a mitigation for this attack vector, PTE
-   inversion, which is permanently enabled and has no performance
-   impact. The kernel ensures that the address bits of PTEs, which are not
-   marked present, never point to cacheable physical memory space.
-
-   A system with an up to date kernel is protected against attacks from
-   malicious user space applications.
+   inversion, which is permanently enabled and has no measurable
+   performance impact in most configurations. The kernel ensures that
+   the address bits of PTEs, which are not marked present, never point
+   to cacheable physical memory space. On x86-32, this physical memory
+   needs to be limited to 2GiB to make mitigation effective.
+
+   Mitigation is present in kernels v4.19 and newer, and in
+   recent -stable kernels.
=20
 2. Malicious guest in a virtual machine
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw8ejUACgkQMOfwapXb+vItRACfc4I0adToRnEhCUMN/qWFESte
+LIAoK2uSoHWtjfhFHH1+DFFU+n62s5D
=500e
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
