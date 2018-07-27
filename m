Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50BAC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4AF20891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DIeimmkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4AF20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbeG0KXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:23:07 -0400
Received: from ozlabs.org ([203.11.71.1]:38721 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbeG0KXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:23:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41cNJK1p1tz9s0R;
        Fri, 27 Jul 2018 19:02:09 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532682129;
        bh=K9o9c4iLG7oq8pkQqDK8m4ckG1L9FEJ46NE6qJxlZ5Q=;
        h=Date:From:To:Cc:Subject:From;
        b=DIeimmkMqxSV2dAvRw95I81h10tdNuOaWTQ9LpxT2TW8YzN60oovEeeT8qb47xbWz
         LckjfvhMzIJS7jKH6rheo5KhfVjyHMf+JuP7KJ1ASNHNKivqfyn844cn4KqspThuW/
         uI0lCYuLY7bb+wPi4LnCeYlKDQkeBBMshgdJw+ZhNiBXKJsGBdMd81+bfCUqYU9kW5
         v1MZLzd42OG6WQfgVUH4uAPNCmnWtbPm+wFIYAfGlxlA6WmC9v5fBBxhwEZDE1wsXL
         Bzx5ely6OpYXyVMOoMwGS1qMs9PhNTZituMZ30deU14M5bVyRWZEKHWj78chRL2/tM
         bmr2n4goem1CQ==
Date:   Fri, 27 Jul 2018 19:02:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@google.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20180727190207.7ce1c9b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/inqdy/oNf6dcVMCgfy/Rc_S"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/inqdy/oNf6dcVMCgfy/Rc_S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

After merging the kspp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

cc1: error: plugin stackleak_plugin should be specified before -fplugin-arg=
-stackleak_plugin-disable in the command line

Maybe caused by commit

  a8b9eaddb9c0 ("gcc-plugins: Add STACKLEAK plugin for tracking the kernel =
stack")

I have used the kspp tree from next-20180726 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/inqdy/oNf6dcVMCgfy/Rc_S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlta348ACgkQAVBC80lX
0GzuwQf/Uhbd1pseRq3IFcCgNfLp4ZWgVgCWYyN9QTcc4Mz5hL9x/4kWf9b4nA1s
e2QgZUe2qVclbpVAoFtqkb/cpwqkkrxC8AcrVYxHuc4pp/kwtPG4zgnrHLyvGZKA
l2cyFpj4QBNDbAuikgHvsCSibLX7bjbiFCCdXufGVIOVudirddGIqjPYpzi/z4pW
YmqHcbHEE4H259uSQgvvhn3rdDxDr1KFkqJxwQWFAnJEPDSRXW1r1pOZFaXZoWNn
TnonFa/s/2VT29nQ1y/wu83uBCXrqe41PxyPiE9iHvNf9rvEuYDT4d1IObRlV/me
UVfG5po11GFeyzIYYc1dfNJ3OogRqw==
=FPmp
-----END PGP SIGNATURE-----

--Sig_/inqdy/oNf6dcVMCgfy/Rc_S--
