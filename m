Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DF7C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3561A20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lBAr7SoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3561A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeIGEu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 00:50:29 -0400
Received: from ozlabs.org ([203.11.71.1]:49047 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbeIGEu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 00:50:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 425yYl1GGlz9s3l;
        Fri,  7 Sep 2018 10:12:26 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536279147;
        bh=RAbM3pTUwvIU17kJacmxmrF+x4genCpY3AWDba5f2GM=;
        h=Date:From:To:Cc:Subject:From;
        b=lBAr7SoGzuCdXenf6pTY49CnyCWeCGih3fywKEmDFqZU8nBxoHLiuOrQteD9RKaz6
         f8F2OWJGrjNyTadFEGcvrXND0g/6hqMENl3FDX6JYOggM7pkKINtgD0wOS9iCxVcG8
         Z2gn5QKWoxQMoDu/ezkac6ma4OEf7bmDTxufxAiwK7qqWv+X3d1pbbZgIMKmUMX0Hp
         q/6EHLZitt1MroVLQj06dK3Qff1zYdw/kE8HK3R7NQKzRlpm70VNq4T3b+wiNzt02L
         ik/EprKpR8N3feX08Umv99tbB5iFzHmhLJIw+sbZ4IUHXtmCnCjhawlMvk8pVqh8qi
         gmZx6qyRdIHsQ==
Date:   Fri, 7 Sep 2018 10:12:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBl?= =?UTF-8?B?bA==?= 
        <bjorn.topel@intel.com>, David Miller <davem@davemloft.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>
Subject: linux-next: manual merge of the bpf-next tree with a previous
 revert
Message-ID: <20180907101225.05a12d00@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OBEI2oCS=mF.Xq=yzLCL2cp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OBEI2oCS=mF.Xq=yzLCL2cp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  drivers/net/ethernet/intel/i40e/i40e_ethtool.c

between commit:

  39b042e0b347 ("Merge remote-tracking branch 'net-next/master'")
(this is really my revert of
  8fd75c58a09a ("i40e: move ethtool stats boiler plate code to i40e_ethtool=
_stats.h")
due to a build failure
)

and commit:

  b5061a9e8785 ("i40e: disallow changing the number of descriptors when AF_=
XDP is on")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 235012b3bd42,3cd2c88c72f8..000000000000
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@@ -5,26 -5,9 +5,27 @@@
 =20
  #include "i40e.h"
  #include "i40e_diag.h"
+ #include "i40e_txrx_common.h"
 -#include "i40e_ethtool_stats.h"
 =20
 +struct i40e_stats {
 +	/* The stat_string is expected to be a format string formatted using
 +	 * vsnprintf by i40e_add_stat_strings. Every member of a stats array
 +	 * should use the same format specifiers as they will be formatted
 +	 * using the same variadic arguments.
 +	 */
 +	char stat_string[ETH_GSTRING_LEN];
 +	int sizeof_stat;
 +	int stat_offset;
 +};
 +
 +#define I40E_STAT(_type, _name, _stat) { \
 +	.stat_string =3D _name, \
 +	.sizeof_stat =3D FIELD_SIZEOF(_type, _stat), \
 +	.stat_offset =3D offsetof(_type, _stat) \
 +}
 +
 +#define I40E_NETDEV_STAT(_net_stat) \
 +	I40E_STAT(struct rtnl_link_stats64, #_net_stat, _net_stat)
  #define I40E_PF_STAT(_name, _stat) \
  	I40E_STAT(struct i40e_pf, _name, _stat)
  #define I40E_VSI_STAT(_name, _stat) \

--Sig_/OBEI2oCS=mF.Xq=yzLCL2cp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluRwmkACgkQAVBC80lX
0Gy+Ngf8DCyDRKjw9bj5z1WeLL9DqglizNpXgH+qLpmf2pEx60+QJBfjw+CF4xHA
rj1fqSvaN0qxSy3/pvq60ltxPSkkvsoTt6DoEh3FSUTs3kcJh15zfFuWGtpiTvTu
f3I6HgWP+WEZ9GgVAbjVCdUpAPi9JK1Dlyz+BPxo1SysFdVENsr8A4W/V9uD5xqG
hyAyUgWTIBuRpxL1LpYEDSLGwEIfHdjfQO0aOVi4LP3XNtIPElkvOtjPVD96jVmo
+EpiHxaVeNoUEQpcpa+kC+GA6KQ9OIOFW4TErQmpCw0XnDLf9lJ63buwLWJVgUsg
Hbve6r7O7b8zBm2RKRYt8tLJRff3Jw==
=q7D6
-----END PGP SIGNATURE-----

--Sig_/OBEI2oCS=mF.Xq=yzLCL2cp--
