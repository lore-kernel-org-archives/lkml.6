Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FA6C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18412084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cv8OCing"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18412084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeLLIPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:15:46 -0500
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]:46912
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbeLLIPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j577UFQm6tUkBFG7pknwb2vjdGtSlVoBDgIFZORg1A=;
 b=Cv8OCinglZrgY8X6e44EZ+35/1O972qsZpDbXgz9ttbiUwsDLNYCW/xGPKbqNonPbZd5Yvdt1hIyNcN8q+IiDTio/3ehjkdZlVEC7A5mdjEnXV8OtYmWFpDVfEio6ucxnOUlT1uD58lKBZfhjS/6UfpKI2k8akIHsqexFQzVZvg=
Received: from HE1PR0402MB3323.eurprd04.prod.outlook.com (10.167.125.20) by
 HE1PR0402MB2731.eurprd04.prod.outlook.com (10.175.35.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Wed, 12 Dec 2018 08:15:41 +0000
Received: from HE1PR0402MB3323.eurprd04.prod.outlook.com
 ([fe80::f95d:89f3:77e0:b668]) by HE1PR0402MB3323.eurprd04.prod.outlook.com
 ([fe80::f95d:89f3:77e0:b668%5]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 08:15:40 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v5 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Topic: [PATCH v5 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Index: AQHUfZ2C+fi/K12gmEKCWnU9UR10jKV66icQ
Date:   Wed, 12 Dec 2018 08:15:40 +0000
Message-ID: <HE1PR0402MB332315D53C681D842865B6B5F1A70@HE1PR0402MB3323.eurprd04.prod.outlook.com>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1542366701-16065-4-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1542366701-16065-4-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0402MB2731;6:pUNqSCbMf1R69UjYQ3NyPk0uxYDaTQLezW890B0p0DyNf5yNrHU/EuC/wEw6mM583v+gfZw8V3IaViuDLx8e+DO2tStbD8U0rKBke0AmhAg1wAl6Px5mugfTQG2QUNBxjVDH7wAwknk85ub92QKz37eDfSDJM8Nrx8TkDDolGCVv5AtkLWxzAaw2Fd79OyQi5R3HvC1s7Kaapn+rXwPwkVCgTVoPkdoR2i8D7Q6lI1fjtTI5qeS4OmCKbHmv8lweWbblKzz2P4C+EUW+2P4tKN5QgOQoJaBUnET5+Vxpub9z7XS7L+6XK4u1ipAbQLc43FU3qT/9x+5oZXHbfiPYECGIs9hPmAdZ6AE1/pLfVHGg/28in4vFdpgK+6kGZxVLdOdL8z/lTcpT+2KI0XGYEaUvjYTmwovtNi0/7dET9wqTDEZtnsWduChkpTP0ElpbFGSKkYMM6XG7gOBIOwLCiw==;5:xuhDJlE8zIowYiKOxcPP94hPq2pCCx0KKBojWVPemahjpyIx2xbfm+lAVq5kpm68xAB8d4qazPzb3OjSTSoG5mkm/7uC63dXlOoPYQQXO2qz4U4xSWQvC2V3d/F35h/AMZDUcF8cLDYFVGNBIShplHmZ/i5Pb1wlq/HmeHL3JRM=;7:4ctazt+uQU8hsM3inNNm0pRnnpsbLQyuOoWSbJzg+hGhAhcgFHQjvU7rxTb6NE0u37x9gK0yD+k4+1tghXWtZnSyioiYSmS80EaSLapTfvtoAFyC+VpDyVB04Ug06P9lnrbqJ1bkfShrq1dJxBvAJQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8dfd9127-5f36-4b35-ef2a-08d6600a0168
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0402MB2731;
x-ms-traffictypediagnostic: HE1PR0402MB2731:
x-microsoft-antispam-prvs: <HE1PR0402MB2731832475A1303D736C114BF1A70@HE1PR0402MB2731.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231472)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:HE1PR0402MB2731;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0402MB2731;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(13464003)(189003)(199004)(256004)(44832011)(8676002)(71190400001)(33656002)(2501003)(486006)(66066001)(97736004)(14444005)(305945005)(106356001)(6506007)(99286004)(53546011)(7736002)(102836004)(81156014)(81166006)(26005)(74316002)(7696005)(8936002)(110136005)(316002)(68736007)(54906003)(476003)(186003)(11346002)(446003)(5660300001)(14454004)(9686003)(2906002)(478600001)(25786009)(39060400002)(7416002)(76176011)(6246003)(6436002)(55016002)(105586002)(4326008)(86362001)(2201001)(3846002)(6116002)(229853002)(71200400001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0402MB2731;H:HE1PR0402MB3323.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WFRs7y80SS6ykAzJXyIpFLP0lH6Eu+rvzx0XM32Pfe5q2JdU54WrLFUkIez7ZhS95SP9//POGCsZXJvLxMj1ZLgduDGHVRBCiQ4JhQu2Cr0W60i1o6czYYL/4o5wLHNg3GjRtz0GU3Wxh8U83kO/r4JIJd+HGfZwVmbDgjxjvBMWCm+v3c6/bVzUxA1mRt4v+I/n7R1RamMQ/TkeJsES7d7tLIgAqOEATqtn5EQYL1foq3EHrBKh4g2dYGxtEFhflOFkj/B/5NvlorwLYlqxVFHvrtB7py7QR50g9QdpHOuFYhSaOD1wthEHPZKNLQJ6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfd9127-5f36-4b35-ef2a-08d6600a0168
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 08:15:40.7516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2731
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: devicetree-owner@vger.kernel.org [mailto:devicetree-
> owner@vger.kernel.org] On Behalf Of Yogesh Narayan Gaur
> Sent: Friday, November 16, 2018 4:44 PM
> To: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com;
> marek.vasut@gmail.com; broonie@kernel.org; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-
> arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@kontron.de; linux-kernel@vger.kernel.org; Yogesh Narayan
> Gaur <yogeshnarayan.gaur@nxp.com>
> Subject: [PATCH v5 3/5] arm64: dts: lx2160a: add FlexSPI node property
>=20
> Add fspi node property for LX2160A SoC for FlexSPI driver.
> Property added for the FlexSPI controller and for the connected slave dev=
ice for
> the LX2160ARDB target.
> This is having two SPI-NOR flash device, mt35xu512aba, connected at CS0 a=
nd
> CS1.
>=20
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
> Changes for v5:
> - None
> Changes for v4:
> - Incorporated Rob review comments.
> Changes for v3:
> - None.
> Changes for v2:
> - - Incorporated Shawn review comments.
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 22
> ++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 13 +++++++++++++
>  2 files changed, 35 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 1483071..3b20c97 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -35,6 +35,28 @@
>  	status =3D "okay";
>  };
>=20
> +&fspi {
> +	status =3D "okay";
> +
> +	mt35xu512aba0: flash@0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "spansion,m25p80";
> +		m25p,fast-read;
> +		spi-max-frequency =3D <20000000>;

The SPI flash supports 50MHz frequency. Please update to 50Mhz

> +		reg =3D <0>;
> +	};
> +
> +	mt35xu512aba1: flash@1 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "spansion,m25p80";
> +		m25p,fast-read;
> +		spi-max-frequency =3D <20000000>;
> +		reg =3D <1>;
> +	};
> +};
> +
>  &i2c0 {
>  	status =3D "okay";
>  	i2c-mux@77 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index c758268..5d0025a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -698,5 +698,18 @@
>  			interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
>  			timeout-sec =3D <30>;
>  		};
> +
> +		fspi: spi@20c0000 {
> +			compatible =3D "nxp,lx2160a-fspi";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0x0 0x20c0000 0x0 0x10000>,
> +				<0x0 0x20000000 0x0 0x10000000>;
> +			reg-names =3D "fspi_base", "fspi_mmap";
> +			interrupts =3D <0 25 0x4>; /* Level high type */
> +			clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names =3D "fspi_en", "fspi";
> +			status =3D "disabled";
> +		};
>  	};
>  };
> --
> 2.7.4

