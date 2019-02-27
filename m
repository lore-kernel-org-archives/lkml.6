Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60ABC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAC0218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NVqha3y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfB0CUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 21:20:09 -0500
Received: from ozlabs.org ([203.11.71.1]:45929 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729527AbfB0CUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 21:20:09 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 448KC95Mgqz9s21;
        Wed, 27 Feb 2019 13:20:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551234006;
        bh=3KUjOd5YM5bIKabNhMiN0XN5Lrrl+Qmc3dk0ZC1XAzY=;
        h=Date:From:To:Cc:Subject:From;
        b=NVqha3y/Mz9tV1lu3IS5t/tu/Ak83fjtoZInFwsy6o35PbiOILemLx/6I6lJ5F31D
         EsP1obW/0+L71kaCbH+P/rG2qqF+PWomLXl9Embm8+7uoI5ciZfLF2cI+tuVSYStiL
         zaSuCQ79PcdOoEIaTJ+oRuVUZ2/ZZOfSHYx08SYN3+eA9sW09v0hyw7SWaNe77Wiqy
         XESpAqin9n/VcJ0WmNQ5IOVSlsXthOSMSR/hhrZBC8Y8q5aQOR/YfcsUwakW4DekK9
         98o9xhlrPna7aj+sIHUaDzSHMXcHfknxgUv0INkcY2Eotb7f392h9RByjtlrFGUUMs
         NNk7UqEEiDaQg==
Date:   Wed, 27 Feb 2019 13:20:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: linux-next: build warning after merge of the iommu tree
Message-ID: <20190227132004.4d3a3da4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ezeCYBum=Iq9ezBpZwWBF6+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ezeCYBum=Iq9ezBpZwWBF6+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joerg,

After merging the iommu tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

In file included from drivers/pci/pci.c:32:
include/linux/pci-ats.h:70:12: warning: 'pci_prg_resp_pasid_required' defin=
ed but not used [-Wunused-function]
 static int pci_prg_resp_pasid_required(struct pci_dev *pdev)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required() interface.")

The non CONFIG_PCI_PASID version needs an "inline".

--=20
Cheers,
Stephen Rothwell

--Sig_/ezeCYBum=Iq9ezBpZwWBF6+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx189QACgkQAVBC80lX
0GxdKAf8DbcfYSLMKlKP0orGWyczZk+rTFfiLuN2m4Hq+QvaUo95ST9AmAJ7EGcY
gQduiIbC6zcoFg7V3+1cGo98KLX4gepynYET64c8CuY4ahTgncZ6PxXiYwC6Ga74
FKKPu5WgvsJDH//Lp0ztJFuMevJMYqaqErN+HFtSOo+rGvurFuTqSgUAuDysadls
QsFFsS04NxS38SNyxbo2hCjtBFkoxNRWjlFto/wBC9JnqfPi9XARCYh5/Xh53MH5
8lDSw+P29Vv9MB1zeaZHeA7IaYtK8H3brqLCRgKnM0i6tCAuKcey2+b+Y2zTSYAx
fLFHJMDYiW58SCkWomO37fm9+4yhCA==
=jpbv
-----END PGP SIGNATURE-----

--Sig_/ezeCYBum=Iq9ezBpZwWBF6+--
