Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44166C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 05:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E574E2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 05:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="eKRCyfuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E574E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeK3Q6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 11:58:06 -0500
Received: from mail-eopbgr1310134.outbound.protection.outlook.com ([40.107.131.134]:63644
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbeK3Q6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 11:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoAnZw6wVhcbyO/ojrVdA7uWj3EU3ZoXanrEFcBtol4=;
 b=eKRCyfuKFniUDA9gSdhoMO0Cz29ND9VbD9x2arQIr4SmWOO0BPUYfAQTjFxqx+MN89a8qQWVy5lA5vCsIA7P84Ki4ohdqnm++tISlRe8uFBoGJIXbM9lFxW35ujwmElckb1QKqXpnzxqkVAzpQ1bzQls7N8eGJMqLrEw3iWK3/Q=
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com (52.133.184.14) by
 TY2PR01MB4921.jpnprd01.prod.outlook.com (20.179.171.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Fri, 30 Nov 2018 05:49:50 +0000
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::98d3:2fbf:ca47:f033]) by TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::98d3:2fbf:ca47:f033%3]) with mapi id 15.20.1339.036; Fri, 30 Nov 2018
 05:49:50 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] phy: renesas: rcar-gen3-usb2: follow the hardware manual
 procedure
Thread-Topic: [PATCH] phy: renesas: rcar-gen3-usb2: follow the hardware manual
 procedure
Thread-Index: AQHUgXGduWh7Uy6zz0qMrwqNmf6bZ6Vh1OcAgAYFj6A=
Date:   Fri, 30 Nov 2018 05:49:50 +0000
Message-ID: <TY2PR01MB22970F60265A2EAB114373E4D8D30@TY2PR01MB2297.jpnprd01.prod.outlook.com>
References: <1542787663-32142-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20181126093911.npr3ktohqciuq5my@verge.net.au>
In-Reply-To: <20181126093911.npr3ktohqciuq5my@verge.net.au>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB4921;20:VsLuIMKoqt5ShUB5J1ssTJYo9JUoqStKirhdpU6lsZ0D3fWeaxqLG7wQpFfap36IATag9U0JDL9l66qHZlg4msgmWiZh2O+8U0ejV6x6Odh7TVzGHhU6isZJqplNbJe/hAF9ucj7B/8AwBFKpZqeC0xaWnVDgE+1YhUJL7c4yGI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 42cd57d3-aaad-4298-3396-08d65687a50e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB4921;
x-ms-traffictypediagnostic: TY2PR01MB4921:
x-microsoft-antispam-prvs: <TY2PR01MB4921920E6A18530296897B47D8D30@TY2PR01MB4921.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TY2PR01MB4921;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB4921;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(136003)(189003)(54094003)(199004)(316002)(575784001)(68736007)(8936002)(105586002)(11346002)(97736004)(25786009)(486006)(81166006)(8676002)(4326008)(81156014)(71190400001)(446003)(106356001)(71200400001)(476003)(74316002)(3846002)(6116002)(256004)(6436002)(55016002)(345774005)(6916009)(9686003)(6246003)(14454004)(53936002)(33656002)(76176011)(66066001)(54906003)(102836004)(7696005)(7736002)(6506007)(99286004)(305945005)(186003)(26005)(478600001)(86362001)(229853002)(2906002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB4921;H:TY2PR01MB2297.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6vmdB81He9e2aYikP5UxulntesC9JKt0Un6QZ1w1Mkwd1NcWeL/i0Ov9oB8dmzbePIqnQUJqlQxPk8So51M3kx5TRWTfL/MvMIXNXCQOhelAMOnS4q5yzcqrcijPt/dqH2qma+nggQVBoCA6sogaglUIUtWawfOHWc+Pv7wTyTSepKfxZEJcZ+gmzatSo7AWRmTtUawp4NKt625rya2AYWLBpqPZE6SOx5poLKm9AN/o74RRaakl2IFKgYzq3qlV3hAVdumJZBx2QE1JhTK93pqdvB76KNOJsGP/A5sQZ+plgzvDj07Fd4hBCYMkHo5Bw/ca1M8n0k6/iD8w5rXdBFTIUzs8p2JEZqd+oGgbzZg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cd57d3-aaad-4298-3396-08d65687a50e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 05:49:50.7373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4921
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon-san,

Thank you for your review!

> From: Simon Horman, Sent: Monday, November 26, 2018 6:39 PM
>=20
> On Wed, Nov 21, 2018 at 08:10:06AM +0000, Yoshihiro Shimoda wrote:
> > This patch modifies rcar_gen3_init_otg() procedure to follow Figure
> > 73.4 of "R-Car Series, 3rd Generation User's Manual: Hardware Rev.1.00"=
.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  This patch is based on the latest linux-phy / next branch
> > (commit id =3D 0eb86fa77f0f0c81631a030f10679a45c05df33a).
> >
> >  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/ren=
esas/phy-rcar-gen3-usb2.c
> > index d0f412c..a9e53e8 100644
> > --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> > +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> > @@ -307,16 +307,21 @@ static void rcar_gen3_init_otg(struct rcar_gen3_c=
han *ch)
> >  	void __iomem *usb2_base =3D ch->base;
> >  	u32 val;
> >
> > +	rcar_gen3_set_linectrl(ch, 0, 1);
> > +	val =3D readl(usb2_base + USB2_LINECTRL1);
> > +	writel(val | USB2_LINECTRL1_DPRPD_EN | USB2_LINECTRL1_DMRPD_EN,
> > +	       usb2_base + USB2_LINECTRL1);
>=20
> I am wondering if as well as the above
> USB2_LINECTRL1_DPRPD_EN should be set and
> USB2_LINECTRL1_DP_RPD should be cleared.

I assumed rcar_gen3_set_linectrl(ch, 0, 1); did
"USB2_LINECTRL1_DP_RPD should be cleared ".
But, the patch is not readable. So, I will fix this.

> > +
> >  	val =3D readl(usb2_base + USB2_VBCTRL);
> >  	writel(val | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
> > -	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
> > -	rcar_gen3_control_otg_irq(ch, 1);
> >  	val =3D readl(usb2_base + USB2_ADPCTRL);
> >  	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
> > -	val =3D readl(usb2_base + USB2_LINECTRL1);
> > -	rcar_gen3_set_linectrl(ch, 0, 0);
> > -	writel(val | USB2_LINECTRL1_DPRPD_EN | USB2_LINECTRL1_DMRPD_EN,
> > -	       usb2_base + USB2_LINECTRL1);
> > +
> > +	msleep(20);
> > +
> > +	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
>=20
> I wonder if it is appropriate to write 0xffffffff to USB2_OBINTSTA

Also, I'll fix this.

> and then USB2_OBINT_BITS to USB2_OBINTEN here.

I assumed the rcar_gen3_control_otg_irq() below did that.
However, since rcar_gen3_control_otg_irq() does read-modify-write the regis=
ter,
it is not good as the initial routine because a boot loader wrote the regis=
ter
with other value. So, I also fix this not to call rcar_gen3_control_otg_irq=
().

> > +
> > +	rcar_gen3_control_otg_irq(ch, 1);

Best regards,
Yoshihiro Shimoda

> >  	rcar_gen3_device_recognition(ch);
> >  }
> > --
> > 1.9.1
> >
