Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760B1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EFB2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="lLY4YgvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EFB2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeLNI67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:58:59 -0500
Received: from mail-eopbgr1320105.outbound.protection.outlook.com ([40.107.132.105]:25371
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbeLNI66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2DU4BLQM6n420EASBkt91zHh42RwAsUexPUfw9S0Lk=;
 b=lLY4YgvNvQB64CfE6UYI5pDUdPZrKmP5EH/Y8vDOqL2Sh210+SPcbGmJNvxvGl2WPEeza+zsnXv6opKUwbKUYjPkawgNr8ubntgrXgiIqB5jXkDshDQ0Dc+2Vyj/0HEF0J0gACZdK66oR7DWWyiIh/xDxpFD9vl2d4jt1BUpxv4=
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com (52.133.184.14) by
 TY2PR01MB4601.jpnprd01.prod.outlook.com (20.179.169.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 14 Dec 2018 08:58:50 +0000
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::9545:5575:a99a:a145]) by TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::9545:5575:a99a:a145%3]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 08:58:49 +0000
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
Subject: RE: [PATCH] usb: gadget: udc: renesas_usb3: Add bindings for r8a774c0
Thread-Topic: [PATCH] usb: gadget: udc: renesas_usb3: Add bindings for
 r8a774c0
Thread-Index: AQHUkyGWqRH5TcjXZE2Sn2q0YFRPWKV97/vw
Date:   Fri, 14 Dec 2018 08:58:49 +0000
Message-ID: <TY2PR01MB22979B32566BCD1614272A2ED8A10@TY2PR01MB2297.jpnprd01.prod.outlook.com>
References: <1544732538-7049-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732538-7049-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB4601;20:6Cx2w2JNrAExBaqIZE8C2DqPWo4VqKAuiptAu/bEC2cz71tD5rw0JxSXpUvSvj3vATS0C29RwzmoGifCO+IiWuKB7lcGbQCywZnRTySqCgN+Fsd2AaE7KhVOhmEiMpIAXlSI2a/eyaTAtv1wayK3dXRm1hHYVNa+oTBTfoO13Ls=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(136003)(396003)(366004)(189003)(199004)(14454004)(81166006)(8676002)(7736002)(229853002)(8936002)(81156014)(478600001)(6116002)(2906002)(54906003)(55016002)(53936002)(316002)(9686003)(3846002)(25786009)(5660300001)(110136005)(4326008)(105586002)(345774005)(6436002)(6246003)(99286004)(305945005)(68736007)(186003)(26005)(76176011)(7696005)(102836004)(97736004)(486006)(446003)(66066001)(6506007)(33656002)(256004)(11346002)(476003)(71200400001)(74316002)(106356001)(86362001)(71190400001)(138113003)(98903001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB4601;H:TY2PR01MB2297.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 1b47882b-a2d4-4617-3a0a-08d661a25d15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB4601;
x-ms-traffictypediagnostic: TY2PR01MB4601:
x-microsoft-antispam-prvs: <TY2PR01MB460164829D73E610E9C3F074D8A10@TY2PR01MB4601.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:TY2PR01MB4601;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB4601;
x-forefront-prvs: 08864C38AC
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lmb81o1aObGKObc3ROt3SKrCM0UHXsPwkuNJ7Zg85YT3oxWKRPukvaOYGMdr+q6y6Z3AohgbteKj+Asxhe/Jf7Ih++IW/vUfTOWiv5eYaDQqPMEev5gFMcNtNlyOl+sfkH3zF35MwbLMpEYTuo+kcr8h9wn2i21lUKwLiJC3ZwLXa9OFAO4uEiQ0PLbdQJk0FdShKaOZ44vsb8Lnpl3g7rFUFjWnGl24h7/rmzPr9EGDoiU528IrcFtxMLuVQaO+EEgQUrZhwQlG69q6kWgMLE2me3tEnQDSHUy0UZ4/wO4cbTkhnwHSJd8uTp7ArXRV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b47882b-a2d4-4617-3a0a-08d661a25d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 08:58:49.2522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

> From: Fabrizio Castro, Sent: Friday, December 14, 2018 5:22 AM
>=20
> Document RZ/G2E (R8A774C0) SoC bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>  Documentation/devicetree/bindings/usb/renesas_usb3.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/renesas_usb3.txt
> b/Documentation/devicetree/bindings/usb/renesas_usb3.txt
> index d366555..35039e7 100644
> --- a/Documentation/devicetree/bindings/usb/renesas_usb3.txt
> +++ b/Documentation/devicetree/bindings/usb/renesas_usb3.txt
> @@ -3,6 +3,7 @@ Renesas Electronics USB3.0 Peripheral driver
>  Required properties:
>    - compatible: Must contain one of the following:
>  	- "renesas,r8a774a1-usb3-peri"
> +	- "renesas,r8a774c0-usb3-peri"
>  	- "renesas,r8a7795-usb3-peri"
>  	- "renesas,r8a7796-usb3-peri"
>  	- "renesas,r8a77965-usb3-peri"
> --
> 2.7.4

