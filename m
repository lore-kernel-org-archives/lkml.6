Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4177ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2BF2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DZN70Nol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2BF2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbeGSCVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 22:21:07 -0400
Received: from ozlabs.org ([203.11.71.1]:38881 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730811AbeGSCVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 22:21:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41WGtM5R7Fz9s21;
        Thu, 19 Jul 2018 11:40:27 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531964427;
        bh=QWO24GSzbEHCzkzdMgELi6qkRihzb6OL5vIYUR70+sk=;
        h=Date:From:To:Cc:Subject:From;
        b=DZN70NolwHEANR1gQWc2Q1srQTBHLpAPNk4tsirzwtNRLqKPp3qUTXI11YqRoFHMt
         TX29Eq6Sfq6YS2tBZvDY5CE0C9prN/TINLSibbKJv9dPPM5mNrfn+/zofjCqAxh27D
         x4+czTvgHdpOXRsrAWPEB+YRELkUd8bU8a+mQuD6/tSNnGH6818gJwF3dMvuIZ4/Ra
         sw1yQ90AYYGT5cDEEgdwae2ZIgrExmc8XTQoVkeP7fSYrVVgPg9EBL+d5CX6EH6Ejj
         hDSeEKfJtB7VAQdZcFHQjESqWvpEQWS+FO7EXZHw3HJJ0T2vCavNR/RE6uJovSAkRg
         449XLZf5hZ6XA==
Date:   Thu, 19 Jul 2018 11:40:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20180719114027.2722d075@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6IWCp4mbw_59ajOlpprefbY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6IWCp4mbw_59ajOlpprefbY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: modpost: missing MODULE_LICENSE() in drivers/net/dsa/realtek.o
see include/linux/module.h for more information

Introduced by commit

  d8652956cf37 ("net: dsa: realtek-smi: Add Realtek SMI driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/6IWCp4mbw_59ajOlpprefbY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltP7AsACgkQAVBC80lX
0GxLKAf/SDcgIqF9K5hvpclc5LhLwbX09L7bVB3iDeq3p1lmlHaA0DU4UU6iqBoO
gmJ3KJXbsnYtDNkS6dyMuP+oPVRJXSLSEhdCnA9vTDNQCqHyMTVca8+IE2UuQobQ
Ei7Pw8BmmR+j5k3AGZiowh6evvUW+G79k+ItP6lrj/w5aPVtlTcTgVbxK1ciMCjJ
qflstXxDbOcd8v2vxsQFK2LQizyAhknnooY+zE6cG2LAKBlkK2AiYj+xygtXxDk8
ZWzTsDKt26yF62/gecMZuZk1KTVBbMAbomueT2tsG4Y8uCeOKWr4lanDHIT5FL9f
2h0yV2L3GHFkP3M8neNoOjE3FPoVIg==
=ajjv
-----END PGP SIGNATURE-----

--Sig_/6IWCp4mbw_59ajOlpprefbY--
