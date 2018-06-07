Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /Ih4MrKPGFulGgAAmS7hNA
	; Thu, 07 Jun 2018 01:54:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CA918608B8; Thu,  7 Jun 2018 01:54:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XjhjZzYP"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 59F5D601D2;
	Thu,  7 Jun 2018 01:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59F5D601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeFGByO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 21:54:14 -0400
Received: from ozlabs.org ([203.11.71.1]:37977 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752344AbeFGByM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 21:54:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 411T9X1gj3z9s1B;
        Thu,  7 Jun 2018 11:54:08 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528336451;
        bh=iORK39LGbWvHxzD7IG1JaWzzjLht3zoEtKISaC+QOZE=;
        h=Date:From:To:Cc:Subject:From;
        b=XjhjZzYPDqUNN2lX2Vhx13M+obb8fOiYAE8e6nQmUyck4QpccapqJnBZ+7LU17dJ9
         p+14dL+urPn25zwRKx7GXeqOktfZfQ03dWQ25het3WR7Ih3Y2hXN40tAgF3GKWff1h
         w0Knw6TD4szLfPEWIogzpVhoYlFrLsFQCpny+3mWz8Db4/cn6v7atvU13vO0mf/X5w
         yHuJilyQuZT3MOu4lz2ti6ceHot1XKgB2KcI3IzAShi4gRkWxH22Ru0DiGk2hPTwXZ
         LgLHGtvBVV6tKySqwr2qCUh5JxJz+KzfVER6uz59NvaZKgpI27tCHE6r/9V9hIpSmA
         /WSUtEI2+JmDQ==
Date: Thu, 7 Jun 2018 11:53:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20180607115350.69251fcf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tWhKl/+1bHH7mzrHfeG6KEG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tWhKl/+1bHH7mzrHfeG6KEG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  tools/testing/selftests/Makefile

between commit:

  a12ab9e125f1 ("selftests: move RTC tests to rtc subfolder")

from Linus' tree and commit:

  ccba8b64452b ("rseq/selftests: Provide Makefile, scripts, gitignore")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/Makefile
index 4cd339b5366a,593fb44c9cd4..000000000000
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@@ -29,7 -28,7 +29,8 @@@ TARGETS +=3D powerp
  TARGETS +=3D proc
  TARGETS +=3D pstore
  TARGETS +=3D ptrace
+ TARGETS +=3D rseq
 +TARGETS +=3D rtc
  TARGETS +=3D seccomp
  TARGETS +=3D sigaltstack
  TARGETS +=3D size

--Sig_/tWhKl/+1bHH7mzrHfeG6KEG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsYkC4ACgkQAVBC80lX
0GxXbwf/c5j4YyGj+TZPY/nBYPR2xDihK9so/yQdF9R6hHu7Z0LZ2o/zqwyzgaea
7QybPNk48nTK6yu2wAqkN0thLqirAX9awIJ50AW07fZNQuuBhfVLSTtPLH1szawI
eVOojJJ0qX56sey+qIGT2C4kQNun9wEgtZhm8tD6e2m/SuPZUDepamGBw3PwefSK
66f+XzQKuJXYvGQS5Z92c+yYSE3D5ppIqv+oiMJx0b2N7y+5oV9qP59Bwo4FAbL7
AMIxqzIH6EcJ3cjZtgJyKdwomRRhZ7wVY4/z+INbJSEJ29ffj3c1Q14f45nN5n6p
H2vuQAlJy8xICCYeqADT5JIYin5gyw==
=A3Qs
-----END PGP SIGNATURE-----

--Sig_/tWhKl/+1bHH7mzrHfeG6KEG--
