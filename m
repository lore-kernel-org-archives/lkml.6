Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B62DC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF36A2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="gCwVpBP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF36A2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbeLNJhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:37:41 -0500
Received: from mail-eopbgr1410133.outbound.protection.outlook.com ([40.107.141.133]:51214
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727693AbeLNJhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3X8e8uQWSWPgSHRtCD/XW71susbo080h1QUH1hmuSw=;
 b=gCwVpBP9a2/IaUUAbULqZ9nVpl0zeDp5Fa5SzPMTEuNFYtAvjBwcjduHytXQpDVrPsCKln46cV9gkcHh/zXKoODJ+zK7jt0AM3ybkfH1DHhmJXl5wx1NDj2NHQBUgPyFhW4pO27JBF6dfMqID/n5T8FzFKA3fFgjnexNX7Dp7oI=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1593.jpnprd01.prod.outlook.com (52.133.162.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 09:37:32 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::dcee:f270:d42b:5b48]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::dcee:f270:d42b:5b48%5]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 09:37:32 +0000
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
Thread-Index: AQHUkyFjZOWmzn5PMkyA9Nqr9LkvB6V9voSAgAAlHTCAABEwAIAABgbg
Date:   Fri, 14 Dec 2018 09:37:32 +0000
Message-ID: <TY1PR01MB1770B22A29EB0FB0402676A2C0A10@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1544732463-6685-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY2PR01MB2297D670A9D3B8D4B5BC0389D8A10@TY2PR01MB2297.jpnprd01.prod.outlook.com>
 <TYXPR01MB1775F0716AF9A20220FF961CC0A10@TYXPR01MB1775.jpnprd01.prod.outlook.com>
 <TY2PR01MB22970241F86719C84841D929D8A10@TY2PR01MB2297.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB22970241F86719C84841D929D8A10@TY2PR01MB2297.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1593;20:kKKXhGDyAuRoPcRg6BLeAlxMXFr6DiJSP8S1M4pJ4aQ4xr883iALynyiPLpJcx1Gfxm9LQI4SVjf6nxhNRfE/rZ3PaJuiPoAip4jpNsKci2/+D4XcuZhEZpNgD0yn1TzbDHDUUE3iJVl96wm3XBP51ZBvrEl5rfbK0ciXcU0uig=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: a3757d3a-8ca1-4fb9-ae70-08d661a7c5d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1593;
x-ms-traffictypediagnostic: TY1PR01MB1593:
x-microsoft-antispam-prvs: <TY1PR01MB15935A8B78A87CACDB6C3558C0A10@TY1PR01MB1593.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1593;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1593;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(7696005)(14454004)(5660300001)(7736002)(53936002)(9686003)(76176011)(6306002)(71190400001)(71200400001)(486006)(476003)(6246003)(6116002)(102836004)(446003)(345774005)(99286004)(3846002)(44832011)(256004)(55016002)(478600001)(53546011)(6506007)(11346002)(25786009)(305945005)(93886005)(66066001)(86362001)(10126004)(4326008)(81156014)(81166006)(186003)(97736004)(8676002)(26005)(8936002)(316002)(68736007)(33656002)(6436002)(105586002)(54906003)(110136005)(106356001)(229853002)(2906002)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1593;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lgF/FwGIDE35u8xIj2ZWSrAYjg2CZKsE1P9PQ3NgUrvHXrwvB4oXjZLasB2fdQ1GcLc/WavP1rNUN2DnQb7p5V1BltybiDrYm0UBfm+gr2lZ/cao8TSRPCV//PH7GNYOaWk5rqjv56+lWhTZ3AIdsB8StYdKGvmJToeo9NCWHujx5hragtJrZ6kO6NcO2BWNvg3mUr6tm1grnkx4/HMT82GMhOIMuGwzxhCF8dgZm+DQgzekGZmR2sMWylNNuMNXFKCVkAWJ4ebvAOVPmtsP4PVyaqpPpxHpKugg7Rfglc0KFrq8CTZKI7mEsk3hxxtP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3757d3a-8ca1-4fb9-ae70-08d661a7c5d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 09:37:32.4523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1593
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Yoshihiro-san

> From: Yoshihiro Shimoda
> Sent: 14 December 2018 09:15
> Subject: RE: [PATCH] dt-bindings: usb: renesas_usbhs: Add r8a774c0 suppor=
t
>
> Hello Fabrizio-san,
>
> > From: Fabrizio Castro, Sent: Friday, December 14, 2018 5:16 PM
> >
> > Hello Yoshihiro-san,
> >
> > Thank you for your feedback!
> >
> > > From: Yoshihiro Shimoda
> > > Sent: 14 December 2018 06:01
> > > Subject: RE: [PATCH] dt-bindings: usb: renesas_usbhs: Add r8a774c0 su=
pport
> > >
> > > Hi Fabrizio,
> > >
> > > > From: Fabrizio Castro, Sent: Friday, December 14, 2018 5:21 AM
> > > >
> > > > Document RZ/G2E (R8A774C0) SoC bindings.
> > > >
> > > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > >
> > > Thank you for the patch!
> > >
> > > Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > >
> > > By the way, I'm not sure, but I'm wondering that we need to add
> > > .compatible renesas,usbhs-r8a774c0 with .data USBHS_TYPE_RCAR_GEN3_WI=
TH_PLL
> > > like r8a77990 to the drivers/usb/renesas_usbhs/common.c.
> > > What do you think?
> >
> > Yeah, you are right, I am going to send a patch for that shortly.
>
> Thank you for submitting a patch!
> I have reviewed you patch and submitted my Acked-by.
>
> Best regards,
> Yoshihiro Shimoda



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
