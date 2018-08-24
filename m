Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5F0C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3484C21710
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="k2sBwWX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3484C21710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeHXM4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:56:47 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:32411 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbeHXM4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:56:47 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie2.idc.renesas.com with ESMTP; 24 Aug 2018 18:22:59 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id 11DCC6EB1F;
        Fri, 24 Aug 2018 18:22:59 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,281,1531753200"; 
   d="scan'208";a="290500756"
Received: from mail-os2jpn01lp0152.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.152])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2018 18:22:57 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3aM2CE108JInbUsVejPHfGMTeTSIcXuxiRDBc5l6aU=;
 b=k2sBwWX6nf7Nv5SWR7NOgZ1DVbFfdiKguUCfB6Fkl/1Nl7Y7zd1XyVqW2L+nybv02FjiTaeDZCDTaY+mzjUEdgKkS9A7QJ2ajI72m358sSaBshr6dWIW4WggZ0LnbJuNHZfEDjH1LekE5IgwjgCttgbJVkTJEZQX8zwgiVh1aDY=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB0253.jpnprd01.prod.outlook.com (10.161.135.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Fri, 24 Aug 2018 09:22:54 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::51b4:b6eb:46a3:a6b]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::51b4:b6eb:46a3:a6b%5]) with mapi id 15.20.1080.015; Fri, 24 Aug 2018
 09:22:54 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Thread-Topic: [PATCH 3/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Thread-Index: AQHUOuJYhP3ID7Y7XEqKHJjJBXyAzqTOoK8AgAABa4A=
Date:   Fri, 24 Aug 2018 09:22:53 +0000
Message-ID: <TY1PR01MB1770F42DC6505E30B645AC04C0360@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1535029653-7418-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535029653-7418-4-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180824091706.pcxymf7suyxcdprz@verge.net.au>
In-Reply-To: <20180824091706.pcxymf7suyxcdprz@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0253;20:rlc6kmIpHIocehelBkDU1A/t1ULOd8LOcDAiU3xGyCue1lr4vzZS8pVCRiFIDUi7mjf/U48wKqOyThOSv3I23MjKRXcYE4xjt4qgKaH2eylUAFXSBRy/up3l5Ultntp5btr9ujgn3ZyM/L4oIt+jPqBOghBZWFtDntu8b1fCGto=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 1501d55a-dafc-410e-2691-08d609a32c02
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0253;
x-ms-traffictypediagnostic: TY1PR01MB0253:
x-microsoft-antispam-prvs: <TY1PR01MB0253598B69A2DF72CFE8C58BC0360@TY1PR01MB0253.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:TY1PR01MB0253;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0253;
x-forefront-prvs: 07749F8C42
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(136003)(39860400002)(199004)(189003)(106356001)(105586002)(14454004)(2906002)(54906003)(229853002)(68736007)(316002)(25786009)(476003)(9686003)(345774005)(55016002)(6436002)(53936002)(478600001)(81166006)(44832011)(486006)(81156014)(74316002)(2900100001)(256004)(66066001)(3846002)(5250100002)(8676002)(6116002)(305945005)(446003)(11346002)(7736002)(86362001)(4326008)(5660300001)(26005)(6506007)(7416002)(6246003)(97736004)(76176011)(33656002)(102836004)(99286004)(186003)(6916009)(8936002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0253;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RB6hFEIElmHRJXg4eXWmm8fRCgsnBNiWLVV0a7M97kVSgrVKlJcznhfIx2NWsApz/dcwvZkS4L9N6bB3jswdG7dtlh/lUnbPoHhPMGMPKR1VAMgXIxzpfG/gxYsxGzXgj4qr4zXb0oV1/90SwsSkJe2d/wYDO2LX1N3HTJzHrd6MJyMpinYwhEKzgk0fUx+c5vijJc93wpWEbGLGGb5fyjtlM8hNsyrJuXXIuboV1Hp0kVV6TQ9Jxfzw3HY1J7djo20GEUAIP3An9/h7G2julkHzcJTPHKnjBYImoQFMh2p/QyjUsIgE5toSYbBQhd+lDRwr3oLVrDRn5HYbLn4QtK3LBH5ddcwN4RKdo3VbUiY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1501d55a-dafc-410e-2691-08d609a32c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2018 09:22:53.9589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Simon,

Thank you for your feedback!

> Subject: Re: [PATCH 3/3] dt-bindings: can: rcar_can: Add r8a774a1 support
>
> On Thu, Aug 23, 2018 at 02:07:33PM +0100, Fabrizio Castro wrote:
> > Document RZ/G2M (r8a774a1) SoC specific bindings and RZ/G2
> > generic bindings.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
>
> Are we sure these clocks are for all RZ/G2 SoCs?

Yeah, that's the expectation.

Thanks,
Fab

> If so:
>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>
> > ---
> >
> > This patch applies on next-20180823
> >
> >  Documentation/devicetree/bindings/net/can/rcar_can.txt | 11 ++++++++--=
-
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/D=
ocumentation/devicetree/bindings/net/can/rcar_can.txt
> > index 94a7f33..ae8fccc 100644
> > --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > @@ -4,6 +4,7 @@ Renesas R-Car CAN controller Device Tree Bindings
> >  Required properties:
> >  - compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A=
7743 SoC.
> >        "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC=
.
> > +      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 S=
oC.
> >        "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC=
.
> >        "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC=
.
> >        "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC=
.
> > @@ -17,6 +18,7 @@ Required properties:
> >        "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
> >        compatible device.
> >        "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible devi=
ce.
> > +      "renesas,rzg-gen2-can" for a generic RZ/G2 compatible device.
> >        When compatible with the generic version, nodes must list the
> >        SoC-specific version corresponding to the platform first
> >        followed by the generic version.
> > @@ -24,7 +26,9 @@ Required properties:
> >  - reg: physical base address and size of the R-Car CAN register map.
> >  - interrupts: interrupt specifier for the sole interrupt.
> >  - clocks: phandles and clock specifiers for 3 CAN clock inputs.
> > -- clock-names: 3 clock input name strings: "clkp1", "clkp2", "can_clk"=
.
> > +- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk=
".
> > +       3 clock input name strings for every other SoC: "clkp1", "clkp2=
",
> > +       "can_clk".
> >  - pinctrl-0: pin control group to be used for this controller.
> >  - pinctrl-names: must be "default".
> >
> > @@ -41,8 +45,9 @@ using the below properties:
> >  Optional properties:
> >  - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid value=
s are:
> >      <0x0> (default) : Peripheral clock (clkp1)
> > -    <0x1> : Peripheral clock (clkp2)
> > -    <0x3> : Externally input clock
> > +    <0x1> : Peripheral clock (clkp2) (not supported by
> > +    RZ/G2 devices)
> > +    <0x3> : External input clock
> >
> >  Example
> >  -------
> > --
> > 2.7.4
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
