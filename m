Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB63C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA9F2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JtuyAEK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA9F2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeKPJt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:49:59 -0500
Received: from ozlabs.org ([203.11.71.1]:43353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbeKPJt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:49:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42wyWy6zH2z9s5c;
        Fri, 16 Nov 2018 10:39:58 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542325199;
        bh=LlhK0tNVj8aZ9lvxUIe9P6H1qwWvaX9reF50QF9I3JU=;
        h=Date:From:To:Cc:Subject:From;
        b=JtuyAEK3soz+wJPgPywjJiDg3mriQKQQP5Z8g9ia5afjzcXo65yGYKVOTA8eDLfRm
         0VYLGum4FVMNm/K4xbqruwzLFTGj/Kh5hQP3VXdK3OIznHItPXqss5OU5PRlTUKy3O
         JakwWrHS6qwzuCUM7qSHkJsa1k4xkPgbfKjw8mS0e/9xTC2SnZvNSOdV3qDCy7Mi+O
         rRdBxy/xf1sHyZSxg3TBxQlrrtoZ+O1jCCrAFborUu1caCC30f/0Z/S1PkEVvlov3X
         X03pZf72d8arW5KPVjLztCVyKptXrDqmhfTJJw+ehnla2l3YJeSIygdD69P9rgWf5g
         cVuDz080dr/AA==
Date:   Fri, 16 Nov 2018 10:39:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Firoz Khan <firoz.khan@linaro.org>
Subject: linux-next: manual merge of the xtensa tree with Linus' tree
Message-ID: <20181116103958.585d9cff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Trk7nOsBO23/NTtD1yhr.jD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Trk7nOsBO23/NTtD1yhr.jD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the xtensa tree got a conflict in:

  arch/xtensa/Makefile

between commit:

  37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build rules")

from Linus' tree (it precedes v4.20-rc1) and commit:

  7c17225f2059 ("xtensa: generate uapi header and syscall table header file=
s")

from the xtensa tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/xtensa/Makefile
index be060dfb1cc3,1e7b179eb6fe..000000000000
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@@ -90,6 -93,15 +90,9 @@@ boot		:=3D arch/xtensa/boo
  all Image zImage uImage: vmlinux
  	$(Q)$(MAKE) $(build)=3D$(boot) $@
 =20
 -%.dtb:
 -	$(Q)$(MAKE) $(build)=3D$(boot)/dts $(boot)/dts/$@
 -
 -dtbs: scripts
 -	$(Q)$(MAKE) $(build)=3D$(boot)/dts
 -
+ archheaders:
+ 	$(Q)$(MAKE) $(build)=3Darch/xtensa/kernel/syscalls all
+=20
  define archhelp
    @echo '* Image       - Kernel ELF image with reset vector'
    @echo '* zImage      - Compressed kernel image (arch/xtensa/boot/images=
/zImage.*)'

--Sig_/Trk7nOsBO23/NTtD1yhr.jD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvuA84ACgkQAVBC80lX
0GzSbwgAhq+d/fQsHqp5xB4g2FCHgHUHEPEUMFV11ZT6hH+nF5N2Fowo/T0NTDUI
jchYAFEojOUWbEoomhPJuPfnrSpcvybb5VWE7ObcMKEQDb5v6Rzuj1PUaHhrlqLr
wN7ZgKE7Bu8VDOvH9AowYyzg9cQ6IsuQJ9iZUhZ9/YLNT0/QvqLrShAb/wLRmkfq
+wFSyVNKKEkg/2JzUa/z/NfFURR5h2Mwp1KUThdeajJwq8Q5FrCscMNZBVXBO2pg
QH3UHAXDNzk6LfpaiFD55gq2S/EJfLlyALaN8fqEGawyyJVsaqAUxvYIx3yYGT1A
56qwUQ59KT30nbVTLX9tuHdUgWdpaw==
=VzFR
-----END PGP SIGNATURE-----

--Sig_/Trk7nOsBO23/NTtD1yhr.jD--
