Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5ACC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E0C206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="U5mElneQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfAPXlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:41:05 -0500
Received: from ozlabs.org ([203.11.71.1]:50823 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbfAPXlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:41:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43g3cY6LHdz9sBZ;
        Thu, 17 Jan 2019 10:41:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547682061;
        bh=oPLHSblTihb9CKxYo3oSwfyW6F+67G99oDCgOXZ88F0=;
        h=Date:From:To:Cc:Subject:From;
        b=U5mElneQq5p3fCV8+KaFI95ToQQ6vpFfuHuoU5SWfuDJMVneUw9YRcB3KVgOxP1aA
         yosULK7vNIK86JeVgN5fagX2ChTpFdVN30y2c+4iQktQv5TF9C8i5h0rUUxAwiXTi9
         qTWwHAyDdUIy+z1d60OTdVv7XtEPw1KpJmoIK64g8S18Nx6MhP6TKu6atrmxoFfLUR
         IgABECXVpglakMwKCJQwyo7L79RWnO42zZTPCLwXGjSjyLy6yKOKetJ5eicZ04huYD
         LIvK3r2bjtYdvr2P7RaOi75soo7780iXqCc9QfUYXZKlzG95j6Y1Q9GB0O6uD9quen
         hOF8LcK+OoPVA==
Date:   Thu, 17 Jan 2019 10:40:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Firoz Khan <firoz.khan@linaro.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190117104043.009ef499@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1=CnjxvyRx1E39Rg1rYP8ae"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1=CnjxvyRx1E39Rg1rYP8ae
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (any sh
config) failed like this:

make[2]: *** No rule to make target '/kisskb/src/scripts/syscalltbl.sh', ne=
eded by 'arch/sh/include/generated/asm/syscall_table.h'.  Stop.
make[1]: *** [arch/sh/Makefile:232: archheaders] Error 2

Probably caused by commit

  60a47bb1b736 ("sh: generate uapi header and syscall table header files")

I will revert that commit from linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/1=CnjxvyRx1E39Rg1rYP8ae
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw/wPsACgkQAVBC80lX
0GyBxwf/SACiLoC4LJHW79XoBe4TPZLSLzefS92PAsoAfoG7S4654/bvKHjZCfmI
ANH0oeALaW2QRLdkyIBV8kF5dZL5RgzS5Am8THuzDwpmIdu8HOurzO/s4HTpmfjc
pYKIZ8OJUc2nGuSfMFFf+JoLKkaoRSoTBAMOXsoUox55vq5+jiLP0RSuz6KsgFDx
FxScrV8OO673NReDMGE0+AUWdhaESuDTeiYb935+d1F53LZTUihDDYwOiq3oT3i/
nlOZhw2hjw6ryunC/nKGjHO21Zo5KC2h/3a0YftFExdsxEC6ihwUV6rq1Bql00sB
wnMd3jFJF3JVmsXbi/xAoD9LEaEpyA==
=AhOp
-----END PGP SIGNATURE-----

--Sig_/1=CnjxvyRx1E39Rg1rYP8ae--
