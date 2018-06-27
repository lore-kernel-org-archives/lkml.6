Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D468C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6E62660D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onelaird.onmicrosoft.com header.i=@onelaird.onmicrosoft.com header.b="USv+DirJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6E62660D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lairdtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeF0Im3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:42:29 -0400
Received: from mail-dm3nam03on0099.outbound.protection.outlook.com ([104.47.41.99]:56458
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752230AbeF0ImW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onelaird.onmicrosoft.com; s=selector1-lairdtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7d3lphuA701a2YMQEvAeiNgyVXipFr2zd8EN8zV1Gg=;
 b=USv+DirJeHS2z9BEbkaiGQiNYZLOWD9JfBj0hNtZe1P5B8q8tmiyqyUoEuLfeAM2v+dytciJrR0niHlOX9TqskA4GXOrFYTSMFmyrceXyqIwq3Xwjzr9FAIYwRkacWhLpQKcTkwd85K8feHGzNPVCgSPEPvrwHra62taMSEiHIE=
Received: from BY1PR02MB1114.namprd02.prod.outlook.com (10.162.108.140) by
 BY1PR02MB1209.namprd02.prod.outlook.com (10.162.108.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Wed, 27 Jun 2018 08:42:18 +0000
Received: from BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::d5c4:ef81:b513:f5da]) by BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::d5c4:ef81:b513:f5da%3]) with mapi id 15.20.0884.024; Wed, 27 Jun 2018
 08:42:17 +0000
From:   Ben Whitten <Ben.Whitten@lairdtech.com>
To:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ben Whitten <ben.whitten@gmail.com>
Subject: RE: [PATCH v2 4/6] arm: dts: add support for Laird WB50N cpu module
 and DVK
Thread-Topic: [PATCH v2 4/6] arm: dts: add support for Laird WB50N cpu module
 and DVK
Thread-Index: AQHUBK62KLwSSbe270qAF8A3mcrIRKRz2uGw
Date:   Wed, 27 Jun 2018 08:42:17 +0000
Message-ID: <BY1PR02MB1114B9B363091FC26668E454E7480@BY1PR02MB1114.namprd02.prod.outlook.com>
References: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
 <1529070055-18701-4-git-send-email-ben.whitten@lairdtech.com>
