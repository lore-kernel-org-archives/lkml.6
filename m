Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90907C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF5620894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AJ7Z0M0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF5620894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbeHACZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 22:25:30 -0400
Received: from ozlabs.org ([203.11.71.1]:42497 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732804AbeHACZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 22:25:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gDzY2hG0z9s3q;
        Wed,  1 Aug 2018 10:42:33 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533084154;
        bh=/RxSL9+KjWB7JhIkmCKn//AR06c5iuEDmofXlV6lcfY=;
        h=Date:From:To:Cc:Subject:From;
        b=AJ7Z0M0NotESVV5mH5Lx8y3HimvdtdtvMLJXQQrx2MbGXLkdlXL+O5LqxtdkTr4O+
         O6mx+rp7FHE/k10jxeSlMM+4Bf5Cql9chryifP/xXSllvSjaN6VcH9XUqjh0Curjea
         gID+3GfNYDd06MJKibblcw3NbL/Zta2C1jgv+HnssXgKDBXc6UCfjKKT3ymJdr6WMo
         /9Oqzu4Ggjdd/RXmccbw9iQsz1UboU1x03UM/b/ATVsQHIwjwVLHnm1BRnazpanxL9
         MnhzUKFsOmlVFNvaA9EqwKZdJIcKEqZXifNtSC8zMuUnYAYfbzl7noANX+3fsiWP1D
         kzKrxnWsdLDiQ==
Date:   Wed, 1 Aug 2018 10:42:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hari Vyas <hari.vyas@broadcom.com>,
        Keith Busch <keith.busch@intel.com>
Subject: linux-next: manual merge of the pci tree with the pci-current tree
Message-ID: <20180801104227.7e52b06d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/29FLhPHXSNImZfmVC35++5m"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/29FLhPHXSNImZfmVC35++5m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Today's linux-next merge of the pci tree got a conflict in:

  drivers/pci/pci.h

between commit:

  44bda4b7d26e ("PCI: Fix is_added/is_busmaster race condition")

from the pci-current tree and commit:

  1e4511604dfa ("PCI/AER: Expose internal API for obtaining AER information=
")

from the pci tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/pci/pci.h
index 08817253c8a2,ba078145bfaa..000000000000
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@@ -301,16 -306,34 +307,44 @@@ static inline bool pci_dev_is_disconnec
  	return test_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
  }
 =20
 +static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
 +{
 +	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);
 +}
 +
 +static inline bool pci_dev_is_added(const struct pci_dev *dev)
 +{
 +	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);
 +}
 +
+ #ifdef CONFIG_PCIEAER
+ #include <linux/aer.h>
+=20
+ #define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
+=20
+ struct aer_err_info {
+ 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
+ 	int error_dev_num;
+=20
+ 	unsigned int id:16;
+=20
+ 	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
+ 	unsigned int __pad1:5;
+ 	unsigned int multi_error_valid:1;
+=20
+ 	unsigned int first_error:5;
+ 	unsigned int __pad2:2;
+ 	unsigned int tlp_header_valid:1;
+=20
+ 	unsigned int status;		/* COR/UNCOR Error Status */
+ 	unsigned int mask;		/* COR/UNCOR Error Mask */
+ 	struct aer_header_log_regs tlp;	/* TLP Header */
+ };
+=20
+ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *i=
nfo);
+ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
+ #endif	/* CONFIG_PCIEAER */
+=20
  #ifdef CONFIG_PCI_ATS
  void pci_restore_ats_state(struct pci_dev *dev);
  #else

--Sig_/29FLhPHXSNImZfmVC35++5m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlthAfMACgkQAVBC80lX
0GxaAwf40DMgIHhrN88na26PGrtfmuK6MUDvUNx50N/GLFGDnyN+4IcF5cn9uKpA
K1xWUGQLM5xR9aHeeQJEwJgE8UhzSDOpGYPJOJPkeiLCN40ieuPIX4dMFmPwwf1d
bhQMg01065InQexBrvLNUlGG7Fijvwwv5o4mHH5OMpzSY0t7oWz3K3/BxTesNpmJ
K+SKJEmAerbd8jkFKesU7OD8fQKrUsWrF9Ti3wrKxinWYMD0D3/NWssYTrYcNyCI
s4fB85+0xlll0s0ZtJwFPVd0YHhGl+2IpeCoZ8VpIbDJFhOO70PxgFw5Y+pp5Rmh
scnQz8hiJlzTEhb+QMmscJPu3SqC
=KNlr
-----END PGP SIGNATURE-----

--Sig_/29FLhPHXSNImZfmVC35++5m--
