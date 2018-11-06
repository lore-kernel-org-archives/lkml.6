Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F59C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0A72083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lKLmNrBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0A72083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeKFKFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:05:48 -0500
Received: from ozlabs.org ([203.11.71.1]:37707 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbeKFKFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:05:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42prPf03ytz9sDr;
        Tue,  6 Nov 2018 11:43:17 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541464999;
        bh=dH48KkodZ+amPzcp+G+g03bWiKhZdzml1ZEIbtSJj1o=;
        h=Date:From:To:Cc:Subject:From;
        b=lKLmNrBcaNc0mivqybYjruMHCKlBvfvgwZUJgTTYDw38YxwgMR/+WisKviOG5daH8
         X0YDYcXG9pySkqfCukFkwFjVJyHvua6i/CVJivaS/8FCDqPQNc3wzj9TfA2WyXCMnt
         oD6V92QWaswhcdL5rp+y7pUdUHIbXzWuZ5FK6aYEk+gUbibxVrYNxuJeHSWG59qvUB
         IusqDb461Whslzq9GNvg1Ao0n5aKhuwnG++2/EYMPG3X75PB/TRuDvoX0IXukIQdWm
         mbuLbLcZ6tT4hZUDg/PRziiexziG1QtjDwM/QN4xdofCdNSPw7cjFfoFA/VbY8v1Sg
         EcZOaj8377OEQ==
Date:   Tue, 6 Nov 2018 11:43:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20181106114317.1fbce2bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/V2udws/wg9FA4M=zy2WB=Tv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V2udws/wg9FA4M=zy2WB=Tv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

/bin/bash: scripts/atomic/check-atomics.sh: No such file or directory

Caused by commit

  8d32588077bd ("locking/atomics: Check generated headers are up-to-date")

I build with O=3D

I have appplied the following fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 6 Nov 2018 11:37:10 +1100
Subject: [PATCH] fix for "locking/atomics: Check generated headers are
 up-to-date"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Kbuild | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kbuild b/Kbuild
index 47c9fe175bd9..780048056ac5 100644
--- a/Kbuild
+++ b/Kbuild
@@ -80,7 +80,7 @@ always +=3D old-atomics
 targets +=3D old-atomics
=20
 quiet_cmd_atomics =3D CALL    $<
-      cmd_atomics =3D $(CONFIG_SHELL) scripts/atomic/check-atomics.sh
+      cmd_atomics =3D $(CONFIG_SHELL) $<
=20
 old-atomics: scripts/atomic/check-atomics.sh FORCE
 	$(call cmd,atomics)
--=20
2.19.1

--=20
Cheers,
Stephen Rothwell

--Sig_/V2udws/wg9FA4M=zy2WB=Tv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvg46UACgkQAVBC80lX
0GxRRAgAk80jx7lgDJ1maHNoo7KKjgJP4u+RwCIhWcRH8jRYfJlWdbiUxqbojuxd
yPZfFHA5D+qgvptM7gqQOPXuuVdfJXFsPZJd1A4XwWstGhb8IHdFb4P5mZ9v5UjQ
DehN3+Bb7IIMeY7Z3sDAhaHw8/N96mkFLRw3fqgNhhN88o+9j/xOIojiNsiB5RFa
BaTkPyC266Unttue1W/dqnuENbwmSafgiyufoWXMqCCKP7qyeeKk20LCDaGtS5D/
OlTfm8WBX1Fb+x5guIkrGFq4tD0gQgTpdaOtO8I69Eu/8vLnT7Uu7+QeLhOomgYL
qg0Dm2miXo9W2zCIzbU43C7Fs1eqKA==
=aerB
-----END PGP SIGNATURE-----

--Sig_/V2udws/wg9FA4M=zy2WB=Tv--
