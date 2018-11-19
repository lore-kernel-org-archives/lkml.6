Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C319DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7189D2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="XWinTjJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7189D2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeKSUCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:02:42 -0500
Received: from mail-eopbgr1400111.outbound.protection.outlook.com ([40.107.140.111]:38157
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727450AbeKSUCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sph01hjzG0fIW7kWpuNcz8IfZTvRxq7bv8yBQSybsso=;
 b=XWinTjJZbb2r1TdZKhE8hdxYrezW7E5zNbdXW3DeoNYXba2ADhGKOHWFXZ58yXkkRWjbhvQgWAni4wQQxwAF3XE0Kpyhz8DwXQbB24/mb/69Q70iKsRzF7Xxo+PrcKXxAJJ+kKNijOqTDyg4uPn8EUN6H6vybRGtfwmyWawXm40=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1690.jpnprd01.prod.outlook.com (52.133.160.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 19 Nov 2018 09:39:34 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%5]) with mapi id 15.20.1294.047; Mon, 19 Nov 2018
 09:39:34 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindings/interrupt-controller: rzn1: Add RZ/N1
 gpio irq mux binding
Thread-Topic: [PATCH v3 1/2] dt-bindings/interrupt-controller: rzn1: Add RZ/N1
 gpio irq mux binding
Thread-Index: AQHUe1IdnqpGsbqZdUmUDVBl2HljTKVUDjSAgALLZWA=
Date:   Mon, 19 Nov 2018 09:39:33 +0000
Message-ID: <TY1PR01MB176917D755CB102AB5FD6BEAF5D80@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181113130910.22130-1-phil.edworthy@renesas.com>
 <20181113130910.22130-2-phil.edworthy@renesas.com>
 <20181117143253.GA27381@bogus>
In-Reply-To: <20181117143253.GA27381@bogus>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1690;20:zYLjJfAOMU0XFmTXNo/vJ+se/YkQUvuMD7bu95SlLJn5Rh7X28m/3c252HVgGGF6AWcXDG5maENi8hSIQNFGddyBki9Yru9uM4CKzDwPTwUsliMqBklR9K6Kg7zwuyvkMyv6YI8e90CvljpSXhImPOGChu4R2u5RZdAGPhYZQ6Y=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 23ac0f70-56c8-4635-7081-08d64e02e9f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1690;
x-ms-traffictypediagnostic: TY1PR01MB1690:
x-microsoft-antispam-prvs: <TY1PR01MB1690F0084306E80229A31957F5D80@TY1PR01MB1690.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1690;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1690;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(51914003)(229853002)(11346002)(476003)(478600001)(25786009)(105586002)(446003)(4326008)(6916009)(106356001)(97736004)(256004)(44832011)(81156014)(8936002)(5660300001)(8676002)(3846002)(2900100001)(81166006)(86362001)(54906003)(316002)(6506007)(53546011)(66066001)(71200400001)(74316002)(71190400001)(7736002)(486006)(102836004)(26005)(305945005)(6246003)(6436002)(186003)(9686003)(33656002)(53936002)(55016002)(99286004)(7696005)(76176011)(2906002)(6116002)(68736007)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1690;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: u2qApKAR2WfiYyHGjEQD+HOGol2z825LmHG9962WM0QtHtMOn/7AgkaSVU5mcciepo+HL/ColWxEokRH4xLCZARitfWaV/RyPU3YJ0WfdNVDr2eaN/ej9sfQlUkkYrXDVmBbl0MzBLNGwEEIUcaEVHmrmjdmk4jeqrt1+suUdpQbaPTuuZ+qzhDU84fgZi3fJDqGq2hcW1UGD+Ef2yTWgUGhk+FCrxzWy67Ks+9KU73cXXr6Bw1vQPKVFB0MofuZRpzvcH3Np3miMABjplJ9m5Pz0isLvuFqUaTK/l9InCegb/zos/L2qw4t7Yx4QkK0A+pZwgDytbyhMVpGX8hWbpgs+8q3ZcXqLFlNdz26kOc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ac0f70-56c8-4635-7081-08d64e02e9f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 09:39:33.8707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 17 November 2018 14:33 Rob Herring wrote:
> On Tue, Nov 13, 2018 at 01:09:09PM +0000, Phil Edworthy wrote:
> > Add device binding documentation for the Renesas RZ/N1 GPIO interrupt
> > multiplexer.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > v3:
> >  - Use 'interrupt-map' DT property correctly.
> > v2:
> >  - Use interrupt-map to allow the GPIO controller info to be specified
> >    as part of the irq.
> >  - Don't show status in binding examples.
> >  - Don't show the soc/board split in binding doc.
> > ---
> >  .../interrupt-controller/renesas,rzn1-mux.txt | 73
> > +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mu
> > x.txt
>=20
> A few nits, otherwise:
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
Thanks for the review!

