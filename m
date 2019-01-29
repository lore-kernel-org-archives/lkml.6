Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1C1C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B939D2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bZFqIDhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfA2DIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:08:53 -0500
Received: from ozlabs.org ([203.11.71.1]:51869 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfA2DIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 22:08:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43pWfm2wmQz9sDL;
        Tue, 29 Jan 2019 14:08:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548731328;
        bh=S4GPUlgx+4+UBfq5mwNzCKTznhZV/t7eL+gWJiXjPVw=;
        h=Date:From:To:Cc:Subject:From;
        b=bZFqIDhkzOkOur6MiIbBAbtKipEVSmYwk8UIpk9X5+l+pd+zeDveblEAGkVJ072f8
         RHn87e9hrDAQ0t9jB0yeIA+DouKhwSQE9MobfZX62ntqmxg3aKUcWu/20ujHBvkZIi
         8rKG/gP2pGnrP8AVY74u/8hqrBkMeHa6z7wPPKV3sA5S6KZQ8e5HeQ0G9ip7oP9GZS
         IVUIurThCJQAcE6gzoAFhukZMkGDAFacUc13T54n9r5zVy2jN/M8QiR1jrgretThp6
         ggbjME6WvG0qa/WTlU59HFV8jIxbx3G8vZVkrzlK0UTkOolcQ1X8dYzjHFyC8S8Fak
         bUf+u+n3FAaSw==
Date:   Tue, 29 Jan 2019 14:08:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Dai <daidavid1@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: linux-next: manual merge of the char-misc tree with the qcom tree
Message-ID: <20190129140846.4dc4c158@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CZfcs.RrhR6kzgnlCitpHrj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CZfcs.RrhR6kzgnlCitpHrj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  arch/arm64/boot/dts/qcom/sdm845.dtsi

between commits:

  05556681948b ("arm64: dts: sdm845: Add videocc node")
  5b6f186f0abb ("arm64: dts: sdm845: Add rpmh powercontroller node")

from the qcom tree and commit:

  ae0037dbfc5e ("arm64: dts: sdm845: Add interconnect provider DT nodes")

from the char-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0ec827394e92,5179cb94c95b..000000000000
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@@ -7,16 -7,13 +7,17 @@@
 =20
  #include <dt-bindings/clock/qcom,dispcc-sdm845.h>
  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 +#include <dt-bindings/clock/qcom,gpucc-sdm845.h>
 +#include <dt-bindings/clock/qcom,lpass-sdm845.h>
  #include <dt-bindings/clock/qcom,rpmh.h>
 +#include <dt-bindings/clock/qcom,videocc-sdm845.h>
+ #include <dt-bindings/interconnect/qcom,sdm845.h>
  #include <dt-bindings/interrupt-controller/arm-gic.h>
  #include <dt-bindings/phy/phy-qcom-qusb2.h>
 +#include <dt-bindings/power/qcom-rpmpd.h>
  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 +#include <dt-bindings/reset/qcom,sdm845-pdc.h>
  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 -#include <dt-bindings/clock/qcom,gcc-sdm845.h>
 =20
  / {
  	interrupt-parent =3D <&intc>;
@@@ -2075,55 -1604,10 +2076,60 @@@
  				#clock-cells =3D <1>;
  			};
 =20
 +			rpmhpd: power-controller {
 +				compatible =3D "qcom,sdm845-rpmhpd";
 +				#power-domain-cells =3D <1>;
 +				operating-points-v2 =3D <&rpmhpd_opp_table>;
 +
 +				rpmhpd_opp_table: opp-table {
 +					compatible =3D "operating-points-v2";
 +
 +					rpmhpd_opp_ret: opp1 {
 +						opp-level =3D <RPMH_REGULATOR_LEVEL_RETENTION>;
 +					};
 +
 +					rpmhpd_opp_min_svs: opp2 {
 +						opp-level =3D <RPMH_REGULATOR_LEVEL_MIN_SVS>;
 +					};
 +
 +					rpmhpd_opp_low_svs: opp3 {
 +						opp-level =3D <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 +					};
 +
 +					rpmhpd_opp_svs: opp4 {
 +						opp-level =3D <RPMH_REGULATOR_LEVEL_SVS>;
 +					};
 +
 +					rpmhpd_opp_svs_l1: opp5 {
 +						opp-level =3D <RPMH_REGULATOR_LEVEL_SVS_L1>;
 +					};
 +
 +					rpmhpd_opp_nom: opp6 {
 +						opp-level =3D <RPMH_REGULATOR_LEVEL_NOM>;
 +					};
 +
 +					rpmhpd_opp_nom_l1: opp7 {
 +						opp-level =3D <RPMH_REGULATOR_LEVEL_NOM_L1>;
 +					};
 +
 +					rpmhpd_opp_nom_l2: opp8 {
 +						opp-level =3D <RPMH_REGULATOR_LEVEL_NOM_L2>;
 +					};
 +
 +					rpmhpd_opp_turbo: opp9 {
 +						opp-level =3D <RPMH_REGULATOR_LEVEL_TURBO>;
 +					};
 +
 +					rpmhpd_opp_turbo_l1: opp10 {
 +						opp-level =3D <RPMH_REGULATOR_LEVEL_TURBO_L1>;
 +					};
 +				};
 +			};
++
+ 			rsc_hlos: interconnect {
+ 				compatible =3D "qcom,sdm845-rsc-hlos";
+ 				#interconnect-cells =3D <1>;
+ 			};
  		};
 =20
  		intc: interrupt-controller@17a00000 {

--Sig_/CZfcs.RrhR6kzgnlCitpHrj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxPw74ACgkQAVBC80lX
0GwzuwgAhZYufATKQCwwILOAX/aMZ3vWJhPI1Dk9GbyvzZ6iCmx+A5F+RkM+f5WB
0DlgrHQc9GNRNvHHYHqLkkDXqjLMocOl5ASTjwKbOBsIAaCsgDRfYZLNIr/hsKaY
fqZCTKHGjMm7ObQmdfbjjtyLTGdgGFGu+4gxPQkhBTtZf/pvHpQ/fjQ1Aolwwzjo
nNo7XzprrYQsPEGEXokP2jxtXB1SKutPjy/70zohKMiUytr0E26OqE6tN+nT3Hak
P9/hpXHJj6pNwZZWbFdVv0hdODtkSoLmXqi75gtLjX7mYxhCC969xYwiO/IF/Zu9
5k1zl9VzvKMfb4BCC2IJ7gCUmwJ/Nw==
=BYPh
-----END PGP SIGNATURE-----

--Sig_/CZfcs.RrhR6kzgnlCitpHrj--
