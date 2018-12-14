Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0558CC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6212075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="ohs3actc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6212075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeLNGBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:01:09 -0500
Received: from mail-eopbgr1320108.outbound.protection.outlook.com ([40.107.132.108]:6327
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbeLNGBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r61iIRUJpMxT4Jb1YOnr0Lo7bb/bn7LyMWs4nnWTOWk=;
 b=ohs3actcbLpF7KJXvI5IcNpzOkArYUl/izK5luH6Hbf28T7qN+IPpDlf1ULpERgyv1JQbgeRWNZmwnLf6u5GLXFLsvVekdHVKzuwl0i6XyTzN/IUNNjyIMVMHF57yH2g4+GURj+3f2nhvJPrRoEBTSvzlwAZXrj3jRSJg+0vCK8=
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com (52.133.184.14) by
 TY2PR01MB3465.jpnprd01.prod.outlook.com (20.178.143.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 06:01:03 +0000
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::9545:5575:a99a:a145]) by TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::9545:5575:a99a:a145%3]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 06:01:02 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Thread-Index: AQHUkyFmr2EcM9KjM0adGPwSzv5FHaV9vTAw
Date:   Fri, 14 Dec 2018 06:01:01 +0000
Message-ID: <TY2PR01MB2297D670A9D3B8D4B5BC0389D8A10@TY2PR01MB2297.jpnprd01.prod.outlook.com>
References: <1544732463-6685-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732463-6685-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB3465;20:XrTq+6GbncoSJoX5FL9xuil7clESTK3JXM0HeV7VABCD1pCz2W1yJEquXAUYZ4z8WDCSXoRQnoqHCn/KPh/lnFaF8IW8NbF9TDvd4OJPp7eWI8XUkXwcIuW1um7rU1pouSkLaFEW+B5QDF9xqQeddzQRg11bnmhQvA/3wXuJIAM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(979002)(376002)(396003)(346002)(39860400002)(136003)(366004)(189003)(199004)(8676002)(6116002)(11346002)(446003)(71190400001)(71200400001)(66066001)(6436002)(102836004)(6506007)(476003)(229853002)(97736004)(8936002)(54906003)(81166006)(110136005)(81156014)(76176011)(86362001)(106356001)(7736002)(33656002)(99286004)(25786009)(316002)(68736007)(478600001)(9686003)(256004)(7696005)(486006)(186003)(26005)(5660300001)(2906002)(345774005)(4326008)(53936002)(14454004)(305945005)(74316002)(3846002)(105586002)(6246003)(55016002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB3465;H:TY2PR01MB2297.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 8f0b5273-bbfc-4f33-5d13-08d6618986e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB3465;
x-ms-traffictypediagnostic: TY2PR01MB3465:
x-microsoft-antispam-prvs: <TY2PR01MB346577126D2D14DF96A729B8D8A10@TY2PR01MB3465.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:TY2PR01MB3465;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB3465;
x-forefront-prvs: 08864C38AC
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Wx/BxuR3JTvs8L/tNltTYeWs0DRlY3vdoPmIGqJWHmXeePWUUC91PvST2Wxs6+g0OowLut8A+kPpuedlSbGLh8VtK2LuH0RAXxgfCXabJLC792AfTW+K9uLSp7YdRqMf9mMskxMvtSNlgSSjncsTbcYZpGAqX1OxAfeQi+1SQQUiXG0rpjHHJTwXxG7TyHP9Ucida9DUy3RnOGqz2yjLcXRuPGt3gl8cT+DurvSHCEQpAG3UHkM1o/vHq4s/yVA7E3bCUMg7+DDljsoPldELcB85eb0f1F5FBZMejPBFgIrQ7BdCIHXcnq6A3TntJK5Y
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0b5273-bbfc-4f33-5d13-08d6618986e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 06:01:01.9730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

> From: Fabrizio Castro, Sent: Friday, December 14, 2018 5:21 AM
>=20
> Document RZ/G2E (R8A774C0) SoC bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

By the way, I'm not sure, but I'm wondering that we need to add
.compatible renesas,usbhs-r8a774c0 with .data USBHS_TYPE_RCAR_GEN3_WITH_PLL
like r8a77990 to the drivers/usb/renesas_usbhs/common.c.
What do you think?

Best regards,
Yoshihiro Shimoda

> ---
>  Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> index 90719f5..d93b6a1 100644
> --- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> +++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> @@ -7,6 +7,7 @@ Required properties:
>  	- "renesas,usbhs-r8a7744" for r8a7744 (RZ/G1N) compatible device
>  	- "renesas,usbhs-r8a7745" for r8a7745 (RZ/G1E) compatible device
>  	- "renesas,usbhs-r8a774a1" for r8a774a1 (RZ/G2M) compatible device
> +	- "renesas,usbhs-r8a774c0" for r8a774c0 (RZ/G2E) compatible device
>  	- "renesas,usbhs-r8a7790" for r8a7790 (R-Car H2) compatible device
>  	- "renesas,usbhs-r8a7791" for r8a7791 (R-Car M2-W) compatible device
>  	- "renesas,usbhs-r8a7792" for r8a7792 (R-Car V2H) compatible device
> --
> 2.7.4

