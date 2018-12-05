Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6316C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E56520989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vzO4S/lp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E56520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbeLEUce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:32:34 -0500
Received: from mail-eopbgr800075.outbound.protection.outlook.com ([40.107.80.75]:51776
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727388AbeLEUcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDSuj0A2J7N4J4Uyu/aBKvW2A2UW3OsZGbvNHSY27JQ=;
 b=vzO4S/lpbRC0sQmZdIslCA3vWW2V3+hzMMox/pJFb5yy/CpieWPVxxCssWOCEovH66jsozh4qMY3JkXF3vNh24Wy4XiBFWUS4xmjAmOdAqFzynxY6h4mQr2prdFPTXoiLK5Qy+mgKcuMSbX3x11kx5HebTOMuYRw03ucJ6I0SaA=
Received: from SN4PR0201MB3536.namprd02.prod.outlook.com (10.167.129.22) by
 SN4PR0201MB3630.namprd02.prod.outlook.com (10.167.129.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 20:29:37 +0000
Received: from SN4PR0201MB3536.namprd02.prod.outlook.com
 ([fe80::7492:e6eb:4d44:d8b0]) by SN4PR0201MB3536.namprd02.prod.outlook.com
 ([fe80::7492:e6eb:4d44:d8b0%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 20:29:36 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP core
Thread-Topic: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP core
Thread-Index: AQHUfggvkVKuttW8xEq5Oarr4c4vt6VvPxIAgAFr3pA=
Date:   Wed, 5 Dec 2018 20:29:36 +0000
Message-ID: <SN4PR0201MB3536E825E836337D1535B812B8A80@SN4PR0201MB3536.namprd02.prod.outlook.com>
References: <1542412619-387-1-git-send-email-jollys@xilinx.com>
 <20181204220612.GA640@bogus>
In-Reply-To: <20181204220612.GA640@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR0201MB3630;6:EbtJ9FjLiYYdyaMjR1do2ssxL4QLGA09ienQGrHWBBG5xZiIoRhRbzlsD22JVPZJ5SrI0/O6dqGtq7dw52qyOQqfcbH/LJmXvstfNym5dUCbTWrBOEKa+GWJqV/eAiCs0e4m9NpgEk7JyzzsfGrRG71GsZ/htd0fQbaBM6+POEtd++QdOWmniamevDin9ci1p6GJBMYHyCqMDEltsXC1XDT+Uq0nvxIqwaIvRa+8CVm+pLXyvq4wJggHULD3pFZm9V/8PdyqRIPMo4+bIedsIGpefeGBgDnyCfpTW0GPxu3egAomT0sGtgAS2zykXLtzVHDmpW2kpCRhxhXXNhATE5bNSd9XcLX00ZnWoVFHBBSDAIOUuNBZHb1jqv5GAGJF8+oN7/7XStDkc7YJWFnroW+dNBqXUU3KWguLu90dDT3CzZivStf5EE59VE2tWRKSaLd5N4sC5zQ+IPmg8OEC0Q==;5:RLaE6HX6CiREGkr62uIopVstgOGhZ6plRckookmukGKbQfc8vUZVQ/s8eDdqRsPJMAMZwjaURrN+iEl4qhy2Us6bwwD0EMaEfA2pCO4zXYgXhPlj8J+Uq+VyS0wx5dh2cJuVgTgfCs/Loyy0XcK0aBLXDtLP04bbntO0sKFIKm0=;7:DeWWkvYvi5ooJauoQMFyB/cdvcYOBiTFvCTjKepLz4iLXIqX8OSEaf6gn6kuNXYyCdxqyxYy1KaWIJ0nllLYA1dr1bL1TqXKNz/9RLFtRFsbGVF1cJy0eXIhNus9PmuyfGXNmQSsa6jecxvfjzTcWg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(13464003)(189003)(199004)(51914003)(446003)(186003)(68736007)(486006)(54906003)(316002)(476003)(102836004)(4326008)(33656002)(8676002)(2906002)(66066001)(9686003)(6436002)(26005)(6116002)(99286004)(74316002)(14454004)(3846002)(53936002)(72206003)(55016002)(97736004)(478600001)(11346002)(5660300001)(256004)(6246003)(25786009)(6916009)(76176011)(105586002)(7696005)(106356001)(7736002)(86362001)(575784001)(8936002)(229853002)(305945005)(71190400001)(71200400001)(6506007)(81156014)(53546011)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3630;H:SN4PR0201MB3536.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: bf04a7d8-6200-4555-1b9e-08d65af05fc0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN4PR0201MB3630;
x-ms-traffictypediagnostic: SN4PR0201MB3630:
x-microsoft-antispam-prvs: <SN4PR0201MB3630B19415D15F9B8D2A71CAB8A80@SN4PR0201MB3630.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN4PR0201MB3630;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3630;
x-forefront-prvs: 08770259B4
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iS9MFPTNjzpLeohjW4BZZymarhN4yPolUUDYZ65+k+//O6Dczpr0mNBKL42ponYu6NBJ4Op4FMwX7jnNGX2WWAp/CehNHyiUKXnhmFa5Yl8kT/ZPIZxzcAXImhASGLZ2Y7pB7ZXLKfjt/OPElkPxbUlYg6+J7Fw+7v1NDtY65CDuoymhuddh5JpiVqrSfiu/9oFxUdXy3t7rTvcGoDryFFN80UscGuaIf3+C9T/3BfWmdOQh89B2UmKZ/+OC5rLMNVQUCL4EXmrpiNObApHAlQZD4D0nESNkxMAcMObm9u9RMSrTbIbzuy96l4xjZEAZ2i90UUuuH/EUTCDSCsQ27smaCqVbVrDXJ6IROFmjNKw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf04a7d8-6200-4555-1b9e-08d65af05fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 20:29:36.3549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review. Please find my responses inline.

Thanks,
Jolly Shah

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, December 04, 2018 2:06 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: mark.rutland@arm.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP co=
re
>=20
> On Fri, Nov 16, 2018 at 03:56:50PM -0800, Jolly Shah wrote:
> > Base firmware node and clock child node binding are part of mainline ke=
rnel.
> This patchset adds documentation to describe rest of the firmware child n=
ode
> bindings.
> > Complete firmware DT node example is shown below for ease of
> understanding:
>=20
> Shouldn't there be a fpga mgr node too? Called pcap IIRC.
>=20
[Jolly] As you suggested, we only added child nodes if the sub-functions ha=
ve their own resources (clks, irqs, etc.). FPGA doesn't have any resources =
so not added . Firmware driver would still register it as mfd device to ins=
tantiate the driver.

> >
> > firmware {
> > 	zynqmp_firmware: zynqmp-firmware {
> > 		compatible =3D "xlnx,zynqmp-firmware";
> > 		method =3D "smc";
> > 		#power-domain-cells =3D <1>;
> > 		#reset-cells =3D <1>;
> >
> > 		zynqmp_clk: clock-controller {
> > 			#clock-cells =3D <1>;
> > 			compatible =3D "xlnx,zynqmp-clk";
> > 			clocks =3D <&pss_ref_clk>, <&video_clk>,
> <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> > 			clock-names =3D "pss_ref_clk", "video_clk",
> "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
> > 		};
> >
> > 		zynqmp_power: zynqmp-power {
> > 			compatible =3D "xlnx,zynqmp-power";
> > 			interrupts =3D <0 35 4>;
> > 		};
> >
> > 		nvmem_firmware {
> > 			compatible =3D "xlnx,zynqmp-nvmem-fw";
> > 			#address-cells =3D <1>;
> > 			#size-cells =3D <1>;
> >
> > 			/* Data cells */
> > 			soc_revision: soc_revision {
> > 				reg =3D <0x0 0x4>;
> > 			};
> > 		};
> >
> > 		afi0: afi0 {
> > 			compatible =3D "xlnx,afi-fpga";
> > 			config-afi =3D <0 2>, <1 1>, <2 1>;
> > 		};
> >
> > 		qspi: spi@ff0f0000 {
>=20
> Why is this under firmware node?
[Jolly] Qspi is a user of eemi API provided by firmware node to perform pri=
vileged register writes. Alternatively, we can keep such user nodes outside=
 of firmware node and keep nodes which firmware is provider for like clock,=
 reset, pins and power.
Please suggest.

>=20
> > 			compatible =3D "xlnx,zynqmp-qspi-1.0";
> > 			clock-names =3D "ref_clk", "pclk";
> > 			clocks =3D <&misc_clk &misc_clk>;
> > 			interrupts =3D <0 15 4>;
> > 			interrupt-parent =3D <&gic>;
> > 			num-cs =3D <1>;
> > 			reg =3D <0x0 0xff0f0000 0x1000>,<0x0 0xc0000000
> 0x8000000>;
> > 		};
> >
> > 		serdes: zynqmp_phy@fd400000 {
>=20
> And this?

[Jolly] Same as above.

>=20
> > 			compatible =3D "xlnx,zynqmp-psgtr";
> > 			status =3D "okay";
> > 			reg =3D <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000
> 0x0 0x1000>,
> > 				<0x0 0xff5e0000 0x0 0x1000>;
> > 			reg-names =3D "serdes", "siou", "lpd";
> >
> > 			lane0: lane@0 {
> > 				#phy-cells =3D <4>;
> > 			};
> > 			lane1: lane@1 {
> > 				#phy-cells =3D <4>;
> > 			};
> > 			lane2: lane@2 {
> > 				#phy-cells =3D <4>;
> > 			};
> > 			lane3: lane@3 {
> > 				#phy-cells =3D <4>;
> > 			};
> > 		};
> >
> > 		pinctrl_uart1_default: uart1-default {
>=20
> This goes under a pinctrl node.
[Jolly] Pincontrol node is not added as it doesn't have any resources. As I=
 understand, you suggest to still add pincontrol node and this under pincon=
trol node.

>=20
> > 			mux {
> > 				groups =3D "uart0_4_grp";
> > 				function =3D "uart0";
> > 			};
> >
> > 			conf {
> > 				groups =3D "uart0_4_grp";
> > 				slew-rate =3D <SLEW_RATE_SLOW>;
> > 				io-standard =3D <IO_STANDARD_LVCMOS18>;
> > 			};
> >
> > 			conf-rx {
> > 				pins =3D "MIO18";
> > 				bias-high-impedance;
> > 			};
> >
> > 			conf-tx {
> > 				pins =3D "MIO19";
> > 				bias-disable;
> > 				schmitt-cmos =3D <PIN_INPUT_TYPE_CMOS>;
> > 			};
> > 		};
> > 		zynqmp-r5-remoteproc@0 {
>=20
> Wrong unit-address and this doesn't belong here.
[Jolly]  Again as it is one of the user of firmware APIs, its kept here. Al=
ternatively, we can keep such user nodes outside of firmware node and keep =
nodes which firmware is provider for like clock, reset, pins and power.
Please suggest.

>=20
> > 			compatible =3D "xlnx,zynqmp-r5-remoteproc-1.0";
>=20
> 'remoteproc' is what the h/w block is called?

[Jolly] The hw block is called rpu.=20

Thanks,
Jolly Shah=20

>=20
> > 			reg =3D <0x0 0xFFE00000 0x0 0x10000>,
> > 				<0x0 0xFFE20000 0x0 0x10000>,
> > 				<0x0 0xff340000 0x0 0x100>;
> > 			reg-names =3D "tcm_a", "tcm_b", "ipi";
> > 			dma-ranges;
> > 			core_conf =3D "split0";
> > 			memory-region =3D <&rproc_0_fw_reserved>,
> > 					<&rproc_0_dma_reserved>;
> > 			tcm-pnode-id =3D <0xf>, <0x10>;
> > 			rpu-pnode-id =3D <0x7>;
> > 			interrupt-parent =3D <&gic>;
> > 			interrupts =3D <0 29 4>;
> > 		};
> > 	};
> > };
