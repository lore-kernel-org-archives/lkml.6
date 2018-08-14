Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA6AC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0744121700
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tEa0r37a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0744121700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbeHOBBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:01:04 -0400
Received: from ozlabs.org ([203.11.71.1]:38439 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbeHOBBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:01:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qmz72h7qz9s4V;
        Wed, 15 Aug 2018 08:11:47 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534284708;
        bh=PyKvbE+FMdlut5TU22u4+R8bBevTpYM9nwlhEwziTxs=;
        h=Date:From:To:Cc:Subject:From;
        b=tEa0r37alvWOAm6utCcy6OEsH47cgt5HpqJZoIEkGqAoxxAnkJseSBlsXR1wH53zL
         9vWCSbnc77CGVeDjdQCDsrdiYrXjeC/oKco8IwNtaNhcntJwkOIPF+p0Q3bcU4/f6m
         pqFHW5jVZ2lTygP7KO1QsmwxjdEWmMZHHCs2/h+1NhaDq7XiiLsp+B+CEeadMqibmq
         YC4zJ0BsR2TwZHrFquIRd9eiJclghwB6ONKjBiBTuZyz4RLUtw1rPz93+k5UpQrPLd
         kA7DtXvBWqs+T5DnTPK4WsILPrz8ZGKUDPZ4sCs6KaVZq5YhqARp9j9e1uzevXybNt
         DTMcINQs7n6ZQ==
Date:   Wed, 15 Aug 2018 08:11:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: linux-next: manual merge of the arc-current tree with Linus' tree
Message-ID: <20180815081141.3f1b1059@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HuV4cFL1C_RG_66=8oYm9h0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HuV4cFL1C_RG_66=8oYm9h0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vineet,

Today's linux-next merge of the arc-current tree got a conflict in:

  arch/arc/include/asm/atomic.h

between commit:

  ab0b910490fe ("atomics/arc: Define atomic64_fetch_add_unless()")

from Linus' tree and commit:

  39456148db74 ("ARC: atomic64: fix atomic64_add_unless function")

from the arc-current tree.

I fixed it up (I just used the version from Linus' tree for now) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/HuV4cFL1C_RG_66=8oYm9h0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzU50ACgkQAVBC80lX
0GySTwf8DAHF4ma7U5UF2mh0VZL0dnJkNS/Km4kXAt/Pit3MWCzuvdoRU3KP8NCy
bbVJGZgpp8qbRexpguQ8Zz/h4c0RPwi2eGpiu3Jlwelt0L4No6GXfYeC6M8BaHDR
MOZP01OgS9wqu4zHbRlfcoadWFY+Nyzv98lwcB40AuQ9Sr7zeKIYetnyBy0KZi85
l6qtKPrgMu3oBQ24J2wuutJGTutCLkToet9sCBhRIrNR4RXd4HUa4/07WCWhV8A5
MR2minmy8dmBBMkzxt1lHajve/7QJK7iDWq32+C9iL3zAu2KDfeCJWDeAVO3kXmo
cARkwkutwRGEtvsEfbTyhMieUDBW+g==
=YYlw
-----END PGP SIGNATURE-----

--Sig_/HuV4cFL1C_RG_66=8oYm9h0--
