Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B7BC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B8620866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="cnnhUSnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B8620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeLNJNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:13:55 -0500
Received: from mail-eopbgr1310128.outbound.protection.outlook.com ([40.107.131.128]:6381
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbeLNJNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDGOT06fj9ZjKpXJHFLb+6clgw3Glmx1s1woaVjWXM8=;
 b=cnnhUSnQAbslhANy1bYmXt/OLjShSBs7qLRu84qkhpvHlABMR+n6u6bVDP3a31lSMFHoh0lqzL7/X8TIenuGr3Az2S484BHAkLqNCjAtCRyYf9nBWMfxfYBIaw5LHmTWgBhoPce97I5HsBnkF/20vuEJymr2wSqBXCdT8D1iT8g=
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com (52.133.184.14) by
 TY2PR01MB2203.jpnprd01.prod.outlook.com (52.133.184.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 14 Dec 2018 09:13:47 +0000
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::9545:5575:a99a:a145]) by TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::9545:5575:a99a:a145%3]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 09:13:46 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] usb: renesas_usbhs: add support for RZ/G2E
Thread-Topic: [PATCH] usb: renesas_usbhs: add support for RZ/G2E
Thread-Index: AQHUk4bU7RL5BooA80yfdpCZpK+pyaV980mA
Date:   Fri, 14 Dec 2018 09:13:46 +0000
Message-ID: <TY2PR01MB2297836B080842D4B630696CD8A10@TY2PR01MB2297.jpnprd01.prod.outlook.com>
References: <1544776023-13364-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544776023-13364-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB2203;20:jKBysSQpN4q/TWvwgfBj3Eb9Asu8JeIgA9VzTjkvNJD6WJFJh8GQO5okSUoOqinRqBYOyDgntlVX3xlppSbVi9XvlAJmNakzivhgZTwnWhMpY9mM+wVG5fB5WgkBD0S1ao5KTglGotpXBTco4s9vi0VfmW64dKBZHO7DPFc504Y=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(366004)(136003)(189003)(199004)(105586002)(106356001)(11346002)(5660300001)(446003)(7736002)(4326008)(305945005)(74316002)(486006)(68736007)(7416002)(345774005)(53936002)(6246003)(229853002)(476003)(86362001)(256004)(9686003)(8676002)(81156014)(110136005)(81166006)(66066001)(2906002)(6436002)(186003)(8936002)(478600001)(25786009)(6116002)(99286004)(71190400001)(71200400001)(55016002)(6506007)(3846002)(54906003)(316002)(33656002)(97736004)(7696005)(14454004)(26005)(76176011)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB2203;H:TY2PR01MB2297.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: ca04e39c-06b8-40eb-19b0-08d661a473f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB2203;
x-ms-traffictypediagnostic: TY2PR01MB2203:
x-microsoft-antispam-prvs: <TY2PR01MB22035C57410D6EE7E687905DD8A10@TY2PR01MB2203.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:TY2PR01MB2203;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB2203;
x-forefront-prvs: 08864C38AC
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fAXt/zV/jHjvWzjvH9gNesK7rkW0hgQXOfukV47W6jpj9IyJg4II4c0sywo9URV/ZukdeQzpGm1kMFzbMdQyF+Xog+39C3SxPKacioC4NWyu51gyfi3TvGU1lkXG1SdfFyagzD992uTmp3YrQpg44dPotmzQkuNIOu4LpFOy599Saqlerj0N9fDyPhhXbNndfsUohhbyq7TaSBnEK22Fg5hItpWkniPInWNPt9/HsV6eB8zdQ47Sa6VR/M/EniklxYnkYdh3xRejQQjmBzrgQTSLpE4GrBN+lF7X7E6nkPyTR28YOdL/hmD1EZ7Tre6Q
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca04e39c-06b8-40eb-19b0-08d661a473f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 09:13:46.5899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

> From: Fabrizio Castro, Sent: Friday, December 14, 2018 5:27 PM
>=20
> HS-USB found in RZ/G2E (a.k.a. r8a774c0) is very similar to the
> one found in R-Car E3 (a.k.a. r8a77990), as it needs to release
> the PLL reset by the UGCTRL register like R-Car E3, therefore add
> r8a774c0 support in a similar fashion to what was done for the
> r8a77990.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Thank you for the patch!

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>  drivers/usb/renesas_usbhs/common.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usb=
hs/common.c
> index 2ff7991..249fbee 100644
> --- a/drivers/usb/renesas_usbhs/common.c
> +++ b/drivers/usb/renesas_usbhs/common.c
> @@ -540,6 +540,10 @@ static int usbhsc_drvcllbck_notify_hotplug(struct pl=
atform_device *pdev)
>   */
>  static const struct of_device_id usbhs_of_match[] =3D {
>  	{
> +		.compatible =3D "renesas,usbhs-r8a774c0",
> +		.data =3D (void *)USBHS_TYPE_RCAR_GEN3_WITH_PLL,
> +	},
> +	{
>  		.compatible =3D "renesas,usbhs-r8a7790",
>  		.data =3D (void *)USBHS_TYPE_RCAR_GEN2,
>  	},
> --
> 2.7.4

