Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B735ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC66220671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e3TvOqWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC66220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbeGSCpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 22:45:33 -0400
Received: from ozlabs.org ([203.11.71.1]:35293 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbeGSCpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 22:45:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41WHQS3Fdlz9s21;
        Thu, 19 Jul 2018 12:04:48 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531965888;
        bh=C8TgaKqMdU3QN0/BaXfo0cfThNnpvKsqqjYN444TZxI=;
        h=Date:From:To:Cc:Subject:From;
        b=e3TvOqWALMs9oimKnJ+lxXLn6NcNwx37oXdcj/bXVPljR39gAvyp/rey+KvVoRQWO
         gHBQSRhDZEtbDyTnXZrjgOR6ZZLWnVI5wEuW7vmcKxkdUvz/tp/V58WivbEWibgA4F
         nlUuyOZOZW6ac8FpK9J1XFmwZSY5xNLQInemApeA+YJADT6kFKyC/UPDwTZw3IcrPW
         7/ws0Gpyp9V5QpX/b8HCCCoc/VKk4JuaFGkEj7EfgdEwAl29eTQSpOQKKAX2tT7Awu
         IejCExiSypWA8jpU+xaDJVUo6qdUfPbG/J8H6e7wqLUKd13aldZy7R7saVfAYopHE3
         d2iXv6JWkmuGA==
Date:   Thu, 19 Jul 2018 12:04:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Guenter Roeck <linux@roeck-us.net>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20180719120447.6e7ba23d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XvlZXxxCXQ8aWEMxZC.Hr6V"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XvlZXxxCXQ8aWEMxZC.Hr6V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

*
* Restart config...
*
....

This is output by my "make allmodconfig" and only started after merging
the net-next tree today.  It has continued for further merges/builds.

I suspect commit

  1323061a018a ("net: phy: sfp: Add HWMON support for module sensors")

which added an "imply" clause.

--=20
Cheers,
Stephen Rothwell

--Sig_/XvlZXxxCXQ8aWEMxZC.Hr6V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltP8b8ACgkQAVBC80lX
0GxYdAf+P0Em8KecENiUi4Z5IVmYro5pvYQIENjFbQhfjQzVwDd/W5gWogovXjwY
miy2aw7W6M3+2sarrJggq3jeXCrTBe225PgU28YoRehf/Qj8k//HQqtxMEIsqfsc
Yie8/mbppFA7p+xVJs81zqj4h7eW8pP3QGZwco30w0xksJwxWnh/qM1BbSEt8BT1
01ISuqORnG2l6m2AN6TdRvIP8EaJcAjnhPm/6dyPSyEhEjCItoloXTQq9/6gfjoO
mx9oC6lVnhx/fi8DdKGIxdSoI69qy4pkHeQsjd+lulu4nxHdJ/exoOF1ew6m3vQY
hRRb1qgzLqysVgn3knauPC/FBu7PbA==
=E/kj
-----END PGP SIGNATURE-----

--Sig_/XvlZXxxCXQ8aWEMxZC.Hr6V--
