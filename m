Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7B07DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D71208D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fFHfxmHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D71208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935842AbeFMWOB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:14:01 -0400
Received: from ozlabs.org ([203.11.71.1]:59027 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935315AbeFMWOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:14:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 415gyF4x7Vz9s1B;
        Thu, 14 Jun 2018 08:13:57 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528928038;
        bh=FL1D3ROPCQh8WJyI6YvGwT5BC7lnvhmbNVPGOa9S3n8=;
        h=Date:From:To:Cc:Subject:From;
        b=fFHfxmHMyCPRQensOJxxKzWHTgqwp0osbIIx7NQl2tcB0fybYrd4rjUFaLs/5E57A
         WKNnWoiW8ZWqK6UY661vuv3drIZSOhJGHGJlAKtY66j+0KM2CMyK1rL532TbmA5E3y
         gQkZ5y1ODE+mfVrY6UuH1N7DVf7OESnNWcktFh5Q5fMqDTXTeGIw5usk0ntttnjw5Z
         fDMT4eJWehfu/fMU0pMECRMki8CTGZv5pajqeHXYw+3sLhmtXBitfEN5gmHSMhwUYm
         3AOn4LVwlDQ7gGbw/DktxzYrdqAOF9HucaGshUS/OP90xzKJLdz8J33lqSGWSW+g8i
         ILM60nHvbrDlw==
Date:   Thu, 14 Jun 2018 08:13:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikhail Malygin <m.malygin@yadro.com>
Subject: linux-next: build warning after merge of the scsi-fixes tree
Message-ID: <20180614081350.690b3c62@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mPL_Q6YQA9s9c+g=evzb9_+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mPL_Q6YQA9s9c+g=evzb9_+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Martin,

After merging the scsi-fixes tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

drivers/scsi/qla2xxx/qla_target.c: In function 'qlt_schedule_sess_for_delet=
ion':
drivers/scsi/qla2xxx/qla_target.c:1227:22: warning: unused variable 'ha' [-=
Wunused-variable]
  struct qla_hw_data *ha =3D sess->vha->hw;
                      ^~

Introduced by commit

  5b10177e2dd8 ("scsi: qla2xxx: Spinlock recursion in qla_target")

--=20
Cheers,
Stephen Rothwell

--Sig_/mPL_Q6YQA9s9c+g=evzb9_+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlshlx4ACgkQAVBC80lX
0GwNQwgAjJB3CubIlBjpeRWq+LWn6W34wa0ZC6FzuOHxWUD1YNmB6PyrAP/3d9Ps
sX9hoPGSYvjzYJ1tDRNCgj+VAfLFQMaWH8ZCg0+1KKSPIJSDLOPHgCUf9BXJZT+A
ar7BXvkL5ZCekhZmKnZd5cGydt6JfHlJZnvVk+ToyqPFK5MrZB/XaDSdELBxoVIs
Ganvy4hGWs5FamR8BHUmXiPS/DSnGrNc9dycADX1Nz8tYNUrEsLCp7TVsn3CrdoU
i9YvflHTJ9Ok+IjoliAjpa0qvw2ZHLhdX4Oco+NZzg42Y09Yv7ASgUi0D7ui34aq
jzxhoncAd//MztQoNDhRYhLSpvpWew==
=e0Ax
-----END PGP SIGNATURE-----

--Sig_/mPL_Q6YQA9s9c+g=evzb9_+--
