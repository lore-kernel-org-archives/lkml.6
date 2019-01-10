Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D195C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10912214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a4PXxpmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfAJAoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:44:37 -0500
Received: from ozlabs.org ([203.11.71.1]:42629 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfAJAoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:44:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43ZnM43RPBz9sN4;
        Thu, 10 Jan 2019 11:44:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547081072;
        bh=pohI/vJ1VR5CUd0DrbDd+kJZGdW/x72V/4t+JyyADSw=;
        h=Date:From:To:Cc:Subject:From;
        b=a4PXxpmisVTZJxFO6ZABnJ3QDVxfBn0h1ZqU2K7uGlBh0Awm6kp4rqgpX8vF+aYvS
         XZ2rey+3vrcHzdNhC8kD4fCTGGshMHUb4btHEq4JT8NXA+u0XhcBxZc+jzXtj4XAHQ
         hrRk6ecp/6xE0GNYj3zeku++reMJW6aenocJPnjCih0nyUsmkAWqZE2WOC76IeSuWc
         c289j7tZWYTArF0MMlo4cR6dmWIZOFMm5jBH8eMMeKMrfDpVhIKGEgYJPW0iKbNoNn
         LXuW6A9ekT01ycmOwVY+n5ibzUjbEDmqSdJDTcU7VbZqezy8t2k39x0efr9pEqwIYH
         kb1lk9GvvcX6A==
Date:   Thu, 10 Jan 2019 11:44:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: linux-next: build warning after merge of the spi tree
Message-ID: <20190110114431.65b7b129@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Xard+V.h9zHArzGvbhRjPfC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xard+V.h9zHArzGvbhRjPfC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

After merging the spi tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/spi/spi-dw.c: In function 'dw_spi_setup':
drivers/spi/spi-dw.c:400:6: warning: unused variable 'ret' [-Wunused-variab=
le]
  int ret;
      ^~~

Introduced by commit

  9400c41e77b8 ("spi: dw: Convert to use CS GPIO descriptors")

--=20
Cheers,
Stephen Rothwell

--Sig_/Xard+V.h9zHArzGvbhRjPfC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw2lW8ACgkQAVBC80lX
0Gw74wf8Cz5yhnUCwf8fKE03AAZCPU6eoWbUsfyOZ1bJ+YktWl1jOf2ccSR9PJo9
7s+2+UiNSkea8+hEDqU6wT9cEg1JrgFSgskQoxAIyAjQhhtX4O11Bx8Q6BHhSWB9
usoKEhtCsZ9LIeoNXcZhyGpGyeQqhnjbUZ80Sr/UwLV4j3Twy37QlshVkCpXfp0F
2pW182rqy2bZT9T99+cWrohQhK8lRsbO2bCi0krlomR91+LBfQuY+TzSV2a22kG7
YJ+zBxBJFT3Nn7Obl0LsGBT4L9ZmxOkCtqQqphPzwWx/wTYr7U9TPT4MQo3y9+3u
y7wEm/jcB6PIhlZyTtcMHmnUpKxBsg==
=ehQA
-----END PGP SIGNATURE-----

--Sig_/Xard+V.h9zHArzGvbhRjPfC--
