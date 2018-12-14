Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42015C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0152086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="htk2ihLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0152086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeLNIPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:15:46 -0500
Received: from mail-eopbgr1410097.outbound.protection.outlook.com ([40.107.141.97]:56832
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeLNIPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MsCWgKenDxWkTQ+f5JQ99R2tuMX5L7KyV75MOMkCgo=;
 b=htk2ihLqIip2OvG9Rx2NrrLdGFoh+Rsk3UlVHQp1Zgs45U1ZgZQUAt+sDLdkpVt8jJoMqoDK4Gn1V2Oz3zq6Cx3Q9K20/Ejwgn+eoljuAkr1U2Z0YbBjCgHCJVMVr1YD4LcKxiFDTDNQL5K20+Xwp2bWb2jm5XRnvAuggkm3KWA=
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com (52.133.168.140) by
 TYXPR01MB1680.jpnprd01.prod.outlook.com (52.133.167.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 08:15:40 +0000
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::64fb:82d3:31d2:1a12]) by TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::64fb:82d3:31d2:1a12%2]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 08:15:40 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: usb: renesas_usbhs: Add r8a774c0 support
Thread-Topic: [PATCH] dt-bindings: usb: renesas_usbhs: Add r8a774c0 support
Thread-Index: AQHUkyFjZOWmzn5PMkyA9Nqr9LkvB6V9voSAgAAlHTA=
Date:   Fri, 14 Dec 2018 08:15:40 +0000
Message-ID: <TYXPR01MB1775F0716AF9A20220FF961CC0A10@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1544732463-6685-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY2PR01MB2297D670A9D3B8D4B5BC0389D8A10@TY2PR01MB2297.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB2297D670A9D3B8D4B5BC0389D8A10@TY2PR01MB2297.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYXPR01MB1680;20:Yc0a4jSviYBhDlO2uKvy5ehZs+A0OQgEvdoOuhHn/bt4I8k7TT4qCXeVuD81TdkqZKuAYQT5ZvQamPPL3Wc4Dk3rBVBJYvKFoMR9KerLaNc+uDunTDuoGaHYxg8Cm1eGxOLron1Bnu3/HmXBVJbflmLXIom9Nt421jOPny0i5xo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: f8702841-acb9-4de0-f9cf-08d6619c5610
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB1680;
x-ms-traffictypediagnostic: TYXPR01MB1680:
x-microsoft-antispam-prvs: <TYXPR01MB1680E26C7B3F6AE4623FA5BDC0A10@TYXPR01MB1680.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:TYXPR01MB1680;BCL:0;PCL:0;RULEID:;SRVR:TYXPR01MB1680;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(39860400002)(366004)(376002)(189003)(199004)(345774005)(76176011)(478600001)(256004)(25786009)(14454004)(7696005)(2906002)(68736007)(105586002)(97736004)(7736002)(316002)(53546011)(66066001)(102836004)(305945005)(74316002)(86362001)(81156014)(53936002)(44832011)(446003)(3846002)(6116002)(476003)(10126004)(11346002)(99286004)(4326008)(186003)(71190400001)(55016002)(6506007)(54906003)(6436002)(110136005)(486006)(8936002)(26005)(6246003)(9686003)(6306002)(81166006)(5660300001)(33656002)(71200400001)(8676002)(229853002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1680;H:TYXPR01MB1775.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: J2CHaMaTLTaqjiHOL1xMJeLPFAgVqlCjScO4sEXmVniVGtHNdtYcCdzoDDAIeakG6FnhiNptSr+PvcX+Q/dgRQPAf72pfdQ4WUTMhtXx1ZjGTF5vFugn6f7gmoFW3I1v5DGKs8RtYTvuZM9L8D3i/EefzpJVaYaFVyScuT6fkUcyR3EbVLlNSNIBH9dItGrTHg/CS2V/eDDUgJ+dwFiVE3UOTv77T058Ro2FpDfPKxh9IFxn76nLJ+XiSEp2DUnRt8bJarmuo3yTlGJBzbW+b7t/R4bA1hzC0sdflt9GAZkuCB2oS1yfuqrhf7VGWfpU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8702841-acb9-4de0-f9cf-08d6619c5610
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 08:15:40.4668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yoshihiro-san,

Thank you for your feedback!

> From: Yoshihiro Shimoda
> Sent: 14 December 2018 06:01
> Subject: RE: [PATCH] dt-bindings: usb: renesas_usbhs: Add r8a774c0 suppor=
t
>
> Hi Fabrizio,
>
> > From: Fabrizio Castro, Sent: Friday, December 14, 2018 5:21 AM
> >
> > Document RZ/G2E (R8A774C0) SoC bindings.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>
> Thank you for the patch!
>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>
> By the way, I'm not sure, but I'm wondering that we need to add
> .compatible renesas,usbhs-r8a774c0 with .data USBHS_TYPE_RCAR_GEN3_WITH_P=
LL
> like r8a77990 to the drivers/usb/renesas_usbhs/common.c.
> What do you think?

Yeah, you are right, I am going to send a patch for that shortly.

Thanks,
Fab

>
> Best regards,
> Yoshihiro Shimoda
>
> > ---
> >  Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> > b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> > index 90719f5..d93b6a1 100644
> > --- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> > +++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> > @@ -7,6 +7,7 @@ Required properties:
> >  - "renesas,usbhs-r8a7744" for r8a7744 (RZ/G1N) compatible device
> >  - "renesas,usbhs-r8a7745" for r8a7745 (RZ/G1E) compatible device
> >  - "renesas,usbhs-r8a774a1" for r8a774a1 (RZ/G2M) compatible device
> > +- "renesas,usbhs-r8a774c0" for r8a774c0 (RZ/G2E) compatible device
> >  - "renesas,usbhs-r8a7790" for r8a7790 (R-Car H2) compatible device
> >  - "renesas,usbhs-r8a7791" for r8a7791 (R-Car M2-W) compatible device
> >  - "renesas,usbhs-r8a7792" for r8a7792 (R-Car V2H) compatible device
> > --
> > 2.7.4



[https://www2.renesas.eu/media/email/unicef.jpg]

This Christmas, instead of sending out cards, Renesas Electronics Europe ha=
ve decided to support Unicef with a donation. For further details click her=
e<https://www.unicef.org/> to find out about the valuable work they do, hel=
ping children all over the world.
We would like to take this opportunity to wish you a Merry Christmas and a =
prosperous New Year.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
