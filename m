Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65044C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B67720893
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SxlZ+wJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B67720893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeG0F4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 01:56:46 -0400
Received: from ozlabs.org ([203.11.71.1]:36383 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbeG0F4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 01:56:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41cGQ33Zq5z9rxx;
        Fri, 27 Jul 2018 14:36:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532666204;
        bh=WUfUuTC0USVZXJwq9TfFzxW4EkQTIt4zNAQOHf/+sXk=;
        h=Date:From:To:Cc:Subject:From;
        b=SxlZ+wJgxb5EDwlENY2LStwoKL5Y7x4ksjRlZKwR8WltrJHmjtYMJcvRbd3WUZxa6
         Q7s+1+NgXlawYPMiNzxobR0j3rlVppTg0IJqJKA3kOSG1UqWo1KjFQtR6VAKAqF7oV
         yfB5sJ1Dkj7svvAyxMDAKXjGOxxCsdcVpdW01FZH23t//B/FX/ONpTy0H4URQahZIW
         IBVYuZg3SEvTlB4uDHIHD24CqI75a2p+D12JVSclG8prbpF2dRZyQWJvI0xL5Xk47x
         688qaF84aF4KLUputv2YL7nUF+TKfAFzalmSR6480TOn58Idq+gxK/fPEEagCYlm1s
         S8KwaLfQytVMw==
Date:   Fri, 27 Jul 2018 14:36:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Steve Longerbeam <steve_longerbeam@mentor.com>
Subject: linux-next: manual merge of the drm tree with the v4l-dvb tree
Message-ID: <20180727143640.4dc3fa54@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tJtDrI3UakkURF+g5o+Re61"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tJtDrI3UakkURF+g5o+Re61
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/ipu-v3/ipu-cpmem.c

between commit:

  343b23a7c6b6 ("media: gpu: ipu-v3: Allow negative offsets for interlaced =
scanning")

from the v4l-dvb tree and commit:

  4e3c5d7e05be ("gpu: ipu-v3: Allow negative offsets for interlaced scannin=
g")

from the drm tree.

I fixed it up (I just used the drm tree version) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/tJtDrI3UakkURF+g5o+Re61
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltaoVgACgkQAVBC80lX
0Gw6PAf/WB4sfm81A8xuj62y9T8Kw1mNJDO7++f3WjYdlepP5s/EchZeun1kr9od
qdlRuSeUFrUvk99jLYCUrbNowkULSMypUJF/vCnCvhuc6ozrc9yUjJSchnPmRiZp
RVVWoHMw49pbzVlxvnd7BQkyXZhNuqyL8jpPdq/46TAXsMK+uyYmgpHebaTVBLYj
tNVIc3De2BejcKrZJj0cn0AU3aRNTEGUNQ6ZFxyTal8+JarXl9ynJIiWH0ooLJTw
qMlXcKRvpotzZsItP/N65RW6PJAD0AQMcImqu1bzSTCsrwKkN4zorSL8ihLG5WG9
rdGsp6MmZxtQllOHeyWkOvgRRU3WnA==
=vROx
-----END PGP SIGNATURE-----

--Sig_/tJtDrI3UakkURF+g5o+Re61--
