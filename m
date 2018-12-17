Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA243C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACE120672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uKLD798T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbeLQIYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:24:44 -0500
Received: from ozlabs.org ([203.11.71.1]:56397 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731737AbeLQIYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:24:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43JDj354rPz9s8r;
        Mon, 17 Dec 2018 19:24:39 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545035079;
        bh=WI+9GxzMnl4Lr9lqFRqHpSMAtaYfYJFpOC1Qgi0b/W0=;
        h=Date:From:To:Cc:Subject:From;
        b=uKLD798Tuw/MQynXfhq9Fm4iLXs+ynmuN0D6BweZWZcdpNfWxmRwF+zzePs6U0MGP
         ZBJh2iQ9Smud4MKFKn89H7+xYQ+CwhGS7QhbGCdDCNVNLGgut1IQUu/8XyvS/xOmlB
         0Cz987qhvujtuTwsCkc4IEU9yEM1lsy686qgwGDFCzDpRNaGXqlosmRNJGqRR8UdIl
         vfDqfdpfIwk60HgRde3jXfaz4zKSxsXA8EzIHT1138HBDqtl3/J4i8+L8kj5Bqa+/Q
         SmqwXOCxD0M7qjpu6y+f7vlacXeGwubXkRaMYOelFcbAGywPOc9zoJHOAtAkTOTLV3
         QrlASLkkpQ0Yw==
Date:   Mon, 17 Dec 2018 19:24:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the gpio tree
Message-ID: <20181217192438.1741a2b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//=Es8H68pJaXDVtiirsyCdZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//=Es8H68pJaXDVtiirsyCdZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the gpio tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/memory/omap-gpmc.c: In function 'gpmc_probe_generic_child':
drivers/memory/omap-gpmc.c:2174:9: error: type of formal parameter 4 is inc=
omplete
         0);
         ^

Caused by commit

  21abf103818a ("gpio: Pass a flag to gpiochip_request_own_desc()")

I have used the gpio tree from next-20181214 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_//=Es8H68pJaXDVtiirsyCdZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwXXUYACgkQAVBC80lX
0GzZQgf/V6a3Y2VGXxA9uo2cGp9vr20/7HG4cJxiXTecU+XwNszgzpzFueAbLbM5
6mGuFeIxEbkS9dYk0RdRIaGJTCmDVm6Mk7UYifwpnPJllsSXxVxgJ3aa1tM86I7V
Sry4+jsduwBDFRB93yhCMF0jvt+DEE+oWaVpkbGZ7NnwBefSHLdrpregFybjlgvY
J/1C9/xUHSuMYbAQvbBOff+42aQ2opTgBQNtjGU/G/ksdC23vyKjsqRfZL//JE+6
xUQi46/bxM/TxnBYo8VRB14MxyoHFLzHGENvMbfozmP0Gdj5eFvq3BTjbg+v0qF7
HGqLm7eM6yU7WW9wM8WS8rvjYnuSyQ==
=IOXC
-----END PGP SIGNATURE-----

--Sig_//=Es8H68pJaXDVtiirsyCdZ--
