Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FB2C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A2922543
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A2922543
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932875AbeFUXT3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:19:29 -0400
Received: from anholt.net ([50.246.234.109]:58986 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932170AbeFUXT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:19:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A7ADC10A1642;
        Thu, 21 Jun 2018 16:19:27 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id jRHQjpbrf1Yk; Thu, 21 Jun 2018 16:19:26 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6D47A10A0D3A;
        Thu, 21 Jun 2018 16:19:26 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id CB9062FE21D0; Thu, 21 Jun 2018 16:19:25 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Kevin Quigley <kevin@kquigley.co.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hughes <james.hughes@raspberrypi.org>,
        Archit Taneja <architt@codeaurora.org>
Subject: RE: [PATCH] drm/vc4: Enable the DSI module and link before other enables.
In-Reply-To: <C15157EF5067BD40AA5332C0BEB5F4D3079020E596F6@quiclu02.quigley.local>
References: <CGME20180604194448epcas1p29627759e2d8c0b1388c6700a7da77a45@epcas1p2.samsung.com> <20180604194437.13790-1-eric@anholt.net> <20180605082532eucas1p21328ec5bea7d588c81480829f862bdfd~1NhnMydDJ0562405624eucas1p2l@eucas1p2.samsung.com> <C15157EF5067BD40AA5332C0BEB5F4D3079020E596F6@quiclu02.quigley.local>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 21 Jun 2018 16:19:24 -0700
Message-ID: <87a7rnenib.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Kevin Quigley <kevin@kquigley.co.uk> writes:

> Hi,
>
> When we talk about control bus enable and video transfer enable for
> DSI, there is a mode in which control commands can be sent,
> interleaved with the video.  This is often done at the end-of-frame
> and/or end of line.  I've seen this handled in some other DSI device
> drivers.  In these cases, the driver has to look at the frame timing
> in the video and carefully select the number of control bytes which
> can be sent during the blanking periods.  The number of bytes which
> can be sent, is very much dependant on the panel-size and clock
> frequencies... (which determines the blanking time).  I'm not sure how
> widely this is a feature in the DSI encoder HW, and/or implemented
> purely in the drivers.

That scheduling is done by the VC4 DSI encoder.

> To conclude: I think that DSI encoder devices need to be able to
> support sending control data (LPDA) - concurrently with video frames.

I believe that should work already.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlssMnwACgkQtdYpNtH8
nuj6XhAAgldBul9TX+OY/OhzeAsWa+81VWWIec9ruWi5He5U4/UaCRIcr0/wKhop
U3eAYS4E0X8OTcC+s/RqaVHRcmHfTOyoR23OXF2onfyvjibtYfapJ2XJUuGzPpLx
inBoU0XvgONM7LyzkaxaAJ/Y40dQ5+vgOLZEy18W0Mu5QFUHvGu7mqSaI3Fg1LMh
C3HCUJQKZMUuIwFaBfokZ1hPy7tq8SYnb6V5y3QjDntOF+4HYIYUfCZOejHQNw9M
LFxyqf1khrrhgc6sVJYWqasEUPx2lssCGkUHPMeEhXHtV1k5Gpov87QU9gJG5tBQ
M19pGRYAmG+2I5NYTMCWO6KxaGL31bX10KubPgz96FpgBMl/tfnU6/7M4fjvKC/O
+RhK/SFtec5abOk7O3LCM5bEBywWSk8xXYDOoaYh38z8glDUydm4qwIxGFODJwBK
TzkQfkgxirq7ElGjmAFgqWOWPTad0t/pUe+oQOu9YP2iAKVKS+XftpsGXImFvK/V
2l7JxzNkHRe+y7Pq1KZBUMZQNG91a2Z7P1hUjbmcFYDDR/cLCb9qpkJi+iWdVWN6
Eq9MpqXQKv3VwkAjsoSW5M7M+rZe+/jogQXaz4kWMJDgjjm2J3O86uBXfFsU1oAu
Q1zEMuwe4Q4Qs22R4xvEmvsGRAx5jIz/9nwBTbmqH9s0nYN9528=
=Hm3m
-----END PGP SIGNATURE-----
--=-=-=--
