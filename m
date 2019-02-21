Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01D9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4B420818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mqAFs6pE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfBUWRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:17:42 -0500
Received: from ozlabs.org ([203.11.71.1]:50353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfBUWRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:17:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 44583l6B05z9s6w;
        Fri, 22 Feb 2019 09:17:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550787459;
        bh=Z4YqYdLtY2sGZZBQNqtAnuHFWM2OyVpWFQy9Z/V/WEU=;
        h=Date:From:To:Cc:Subject:From;
        b=mqAFs6pE/UKRWRRWbByzirMYWGPJxJxePF8QisPxMY8Qcpjo0ZwBYj12+6bBGaZU8
         UCsu6fiXa6Lz/VzBULHjOO+jb8Nbzg5PfNQcKDBioHJayrYnKWrPc5kKg81F15qTbf
         Ypvv9u7H076kfj0aFQK2I0Ljv8jrZ55UnE0P6F3w/zR8ztwcVfkXNLf6v0ox9WJnNf
         1QIxodTpMi8N1SDjzFX9XRA9LDNSO1vU/hrY3FtMUk5zeKYgKKlygRLyudhF979LJ7
         md/Hirdc4PcPI5XChllkOKCHF7TUwDo2p6N8gVlbHhv38qGRpDzL15roYx4ILUJc6V
         Q3TLjsxSTpR7g==
Date:   Fri, 22 Feb 2019 09:17:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the powerpc tree with the dma-mapping
 tree
Message-ID: <20190222091728.6d3d9877@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ok17N8/ya7k8hwIQAwaZptq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ok17N8/ya7k8hwIQAwaZptq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/powerpc/kernel/dma-swiotlb.c

between commit:

  cfced786969c ("dma-mapping: remove the default map_resource implementatio=
n")

from the dma-mapping tree and commit:

  68005b67d15a ("powerpc/dma: use the generic direct mapping bypass")

from the powerpc tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/ok17N8/ya7k8hwIQAwaZptq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxvI3gACgkQAVBC80lX
0GwCLwf8Cs2kNsCKIdpn1d0w4LHBA4HAlvsOfuZgHZktoG/FprY7Yi1Z/1zHEehJ
jUvUjJN9x6Ml6oTk6aunNl1vFIXX3BvtUz4NAmZF+tSY3ycnHJ8CT76QjOPzzeH8
dgnKqzM2RwkgJ0H2ZwkRwr5KVjM5ZVVyqJuzBsMbi/iaZoKIxWI+gc9pI3jPz1fl
47x3wE4KxhI/eu/LKb3lTNgFuatwNqlWYd+mV411VyuXiWBqsuCsluT5vsVWOFfd
nzJlEfcBdZ5q20piok04KZItnCHOFB0trw0BpbBXawTW/6ml8AbY3QNJP/BFhMmx
zU6xpU/5SNGeDu5rCTkHMacnq4Zd/w==
=VWkj
-----END PGP SIGNATURE-----

--Sig_/ok17N8/ya7k8hwIQAwaZptq--
