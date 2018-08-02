Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E33C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109ED208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="djPQ6F9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109ED208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbeHBDDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:03:54 -0400
Received: from ozlabs.org ([203.11.71.1]:39091 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbeHBDDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:03:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gsfn0PqVz9s3q;
        Thu,  2 Aug 2018 11:15:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533172516;
        bh=O/Gduby3zNHwTEX3Yl2JtXQ/2dAnsnMaj43SOXnStHc=;
        h=Date:From:To:Cc:Subject:From;
        b=djPQ6F9wNgnuGZKCCThfq7clsS1PHAiW3xgy5/rmYcfLxxhRJU3k8i8gwS+AoAjD9
         75najSEeWM8jqyvZo5sEKb3wzlxfzY2/FZtO30B76ZvfPJBVwR0ibKpJ2TBI6iHzVt
         Gtm7oK2IrF+WZpuz1wzBOpmKni9O/bKspys3YTrFXT6icoesM6aN87Ax7FwHpJAaem
         THg2XeoPt9OxTFw46kS0dVMQLRvdhT3udm+Gd74Aow3zo0eHAJ6YOTLb/bl4pMgIeF
         gcp2rIzTBGbvhp3VhQOOJS+XoDR8cwXngWCuNsPsJ6prP0lCPeblNqgoyBaRXOFnBi
         plLu9P4DYIW9A==
Date:   Thu, 2 Aug 2018 11:15:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>, Theodore Ts'o <tytso@mit.edu>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: linux-next: manual merge of the jc_docs tree with the ext4 tree
Message-ID: <20180802111512.3a467ff5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7=12L=sr.Fv+AsRsDlGk3uz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7=12L=sr.Fv+AsRsDlGk3uz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the jc_docs tree got a conflict in:

  Documentation/index.rst

between commit:

  6684874af063 ("docs: create filesystem internal section")

from the ext4 tree and commit:

  85c32d9c6f3e ("doc: move away translations from top-level index")

from the jc_docs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/index.rst
index f95ba981f8cd,5d310d960f82..000000000000
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@@ -102,40 -104,13 +104,24 @@@ implementation
 =20
     sh/index
 =20
 +Filesystem Documentation
 +------------------------
 +
 +The documentation in this section are provided by specific filesystem
 +subprojects.
 +
 +.. toctree::
 +   :maxdepth: 2
 +
 +   filesystems/ext4/index
 +
- Korean translations
- -------------------
-=20
- .. toctree::
-    :maxdepth: 1
-=20
-    translations/ko_KR/index
-=20
- Chinese translations
- --------------------
+ Translations
+ ------------
 =20
  .. toctree::
-    :maxdepth: 1
-=20
-    translations/zh_CN/index
-=20
- Japanese translations
- ---------------------
-=20
- .. toctree::
-    :maxdepth: 1
+    :maxdepth: 2
 =20
-    translations/ja_JP/index
+    translations/index
 =20
  Indices and tables
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--Sig_/7=12L=sr.Fv+AsRsDlGk3uz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltiWyAACgkQAVBC80lX
0GxhKAgAmxX4uTddswsJeFVLG4euFxLC2EbdjLawn7+ZFazDNrneLbOVuW2zq6+I
Ww525gMYrZImk1JxllMUw2JcSwSEiUNvkoqSPk1ZSbEbvhu1AT7XPNDs00+tiMrc
UXnss5tnDAy9czB2eZBdzmLxdOc98Q4QMNoDdTf+9sG25jDwInfFWeT+uitSHyvN
kx+h9DDKSYm/W2ydLzXgLPslvauKtOkrwpsvzGzI/aW17oUXP1X5ZJWozWOxaUt/
A6jP+U/RlAHe0reKHC0WmS/pugWoKBEtxmAMlulILxVm9PpmDef7okqqAdrNlfCl
c/6J/1AW6+C37KmX+xlmKA0YpvkmCQ==
=oAag
-----END PGP SIGNATURE-----

--Sig_/7=12L=sr.Fv+AsRsDlGk3uz--
