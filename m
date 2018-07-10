Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A57C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42EE2089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YcZmTJ6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42EE2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932875AbeGJGpZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:45:25 -0400
Received: from ozlabs.org ([203.11.71.1]:38681 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751017AbeGJGpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:45:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Pt4J6fQzz9s3R;
        Tue, 10 Jul 2018 16:45:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531205121;
        bh=YvN2QwVqeUnjhSUu2zgUR3cirNZ3PlgV1uCdXhZZmj8=;
        h=Date:From:To:Cc:Subject:From;
        b=YcZmTJ6JIbK7B/oLXHaZ7Mwf5YxGErgMs1Go0htn8Rfhfij02TDQZSH8fMAfTTBEi
         tKTAoI0artgmHH6SsQuxdU27BLOjlIXJIp7h9ZbLjcbxmczNc9wXNNyBaNqSIB5mpe
         IlVfG6gDTk2GXzUr0fS7fHEe5lDAKMxsIoKmIiw44AB2kxgsx3Ad2CMo90iGr95k63
         o659qEQaeGYYe9TCvFPNDR2pICvA637T1P0qMaf8BMcw+cKMczhjdAAVZfu7tb9Xxa
         SuRIKwneW2LS5MPuc8xNFME6TMuB8fJ9vLf9lfjNK+wCBaDAk34Fy8mL0S+lktuon+
         W1Gq6uG4Pf7Yw==
Date:   Tue, 10 Jul 2018 16:45:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: linux-next: build warning after merge of the printk tree
Message-ID: <20180710164514.22c552db@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FURb5/juwPe4KedDlPCpTFT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FURb5/juwPe4KedDlPCpTFT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the printk tree, today's linux-next build (x86_64
allnoconfig) produced this warning:

kernel/printk/printk.c:2033:13: warning: 'suppress_message_printing' define=
d but not used [-Wunused-function]
 static bool suppress_message_printing(int level) { return false; }
             ^~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  375899cddcbb ("printk: make sure to print log on console.")

--=20
Cheers,
Stephen Rothwell

--Sig_/FURb5/juwPe4KedDlPCpTFT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltEVfoACgkQAVBC80lX
0GxQTwf9EZwdtrXMLQwD1/qJOadRHs1fyvT5nyUdMbCPctaMkdIm4Nsyx1lai8r/
oFMjjlMqmwO+YqneRwojhv+nAZ77+CtBURnV7k2riazf3mHcrUjHCzfQ2el5Fgsj
6p3Yaowl45+lTVYa9uEZxs59QWWFrZnfPKdDk8jDFeFppG1N3UHr9rQJm9pis6TA
9rZFucyeWAZAe7wMkbpeKPl8whpVUPXxwDgtgIjiotVg5tKluC7RNcQwLzMbBH0o
u2haX3SDfeqOdxi05Weh4QIXKo7kFAyX3os+wyyUPoIv40uWuhLAf1I6WhdPBdbi
gLCiuK5xrnNYmgxURg7moHUQ+0PzDw==
=bSrM
-----END PGP SIGNATURE-----

--Sig_/FURb5/juwPe4KedDlPCpTFT--
