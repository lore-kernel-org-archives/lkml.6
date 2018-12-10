Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C642C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 03:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E5F2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 03:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L8SeP0js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E5F2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbeLJDn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 22:43:26 -0500
Received: from ozlabs.org ([203.11.71.1]:36725 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeLJDn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 22:43:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Cpnl3qldz9s2P;
        Mon, 10 Dec 2018 14:43:23 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544413403;
        bh=YXGWnNErFgdigwDAg5TtcRSnEcnVzN1UmooQRnpLhtc=;
        h=Date:From:To:Cc:Subject:From;
        b=L8SeP0jse2pgNXxMpECui5B1IcAYWg78zkyVOkdF49KtuvV+1UmvacJdX8t4leHt9
         iqE/pW7cZTfukiL9XwRRwUhFTtNStMddSv93KZMny/X3Uc4mQddkIUi1wqTWbJNFy7
         MuX08veqqoBmhHi+ac5wRXS6U1ZrIt8JzzeKIu2Ui11mjSRIfuQ4SrwooDn8SIY7ZL
         WdOYazDf9/fTGG75ppS9uZ4CV3GVhnoOUc1XPShb+UqFeHFG3n98He7u6Cq/Tq9Bzh
         Cd61Iv8xKpguM6+JVjtbfA265C4AEKWTXyLyUSokULVb9EkqMdjC/SKldsX16Thodk
         7nX3FlG8zQDoQ==
Date:   Mon, 10 Dec 2018 14:43:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the device-mapper tree with the block
 tree
Message-ID: <20181210144322.11a94d25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/q1Kzo215pGJ.Yz=WAKt/TmG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q1Kzo215pGJ.Yz=WAKt/TmG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

It appears that there are a series of shared patches between the block
and device-mapper trees that are not the same commits.  I assume that the
block tree has been rebased, while the device mapper tree that was based
(or includes) part of the block tree has not bee rebased (yet).

--=20
Cheers,
Stephen Rothwell

--Sig_/q1Kzo215pGJ.Yz=WAKt/TmG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwN4NoACgkQAVBC80lX
0GzgFQf/Z2uhvvJPpOXS8XrLFxX1pyCbkodorwcp5uWcu75NJjCBPIF14IJgJnAy
5MDfbhriOEW5ofrzWsjUSIOyXusWNZv1nfIRP1cMVOb4x8ijDaV3I1BpKojRHmCz
IlbiRk37UrK6NGjBHjZB6M5C10Q/H4VbRFYT8WxZe70xzhwyRHjLRSYrAe+tqTcQ
Yb0UBsEQ4gMryFgah63xCOVDb6n6XwyyFu88S5Jv/WptZo6qaEvCAoFNE0CRMOy8
4B627C2z1EKq8sExN06CByiCRMCKaVvb79nhf8KuORGDGQZsry6eoHFMHjoLNZWj
fF8MT4TWXgmECMz3hRdtXlZ/BX3VWg==
=l2pd
-----END PGP SIGNATURE-----

--Sig_/q1Kzo215pGJ.Yz=WAKt/TmG--
