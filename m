Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F347DC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD997208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="lLvSIzQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD997208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeKHUiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:38:55 -0500
Received: from mail-ty1jpn01on0092.outbound.protection.outlook.com ([104.47.93.92]:38064
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726941AbeKHUiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxlqK8rmu91GRX/QWdB5aF7FRwcbPv+wTdLwmOaIr9k=;
 b=lLvSIzQpV3pdZAj1bPlZSI4xRgrPY80rcoPGB3NxyN8C3y7HBSDPGZXZgm9Mdb6pZs+ZyxUFGTNYxvcdS3Ef1y/g0VjMgqhJoftjmFZjsB8/yWJ5cdKKRaQ/VGB6Ia1bNdeAUlAOp9zCUtTvJd9VJwvAJ1v5ogZFgNzBUGxcDTI=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1102.jpnprd01.prod.outlook.com (10.174.225.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Thu, 8 Nov 2018 11:03:53 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:03:53 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: rcar-dmac: Document R8A774A1 bindings
Thread-Topic: [PATCH] dmaengine: rcar-dmac: Document R8A774A1 bindings
Thread-Index: AQHUM8riZEF66pdYT0C8GJYqJNBsv6VGPZrQ
Date:   Thu, 8 Nov 2018 11:03:53 +0000
Message-ID: <TY1PR01MB17708409052CFB9469856335C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1534249935-15496-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1534249935-15496-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1102;20:6OFDCjvDgirSanE0fU+ipb+XCgP5h3zqmpfFfxZ81rkuxFllb2k9i+8hru6a78eQ1q7xxG/H3tyoxz+LYNAwrcfROYKy93Hyu4FxoBhf4seKDK1uH9qJ3qyK8VEjhgAZQ30EXqLAfWHjkT3acUOo8qrazHyMeoFfmFFRsM1lifk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 150f8674-5a71-4e29-208f-08d64569df1d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1102;
x-ms-traffictypediagnostic: TY1PR01MB1102:
x-microsoft-antispam-prvs: <TY1PR01MB110200A121AF518E2917B780C0C50@TY1PR01MB1102.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1102;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1102;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(11346002)(4326008)(476003)(2900100001)(102836004)(6506007)(53546011)(99286004)(7696005)(256004)(76176011)(446003)(14444005)(6246003)(316002)(25786009)(2906002)(86362001)(486006)(186003)(97736004)(68736007)(413944005)(14454004)(6116002)(9686003)(71200400001)(71190400001)(26005)(55016002)(53936002)(54906003)(110136005)(3846002)(106356001)(8936002)(478600001)(81166006)(81156014)(8676002)(6436002)(5660300001)(229853002)(105586002)(44832011)(66066001)(33656002)(305945005)(74316002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1102;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Orhj7k82M7JpwRZ4TYKCJ6567UYmeE5N6KbzyW7BNHpRGuQFRk4kJs+2YtrXsGwTWURc/yw00DRagAb/iqfCJaFzHD/hzYfrDWd/udP5aYPDj1IiGxI19HoYU4Qun1o93mV+jP2NbJmkRJbBw2bQzQUWO/leN1VDByc8ZWfUKPkC7EnAJyOEGzh0PxEMogbONPHlY6R2tC6gq/nOSIfhyP1gah0WC7yuTN/cDBhyKv08dMuKlnv7CV0klZ4y8Y0quG3sOG6Jdzr+jkrslB5R9FIYjze0ULGSUV0w2XJ+yYnZAnchqND8AJIFJDXGR7bn/Ltw1bTLIz5rmZoj/2dPtdsU4GnM/NahZGFTzhYRGhk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150f8674-5a71-4e29-208f-08d64569df1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:03:53.4653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Who is the best person to take this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 14 August 2018 13:32
> Subject: [PATCH] dmaengine: rcar-dmac: Document R8A774A1 bindings
>
> Renesas' RZ/G2M (R8A774A1) SoC has DMA controllers compatible
> with this driver, therefore document RZ/G2M specific bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> index 946229c..2de2eed 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> @@ -1,6 +1,6 @@
>  * Renesas R-Car (RZ/G) DMA Controller Device Tree bindings
>
> -Renesas R-Car Generation 2 SoCs have multiple multi-channel DMA
> +Renesas R-Car (Gen 2/3) and RZ/G SoCs have multiple multi-channel DMA
>  controller instances named DMAC capable of serving multiple clients. Cha=
nnels
>  can be dedicated to specific clients or shared between a large number of
>  clients.
> @@ -19,6 +19,7 @@ Required Properties:
>  - "renesas,dmac-r8a7743" (RZ/G1M)
>  - "renesas,dmac-r8a7745" (RZ/G1E)
>  - "renesas,dmac-r8a77470" (RZ/G1C)
> +- "renesas,dmac-r8a774a1" (RZ/G2M)
>  - "renesas,dmac-r8a7790" (R-Car H2)
>  - "renesas,dmac-r8a7791" (R-Car M2-W)
>  - "renesas,dmac-r8a7792" (R-Car V2H)
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
