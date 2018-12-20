Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E88C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE45B2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dspGScL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbeLTKyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:54:40 -0500
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:52896
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbeLTKyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+8lBurfm7kEhvnaLupCSpq9KejOzhmRNRxbE2EVwKg=;
 b=dspGScL+ysbz0QM1ajbFDdRwO849UKd/tfLJqPkoRs3lcRIqhARq6X6RswFSUE8wVq38qYINYACZhvOScV8sb7pJksTZn8Rh3Iuu7NawfPezM0mhXfeWUXydOb+tRYBeIqLuFjbKljKlrzyNTFQey1I2S5ooVY2bPCb/NfH5OlA=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB3377.eurprd08.prod.outlook.com (20.177.109.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 20 Dec 2018 10:54:34 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db%5]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 10:54:34 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
Thread-Topic: [PATCH v2 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
Thread-Index: AQHUl5cAOCEuMH0GRUuCne9wdYhyiw==
Date:   Thu, 20 Dec 2018 10:54:34 +0000
Message-ID: <20181220105419.GA7599@james-ThinkStation-P300>
References: <20181219123147.16090-1-james.qian.wang@arm.com>
 <20181219123147.16090-3-james.qian.wang@arm.com>
 <CAL_JsqLsQ__dpu0Xh5zmLbOx_B8t0t0kJzoh-nOf=nuZSppAYg@mail.gmail.com>
In-Reply-To: <CAL_JsqLsQ__dpu0Xh5zmLbOx_B8t0t0kJzoh-nOf=nuZSppAYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0090.ausprd01.prod.outlook.com
 (2603:10c6:10:3::30) To AM0PR08MB4483.eurprd08.prod.outlook.com
 (2603:10a6:208:145::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3377;6:XDnlj4zO8mgynzrA3J+1Vx+nHfY64mYBzEN4RZPK/UBTaWFEk3RoEz7O2xBF8aG6hC7nxLmFIsPn9naVxtW5IxtUzZmS9JZBFpIza4PDLeBoIvyPp9muupfErwNZBI5OX1hjzq9cogG/cs5mmSqvG4Q0OenPijcjfniRxHIE6u60QzodaLFZxsi/W1J+UBDN+Jn/zCagfwm33vHbsN8fxJ5pPGqn+C9MUuk9e4eev828e2laapVbeVikmll9ZCDTtgPoABVENs2UpDQ5QjW9vyp1zqvmCbh1aRIuhYMLrgYGkSTdRrrV5Zr7tFqO+wdx1j3M3qeGjyg5vys84n7zbr5np0jVfActLJSqWNzZ0WoNEvVFyv82pstECoeqDWeqkCzT2aTqbR4EO1K++47SzdiCY1+2D+ZPDOoE3wd/WXvphKcxsc0q5gQiRP5pZHNxAMRsUWulH4OvqohB1wrQzg==;5:m+tC1/EMRLUFwYNG49Q4eNTZYnvMMSY+Yv7mf/muh9LvLsSAQWJvYVr1aFFcvYJZ70uKEINn739BPL97+s+loyGsITy75735/Lfw0dqS2UOCwSITldnvvZIE2zYlL5zRiCvZLkZ3IJa7pr3NaKRUMl4n3cMwq/VIuyvKt5cRyso=;7:dqnB/hNdQDo7Q+TUEar235oxqB0z+uFcvvvSKy1XQL5OPrpjc1J4xAUI+1rMc+ZMMkXRn3T6pLTEHXVlLls9621RYrSgE2W+hYtiz13a0cR8l0I0UKkmC/8eR3F3UYE3fqP3jSidm5RQENhaTR8lTw==
x-ms-office365-filtering-correlation-id: 31dad57f-af23-4ed3-33f6-08d6666986fd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3377;
x-ms-traffictypediagnostic: AM0PR08MB3377:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3377E7891CB414BD84B2788EB3BF0@AM0PR08MB3377.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3377;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3377;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(39860400002)(136003)(346002)(366004)(396003)(189003)(199004)(26005)(5660300001)(53936002)(6512007)(8936002)(9686003)(6306002)(8676002)(71190400001)(71200400001)(25786009)(4326008)(68736007)(7416002)(97736004)(256004)(14444005)(81156014)(1076003)(6246003)(966005)(81166006)(86362001)(2906002)(6436002)(3846002)(106356001)(105586002)(54906003)(6116002)(305945005)(33716001)(7736002)(33656002)(52116002)(14454004)(229853002)(11346002)(476003)(316002)(99286004)(76176011)(58126008)(33896004)(478600001)(386003)(53546011)(6506007)(186003)(486006)(6486002)(66066001)(55236004)(446003)(102836004)(18370500001)(87944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3377;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NRGrXBYCx3Oaq0fQ/PlNq0mbEuOHP11xbyI/KgL6K+vV8kxlOvfnxtIi1CALNlXDostrYwnmR58mv4TMHnQhbEiozY0q79qmvOT7W987hYUeB8Oq4XWpEwqEZk28PNUOjXQ/7DEuXZHnUCPKzwFluTH+khfyZ2KdlFjjqfsBuq+ECDf95EwWK/wCH9EBRHPQd34o4qK0DANqs7S2awxcek+n9YLOvs85MMi0GnOmasIc1K+kY3FA9EWxbaw6pknJXtbinrbo1siE9RRnM+N725Tnrh4zKO7J7CwAiDvco3OInTGxByymEK2UmP5KGwj0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0BC68A1DB0FB1C44B013DBA8EB76D7B4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31dad57f-af23-4ed3-33f6-08d6666986fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 10:54:34.4555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3377
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 07:55:44AM -0600, Rob Herring wrote:
> On Wed, Dec 19, 2018 at 6:33 AM james qian wang (Arm Technology China)
> <james.qian.wang@arm.com> wrote:
> >
> > Add DT bindings documentation for the ARM display processor D71 and lat=
er
> > IPs.
> >
> > Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
> > ---
> >  .../bindings/display/arm/arm,komeda.txt       | 87 +++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/arm/arm,k=
omeda.txt
> >
> > diff --git a/Documentation/devicetree/bindings/display/arm/arm,komeda.t=
xt b/Documentation/devicetree/bindings/display/arm/arm,komeda.txt
> > new file mode 100644
> > index 000000000000..d4b53c11b2a2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/arm/arm,komeda.txt
> > @@ -0,0 +1,87 @@
> > +Device Tree bindings for ARM Komeda display driver
> > +
> > +Required properties:
> > +- compatible: Should be "arm,mali-d71"
> > +- reg: Physical base address and length of the registers in the system
> > +- interrupts: the interrupt line numbers of the device in the system
>=20
> How many?

Sorry, only one interrupt. will fix it in the next version.=20

> > +- interrupt-names: contains the names of the IRQs in the order they we=
re
> > +    provided in the "interrupts" property. Must contain: "DPU".
>=20
> There's no point in *-names when there is only one entry.
>=20
> > +- clocks: A list of phandle + clock-specifier pairs, one for each entr=
y
> > +    in 'clock-names'
> > +- clock-names: A list of clock names. It should contain:
> > +      - "pclk": for the APB interface clock
> > +      - "mclk": for the main processor clock
>=20
> The order here doesn't match the example.

will fix it.

>=20
> > +- #address-cells: Must be 1
> > +- #size-cells: Must be 0
> > +
> > +Required properties for sub-node: pipeline@nq
> > +Each device contains one or two pipeline sub-nodes (at least one), eac=
h
> > +pipeline node should provide properties:
> > +- reg: Zero-indexed identifier for the pipeline
> > +- clocks: A list of phandle + clock-specifier pairs, one for each entr=
y
> > +    in 'clock-names'
> > +- clock-names: should contain:
> > +      - "aclk": AXI interface clock
> > +      - "pxclk": pixel clock
>=20
> The order here doesn't match the example.
>

will fix it in the next version.

> > +
> > +- port: each pipeline connect to an encoder input port. The connection=
 is
> > +    modelled using the OF graph bindings specified in
>=20
> modeled

will fix it.

>=20
> > +    Documentation/devicetree/bindings/graph.txt
> > +
> > +Optional properties:
> > +  - memory-region: phandle to a node describing memory (see
> > +    Documentation/devicetree/bindings/reserved-memory/reserved-memory.=
txt)
> > +    to be used for the framebuffer; if not present, the framebuffer ma=
y
> > +    be located anywhere in memory.
> > +
> > +Example:
> > +/ {
> > +       ...
> > +
> > +       dp0: display@c00000 {
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <0>;
> > +               compatible =3D "arm,mali-d71";
> > +               reg =3D <0xc00000 0x20000>;
> > +               interrupts =3D <0 168 4>;
> > +               interrupt-names =3D "DPU";
> > +               clocks =3D <&dpu_mclk>, <&dpu_aclk>;
> > +               clock-names =3D "mclk", "pclk";
> > +
> > +               pl0: pipeline@0 {
> > +                       clocks =3D <&fpgaosc2>, <&dpu_aclk>;
> > +                       clock-names =3D "pxclk", "aclk";
> > +                       reg =3D <0>;
>=20
> Is there a register range for each pipeline? If so, using that here
> would be better than index.

Sorry, there is no register range for the pipeline.

>=20
> > +
> > +                       ports {
> > +                               #address-cells =3D <1>;
> > +                               #size-cells =3D <0>;
> > +
> > +                               port@0 {
> > +                                       reg =3D <0>;
>=20
> You can drop 'ports' moving port up a level. And for a single port,
> you don't need reg.

you're right will fix it.
>=20
> > +                                       dp0_pl0_out: endpoint {
> > +                                               remote-endpoint =3D <&d=
b_dvi0_in>;
> > +                                       };
> > +                               };
> > +                       };
> > +               };
> > +               pl1: pipeline@1 {
> > +                       clocks =3D <&fpgaosc2>, <&dpu_aclk>;
> > +                       clock-names =3D "pxclk", "aclk";
> > +                       reg =3D <1>;
> > +
> > +                       ports {
> > +                               #address-cells =3D <1>;
> > +                               #size-cells =3D <0>;
> > +
> > +                               port@0 {
> > +                                       reg =3D <0>;
> > +                                       dp0_pl1_out: endpoint {
> > +                                               remote-endpoint =3D <&d=
b_dvi1_in>;
> > +                                       };
> > +                               };
> > +                       };
> > +               };
> > +       };
> > +       ...
> > +};
> > --
> > 2.17.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
