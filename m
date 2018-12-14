Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC82C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA51D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="ARXrr1k1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA51D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeLNIUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:20:43 -0500
Received: from mail-eopbgr1400107.outbound.protection.outlook.com ([40.107.140.107]:22372
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbeLNIUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHZXSRw10yJimH3oAEXsBk0JujnhSWR3jW6C3H5z84M=;
 b=ARXrr1k1x5t0Hlp9maDzAN3yqznSirMV5luNgQCnK75aadkt1vRNnNrePUJ1lkgrSTbwGefNwBgMi/OLRInguT5Ug5EujHkJ1Ru1+Li41gvT5t3maVgwkdm6bFuHQNuzn/vmTocJPZY71SojKKI2sQJUt535F/uPztMLTOBZhec=
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com (52.133.168.140) by
 TYXPR01MB1485.jpnprd01.prod.outlook.com (52.133.165.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 14 Dec 2018 08:20:37 +0000
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::64fb:82d3:31d2:1a12]) by TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::64fb:82d3:31d2:1a12%2]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 08:20:37 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH] dt-bindings: net: ravb: Add support for r8a774c0 SoC
Thread-Topic: [PATCH] dt-bindings: net: ravb: Add support for r8a774c0 SoC
Thread-Index: AQHUkyEM/gyhUN9RTE6cc0dQZ64erKV95LTg
Date:   Fri, 14 Dec 2018 08:20:37 +0000
Message-ID: <TYXPR01MB17757A77BB1088F94AD0C3A8C0A10@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1544732314-6041-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732314-6041-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYXPR01MB1485;20:T92Jcp3qOu3zPMPB9EEaF6EwmKQnrjRxJi2QgPps6wDqWJwbumo4hNdA53T+yhj2DqYYhjf4WVGS9pR4OrmsNe2gzdQLxUG7cbWbP+igEwAoRO0iKoNfB7uGkj0cBRWEtlb0WOzpnqnExGwnhnpqIX+yQT6RRbJkSNKsgndhQ20=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 65a819be-baba-449e-f381-08d6619d06ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB1485;
x-ms-traffictypediagnostic: TYXPR01MB1485:
x-microsoft-antispam-prvs: <TYXPR01MB148560F858AA5EFEEAB34C6DC0A10@TYXPR01MB1485.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TYXPR01MB1485;BCL:0;PCL:0;RULEID:;SRVR:TYXPR01MB1485;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39860400002)(136003)(199004)(189003)(478600001)(14454004)(476003)(10126004)(4326008)(5660300001)(446003)(6436002)(11346002)(102836004)(71190400001)(71200400001)(9686003)(53546011)(99286004)(186003)(26005)(7696005)(6506007)(76176011)(8936002)(25786009)(2906002)(3846002)(6116002)(106356001)(105586002)(6246003)(86362001)(229853002)(44832011)(33656002)(66066001)(68736007)(316002)(7736002)(74316002)(55016002)(110136005)(54906003)(53936002)(6306002)(256004)(305945005)(486006)(107886003)(8676002)(97736004)(7416002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1485;H:TYXPR01MB1775.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 18yZOZLUGzU4KgwSWG0J5wmB4ZoCr6HP5aihC4GiaacynxUBapcXfZf/Vvq1CcB5LiVjXRHNfvcz/eHnYmyqGh86OFocWvVxXL7JBcsfRUjHFy4Y+ykBhYnd7R3jKn+u1w5o6B7R0wVFyNwFlj4z82r4B/Xbr44sCPU5QL6S/0qGmLB0Pe2KJlOkGqbK/DG8gihAaYhkfGfyQzLY4Y9+hxS9Adz5V5dr3MPt3UlrIbWS/XtanTz5RzZ7h+ediJZHmF6cn6PKnJ8rx/VHKc6p/eiIwtwDfDxoSj0L4kMLhaNdDkRCrAK9mxyVsbdaKPNW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a819be-baba-449e-f381-08d6619d06ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 08:20:37.2669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1485
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is for net-next, sorry for not putting it in the subject.

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 13 December 2018 20:19
> Subject: [PATCH] dt-bindings: net: ravb: Add support for r8a774c0 SoC
>
> Document RZ/G2E (R8A774C0) SoC bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/net/renesas,ravb.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Doc=
umentation/devicetree/bindings/net/renesas,ravb.txt
> index 3530256..7ad3621 100644
> --- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
> +++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
> @@ -18,6 +18,7 @@ Required properties:
>  R-Car Gen2 and RZ/G1 devices.
>
>        - "renesas,etheravb-r8a774a1" for the R8A774A1 SoC.
> +      - "renesas,etheravb-r8a774c0" for the R8A774C0 SoC.
>        - "renesas,etheravb-r8a7795" for the R8A7795 SoC.
>        - "renesas,etheravb-r8a7796" for the R8A7796 SoC.
>        - "renesas,etheravb-r8a77965" for the R8A77965 SoC.
> --
> 2.7.4



[https://www2.renesas.eu/media/email/unicef.jpg]

This Christmas, instead of sending out cards, Renesas Electronics Europe ha=
ve decided to support Unicef with a donation. For further details click her=
e<https://www.unicef.org/> to find out about the valuable work they do, hel=
ping children all over the world.
We would like to take this opportunity to wish you a Merry Christmas and a =
prosperous New Year.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
