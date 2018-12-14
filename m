Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BA6C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CF12086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="F5mM2ll/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CF12086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeLNJGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:06:09 -0500
Received: from mail-eopbgr1320131.outbound.protection.outlook.com ([40.107.132.131]:47673
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbeLNJGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAQWmn1yOSylaa79ASaANsHbp8D01qLLQg81FzzmBVU=;
 b=F5mM2ll//J3NL/YLmQrXb5yOlZkkLBACRcdKu8r7nudYZW46jzO+SKAFCDjjmYaQDFsrtx2BU/nCNqZYlWeBoQk6ZxwBn7IqZFAU6h5Uspepwdp/9f9mLh6zS8Ve+Kd0LtzmkZL+5MtdtedBMWapVVqhXdSn+4w8W+8T8E+UL/U=
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com (52.133.184.14) by
 TY2PR01MB4539.jpnprd01.prod.outlook.com (20.179.169.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 09:06:03 +0000
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::9545:5575:a99a:a145]) by TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::9545:5575:a99a:a145%3]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 09:06:02 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kees Cook <keescook@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: udc: renesas_usb3: add support for r8a774c0
Thread-Topic: [PATCH] usb: gadget: udc: renesas_usb3: add support for r8a774c0
Thread-Index: AQHUkyHJnjzTMqakp0q36ULlifzPj6V98geA
Date:   Fri, 14 Dec 2018 09:06:02 +0000
Message-ID: <TY2PR01MB2297A0B026B45621F220F259D8A10@TY2PR01MB2297.jpnprd01.prod.outlook.com>
References: <1544732635-7367-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732635-7367-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB4539;20:IPVSMOF3Wtgr0yNhBC6XiFQAlcdPrp62a4gWiaA3UMqzM85/SD2lS7OYqOVp+t65H+pn7EqSD9nEdUAEkFK/jGIzak2zlrfcAaMwxnWu+z0CwrtGS2kT7OFFxD1E7xlAP+x26Ma7qPIE5ufC0I/IDTwiKNo9/daIlhIVpWyly9U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(14454004)(9686003)(86362001)(4326008)(3846002)(6436002)(5660300001)(66066001)(6246003)(6116002)(305945005)(99286004)(106356001)(7736002)(71190400001)(71200400001)(74316002)(53936002)(2906002)(345774005)(105586002)(55016002)(476003)(478600001)(76176011)(33656002)(68736007)(486006)(11346002)(8676002)(229853002)(97736004)(81166006)(81156014)(256004)(54906003)(186003)(110136005)(446003)(25786009)(8936002)(316002)(26005)(102836004)(7696005)(6506007)(138113003)(98903001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB4539;H:TY2PR01MB2297.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 3b087ffd-0ae3-485d-a764-08d661a35f3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB4539;
x-ms-traffictypediagnostic: TY2PR01MB4539:
x-microsoft-antispam-prvs: <TY2PR01MB4539E433EE1D8FB562A0E870D8A10@TY2PR01MB4539.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:TY2PR01MB4539;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB4539;
x-forefront-prvs: 08864C38AC
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UVkdqg1k7prf1C18d32x0zTT+0EUowUnsjHBjiBxpO/RcF7sGcCovsy4MtRhylKXq8ptndKe3fSNPW66WHKSgg+8hGj2fRStBT3aOMp7T+R+dWd3Sy1w9f/hQvP54cZ7fU3ngxd6yRGiNrM/8834zw9Ykm9RZDMx3mJgVVBgEYiAL9/xSsqZkSv102qq9EP7wvDPR1dLwom26+sZjEtv0Ui9hnjrV7YlUXV3YV8Zq+GiNPM7gspZtKKUSS8v5QOzcRm2hn+sgIfiYgr0rWObgVPGA0DQN3mIxCI8tyqKYAwiQoYh5GNwRm/yUkEQx8GJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b087ffd-0ae3-485d-a764-08d661a35f3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 09:06:02.3184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4539
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

> From: Fabrizio Castro, Sent: Friday, December 14, 2018 5:24 AM
>=20
> RZ/G2E USB 3.0 implementation is like the one found on R-Car E3,
> therefore add the same quirk.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>  drivers/usb/gadget/udc/renesas_usb3.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/u=
dc/renesas_usb3.c
> index cdffbd1..18444a8 100644
> --- a/drivers/usb/gadget/udc/renesas_usb3.c
> +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> @@ -2625,6 +2625,10 @@ MODULE_DEVICE_TABLE(of, usb3_of_match);
>=20
>  static const struct soc_device_attribute renesas_usb3_quirks_match[] =3D=
 {
>  	{
> +		.soc_id =3D "r8a774c0",
> +		.data =3D &renesas_usb3_priv_r8a77990,
> +	},
> +	{
>  		.soc_id =3D "r8a7795", .revision =3D "ES1.*",
>  		.data =3D &renesas_usb3_priv_r8a7795_es1,
>  	},
> --
> 2.7.4

