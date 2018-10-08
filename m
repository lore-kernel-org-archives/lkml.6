Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B9EC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BEC2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tt/a4IDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BEC2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJHKyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:54:19 -0400
Received: from ozlabs.org ([203.11.71.1]:58035 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeJHKyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 06:54:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42T5pJ4jg9z9sB7;
        Mon,  8 Oct 2018 14:44:40 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538970280;
        bh=8hF1lZL+iZNIDkfHrqIH2fs7pshjTTygrrFcRy7WQ0E=;
        h=Date:From:To:Cc:Subject:From;
        b=tt/a4IDBlSvIlUi+ENH7T7PMdVs6VvtiiEOG4/EXvQuLH7jlUGebo2m6NOLctYRyJ
         QwlVsYJQSjm8CDH6+2XlCyvuG2t5s5hH5Wk20N3yGa76Q1Fp5tbVSjBUB+ZikHGcqs
         eUdfd4f83uIQhInShnT2wkwC3aj+gjrwV3j4tTt/7xh0Sa/tqY8ygA4em/6jmPpAWi
         Tl/cq2i8QOnE5mpD3tXYTppHTBGAbkEol3trDSSnyO1oZj8PLM5/8xdkQsPgFaa/fM
         sFOpkJXXve8mTHYlSGGaqWPf7LbH+OtUmTQkoIpUmIC1PRnNx9axsB7qVTFGfdTfvw
         wnoH9+0dLUcPw==
Date:   Mon, 8 Oct 2018 14:44:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: linux-next: manual merge of the drivers-x86 tree with the tip tree
Message-ID: <20181008144438.53e6fdbc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xWjeFjFzezcq6RJ_i3hsvmy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xWjeFjFzezcq6RJ_i3hsvmy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  drivers/platform/x86/intel_int0002_vgpio.c

between commit:

  f2c4db1bd807 ("x86/cpu: Sanitize FAM6_ATOM naming")

from the tip tree and commit:

  96402de65afc ("platform/x86: intel_int0002_vgpio: Enable the driver on Ba=
y Trail platforms")

from the drivers-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/platform/x86/intel_int0002_vgpio.c
index e89ad4964dc1,c958a628c375..000000000000
--- a/drivers/platform/x86/intel_int0002_vgpio.c
+++ b/drivers/platform/x86/intel_int0002_vgpio.c
@@@ -57,11 -54,7 +54,7 @@@
  #define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
 =20
  static const struct x86_cpu_id int0002_cpu_ids[] =3D {
- /*
-  * Limit ourselves to Cherry Trail for now, until testing shows we
-  * need to handle the INT0002 device on Baytrail too.
-  *	ICPU(INTEL_FAM6_ATOM_SILVERMONT),	 * Valleyview, Bay Trail *
-  */
 -	ICPU(INTEL_FAM6_ATOM_SILVERMONT1),	/* Valleyview, Bay Trail  */
++	ICPU(INTEL_FAM6_ATOM_SILVERMONT),	/* Valleyview, Bay Trail  */
  	ICPU(INTEL_FAM6_ATOM_AIRMONT),		/* Braswell, Cherry Trail */
  	{}
  };

--Sig_/xWjeFjFzezcq6RJ_i3hsvmy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu60qYACgkQAVBC80lX
0GwXTQf+KsBeoNmofEXdKDBsLT5FmLAcbGD1DDEHcCNpMhRLL9QeaTnqGgXr4Om/
s1/pZTcbuV7u6+YcDqWJAfw2WGdyhl7Dkm4/7cSkEN9vQUv6CCv5QDfnuMIRrA04
6x/q+1uhHES5cr5y9rWGfjFs/ettMJY301f3w2HP+2IzvF1lF0uTblpXB4iprcWF
HiIkxZ5TAxmCqXoSNSuMqViUfyu8wQ4S2AHOcCF8fbvMdbmdgMnuA9w6p9+kjWzC
do6jBqzYQ4UBn2qddMDuuAnh2mb8YsKbH/FbnlTcRz3GMxQHJdtD0ww1vydfHG8k
qmiPfpaXViQCqwVZqL3czT4XeVzbpA==
=TPBv
-----END PGP SIGNATURE-----

--Sig_/xWjeFjFzezcq6RJ_i3hsvmy--
