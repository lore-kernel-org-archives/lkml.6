Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A97DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64C82147E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hoADDDx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64C82147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeHQA6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 20:58:24 -0400
Received: from ozlabs.org ([203.11.71.1]:44899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbeHQA6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 20:58:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41s0Ym6rSPz9s3Z;
        Fri, 17 Aug 2018 07:57:32 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534456653;
        bh=lW5JpBG1UCneSOIzJTtTedIVLL7nBnYoaRZc1CXZZEs=;
        h=Date:From:To:Cc:Subject:From;
        b=hoADDDx0BThdV+7ok5MkQrLff7axNdP5zhieKrsIAwwoA6yWqCLhoKUAULXbmRzvM
         Gb4xq62HZv31n/2WgM/lmvTqf5WcuIw65NFl0wBm911s4khH2D72M8RcFMteK5aUte
         HqdJwPjobXAwlb/4oxTvD4MntEpTNlry9WrocKu8aWv/OrzcsHPsURgloZEL7vB2CZ
         qZVJQ0GHAOB3wxXjimFXdLpWkNnnzq6KWzx0OMU080/BAUruspCzWob4dkekXaGaMV
         NC7VNx/43WwHrzzb+Ih4I/mVOU3nFpewAEOxkL4EpAhdxH82Bd2ZNQR29rWTVTOUvn
         VpVRmNwIpDe2g==
Date:   Fri, 17 Aug 2018 07:57:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matteo Croce <mcroce@redhat.com>
Subject: linux-next: manual merge of the ipvs tree with the netfilter tree
Message-ID: <20180817075717.0bc15438@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5TmRJ.KLaABcun.uJPlj6uX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5TmRJ.KLaABcun.uJPlj6uX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ipvs tree got a conflict in:

  net/netfilter/ipvs/ip_vs_conn.c

between commit:

  b71ed54dc2a1 ("ipvs: don't show negative times in ip_vs_conn")

from the netfilter tree and commit:

  16e98cec49a4 ("ipvs: don't show negative times in ip_vs_conn")

from the ipvs tree.

I fixed it up (I just used the (updated) version from the netfilter tree)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/5TmRJ.KLaABcun.uJPlj6uX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt18z0ACgkQAVBC80lX
0Gz1Pwf/QCcKsgUXw0F6JPwSF3FkvnAHm925RuiF93sCAePZBfZKy4WkEyfr9KBm
HJOGgeZUnFeH0M9IUPpcYMtQyRaeDErtj7v97zNLSqraYiVPhhzTmIVRIt0dSXvy
l5wkTNv9cnbs6mj1CRBn0gq07lLkEg5mz82k84OAay8gL9NtJZLeX/w2Nh5cwBwa
UfimYk9v3xxqCiLmBvCpZTE6JeeS+7bdFhL+7R2qEc/dORAUb3KrU6LOK7ZR4I3r
FKIKlt5Zrj9zE2ehxmeO5pt2h515AoVrjxso35+FJFMz9KUcgkzvBkTwAHYhAN6x
EhR0zRi+EN8tSiZn0P9uIo4pH76Z6g==
=cijq
-----END PGP SIGNATURE-----

--Sig_/5TmRJ.KLaABcun.uJPlj6uX--
