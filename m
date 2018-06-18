Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A894CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5648F20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="atd5JUhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5648F20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754601AbeFRD26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 23:28:58 -0400
Received: from ozlabs.org ([203.11.71.1]:37913 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754525AbeFRD24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 23:28:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418Glq1n7xz9s1B;
        Mon, 18 Jun 2018 13:28:55 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529292535;
        bh=0OrIDBvNQMnV/fApyuiwzz8zPv4/T4bNhYm6fdSt5w0=;
        h=Date:From:To:Cc:Subject:From;
        b=atd5JUhYRv8V+pmpxLUFHxa7rYowhH1ffB2GC2gcAS61QiWAkIkJCe9cAYzoQTa5W
         fxZDc7NcpNR90PHqZd31roASu5X6nUgnEZu2GwUIHJxLf0Kcp5cvtgZsO/VB3NjYBW
         UAtCzKPyglo80RDiuuZ6lw5bno9bK7Tr+FMo397umM3dfQSzt46jST+VOh/OD1rjfi
         ihGxpEQv3hiq4SxM2xRIQwiyA2r93zVfurop7+/Ozl8JdRFU+JP2qGpcg59cs+vDPG
         qCVRKDThGIoUEgvOc0dRnKqSLQu76k7ZmFnxR+mwqKknE8VJ9SOSJnqoKuS9FMMtmX
         AUUk0Ff8bzUWQ==
Date:   Mon, 18 Jun 2018 13:28:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the xarray tree
Message-ID: <20180618132854.4fcf8d5d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K038ToGsmLqBz5vZHXYp4Rh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K038ToGsmLqBz5vZHXYp4Rh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the xarray tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: modpost: missing MODULE_LICENSE() in lib/test_xarray.o

Introduced by commit

  d968f529e39f ("xarray: Add XArray load operation")

--=20
Cheers,
Stephen Rothwell

--Sig_/K038ToGsmLqBz5vZHXYp4Rh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsnJvYACgkQAVBC80lX
0GwEbAf/Yn1C09mAEdCaDOgQL0vLc+JsNCL+YIC1YQ2HNY0ujCzG/FmNmP0F+ER3
5dKRh7FX9jkHFpCbqZFFUNusHNnmIiB6ZY+HnmPUJgCXAfUZpGknqr2BqKmmmtZq
5eahqFl6YungqruYNoMG/a9O9GpNSEzrjJ9FQCZuNx7Pq+TiTjj6/J8QMIsuI5h0
ZJGi6YPrGxAdOfqROSIBs6aMiXSZQzBevuaBVFmeCxZ+AI5uOK3JAZws2Co8CgFG
qE6LE9BMOyZvF7yeSYnqqOxeDSIJf+eGNqVi6EMavaqPmKXDfmKsG3sg4FY1oWph
j8s5CyaamMHcp1oldphUsH6i5FJboQ==
=utSZ
-----END PGP SIGNATURE-----

--Sig_/K038ToGsmLqBz5vZHXYp4Rh--
