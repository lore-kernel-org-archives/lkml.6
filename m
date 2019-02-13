Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03007C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B801F222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BKnvBE8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbfBMFy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 00:54:26 -0500
Received: from ozlabs.org ([203.11.71.1]:47015 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730072AbfBMFy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 00:54:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zpcp5H3lz9sML;
        Wed, 13 Feb 2019 16:54:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550037261;
        bh=Ep6x3INC03RHBg8Nc8NqVb3MWYHD6EKeMtLDHfgO1No=;
        h=Date:From:To:Cc:Subject:From;
        b=BKnvBE8Uz5370QaDQFQLbzUSFFKV5sxAkSbOivujjwoZMCHHEaz+6TOw5W7lVS+Z1
         WHrFgFZUWmlfe8fBv7TmthayPWfJqBIKjbMP85mh/nNNK3ekVYNbx3bZJZCVSJpP/y
         uP09gPVdF2EkW7pRWCWdg7GywGNzB/ro1Pi5vlvaXduV43y0OGJYOwF3frWyDXyElb
         UGi9X3DyHbRRFkx2jfoVrSVT+V493MD8ffZ64CksOhnuwJW3u7LML1c+ckr0M9UsE3
         TZGREKNQFsG/DGJM/LidZH71rqaobuAmBx5K7qCgL84Byx2+lJMTc8z5gN7zKj0n1x
         tHydZ+WOYyAiA==
Date:   Wed, 13 Feb 2019 16:54:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alin Nastac <alin.nastac@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>
Subject: linux-next: build failure after merge of the netfilter-next tree
Message-ID: <20190213165415.5a992838@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/H8=D_/BOxF_SwYAG=cgyHrp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H8=D_/BOxF_SwYAG=cgyHrp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the netfilter-next tree, today's linux-next build (powerpc
allyesconfig) failed like this:

ld: net/ipv4/netfilter/nf_reject_ipv4.o:(.opd+0x78): multiple definition of=
 `nf_reject_verify_csum'; net/netfilter/nft_reject_inet.o:(.opd+0x78): firs=
t defined here
ld: net/ipv4/netfilter/nf_reject_ipv4.o: in function `.nf_reject_verify_csu=
m':
(.text.nf_reject_verify_csum+0x0): multiple definition of `.nf_reject_verif=
y_csum'; net/netfilter/nft_reject_inet.o:(.text.nf_reject_verify_csum+0x0):=
 first defined here
ld: net/ipv4/netfilter/nft_reject_ipv4.o:(.opd+0x48): multiple definition o=
f `nf_reject_verify_csum'; net/netfilter/nft_reject_inet.o:(.opd+0x78): fir=
st defined here
ld: net/ipv4/netfilter/nft_reject_ipv4.o: in function `.nf_reject_verify_cs=
um':
(.text.nf_reject_verify_csum+0x0): multiple definition of `.nf_reject_verif=
y_csum'; net/netfilter/nft_reject_inet.o:(.text.nf_reject_verify_csum+0x0):=
 first defined here
ld: net/ipv4/netfilter/ipt_REJECT.o:(.opd+0x60): multiple definition of `nf=
_reject_verify_csum'; net/netfilter/nft_reject_inet.o:(.opd+0x78): first de=
fined here
ld: net/ipv4/netfilter/ipt_REJECT.o: in function `.nf_reject_verify_csum':
(.text.nf_reject_verify_csum+0x0): multiple definition of `.nf_reject_verif=
y_csum'; net/netfilter/nft_reject_inet.o:(.text.nf_reject_verify_csum+0x0):=
 first defined here
ld: net/ipv6/netfilter/nf_reject_ipv6.o:(.opd+0x78): multiple definition of=
 `nf_reject_verify_csum'; net/netfilter/nft_reject_inet.o:(.opd+0x78): firs=
t defined here
ld: net/ipv6/netfilter/nf_reject_ipv6.o: in function `.nf_reject_verify_csu=
m':
(.text.nf_reject_verify_csum+0x0): multiple definition of `.nf_reject_verif=
y_csum'; net/netfilter/nft_reject_inet.o:(.text.nf_reject_verify_csum+0x0):=
 first defined here
ld: net/ipv6/netfilter/nft_reject_ipv6.o:(.opd+0x48): multiple definition o=
f `nf_reject_verify_csum'; net/netfilter/nft_reject_inet.o:(.opd+0x78): fir=
st defined here
ld: net/ipv6/netfilter/nft_reject_ipv6.o: in function `.nf_reject_verify_cs=
um':
(.text.nf_reject_verify_csum+0x0): multiple definition of `.nf_reject_verif=
y_csum'; net/netfilter/nft_reject_inet.o:(.text.nf_reject_verify_csum+0x0):=
 first defined here
ld: net/ipv6/netfilter/ip6t_REJECT.o:(.opd+0x60): multiple definition of `n=
f_reject_verify_csum'; net/netfilter/nft_reject_inet.o:(.opd+0x78): first d=
efined here
ld: net/ipv6/netfilter/ip6t_REJECT.o: in function `.nf_reject_verify_csum':
(.text.nf_reject_verify_csum+0x0): multiple definition of `.nf_reject_verif=
y_csum'; net/netfilter/nft_reject_inet.o:(.text.nf_reject_verify_csum+0x0):=
 first defined here
ld: net/bridge/netfilter/nft_reject_bridge.o:(.opd+0x108): multiple definit=
ion of `nf_reject_verify_csum'; net/netfilter/nft_reject_inet.o:(.opd+0x78)=
: first defined here
ld: net/bridge/netfilter/nft_reject_bridge.o: in function `.nf_reject_verif=
y_csum':
(.text.nf_reject_verify_csum+0x0): multiple definition of `.nf_reject_verif=
y_csum'; net/netfilter/nft_reject_inet.o:(.text.nf_reject_verify_csum+0x0):=
 first defined here

Caused by commit

  bfcf40da7559 ("netfilter: reject: skip csum verification for protocols th=
at don't support it")

I have reverted that commit for today.



--=20
Cheers,
Stephen Rothwell

--Sig_/H8=D_/BOxF_SwYAG=cgyHrp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxjsQcACgkQAVBC80lX
0GxC8wf+MmMGIH9mmr0wQOs8NTy3WJcrktXmDoZjBkv8gAwNOen7TkzmfjddeDT9
Z6jYcPQ6pnBSZyCif0UORURYJMGPQMCtvIwKGnHMno5d4rAR5fkbwDsNdbFwBs+S
ldZ/8nm7/UrS6N7E4l1jLgyhnukTn3DKYqBlDK2tLHP+hRFHW9E8P4bEVjW55R65
e2E7Nt2791qeRQu46aO+BCiKsP8D5L10qkcvSDu3q5p4gsGAj0+P8dsT3UHlLPjO
yiIVgLc9sMHWu0Q//EL/XEd/z7I62tYNOZ1n9Rx1UGSEH75tCFn95/XeuT+GfEP0
t/8w9w5iWM6kfXBSBRepaBns4C91bg==
=FgFO
-----END PGP SIGNATURE-----

--Sig_/H8=D_/BOxF_SwYAG=cgyHrp--
