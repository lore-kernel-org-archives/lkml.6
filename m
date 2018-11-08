Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594F4C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1110F208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="bAB7CY8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1110F208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeKHUyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:54:25 -0500
Received: from mail-ty1jpn01on0127.outbound.protection.outlook.com ([104.47.93.127]:6578
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbeKHUyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv8bba29ivqhFXUW/OHBHxux6UCozgbsYrpKW6B8Svc=;
 b=bAB7CY8nLs3yJ3HvsHmmfVU6Bb3aZb+KW1xIFEAxqKaR5QXOhdeJNSHa9zO22r14Vd7de0Mciu5hdqMVBUuI2azod9wMPEgjLDD3UZbB/iAz5PspMtznfBZYoUFP9Jt6YHI6Flfuqj8Wpr99k7PGu+9taKJOSruiRMlzcOi7OeQ=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1SPR00MB085.jpnprd01.prod.outlook.com (10.174.228.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 8 Nov 2018 11:19:17 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:19:17 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] serial: sh-sci: Document r8a774a1 bindings
Thread-Topic: [PATCH] serial: sh-sci: Document r8a774a1 bindings
Thread-Index: AQHUM8saTW8u1ZgMVE6lx+EpGbfHE6VGQasQ
Date:   Thu, 8 Nov 2018 11:19:17 +0000
Message-ID: <TY1PR01MB1770A808CD0FB80FD1AE263DC0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1534250042-15815-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1534250042-15815-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1SPR00MB085;20:AHwKeft8Y1/A+zhuaziFLUWWXLHHGgqjcSbf/h6/JheXYr65raZHysokJpveQX/SeCilOZEPotbBRHIpEZOvR0yTp49T/rDzv1CN6nL5oQD2oP40da6Kvtj5RQDKK9xtUdnnwLyj+bdff9tmRMeZ8ht9LvFIbUQqfFsmPUfcB9M=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: ee7d5184-04ea-4d6d-9aef-08d6456c05d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1SPR00MB085;
x-ms-traffictypediagnostic: TY1SPR00MB085:
x-microsoft-antispam-prvs: <TY1SPR00MB085C92589F28394A2A4B010C0C50@TY1SPR00MB085.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TY1SPR00MB085;BCL:0;PCL:0;RULEID:;SRVR:TY1SPR00MB085;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(76176011)(99286004)(4326008)(3846002)(6116002)(97736004)(186003)(54906003)(316002)(110136005)(7696005)(6436002)(25786009)(305945005)(7736002)(86362001)(5660300001)(71200400001)(74316002)(71190400001)(53936002)(14454004)(476003)(14444005)(256004)(6246003)(68736007)(106356001)(446003)(413944005)(102836004)(11346002)(2906002)(81166006)(81156014)(44832011)(9686003)(486006)(8936002)(33656002)(8676002)(229853002)(2900100001)(6506007)(53546011)(26005)(478600001)(105586002)(55016002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1SPR00MB085;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BZB/g4vpmQ2RKrouBIFjFtXMkSQvaLQu2vJabWKQt1hajChEZg/KmTK4XW3p5EFSrXFiMhtlMMkekJrnOdnPaaW44XpnPazfNL3WO92rlUINgi+B8DuCGWXJP4MvABOwZbfAArwcF7IslPPnZsfoWCin6JrZYRsA9V73EBNAfq6O+Nnv6Z2DL82yLu0kfOUgWISPd3gdKSfvlAK/QiRF2Jw8S4TKQvw7BLZPFLqWmvSuGuv0NC1mrYqUA2vxmtkF4F4GGVwO8fAb/WCbYO8dPO+X/Yz4zFtA4+8pbsUkl73bIosulmqKzudA3AMEyyRHNdo1QPOmQtxgtD8tJKkoinBEcGEyMaPifj2fbNXlGxA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7d5184-04ea-4d6d-9aef-08d6456c05d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:19:17.3644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1SPR00MB085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

This is just a gentle reminder.

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 14 August 2018 13:34
> Subject: [PATCH] serial: sh-sci: Document r8a774a1 bindings
>
> RZ/G2M (R8A774A1) SoC also has the R-Car Gen3 compatible SCIF and
> HSCIF ports, so document the SoC specific bindings. While at it,
> update the RZ/G1 and RZ/G2 family specific strings description as
> outdated.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  .../devicetree/bindings/serial/renesas,sci-serial.txt      | 14 ++++++++=
------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.=
txt b/Documentation/devicetree/bindings/serial/renesas,sci-
> serial.txt
> index eaca9da..1994ab8 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -20,6 +20,8 @@ Required properties:
>      - "renesas,hscif-r8a7745" for R8A7745 (RZ/G1E) HSCIF compatible UART=
.
>      - "renesas,scif-r8a77470" for R8A77470 (RZ/G1C) SCIF compatible UART=
.
>      - "renesas,hscif-r8a77470" for R8A77470 (RZ/G1C) HSCIF compatible UA=
RT.
> +    - "renesas,scif-r8a774a1" for R8A774A1 (RZ/G2M) SCIF compatible UART=
.
> +    - "renesas,hscif-r8a774a1" for R8A774A1 (RZ/G2M) HSCIF compatible UA=
RT.
>      - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART=
.
>      - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART=
.
>      - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART=
.
> @@ -55,13 +57,13 @@ Required properties:
>      - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible=
 UART.
>      - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible=
 UART.
>      - "renesas,rcar-gen1-scif" for R-Car Gen1 SCIF compatible UART,
> -    - "renesas,rcar-gen2-scif" for R-Car Gen2 SCIF compatible UART,
> -    - "renesas,rcar-gen3-scif" for R-Car Gen3 SCIF compatible UART,
> -    - "renesas,rcar-gen2-scifa" for R-Car Gen2 SCIFA compatible UART,
> -    - "renesas,rcar-gen2-scifb" for R-Car Gen2 SCIFB compatible UART,
> +    - "renesas,rcar-gen2-scif" for R-Car Gen2 and RZ/G1 SCIF compatible =
UART,
> +    - "renesas,rcar-gen3-scif" for R-Car Gen3 and RZ/G2 SCIF compatible =
UART,
> +    - "renesas,rcar-gen2-scifa" for R-Car Gen2 and RZ/G1 SCIFA compatibl=
e UART,
> +    - "renesas,rcar-gen2-scifb" for R-Car Gen2 and RZ/G1 SCIFB compatibl=
e UART,
>      - "renesas,rcar-gen1-hscif" for R-Car Gen1 HSCIF compatible UART,
> -    - "renesas,rcar-gen2-hscif" for R-Car Gen2 HSCIF compatible UART,
> -    - "renesas,rcar-gen3-hscif" for R-Car Gen3 HSCIF compatible UART,
> +    - "renesas,rcar-gen2-hscif" for R-Car Gen2 and RZ/G1 HSCIF compatibl=
e UART,
> +    - "renesas,rcar-gen3-hscif" for R-Car Gen3 and RZ/G2 HSCIF compatibl=
e UART,
>      - "renesas,scif" for generic SCIF compatible UART.
>      - "renesas,scifa" for generic SCIFA compatible UART.
>      - "renesas,scifb" for generic SCIFB compatible UART.
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
