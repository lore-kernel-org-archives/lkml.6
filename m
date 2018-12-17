Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961F1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB572084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XhTdHfzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeLQFjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 00:39:02 -0500
Received: from ozlabs.org ([203.11.71.1]:56775 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbeLQFjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 00:39:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43J91t3LxVz9s8r;
        Mon, 17 Dec 2018 16:38:58 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545025139;
        bh=o+/8hfZk8oQCFnqbBS+yFEJ8//26saW+qOMNuyniDcU=;
        h=Date:From:To:Cc:Subject:From;
        b=XhTdHfzPkW+c47GLS0mcgmDa5v/wrg3aCgyAS/AQJP1TpY9Kz7y1S+SOXpv0kHBfa
         DsdH6638MneFcXQPLMNOtp16t8TvctSnNie8V//p33q0OQwaFvsb4L90wszV7rNMHb
         DQNZl8vi/TzXBBKBdHhDjL+BW/LTwXWxpCV53KcLjH3dkBKBx9q9G4sXLhnoOTat8m
         RFEYuOOC3b1jhUbWlOhrCCCL8BKvdA7sqW3OXi+u8uNv94g992a40MhHsQysTbc85Q
         RuzL8s76dFKF50ZOvtLlTZZ6F/Ajv4tuiK7o4zETmv98wTHVqxwPYwhMB/fr7DriNd
         wyRcIObuce/ZQ==
Date:   Mon, 17 Dec 2018 16:38:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: linux-next: build failure after merge of the mfd tree
Message-ID: <20181217163858.099428ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VgN_NUCJtzMpivRt4VDof3K"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VgN_NUCJtzMpivRt4VDof3K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mfd tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/mfd/tps65218.c: In function 'tps65218_probe':
drivers/mfd/tps65218.c:247:3: error: label 'err_irq' used but not defined
   goto err_irq;
   ^~~~

Caused by commit

  05ba643fa2ce ("mfd: tps65218: Use devm_regmap_add_irq_chip and clean up e=
rror path in probe()")

I have used the mfd tree from next-20181214 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/VgN_NUCJtzMpivRt4VDof3K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwXNnIACgkQAVBC80lX
0GyHwgf8D0NZxXYySDWUpahKbTIy6PrD+Ah+49QgpAsOn9SrluxZki/v1PoLO57a
W3jC0jqvVSQHS2bi4WkgW9tgKjb94I1wsb3lvVblPUg6C3A/QsORuXLLXTlAzx8M
uXl8KKUYzg4mRUgc98H9OixDCyJYh7Jubv/HJzQn/q0mF4BJ3FQMqGsmFcb/8PZB
8afFfQP9eoGcQEHFEM4+QreBzIu1MnP8Tv1S2gZpP2JzrYhIIsldHvptPgHdUoFH
07Is1K7h7H0UYrI1ShDH+2i5oEBja7D/mdZlOwBSCydNSiFsYz1HI6MDGZEai3/P
cU3TyVFypB88CM5EuSx/ndfxa3QS8g==
=/5hz
-----END PGP SIGNATURE-----

--Sig_/VgN_NUCJtzMpivRt4VDof3K--
