Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C43BECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEE52088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IJX7nSbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEE52088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbeIRHXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:23:41 -0400
Received: from ozlabs.org ([203.11.71.1]:40009 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeIRHXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:23:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42DmHG2M6wz9sBJ;
        Tue, 18 Sep 2018 11:53:30 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537235610;
        bh=YV0Ujyq/ReIUS8bUPtBmIUnifnvGxSWwcCj07ctpV4A=;
        h=Date:From:To:Cc:Subject:From;
        b=IJX7nSbtDf3gYg4IG4iqWudouTeNdBNmDNrDnDJ2ADHXOgeNxARuYsfXJVB8/Vpmr
         6yWXKWTElCIvNuk/iHF3Mlz2nryNinsZ4X3lxN5RTWjmUxUmsKQJWSGu0cN+lPT6Gi
         1g6QRJL/CLsBIOyU3DKEbQ/DiDkbBn3s6kaOxnIGPya7/04GMcK4HYfmDnm7zyFpy3
         nKh9jzdJeb3gdVwcmgt5jgDKETm8oEfBSt8kCv9l2L+Uv/KYgZArqNMq9jr+yUn+pT
         yKVgJ64b/LARbksSq1QkFCp0TmUrugltzQcKD8CtAN40doOynT3l3TQCeQImytaZrU
         zX5N6tdqhTmqA==
Date:   Tue, 18 Sep 2018 11:53:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the device-mapper tree
Message-ID: <20180918115329.61fe2b2d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0F8rWZGdeNDm_jTVnFBIBuh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0F8rWZGdeNDm_jTVnFBIBuh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the device-mapper tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

drivers/md/dm-mpath.c: In function 'parse_path':
drivers/md/dm-mpath.c:891:24: warning: assignment discards 'const' qualifie=
r from pointer target type [-Wdiscarded-qualifiers]
  attached_handler_name =3D scsi_dh_attached_handler_name(q, GFP_KERNEL);
                        ^

Introduced by commit

  b8505ba97e0a ("dm mpath: fix attached_handler_name leak and dangling hw_h=
andler_name pointer")

--=20
Cheers,
Stephen Rothwell

--Sig_/0F8rWZGdeNDm_jTVnFBIBuh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlugWpkACgkQAVBC80lX
0Gw4JQgAm1Fh/wfZzO8aZTg0NfCsAr6WBjAbJoERqzRHSsICXKTlSWswaymlgFn/
NnxnR1f7QMsL3tRPuCa6ag+viBIrHmDyTeCxYo0/9yfnw56JLTrlar3Vg0aprzAT
TXK0Qp3kwf6HM6C3DiNZST3V/COupvPs/z9wzUpfFfRIk/OWI5m3vECts4A6WUSn
wDSoiBYls2r7a9N8xp85YhEzTTd6/Xg2cNddEnCRUqSUXy1Aa/Na9Aae2XLCYdAx
QWyRmR8PcH2lMAJXS/dxxyHwCrhqGUKzTkNy9gnwbJ9uU09K2aQLtxnGFFV4kzV1
X+6FCdBus3cdU/HVs1Dmi4sda0DmEg==
=SyQF
-----END PGP SIGNATURE-----

--Sig_/0F8rWZGdeNDm_jTVnFBIBuh--
