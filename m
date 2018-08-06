Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076F2C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BDB219A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WehfCMcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BDB219A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeHFERR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:17:17 -0400
Received: from ozlabs.org ([203.11.71.1]:44733 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbeHFERR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:17:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41kLhj08VNz9s0n;
        Mon,  6 Aug 2018 12:10:28 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533521429;
        bh=Ekhcf6nBQuzTKVnuozw68DJQvVT4NLKRiU1yQrwjROE=;
        h=Date:From:To:Cc:Subject:From;
        b=WehfCMcQKzPOyBSplTKzoRm7fPYhnj+dGXOqd95Y5XwurEsZu2DdJ8Hp0f915p5wK
         RUr8DX2wlIGZ70R4vffmA2R2+YzjvbZXu2oFl51HxYtEGb7Dgc042dht3VCw2QIRYy
         ojdxMEqrx4pwM90JfVBmE2qyxyPoCuPgOy0oLwI0pGJdgUVPbv70I4Ga0GKeNhGCCd
         fs1p+M/zy1k5A+ixV/eVqM8w5qbUtrss9cjj8p4cq0x4PPYuvNAu+rcLsGhl9LtnGf
         sp2/S7Ua+pqJ7AyWE1F8NvRjWHJLfRon/KuapdFWTs9bwG6bnb85bTRdHXs0gNHGR0
         Lt4EvPiBdNjVg==
Date:   Mon, 6 Aug 2018 12:10:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20180806121026.7c4b956b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nUutFw4bxDjgRFO=yUac+tY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nUutFw4bxDjgRFO=yUac+tY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/ptp/ptp_qoriq.o: In function `qoriq_ptp_probe':
ptp_qoriq.c:(.text+0xd0c): undefined reference to `__aeabi_uldivmod'

Caused by commit

  91305f281262 ("ptp_qoriq: support automatic configuration for ptp timer")

I just reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/nUutFw4bxDjgRFO=yUac+tY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltnrhIACgkQAVBC80lX
0GzTgAf/U0HdKmV+qnw8Yf3Xuwx/7jubhhVRj/4gRBcp62G4pPEcTFfjHbHPqjsa
Vm4MDhzPsqlw+ldhBlxMQGfC8V+2bHfpNbk41HjdnBTXbwM9B3ZcLRNvJnI8ZTiW
2TqALUNnqF4aEpODQFaOQLTlenipWuWC00XuBPL9o1dewc70HP8hTaNeA7/Xh/T7
lRp4gUsQN+1F1ZjW62nHm+3BuwkeRebzWCBZi7lD58n87DDmjHm0tLXeUMVzJyQx
OWmgBk1xdzysEALE7+peT4S4/CjuFZQYmVqvm26Ysq8qcaGbAaeqb6zopu2cbNPr
0DsyCZWnZSwlAcxuAaEZxXAMusD8KQ==
=yMFq
-----END PGP SIGNATURE-----

--Sig_/nUutFw4bxDjgRFO=yUac+tY--
