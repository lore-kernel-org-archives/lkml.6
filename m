Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6C4C46467
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9206221717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9206221717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeHCETd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:19:33 -0400
Received: from pide.tip.net.au ([203.10.76.2]:33199 "EHLO pide.tip.net.au"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbeHCETd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:19:33 -0400
Received: from canb.auug.org.au (unknown [122.99.82.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pide.tip.net.au (Postfix) with ESMTPSA id 41hVyP5YgSz9CSG;
        Fri,  3 Aug 2018 12:15:57 +1000 (AEST)
Date:   Fri, 3 Aug 2018 11:00:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geliang Tang <geliangtang@gmail.com>
Subject: linux-next: build failure after merge of the pstore tree
Message-ID: <20180803110002.5942ff15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wUzUYpsI4p=0c9YoFKPjbP4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wUzUYpsI4p=0c9YoFKPjbP4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

After merging the pstore tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/pstore/platform.o: In function `zbufsize_zstd':
platform.c:(.text+0x172): undefined reference to `ZSTD_compressBound'

Caused by commit

  48ed452ca6ad ("pstore: add zstd compression support")

I have used the pstore tree from next-20180802 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/wUzUYpsI4p=0c9YoFKPjbP4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltjqScACgkQAVBC80lX
0GwALggApkQBA0vfK+wsVfRM9m83qorsSaDjALq5RnGLPD776TpCOb7y21jPYC3A
uS1W0iR/wjEJt7hELJ5kyJGxaz3sxcIQivshWIFlU6daaWA2rjAv2UizlKcSi3Xv
Esd0NESoKYoeKLmEpZefNlSbR3SqYiRDSNINLE9ntyL/IWkoKWT/Ui6LrgNXS9Cx
8q1cYFXRJa+Aiblrpv7xF6qmzBNJG6Ju0hk2Axg0doNOee/wu9o1deZ2rrH0CVd5
Iv3R7hurkO1oighix6H1kTYG00wo7fmbiCS/acV+qDkAhUaKKF+DiqxJv7rTCgDo
YFJWP2UcdGbe1tTCwRFEKwRuEZx1yg==
=/Fyh
-----END PGP SIGNATURE-----

--Sig_/wUzUYpsI4p=0c9YoFKPjbP4--
