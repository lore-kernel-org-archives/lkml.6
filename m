Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A927C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2719220664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="VJKKBmlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2719220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbeJaWmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:42:23 -0400
Received: from mail-os2jpn01on0099.outbound.protection.outlook.com ([104.47.92.99]:32160
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729313AbeJaWmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+t1H7JtW/sa4tPaJ2Se2pDr309KeDWcYyFCv6gp1BY=;
 b=VJKKBmlrouqretHAItxoOjlwvQlyN55Y91jxeDwbVT7bs+9iddQW6xBQ9Ely82VA+k4eyz3Akt2GXxpQ4Rt7W4/mKtWqIw/iz03+x05x6ime3XaGiObe9GSlcDFX+cTs4TOla507JYHm6BMwZ4137HsKqwyEPsaFJR+p4oD36oc=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1593.jpnprd01.prod.outlook.com (52.133.162.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Wed, 31 Oct 2018 13:43:59 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%4]) with mapi id 15.20.1273.028; Wed, 31 Oct 2018
 13:43:59 +0000
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
Subject: RE: [PATCH v2 1/2] dt-bindings/interrupt-controller: rzn1: Add RZ/N1
 gpio irq mux binding
Thread-Topic: [PATCH v2 1/2] dt-bindings/interrupt-controller: rzn1: Add RZ/N1
 gpio irq mux binding
Thread-Index: AQHUcD2dbpfo8FEemU21B7rfUFcsDKU4aUwAgADwijA=
Date:   Wed, 31 Oct 2018 13:43:59 +0000
Message-ID: <TY1PR01MB176943688317D3099AD69727F5CD0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181030104438.27827-1-phil.edworthy@renesas.com>
 <20181030104438.27827-2-phil.edworthy@renesas.com>
 <20181030230420.GA25133@bogus>
