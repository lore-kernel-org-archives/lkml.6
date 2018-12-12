Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27735C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BC420851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="dvYhdGb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BC420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeLLCLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:11:48 -0500
Received: from mail-eopbgr1410103.outbound.protection.outlook.com ([40.107.141.103]:35003
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbeLLCLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14LKBb7jon8bp8/d+XzuNN7TLo7U8uwM98B32OIQjas=;
 b=dvYhdGb359c1O/1GPXULxzHp23+amhIi+jGT+tJ/fgykRBL1iDPFz1gEC9QZtfv1Tn80w3aoxJKMWKr42R+ioxCLdEk3POZJdj81NTipUQR/Kr5tEaZ//kvmtjPjo4j9NOZveJMBAy/E6gs6WQ0Y8TLabblw5db5Fhz6k/jQkA0=
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com (52.134.243.14) by
 OSBPR01MB4152.jpnprd01.prod.outlook.com (20.178.99.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Wed, 12 Dec 2018 02:11:42 +0000
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::c070:7362:375f:74c5]) by OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::c070:7362:375f:74c5%6]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 02:11:40 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: renesas_usbhs: mark PM functions as __maybe_unused
Thread-Topic: [PATCH] usb: renesas_usbhs: mark PM functions as __maybe_unused
Thread-Index: AQHUkTlBqDCbIxtrnEiimwSiV/xiBKV6W3lQ
Date:   Wed, 12 Dec 2018 02:11:40 +0000
Message-ID: <OSBPR01MB22931F20DD3B4EA1BC1C01F4D8A70@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <20181211100645.650975-1-arnd@arndb.de>
In-Reply-To: <20181211100645.650975-1-arnd@arndb.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.140]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB4152;20:pKNyj6P9MkqTpSwJ8WejXUgxMsyxkoAIDrB7RYWaIPtcuIQvXl1FivgInKwGZ0pCxQ8SUe/PMm3dfoEDKgd+M9EzkZ9aseyvSopUI1o5EyRpEG3uTDENbM+DpC21dTisnk3+UsJpmriiYDlXOWBvQb187HS7gUzYxEm+pvbue6c=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(74316002)(6246003)(2906002)(53546011)(102836004)(345774005)(186003)(9686003)(26005)(4326008)(6506007)(76176011)(7696005)(5660300001)(14454004)(55016002)(11346002)(86362001)(71190400001)(446003)(71200400001)(476003)(68736007)(99286004)(25786009)(486006)(14444005)(105586002)(81166006)(6436002)(256004)(106356001)(316002)(33656002)(97736004)(8936002)(110136005)(8676002)(54906003)(7736002)(305945005)(6116002)(53936002)(3846002)(66066001)(81156014)(229853002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB4152;H:OSBPR01MB2293.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 177a15a9-084c-4c7c-8577-08d65fd72792
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB4152;
x-ms-traffictypediagnostic: OSBPR01MB4152:
x-microsoft-antispam-prvs: <OSBPR01MB415226EC8465808B7A768BAAD8A70@OSBPR01MB4152.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB4152;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB4152;
x-forefront-prvs: 0884AAA693
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iK8Xqyz3cDc7pxsT1CzGdX2G+dOGfE7kU9xnpiB1WEz6z9ukT+1ZVCoCmjkSsDMcpbvyf0o5x69fBhgdYggZMh8J15GxkBL/tXnwNkzP8V7O2R4p1Lx/91rjLBXJvDqoCRLQMCPOo2+oeDyjY2jPXXze0mWW8MODpCc75BnZGpiFFMW97OX0QF5+/psh5Iv6mCUvk/cWX+NohvXWIm4MfQO3cSDlIdQO82KofV8Ddnn/7qd+Rzu000ALgRAWCFp+mrjZNR04AHDUa3Xv3bQeN/sF4iKlEZfZDl4VP9ewIHSChRgsW9kGDGFwddQ/uihY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177a15a9-084c-4c7c-8577-08d65fd72792
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 02:11:40.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for the patch!

> From: Arnd Bergmann, Sent: Tuesday, December 11, 2018 7:06 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>; Yoshihiro Shimoda <yoshihiro.shimoda.u=
h@renesas.com>; Felipe Balbi
> <felipe.balbi@linux.intel.com>; Simon Horman <horms+renesas@verge.net.au>=
; Chris Brandt <Chris.Brandt@renesas.com>;
> linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] usb: renesas_usbhs: mark PM functions as __maybe_unused
>=20
> Without CONFIG_PM, we get a new build warning here:
>=20
> drivers/usb/renesas_usbhs/common.c:860:12: error: 'usbhsc_resume' defined=
 but not used [-Werror=3Dunused-function]
>  static int usbhsc_resume(struct device *dev)
>             ^~~~~~~~~~~~~
> drivers/usb/renesas_usbhs/common.c:844:12: error: 'usbhsc_suspend' define=
d but not used [-Werror=3Dunused-function]
>  static int usbhsc_suspend(struct device *dev)
>             ^~~~~~~~~~~~~~
>=20
> No idea why this never happened before, but it's trivial to work
> around by marking the functions as __maybe_unused so the compiler
> can silently discard them.

This build warning cause the commit d54d334e75b9 ("usb: renesas_usbhs:
Use SIMPLE_DEV_PM_OPS macro").

So, I'd like to add the following tag on this commit log.

Fixes: d54d334e75b9 ("usb: renesas_usbhs: Use SIMPLE_DEV_PM_OPS macro")

Also, we can remove "No idea why this never happened before, but"
from the commit log.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

After revised the commit log a little:

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>  drivers/usb/renesas_usbhs/common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usb=
hs/common.c
> index 02c1d2bf4f86..2ff7991f4517 100644
> --- a/drivers/usb/renesas_usbhs/common.c
> +++ b/drivers/usb/renesas_usbhs/common.c
> @@ -841,7 +841,7 @@ static int usbhs_remove(struct platform_device *pdev)
>  	return 0;
>  }
>=20
> -static int usbhsc_suspend(struct device *dev)
> +static __maybe_unused int usbhsc_suspend(struct device *dev)
>  {
>  	struct usbhs_priv *priv =3D dev_get_drvdata(dev);
>  	struct usbhs_mod *mod =3D usbhs_mod_get_current(priv);
> @@ -857,7 +857,7 @@ static int usbhsc_suspend(struct device *dev)
>  	return 0;
>  }
>=20
> -static int usbhsc_resume(struct device *dev)
> +static __maybe_unused int usbhsc_resume(struct device *dev)
>  {
>  	struct usbhs_priv *priv =3D dev_get_drvdata(dev);
>  	struct platform_device *pdev =3D usbhs_priv_to_pdev(priv);
> --
> 2.20.0

