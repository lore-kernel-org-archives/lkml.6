Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58D5C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86716217B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YVoSMvRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86716217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeHVB04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:26:56 -0400
Received: from ozlabs.org ([203.11.71.1]:49767 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbeHVB04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:26:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41w4V01nwFz9s4v;
        Wed, 22 Aug 2018 08:04:55 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534889096;
        bh=W3Gv7q+ho7Wk3QeyEMdQU1grF0MiLoRS7EXrg8MmMVM=;
        h=Date:From:To:Cc:Subject:From;
        b=YVoSMvRFKnBbgoEAJXbKdvQYsFjHULvfH8ATPlPpxqKiB8w251LRUvuFxSIZuqJ1v
         XVCOgzGu4XylUgExlMbGM4SlrZChNFeJnG7Va8envm8XVEOPYUB3pAF1aEHiScgBBm
         lKXZiHYpSrI5EBVpmCTDrIEDy1MegIy4XK9MwTAUk5vFD8RAtaxykxiu4tzdR1nFki
         WgRAeZKn4aEFiuzYT78Tmq70KXQ98D/4NxW74T93HVgX1LsJ/bNInO+wuAw3ID8IqO
         3p1DAkjgNGKjpUbxpmBRFdM/FNj5YJ4+7G3RMJsIb+FDpll4ukTeZHFDxgZ3TMrRNG
         HiAtLfmm/SJYQ==
Date:   Wed, 22 Aug 2018 08:04:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: linux-next: build warning after merge of the net tree
Message-ID: <20180822080449.5887e244@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/u73I2CAj_0XHU31A_03DG_W"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u73I2CAj_0XHU31A_03DG_W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net tree, today's linux-next build (KCONFIG_NAME)
produced this warning:

drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: In function 'tc_fill_actio=
ns':
drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c:64:6: warning: unused varia=
ble 'i' [-Wunused-variable]
  int i;
      ^

Introduced by commit

  244cd96adb5f ("net_sched: remove list_head from tc_action")

--=20
Cheers,
Stephen Rothwell

--Sig_/u73I2CAj_0XHU31A_03DG_W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt8jIEACgkQAVBC80lX
0Gy9rggAmgoFDJxS7tbYirshdBLQulKP16+xv8mZTJ6WJgM59HmkaodNsvjYgQfj
lJ7derYeOUQHMglKON+nNzMKWcSC1r8GGW/LudBY2CI7jr6V7C1o+FTtHUB80n8O
dY0i4lFu/R/K6/bYFiDBdl825Obr08JP8bZkdQDOE/zcSEgSxios51CTMjv4e79/
f7h/gmiW4p5obZNkqTIP3YXQrj5r2NEQQwN4G9OQW1lqjG1gwLJSB7f+1uaFEFsP
uiTvukh257mgGHDl1u3Z7C4lYigzMHwzgnc+ButCJrzoR6SOZ5J/9oqTwxdhfDr/
3z5XakXJ47ssLtHX/PdmmrJQN5neww==
=3oaR
-----END PGP SIGNATURE-----

--Sig_/u73I2CAj_0XHU31A_03DG_W--
