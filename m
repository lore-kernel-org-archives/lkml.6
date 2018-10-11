Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A105AC677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8AD20645
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tIpQ57Yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8AD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeJLAxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:53:54 -0400
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:42627
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbeJLAxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSq03roP8PSqMcYvANdZ+P1jIXATxF4QkjsuDqKiz9I=;
 b=tIpQ57Yn31aloAHj3e+OW34Ha8OhTGhfWsbHnTDaIy11SlxyRpILOYnlHmp7f2f2ezTvgMVKA77wTBfX8gTCEKJXFYS2PnRCBphbEFUWvQhWvrjXIe3vjZvzG9C67QC79WYaeN+Eckag9/m8SdgHpUhBho5PZRVeLKdUqGS9udg=
Received: from AMSPR04MB503.eurprd04.prod.outlook.com (10.242.107.152) by
 AMSPR04MB311.eurprd04.prod.outlook.com (10.242.107.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Thu, 11 Oct 2018 17:25:40 +0000
Received: from AMSPR04MB503.eurprd04.prod.outlook.com
 ([fe80::d081:5636:5890:c63c]) by AMSPR04MB503.eurprd04.prod.outlook.com
 ([fe80::d081:5636:5890:c63c%8]) with mapi id 15.20.1228.020; Thu, 11 Oct 2018
 17:25:39 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
CC:     Xiaobo Xie <xiaobo.xie@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] arm64: dts: lx2160a: enable eSDHC controller
Thread-Topic: [PATCH v2] arm64: dts: lx2160a: enable eSDHC controller
Thread-Index: AQHUYS0ecwImYsIKL0qynaPPkxilKKUaSpxA
Date:   Thu, 11 Oct 2018 17:25:39 +0000
Message-ID: <AMSPR04MB503AE4F55B3FAE7E77842218FE10@AMSPR04MB503.eurprd04.prod.outlook.com>
References: <20181011063522.7767-1-yinbo.zhu@nxp.com>
In-Reply-To: <20181011063522.7767-1-yinbo.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AMSPR04MB311;6:W/EWlHZMQv9MndRmu10cBVfP+DUGmHFqrWVLGGnuW4cclRs3uJnUqbfiVs3Ofc/bplTdyTLe5gZFJGVve8ESIGvXF4Gw6FxzU3OThx+6jRdL+1puVdce6y5hRKS0Z+lGftCeS1i9mF1HF3syEYb5zhknaWxGLh0dENaHJY0WwGfO2nt6GeJSzwi7PbtWnVIebuMEpHn33zEtYrI0uvnVA79tN6Pf3YDghOzt7Lkl8R2J9nEcbEToMrD8rHghl00Jk1X7MBqGu80HxXJioU4Dcmpuv2yqNjtbubrmWmjo0Tn+jAx2xMhp4YB7zkcRSr0btSmr+zHTUMnBihJExy67ltaF8qEBSvKiLFedoWtFkQhWkXptxca57qg7LisJFtCMjTkKLTU2UHObpEXYMR8I5Ysp43Y29VRaq1kRC6rLWhArYPmMNXN0u17r73BVHt9z/oF+ooM1jbOP9con6XZYmQ==;5:qZg0cpMhxzznJTlfGYM/wGaoANQjZt6ZxJOnPWfHDPAQTckEyBWg6nj0Te2X1ESnA2mldFl20nKV2zewtBSeiEwg7FmiGunQpq1lgrRzYYYK054XExnMwgtqxJQfcgYZOJ5ZWEloMPdHb7ePujLD57pC5DH9Kl4KUOBTGOWrDus=;7:Dn4Vkki6e0OYO11ODuMgLGaGU5SY/qcasuY4PhqxTio2+hTMzWqRQnzjKwKedR+70botoKxLB30hWDikwr24IFnx7EbuYEQH3EyyIDbAIRh1oeNkXijlrTOOCv2SwvgG5+3lD1WzDaIyXqZIcnGq3o59szKll/FqC4dsUGvwdtn4ArEVwIYdzYL1mppXwMLlFaleNsLBdKMlVTzQnEbQ4iDqPm0oEFosFKGsXxVsyZT3p287efB8gnBDdidAicmX
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b25e8b50-dc0b-45be-ef24-08d62f9e90a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AMSPR04MB311;
x-ms-traffictypediagnostic: AMSPR04MB311:
x-microsoft-antispam-prvs: <AMSPR04MB311C8CB1C6A30F90C7C21148FE10@AMSPR04MB311.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(185117386973197)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AMSPR04MB311;BCL:0;PCL:0;RULEID:;SRVR:AMSPR04MB311;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(39860400002)(376002)(13464003)(199004)(189003)(106356001)(11346002)(110136005)(33656002)(25786009)(54906003)(68736007)(446003)(4326008)(186003)(486006)(5660300001)(476003)(316002)(97736004)(5250100002)(81156014)(6506007)(53546011)(8676002)(71200400001)(256004)(14444005)(71190400001)(6116002)(2501003)(3846002)(86362001)(81166006)(55016002)(66066001)(105586002)(26005)(102836004)(9686003)(8936002)(575784001)(7696005)(6306002)(229853002)(7736002)(2906002)(76176011)(14454004)(53936002)(74316002)(305945005)(478600001)(2900100001)(6246003)(6636002)(6436002)(966005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AMSPR04MB311;H:AMSPR04MB503.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CA52S+sSpNaq59oAEmsvPgyQWZtrbM1HlgFeDw6HEPsmCA+JZ9nIRFITaQCjN30Hnogw0fUgk3Rljq/1VdXuKDw2jwJSDSln6qZjnJe5hu8WQyPnzew7x7WaMBDF9WfFJjjps68HoUaIf4+SsgOqdcX6laJtj8mUEPg9c8qQrmDNmIv7tFW7Ow5uiO8tJd7vHnN6uTv4HHsJmdMqE8RKjQmWCy0lahZF1CcauVc+U/WWuf7K52BqSPmWF7DfoW0AROx/dfrWLAoBtzx9mnozb8k4phAfVG+mhxAloBCTVjNeyU8z6qlKaiIjNMOzRf8Ppa9+c5ii8gLXmkMfa/Z/Uy1aCtZPyl9rs2ohU//EBC8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25e8b50-dc0b-45be-ef24-08d62f9e90a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 17:25:39.6369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMSPR04MB311
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Yinbo Zhu <yinbo.zhu@nxp.com>
> Sent: Thursday, October 11, 2018 1:35 AM
> To: Yinbo Zhu <yinbo.zhu@nxp.com>; Y.b. Lu <yangbo.lu@nxp.com>; linux-
> mmc@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>;
> ulf.hansson@linaro.org; Leo Li <leoyang.li@nxp.com>
> Cc: Xiaobo Xie <xiaobo.xie@nxp.com>; devicetree@vger.kernel.org; linux-
> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v2] arm64: dts: lx2160a: enable eSDHC controller
>=20
> There are two eSDHC controllers in lx2160a. This patch is to enable eSDHC=
 for
