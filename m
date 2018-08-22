Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15948C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 22:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE09420C07
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 22:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ryCB2pbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE09420C07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeHWCCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 22:02:46 -0400
Received: from ozlabs.org ([203.11.71.1]:52673 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbeHWCCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 22:02:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41wj7L6p8qz9s3C;
        Thu, 23 Aug 2018 08:35:58 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534977359;
        bh=spvJ1fpEvGcjHbkujkR8TLAYDmX8vreVEvjgRIj0+g0=;
        h=Date:From:To:Cc:Subject:From;
        b=ryCB2pbtGf+CHDqL74zgRCDt5Ll/D2sb1dtPjB8aZpimdPG4WnDBmX5vfLdG7hcpa
         csrkpVgDATZ3+sgaRqabORt9LbHF8whk37fl8o2XQMXC73SUlXU8tL8YYF7uoBuX2q
         9v8jiLA8f4gQFlX89cAo77bVZ8zDKxxRNQetolM76ksCzyK6hLXJrjzeeirr0MMH1s
         DSEOp+3JXrxulSwDuDlovKEyUhyGJk+CcH0g47LOGElydoTxrxE7TCU1+Xtt2r/oNa
         8ldDigaPXAfoGxwoC5LGaPh48zOqqdGwH52TpjWAyeEnUEnlcIxItpPUd002ceLmP3
         CkJsfe/dtfnNg==
Date:   Thu, 23 Aug 2018 08:35:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20180823083552.6fd372af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mro.6O4w9MnCWFD7==DKJwp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mro.6O4w9MnCWFD7==DKJwp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

After merging the kbuild tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ld: failed to merge target specific data of file drivers/input/mouse/alps.o
ld: drivers/input/mouse/byd.o: compiled for a big endian system and target =
is little endian
ld: failed to merge target specific data of file drivers/input/mouse/byd.o

and many, many more like this.

Sorry, I can't easily tell what caused this.

I have used the kbuild tree from next-20180822 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/mro.6O4w9MnCWFD7==DKJwp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt95UgACgkQAVBC80lX
0GzEwQf7BHhPvlz4bMi/xEqfOoEH7Dc6BQAcvfn/1BDSX1JGUJp34An8r40JkG60
ZoN63sP1phqPGPMfrPzMZohMdcnuN480njVruQKKZ3k5MWsb1poHDre4jEPmfReI
/f2hch0bz8XSiHQ1DI3ofeWeFCmk46eSWEdROuv7u4hcQ4GscY3lPSPR3GsSaZmX
zofpnMMu350fXF2FBB6i/w/gj0RA8/1hFmVlpD99B54xNifKzGJcAtIwhIYRoN7h
auer9590Iuo/mWa2A/oviyBmnOF41mO0SsGPnE0xINeKV4S4N9DNlvRdOg5DOG6U
7MRBy0rBXZvr4xkO5akvmeSWv6ctmA==
=mStA
-----END PGP SIGNATURE-----

--Sig_/mro.6O4w9MnCWFD7==DKJwp--