In-Reply-To: <20181030230420.GA25133@bogus>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1593;20:nypFKQo4o53Ax488PICwQjNLZ/dED8yetUhGUb6Kwd17U2Ai86Ji2hGGiwolKjt4K92CPtpgQgiyJBTnK6QA58zAORcSG96PEpNQuKBnT7dcdc6SMfigraj2ehAZPwCsC5RhbQDuqcBDpKHNvVZSfZrKoGEmtC7tg7ZoVH3h4iA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c1da76e5-86b3-454d-5394-08d63f36e960
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1593;
x-ms-traffictypediagnostic: TY1PR01MB1593:
x-microsoft-antispam-prvs: <TY1PR01MB1593C66788983F79EA37DEC0F5CD0@TY1PR01MB1593.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1593;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1593;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(346002)(366004)(39860400002)(189003)(51444003)(199004)(81156014)(229853002)(25786009)(14444005)(256004)(66066001)(102836004)(4326008)(97736004)(6916009)(53546011)(14454004)(26005)(5250100002)(2900100001)(105586002)(478600001)(6506007)(316002)(106356001)(54906003)(55016002)(71190400001)(99286004)(33656002)(9686003)(71200400001)(76176011)(7696005)(68736007)(486006)(6436002)(2906002)(3846002)(6116002)(476003)(8676002)(446003)(11346002)(6246003)(81166006)(53936002)(8936002)(86362001)(305945005)(7736002)(74316002)(186003)(44832011)(5660300001)(357404004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1593;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L2KmGe4Y+wArbd5doh1U3Mw2HUKyYqP5znj5iUWBRnPwmsnbED2SUI9wmmWbB040IZL/xhGF5zdHS1lkjxMuTRnDcVuA0GwXufVYqavhvs705tV+iFraxNejUYCPN1baZ58un22iNxvplCyxqTMj9lktVEo7KdquUJXlmtC5B01lfbzgGP9tyc8X13hWSL1a0rJAxI1u7w6gKOeVgNnqUYjwQUCOPx+3llIPf23NIFWMho/arcGP6Zojs7XwxUH0vdrr7ugT06Yzzcd20ylekDuHMXFrrv3yjdK0tgBGvDp1q1dOe1JdHvZr0qlE0pcaMcjA63M3ctBIy8IETnIvrQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1da76e5-86b3-454d-5394-08d63f36e960
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 13:43:59.3348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1593
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Many thanks for a quick review!

On 30 October 2018 23:04, Rob Herring wrote:
> On Tue, Oct 30, 2018 at 10:44:37AM +0000, Phil Edworthy wrote:
> > Add device binding documentation for the Renesas RZ/N1 GPIO interrupt
> > multiplexer.
> >
<snip>

> This looks a bit strange...
>=20
> > +
> > +	gpioirqmux: gpioirqmux@51000480 {
> > +		compatible =3D "renesas,r9a06g032-gpioirqmux",
> > +				"renesas,rzn1-gpioirqmux";
> > +		reg =3D <0x51000480 0x20>;
> > +
>=20
> > +		interrupt-controller;
> > +		#interrupt-cells =3D <1>;
> > +		interrupt-parent =3D <&gpioirqmux_map>;
> > +		interrupts =3D
> > +			<0 1 17>,	/* gpio1a 17 */
> > +			<1 1 24>,	/* gpio1a 24 */
> > +			<2 1 26>;	/* gpio1a 26 */
>=20
> Remove all these and...
>
> > +
> > +		gpioirqmux_map: gpioirqmux-map {
>=20
> Move everything in this node up a level.
>=20
> > +			#interrupt-cells =3D <3>;
>=20
> This should be 1.
>=20
> Or perhaps 2 cells if you need the GPIO controller index (cell 2 above).
> But is that numbering really meaningful to the GPIO irq mux or does it ju=
st
> have Nx32 inputs? #interrupt-cells should be defined based on the GPIO ir=
q
> mux, not what it is connected to. You could always have a single linear
> number space and mask out bits to get banks if you need to.
You are absolutely correct, the irq mux should not concern itself with wher=
e
interrupts came from, all it sees is 96 inputs.


> > +			#address-cells =3D <0>;
> > +			interrupt-map-mask =3D <7 0 0>;
>=20
> Then 1 cell here, but the mask should be 31.
>=20
> > +			interrupt-map =3D
> > +				<0 0 0 &gic GIC_SPI 103
> IRQ_TYPE_LEVEL_HIGH>,
>=20
> Then this should be:
>=20
> <17 &gic GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>
>=20
> > +				<1 0 0 &gic GIC_SPI 104
> IRQ_TYPE_LEVEL_HIGH>,
>=20
> <24 &gic GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>
>=20
> If I understand what you are trying to do. :)
I think you do!

>=20
> If the 0-7 numbering and mapping to the downstream numbering was
> important (i.e. the 1 combined with 1 and 24 in the interrupts property),=
 then
> you can use the index of the interrupt-map entries for that.
Yes, the 0-7 numbering and mapping are important as we need to pin the inpu=
t
interrupt to a specific output interrupt due to firmware running on another=
 core.
Using the index makes complete sense.

> > +				<2 0 0 &gic GIC_SPI 105
> IRQ_TYPE_LEVEL_HIGH>,
> > +				<3 0 0 &gic GIC_SPI 106
> IRQ_TYPE_LEVEL_HIGH>,
> > +				<4 0 0 &gic GIC_SPI 107
> IRQ_TYPE_LEVEL_HIGH>,
> > +				<5 0 0 &gic GIC_SPI 108
> IRQ_TYPE_LEVEL_HIGH>,
> > +				<6 0 0 &gic GIC_SPI 109
> IRQ_TYPE_LEVEL_HIGH>,
> > +				<7 0 0 &gic GIC_SPI 110
> IRQ_TYPE_LEVEL_HIGH>;
>=20
> These all seem to be unused?
I think that's just an artefact of the way I abused interrupt-map!

Thanks
Phil

> > +		};
> > +	};
> > +
> > +	gpio1: gpio@5000c000 {
> > +		compatible =3D "snps,dw-apb-gpio";
> > +		reg =3D <0x5000c000 0x80>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +		clock-names =3D "bus";
> > +		clocks =3D <&sysctrl R9A06G032_HCLK_GPIO1>;
> > +
> > +		gpio1a: gpio-controller@0 {
> > +			compatible =3D "snps,dw-apb-gpio-port";
> > +			bank-name =3D "gpio1a";
> > +			gpio-controller;
> > +			#gpio-cells =3D <2>;
> > +			snps,nr-gpios =3D <32>;
> > +			reg =3D <0>;
> > +
> > +			interrupt-controller;
> > +			interrupt-parent =3D <&gpioirqmux>;
> > +			interrupts =3D   < 0  1  2  3  4  5  6  7
> > +					 8  9 10 11 12 13 14 15
> > +					16 17 18 19 20 21 22 23
> > +					24 25 26 27 28 29 30 31 >;
> > +			#interrupt-cells =3D <2>;
> > +		};
> > +	};
> > --
> > 2.17.1
>
