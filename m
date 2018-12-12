Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE4EC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD9520811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iqGm6d/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD9520811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLLBC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 20:02:56 -0500
Received: from ozlabs.org ([203.11.71.1]:39105 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbeLLBC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 20:02:56 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Dz7d2W5Bz9s2P;
        Wed, 12 Dec 2018 12:02:53 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544576573;
        bh=6WIWnyrMEjg5gMRCO9DY1z/J1XA/tE7xrq+Jo1qg8bQ=;
        h=Date:From:To:Cc:Subject:From;
        b=iqGm6d/+pkSR6o1qIFl9Db11cidLLak+Ehn8o6eKQzUA0dHvBXd2iH8s0xQWCRvtf
         Ppo7mShSbiBj4XbsO0YxwK7SPWvzYoOC8Al//ri2qenJRSLXi7TdWf6dLP61idhZKp
         nu2aJ9aLyV8Tp2Nc1gHhLAcwJIY/hjWlXjmzDMqAziWXxKmzCNKUftDNGO7HoFijBS
         6fb+ucqMzvtYJYuepYlTImjdQahvRMwqFbiEKaF2HrzI9lDO99vpozlTdbmcMK6Pl8
         vku0nPXbFZHdXFopaTmDubvRTbfYPXIdLp2gJ/9u9D1DrEYG9TbNgoJYzUHJ52isQm
         t/eycpRCpL2Eg==
Date:   Wed, 12 Dec 2018 12:02:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: linux-next: manual merge of the net-next tree with the
 char-misc.current tree
Message-ID: <20181212120252.5260cb22@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/va0C.Q=hZe4pk/E4Ct33LSf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/va0C.Q=hZe4pk/E4Ct33LSf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  MAINTAINERS

between commit:

  cb4f131e1f2c ("MAINTAINERS: Patch monkey for the Hyper-V code")

from the char-misc.current tree and commit:

  b255e500c8dc ("net: documentation: build a directory structure for driver=
s")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 4a2a30380bed,a676b40ac1d6..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -6930,11 -6902,9 +6931,11 @@@ Hyper-V CORE AND DRIVER
  M:	"K. Y. Srinivasan" <kys@microsoft.com>
  M:	Haiyang Zhang <haiyangz@microsoft.com>
  M:	Stephen Hemminger <sthemmin@microsoft.com>
 +M:	Sasha Levin <sashal@kernel.org>
 +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
  L:	devel@linuxdriverproject.org
 -S:	Maintained
 +S:	Supported
- F:	Documentation/networking/netvsc.txt
+ F:	Documentation/networking/device_drivers/microsoft/netvsc.txt
  F:	arch/x86/include/asm/mshyperv.h
  F:	arch/x86/include/asm/trace/hyperv.h
  F:	arch/x86/include/asm/hyperv-tlfs.h

--Sig_/va0C.Q=hZe4pk/E4Ct33LSf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwQXjwACgkQAVBC80lX
0GyyqAf/buHMJXRweis7vXd4hKdzKVzjOsKdtDodaZ6F5lpZ4KfRrhW/1BlkChDq
z7me3ZEvMw3ubOdgVhAEFHLbbs4e5J4E1c7PdkCNMr9fMiS+GeIbpcGgpC/IYs9b
SJdL7AAjtmu097IjRFUr+6yn+/aG/UcZb89UyUMiZm9i+aMGd+yEFhZLPePsf64c
5Q/cp2tK8HvDbFfqHZbQNODwjR/9GgIwnaHo1DVPq/rKzTfzQRDBS1g9NvBhfAYD
FSmuSUAN9zWjJGwdq+YvtpMkc+89I4Fqn9a0B4Bb5Bl+GwDzX8TjP1GGZ7WNR61k
Q5kjYO7quouRr7nzkgu4h+3FjhF5ag==
=8Sf8
-----END PGP SIGNATURE-----

--Sig_/va0C.Q=hZe4pk/E4Ct33LSf--
