Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E373C169C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EBD214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ayBKhekg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfBDAMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 19:12:49 -0500
Received: from ozlabs.org ([203.11.71.1]:39715 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfBDAMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 19:12:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43t7Sr5ytGz9s3x;
        Mon,  4 Feb 2019 11:12:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549239166;
        bh=QPqD958U79tBu25eO1grrMMjgarroz5q0ZYQhbMODlo=;
        h=Date:From:To:Cc:Subject:From;
        b=ayBKhekgUu9Wp8KN/vinLHrK9JlBdjYGwdq22+5tM3qz/vRll75zAKZ8PdldySORv
         xpkWcs4ZWhJqghSL01/D6IDmKXHI1kp76Xgjm0clXQYRTcdfeRkB1RNSNZ0N/ziUg+
         x6w/KXelFlrBthPgaIhvyIPMCbgYIY1DQjK63nqB3gJ8aco1+RaoxjSu5Cnr0nF2pt
         sZMk40bUEUygiv8prI74I5AEJ2KfyGuMmcgJj0UutlVtxhhloNIvdZhzSe28SgBuTW
         yObFCfYV/8jtdEbkyHIxWo8HU9aVpTT1I5mg0SGSaPKnSHbFqNcuio2ZA9uNtZwy5n
         rZ0b3izpPJuIg==
Date:   Mon, 4 Feb 2019 11:12:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: linux-next: build failure after merge of the drm-tegra tree
Message-ID: <20190204111241.278b6215@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vuFuZpYzUppTel1lu9266P2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vuFuZpYzUppTel1lu9266P2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

After merging the drm-tegra tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/gpu/host1x/cdma.c: In function 'host1x_cdma_wait_pushbuffer_space':
drivers/gpu/host1x/cdma.c:279:13: error: 'struct host1x_cdma' has no member=
 named 'sem'
   down(&cdma->sem);
             ^~

Caused by commit

  abb289796799 ("gpu: host1x: Use completion instead of semaphore")

interacting with commit

  db5652be58a9 ("gpu: host1x: Introduce support for wide opcodes")

I have used the drm-tegra tree from next-20190201 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/vuFuZpYzUppTel1lu9266P2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxXg3kACgkQAVBC80lX
0GwI8wf+LvaaP1f9ZFNpFhIxJODXYdI7c7W3nDdHP98jBZNCqOIncX+NIDl5MJPG
IqQd4MzqijCIjR1+i+PsHwXi2lNCbvZRum0DQYpBKOmRUx3KkLF1bnO8TyiekLLx
doSjwKRK+7PF9AnQH9sd/pLzLOSc7MTR81fTsFU/fJHdySkJVae+otJf8ZzD7e8/
KnftByXw5KrM4e+PHnZXI+mIcU3hr5q0WjP4bGYfdG6tQwMH7mzpI+t9xoPMkVds
+izkY87r277gPbs7oapCcRUqcirB7Gy3LRwGIs1wUKP70ojqIjGs62sE1m7clWi5
f/BtCRHsgjYhmoBdvJcrkgY0xgHY/A==
=Cr3E
-----END PGP SIGNATURE-----

--Sig_/vuFuZpYzUppTel1lu9266P2--
