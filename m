Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2CFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C767C222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="G/GVgAFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502695AbfBNQVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:21:11 -0500
Received: from mail-eopbgr1400125.outbound.protection.outlook.com ([40.107.140.125]:56745
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394009AbfBNQVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7AY9zfnVGKsgUXUOwjtZxbR+DXQfuoj0UehVP2R7UQ=;
 b=G/GVgAFZMnrZdRx/sOrk4O56BE55OkCK293giEIas/dwtqYBqv++B6m69PrTB3cAILslAQgI7ohNvOfHmt5Zms+32iWRUD4LY42R2FGZw27zT6fgGQASEZT1sJaNxQUVebkmgjGW3/6y4VJOeBugfzdPiMiooETpE5iNyjfmubY=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1610.jpnprd01.prod.outlook.com (52.133.162.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 14 Feb 2019 16:21:02 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::9c4b:5b3e:212f:354e]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::9c4b:5b3e:212f:354e%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 16:21:02 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Simon Horman <horms@verge.net.au>
CC:     Biju Das <biju.das@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        =?iso-8859-2?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Lukasz Majewski <lukma@denx.de>,
        Michal Simek <monstr@monstr.eu>,
        =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ebiharaml@si-linux.co.jp" <ebiharaml@si-linux.co.jp>
Subject: RE: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
Thread-Topic: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
Thread-Index: AQHUrcqn7iCjVkUVBUihzBp2UqLnOqXfpZYQ
Date:   Thu, 14 Feb 2019 16:21:02 +0000
Message-ID: <TY1PR01MB1770A46D7FA45A8AFA923DADC0670@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-2-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1547663874-29411-2-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4985b6a9-b2e4-442f-3917-08d692986989
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1610;
x-ms-traffictypediagnostic: TY1PR01MB1610:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1610;20:l6BGst7vjLDHK1Hd6UoOyY27Uc/5dPBRLxzRV0ml+ndbblrjOmxPaFGT1zCYluTTMeG0MEKhVsLKOjSdPPdpVMb5XtaLuLZjDoeLY2JJW86WiUJOoYnAxx/mRwaPryutBPBZBXOvuJscvOSEsUICRqBJZ67zzfjuVKh/+LXT/a0=
x-microsoft-antispam-prvs: <TY1PR01MB16101140F848564B15C46C26C0670@TY1PR01MB1610.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(102836004)(53936002)(186003)(53546011)(76176011)(33656002)(446003)(486006)(25786009)(66066001)(3846002)(11346002)(6506007)(7696005)(26005)(53386004)(476003)(6116002)(44832011)(4326008)(6246003)(97736004)(256004)(2906002)(8676002)(68736007)(81156014)(229853002)(478600001)(71200400001)(7416002)(6436002)(81166006)(8936002)(413944005)(966005)(7736002)(6306002)(9686003)(305945005)(86362001)(55016002)(316002)(54906003)(74316002)(14454004)(110136005)(99286004)(106356001)(71190400001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1610;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: crmJU/w6SveERKyFvgk4J6pZGGTaLewk1SyoO+/PL1jFUzBppRh4hmeGmHG96PcYEHGVEUuo/BU3UN/wvPtBbU7gPAI/wj7HKplrryKHbH3jzAXyNLqqg9GKDBfOcmZw/8xfr1Vr4CxOtfsp/EScQYu/ZTHnFhEBvvlKOYvrvuO1EPtPbo8qR0wiCAbSh6/Nv/VqJVK5Fxkor8i5DfJZTx8BNKfMblmgvwfhFObZ6xUub/TMdZ864gfhxJRmzuFAywq7QzQsDQYDflSHkyU7hTioxU1dfxMhVQUAuiuF3DugykPaYA0mXCKFvzW3MmQ1IsPWj4GYGlTOmWSAj34Egh/JWyNzIaKlQTZrAanhbU6YeVtCkLftZsZaqusRRqZV65kubDw+LUOTPg1huwcnJLhlM8w2aRRXhZXO3WhFS6o=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4985b6a9-b2e4-442f-3917-08d692986989
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 16:21:02.2128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Who is the best person for taking this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 16 January 2019 18:38
> Subject: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
>
> From: Biju Das <biju.das@bp.renesas.com>
>
> Add Silicon Linux to the list of devicetree vendor prefixes.
>
> Website: http://www.si-linux.co.jp
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Docu=
mentation/devicetree/bindings/vendor-prefixes.txt
> index 4b1a2a8..02a7037 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -344,6 +344,7 @@ sgxSGX Sensortech
>  sharpSharp Corporation
>  shimafujiShimafuji Electric, Inc.
>  si-enSi-En Technology Ltd.
> +si-linuxSilicon Linux Corporation
>  sifiveSiFive, Inc.
>  sigmaSigma Designs, Inc.
>  siiSeiko Instruments, Inc.
> --
> 2.7.4



Renesas Electronics Europe GmbH,Geschaeftsfuehrer/President : Michael Hanna=
wald, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse =
10, 40472 Duesseldorf, Germany,Handelsregister/Commercial Register: Duessel=
dorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr.=
/WEEE reg. no.: DE 14978647
