Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7570C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8D02152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="I5uYt2zC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8D02152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbeITQxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:53:09 -0400
Received: from ozlabs.org ([203.11.71.1]:44629 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbeITQxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:53:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42GDXc5sRXz9sC2;
        Thu, 20 Sep 2018 21:10:08 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537441808;
        bh=Apfzl0LBx4/zPCjTcu3rgmzHQLqWyjn1orqK0ayrsgM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I5uYt2zCRHmW7IKyMR6mxx4OYjxnWC4kzccMvr87uc5NIpYVwLYIbyLXIUpMIe3yT
         rIIPmv4e38kmap/oIgpA/dKmHWl7on4QugEf1DiltlaIABa/ozv1uFMddxa9UPBkWz
         P5cxpQHiWnzHCb+G2WwZ4opkeSuo8FKcI6j3bac78nnZDL5C4wOR+ZXU0FP1V0H964
         7yz0cI+Gw7KoNeAaVzJDdTyg1WzSwPenbM7DwNgQKGPOR+WIh4Z9ogPrPrlqWNbVu/
         bKmr7Uevwe92qaEuQ14rWxeqjBYCbNlNVdikcuufrY6iOAjrSiqp8cSwmsaqig1xX+
         qHa6ihAm3Xkmg==
Date:   Thu, 20 Sep 2018 21:10:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>, robh@kernel.org
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Sep 20
Message-ID: <20180920210711.4561abee@canb.auug.org.au>
In-Reply-To: <87d0t8jvym.fsf@concordia.ellerman.id.au>
References: <20180920151243.5524c6ca@canb.auug.org.au>
        <87d0t8jvym.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fqB1TWcNoApRYmxO2qH.b0N"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fqB1TWcNoApRYmxO2qH.b0N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Thu, 20 Sep 2018 20:37:37 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> Oodles of:
>=20
>   # < make -s -j 48 ARCH=3Darm64 O=3D/kisskb/build/linux-next_arm64-allno=
config_arm64 CROSS_COMPILE=3D/opt/cross/kisskb/br-aarch64-glibc-2016.08-613=
-ge98b4dd/bin/aarch64-linux-  allnoconfig
>   # make -s -j 48 ARCH=3Darm64 O=3D/kisskb/build/linux-next_arm64-allnoco=
nfig_arm64 CROSS_COMPILE=3D/opt/cross/kisskb/br-aarch64-glibc-2016.08-613-g=
e98b4dd/bin/aarch64-linux- =20
>   /bin/sh: 1: pkg-config: not found
>   make[3]: pkg-config: Command not found
>   /kisskb/src/scripts/dtc/yamltree.c:23:10: fatal error: yaml.h: No such =
file or directory
>    #include <yaml.h>
>             ^~~~~~~~
>   compilation terminated.
>   make[3]: *** [scripts/Makefile.host:107: scripts/dtc/yamltree.o] Error 1
>   make[3]: *** Waiting for unfinished jobs....
>   make[2]: *** [/kisskb/src/scripts/Makefile.build:536: scripts/dtc] Erro=
r 2
>   make[2]: *** Waiting for unfinished jobs....
>   make[1]: *** [/kisskb/src/Makefile:1067: scripts] Error 2
>   make: *** [Makefile:146: sub-make] Error 2
>=20
> http://kisskb.ellerman.id.au/kisskb/head/a0cb0cabe4bbeacf5ed9e81a41abcbae=
47ba925a/
>=20
>=20
> I guess we've got a yaml dependency now?

Yeah, but it is tested for and worked for my builds during the day (I
don't have it installed on my build machine either ...  do we have
pkg-config installed in the build images?

Anyway, it is (presuambly) caused by commit

  52786e7517a2 ("scripts/dtc: Update to upstream version v1.4.7-14-gc86da84=
d30e4")

from the devicetree tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/fqB1TWcNoApRYmxO2qH.b0N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlujgBAACgkQAVBC80lX
0Gw1qQf/e+2+cE7SAGP2TO0AitY5bEECuk7I8gjnytxwcD/+nRVoXrH8dU/wSS9l
iAdgsoi2uYefca4+h8IOgzgrIbhfRcBR6mFJ0jgzH0bSyXgoxQXYUquY/xhiznIe
0l2xXEoOF7I1YHWWssMLvAtmWqFIjiWn3gNBDP9eC6ULRUFl8wG+RErqfDGYlS4d
FlEp5N1vtQ2tmLboM45zToUocjsXxPhat8mprbThnSuLfGgQBHNefD5L5x/qA4sy
2TIxQwnA0AHqKjZFCE2pwdmVgLStJkppxKkhu7zLbjp5twYR4SMMbKHIxdDu4lGC
9A4VuClZI0atGcM44tCDlERo77omaw==
=brwp
-----END PGP SIGNATURE-----

--Sig_/fqB1TWcNoApRYmxO2qH.b0N--
