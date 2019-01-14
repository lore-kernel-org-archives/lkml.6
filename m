Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97A4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8048D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TMyIqtwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfANBVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 20:21:42 -0500
Received: from ozlabs.org ([203.11.71.1]:52701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfANBVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 20:21:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dG033HMSz9s4s;
        Mon, 14 Jan 2019 12:21:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547428899;
        bh=GppDqh72V2zbXa+nMShxS+aJqFY7bGueJCgkvSnBxCo=;
        h=Date:From:To:Cc:Subject:From;
        b=TMyIqtwJ4nLiNtzn9ebjIQXHcKbH6Ehm6iFTzdBVJkBKsMGt2pIAbIOnNmfg9Ne0N
         j1CGRwVuPLlgTLkZdQiFgdkVIDAv7LFsWPDmjPBAK+xaGYH6mUuQhIzAST+TPsGb33
         vBtGMbIDgXka2QBCSd0lVLXv8Bff/tFZMqQQNIHqF5aAueCwSuF4cwIS8UmtNZR23n
         yPhSq/Qyn8CTFA8jlM1FHUPqb+xF1AtT4eiK+EQUsEGI3E6zGT150/n5ifT1zOWWuo
         gK9Gs22AcD2niqWnbhNauuC8JQG/tBjVEOoHyPSAqSADaLHy4lXIcgb4XaWh2LGTEg
         dpZ8ZWp+qfJ4Q==
Date:   Mon, 14 Jan 2019 12:21:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: linux-next: build failure after merge of the mali-dp tree
Message-ID: <20190114122138.724ba326@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Pl2mXa.vZIUYGfVekdw91c+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Pl2mXa.vZIUYGfVekdw91c+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mali-dp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from drivers/gpu/drm/arm/display/komeda/komeda_framebuffer=
.c:11:
drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h:13:25: error: field=
 'base' has incomplete type
  struct drm_framebuffer base;
                         ^~~~

Caused by commit

  31849148cb41 ("drm/komeda: Add komeda_framebuffer")

I have used the mali-dp tree from next-20190111 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Pl2mXa.vZIUYGfVekdw91c+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw75CIACgkQAVBC80lX
0Gy7dwf/WLObYa5Tex18fs96k6sbY9Q8gfIaLwY5msyM00H9VpAGx1niLFFwIm4v
VysxZ5cbaMRe8Cz3SHI/pg5JmUfLLFm/QymdPtWNEyWX5HrnBQpx4SusE0E3BRYq
g0PW0HaBhiOQjd9/SWuSpP453CSkZHNvr9OPPe2trp5b1SKxTlrg2lUC73ugs2yw
5yYdHZ0qK/msi0iSirPKeJ0gtQTjRUI1IB4HuFkR0ZQpV4FW6VjMHrbGJvKJL4sg
Q5N9BWbduz1AGThf/kp+fp2sCaMPQGvEhCLD1A9g6SgQu+8KRvuMiDsKqop17Iif
78FCJD/rei+2EqpKRc3Yipq52J/rCw==
=PK2W
-----END PGP SIGNATURE-----

--Sig_/Pl2mXa.vZIUYGfVekdw91c+--
