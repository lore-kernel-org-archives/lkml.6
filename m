Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEC6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B03F20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ozATEHRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfARA2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 19:28:15 -0500
Received: from ozlabs.org ([203.11.71.1]:55877 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfARA2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 19:28:14 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43ghcX3WNFz9sDr;
        Fri, 18 Jan 2019 11:28:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547771292;
        bh=3H1FT7RIlMsmhHhNxoROMGerrxb/XDCHeWwo89QoH8s=;
        h=Date:From:To:Cc:Subject:From;
        b=ozATEHRcm5fbLzHRlibEhosg2SjBEA0zuBel70bBISOEBtznN1Lea4sNs/4/SETZx
         rG45Jq/ABus3NHKdrcpjQ98v1ENL8iNe3k+8hg1XZSQvYZ0kCpu7/5BUi9D+dnr/rj
         PJbj+OVU/pIQ4fsXEh5AMQbUHZE2YDwaAjCQAmAl97PcgL1vWyAbBbBZSjvz2HUShY
         UdIRCYrHh4H2nw4X6BjuB4BkWnAp0QD3yPQFitMtbFtCTS688Vu2+bGmAXwkIRf1ji
         SAM2y21FTqW/PMEovUkMzUaxmSp3R19vv74iW3XzEMbciit7sfyaxuQQSFOq0uZs09
         x/DqmOhrT5V/A==
Date:   Fri, 18 Jan 2019 11:28:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: linux-next: build warning after merge of the mali-dp tree
Message-ID: <20190118112811.091dd962@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/y5n=y4k.rTJ_O8JbIxNz+FQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y5n=y4k.rTJ_O8JbIxNz+FQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Liviu,

After merging the mali-dp tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/gpu/drm/arm/display/komeda/komeda_dev.c: In function 'komeda_parse_=
dt':
drivers/gpu/drm/arm/display/komeda/komeda_dev.c:52:26: warning: unused vari=
able 'pdev' [-Wunused-variable]
  struct platform_device *pdev =3D to_platform_device(dev);
                          ^~~~

Introduced by commit

  7e8d4fcf8daf ("drm: arm/komeda: Remove IRQ parsing from initial series")

--=20
Cheers,
Stephen Rothwell

--Sig_/y5n=y4k.rTJ_O8JbIxNz+FQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxBHZsACgkQAVBC80lX
0Gx8swf/dvkNQMtG8rfbpcC2vcjVpzsJrcseJODeV8Q2kNhpleTL3fejs9L8F04U
1DASaIuhGql3ytdr3JTHmaA9d5jT2RPQVh20WPOnvzDI5fW0HYo4lWHWjNgd+hvf
WApklWjLNad2qc5HM5RkCqTg1UsC3Sbo7AatA5O9tAkO6g+pxEqlb4vE2doq6XWq
J0a/rhs9sHB+rIpz6RKEf3/Oc1s8vGNNlC4wtYjvDxzHxzi4ad82j2I9RR4V2ZZ7
MTvk61amyNdau5RDzofy7XCq3lcf+h6zVExIr6joa6mZc5UOqvBKswXmXD7zf0ll
+y1B98F846mKWw4VSCFjk1WXD38OOg==
=t0sJ
-----END PGP SIGNATURE-----

--Sig_/y5n=y4k.rTJ_O8JbIxNz+FQ--
