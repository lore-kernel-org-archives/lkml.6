Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25730ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 03:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71F621480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 03:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RBJemX2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71F621480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeIXJek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 05:34:40 -0400
Received: from ozlabs.org ([203.11.71.1]:57221 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeIXJek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 05:34:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42JVF65rYgz9sBZ;
        Mon, 24 Sep 2018 13:34:34 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537760077;
        bh=W7+BviYTfccXXRcqH0V3bj7qeoicl+0OZC4rdKbOah8=;
        h=Date:From:To:Cc:Subject:From;
        b=RBJemX2w9zdDABzfwYz27rFzpqp60sbTt7It5/wanL4qqB0ZnK4VnMah0iW6mn8Q8
         Hnbnyh+bi3fxac0Oag4InZiuKYx1YYjdweGlkeT8eF7Pg3xFP8y5CXs4lYARm3GTfw
         bnnUIf51mYYXyOUjMM1wDvapRGI58TdfdLqNBXJ3eEjGfH8sLc5Kj8EA1TDlYCciXw
         Q9iHfXzVEcIfSoavj7Bd+lvyWhfa1lkrTdwFBKx66Xjs24Z1cnn9iJQRw+RExM2Z45
         xiS5bzA/r9Xx8RShAKjYyPdBnajBNGvHspcXTnCk6HalOnU8LXUlY7qjcPyp0uPj2c
         XoXa28i0OORLw==
Date:   Mon, 24 Sep 2018 13:34:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: linux-next: manual merge of the userns tree with the tip tree
Message-ID: <20180924133434.3c04d891@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tlqE6TIcDKEcIt2vYqb6Zmx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tlqE6TIcDKEcIt2vYqb6Zmx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Today's linux-next merge of the userns tree got a conflict in:

  arch/x86/kernel/traps.c

between commits:

  76dee4a72849 ("x86/kprobes: Inline kprobe_exceptions_notify() into do_gen=
eral_protection()")
  81fd9c18444e ("x86/fault: Plumb error code and fault address through to f=
ault handlers")

from the tip tree and commits:

  6ace1098a68c ("signal/x86/traps: Factor out show_signal")
  79e21d654093 ("signal/x86/traps: Move more code into do_trap_no_signal so=
 it can be reused")

from the userns tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/kernel/traps.c
index 5bd0a997d81e,34a327f35976..000000000000
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@@ -202,11 -202,8 +202,8 @@@ do_trap_no_signal(struct task_struct *t
  						error_code, trapnr))
  				return 0;
  		}
- 		return -1;
- 	}
-=20
- 	if (!user_mode(regs)) {
+ 	} else if (!user_mode(regs)) {
 -		if (fixup_exception(regs, trapnr))
 +		if (fixup_exception(regs, trapnr, error_code, 0))
  			return 0;
 =20
  		tsk->thread.error_code =3D error_code;
@@@ -560,19 -540,9 +544,19 @@@ do_general_protection(struct pt_regs *r
 =20
  		tsk->thread.error_code =3D error_code;
  		tsk->thread.trap_nr =3D X86_TRAP_GP;
 +
 +		/*
 +		 * To be potentially processing a kprobe fault and to
 +		 * trust the result from kprobe_running(), we have to
 +		 * be non-preemptible.
 +		 */
 +		if (!preemptible() && kprobe_running() &&
 +		    kprobe_fault_handler(regs, X86_TRAP_GP))
 +			return;
 +
- 		if (notify_die(DIE_GPF, "general protection fault", regs, error_code,
+ 		if (notify_die(DIE_GPF, desc, regs, error_code,
  			       X86_TRAP_GP, SIGSEGV) !=3D NOTIFY_STOP)
- 			die("general protection fault", regs, error_code);
+ 			die(desc, regs, error_code);
  		return;
  	}
 =20

--Sig_/tlqE6TIcDKEcIt2vYqb6Zmx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluoW0oACgkQAVBC80lX
0GypKwgAkq1U6dsJv73sBq7FV8XRl9S3sUIORJZHVsTXTTR7iSpf5lRLXwb/d80/
MMKKSNwluJIYxwTbnGdJeU7CRhuTEtizT6JKo5c57CpFGMjUNnD8cCK+nzJ9Snkn
oTOeCo+gpbzkz0dr3WPgpt1dNyxnX1s1PZtHvKSZvD4cJ118SK97QoJaEANykTpj
Je1gx/TD0EOG/x4clNOlxsqFLXCob0diJk0LUiL9uaht8Cb8E2JZiDJd91eJxo09
+01s3gjssjaoSus6Z4XUFCCm/HDVbZ+Frb8V8U09LUb11TiiVMR95MSdQeOAg0RH
InJzr18k5FbJ2p3PmlFR0ZkgEnGD+g==
=nb7z
-----END PGP SIGNATURE-----

--Sig_/tlqE6TIcDKEcIt2vYqb6Zmx--
