Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8724C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C042133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KuqSe/P1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C042133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389029AbeKPJUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:20:53 -0500
Received: from ozlabs.org ([203.11.71.1]:42937 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbeKPJUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:20:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42wxtW5X5nz9s47;
        Fri, 16 Nov 2018 10:10:59 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542323459;
        bh=PYgqWNzcoshta/m/OTwdNWK//2aQFYDwZ0jhGXRPTgo=;
        h=Date:From:To:Cc:Subject:From;
        b=KuqSe/P15cQEQDxGRUPx8b1VFB8so01aFj0cjBJ4mjRGT5/7PbcpD6dhvZGqj7xtQ
         ciwbUcu1gcNAwDYKS0Xi/wmO/Ap0DxJFPQ7yeMP5sVkEbnCJAA2vt4MskuoFmLRUYV
         DHN9h96fB5Gh93pH+SiCHLneN/WPwEC0RIaU4VTlM8oYSvFWRfWyK2dp2vcOujVxbi
         olFbCtg4Dte2xpPltQRoXj2o0C0MsEjM7Px6bIQnsTH77saQVKhBcBkhBdIaLEX0Yh
         DJLEeFzIZ3Nju4KtaL260btnQ9yoeyQVSiHg9fJ9DJOo+E8NcoCmWJXsX93g0ZrkrJ
         QNVqQiEHxX4CA==
Date:   Fri, 16 Nov 2018 10:10:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@codeaurora.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: linux-next: build warning after merge of the qcom tree
Message-ID: <20181116101059.18ad3fc9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bsffGIR900KQxJ3cNoyrhDu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bsffGIR900KQxJ3cNoyrhDu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the qcom tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c: In function 'a6xx_gmu_rpmh_arc_votes=
_init.constprop':
drivers/gpu/drm/msm/adreno/a6xx_gmu.c:943:12: warning: 'pri_count' is used =
uninitialized in this function [-Wuninitialized]
  pri_count >>=3D 1;
            ^~~
drivers/gpu/drm/msm/adreno/a6xx_gmu.c:948:12: warning: 'sec_count' may be u=
sed uninitialized in this function [-Wmaybe-uninitialized]
  sec_count >>=3D 1;
            ^~~

Introduced by commit

  ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_dat=
a()")

# CONFIG_QCOM_COMMAND_DB is not set

--=20
Cheers,
Stephen Rothwell

--Sig_/bsffGIR900KQxJ3cNoyrhDu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvt/QMACgkQAVBC80lX
0GxxhggAnPhUNs7OcqjzTZydgZBYXnFl0Z3A0tXvL9OLBSVXO6fqOd2By92mQsUS
OZSnivl81SfuHV8Ko4Rv8MOqW6dixtt2Z63Qmr4nDipppZLgILo66Svt+E/+LPkX
m5CycaQdSpJUgtY8W22YWLUF02G7alOns7skhEIGzwYvv+iEiHHrQw80kuDm0/6T
/E4UaPGPkcCL9bSsnYmSjVKQB2P3tsYhlRGYuA58QyUdB6L8+F1f64oRmaQMiVwH
2GfJpnRF0nW+El634YX5MsFekNfjxvyP107vQz5LcLxoezvYlP7g9OBrysWGW6Yl
IQL2cKJO0lg0fd4916MVwwdXV1POnA==
=sBkX
-----END PGP SIGNATURE-----

--Sig_/bsffGIR900KQxJ3cNoyrhDu--
