Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606E0C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2986620881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="o7vyR96R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfAaXZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:25:51 -0500
Received: from ozlabs.org ([203.11.71.1]:43749 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfAaXZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 18:25:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43rGZ35rSYz9sMl;
        Fri,  1 Feb 2019 10:25:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548977148;
        bh=Sby+/3KuREUTmcKXW1SKuDO0Z5Puf8gJtD6BKnfvud8=;
        h=Date:From:To:Cc:Subject:From;
        b=o7vyR96Re3NlUrplwQ4v2zxomMiduvYponlrdqYFxn7I/f+AEpFxxgX8e62L5Etwf
         yMZ6cXpoamCVkCmlO72E8wJVYUjIUZ3qccPpl9eMI40yl8MRSNuWFYdb9DEZsWZLCJ
         i2BMEi3bGsZ+m+gHR5jrKcixDGqzOukLTGxTxB/ixyTQp8XLZPG73hXUvAKwj0Tqvt
         PdWV6nMiObLY5ajw2BNHivPqFbHJHhSzAh538qwb9J7gMjh5+PhB00b0GWnWvhgVC3
         AyzIRvNQheVBFW6aJkCYShd83JH87U6DnU6efMZ140HsyoYPPtHCid+ECauSiXyZUA
         uAAQiHhcBgd7w==
Date:   Fri, 1 Feb 2019 10:25:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: linux-next: build warning after merge of the v4l-dvb tree
Message-ID: <20190201102547.1eb9158d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4XDVUjH.35uiijZ++PF2lAV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4XDVUjH.35uiijZ++PF2lAV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/media/common/videobuf2/videobuf2-core.c: In function '__vb2_dqbuf':
drivers/media/common/videobuf2/videobuf2-core.c:1772:15: warning: unused va=
riable 'i' [-Wunused-variable]
  unsigned int i;
               ^

Introduced by commit

  2cc1802f62e5 ("media: vb2: Keep dma-buf buffers mapped until they are fre=
ed")

--=20
Cheers,
Stephen Rothwell

--Sig_/4XDVUjH.35uiijZ++PF2lAV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxTg/sACgkQAVBC80lX
0Gxftgf+MlJVRZ94sc+ZDZOx7dA1tFF7RUvsm1ii9XaUnFiIeBM4lgaj/pqhgwd4
0JjMjkQ0ch8SRfUnMtMwqQmISy7PouRImUQ8+JL2FF52Av9bJXEGEo/H60jLfES3
liG2LZ2NXPza8w9fKgJhiKGwAbCeCFOk8Qaut1dmvmIiZa+kIK/fyv+/qISYCbdP
SNJoxYD2zWPsD2tVPBzpBAtxnbKWpdjoni6jHH36op6J9YCJWtzfBZSqfkvaml4h
655sHFjZLaS75IWBm20N+brNPBASmmHROmt1t1tZAVirtGgEEbIoB54AVKVfUZiA
ctwkbXeG1YXlvoNoSGJE1ymeZeVPuA==
=WDeY
-----END PGP SIGNATURE-----

--Sig_/4XDVUjH.35uiijZ++PF2lAV--
