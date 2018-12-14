Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AF4C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AC02086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="RAUqhP5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AC02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeLNJPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:15:31 -0500
Received: from mail-eopbgr1320112.outbound.protection.outlook.com ([40.107.132.112]:51254
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbeLNJPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG9Fml4RJ+sge9iTZYvKY7nmVq2H1dD/astF19pmCTY=;
 b=RAUqhP5ByUJ5mWk2C3HGXtM46PMO7ZFXQrYwNymKHCWpzP3/3wKaU2armvIw4gi5X+V1YGqGktOSSCMd2RidV0xU9cVK9d2Rei+cDT+22QuUnHmjVR4ocR1sDJ2i8A2uY4YXCjhL7brCF+4mBHgla9BRaHYDe8YBmmCsM1xiZp0=
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com (52.133.184.14) by
 TY2PR01MB4859.jpnprd01.prod.outlook.com (20.179.170.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 09:15:22 +0000
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::9545:5575:a99a:a145]) by TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::9545:5575:a99a:a145%3]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 09:15:22 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
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
Thread-Index: AQHUkyFmr2EcM9KjM0adGPwSzv5FHaV9vTAwgAAm8wCAABBN4A==
Date:   Fri, 14 Dec 2018 09:15:22 +0000
Message-ID: <TY2PR01MB22970241F86719C84841D929D8A10@TY2PR01MB2297.jpnprd01.prod.outlook.com>
References: <1544732463-6685-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY2PR01MB2297D670A9D3B8D4B5BC0389D8A10@TY2PR01MB2297.jpnprd01.prod.outlook.com>
 <TYXPR01MB1775F0716AF9A20220FF961CC0A10@TYXPR01MB1775.jpnprd01.prod.outlook.com>
In-Reply-To: <TYXPR01MB1775F0716AF9A20220FF961CC0A10@TYXPR01MB1775.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB4859;20:VHFQ5SxczU57xS8dsNpGgQ6tJno8PEvc/o4n84LpntTJTvLlSqD/h5fsqaFKwNnSFNsmg9nmJywPp/0tpTKqWvS7+zKKgu85gIdjbIcwU/EcGOP3JOhktgbjmfScUiLviuaKqemq1Xr+folrmUU1LCoOyUjLpKqnhvncz+4bOwc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(486006)(76176011)(110136005)(8676002)(476003)(55016002)(105586002)(81166006)(9686003)(54906003)(8936002)(81156014)(68736007)(256004)(11346002)(86362001)(446003)(7736002)(33656002)(74316002)(305945005)(71200400001)(71190400001)(106356001)(186003)(99286004)(66066001)(7696005)(53936002)(6116002)(2906002)(316002)(97736004)(6506007)(6436002)(102836004)(5660300001)(229853002)(4326008)(478600001)(345774005)(14454004)(25786009)(6246003)(26005)(3846002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB4859;H:TY2PR01MB2297.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 0d1b56a2-51aa-49bb-81f0-08d661a4acf6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB4859;
x-ms-traffictypediagnostic: TY2PR01MB4859:
x-microsoft-antispam-prvs: <TY2PR01MB485904D78C5A562439D5C056D8A10@TY2PR01MB4859.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TY2PR01MB4859;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB4859;
x-forefront-prvs: 08864C38AC
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GzPIemRhTBfiSfmGCTO1ebnVsXO3er4TmZ6i6QLwrn2UkAouGUAiS1o4lv9Rf3EKsYdgrpdnyqSR/t+DaIFPmvUxF7GMHtFRxR0oWZrtEdd1nggZ7tnzZAqBJxQSlhY1g4FYVszCbZUjYbMMdY08HcaMqQ1vGBdxw6RR76rPOJsYRrBw6PZW3oc0/eA5t7vKpnSSOvTRFqWAZrxZb0lSD/wN2HKYN+Pqr/yLGs4lXkX/RKm8XOGcs2DevqabUHWha0r+Tm7razruqER5atqT+AcU6Nv6swoCmXNhlA2czyzbztz9/G5uD7YtGY/ffUGW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1b56a2-51aa-49bb-81f0-08d661a4acf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 09:15:22.2620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4859
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fabrizio-san,

> From: Fabrizio Castro, Sent: Friday, December 14, 2018 5:16 PM
>=20
> Hello Yoshihiro-san,
>=20
> Thank you for your feedback!
>=20
> > From: Yoshihiro Shimoda
> > Sent: 14 December 2018 06:01
> > Subject: RE: [PATCH] dt-bindings: usb: renesas_usbhs: Add r8a774c0 supp=
ort
> >
> > Hi Fabrizio,
> >
> > > From: Fabrizio Castro, Sent: Friday, December 14, 2018 5:21 AM
> > >
> > > Document RZ/G2E (R8A774C0) SoC bindings.
> > >
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > Thank you for the patch!
> >
> > Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >
> > By the way, I'm not sure, but I'm wondering that we need to add
> > .compatible renesas,usbhs-r8a774c0 with .data USBHS_TYPE_RCAR_GEN3_WITH=
_PLL
> > like r8a77990 to the drivers/usb/renesas_usbhs/common.c.
> > What do you think?
>=20
> Yeah, you are right, I am going to send a patch for that shortly.

Thank you for submitting a patch!
I have reviewed you patch and submitted my Acked-by.

Best regards,
Yoshihiro Shimoda

