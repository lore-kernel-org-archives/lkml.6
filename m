Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01886C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF232214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lw9vbzHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF232214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLGBZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:25:00 -0500
Received: from ozlabs.org ([203.11.71.1]:55961 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGBZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:25:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439vsP53tsz9s1c;
        Fri,  7 Dec 2018 12:24:57 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544145897;
        bh=5wq/qnznZFLSH0FaQE+Gnud7tbjxn119GUD8bg8Ijek=;
        h=Date:From:To:Cc:Subject:From;
        b=lw9vbzHOtkUkdhmTZzpRBHYGwqZkejq/h5jcxl7I8yAGmE+7Xhm9ubAu/joj+KsWE
         l1cNvzWPLrYQk/RknAqhjeDygU4UYMjAcpCiBvp/Wxrp9QyrCQd8wNcsi+VZ0xTPJe
         3M49Gzl1ws3+jmXa46FMXliSPdcM9HcFDvBdDDVY+nsL8B8g360Nn+OVhsqcsgEKMx
         c1evKJKM1CfWUItU0fdoe8CeBxYyE1Nf2r1TBme+94VWqTx5NRShUIR3CId0+82EX0
         2pGjvu6c6b5e/k56Pr1tV8AJezs0+IJSHmXH3c5j+3Jgl/WGInPT5ZYfp30Nr0RYJY
         FgLSBwsN7eeCw==
Date:   Fri, 7 Dec 2018 12:24:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: linux-next: build failure after merge of the thermal tree
Message-ID: <20181207122456.754129f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZtC3eBj3jrbJ8fnzS1zf3GZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZtC3eBj3jrbJ8fnzS1zf3GZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Zhang,

After merging the thermal tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/thermal/qcom/qcom-spmi-temp-alarm.c:26:10: fatal error: thermal_cor=
e.h: No such file or directory
 #include "thermal_core.h"
          ^~~~~~~~~~~~~~~~

Caused by commit

  150a4fe8c335 ("drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom =
subdir")

I have used the thermal tree from next-20181206 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZtC3eBj3jrbJ8fnzS1zf3GZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwJy+kACgkQAVBC80lX
0GztcQf9EiqRHgGUILOxNzg2TOm00zRwcrmUh61igBlzOUbuk7Znf/Pljh1PCE3f
M8/XHNDEJG11heNv+rMhS71hrWsOCys5kvE8bJh9xDLb4omn3S8YWZSpGlcHtiph
o2HLPV+Jd1VxeCQH4p5mmZzCR6+PGk80o2I5eesBRvB2X7+2d3d1ysIsXYLo+ChG
YE2p2uLoqoe+dpdjyRPy1l7nrNjuZ6RoLS1x91VaZh5H3sO1Ugfdd3NLSxZSUb1c
mQEFUsmJ2gS47LJka56BG0RcaGyYJAbYdVlpG+UOq98ovh+dDGksG+rectcuBdMn
Y5UahXD1fVO24PRBaw2cRfZPzUVrRg==
=h+Wu
-----END PGP SIGNATURE-----

--Sig_/ZtC3eBj3jrbJ8fnzS1zf3GZ--
