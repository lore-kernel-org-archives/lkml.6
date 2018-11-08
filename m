Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CDFC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E5A21104
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="SO4OwixV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E5A21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeKHVAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:00:32 -0500
Received: from mail-os2jpn01on0100.outbound.protection.outlook.com ([104.47.92.100]:40592
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbeKHVAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddT8lTGY5+fefS+HwNKv5S4H8LLydEZTYEh+heN7xEw=;
 b=SO4OwixVFA0afErh3MkoSg7olwv51HSs4xIpJkYAzn8vDNz/9spjcJE3P8sm84zy6ZffeYDgRBzg5T/PlUUS8TEH3jRfEwjPWW9UnnTuLx2AAwhIxzIxd0SIQ81i7PkfGb1rF67gKdkjzVThIqf2Cv1VIp1aVRm0saBm9pIlGl4=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1817.jpnprd01.prod.outlook.com (52.133.162.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 8 Nov 2018 11:25:23 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:25:23 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Thread-Topic: [PATCH v2 2/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Thread-Index: AQHUSPMgnV7YcVxKm0CbO3oTvHgR86VGGWKA
Date:   Thu, 8 Nov 2018 11:25:23 +0000
Message-ID: <TY1PR01MB17709C158FEAC53383231CB7C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1536576195-11520-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1536576195-11520-3-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1536576195-11520-3-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1817;20:DSy9fsgnHihJgCyqgq9eZ/X+lWwEI39d0wDG6EdmJZGj8wZJDYQ+0fQEcYcmnRgBvN6cjSUx5BwRtbNDkIeJGVy296BlcrsSP99UZGQqDH98nyYMEBJNVQboJ8gNLKUlYvHOUfybk1f3hoiqEqS4VanUZhk0mDE3VsrucIB1bsg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 5f0282ac-a714-40a1-bd0e-08d6456cdfe0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1817;
x-ms-traffictypediagnostic: TY1PR01MB1817:
x-microsoft-antispam-prvs: <TY1PR01MB1817CC3CD5727A071B3163DEC0C50@TY1PR01MB1817.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1817;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1817;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(396003)(346002)(136003)(189003)(199004)(66066001)(71190400001)(4326008)(55016002)(25786009)(2906002)(6436002)(5660300001)(53936002)(6116002)(305945005)(68736007)(97736004)(71200400001)(3846002)(6246003)(86362001)(9686003)(110136005)(99286004)(74316002)(7736002)(54906003)(7416002)(7696005)(478600001)(316002)(76176011)(229853002)(8936002)(81166006)(81156014)(53546011)(6506007)(26005)(102836004)(33656002)(11346002)(8676002)(256004)(413944005)(106356001)(105586002)(446003)(186003)(476003)(14454004)(44832011)(486006)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1817;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /mZGodrBP2ykS0sPaOvRcxBhkz2QLwCQCgWs5k69uR8e/+qJQ4vu/gM8dUVeroh5xl89aCxmmNKBWsp+LEmWI+YaCnuM0eTquSA79zipyVJhDZPlPkogN5P1S9eux7Qz6A7sfwOiOnf+9m+5RFzwbnU/NhU5TOXTsGBxtoD2kDJMRA7B28GDAYhBq3Pc6sD+Cz+zbPliGqeDyoZd3RkdwiPWkDTrsqBIvoKL30MGuslXn0oOqtODy0AlJoCsjUnqsT9aqvlbUSjBxaaHbyQ7j8FDlvtKe39/jP+PtTLlQkmh7qwuqFouOCwXrLSJdd/CXErjyqYot7pr/ck5vRkNZKgL7l9avOmEHkPCJK72HbE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0282ac-a714-40a1-bd0e-08d6456cdfe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:25:23.1934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1817
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Who is the best person to take this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 10 September 2018 11:43
> Subject: [PATCH v2 2/3] dt-bindings: can: rcar_can: Add r8a774a1 support
>
> Document RZ/G2M (r8a774a1) SoC specific bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
> v1->v2:
> * dropped "renesas,rzg-gen2-can" and fixed "clocks" property description
>   as per Geert's comments.
>
> This patch applies on top of next-20180910.
>
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 18 ++++++++++++=
+-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Doc=
umentation/devicetree/bindings/net/can/rcar_can.txt
> index 94a7f33..f3b160c 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -4,6 +4,7 @@ Renesas R-Car CAN controller Device Tree Bindings
>  Required properties:
>  - compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A77=
43 SoC.
>        "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
> +      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 SoC=
.
>        "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
>        "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
>        "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
> @@ -16,15 +17,21 @@ Required properties:
>        "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible device=
.
>        "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
>        compatible device.
> -      "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible device=
.
> +      "renesas,rcar-gen3-can" for a generic R-Car Gen3 or RZ/G2
> +      compatible device.
>        When compatible with the generic version, nodes must list the
>        SoC-specific version corresponding to the platform first
>        followed by the generic version.
>
>  - reg: physical base address and size of the R-Car CAN register map.
>  - interrupts: interrupt specifier for the sole interrupt.
> -- clocks: phandles and clock specifiers for 3 CAN clock inputs.
> -- clock-names: 3 clock input name strings: "clkp1", "clkp2", "can_clk".
> +- clocks: phandles and clock specifiers for 2 CAN clock inputs for RZ/G2
> +  devices.
> +  phandles and clock specifiers for 3 CAN clock inputs for every other
> +  SoC.
> +- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk".
> +       3 clock input name strings for every other SoC: "clkp1", "clkp2",
> +       "can_clk".
>  - pinctrl-0: pin control group to be used for this controller.
>  - pinctrl-names: must be "default".
>
> @@ -41,8 +48,9 @@ using the below properties:
>  Optional properties:
>  - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid values =
are:
>      <0x0> (default) : Peripheral clock (clkp1)
> -    <0x1> : Peripheral clock (clkp2)
> -    <0x3> : Externally input clock
> +    <0x1> : Peripheral clock (clkp2) (not supported by
> +    RZ/G2 devices)
> +    <0x3> : External input clock
>
>  Example
>  -------
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
