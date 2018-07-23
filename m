Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19AAECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A545D20671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TkhutJX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A545D20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbeGXAJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 20:09:17 -0400
Received: from ozlabs.org ([203.11.71.1]:59117 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388110AbeGXAJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 20:09:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41ZHCZ03Qkz9s4V;
        Tue, 24 Jul 2018 09:05:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532387146;
        bh=1hw8m8oxMD4fUgb0fidGCpfygl5fKrT6TQQd0zVOJ3o=;
        h=Date:From:To:Cc:Subject:From;
        b=TkhutJX8qumV73TWQrXR7oouCrEdz9jBDzUrXWnzJ0iBMLLRlVtLBQGD5Xupwm9dt
         rAqQsK4kbf2Mtau3Nb7m7cEv9jM9QhgDqNUCcjjaZkV5TVd4KHHXaMk12YM6Gf0e8j
         g6PTf7wWjfytfgQRoM0XSS36LbqSiler5UTxLbxqjBnkswoyGO5whXls3TGB2X62/3
         8ROGOEJ3/eJ2In5BrrJEcHOi78iZMd04nSGNc+kZ2lpIFFJIPlWusgvyO1rJtIhEBi
         TysT0XhnD/TCriPcyXPC9A2dXHM+kkpOPh2NerUIQV5H0ZwyIjiRrOPLwr9kkyXG++
         FfIl13wt0GS+g==
Date:   Tue, 24 Jul 2018 09:05:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: linux-next: build warning after merge of the arm64 tree
Message-ID: <20180724090545.2270d975@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jN7heVklmlR9WX36Z.SMHz5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jN7heVklmlR9WX36Z.SMHz5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm64 tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/acpi/Kconfig:6:error: recursive dependency detected!
drivers/acpi/Kconfig:6:	symbol ACPI depends on EFI
arch/x86/Kconfig:1920:	symbol EFI depends on ACPI
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"

Introduced by commit

  5bcd44083a08 ("drivers: acpi: add dependency of EFI for arm64")

--=20
Cheers,
Stephen Rothwell

--Sig_/jN7heVklmlR9WX36Z.SMHz5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltWX0kACgkQAVBC80lX
0GzRbQgAlEZ8ZMHeOq65ZF6UPW1pUTvOAfGcxsKpe9ibZERHJtWjjSlvD02v4BLc
Y74KCIhysKHbQFjI4emZUce1573E70gvDMqoe8JIYqAY2x3DdkUOh2sqge5yPQMB
XCInvqs7LlkiObH8VFjRMr81CeH7OqvYUsDu9lEBrvc9HCIzFtM8e+f2WWsiLGW6
e9gTEHrsoMMOb7qi2vSPtXl5gdl5HHUbw/Cmhy7ZKyjOdUML1m/qmnwm0meeDq3a
RNj/joNkt2H+fRA1Ym4J7qfX7k1+V7A7VTsGJRGIcj2LIGVsuoo16K3B9zUofYcg
QPhrfTv7FryyVR2sbt9JzJGOzCfQQg==
=UW3N
-----END PGP SIGNATURE-----

--Sig_/jN7heVklmlR9WX36Z.SMHz5--
