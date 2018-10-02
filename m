Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613ABC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110E120C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VO089c8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110E120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJBHG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:06:29 -0400
Received: from ozlabs.org ([203.11.71.1]:46099 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeJBHG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:06:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PKgx0qS0z9s3x;
        Tue,  2 Oct 2018 10:26:04 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538439965;
        bh=LnJOZ0e3X+pc10WWEsBtcF051jKd+YkIgO8VzvYiSjI=;
        h=Date:From:To:Cc:Subject:From;
        b=VO089c8IlVkBAMfibtc8mJmFnllyxkNXFIyzQPEabRu+UdN79DoieLKtlzDKbzby3
         pP/2dBJW/THF2fnEjVE/jkq0YoJpo5i8YEauo3ZhwtYENJXCCMYP+bnI4tpv+0vR4l
         Zbjujfsw6+xtRQpP2e+kmBeX7k8N988ZKQIi0s5qPPqG2trJmJRKgQIBgIYDKdL6V5
         TbmW7EQ2N9G9uWhmyGa44mm9YjNsKmfDYvhPSEXbv0trJbkaeKBMAarUApO6072w3s
         GuIXFLAf+MNfypZwoeKH7WZ82QmUQPmbzKcyuAyorsmnY9Vxmw3LP1I3RFiFJS61fh
         YR/gPHJbPg74w==
Date:   Tue, 2 Oct 2018 10:26:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: linux-next: build warnings after merge of the pci tree
Message-ID: <20181002102602.53320db6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XU1FcePTKC6WYDDLfFv5kRM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XU1FcePTKC6WYDDLfFv5kRM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

After merging the pci tree, today's linux-next build (powerpc
ppc64_defconfig) produced these warning:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_io_slot_r=
eset':
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11102:6: warning: unused vari=
able 'err' [-Wunused-variable]
  int err;
      ^~~
drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_pci_error_sl=
ot_reset':
drivers/net/ethernet/intel/i40e/i40e_main.c:14230:6: warning: unused variab=
le 'err' [-Wunused-variable]
  int err;
      ^~~

also from the x86_64 allmodconfig build:

drivers/dma/ioat/init.c: In function 'ioat_pcie_error_slot_reset':
drivers/dma/ioat/init.c:1255:6: warning: unused variable 'err' [-Wunused-va=
riable]
  int err;
      ^~~
drivers/net/ethernet/sfc/efx.c: In function 'efx_io_slot_reset':
drivers/net/ethernet/sfc/efx.c:3824:6: warning: unused variable 'rc' [-Wunu=
sed-variable]
  int rc;
      ^~
drivers/net/ethernet/sfc/falcon/efx.c: In function 'ef4_io_slot_reset':
drivers/net/ethernet/sfc/falcon/efx.c:3163:6: warning: unused variable 'rc'=
 [-Wunused-variable]
  int rc;
      ^~

Introduced by commit

  6dcde3e574b2 ("XXX PCI/AER: Remove pci_cleanup_aer_uncorrect_error_status=
() calls")
(good subject prefix there :-))


--=20
Cheers,
Stephen Rothwell

--Sig_/XU1FcePTKC6WYDDLfFv5kRM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluyuxoACgkQAVBC80lX
0GxBSwf+PSzcm/mq0Rgw6V4T0EYlBpzthldt/7pgK9W/0OOS31U+Kg92MGE/h3UN
i1EqTfTpn4QruIdjcYrbljHTnsODIFq3OvVasSOhuw5JPF1e5Ct/644ZmsYcWmKk
QxxHtYmLvYhuwumIr01m2EEhoawF+3gNZ8RvxiU/n7EDMW0OZeHrAICr9S1yzehf
0TmnNSTI1MKpMbRiTamF0EUmqAVQc+xiOkGy7EuTiGHsVLuK+kv4Dif5yPK+lIVq
3EkPJo1QdEstuEpED4XX5tkHLdeX3POeh2SqcRiZgOeMG5FvE92gG0uGhvCga8t2
hHAr6A8AZjw4S7nr4FIP+p9K8H6gVg==
=rsZz
-----END PGP SIGNATURE-----

--Sig_/XU1FcePTKC6WYDDLfFv5kRM--
