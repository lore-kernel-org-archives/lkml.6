Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9781CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D98D20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="BZQEMUVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D98D20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeKHXlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:41:14 -0500
Received: from mail-os2jpn01on0133.outbound.protection.outlook.com ([104.47.92.133]:23538
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbeKHXlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWKhVFG6qJrzxSEh93q4HSuGrStgkxRYmreUstK8ff8=;
 b=BZQEMUVSJCACPEZQ084HcYWXttbMr+8bWMxSwOeiDcPTvqOMIzZ0lokFOkutX2bykH1eHgY4BcFpd8ouCJQNdjsORJJk0ThGMep2KAtULfaAaLPFCI0lwwpWYlrV9e1lLOukh7tjQ3UvECdEMhPQXv6Drr3fpJN9W+vWuUiGbdc=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1644.jpnprd01.prod.outlook.com (52.133.163.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Thu, 8 Nov 2018 14:05:29 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 14:05:29 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Simon Horman <horms@verge.net.au>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Wolfgang Grandegger <wg@grandegger.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Thread-Topic: [PATCH v2 2/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Thread-Index: AQHUSPMgnV7YcVxKm0CbO3oTvHgR86VGGWKAgAAW3gCAABXiwA==
Date:   Thu, 8 Nov 2018 14:05:29 +0000
Message-ID: <TY1PR01MB1770EA27994C36DD1595BEAFC0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1536576195-11520-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1536576195-11520-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB17709C158FEAC53383231CB7C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20181108124632.fd52533ws7l7j2r2@verge.net.au>
In-Reply-To: <20181108124632.fd52533ws7l7j2r2@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1644;20:qfjrCDjScmncEkpyWxiFzJmN9Jt4sLIK+wsj4PrdH4qa1VULH0lsTJBJvR2jaEQoe0dfcnn142ygn39ZQEXXvzOcvy8xayHcyNR8Movs0jGlC+RGxejbFuOXidRwOn6dn/C9niL2xXQ6HC9FEw8OviwwHkApRA6jqljt8MUZrnk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 5aa8a89c-bba3-412a-b778-08d645833daa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1644;
x-ms-traffictypediagnostic: TY1PR01MB1644:
x-microsoft-antispam-prvs: <TY1PR01MB16446C4EAE3B56F88A505BF6C0C50@TY1PR01MB1644.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1644;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1644;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(7736002)(68736007)(229853002)(305945005)(74316002)(99286004)(316002)(7416002)(7696005)(86362001)(110136005)(6506007)(53546011)(54906003)(5660300001)(102836004)(105586002)(26005)(71190400001)(76176011)(186003)(71200400001)(8676002)(11346002)(81166006)(81156014)(446003)(106356001)(476003)(256004)(44832011)(486006)(8936002)(33656002)(55016002)(93886005)(478600001)(4326008)(9686003)(25786009)(6246003)(53936002)(14454004)(97736004)(6116002)(2900100001)(2906002)(66066001)(3846002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1644;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4UL4LIjfeSXkVksn2UBfyQxztE9+OHQcjyoWfq6sPVhhqlkjFDNru+XNuMpI1g4o3pbLeBQ7zWoBh7VsKpg7KYAuK9TpQP53jvKs3rtz2rjqZFwoqscA5aI0BfLbPvgxSTVpmpuLFpWkONAd+nknINlj0kMm1uJfdpqgeggHgdPLr83YKtx5NjldvlTh68xlAuj8umtWSg6w/ejgMigE/7FY1jgVrJLT4cB4rKY9IoEfeHifF2HBHNcufxHTOoAN50PFP9PgaWAKrpT7Wer0EYHaci3odaClu/5LccDHSkBBZyjFGBiiAIwgVdanlQFHcCn3x14JWUTBTJed/S9QjAhrJ5BRJDSGjaq65xrMjNM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa8a89c-bba3-412a-b778-08d645833daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 14:05:29.6213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Simon for getting back to me.

Marc, does this patch look ok to you?

Thanks,
Fab

> Subject: Re: [PATCH v2 2/3] dt-bindings: can: rcar_can: Add r8a774a1 supp=
ort
>
> On Thu, Nov 08, 2018 at 11:25:23AM +0000, Fabrizio Castro wrote:
> > Dear All,
> >
> > Who is the best person to take this patch?
>
> I believe this one is for Marc.
>
> > Thanks,
> > Fab
> >
> > > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > Sent: 10 September 2018 11:43
> > > Subject: [PATCH v2 2/3] dt-bindings: can: rcar_can: Add r8a774a1 supp=
ort
> > >
> > > Document RZ/G2M (r8a774a1) SoC specific bindings.
> > >
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > > ---
> > > v1->v2:
> > > * dropped "renesas,rzg-gen2-can" and fixed "clocks" property descript=
ion
> > >   as per Geert's comments.
> > >
> > > This patch applies on top of next-20180910.
> > >
> > >  Documentation/devicetree/bindings/net/can/rcar_can.txt | 18 ++++++++=
+++++-----
> > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > > index 94a7f33..f3b160c 100644
> > > --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > > +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > > @@ -4,6 +4,7 @@ Renesas R-Car CAN controller Device Tree Bindings
> > >  Required properties:
> > >  - compatible: "renesas,can-r8a7743" if CAN controller is a part of R=
8A7743 SoC.
> > >        "renesas,can-r8a7745" if CAN controller is a part of R8A7745 S=
oC.
> > > +      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1=
 SoC.
> > >        "renesas,can-r8a7778" if CAN controller is a part of R8A7778 S=
oC.
> > >        "renesas,can-r8a7779" if CAN controller is a part of R8A7779 S=
oC.
> > >        "renesas,can-r8a7790" if CAN controller is a part of R8A7790 S=
oC.
> > > @@ -16,15 +17,21 @@ Required properties:
> > >        "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible de=
vice.
> > >        "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
> > >        compatible device.
> > > -      "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible de=
vice.
> > > +      "renesas,rcar-gen3-can" for a generic R-Car Gen3 or RZ/G2
> > > +      compatible device.
> > >        When compatible with the generic version, nodes must list the
> > >        SoC-specific version corresponding to the platform first
> > >        followed by the generic version.
> > >
> > >  - reg: physical base address and size of the R-Car CAN register map.
> > >  - interrupts: interrupt specifier for the sole interrupt.
> > > -- clocks: phandles and clock specifiers for 3 CAN clock inputs.
> > > -- clock-names: 3 clock input name strings: "clkp1", "clkp2", "can_cl=
k".
> > > +- clocks: phandles and clock specifiers for 2 CAN clock inputs for R=
Z/G2
> > > +  devices.
> > > +  phandles and clock specifiers for 3 CAN clock inputs for every oth=
er
> > > +  SoC.
> > > +- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_c=
lk".
> > > +       3 clock input name strings for every other SoC: "clkp1", "clk=
p2",
> > > +       "can_clk".
> > >  - pinctrl-0: pin control group to be used for this controller.
> > >  - pinctrl-names: must be "default".
> > >
> > > @@ -41,8 +48,9 @@ using the below properties:
> > >  Optional properties:
> > >  - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid val=
ues are:
> > >      <0x0> (default) : Peripheral clock (clkp1)
> > > -    <0x1> : Peripheral clock (clkp2)
> > > -    <0x3> : Externally input clock
> > > +    <0x1> : Peripheral clock (clkp2) (not supported by
> > > +    RZ/G2 devices)
> > > +    <0x3> : External input clock
> > >
> > >  Example
> > >  -------
> > > --
> > > 2.7.4
> >
> >
> >
> >
> > Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne En=
d, Buckinghamshire, SL8 5FH, UK. Registered in England
> & Wales under Registered No. 04586709.
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