In-Reply-To: <1529070055-18701-4-git-send-email-ben.whitten@lairdtech.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Whitten@lairdtech.com; 
x-originating-ip: [109.174.151.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR02MB1209;7:fYcwu4ATRaQPqSkcHjzW/XbBxEXS3JPBGM7rCQioelw44n3GI1yVQf3lpyIzgqpPl4Tz93tHAvV6eQ7lsbyaqr11dXh8cgFiqXtOzAStUkLkCauRNQj7xJ1NL3mzP1bPZKfooGTFwn9FRmQygnOw9XXooAHlx4ubzc/Zl6l7SBxKaVegBoOC4RRk01MdGeEkDKDe4o+VVEN4MqFpbg8Jhg2hh4AerA/k2s8vHobtkw+lPP3UHeNNko2bw7EHi5FN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 75460bb3-6457-4009-debc-08d5dc09e3c8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BY1PR02MB1209;
x-ms-traffictypediagnostic: BY1PR02MB1209:
x-microsoft-antispam-prvs: <BY1PR02MB12096EE10C0D9D0BB4FDEA0FE7480@BY1PR02MB1209.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(44402351742967);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY1PR02MB1209;BCL:0;PCL:0;RULEID:;SRVR:BY1PR02MB1209;
x-forefront-prvs: 0716E70AB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(229853002)(72206003)(4326008)(2906002)(11346002)(2501003)(25786009)(476003)(105586002)(66066001)(446003)(966005)(486006)(6116002)(256004)(3846002)(54906003)(14444005)(99286004)(106356001)(5250100002)(81166006)(5660300001)(6436002)(316002)(68736007)(86362001)(110136005)(76176011)(6506007)(7696005)(6306002)(2900100001)(55016002)(102836004)(478600001)(97736004)(26005)(53936002)(9686003)(74316002)(186003)(39060400002)(305945005)(81156014)(7736002)(14454004)(8676002)(33656002)(8936002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY1PR02MB1209;H:BY1PR02MB1114.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lairdtech.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xU/+WXMfh3Cci6LWoXm9eyHrt/rQOZTgjP/unm0+cMnXLC4la3sxkIsmbbvd84g3KdMQEM7mxrAsPnHvOJCJTk1wDFCS0aiC2i4ZQ3CxYPRjC+2iM8+5uVBWHSMXi3EYMQxsyPo0/r8mnFewPpLCEyk6McAJynTIegqVt62mP8+DL+wJ5CD+ILo0uH2Ku6nDv2EGRS+e7KmgoiLmuXScLPgKfwpQDBtsZi+JLl0Qy8R32Cp2aeF/EWblFa8m7nXCibvA2jt8nK3LUxw93edTl6/yda+S4uqLC3vYjr5r//QKHOFfYKFbA92D92ZQUB24whZ4Vfw+71JWQtGnrrZDCZaRpdOboPBj3uieppDS/Bk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lairdtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75460bb3-6457-4009-debc-08d5dc09e3c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2018 08:42:17.6108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4d27a54-2db1-4088-a044-1a83c778ad1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB1209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

As you are planning a clock binding rework and this patch in the series
needs a change to account for that, do you want me to re-submit after
your series or are we good to go as is?

Thanks,
Ben
=20
> This adds support for Lairds CPU module, featuring Atheros wifi, CSR
> Bluetooth and, Atmel SAMA5D3 CPU.
> https://www.lairdtech.com/products/wb50nbt-wi-fi-bluetooth-module
>=20
> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
> ---
>  arch/arm/boot/dts/Makefile        |   1 +
>  arch/arm/boot/dts/at91-wb50n.dts  | 112 +++++++++++++++++++++
>  arch/arm/boot/dts/at91-wb50n.dtsi | 198
> ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 311 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-wb50n.dts
>  create mode 100644 arch/arm/boot/dts/at91-wb50n.dtsi
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 04604d2..07823be 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -52,6 +52,7 @@ dtb-$(CONFIG_SOC_SAM_V7) +=3D \
>  	at91-sama5d2_xplained.dtb \
>  	at91-sama5d3_xplained.dtb \
>  	at91-tse850-3.dtb \
> +	at91-wb50n.dtb \
>  	sama5d31ek.dtb \
>  	sama5d33ek.dtb \
>  	sama5d34ek.dtb \
> diff --git a/arch/arm/boot/dts/at91-wb50n.dts b/arch/arm/boot/dts/at91-
> wb50n.dts
> new file mode 100644
> index 0000000..8cecc70
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-wb50n.dts
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * at91-wb50n.dts - Device Tree file for wb50n evaluation board
> + *
> + *  Copyright (C) 2018 Laird
> + *
> + */
> +
> +/dts-v1/;
> +#include "at91-wb50n.dtsi"
> +
> +/ {
> +	model =3D "Laird Workgroup Bridge 50N - Atmel SAMA5D";
> +	compatible =3D "laird,wb50n", "atmel,sama5d31", "atmel,sama5d3",
> "atmel,sama5";
> +
> +	gpio_keys {
> +		compatible =3D "gpio-keys";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		btn0@10 {
> +			reg =3D <10>;
> +			label =3D "BTNESC";
> +			linux,code =3D <1>; /* ESC button */
> +			gpios =3D <&pioA 10 GPIO_ACTIVE_LOW>;
> +			gpio-key,wakeup =3D <1>;
> +		};
> +
> +		irqbtn@31 {
> +			reg =3D <31>;
> +			label =3D "IRQBTN";
> +			linux,code =3D <99>; /* SysReq button */
> +			gpios =3D <&pioE 31 GPIO_ACTIVE_LOW>;
> +			gpio-key,wakeup =3D <1>;
> +		};
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		led0 {
> +			label =3D "wb50n:blue:led0";
> +			gpios =3D <&pioA 12 GPIO_ACTIVE_LOW>;
> +			default-state =3D "off";
> +		};
> +
> +		led1 {
> +			label =3D "wb50n:green:led1";
> +			gpios =3D <&pioA 24 GPIO_ACTIVE_LOW>;
> +			default-state =3D "off";
> +		};
> +
> +		led2 {
> +			label =3D "wb50n:red:led2";
> +			gpios =3D <&pioA 26 GPIO_ACTIVE_LOW>;
> +			default-state =3D "off";
> +		};
> +	};
> +};
> +
> +&watchdog {
> +	status =3D "okay";
> +};
> +
> +&mmc0 {
> +	status =3D "okay";
> +};
> +
> +&macb1 {
> +	status =3D "okay";
> +};
> +
> +&dbgu {
> +	status =3D "okay";
> +};
> +
> +/* On BB40 this port is labeled UART1 */
> +&usart0 {
> +	status =3D "okay";
> +};
> +
> +/* On BB40 this port is labeled UART0 */
> +&usart1 {
> +	status =3D "okay";
> +};
> +
> +&i2c0 {
> +	status =3D "okay";
> +};
> +
> +&spi1 {
> +	status =3D "okay";
> +
> +	spidev@0 {
> +		compatible =3D "spidev";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <8000000>;
> +	};
> +};
> +
> +&usb0 {
> +	status =3D "okay";
> +};
> +
> +&usb1 {
> +	status =3D "okay";
> +};
> +
> +&usb2 {
> +	status =3D "okay";
> +};
> +
> diff --git a/arch/arm/boot/dts/at91-wb50n.dtsi b/arch/arm/boot/dts/at91-
> wb50n.dtsi
> new file mode 100644
> index 0000000..85692c8
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-wb50n.dtsi
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * at91-wb50n.dtsi - Device Tree include file for wb50n cpu module
> + *
> + *  Copyright (C) 2018 Laird
> + *
> + */
> +
> +#include "sama5d31.dtsi"
> +
> +/ {
> +	model =3D "Laird Workgroup Bridge 50N - Atmel SAMA5D";
> +	compatible =3D "laird,wb50n", "atmel,sama5d31", "atmel,sama5d3",
> "atmel,sama5";
> +
> +	chosen {
> +		bootargs =3D "ubi.mtd=3D6 root=3Dubi0:rootfs rootfstype=3Dubifs
> rw";
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	memory {
> +		reg =3D <0x20000000 0x4000000>;
> +	};
> +};
> +
> +&pinctrl {
> +	board {
> +		pinctrl_mmc0_cd: mmc0_cd {
> +			atmel,pins =3D <AT91_PIOC 26 AT91_PERIPH_GPIO
> AT91_PINCTRL_PULL_UP_DEGLITCH>; /* PC26 GPIO with pullup deglitch */
> +		};
> +
> +		pinctrl_usba_vbus: usba_vbus {
> +			atmel,pins =3D <AT91_PIOB 13 AT91_PERIPH_GPIO
> AT91_PINCTRL_DEGLITCH>; /* PB13 GPIO with deglitch */
> +		};
> +	};
> +};
> +
> +&slow_xtal {
> +	clock-frequency =3D <32768>;
> +};
> +
> +&main_xtal {
> +	clock-frequency =3D <12000000>;
> +};
> +
> +&slow_osc {
> +	atmel,osc-bypass;
> +};
> +
> +&usart1_clk {
> +	atmel,clk-output-range =3D <0 132000000>;
> +};
> +
> +&mmc0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3
> &pinctrl_mmc0_cd>;
> +	cd-gpios =3D <&pioC 26 GPIO_ACTIVE_LOW>;
> +	slot@0 {
> +		reg =3D <0>;
> +		bus-width =3D <4>;
> +	};
> +};
> +
> +&mmc1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3>;
> +	status =3D "okay";
> +	atheros@0 {
> +		compatible =3D "atheros,ath6kl";
> +		atheros,board-id =3D "SD32";
> +		reg =3D <0>;
> +		bus-width =3D <4>;
> +	};
> +};
> +
> +&macb1 {
> +	phy-mode =3D "rmii";
> +};
> +
> +&dbgu {
> +	dmas =3D <0>, <0>;	/*  Do not use DMA for dbgu */
> +};
> +
> +/* On BB40 this port is labeled UART1 */
> +&usart0 {
> +	atmel,use-dma-rx;
> +	atmel,use-dma-tx;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_usart0 &pinctrl_usart0_rts_cts>;
> +};
> +
> +/* On BB40 this port is labeled UART0 */
> +&usart1 {
> +	atmel,use-dma-rx;
> +	atmel,use-dma-tx;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_usart1 &pinctrl_usart1_rts_cts>;
> +	dtr-gpios =3D <&pioD 13 GPIO_ACTIVE_LOW>;
> +	dsr-gpios =3D <&pioD 11 GPIO_ACTIVE_LOW>;
> +	dcd-gpios =3D <&pioD 7 GPIO_ACTIVE_LOW>;
> +	rng-gpios =3D <&pioD 8 GPIO_ACTIVE_LOW>;
> +};
> +
> +/* USART3 is direct-connect to the Bluetooth UART on the radio SIP */
> +&usart3 {
> +	atmel,use-dma-rx;
> +	atmel,use-dma-tx;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_usart3 &pinctrl_usart3_rts_cts>;
> +	status =3D "okay";
> +};
> +
> +&spi1 {
> +	cs-gpios =3D <&pioC 25 0>, <0>, <0>, <0>;
> +};
> +
> +&ebi {
> +	pinctrl-0 =3D <&pinctrl_ebi_nand_addr>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +};
> +
> +&nand_controller {
> +	status =3D "okay";
> +
> +	nand: nand@3 {
> +		reg =3D <0x3 0x0 0x2>;
> +		atmel,rb =3D <0>;
> +		nand-bus-width =3D <8>;
> +		nand-ecc-mode =3D "hw";
> +		nand-ecc-strength =3D <8>;
> +		nand-ecc-step-size =3D <512>;
> +		nand-on-flash-bbt;
> +		label =3D "atmel_nand";
> +
> +		partitions {
> +			compatible =3D "fixed-partitions";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +
> +			at91bootstrap@0 {
> +				label =3D "at91bs";
> +				reg =3D <0x0 0x20000>;
> +			};
> +
> +			uboot@20000 {
> +				label =3D "u-boot";
> +				reg =3D <0x20000 0x80000>;
> +			};
> +
> +			ubootenv@a0000 {
> +				label =3D "u-boot-env";
> +				reg =3D <0xa0000 0x20000>;
> +			};
> +
> +			ubootenv@c0000 {
> +				label =3D "u-boot-env";
> +				reg =3D <0xc0000 0x20000>;
> +			};
> +
> +			kernel-a@e0000 {
> +				label =3D "kernel-a";
> +				reg =3D <0xe0000 0x500000>;
> +			};
> +
> +			kernel-b@5e0000 {
> +				label =3D "kernel-b";
> +				reg =3D <0x5e0000 0x500000>;
> +			};
> +
> +			rootfs-a@ae0000 {
> +				label =3D "rootfs-a";
> +				reg =3D <0xae0000 0x3000000>;
> +			};
> +
> +			rootfs-b@3ae0000 {
> +				label =3D "rootfs-b";
> +				reg =3D <0x3ae0000 0x3000000>;
> +			};
> +
> +			user@6ae0000 {
> +				label =3D "user";
> +				reg =3D <0x6ae0000 0x14e0000>;
> +			};
> +		};
> +	};
> +};
> +
> +&usb0 {
> +	atmel,vbus-gpio =3D <&pioB 13 GPIO_ACTIVE_LOW>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_usba_vbus>;
> +};
> +
> +&usb1 {
> +	num-ports =3D <3>;
> +	atmel,vbus-gpio =3D <&pioA 2 GPIO_ACTIVE_LOW>;
> +	atmel,oc-gpio =3D <&pioA 4 GPIO_ACTIVE_LOW>;
> +};
> --
> 2.7.4

