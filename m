Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B8FC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5D326C72
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M5VrjRqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5D326C72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753445AbeF1E7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:59:17 -0400
Received: from ozlabs.org ([203.11.71.1]:52089 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbeF1E7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:59:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41GSHN5WhMz9ryt;
        Thu, 28 Jun 2018 14:59:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530161954;
        bh=gYROkyXkUxB5Woq/G/L32wW3PsawpI6lO5LTHXSOsWE=;
        h=Date:From:To:Cc:Subject:From;
        b=M5VrjRqdxpMkZp1XRuSlF/OhYQ4yLzPOp7vcvZ9QwNnmdslxmLdGLORnba+E3J6zq
         Pvw9jx8/pnrWvrh0tY0msfAp5efSedBXOodshuOiWZHf25zDi2l6rOYcI5cu4F2C0+
         W1v4EvjTSsdKBpVCp31VRmIyFJ+ojkNqBudqLFPTmZLD/yqCOuvsN1nC8CixYnkAbt
         ceaopmddpMcWJ6IJa5CrDxYmdt2lay12dzm6B6lKK0XB2aleRlfh7L1DAkaJhwBR0C
         4PKu9FMQ4A0V5evfNO/WzfrUy8uC5BKbcMJzPmimCFhfalPG9Sj6N0S11YfBGi0kkk
         9swgo0ZlnIa7A==
Date:   Thu, 28 Jun 2018 14:59:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: linux-next: manual merge of the xarray tree with the
 wireless-drivers-next tree
Message-ID: <20180628145900.4ca1e648@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/w0UTs=DoWUojtQpEhHHC5tx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w0UTs=DoWUojtQpEhHHC5tx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the xarray tree got a conflict in:

  lib/Kconfig.debug

between commit:

  0e2dc70e3d0d ("bitfield: add tests")

from the wireless-drivers-next tree and commit:

  d968f529e39f ("xarray: Add XArray load operation")

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

diff --cc lib/Kconfig.debug
index f2be7503f87c,df1ea92d924c..000000000000
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@@ -1802,13 -1802,9 +1802,16 @@@ config TEST_BITMA
 =20
  	  If unsure, say N.
 =20
 +config TEST_BITFIELD
 +	tristate "Test bitfield functions at runtime"
 +	help
 +	  Enable this option to test the bitfield functions at boot.
 +
 +	  If unsure, say N.
 +
+ config TEST_XARRAY
+ 	tristate "Test the XArray code at runtime"
+=20
  config TEST_UUID
  	tristate "Test functions located in the uuid module at runtime"
 =20

--Sig_/w0UTs=DoWUojtQpEhHHC5tx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls0axQACgkQAVBC80lX
0Gxt7wf+NCxfGPR4S0spDyVUqdi2K48ZHk3jqA+yYRzhX025g0bRG1in3ZO7H74n
AIFM5rgATSQPlGuXa4qgZzzKhRHvDAPYf4LuFL3M/Usqa3M187AVt6cgFZBf78QA
oD6ypzvECVpShj5tZQihwdEegBxib9ZdQOXu+8m6VFMaZiPVeCsNQ5nOh7q7zyR5
RpzUbTbEwAB6K8fZuW2Y/HomKyJruhkMbJ1CCBSi6eGQhKAuh+A5OMdQ8AXxfIAG
1Cg83FHhb/az1YwyzQQHLr3mVyFee54SXTyLmzbw2QKcluH6QEHQ4Hw1A7Szzv2+
Nf88LhwOs0NorXjVw4iCrwioOqAKVQ==
=AT++
-----END PGP SIGNATURE-----

--Sig_/w0UTs=DoWUojtQpEhHHC5tx--
