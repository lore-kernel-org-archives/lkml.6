Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64F6C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851702184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="txOdXm6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfAaEcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 23:32:02 -0500
Received: from ozlabs.org ([203.11.71.1]:55197 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfAaEcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 23:32:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qnPn2dQ0z9sBb;
        Thu, 31 Jan 2019 15:31:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548909119;
        bh=fK+l0ljpQf132G+Kr6LliMveeC2X4Wks95BPUMBqLB8=;
        h=Date:From:To:Cc:Subject:From;
        b=txOdXm6RQO9L9J4ySFLgYRAephwqV7aYwskW/3gYaw9J9B0vkpzEG28x26to/DuQm
         QmmQuWfq9v75uKxStytJUJ5/patJ/Wn7WAgnEM8RS7sMUE1sYZjpTGi91225zc1mhz
         1X7trKOjYK1XAzRnOolGXVBhKU2O1jYTAIj7WTF6BAXBtqiwPQuXkzOtr9HjMg8wFS
         ldRPraXmrsGM+cfvokVgukJgrk6NozvUjhcgHvhPsRFHO2veuxAEMMBD2qln/ipwnf
         Ad9Drw8MQypo2QiCTBSQEyc0d/ywk6F1789jQlW51gIrBzRjH/c/TbQRBu+Vog9j6O
         PlxpSUGUZ3aCA==
Date:   Thu, 31 Jan 2019 15:31:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: linux-next: manual merge of the akpm-current tree with the tip tree
Message-ID: <20190131153156.0a26ebda@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uV77eKg_jxRiBeGkLI2d+7k"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uV77eKg_jxRiBeGkLI2d+7k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  include/linux/sched.h

between commit:

  15917dc02841 ("sched: Remove stale PF_MUTEX_TESTER bit")

from the tip tree and commit:

  ca299cb98649 ("mm/cma: add PF flag to force non cma alloc")

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

diff --cc include/linux/sched.h
index bb68abafac29,1ef3995b7564..000000000000
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@@ -1409,6 -1423,8 +1423,7 @@@ extern struct pid *cad_pid
  #define PF_UMH			0x02000000	/* I'm an Usermodehelper process */
  #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle=
 with cpus_allowed */
  #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process polic=
y */
+ #define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have =
_GFP_MOVABLE cleared */
 -#define PF_MUTEX_TESTER		0x20000000	/* Thread belongs to the rt mutex tes=
ter */
  #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as fre=
ezable */
  #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_pro=
cesses() and should not be frozen */
 =20

--Sig_/uV77eKg_jxRiBeGkLI2d+7k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxSejwACgkQAVBC80lX
0GzOoAf+KDBwyeSs/d8iF/S41DQNfnvzywvMh8u5753oJcadOiYq1C6rTPok5Ifz
V6S6t0/BczKL0+uzTQhi1nrXvtp07zNq3qZ7+Nl0HVu7LDqoItlLnoURv7rB3YiD
LukcRQSHosFYCs3cgPp9368CXiQEQPjoa5sPbtzyOBl91jyeXA/tWS+2/QSW0UOG
Q1Hpqj6bRl2MZEJ2kflbx3bz+/sjFChG5Ok9uYJ/CJJrECzESNVkp7EtmatLbrCw
mf97z0wp9pEwHJyB1frquvreucWU8YryFg7SFmfiewRez59xzXeJ0cIygy9UXR78
5iKuynV256girUI2zqmjpCWvi3Obgw==
=kQ70
-----END PGP SIGNATURE-----

--Sig_/uV77eKg_jxRiBeGkLI2d+7k--
