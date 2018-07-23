Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DC4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3A020878
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nNfUvbCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3A020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbeGWHvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:51:19 -0400
Received: from ozlabs.org ([203.11.71.1]:33871 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387819AbeGWHvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:51:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41YsbW0ckKz9s3Z;
        Mon, 23 Jul 2018 16:51:35 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532328695;
        bh=ylfedoARvtzx2AWvAAY4yx85W5H4SYXiPXjnd55m+20=;
        h=Date:From:To:Cc:Subject:From;
        b=nNfUvbCLUAmVBt2QFYBgY5UTy2MSmzWV3QJyyAW4iygkWp7FZlrSY56F2zuuFofPD
         yZ8BuwtHBAC8WLfl6j+fAzXhuaQnGGKn19NhsIhhLepnAGeRM0n0HbvJyn+CL0NFFs
         cstu/udCy74zH7/yD/qBtBD8uUIXPkX+CrHB70NC51rW4+vOqjp6PocJ3NUlF4t681
         pKjkdLUg76pEe/PuLxzLAaGl5619lFmwI13eCPAKniEhvzYdh4MiPGX5ofFi4MjybJ
         Kk5m+igguzqX9bwPxuzPuq3Yr9f6k3cBS5K8O9jWkimBhuuueOl9PZcB6a6InYVqNw
         kWep9Rhk+2GaQ==
Date:   Mon, 23 Jul 2018 16:51:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: linux-next: manual merge of the xarray tree with the nvdimm tree
Message-ID: <20180723165115.4c96278b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/arOsxl+6MdhuZX6xEIj6HGW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/arOsxl+6MdhuZX6xEIj6HGW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

Today's linux-next merge of the xarray tree got a conflict in:

  MAINTAINERS

between commits:

  30153e5ba54d ("MAINTAINERS: update Ross Zwisler's email address")
  212a28b4dae9 ("MAINTAINERS: Add Jan Kara for filesystem DAX")

from the nvdimm tree and commit:

  40c8f8eed61c ("Update email address")

from the xarray tree.

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
index 7afb9ad5a85c,9bcfd5caa248..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -4330,9 -4272,8 +4330,9 @@@ S:	Maintaine
  F:	drivers/i2c/busses/i2c-diolan-u2c.c
 =20
  FILESYSTEM DIRECT ACCESS (DAX)
- M:	Matthew Wilcox <mawilcox@microsoft.com>
+ M:	Matthew Wilcox <willy@infradead.org>
 -M:	Ross Zwisler <ross.zwisler@linux.intel.com>
 +M:	Ross Zwisler <zwisler@kernel.org>
 +M:	Jan Kara <jack@suse.cz>
  L:	linux-fsdevel@vger.kernel.org
  S:	Supported
  F:	fs/dax.c

--Sig_/arOsxl+6MdhuZX6xEIj6HGW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltVevYACgkQAVBC80lX
0GxIwAf9E1gQXy0MwWvVyOuJNlIoZlv+8GrlQIJLmNT39iq712spd8zAonNFnRCP
iqOfKQSWkCVkDKwInuyR9m5lpnyEGdVS0FW8bjOg7t9DV2ZSmf32dKmwNmNW3UaL
g3d6S92y83mAGzQYgEtND4piqoLBjR/sA4gnepxG2A3zC+PeB3sOoCZswKqQ3UkO
96kY4JdbiknwtpGdzmf54vcidPwjarIHrPqSq/CcQW22qfiUo71VH53or+T3iDg9
uhhXlK+iTcY+qiSO6ezXkwI+watkFbiYB/CZvAIXYJitfgsNbPUaSXY5spliZQzc
PHuafseGslugf0Jqx/T1FuoE3eWygw==
=LsyE
-----END PGP SIGNATURE-----

--Sig_/arOsxl+6MdhuZX6xEIj6HGW--
