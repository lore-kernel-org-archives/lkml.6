Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0578BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96CC20855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Im+vCGpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfBKFYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 00:24:42 -0500
Received: from ozlabs.org ([203.11.71.1]:47953 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKFYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 00:24:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43yZ3W0VGBz9sBZ;
        Mon, 11 Feb 2019 16:24:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549862679;
        bh=MOxZO87G/CFolz3Rs92S2mX6oE0UfTZpZwGCnyfzc5U=;
        h=Date:From:To:Cc:Subject:From;
        b=Im+vCGpGtcbdBCgGMor5Tkgty0Iu+iIAh/s/sP2X+LdeVYo7abvjU97HiV0ruyQrF
         Jk8wMpx3Ehz0foRVWzHw2WU1KAdv+JGgu3CHzInbBLjWvSlHIZOauQAXTLvwIwvuDB
         inAtLTTTXxENPMn7BUzEc1P8mzOk6ehvc/3tDVE+p2y+yGwT5qgIXnlZWeSgiBHfKr
         c9h4UIGv17yZLx5wySW6hAvcYEHSeHDDmdTieXwGuO2DD6JeqC2clk6E9BgusqLLpj
         I/8Q0QmIZ3Uz9kyzLC7AWfXmc+Tpd0jFtn4QA6AS68iprT4GSjRtnxuTNhot+TmXj0
         71tJv0VF0PD8w==
Date:   Mon, 11 Feb 2019 16:24:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: linux-next: build failure after merge of the rtc tree
Message-ID: <20190211162438.1112c0ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WzvQmp36pyL4..zvstGkkAV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WzvQmp36pyL4..zvstGkkAV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rtc tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

ERROR: "rtc_nvmem_unregister" [drivers/rtc/rtc-meson.ko] undefined!

Caused by commit

  21358403bb29 ("rtc: support for the Amlogic Meson RTC")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/WzvQmp36pyL4..zvstGkkAV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxhBxYACgkQAVBC80lX
0Gw8xgf9HGjTc5BrkVt73NlhX5cAxTYyvHS4J6dt4f4pcgF8jzNaePNcCfEmaKtB
kXB/xajWMt6TPO12okQgSRwbhVzF/uUVtBGyU12+q2BvoLvvl0hmxO/wv2JUiQ+8
7AToNkkJhHLiMAFKd78gO8GxLXU/KBBKsabwiHgPJk8GhLy1/9l9RNWL/khbBa3E
Lcush/ZLHPhaf8bC3SgOoo1R4eU8f/m5xsxO0hzCe/7Ji6PPvSBJ+soqneJhJ862
Xb2SV+E8i9YKJhAameBAtAKGRiRkqWBTLQCkmqqax+7s8lJF0oObtPa30nhL3CcI
sc6Fpx4tYIGAJURMOS4yoaOsOrwJqw==
=xrwp
-----END PGP SIGNATURE-----

--Sig_/WzvQmp36pyL4..zvstGkkAV--
