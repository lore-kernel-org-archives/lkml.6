Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C6FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C37206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QMUxOmFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391097AbfBNDCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:02:25 -0500
Received: from ozlabs.org ([203.11.71.1]:40335 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfBNDCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:02:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 440Llx3qG4z9sMp;
        Thu, 14 Feb 2019 14:02:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550113342;
        bh=HNRvt3QATlvK8pd4PsSDXaoE7Uh3nKEjFm+rR3FWzRA=;
        h=Date:From:To:Cc:Subject:From;
        b=QMUxOmFhR2Ug6Y2W8wZ1eGIBgtZPAYl/Sh7pFxlniFUoeJacXzog8PpVr0Auf9CK3
         tpqKix+ROlKsUAJ4+XmQIR+/+OAmLmSoFeOVq07uwl9S0Qb5LuB295TNQeSqNAOGno
         TyPY1wRwTuE17vHNv/2RChcUKV0YwWTrNJYOjT3tcYHaqSYUYzRIBaVeNW4Gk/aJy1
         HsvRLz24904dh38Eg3BTaomtNmMWj8no/BFNVdQoHE6AMr9RokfeW2OdNzbwqy4k3G
         lMTFZqwMGXZ0H/3ETL9Dt5OnyPzQwC8SiJrpeu6VjEKdVcKrHzpG3hG50KG2vrit+w
         F2O4xXs7Sznng==
Date:   Thu, 14 Feb 2019 14:02:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Otto Sabart <ottosabart@seberm.com>
Subject: linux-next: manual merge of the devicetree tree with Linus' tree
Message-ID: <20190214140216.72ad7d4a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bZa23S7X0eEOjYpMr4pLIK_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bZa23S7X0eEOjYpMr4pLIK_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt

between commit:

  8217724eb7c5 ("doc: bindings: fix bad reference to ARM CPU bindings")

from Linus' tree and commit:

  36c79bc7ef79 ("dt-bindings: interrupt-controller: Convert ARM GICv3 to js=
on-schema")

from the devicetree tree.

I fixed it up (the latter also did the update from the former, so I just
removed the file) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/bZa23S7X0eEOjYpMr4pLIK_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxk2jgACgkQAVBC80lX
0GxHcQf/ez6DQIB2UzdcaZhNK+qTO/5Ub80/5h0dAEvGW6cTVB1UH44slklwFh6N
F25gkr7fKuBzJNI4y8FcXD+joQX/KwT9cYrV2nbKP1pY9CEpOJK1c0hi7vq6tqtJ
2p956b9NDteEi0oNRusQyC0C+Wrtch5WzLUXedJgiqQk9YWfasQmUlvurCe7Z7Kl
3bM8IggXMOOjdqNBBh3qdSdozZIwWk6jCC92nLOzM3PA1i1wEFQY4ZkcciYc8XXg
rVvm0xpO0wjZ6boEN118aajiguhdMcN1PXVzX2hiCnOvqnokYISRo8HoBiDe+KYb
7d68k2PuTTacj7zuiq2KWmg3KeJuWw==
=FgvM
-----END PGP SIGNATURE-----

--Sig_/bZa23S7X0eEOjYpMr4pLIK_--