> RDB and QDS board.
>=20
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
> Change in v2:
> 		squash all lx2160a esdhc dts patch into the original patch

Hi Yinbo,

What I meant is that the eSDHC nodes should be squashed into the patches ad=
ding these device tree.  I don't see a good reason that SDHC nodes should b=
e a separate patch for now, especially when the original patch is still bei=
ng reviewed and could be changing.
https://lore.kernel.org/patchwork/patch/995433/
https://lore.kernel.org/patchwork/patch/995434/

Regards,
Leo
>=20
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |    8 ++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   15 ++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   25
> +++++++++++++++++++++
>  3 files changed, 48 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> index bc30173..b58b96c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -294,6 +294,14 @@
>  	status =3D "okay";
>  };
>=20
> +&esdhc0 {
> +	status =3D "okay";
> +};
> +
> +&esdhc1 {
> +	status =3D "okay";
> +};
> +
>  &dspi0 {
>  	dflash0: n25q128a {
>  		#address-cells =3D <1>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 53b0e80..cbe8919 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -170,6 +170,21 @@
>  	status =3D "okay";
>  };
>=20
> +&esdhc0 {
> +	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr12;
> +	status =3D "okay";
> +};
> +
> +&esdhc1 {
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	bus-width =3D <8>;
> +	status =3D "okay";
> +};
> +
>  &fspi {
>  	status =3D "okay";
>  	nxp,fspi-has-second-chip;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index fa4a1f8..174544a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -356,6 +356,31 @@
>  			little-endian;
>  		};
>=20
> +		esdhc0: esdhc@2140000 {
> +			compatible =3D "fsl,esdhc";
> +			reg =3D <0x0 0x2140000 0x0 0x10000>;
> +			interrupts =3D <0 28 0x4>; /* Level high type */
> +			clocks =3D <&clockgen 4 1>;
> +			voltage-ranges =3D <1800 1800 3300 3300>;
> +			sdhci,auto-cmd12;
> +			little-endian;
> +			bus-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		esdhc1: esdhc@2150000 {
> +			compatible =3D "fsl,esdhc";
> +			reg =3D <0x0 0x2150000 0x0 0x10000>;
> +			interrupts =3D <0 63 0x4>; /* Level high type */
> +			clocks =3D <&clockgen 4 1>;
> +			voltage-ranges =3D <1800 1800 3300 3300>;
> +			sdhci,auto-cmd12;
> +			broken-cd;
> +			little-endian;
> +			bus-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
>  		gpio0: gpio@2300000 {
>  			compatible =3D "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2300000 0x0 0x10000>;
> --
> 1.7.1

