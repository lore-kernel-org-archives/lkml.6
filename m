Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2198EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA852403E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j79LVi2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA852403E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeGEX4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:56:55 -0400
Received: from ozlabs.org ([203.11.71.1]:37067 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753254AbeGEX4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:56:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41MFBq5Bgtz9s4r;
        Fri,  6 Jul 2018 09:56:51 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530835011;
        bh=88ul4CspG+0m4WhwnYhcrMIkC0mm3LEOkUttSjG1Qnw=;
        h=Date:From:To:Cc:Subject:From;
        b=j79LVi2RzcLb10K5/Jbjs40LhjWTTqQJjNKnhGE/wDDWKXDDOsMPCWmFpEt31WYrP
         q4SJbo3VucTjC0rMeSAEyP8t3FTMtLr1L+Hs5gcBZ7e9Igfu26/ubEBNCLXSfgsRZK
         LL6O2EyQ7bADtTti86Hdb3E0cv+flHhBL55W5M78dxeMdxQADaWz8xDTIsOSwQzpV0
         LIhX1+xuf1TqvD92CbRBUD4EKd3llZeNSDW+DcN9tAu3fWHzVoOH4nIoi9+tNKtWHE
         PmE70TEPfa1LSlECQ+YMSIu7+0Gf36wvz5IaNuoYmIxYDyChmrFhtdRpS79qdGueVI
         OxfiGWGbBDLiA==
Date:   Fri, 6 Jul 2018 09:56:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Moshe Shemesh <moshe@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20180706095633.676b0229@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K9k_pTU7s0mPZXgVpOGNQM3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K9k_pTU7s0mPZXgVpOGNQM3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

In file included from include/net/dsa.h:24:0,
                 from include/linux/platform_data/b53.h:23,
                 from drivers/net/dsa/b53/b53_spi.c:25:
include/net/devlink.h: In function 'devlink_param_value_changed':
include/net/devlink.h:771:9: warning: 'return' with a value, in function re=
turning void
  return -EOPNOTSUPP;
         ^
include/net/devlink.h:769:1: note: declared here
 devlink_param_value_changed(struct devlink *devlink, u32 param_id)
 ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Lots of these ...

Introduced by commit

  ea601e170988 ("devlink: Add devlink notifications support for params")

--=20
Cheers,
Stephen Rothwell

--Sig_/K9k_pTU7s0mPZXgVpOGNQM3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls+sDEACgkQAVBC80lX
0GymwQf8DEsZzHSHyIO9VebCreLVFNdlT/01smaCGgxLrbnPuucMzZOMI7MQDiDD
VKinJZCquD58LAae4PhYKjm2KBQCVK0g0Hx+liDdLOeiMPydHZIFRXJdJKOrVEZu
TQkOBDC4/sq2Vxxv6h/zZkfB4OEObxrt4zitJGo5uM+bxwf2CLDqhfpuPB9CjYch
1TRRj3ag71TO4TbQDv3H+PsNmNShmto7SkEAYcDAjfJI8QhbtBsod4OjbJF+8O1X
cinhm8hS0Qn7WYTxKrZdNs2UnHg0AwEPyrXD/le2jjOw6a4REoiJPH1zwKDoKnoO
+c+v7Hh1kznfDKdxp8maJXLPvwI4bg==
=Qv6D
-----END PGP SIGNATURE-----

--Sig_/K9k_pTU7s0mPZXgVpOGNQM3--
