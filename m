Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506BCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1592176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ikr5z+3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbeLTGC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:02:59 -0500
Received: from ozlabs.org ([203.11.71.1]:55605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbeLTGC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 01:02:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43L1Q64H6qz9s7W;
        Thu, 20 Dec 2018 17:02:54 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545285775;
        bh=HHThe0YyeK3VuvTF+Oi8T+HQST9uIRon1Y7jHECpK2A=;
        h=Date:From:To:Cc:Subject:From;
        b=Ikr5z+3kmLYOpQhAAZZpU32QzGPpxabTrvFQIhfqOcO7ymIml6+Ca/TuStmGJCpPH
         NynzQylO0X2wlUmFj1uYSFROzmoHilMt9iOk9jRj0h0DjBD1fNSb6Fkkk3WChG25uu
         Jfp7KZ7BRZ+XyPrukDO9umh+5Qv4kP4b1MQcv8bIZNhKiwTdU07Wmx8k5TYP5QL/7g
         1V93wE2pf8BxSCoEjXCp/Nrf4+816Oj9UdULzNN1kVfDbVS/ZcBiLfHeFEzYwRQD4i
         Vn8scXwb6e1h0WCybIAAtUT6+R/F9AmpFcjHrTYFn5fWYgmmX+oSX/CbJWJIB8JhSt
         H9AUW/7JGkaWg==
Date:   Thu, 20 Dec 2018 17:02:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: linux-next: manual merge of the char-misc tree with the net-next
 tree
Message-ID: <20181220170253.011d0b10@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FcrPckkByQ0wbOg4CieH_NY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FcrPckkByQ0wbOg4CieH_NY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  drivers/ptp/ptp_clock.c

between commit:

  aea0a897af9e ("ptp: Fix pass zero to ERR_PTR() in ptp_clock_register")

from the net-next tree and commit:

  b9d93594c767 ("ptp: fix an IS_ERR() vs NULL check")

from the char-misc tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/FcrPckkByQ0wbOg4CieH_NY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwbMI0ACgkQAVBC80lX
0Gxpqwf/e9suOmkMqEGZ7UCtsbut65nq5+m9DPpuEnEH9tilwJOpoxHaTiRNPNE3
jnJIGHlrya2sg6fb2XSia68o+XeotUJBeIO9HD80jd0lNwf39SqKuLyRu0/siJTI
zBv5vNliAHFV4d3aji7j6aqYunYRjFMyXSdTQrraiYigMQBzelfRkHAzqZ+rery3
WTieFyn5sG+0VOFSgoXZLO5b3EZj/4wDvuM2kthYtuNOCfEfMSwBb4yYjLmLX0qB
Kor6w6OkPMEFYymFCO0tI7CRcg/80Q2t7nP/vVVJ5CGGYcuau4ImeHijggP8CWsV
8/PTrGqPSQAmTw0RQyEMsQeQkX7fAw==
=OTdg
-----END PGP SIGNATURE-----

--Sig_/FcrPckkByQ0wbOg4CieH_NY--
