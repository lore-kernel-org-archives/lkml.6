Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B600AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713B1206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fTyOOpLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713B1206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeK2L16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:27:58 -0500
Received: from ozlabs.org ([203.11.71.1]:54569 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbeK2L16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:27:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 434yvK0DV2z9s7T;
        Thu, 29 Nov 2018 11:24:28 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543451069;
        bh=z0Gtrj2jyjg3h08XhNq6jioMtnzcJmm/SPfXSfICeA8=;
        h=Date:From:To:Cc:Subject:From;
        b=fTyOOpLPKSERjGrxS+YQqgG3Cvl/5Qh0UmHbAUkJzxC2ljpef/jdBOjWqt+ppWnAW
         LrUyL+j9X7drVQufNhFgnPqbcxb0f7C2qhGU81lphlgmwbqnzblZCit4Rb9tFZs5vJ
         AqTtzcNfxIOov02XnYU2em7IapfC1tALPovsYdZQpD2icl75E2jEgQejjeSV0tFTr1
         TaeVh0Usoxqi4/pC5WJZy7tm7XrXIErU0ccCdVGggInjY8mGhHt5ug8SX0ZrGp4FQA
         xg2yn/q6US+c0InKr9Rz7S5nK8LiZOx1l3vbDk01AS4j3+5RDpnshJfWq5pEhzMyUJ
         VeCrXitCMRGRw==
Date:   Thu, 29 Nov 2018 11:24:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Kees Cook <keescook@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20181129112428.45287471@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/98MDSry6jDRHt9Ep1W=uTQv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/98MDSry6jDRHt9Ep1W=uTQv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build
(x86_64_allmodconfig) produced this warning:

drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c: In function 'run_xdp':
drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:324:3: warning: this state=
ment may fall through [-Wimplicit-fallthrough=3D]
   bpf_warn_invalid_xdp_action(xdp_act);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:325:2: note: here
  case XDP_ABORTED:
  ^~~~
drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:326:3: warning: this state=
ment may fall through [-Wimplicit-fallthrough=3D]
   trace_xdp_exception(priv->net_dev, xdp_prog, xdp_act);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:327:2: note: here
  case XDP_DROP:
  ^~~~

Introduced by commit

  7e273a8ebdd3 ("dpaa2-eth: Add basic XDP support")

This due to my use of -Wimplicit-fallthrough.  This is new code.  The
warning can be suppressed by adding a comment like /* fall through */
at the appropriate places to indicate that the fallthrough is intended.

--=20
Cheers,
Stephen Rothwell

--Sig_/98MDSry6jDRHt9Ep1W=uTQv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv/MbwACgkQAVBC80lX
0Gxf2Qf/YWrIZvqMmkjx8UMwGPfDXUI/bw5l7GEJy03urzZJWem+77ggWgl70r0E
AL6O4xHPzcv/TAEz+zqb3mae18N/k9uZudqIBQggxi/oPmQTZSQj7mIw0y3mEhRZ
pOG0v1r3d4P5S7rvi6WTrwNnbzKYWFxIUFyIRCMNyrSB7Sk7DnjCjGwtyXctG2V8
ZqsJKh6EaCpKVUEfCbxry8VOLN/JRjAOydkGWwAifvNsFcTqG8N+uinoZSd2mn/C
N+lPshmqYmUJvCETKcABdLEcBY6IVQdoCRYgXO894VGxdlROBWPYGcVsnKteauRG
3BuPWJbwz9C+IzUobaDc5S9LPA5BpQ==
=+fzU
-----END PGP SIGNATURE-----

--Sig_/98MDSry6jDRHt9Ep1W=uTQv--
