Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60ACC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEDF20879
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfABXv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 18:51:56 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47877 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfABXv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 18:51:56 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 194A28076A; Thu,  3 Jan 2019 00:51:48 +0100 (CET)
Date:   Thu, 3 Jan 2019 00:51:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Thomas Gleixner <tglx@linutronix.de>, corbet@lwn.net
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        linux-doc@vger.kernel.org
Subject: [patch] Fix up l1ft documentation was Re: Taking a break - time to
 look back
Message-ID: <20190102235152.GA24163@amd>
References: <alpine.DEB.2.21.1812200022580.1651@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812200022580.1651@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The next round of speculation-related issues including the scary L1TF
> hardware bug was a way more "pleasant" experience to work on. While for
> obvious reasons the mitigation development happened behind closed doors in
> a smaller group of people, we were at least able to collaborate in a way
> which is somehow close to what we are used to.

Ok, I guess L1TF was a lot of fun, and there was not time for a good
documentation.

There's admin guide that is written as an advertisment, and
unfortunately is slightly "inaccurate" at places (to the point of
lying).

Plus, I believe it should go to x86/ directory, as this is really
Intel issue, and not anything ARM (or RISC-V) people need to
know. (But we already have some urls in printk messages that may need
fixing up..?)

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/Documentation/admin-guide/l1tf.rst b/Documentation/admin-guide=
/l1tf.rst
index b85dd80..05c5422 100644
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
+   inversion, which is permanently enabled and has no measurable
+   performance impact in most configurations. The kernel ensures that
+   the address bits of PTEs, which are not marked present, never point
+   to cacheable physical memory space. On x86-32, this physical memory
+   needs to be limited to 2GiB to make mitigation effective.
=20
-   A system with an up to date kernel is protected against attacks from
-   malicious user space applications.
+   Mitigation is present in kernels v4.19 and newer, and in
+   recent -stable kernels.
=20
 2. Malicious guest in a virtual machine
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -405,6 +408,9 @@ time with the option "l1tf=3D". The valid arguments for=
 this option are:
=20
   off		Disables hypervisor mitigations and doesn't emit any
 		warnings.
+		It also drops the swap size and available RAM limit restrictions
+		on both hypervisor and bare metal.
+
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 The default is 'flush'. For details about L1D flushing see :ref:`l1d_flush=
`.
@@ -576,7 +582,8 @@ Default mitigations
   The kernel default mitigations for vulnerable processors are:
=20
   - PTE inversion to protect against malicious user space. This is done
-    unconditionally and cannot be controlled.
+    unconditionally and cannot be controlled. The swap storage is limited
+    to ~16TB.
=20
   - L1D conditional flushing on VMENTER when EPT is enabled for
     a guest.




--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwtTpgACgkQMOfwapXb+vJ8fQCdHMi3YPJwrHWpdUjNLAOYoB8Z
1YMAoJzLEAcJKiMpg8+/1DNH5wceGAUQ
=wFSl
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
