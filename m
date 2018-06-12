Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9BD05C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 02:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD102089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 02:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RQlbXGDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD102089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935102AbeFLC0q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 22:26:46 -0400
Received: from ozlabs.org ([203.11.71.1]:38315 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933545AbeFLC0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 22:26:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 414Yfn45WXz9s0w;
        Tue, 12 Jun 2018 12:26:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528770402;
        bh=Qd7Jf/5pgFsrqB+sXDqD91Dxgir9NUHqESJfXVx57fc=;
        h=Date:From:To:Cc:Subject:From;
        b=RQlbXGDVjJWxJCSeTqd+MQ6H6MiRKCbccKSrXvm+jNbhF0mtdxBykMuVFG4oQL8/K
         Knzl6y8GPNzcsXfEaHLr9pKkbRfX02LHIPVlujpzykir0vQOIpeEZKYHAfeeOHqjsm
         uUrPF2egLGZKue/0dDWNRMUEiTCcaQrmX/3CcprZqppYteTFBftjk9OVncHKI/tdP3
         ZCMvXsLkN4r9djDHVjB/+lH3eq3pNgO+oRqERWowLYdR041ia3hnPXY2UgODQSQesT
         8aMJcdHXE3R0A5g+kg7D4polOch/OatCvd/SFbLpKxNseuVkEkpMG7YXg2AiQv3ZMZ
         YKCdiNLRbftMA==
Date:   Tue, 12 Jun 2018 12:26:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure in Linus' tree
Message-ID: <20180612122640.534118ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VyhoGSrerE.YtOd2YUrq1u0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VyhoGSrerE.YtOd2YUrq1u0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Building Linus' tree, today's linux-next build (powerpc allyesconfig)
failed like this:

ld: net/bpfilter/bpfilter_umh.o: compiled for a little endian system and ta=
rget is big endian
ld: failed to merge target specific data of file net/bpfilter/bpfilter_umh.o

This has come to light since I started using a native compiler (i.e. one
that can build executables, not just the kernel) for my PowerPC builds
on a powerpcle host.

I have switched back to my limited compiler.

--=20
Cheers,
Stephen Rothwell

--Sig_/VyhoGSrerE.YtOd2YUrq1u0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsfL2AACgkQAVBC80lX
0GzhhQf/dCEFz2naJA3Uwspxm0fioygm5jpmhvUMa/Mo1QmtdG06VRt9nbQQ/bdw
lLb/2l/rDp2cl9wXPjWOZnY7nJPvsR/sIw2D1Gi+ZaeWn29nojZ6KmE+bqeJHMIZ
+ecFo4+aa9MHJjy4X7Inig3q4zwfSFD2AuFHX7aoabcBqbYb73xhOYP72CQH5qiV
K8mz97TZbKTbaVyoeb7N6tbnhyZxZGpKrbuG/uRoE7JJJZDlxMG1FuJZoio3LBJl
UQVpWrtmOqy4ZAj2o9zH7yfcUiC7NUsKJXHPns1GqChNlZr67Hh6Y24oqEQA3fT0
2m1c1Isw4u+jQz3EpvOnjiefN5pVVg==
=f5hV
-----END PGP SIGNATURE-----

--Sig_/VyhoGSrerE.YtOd2YUrq1u0--
