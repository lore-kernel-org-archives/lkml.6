Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1DEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6052146F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nzVO7vkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfAIDX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:23:59 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:41801
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbfAIDX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PQB948Nyuc2TvE2rGc4GIwP0Bq5+dROBy4ZYZ8+wIM=;
 b=nzVO7vkw6zqn4ngmMDCspeko6H/xMrr9KjMPzV4hTWRfORh9N2ZYW7GJSspPRoilSlaZMgu754VSEc60TwbkikHQDB3Sj09lZwGgne27wQrjCApnc7eVZdZUGSilUWeOi67xf52yvEGt4i58qr5duftJsOGI0v3WPMZBwX1kTFo=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2738.eurprd04.prod.outlook.com (10.175.40.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Wed, 9 Jan 2019 03:23:54 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 03:23:54 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>
Subject: RE: [PATCH 1/3] usb: kconfig: remove dependency FSL_SOC for ehci fsl
 driver
Thread-Topic: [PATCH 1/3] usb: kconfig: remove dependency FSL_SOC for ehci fsl
 driver
Thread-Index: AQHUpxgBkJ5uhq9XMUWhOXrVWOpG3KWli3mAgAC7iCA=
Date:   Wed, 9 Jan 2019 03:23:54 +0000
Message-ID: <AM5PR0402MB286583217B668F4B50A213ACF18B0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190108060426.11581-1-ran.wang_1@nxp.com>
 <Pine.LNX.4.44L0.1901081110550.1355-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1901081110550.1355-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [223.104.3.158]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2738;6:5xUJNgxnWiGsa1HB2aLavT0qpEvlaIQtXCeZPAYAjycthCUt+4XeQTAmseyB/qIY9oHmND/6nE8JZW09HcNHVYyn3ZX3E0PRoPysXFiD1HDsEEB5soQtXyyyuuYFQk4fPXBt3FDoM3qzNRwUd9D/507gnCNG0a7Dq5d5MTMgNZSxJYW1zbyXswFaGFRLLm3xVmRraehcomq5BN9oJ2ZdYQ3yXGtXgiVQUpVcphFcCLlFLWy57itJfXb80fh7jizGOiB9ZqhQJB/GzIeao4o3TDIi1YToxewoF6Sgi6oLLbMWutbAVGa2g3YSU2YbaVdO8DnIF9rSEyf9EJLICeeAf6HkywBGaS3Njbn/j98UgrSja2pnfV9+2p1j6MbPVo08+prsKlivo18T969lEnt8QYX50KfjTB8XanFTslfigLyopJytXY+Iz2NcxqrPgVJMHH2kfg4AGk44XlLwy4O0ow==;5:vrhQlDDDCqNQGIMc/juqCUjK9Y82n9ibK7+x5vKJUoLgIvkyx/ztuZr7u/gq5OG7HbDHPmV3bcFsC0KyYFeMXgeASJeIvaZTyRvUy+qBCHUdYcua45uMjTu2fJs6W2LxGRGcTYk83rdw50x3swgdLNXvBaYF9cseSbADw/zcWGDo3uu7iHWy2qS+KKeRvGPaebBHuN91Z2L/QH76yKatVg==;7:M1rLDEv79mokzdc84KAQ7690D6e3n3qQPMddXM6oWlbTnPOjwsthnDYu9KEPcYbGYjgQWe8Jhn9Dp30N+QUWpWTNsx+/mwPRPyDj4MqWrGx2fFK/qs3wg1jmxVsRntM0g4AorVACmZSxA79GGI3bkA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d0c312a3-d602-4698-5d4c-08d675e1e23a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2738;
x-ms-traffictypediagnostic: AM5PR0402MB2738:
x-microsoft-antispam-prvs: <AM5PR0402MB273852815E6923FA2B253EDEF18B0@AM5PR0402MB2738.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM5PR0402MB2738;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2738;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(366004)(136003)(376002)(13464003)(199004)(189003)(33656002)(6916009)(54906003)(6116002)(486006)(3846002)(5660300001)(53936002)(97736004)(2171002)(316002)(55016002)(229853002)(99286004)(74316002)(68736007)(7696005)(6246003)(76176011)(8936002)(256004)(478600001)(6436002)(4326008)(9686003)(25786009)(105586002)(53546011)(81166006)(81156014)(71190400001)(305945005)(14454004)(71200400001)(2906002)(186003)(476003)(26005)(446003)(86362001)(102836004)(66066001)(7736002)(8676002)(106356001)(6506007)(11346002)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2738;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zi0P6TOADRCYWoFS6HuE4ipGo/I1ByF7oXycgv4ot1rJOtg4TmupyYjl1pXo2A739Ry5CfUbj5jp8mDPxS2M4Wn4Mg23Wm2CMs93pGlEJlmJ6OddXb0eKkcqNlIUP+veVjXF/93rKhbGCjS56uDHyaroNQHjO7I3fWAK5aWrsTDagxu0cb/rA3yoyJj/jorXxS5p13WxFUYuTAcdljbDi1VKyU+K11Ty8lpa+R6JNn87AknDF7A4kdDhi86C08CTuIdiaQOfKliprAA1EoD0nd4t2chli1j1XPt7QAl3+4c+vzlsRwj6ej9Q62oMZhzS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c312a3-d602-4698-5d4c-08d675e1e23a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 03:23:54.2133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> -----Original Message-----
> From: Alan Stern <stern@rowland.harvard.edu>
> Sent: Wednesday, January 09, 2019 00:12
> To: Ran Wang <ran.wang_1@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> usb@vger.kernel.org; linux-kernel@vger.kernel.org; Rajesh Bhagat
> <rajesh.bhagat@nxp.com>
> Subject: Re: [PATCH 1/3] usb: kconfig: remove dependency FSL_SOC for ehci
> fsl driver
>=20
> On Tue, 8 Jan 2019, Ran Wang wrote:
>=20
> > From: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> >
> > CONFIG_USB_EHCI_FSL is not dependent on FSL_SOC, it can be built on
> > non-PPC platforms.
> >
> > Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  drivers/usb/host/Kconfig |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig index
> > 16758b1..53cbc0c 100644
> > --- a/drivers/usb/host/Kconfig
> > +++ b/drivers/usb/host/Kconfig
> > @@ -179,8 +179,8 @@ config XPS_USB_HCD_XILINX
> >  		devices only.
> >
> >  config USB_EHCI_FSL
> > -	tristate "Support for Freescale PPC on-chip EHCI USB controller"
> > -	depends on FSL_SOC
> > +	tristate "Support for Freescale on-chip EHCI USB controller"
> > +	depends on USB_EHCI_HCD
>=20
> This line is not needed.  The entire entry lies within an "if USB_EHCI_HC=
D"
> block.

Got it, will remove it in next version, thanks.

Regards,
Ran

> Alan Stern
>=20
> >  	select USB_EHCI_ROOT_HUB_TT
> >  	---help---
> >  	  Variation of ARC USB block used in some Freescale chips.
> >

