Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72A2C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868DA21735
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bMLKwrkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868DA21735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeI1Hcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:32:32 -0400
Received: from ozlabs.org ([203.11.71.1]:37923 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbeI1Hcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:32:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Ltt43csVz9sB5;
        Fri, 28 Sep 2018 11:11:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538097084;
        bh=C/SAPUfbO3kZK0MVbG+yqzLwXjICVRdNJHfI6UL/syI=;
        h=Date:From:To:Cc:Subject:From;
        b=bMLKwrkCuthUUZQNwdFM89WGB+FAzaDCSUdB0bihWuFfRMK2rkO1JKQ38zZrFdN16
         mKp8Uis+vSoC5cqOaVBcu0JQt6BW6dkKNhfW/LYf99k5+XptMHNQyidADMp8TlYkrL
         LhFClTJgTjDAgkHOuCqCSq6hx5A21+fpLb9CP7RQ6CPmP9NfIX4qa5Lpvu4688oQVp
         SRqZ37wuN9HED30Ks13leCxlOrpdd3jWwgi2Bdu2bdqwYeE8S4siu2AuDxDrZiffcf
         iW4SfqpvFLRgTn/JweIUIQdoAjld6ifAMwmEP4hIC0AvpfkfsSz4W8VL7kBCzWGs+l
         O05yhdiqLQ5Jg==
Date:   Fri, 28 Sep 2018 11:11:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
Subject: linux-next: build warning after merge of the block tree
Message-ID: <20180928111124.745bf2ef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yy6YmAVRty.sLu=Rb/Trb_I"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yy6YmAVRty.sLu=Rb/Trb_I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

After merging the block tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

block/kyber-iosched.c:84:22: warning: integer overflow in expression of typ=
e 'long int' results in '705032704' [-Woverflow]
  [KYBER_DISCARD] =3D 5 * NSEC_PER_SEC,
                      ^

Introduced by commit

  6e25cb01ea20 ("kyber: implement improved heuristics")

--=20
Cheers,
Stephen Rothwell

--Sig_/yy6YmAVRty.sLu=Rb/Trb_I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlutf7wACgkQAVBC80lX
0Gw2cAf8CBp4h61SdtashYNOUgegNNUqSD9vgcS7M0XbjqkFXrICt6WZIVq5nohG
ewKe9e5TgHAuVRjGn5GxeYuNqZnEMPdfI2DsIFQSctFKWvoejq+9P+woRfcx1mHT
jc2hTjnxO9xGfeHzbXcSqv/knLFfAGUkb24lDycqCi++PTPFuSpAvJcsk4fBsR86
koYkwk8wZVA3vuhjsgdMIkV69Ws2sV/zN6Dq5ajqIz3jvZaNC3zR7hxeB1DLGI1E
byuQzEfWG3ZukfeFC6NkAwNahlYaSHKfBBmXmCb0xF0kJ48bkgHZJSl3PE3KJ1tL
md/v3sLYzPpgrfaTnS1AAXAoLM6NFQ==
=z5wW
-----END PGP SIGNATURE-----

--Sig_/yy6YmAVRty.sLu=Rb/Trb_I--
