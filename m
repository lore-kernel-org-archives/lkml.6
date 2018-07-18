Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C6FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DF42075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uHkF5aCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DF42075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbeGRCkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:40:00 -0400
Received: from ozlabs.org ([203.11.71.1]:49965 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730774AbeGRCkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:40:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41VgSc3z96z9s21;
        Wed, 18 Jul 2018 12:04:32 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531879472;
        bh=wAUwF66QqRjuOgoOvvvoX72ZGCjqLCNTvTQx2kq/t8A=;
        h=Date:From:To:Cc:Subject:From;
        b=uHkF5aCvXc0fSjiA3wHRsVoWRcdya77Ci/9iHbXQtckTOJ5EcpqdHqfQTtC7zhkN9
         wgUYz9epuAehb9x9eTcxT7g3nFcu8PhC+WSp7aoTaPln3hWgCG3fjgb7+lUgbtSHZu
         IAnN1qTr1+Y60GEiZbiTu8OPHE8Mdt4pkhFNd9tAxagR3NX8p6XHaj0MpY0WPA0cTj
         dCBwfVaOiHXkx7UgPvwyr54ZUr+rOMLSRbtI0d9GBZe4zTFoLrQAPqFyerhd19+4Zr
         knRyGHNDbTNf/5sjYqNZmNs8BhUuKHse1xzmdy4Bkox7BaQpyP+nMB7s3boKTmJQA6
         WFqrVDSsL2oMg==
Date:   Wed, 18 Jul 2018 12:04:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Simon Horman <horms@verge.net.au>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the ipvs-next tree with the
 netfilter-next tree
Message-ID: <20180718120431.68189264@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/s5py6xYsqSWVfpA8CYdG42t"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s5py6xYsqSWVfpA8CYdG42t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Today's linux-next merge of the ipvs-next tree got conflicts in:

  net/ipv6/netfilter/Kconfig
  net/netfilter/Kconfig
  net/netfilter/Makefile

caused by commits

66c524acfb51 netfilter: conntrack: remove l3proto abstraction
5a733aa21d2f netfilter: conntrack: remove get_l4proto indirection from l3 p=
rotocol trackers
e33ae98088b4 netfilter: Kconfig: Make NETFILTER_XT_MATCH_SOCKET select NF_S=
OCKET_IPV4/6
35bf1ccecaaa netfilter: Kconfig: Change IPv6 select dependencies

which appear as different commits in the the netfilter-next tree (along
with further changes to these files there).

I fixed it up (I used the netfilter-net tree versions of these files) and
can carry the fix as necessary. Please clean up your tree wrt the
netfilter-next tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/s5py6xYsqSWVfpA8CYdG42t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltOoC8ACgkQAVBC80lX
0GzRGgf/Ta8owGnIo1sVmxDMkWaCn24X0i20Jn/gCu3H1VkYL8W/q5eibxFgqU7W
CLXbpDpreMsjy3Jf5lO5+thtrhHPmvIvvkBiuuWfjcM17pPcdtHT+yfySU/iQHzG
tSSyjD5gtve1vbiM7RG6DdeQruz+Pu0ZNlXx17q8aLPPQScoOz26FFaiaRGTOAJs
VaM85Lzs2PiDmytNqVPcxzBpA9YRXoHmjZF2Vk93xRj+hGmIdLoEOS7/Ll4KVD+U
0zRyIFONOwYBBpiN8LMoGX5JR97ghkNrY4r9arGB2GqSDqZBFEjtHa3fhBZ7UDgS
zeSQLAlkzaWFVBWwwqrckBz8zH2aAg==
=n4ju
-----END PGP SIGNATURE-----

--Sig_/s5py6xYsqSWVfpA8CYdG42t--
