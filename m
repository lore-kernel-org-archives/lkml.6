Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9F5C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C3120855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="g3Tpovin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfAUINZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:13:25 -0500
Received: from ozlabs.org ([203.11.71.1]:32895 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbfAUINY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:13:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43jZx82jxTz9sDX;
        Mon, 21 Jan 2019 13:19:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548037148;
        bh=At844LHIrTkFvQ9Amb3lAWUvXGukHaQVBXKtxws8irs=;
        h=Date:From:To:Cc:Subject:From;
        b=g3TpovinzEourQM4eqVsQNbb9nC5E+22oi+oSP//IYKUCscwF/MdlNprhN3TWkfCQ
         DlBc8PBlfcMInu+3xZVTkvQAV0y19bx5EK7k26eiGih9u0OqJr1mF6xYfh2nDJz9cc
         cqkYSbERvFJg4m3HVjvTCu8Hd3F0FpA/JQPZRKIYko9dxHzQIIrLK3Nocxhj4NMylx
         Age82JeaX+iFHgNL+2AAfDUpKp7bbkChgBxuhmeYF8GqjZNEy1i0E+k36DUAZx61wP
         YTLqbOZfzm7KBXFiQafbDGzLs5ZP6rgCt0KXexJZQomZ0ESuEIVv0qg7Zq0n+vuqlm
         OmjmiOlib0O5g==
Date:   Mon, 21 Jan 2019 13:19:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the vhost tree with the net tree
Message-ID: <20190121131907.67165947@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6CoH0_PjMa07dr7FS08w0yh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6CoH0_PjMa07dr7FS08w0yh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

Today's linux-next merge of the vhost tree got a conflict in:

  drivers/net/virtio_net.c

between commit:

  df133f3f9625 ("virtio_net: bulk free tx skbs")

from the net tree and commits:

  a73c976c635f ("virtio_net: bulk free tx skbs")
  017ed06fa099 ("virtio-net: bql support")

from the vhost tree.

The 2 versions of "virtio_net: bulk free tx skbs" are not identical
and then "virtio-net: bql support" further changed the same function
prototype ...

I fixed it up (I basically used the vhost tree verison) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/6CoH0_PjMa07dr7FS08w0yh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxFLBsACgkQAVBC80lX
0GwdiAf/eNP0gD3Mp5G7VVFw9SFTcqCS3+lX2yeiB24cDDb3srpdmFYclmOCy7wT
1LdTSpZA24k33fBoQrnQDEEpufZ1E+SI3JmNtCOcfos8Wlepwzv5Lw3YAsdV1xB7
GXuy0Dz/snOtcjiRbylE0hkM8WUJW5jv9MVqa/lKUFKVAH0GDsV4p2zUocU/F5UG
RwH1svvbcb/nq+vuf7TkL+vRs1wYX+2wsuZJ1agg9rHTCr1uJ8po1orz6rBVlLyf
VKwXVK9AIyv4K4g1g/ADOMn+t/3+laDp1aAyLYuOp3A3OrFqcucrd70ioVwGOTPQ
fShDS2qJ7wukNDuAcDPjiynwI1YHig==
=0oz/
-----END PGP SIGNATURE-----

--Sig_/6CoH0_PjMa07dr7FS08w0yh--
