Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B752C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB5421852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="jDZ3nxbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbeLRLlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:41:49 -0500
Received: from mail-eopbgr1400093.outbound.protection.outlook.com ([40.107.140.93]:48566
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbeLRLls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+3fBgNnspZ8po3rXrF52ZJHdUS0PkXhgYBiC2bbCKo=;
 b=jDZ3nxbZ7mZIfqnCpEJhGUyuyUhgTVXGYOaoD1owfiPJRsaenC074lQy7GhB8VDmd/ZLnw/8OLdnhnE+enZJj74MG+Mwm9K6aFeaf0fU64vYDu5e4F/IGLGFDOlp310/qQtAc1JmHDdEPQvEFWJIXmjw4EAqa5xC/H2xoEx7Mf4=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1642.jpnprd01.prod.outlook.com (52.133.163.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Tue, 18 Dec 2018 11:41:44 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::dcee:f270:d42b:5b48]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::dcee:f270:d42b:5b48%5]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 11:41:44 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: i2c: rcar: Add r8a774c0 support
Thread-Topic: [PATCH] dt-bindings: i2c: rcar: Add r8a774c0 support
Thread-Index: AQHUkyEcJgA+wpgOfU64mlpSc8tCkKWDiDWAgADeq8A=
Date:   Tue, 18 Dec 2018 11:41:44 +0000
Message-ID: <TY1PR01MB1770DD6B3F98F9C1B6B2252FC0BD0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1544732342-6131-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20181217222410.dfy2them2skvlnuw@ninjato>
In-Reply-To: <20181217222410.dfy2them2skvlnuw@ninjato>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1642;20:eOITLy03m1Adi/3SyP5C3IG0eWgjGOra+8l3Qj7Tfkh/PqcuSAac5n+N9+SGpGH1jU4iprN8V7YVKXNpyOe0mRTbsu//lqKxcsNEfr0Ddo9+iN3I4mOPE8+alRN3x5jAHKrcIchgkzKi0D4IlImhwdmKInScuFKmXyExOaVHvaU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: dec5fac7-cf75-4f07-2cb3-08d664ddc95a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1642;
x-ms-traffictypediagnostic: TY1PR01MB1642:
x-microsoft-antispam-prvs: <TY1PR01MB1642926000C1EA79BCFCE913C0BD0@TY1PR01MB1642.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1642;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1642;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(136003)(366004)(396003)(189003)(199004)(316002)(476003)(11346002)(99286004)(229853002)(345774005)(68736007)(446003)(486006)(26005)(44832011)(74316002)(106356001)(305945005)(105586002)(76176011)(186003)(33656002)(6916009)(7696005)(6436002)(5660300001)(71200400001)(86362001)(97736004)(71190400001)(7736002)(102836004)(6116002)(256004)(2906002)(7416002)(8936002)(25786009)(6246003)(53546011)(3846002)(81166006)(54906003)(10126004)(6506007)(39060400002)(4326008)(66066001)(81156014)(14454004)(478600001)(8676002)(6306002)(53936002)(9686003)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1642;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6Cy2y4gBTCgGJAKo6ncN1Dx+smpNRcq3ml6XItROo+N5q3xkKJx+/NOu4H/Jxr67Xd1oT08SVfLBuqEhY8B6Y76jYbRNUvgU5TuCWQHIljJZZk8P2v/twajRF95EnFk1XXl2PMmzBtayup0f0eMcVUtIWL7ESVAjpYJA4bwB3WepdbeZfuaJ79jbGS9gQ7YqPz++g485gIu0WXvQciXxd0wbbpLF22GpfWXtcRTC3gwawbZ++Nkwq8Hy5VkQrt79Sn5DPxDd2fWffQxNYiytwO3axooIG2ttHYy12bxEBtDekwA4tBjiAe91NRaJqcyb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec5fac7-cf75-4f07-2cb3-08d664ddc95a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 11:41:44.6953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1642
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wolfram,

> From: Wolfram Sang <wsa@the-dreams.de>
> Sent: 17 December 2018 22:24
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>=
; Wolfram Sang <wsa+renesas@sang-
> engineering.com>; Geert Uytterhoeven <geert+renesas@glider.be>; Simon Hor=
man <horms+renesas@verge.net.au>; Biju Das
> <biju.das@bp.renesas.com>; Ulrich Hecht <ulrich.hecht+renesas@gmail.com>;=
 Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com>; Hiromitsu Yamasaki <hiromitsu.yamas=
aki.ym@renesas.com>; linux-i2c@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Simon Horman <h=
orms@verge.net.au>; Chris Paterson
> <Chris.Paterson2@renesas.com>; linux-renesas-soc@vger.kernel.org
> Subject: Re: [PATCH] dt-bindings: i2c: rcar: Add r8a774c0 support
>
> On Thu, Dec 13, 2018 at 08:19:02PM +0000, Fabrizio Castro wrote:
> > Document RZ/G2E (R8A774C0) I2C compatibility with the relevant driver
> > dt-bindings.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>
> Fixed the typo in the commit message and applied to for-next, thanks!
>

Thank you for fixing!

Fab



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
