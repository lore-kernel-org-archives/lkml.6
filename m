Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D00C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EB920880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qp95VuCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EB920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeIKHor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 03:44:47 -0400
Received: from ozlabs.org ([203.11.71.1]:45287 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeIKHor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 03:44:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 428Tq439YGz9s55;
        Tue, 11 Sep 2018 12:47:44 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536634064;
        bh=zX7NgDDBaFpHqbO4JfHXJIgvSYvCEvXNz5/3h2fahNA=;
        h=Date:From:To:Cc:Subject:From;
        b=qp95VuCTzk3Y6YJqJ8Vt8F/P4cTkutuTBoaXPO++WHzPSIWL43zQc41c2QAuwft3t
         SdQJtAgWDKG9oodc1jzK7EUbl3AUAWPc12n9LS9P8+EaojVkig78jvrPiYAwinh7xv
         UAh2YEi0B4ZGh7djfZ4VTsqF83Hd3HUPYMQ36uMMF2X6UKMh1ZxuObs8nG22B1/WeH
         THn9GTQtdzz+UF8Bq6O6hLHlYuTCE3k1iZwUB0HZp59LgfgttTbCryFHlmkOhoNwre
         RgqgvGi5n9dwh+R0Ut5MveEz/9p9DwXmwNs9sSiEPHIEJYz0x0Lm7yGbdKS2Qu30Zd
         ZqvoUhc1GPEWA==
Date:   Tue, 11 Sep 2018 12:47:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: linux-next: build warning after merge of the usb tree
Message-ID: <20180911124743.558e33dc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D1pf8ILWweXZDQrFaO_cBaq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D1pf8ILWweXZDQrFaO_cBaq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the usb tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/usb/core/hcd.c: In function '__usb_hcd_giveback_urb':
drivers/usb/core/hcd.c:1741:16: warning: unused variable 'flags' [-Wunused-=
variable]
  unsigned long flags;
                ^~~~~

Introduced by commit

  ed194d136769 ("usb: core: remove local_irq_save() around ->complete() han=
dler")

--=20
Cheers,
Stephen Rothwell

--Sig_/D1pf8ILWweXZDQrFaO_cBaq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluXLM8ACgkQAVBC80lX
0GxIlgf/ekYZFA17PJk+ZyZuBXoKSpfWB+WuboRiecqivjf9ickArJHJ4sieVlL3
M9bwahP8+VYOIaTa/vYvjRyAdDWneUefF7FyCFIhQv2w9rC1pw62BDVzmLAf4M0o
wkP6NhiFFj9DGqxexvOLVOo3y7ydnsvYdctZCl2iN4ndftE+UWBpCoQJKyeO4JlR
1qW0xS7SdGVXK/PDASb1mmciPI+CeFxiYI1DT7LwEvDpaK+gDewCYPwS1yWlIxYi
V70aYaVSJn91Aycxbln1ukDcuzaGSqekqeibkPtmPAfkl7/raGgzkoN/KoX5TAIU
pG6NH0wVlKl9K4inNzRLiEhpzS7pNQ==
=0ARp
-----END PGP SIGNATURE-----

--Sig_/D1pf8ILWweXZDQrFaO_cBaq--
