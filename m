Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9307C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF162087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UwC6Mhij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfBYIAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:00:41 -0500
Received: from ozlabs.org ([203.11.71.1]:44423 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfBYIAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:00:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 447Ds21XHZz9s2R;
        Mon, 25 Feb 2019 19:00:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551081638;
        bh=70GdZmnR+LHYle9/TnVC/y1PpFTkpDJ+Q4q9GyujYqk=;
        h=Date:From:To:Cc:Subject:From;
        b=UwC6MhijF6YZLuplQSX6zi0ObEzpqCKYtvNurwZ0hYivtE1d5HX4u5FW3OFG/yi1f
         fKwj6blUKQJdSGg5nj8Qjl/WhEXTWrzIkB4IKN5jY4e3eaqXnPCKAXlTR3iIcTigtC
         4l60CvlX6YW1m7tYp9L56T2Hroy4wbZe6Cm9uGWR9XTt0Qt0spn0F7wUtjLSvKDf7C
         CgCG6L+2KuSigHYa+uhrZLOUtI8fKm1Xmw85/VGUSb+tA8exVs1FGip/ou87M441lu
         FA+ska1H8qufKQhxxq2t62Ex3Q6mwyP+hq/75YzlTT7b1yx3qs2s9vLmhKuMjWq9zB
         5UbQX7I9Erpnw==
Date:   Mon, 25 Feb 2019 19:00:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190225190034.0cad4e3d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+eE9o=RAO22YcHqlnU8p7X7"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+eE9o=RAO22YcHqlnU8p7X7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a638b1d8cc87 ("net: hns3: fix get VF RSS issue")

Fixes tag

  Fixes: 374ad291762a ("net: hns3: net: hns3: Add RSS general configuration=
 support for VF")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h (%s)'

--=20
Cheers,
Stephen Rothwell

--Sig_/+eE9o=RAO22YcHqlnU8p7X7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxzoKIACgkQAVBC80lX
0GxBpggAhgGK6bijkh0RiWclJTK1zRkfY1qhr3oqhxgdjnoZJbUFL/dPXlwB5/Fj
RZGnOTkvs/MsVC7tpGx34gWxKLM48/uxCbLgqRJ0iCtN4KN9uxS6wUsjbGrhAar6
5u0UniFTIpvXs1JvVGfEA2Px1B9FSisixH+khaciEgSsfoJpkojXiOcCcFWpwFpD
wEbUf/cQ87954Ve2m0pBP5MGz+FM+YEXlkTiyVdOFoJfw8sz+1s7v6Md73+9N7lE
JRyCnOYbCtWHY/Y//PnbR40MKaqeNaMKW0U9gE029cAQlqXj1L/n2+1pWcEWzJrm
mItJFqaFYFeSyFsQbfIl8IztpePVZw==
=Nmow
-----END PGP SIGNATURE-----

--Sig_/+eE9o=RAO22YcHqlnU8p7X7--
