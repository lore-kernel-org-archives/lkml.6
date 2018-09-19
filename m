Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029DFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00AF2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sbpqqUO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00AF2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbeISIsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:48:00 -0400
Received: from ozlabs.org ([203.11.71.1]:52005 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbeISIr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:47:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42FPzY4tZ3z9sCV;
        Wed, 19 Sep 2018 13:12:09 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537326729;
        bh=lx9gWBPyN+eU3dbEqWfPj8NXB00RDdj5WeXM7Bnq32E=;
        h=Date:From:To:Cc:Subject:From;
        b=sbpqqUO+ig/E9Nr3FssiL4SguE+BTkSNIHzpO+Rr0wvtxcyMJXV2hpPNXeA4HiRUd
         Atytw3Bt3p+YvEICNx5mqI98Ot6HS4OuVSWK+t5DUOhwCXt0Wgecij4NC0W3OR9/Sf
         R69Ycsv28JKKeKDh20eQavVzwDsHzg8I9+i4X1fHtzHy2dVKGoGf9b1JLHyy7Jy3BD
         gPUHSKrzney9l44cnxL9noZ53KaqtgpSYXHLLdUwtqn8C1b1CXPQPegV7PC1C/smbM
         i5OLryOfX8WaUFKRbQA/Ef2HVVtPiFnRG/fdYU0FPsQOJmq/Cl3EFiHLW6zA7RkIEZ
         Wyhu3X52oz7+Q==
Date:   Wed, 19 Sep 2018 13:12:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: linux-next: build warning after merge of the tty tree
Message-ID: <20180919131208.07aa9c6b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zHN7EXP/_IdCDN5DGkikm+j"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zHN7EXP/_IdCDN5DGkikm+j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the tty tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/tty/serial/kgdboc.c:134:12: warning: 'kgdboc_option_setup' defined =
but not used [-Wunused-function]
 static int kgdboc_option_setup(char *opt)
            ^~~~~~~~~~~~~~~~~~~

Introduced by commit

  2dd453168643 ("kgdboc: Fix restrict error")

--=20
Cheers,
Stephen Rothwell

--Sig_/zHN7EXP/_IdCDN5DGkikm+j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluhvokACgkQAVBC80lX
0Gykxgf9ERNFk3BLsqosftgmVPn56QDxAL/5rL/bCg771tenzM1q1ewI9R4AIUS5
3ma6RMRhNHjuxDEVICXvJ7VdJt9XSnIZrMWXlm55L8H2fP02GtKk1AR5xgjMsNae
uLW5nNX14lFRAcYwq2HrEZy5aEX6S9Tvqg/9TATsNRGPpfE5LJzEvp64gXXDcCIM
bz4ggu1MizDrkvHH5+wSeK0At6f2S6JXZQFQOwu0NhVKQNLvABCTaAjTcvhxw8Gu
CkQuf/ljaAqhXt8A1ixciAU/AWOXZFC5LxuhcdMZQb0Ra8ikJgU4NIwdAD0N97Xo
ZlFRMeqyubOzM07rxVip5IdxvbG0Sg==
=5BlO
-----END PGP SIGNATURE-----

--Sig_/zHN7EXP/_IdCDN5DGkikm+j--
