Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C15FC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA4221528
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bS0yeOL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA4221528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbeHOK4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 06:56:35 -0400
Received: from ozlabs.org ([203.11.71.1]:58633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeHOK4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 06:56:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41r2832FcMz9sCD;
        Wed, 15 Aug 2018 18:05:23 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534320324;
        bh=tQEwSfavkEV8OvqjwfOwMwCYwALS8lnw3L6xhbuYABk=;
        h=Date:From:To:Cc:Subject:From;
        b=bS0yeOL8OBSblTxfKp2s3qBwmyLXEtZIPXpbiBt7yMjXG/Gt5KXzscb4TtZoH8us0
         hIznIGWsHuIRiWNDUasXLq4Z2Wo577s+HJA98SXEz7GQd/6ia5RSr21axArcZDAXo5
         HYQXO0ld2NzLbBhRubJ7uxaVKAWp+Csa7z0O6qis6ucvxXRKn1pH34FpwtQVO0bmdT
         xaF4RjRvXAqlUkJ1kQevA2GVCdWrXo26iREIne/c5d6rKo1FT6BuJOxH7pKbbB4tE4
         hQXn23wX45OmssH+cCYQTeelyTlfidQNmVqzSciYPlA/p0c/nKf0JRUQxzNwRx/uVy
         MoTWKf2Wc/qow==
Date:   Wed, 15 Aug 2018 18:05:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.cz>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: linux-next: manual merge of the akpm-current tree with Linus' tree
Message-ID: <20180815180504.2f75cc0b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/V6l_PWApLFt+jGRElQiFFrX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V6l_PWApLFt+jGRElQiFFrX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  include/asm-generic/pgtable.h

between commits:

  42e4089c7890 ("x86/speculation/l1tf: Disallow non privileged high MMIO PR=
OT_NONE mappings")
  6c26fcd2abfe ("x86/speculation/l1tf: Unbreak !__HAVE_ARCH_PFN_MODIFY_ALLO=
WED architectures")

from Linus' tree and commit:

  c235da45bb89 ("mm: provide a fallback for PAGE_KERNEL_RO for architecture=
s")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/asm-generic/pgtable.h
index a75cb371cd19,81371468ed5a..000000000000
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@@ -1083,18 -1083,24 +1083,36 @@@ int phys_mem_access_prot_allowed(struc
  static inline void init_espfix_bsp(void) { }
  #endif
 =20
 +#ifndef __HAVE_ARCH_PFN_MODIFY_ALLOWED
 +static inline bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
 +{
 +	return true;
 +}
 +
 +static inline bool arch_has_pfn_modify_check(void)
 +{
 +	return false;
 +}
 +#endif /* !_HAVE_ARCH_PFN_MODIFY_ALLOWED */
 +
+ /*
+  * Architecture PAGE_KERNEL_* fallbacks
+  *
+  * Some architectures don't define certain PAGE_KERNEL_* flags. This is e=
ither
+  * because they really don't support them, or the port needs to be update=
d to
+  * reflect the required functionality. Below are a set of relatively safe
+  * fallbacks, as best effort, which we can count on in lieu of the archit=
ectures
+  * not defining them on their own yet.
+  */
+=20
+ #ifndef PAGE_KERNEL_RO
+ # define PAGE_KERNEL_RO PAGE_KERNEL
+ #endif
+=20
+ #ifndef PAGE_KERNEL_EXEC
+ # define PAGE_KERNEL_EXEC PAGE_KERNEL
+ #endif
+=20
  #endif /* !__ASSEMBLY__ */
 =20
  #ifndef io_remap_pfn_range

--Sig_/V6l_PWApLFt+jGRElQiFFrX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltz3rAACgkQAVBC80lX
0GxebAf/fv95337K9Z39twbpgZFVA6OnPIo8GfyFgc3J+T8R2kTQASm3Kju28dPK
lyGGtkOnnMQwFADn2iI3Zb4j8ZHhnvQi1MiX6p2wCEEyAFqJhW+qwB76Xo0hPu1S
B8fJyO8TAmcdqVIqpPSHIPtXmMt39HSPx2SLgcVKW8Ecl8S0MCGWykk/RmcArx1O
7BOzOK4SJqTDOWvhyzyJADdXBBYzLYVdQXrU5e2GjqWpnFLGf1nuZGUaaDDTOPsy
tmWUqeNSOqt9MtPHuP4uHrK0SeWhE5TUL7ATWrZA/ipNiTinC5YL1jir1R2Tq6MO
jGkUNKvRYWWrycQjQgCxzugo8FDw5g==
=jCcJ
-----END PGP SIGNATURE-----

--Sig_/V6l_PWApLFt+jGRElQiFFrX--
