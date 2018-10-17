Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC85ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5048E21486
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iJUGDtH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5048E21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeJRFtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:49:43 -0400
Received: from ozlabs.org ([203.11.71.1]:40163 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbeJRFtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:49:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42b5Vp1GX0z9sBN;
        Thu, 18 Oct 2018 08:52:00 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539813122;
        bh=Wr5NibhvPZVWeioCKPs1mIE0ymyKVXQTlOd84iYGziI=;
        h=Date:From:To:Cc:Subject:From;
        b=iJUGDtH2pJcatDeuOFyeK0SeJHjv0cyPipEYDAwDWfnchCGJNar8/CzgXsorbGWRD
         SnaF2ew/UASKxxCvupUDrahUiJBEx0GYJgSRueenGr+D82vQMqE2sBPCUmEvbSJjuu
         za4pS5Z5ZOUJlvl2HwSbyhEwlS8EiuUheNy4Ofnf71uO+g20MfK+B4f4x82Z1tr3rU
         WcaCIx5doOx7BwMthcojHTuxE4JTufpTiWk9MOWfKhsqVJk+luoX+4AvmlTdOAjqoV
         8fQin9554bcUbWTKfHnL8QOcr1FigBz588Gxcf2aswLiSk1IePwkUBeZQ5PD3elDyE
         XG/nYms6KUB0Q==
Date:   Thu, 18 Oct 2018 08:51:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Craig Tatlor <ctatlor97@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: build warning after merge of the clk tree
Message-ID: <20181018085142.0fc1d2f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BvsTfr6L6MiWm_CVDsoWvly"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BvsTfr6L6MiWm_CVDsoWvly
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the clk tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

WARNING: modpost: missing MODULE_LICENSE() in drivers/clk/qcom/gcc-sdm660.o
see include/linux/module.h for more information

Introduced by commit

  f2a76a2955c0 ("clk: qcom: Add Global Clock controller (GCC) driver for SD=
M660")

--=20
Cheers,
Stephen Rothwell

--Sig_/BvsTfr6L6MiWm_CVDsoWvly
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvHrvkACgkQAVBC80lX
0GxhUQf+MEvNeshiNgJ3D+Ophr89+y+HjrIF0ObtuEZejuef35PZpEvviwpcQiVH
CrRyxx6Dt+Hay/BmQMvnKHSpJAbuLEEG+KDJo2CtgrTfqyMDkdBlra4ajbs0dT4s
dQ9T/f8rNGPnHoIZpAVf+Mp56lli2E+OE0x4VlDgEdE36hGdy7u7m3rx8ivCiiMF
jlaBmZeSvTa+3GfeMwOT3WjwZ41T6ogJf+E+dXdOtm400lemmk360kHea9ZGR62S
IKaB9lM8q3N3lP+lqCltOMzGvQPK5tzUmZWJKNvEFddDUKfNTEysBk/+bwtvFKUG
JjyX9haw7gc4dWnrkZCyNZxh63A4CQ==
=21L9
-----END PGP SIGNATURE-----

--Sig_/BvsTfr6L6MiWm_CVDsoWvly--
