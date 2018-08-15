Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D86C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 04:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DC8216B7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 04:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bMjuyCv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DC8216B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeHOGym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 02:54:42 -0400
Received: from ozlabs.org ([203.11.71.1]:41045 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbeHOGym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 02:54:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qwnr58bFz9s9F;
        Wed, 15 Aug 2018 14:04:16 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534305856;
        bh=WmwhpgZIFk97VIRZwnO7xRGiddFi6txLpLZS96Jy9pE=;
        h=Date:From:To:Cc:Subject:From;
        b=bMjuyCv1a/IGdhaMz8Zsf8odeXkJ3mXyR31Rh1WM9/F5+rd9Pf/qM0XbboVK1pebA
         sOYZom/NsPBtlry0+PFUlzXNg6fDmsIKJzJq4kV8y4e7zGSzaAVxofsOwSLYvcU3sy
         ydPsaL9J9Db8g9oOYcRRhqjIsT3KpotlV6L+5nZjJXNQnhBW61t2P5UsPt6C7RYvb3
         mSN9QCuDIKBhrbNDfkz4QKq7stTpGYxIHboxbIDbfwKem6WLffxbc9PwblGZHU0FzE
         Dm+17kt/OCyHR+78H2ZygznH7nMyS4d07ByibiGD1BVFKmsBT0BOQ4iq7ySMrGY4cR
         dyjjBvChhP9MA==
Date:   Wed, 15 Aug 2018 14:04:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tobias Tefke <tobias.tefke@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: linux-next: manual merge of the ftrace tree with Linus' tree
Message-ID: <20180815140416.200fd873@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gVAgX7Kb+mYpBsve7JXvxyX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gVAgX7Kb+mYpBsve7JXvxyX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steven,

Today's linux-next merge of the ftrace tree got a conflict in:

  kernel/events/uprobes.c

between commit:

  788faab70d5a ("perf, tools: Use correct articles in comments")

from Linus' tree and commit:

  38e967ae1e60 ("Uprobes: Simplify uprobe_register() body")

from the ftrace tree.

I fixed it up (the latter moved the uprobe_unregister function - see
below) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/events/uprobes.c
index aed1ba569954,c0418ba52ba8..000000000000
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@@ -860,7 -856,28 +856,28 @@@ __uprobe_unregister(struct uprobe *upro
  }
 =20
  /*
-  * uprobe_register - register a probe
 - * uprobe_unregister - unregister a already registered probe.
++ * uprobe_unregister - unregister an already registered probe.
+  * @inode: the file in which the probe has to be removed.
+  * @offset: offset from the start of the file.
+  * @uc: identify which probe if multiple probes are colocated.
+  */
+ void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_=
consumer *uc)
+ {
+ 	struct uprobe *uprobe;
+=20
+ 	uprobe =3D find_uprobe(inode, offset);
+ 	if (WARN_ON(!uprobe))
+ 		return;
+=20
+ 	down_write(&uprobe->register_rwsem);
+ 	__uprobe_unregister(uprobe, uc);
+ 	up_write(&uprobe->register_rwsem);
+ 	put_uprobe(uprobe);
+ }
+ EXPORT_SYMBOL_GPL(uprobe_unregister);
+=20
+ /*
+  * __uprobe_register - register a probe
   * @inode: the file in which the probe has to be placed.
   * @offset: offset from the start of the file.
   * @uc: information on howto handle the probe..

--Sig_/gVAgX7Kb+mYpBsve7JXvxyX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzpkAACgkQAVBC80lX
0GxxRgf/Q7J755A4ifHF3e6c0oHwsvlSzs2wB+Sv8jTCeCq57rt2DF6kivlWbsm1
TS3O6MRrB1DGv25VMk6xg4/Wxg5c2qWMX/GZbCNrVFv9zyRcdr3jOocaDypDXNRN
OXk7MpvNUwIu/tZK90tOp4DvnL3yq4R3VFXAlCdqE2vQeIV7FxAa4IfcPqw6L2Ei
Sby0JZNe/E0V7hEKF8HEtgNfreiG97XxjOH/RD15HEHSkhWyVXuktbfFBupRA7Y0
vWvrD3zQ0WfxP8eKohDP1Q1XDoDSPotEW0yDrUcZqsnlPPZrBQTLYBMstHmRRiNr
GtqbKy59SaPPt1AMC2WzfT51BOoixg==
=RkdF
-----END PGP SIGNATURE-----

--Sig_/gVAgX7Kb+mYpBsve7JXvxyX--
