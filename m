Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B35C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08AE214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oG0dU0m9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08AE214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeLFWSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:18:51 -0500
Received: from ozlabs.org ([203.11.71.1]:42333 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLFWSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:18:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439qkc1Gngz9s47;
        Fri,  7 Dec 2018 09:18:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544134728;
        bh=OVBMP3tfEP1iObbqu6H6WrB2qSeC7XDR7l59pi5e5kg=;
        h=Date:From:To:Cc:Subject:From;
        b=oG0dU0m9/9sBBfgdkobX6zcyWrSzGbs58EZ2U1/gVqFJlvqp8zerNd2eoXgUHkrsN
         W21cJH+xKwj6diECL8D9fusTQSvq3qoA5VBTLd+dt3c8amFoh7ng2oOIXjFS+LFSMM
         qTdcICWF3X1Gwgh8jzyEPr+vLLuakoSrnSWYfzSwfJi6aS0Db3D5eQ87X+yZs/0MRi
         Hhswh+LseBwxCurea0MZ520BrIEwXs63OuY7JfgtV3gbqjnLdnqhJVU6Ar5Oafqap1
         DWPuRxuzayNlpkvVuQL3/onN4xagrtEU+Stpcw/M4/rV1SXHMx7IMelpUf8eu1reCo
         L0ux3Ib9IxETw==
Date:   Fri, 7 Dec 2018 09:18:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: linux-next: manual merge of the arm64 tree with Linus' tree
Message-ID: <20181207091847.1db6a48e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1lBJtn.ZJVoQ.Wz5=7LV8BC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1lBJtn.ZJVoQ.Wz5=7LV8BC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm64 tree got a conflict in:

  arch/arm64/kernel/cpu_errata.c

between commit:

  ce8c80c536da ("arm64: Add workaround for Cortex-A76 erratum 1286807")

from Linus' tree and commit:

  c9460dcb06ee ("arm64: capabilities: Merge entries for ARM64_WORKAROUND_CL=
EAN_CACHE")

from the arm64 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/kernel/cpu_errata.c
index 6ad715d67df8,bb44635026f8..000000000000
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@@ -570,21 -570,43 +570,57 @@@ static const struct midr_range arm64_ha
 =20
  #endif
 =20
 +#ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
 +
 +static const struct midr_range arm64_repeat_tlbi_cpus[] =3D {
 +#ifdef CONFIG_QCOM_FALKOR_ERRATUM_1009
 +	MIDR_RANGE(MIDR_QCOM_FALKOR_V1, 0, 0, 0, 0),
 +#endif
 +#ifdef CONFIG_ARM64_ERRATUM_1286807
 +	MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 3, 0),
 +#endif
 +	{},
 +};
 +
 +#endif
 +
- const struct arm64_cpu_capabilities arm64_errata[] =3D {
+ #ifdef CONFIG_CAVIUM_ERRATUM_27456
+ static const struct midr_range cavium_erratum_27456_cpus[] =3D {
+ 	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
+ 	MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
+ 	/* Cavium ThunderX, T81 pass 1.0 */
+ 	MIDR_REV(MIDR_THUNDERX_81XX, 0, 0),
+ 	{},
+ };
+ #endif
+=20
+ #ifdef CONFIG_CAVIUM_ERRATUM_30115
+ static const struct midr_range cavium_erratum_30115_cpus[] =3D {
+ 	/* Cavium ThunderX, T88 pass 1.x - 2.2 */
+ 	MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 2),
+ 	/* Cavium ThunderX, T81 pass 1.0 - 1.2 */
+ 	MIDR_REV_RANGE(MIDR_THUNDERX_81XX, 0, 0, 2),
+ 	/* Cavium ThunderX, T83 pass 1.0 */
+ 	MIDR_REV(MIDR_THUNDERX_83XX, 0, 0),
+ 	{},
+ };
+ #endif
+=20
+ #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
+ static const struct arm64_cpu_capabilities qcom_erratum_1003_list[] =3D {
+ 	{
+ 		ERRATA_MIDR_REV(MIDR_QCOM_FALKOR_V1, 0, 0),
+ 	},
+ 	{
+ 		.midr_range.model =3D MIDR_QCOM_KRYO,
+ 		.matches =3D is_kryo_midr,
+ 	},
+ 	{},
+ };
+ #endif
+=20
+ #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
+ static const struct midr_range workaround_clean_cache[] =3D {
  #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
  	defined(CONFIG_ARM64_ERRATUM_827319) || \
  	defined(CONFIG_ARM64_ERRATUM_824069)
@@@ -697,23 -698,17 +712,17 @@@ const struct arm64_cpu_capabilities arm
  	},
  #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
  	{
- 		.desc =3D "Qualcomm Technologies Falkor erratum 1003",
+ 		.desc =3D "Qualcomm Technologies Falkor/Kryo erratum 1003",
  		.capability =3D ARM64_WORKAROUND_QCOM_FALKOR_E1003,
- 		ERRATA_MIDR_REV(MIDR_QCOM_FALKOR_V1, 0, 0),
- 	},
- 	{
- 		.desc =3D "Qualcomm Technologies Kryo erratum 1003",
- 		.capability =3D ARM64_WORKAROUND_QCOM_FALKOR_E1003,
- 		.type =3D ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
- 		.midr_range.model =3D MIDR_QCOM_KRYO,
- 		.matches =3D is_kryo_midr,
+ 		.matches =3D multi_entry_cap_matches,
+ 		.match_list =3D qcom_erratum_1003_list,
  	},
  #endif
 -#ifdef CONFIG_QCOM_FALKOR_ERRATUM_1009
 +#ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
  	{
 -		.desc =3D "Qualcomm Technologies Falkor erratum 1009",
 +		.desc =3D "Qualcomm erratum 1009, ARM erratum 1286807",
  		.capability =3D ARM64_WORKAROUND_REPEAT_TLBI,
 -		ERRATA_MIDR_REV(MIDR_QCOM_FALKOR_V1, 0, 0),
 +		ERRATA_MIDR_RANGE_LIST(arm64_repeat_tlbi_cpus),
  	},
  #endif
  #ifdef CONFIG_ARM64_ERRATUM_858921

--Sig_/1lBJtn.ZJVoQ.Wz5=7LV8BC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwJoEcACgkQAVBC80lX
0Gztcwf/Vzza/0RNAhQMMZZRfUG6e/sQewQtRXLmvSc9yKLs0w0FAmO/Igw1RrT3
kyNySbFF9gH+m0XCwti+/kDI/H0XWF9vYZXE3KwzBodxBpl0bgZLCNiBY5ZKUMyz
0hms2p8uuUE7npBwD/Dk510lR9woPnyQFz5sPstkuWcayyo0ermg6YLJdZ87KzLB
i3Pp0TN5M30e7/zbLO5sfgzVpO1kRhOIN2E58TgPnqwYOwRqgLhfWY8qTw5LRLCx
cwMfA7zJUZJXJizHmoQlGeIKMvfQ4hWqW3xWa/FZTw0A2ng0gMWzNXhINKObN05Q
neHtW2Gggb3QGgK9QmCXTlewxRVGXA==
=C381
-----END PGP SIGNATURE-----

--Sig_/1lBJtn.ZJVoQ.Wz5=7LV8BC--