> >
> > diff --git
> > a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-
> > mux.txt
> > b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-
> > mux.txt
> > new file mode 100644
> > index 000000000000..6515880e25cc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,r
> > +++ zn1-mux.txt
> > @@ -0,0 +1,73 @@
> > +* Renesas RZ/N1 GPIO Interrupt Multiplexer
> > +
> > +On Renesas RZ/N1 devices, there are several GPIO Controllers each
> > +with a number of interrupt outputs. All of the interrupts from the
> > +GPIO Controllers are passed to the GPIO Interrupt Multiplexer, which
> > +selects a sub-set of the interrupts to pass onto the system interrupt
> controller.
> > +
> > +A single node in the device tree is used to describe the GPIO IRQ Muxe=
r.
> > +
> > +Required properties:
> > +- compatible: SoC-specific compatible string "renesas,<soc-specific>-
> gpioirqmux"
> > +  followed by "renesas,rzn1-gpioirqmux" as fallback. The SoC-specific
> > +compatible
> > +  strings must be one of:
> > +	"renesas,r9a06g032-gpioirqmux" for RZ/N1D
> > +	"renesas,r9a06g033-gpioirqmux" for RZ/N1S
> > +- reg: Base address and size of GPIO IRQ Muxer registers.
> > +- interrupts: List of output interrupts.
> > +- #interrupt-cells: Numder of cells in the input interrupt specifier, =
must be
> 1.
> > +- #address-cells: Must be 0.
> > +- interrupt-map-mask: must be 127.
> > +- interrupt-map: Standard property detailing the maps between input
> > +irqs and the
> > +  corresponding output irq. This consist of a list of:
> > +	<input-irq-spec phandle-to-interrupt-controller output-irq-spec>
> > +  The input-irq-spec is from 0 to 95, corresponding to the outputs of
> > +the GPIO
> > +  Controllers.
> > +
> > +Example:
> > +
> > +	The following is an example for the RZ/N1D SoC.
> > +
> > +	gpioirqmux: gpioirqmux@51000480 {
>=20
> interrupt-controller@...
Sure

> > +		compatible =3D "renesas,r9a06g032-gpioirqmux",
> > +				"renesas,rzn1-gpioirqmux";
> > +		reg =3D <0x51000480 0x20>;
> > +		interrupts =3D
> > +			<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> > +			<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
>=20
> This is a bit redundant as the same information is in interrupt-map, but =
I
> guess you need it to get the irq resources.
That's right.

> > +
> > +		#interrupt-cells =3D <1>;
> > +		#address-cells =3D <0>;
> > +		interrupt-map-mask =3D <127>;
>=20
> Use hex for masks.
Ok.

> > +		interrupt-map =3D
> > +			/* gpio2a 24, pin 146: ETH Port 1 IRQ */
> > +			<88 &gic GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> > +			/* gpio2a 26, pin 148: TouchSCRN_IRQ */
> > +			<90 &gic GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> > +
> > +	gpio2: gpio@5000d000 {
> > +		compatible =3D "snps,dw-apb-gpio";
> > +		reg =3D <0x5000d000 0x80>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +		clock-names =3D "bus";
> > +		clocks =3D <&sysctrl R9A06G032_HCLK_GPIO2>;
> > +
> > +		gpio2a: gpio-controller@0 {
>=20
> gpio@0
Are you sure about this?
The bindings in Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
show an example where the sub-nodes for gpio banks are gpio-controller@.
This is also in Documentation/devicetree/bindings/gpio/gpio.txt.

Thanks
Phil

> > +			compatible =3D "snps,dw-apb-gpio-port";
> > +			bank-name =3D "gpio2a";
> > +			gpio-controller;
> > +			#gpio-cells =3D <2>;
> > +			snps,nr-gpios =3D <32>;
> > +			reg =3D <0>;
> > +
> > +			interrupt-controller;
> > +			interrupt-parent =3D <&gpioirqmux>;
> > +			interrupts =3D  < 64 65 66 67 68 69 70 71
> > +					72 73 74 75 76 77 78 79
> > +					80 81 82 83 84 85 86 87
> > +					88 89 90 91 92 93 94 95 >;
> > +			#interrupt-cells =3D <2>;
> > +		};
> > +	};
> > --
> > 2.17.1
> >
