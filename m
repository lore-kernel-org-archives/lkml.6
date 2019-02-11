Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F14C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D30218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h9dPXdTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfBKWRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:17:31 -0500
Received: from ozlabs.org ([203.11.71.1]:50243 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfBKWRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:17:30 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43z0X809BJz9sCh;
        Tue, 12 Feb 2019 09:17:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549923448;
        bh=4SZlHDpjfyelc/K+K+cweed7HHm/CtdtAlwcEFRpWXE=;
        h=Date:From:To:Cc:Subject:From;
        b=h9dPXdTD+OwymIsPEhJxLqbXEVJegYIngjEzwDXTFCrHJQFA1jbLCJlqZYSMa70o9
         w5jff4c4nr3rmI1VHO73uUNGviBgJpVAowgBVsBdj50OH1FHV5pMLUQwcqHyCBXxAb
         WX1rYE5XygmwxKHjwfx7+87e+1LJaiKwC/ry+qGSHo39JiQLJ6QV8bgPCzWh0PvMrK
         rz6ggWEb7UFa2vt/zFtGAk83Qd/7VDEhq4n4byE02Cyv2AjKn6uzRvaIyZ/t8Nr+J7
         KcOkfM1nvmoU0key74zSjaI4anputk5F57cGLzzg+uZC7f865iyZrHvC1yl9XXms7t
         OsXB0RDoNRIxg==
Date:   Tue, 12 Feb 2019 09:17:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tristram Ha <Tristram.Ha@microchip.com>
Subject: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190212091727.7d93c434@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZhQK5b7Id5CuJZbQFQzBtZc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZhQK5b7Id5CuJZbQFQzBtZc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  cbd72b485214 ("net: dsa: microchip: add switch offload forwarding support=
")

Fixes tag

  Fixes: c2e866911e254067 ("microchip: break KSZ9477 DSA driver into two fi=
les")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/ZhQK5b7Id5CuJZbQFQzBtZc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxh9HcACgkQAVBC80lX
0Gy7xAgAmmxE5wiWpWzlTueRN60hAi/njjm9WqT+Di1IAh854T6c0Q5GD75CyUZF
Kz4zWkaCFFBudI5jPQCOTP5xlw5IFrDYwJKQiPejt8rzJTYV0K31gQK2TA8aYZJA
ZYfDrp/ZykK9z5twrzCQNAVk6XBevV9No5kaV5qMB8XkOrOLzu5D0TyXv98w4qzJ
nyeeCRVW9eIsffaDuB8vLOjTqf2pbucKZssOvTfJFaFhDEYLLTs2qzbFbsTqQPWQ
LXDNfHTQ877SIZwwyGyA/qq7WxJDBLuK5NP62kB/isalYo3Zer/XleCaXJniyATd
/VqGvIV+NEoKNKrTbGdJYS2zuR7CBA==
=caVa
-----END PGP SIGNATURE-----

--Sig_/ZhQK5b7Id5CuJZbQFQzBtZc--
