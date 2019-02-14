Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DB8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447AD222DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="B9IvcjlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502521AbfBNQJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:09:32 -0500
Received: from mail-eopbgr1410095.outbound.protection.outlook.com ([40.107.141.95]:35072
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405580AbfBNQJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2mWiNq2FfITs/SZtGdpgyrAySZJBMyZpPSmVtncqbc=;
 b=B9IvcjlLd1i8hRs9dP5Mh73PsLt5yyYjmB+BVY7CrycsaiuMB/v8K1hT+xDg89r+TOR1uwJtWxvKC+x4nVeoBOrdmPCzyRBzOWZxRGp2thCDfot0IidGiB6PIo5D64G/OuOWNTvTgvfZIGMkuXFzU/fRP58lW2Ko+Q/8kN3jKys=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1801.jpnprd01.prod.outlook.com (52.133.164.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 16:09:25 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::9c4b:5b3e:212f:354e]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::9c4b:5b3e:212f:354e%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 16:09:25 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kees Cook <keescook@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH] usb: gadget: udc: renesas_usb3: add support for r8a774c0
Thread-Topic: [PATCH] usb: gadget: udc: renesas_usb3: add support for r8a774c0
Thread-Index: AQHUkyHJAo/7voQe8EumlR5E6t9Sj6Xf2ELg
Date:   Thu, 14 Feb 2019 16:09:25 +0000
Message-ID: <TY1PR01MB1770317703AABF9DBAFD2FC5C0670@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1544732635-7367-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732635-7367-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5b62af1-5faf-4e94-05f3-08d69296ca72
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1801;
x-ms-traffictypediagnostic: TY1PR01MB1801:
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1801;20:8wHxZQvmhBI4V5Zcfn3BmhhJ5194h2sG0s4cHCbtJSTiW9RIMOsNOEK1EHs2pOJRe9cqbAwSUQ0UhJhNPM9CHApXg4Q+YPzNHKUfN9cweUwJhznXlrFPuOrKtqA2rOfp8VaI6ha+ADff8WqNlgPw2XfS5jEi/k/lEojPViezhf0=
x-microsoft-antispam-prvs: <TY1PR01MB18018C7A92B6A8BDBFAAF00DC0670@TY1PR01MB1801.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(476003)(11346002)(229853002)(6246003)(14454004)(305945005)(7736002)(2906002)(25786009)(106356001)(105586002)(107886003)(256004)(446003)(186003)(86362001)(71190400001)(486006)(6436002)(9686003)(26005)(55016002)(44832011)(71200400001)(478600001)(53936002)(68736007)(66066001)(4326008)(7696005)(6116002)(3846002)(54906003)(81166006)(53546011)(6506007)(33656002)(316002)(6916009)(99286004)(97736004)(76176011)(74316002)(102836004)(8936002)(81156014)(8676002)(138113003)(98903001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1801;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NVZmHnc7hz2VX13e2bfWQTNbNCZ0PX5grc0+QAervJyZOsN9TnVvrEqX513AQCSsfMy7KZaXUCQWenx6th4tcOH9SvN+hwde9ovoCqFu3ajcdbVEnYm2OFVYdI+8U0nByzq6R3ab+vdTAcJZCBFR4Va+Xn6ROhP1QC60Titju77AkQfBwxujsTjmtnmu8Po+IdmUJlU/esNHoDQ5h5OugKSEEj0xp2sR2Zx+ppg52p/1OX2VHSmMgsxwCe75TK16fXdGrszOX8AlYMLCYy7RpfkiQ6ECDhNfsKvTRzerE+qk39ClckhbJMdvm7+nBd75FkHJHQzQXeWRG4RsYUHLNSOyhwkPV7Qk4702WtEiW5hN8rTrkSjPHWkamITOQK7aTc9aYeCMW5Q8iQCRp428KVLL95xYfcNQOqGBStphcho=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b62af1-5faf-4e94-05f3-08d69296ca72
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 16:09:25.7623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Felipe,

Who is the best person for taking patches for renesas_usb3.c?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 13 December 2018 20:24
> Subject: [PATCH] usb: gadget: udc: renesas_usb3: add support for r8a774c0
>
> RZ/G2E USB 3.0 implementation is like the one found on R-Car E3,
> therefore add the same quirk.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  drivers/usb/gadget/udc/renesas_usb3.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/u=
dc/renesas_usb3.c
> index cdffbd1..18444a8 100644
> --- a/drivers/usb/gadget/udc/renesas_usb3.c
> +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> @@ -2625,6 +2625,10 @@ MODULE_DEVICE_TABLE(of, usb3_of_match);
>
>  static const struct soc_device_attribute renesas_usb3_quirks_match[] =3D=
 {
>  {
> +.soc_id =3D "r8a774c0",
> +.data =3D &renesas_usb3_priv_r8a77990,
> +},
> +{
>  .soc_id =3D "r8a7795", .revision =3D "ES1.*",
>  .data =3D &renesas_usb3_priv_r8a7795_es1,
>  },
> --
> 2.7.4



Renesas Electronics Europe GmbH,Geschaeftsfuehrer/President : Michael Hanna=
wald, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse =
10, 40472 Duesseldorf, Germany,Handelsregister/Commercial Register: Duessel=
dorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr.=
/WEEE reg. no.: DE 14978647
