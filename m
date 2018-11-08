Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECF2ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C4E2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="JJAxppUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C4E2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKHXe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:34:57 -0500
Received: from mail-ty1jpn01on0129.outbound.protection.outlook.com ([104.47.93.129]:54521
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726719AbeKHXe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHTmSv5cjdtfFLBrClRq5rZ06205p0Nr+be95cFcLc4=;
 b=JJAxppUPJiPYWhl2J7ypoqP5G2r512Imt2mDd3PfmxU/F1W8AeLhP4RbsMWVgNq+ixQlrjO7ftSy2KNjyfpe96hnZ0rG9lHFYSmpIXaLwtiD8SNnsOfHPV1qlm1XZpFO27H1QYADD2iavtfjl7MV9XZqTIAvgEjFU7g0pTG0YKY=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1641.jpnprd01.prod.outlook.com (52.133.162.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Thu, 8 Nov 2018 13:59:15 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 13:59:15 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Simon Horman <horms@verge.net.au>, Vinod Koul <vkoul@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: rcar-dmac: Document R8A774A1 bindings
Thread-Topic: [PATCH] dmaengine: rcar-dmac: Document R8A774A1 bindings
Thread-Index: AQHUM8riZEF66pdYT0C8GJYqJNBsv6VGPZrQgAAWhoCAABp2AA==
Date:   Thu, 8 Nov 2018 13:59:15 +0000
Message-ID: <TY1PR01MB1770C8FE55F27CAAB2A89FB7C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1534249935-15496-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB17708409052CFB9469856335C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20181108122329.pxxjrmaaxutxxel3@verge.net.au>
In-Reply-To: <20181108122329.pxxjrmaaxutxxel3@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1641;20:VO89CxNe2U3cOaTdIyE3tDN7nuOOFn9bWKLuIg2esIzvBe/aUBCVPFvLLEF8VaG0GmOyDTovyCuil204DrliC/4uS3A7hfu0pgTdVgwWUrb0nadtsD4YNuJDtKZjf3JzC5/3nNp7cmQFGcOgDpEt/JSj8A8/6yAd4IH0dYJN9uc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 707ba22a-5e8f-4b63-e6ea-08d645825ec1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1641;
x-ms-traffictypediagnostic: TY1PR01MB1641:
x-microsoft-antispam-prvs: <TY1PR01MB1641D45986A5541D30182F1AC0C50@TY1PR01MB1641.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1641;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1641;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(7736002)(110136005)(305945005)(54906003)(6436002)(44832011)(5660300001)(486006)(26005)(478600001)(102836004)(446003)(186003)(11346002)(6506007)(53546011)(476003)(316002)(86362001)(81156014)(81166006)(53936002)(3846002)(229853002)(6116002)(33656002)(9686003)(14444005)(99286004)(68736007)(4326008)(8676002)(71190400001)(71200400001)(2906002)(2900100001)(8936002)(6246003)(66066001)(14454004)(74316002)(7696005)(25786009)(55016002)(106356001)(105586002)(97736004)(76176011)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1641;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mdbRH63k+/Pz9YOGlYxYyQIcEFISEIKkHqwqGryebGEiSmOBfJUlb6R4SVRmrEtMA2096UG88JohywOrzNp+ROr6TXw2eD0HUFNZozGfYBZ4rcHsNJCtQwFVG0zVDFLM1mHn5EJekS4Bl3BioT0XS/6xQ1IHsI55CZ+Q9XF3QMasA/g73nF7qg7UQQ59UKtLexo/qr2PdX/VMiRE9JItGC0yFZJ/ZpognciJ6Iz5aZMlr0Ys3DzGusA/OVVqFu5I7c7FDWnUcPe6bTQnRPqSQ3UEn4cUKNrUqKu7EptSRCF0JikEPPgqgH9bdd8W/XSMbzyt3y77qEjpiywF+HAQeILc7Z0ACHjGSmob/9SkJpE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707ba22a-5e8f-4b63-e6ea-08d645825ec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 13:59:15.6414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1641
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Simon for getting back to me.

Vinod, does this patch look ok to you?

Thanks,
Fab

> Subject: Re: [PATCH] dmaengine: rcar-dmac: Document R8A774A1 bindings
>
> Hi Fabrizio,
>
> I believe this one is for Vinod.
>
> On Thu, Nov 08, 2018 at 11:03:53AM +0000, Fabrizio Castro wrote:
> > Dear All,
> >
> > Who is the best person to take this patch?
> >
> > Thanks,
> > Fab
> >
> > > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > Sent: 14 August 2018 13:32
> > > Subject: [PATCH] dmaengine: rcar-dmac: Document R8A774A1 bindings
> > >
> > > Renesas' RZ/G2M (R8A774A1) SoC has DMA controllers compatible
> > > with this driver, therefore document RZ/G2M specific bindings.
> > >
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > > ---
> > >  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.=
txt
> > > b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> > > index 946229c..2de2eed 100644
> > > --- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> > > +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> > > @@ -1,6 +1,6 @@
> > >  * Renesas R-Car (RZ/G) DMA Controller Device Tree bindings
> > >
> > > -Renesas R-Car Generation 2 SoCs have multiple multi-channel DMA
> > > +Renesas R-Car (Gen 2/3) and RZ/G SoCs have multiple multi-channel DM=
A
> > >  controller instances named DMAC capable of serving multiple clients.=
 Channels
> > >  can be dedicated to specific clients or shared between a large numbe=
r of
> > >  clients.
> > > @@ -19,6 +19,7 @@ Required Properties:
> > >  - "renesas,dmac-r8a7743" (RZ/G1M)
> > >  - "renesas,dmac-r8a7745" (RZ/G1E)
> > >  - "renesas,dmac-r8a77470" (RZ/G1C)
> > > +- "renesas,dmac-r8a774a1" (RZ/G2M)
> > >  - "renesas,dmac-r8a7790" (R-Car H2)
> > >  - "renesas,dmac-r8a7791" (R-Car M2-W)
> > >  - "renesas,dmac-r8a7792" (R-Car V2H)
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
