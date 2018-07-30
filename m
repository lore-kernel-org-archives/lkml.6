Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764A7FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2685D20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L+ctxZs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2685D20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeG3K0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:26:00 -0400
Received: from ozlabs.org ([203.11.71.1]:54481 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbeG3K0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:26:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41fCxF2tf8z9ryl;
        Mon, 30 Jul 2018 18:52:01 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532940721;
        bh=O4+PlOTZ/dBLrWrCHvH/sRgVIEu0S5DbX2YmRV9DD1Y=;
        h=Date:From:To:Cc:Subject:From;
        b=L+ctxZs+k6kHfZ96U3EedHkHD5oFeNuyuZ9fldiWYz6fX+9Yw6I1oVPVEdhHzXQuP
         1HnD12beRGu1ENON0unA1mvF5HqpqNZmdrlvjvJd9ElePdSznCiCjv15ZNz5pH8gG7
         tH4jFvyZPUUw92f+PUipnzDxrJ6F7ai8ORy4C4PEURmOju1JifV6UUp2JfFq8L308p
         CYw0XimxLPAhws+YZ3dBC9ztQVE9GWKBKuxFi+VWAtbDr9iZktDJxSMmEdFMV7e+AJ
         8oADQpyUihg5ppY5ld+6Mz4y0KA685e6ojj57z5XSEU8LlbMZSIFuuvjIsybz/EugJ
         u9hNKQ+fcG7hQ==
Date:   Mon, 30 Jul 2018 18:52:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>
Subject: linux-next: build warning after merge of the nfs-anna tree
Message-ID: <20180730185200.0d836ca7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XWlsjm0+0Mp=t5OOkAio75v"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XWlsjm0+0Mp=t5OOkAio75v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nfs-anna tree, today's linux-next build (powerpc
ppc44x_defconfig, sparc defconfig) produced this warning:

net/sunrpc/stats.c: In function 'rpc_clnt_show_stats':
/home/sfr/next/next/net/sunrpc/stats.c:258:32: warning: excess elements in =
struct initializer
   struct rpc_iostats stats =3D { 0 };
                                ^

Introduced by commit

  c3b588a2d5be ("sunrpc: Change rpc_print_iostats to rpc_clnt_show_stats an=
d handle rpc_clnt clones")

--=20
Cheers,
Stephen Rothwell

--Sig_/XWlsjm0+0Mp=t5OOkAio75v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlte0bAACgkQAVBC80lX
0Gw/owf8CE6TE9bsTADqIAWVTxGUpzn2SlUKxi4van7tpNKAsBjuzZcAbDpiXZtB
ocVzdyKSA7RMJd92vSLIl+fb/au8HhW9Fm62YwZ5AJ8WbdVVpESxfWYprE/BKpl1
kgt9g9rVa2QX9tfP5k0OxDcpOnmiBOWIlLbcCoNIF4RhlO5IjuLcKitLvm+6RGHa
+SfRDPPQv/5kNO7Hk9Lih4IWpVScfazq3zNPNY7Cd4bIXZ5xmYZLEVSW7jnv7tu2
pNQz/ARNzBnnLUNZ66wcUe2wWfHtycWvwpM76K5sYfeRbeKarT2+BWhMBS6x9d8b
LRzdaexcD8qnbm3EPNlcl+IxymzBhw==
=Nxfx
-----END PGP SIGNATURE-----

--Sig_/XWlsjm0+0Mp=t5OOkAio75v--
