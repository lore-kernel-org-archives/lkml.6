Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CFDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416AF20854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sCrPVK36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfANACI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 19:02:08 -0500
Received: from ozlabs.org ([203.11.71.1]:46785 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfANACI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 19:02:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dDDF2YsQz9s7T;
        Mon, 14 Jan 2019 11:02:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547424125;
        bh=TlxYXZE4sQF/Aac+kyh6hfP2d7wNfPfAorXxr9CbVPM=;
        h=Date:From:To:Cc:Subject:From;
        b=sCrPVK36RjXj2DxQDQyYmzQ9rtj13/RaAvAWlR6Wvv5yRSPBxWF4x1C4o1dPtIX2S
         6UVDAZ6+yaNmxoAthKDTDapdAAmWBC1SGQsELfA/dBQ4cUquEuYOqCxX1ZwfQVcrya
         3rbaG/GcMQukFSx74Ip2ZmdKv1UKzvGPmUAKATRVTXMHq/cxJAlAbmWVoTaoje3qa3
         jkvfJTHo2CzQNpnuW9FxPXFEHACs1iE5E93DtUHPyQ+0Xk7m8MDnfKG1PXSgNijpcw
         BZTpBhjgSoK21Sk4q4uEC41A/nOOcWilnqrseLwnSQCpBl7qEVV+EmrN78TK5BOUVf
         0APzrDTUQoM+Q==
Date:   Mon, 14 Jan 2019 11:02:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the vfs tree with the vfs-fixes tree
Message-ID: <20190114110204.5eb36d04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/W6+sWcrA0soaaHA4VprP2Yu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W6+sWcrA0soaaHA4VprP2Yu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  kernel/cgroup/cgroup-v1.c

between commit:

  61aa329d0762 ("cgroup: saner refcounting for cgroup_root")

from the vfs-fixes tree and commit:

  b3678086951a ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")

from the vfs tree.

I couldn't figure out how to fix this up, so I effectively reverted the
vfs-fixes tree change.  Al, can you either do the merge yourself, or
provide me with a merge fix, please.

--=20
Cheers,
Stephen Rothwell

--Sig_/W6+sWcrA0soaaHA4VprP2Yu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw70XwACgkQAVBC80lX
0GwN0gf+PcBzCF9K67oo/h5dYw6yytrsora6pT1yG21VSjjeWpcqi6sB9Kw/4794
HX7pxQB1wTzA52kvcD0keKZoCDdOIY+9p9dfOuCp9QFsVNZCpZgQgTNQGP2fY9rS
LCRhoazNga+ml9vVRR00OMZiXMnN+1h1VIlKtRoee6DTHXuCKQiA9kRmQqGgQrEu
qUUevFAjgZOVkc6CWF5+02n8pCAKTgZakgdSgVRpvxj3HDf69cV4xOMVo+kTZkip
O/czAgkUD+TK680ErGr2+4OX+sQb99Wwz1q+lfrNpKL18RbjcBgVL4vRbPUanaYN
dO10Zva+jc5Vw7+Uc76zSda8nZxy0g==
=TMps
-----END PGP SIGNATURE-----

--Sig_/W6+sWcrA0soaaHA4VprP2Yu--
