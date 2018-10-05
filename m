Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635F1C64EBC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AD820834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GGQl0k65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AD820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeJEIeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 04:34:03 -0400
Received: from ozlabs.org ([203.11.71.1]:59891 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbeJEIeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 04:34:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42RC765GRhz9s55;
        Fri,  5 Oct 2018 11:37:38 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538703458;
        bh=ftvUqutCmcKAVqRxOanyK3tNoJVdj2r3FbSvtDQ5ZNQ=;
        h=Date:From:To:Cc:Subject:From;
        b=GGQl0k65DG/IsqKt7AqgHUmpDiBtL4VWRkTOgnUn9sbXxQmC6ktH7DGwZB7zrnzuR
         krT6pZLU8uqxklYrdkNwFU/QXDa4HEyVFA8z+JJv/i9r0hRKyfaT7o2IHMKEiUZyKY
         BmCx0TOJA+SFICi8f+SR1zjf52T28hPL3nZSytS93+C9Xh72dy92lV8akjp7VRsUQ8
         biRI3dzAisBagpJGSDnepSRi9vvsiVyUgcm9MItgFVagCeog/fmSDOHeMJbLqzZ9oy
         B8kLeAiT3VXkBHxCRvrXd032+UoSEHpHdcHdIP/H/tujUlH9PmQyt+b0uEJ2PLGCtJ
         GDu4dnin940Cg==
Date:   Fri, 5 Oct 2018 11:37:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: linux-next: build failure after merge of the drm-msm tree
Message-ID: <20181005113738.2b7e4e1d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Oz9kFV2PSTN=zeTbT2o+FQo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Oz9kFV2PSTN=zeTbT2o+FQo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

After merging the drm-msm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arm-linux-gnueabi-ld: drivers/gpu/drm/msm/adreno/a6xx_gpu.o: in function `a=
6xx_gpu_busy':
a6xx_gpu.c:(.text+0x70): undefined reference to `__aeabi_uldivmod'

Caused by commit

  a2c3c0a54d4c ("drm/msm/a6xx: Add devfreq support for a6xx")

I have used the drm-msm tree from next-20181004 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Oz9kFV2PSTN=zeTbT2o+FQo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu2wGIACgkQAVBC80lX
0Gxidgf+Ppqa+xCk9sv5wXIDA+911gYtrofBmnT5373qGExkr4Bwip1FDBXh0vTp
6Wx9POoVrR2OZoBhlWHKKyN7uLdMfpEEMncw+zh1rnZJehRey3b6O/0FM3PLkFxf
BEYGpp2X7+MbKVQM6w2OXcWMxYoJKMEdAV/+g/61kwOj3cu5K3P6E/QzNR+KJgOm
58nrml7s/Yu7arwYh8hteTRvpzb53fDx/htmvpREFCEjK/xn559r/BYN3ZYoKhvz
UO5tEqwR0/Sb3K/9udguObknzZwiE0zjfPV1nOQSZAW4zhMRIricXTRAG4S+6xtW
XxRHKqYF9iR3ArN1jUoBoavG9o6Hpg==
=tWOy
-----END PGP SIGNATURE-----

--Sig_/Oz9kFV2PSTN=zeTbT2o+FQo--
