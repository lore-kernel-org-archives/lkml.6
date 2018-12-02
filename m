Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B26CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D1220834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJ6h23Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D1220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbeLBI7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 03:59:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbeLBI7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 03:59:03 -0500
Received: from localhost (unknown [122.182.223.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0032080A;
        Sun,  2 Dec 2018 08:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543741140;
        bh=gok0awTkCPJCGa99wg89/I4VcnB8tebRLdwnurYYL/c=;
        h=Date:From:To:Cc:Subject:From;
        b=vJ6h23QyI729chNcBF2QL+nWg6Y2yaikGdhlUapoM/HCfavfxONHu/K+hb7Qz/w6H
         cCm6/RdX1JNgk1k8uC5JmXg4sQvpvwU/3d5Qp/LFRpsMABF4PqxcBSt6j0A8dykjP0
         Yc95OvF3wo1z6CIut44IDBnjwdcGMy8k7z+oZrr0=
Date:   Sun, 2 Dec 2018 14:28:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PULL REQUEST] dmaengine fixes for v4.20-rc5
Message-ID: <20181202085852.GP3175@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the pull request for v4.20-rc5. It contains two fixes (cced
stable) to fix serial dma memory leak on at_hdmac dma

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-4.20=
-rc5

for you to fetch changes up to 77e75fda94d2ebb86aa9d35fb1860f6395bf95de:

  dmaengine: at_hdmac: fix module unloading (2018-11-29 19:49:41 +0530)

----------------------------------------------------------------
dmaengine-4.20-rc5

dmaengine fixes for v4.20-rc5

This contains two fixes to at_hdmac which fixes long standing bus
reported recently on serial transfers causing memory leak. These
fixes were done by Richard Genoud.

----------------------------------------------------------------
Richard Genoud (2):
      dmaengine: at_hdmac: fix memory leak in at_dma_xlate()
      dmaengine: at_hdmac: fix module unloading

 drivers/dma/at_hdmac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Thanks
--=20
~Vinod

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcA57MAAoJEHwUBw8lI4NHpTUP/iyQLuPS/ZjgnGVH1MT4YT2z
O9Vx3NA/6AyJmr3kaRTi1m4OZISu7vob8DHcP2Wlk8XYcB1My41ffUX1NoPO2ES5
aIoKiZlS8vilPJ7WaTcQd+C5OvknSv2RsKj5tQHBms0gfy1VXm0tU6SWpdufeJDQ
517DQe0rcovBBd0iAZX9NwaO0jjHSI+3j/kPGol9BVfJ8H0hlz3ni2qJvGBWiu3O
wyGofLQXd1ybGdzXRe73jQICkQu8U36/twcJpPuDN4xDLOgA8gIX3ZIutzqX68NV
xxZZh3ouXWdGwA5ppVe55GFp+4xdW3XSFWJJbFD2A4ArQCFSq0gm+5ECOY5AZK8N
8BoQ+cf1+KtNly1y/CT+pLmqS8WJ5YoMihqFrTamN8oOFgNXPWdcxPXkzp6igmyc
sUaGZ2ShNoNe+tp59gUKY1mZhAPFDnwS3R0AsmTQ+Llwn1VomSeATS9Tih8QiacU
IMOB3+d2egBZYIOha3papuS4RfnmoMQFNo+nNIvYXH0o+AbWzdJqfrT2xr3s9YPa
mOqsmakFf2xvMTXphAZOlAD6r0CizlBBfh3UXbOGZKcanmIpS26UuL3fbOQLS5F+
6S9z/25/ABxOpetGIqNguIrAIvSp5do9Ak3N+z/kcYQha3+En7GZmtkqCBZEmnwQ
n3/w9L8KNcWfxnsZDLk2
=/0V7
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
