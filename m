Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED4BECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FFD2088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WaRrMjzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FFD2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbeIRFog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:44:36 -0400
Received: from ozlabs.org ([203.11.71.1]:37455 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbeIRFog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:44:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Dk5K037Pz9sBv;
        Tue, 18 Sep 2018 10:14:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537229686;
        bh=WNHpN5jTIXLjCtWwiVAzeO1ovQ1FZ4Hn0sZFjl6vO68=;
        h=Date:From:To:Cc:Subject:From;
        b=WaRrMjzF/i6XG3SUzfhqpcLBPiBA8svSpofFuIy2I7WloI33QXgoYTHyePwpnPb89
         Oiykn3xPMZqzoE2e/z8d/PwomlLGfgzY1Xri3280XFFo12XEaQI84Trhd91S/QtwH2
         EBdplxFTRR3xjve0vNdJrR+2GCJ3D/r4l1ROdnbbWAhteQ6UvE/xyN8CRFCqHL9H9F
         rCUFJD1dyRnzeSUGT5ovIyraq/TFl92C7+C7mB0D25KbVG4vUtq5ervEq1PWwOVlTS
         BQIPmb4ISmHjPNtiBT4z1k61T7ZK6kVbvAdqmyFnCTlNoIhIJu1ycnA1aQpBjhRz//
         mncaIr1GcsDUw==
Date:   Tue, 18 Sep 2018 10:14:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Austad <henrik@austad.us>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: linux-next: manual merge of the net-next tree with the jc_docs tree
Message-ID: <20180918101444.6466090c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/klpMMgpWX4ekdlopQM4qc3T"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/klpMMgpWX4ekdlopQM4qc3T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  Documentation/networking/00-INDEX

between commit:

  a7ddcea58ae2 ("Drop all 00-INDEX files from Documentation/")

from the jc_docs tree and commit:

  a20625e49dde ("docs: net: Remove TCP congestion document")

from the net-next tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/klpMMgpWX4ekdlopQM4qc3T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlugQ3QACgkQAVBC80lX
0GxVfAf/YNLUgt7tJInWBu1JIXC8DPu4YIjBuqgCcLi9Mry7haVJ4T+bxp8adM3Z
59jsn7vPOBtCjGtlBoDUITlypkZnaDVtVFaSJ0ZTnyfP6ASzJ58nUWZqGWZ1Fw92
pU9f2D2wScJc1LoaN2Ds8jkB28sVDcWv3raDZ1FesGsoq7oPMZ6NjZZw6I2+tvf3
So4EQQ9JT64jVzHPd5yVpHvHDBB1ze9wixqsLzdS9KNEbfmUjKVn0lm+AiM7j+tJ
6nllx8g5GSyyT6HdDLc4daxvunw3Dp1lbn6gtRJJQfxBv7gxbvCj94WJwnGsqo2u
8zxCU7iG9jFET7jwW22jvF0naa8yVQ==
=R0rL
-----END PGP SIGNATURE-----

--Sig_/klpMMgpWX4ekdlopQM4qc3T--
