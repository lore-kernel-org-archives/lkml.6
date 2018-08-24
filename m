Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DCCC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8552157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Xc+OMEt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8552157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeHXMFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:05:22 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:3149 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbeHXMFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:05:21 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie2.idc.renesas.com with ESMTP; 24 Aug 2018 17:31:44 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 9B3156FA09;
        Fri, 24 Aug 2018 17:31:44 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,281,1531753200"; 
   d="scan'208";a="290495024"
Received: from mail-os2jpn01lp0152.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.152])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2018 17:31:43 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iU+uOW8itfS5u6KYlQ1lSPUj7GPshYKsmFicY+F58wU=;
 b=Xc+OMEt/9ThrivcvKLcEVHosy4IaqeZttRlastvq2/4fhmozR0HoTueaaotggAKp+UWLRVvC55c5YsvUag2uY3W6N9HllhEoF99gWlaVhc/4GmHTfb7YgRMgzkvjOH544i9DbPlwFJwsBffevWsxYb+BmM5sq4BIsgypuGdxP1s=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1136.jpnprd01.prod.outlook.com (10.174.225.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Fri, 24 Aug 2018 08:31:43 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::51b4:b6eb:46a3:a6b]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::51b4:b6eb:46a3:a6b%5]) with mapi id 15.20.1080.015; Fri, 24 Aug 2018
 08:31:42 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>
CC:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: can: rcar_can: Add r8a774a1 support
Thread-Topic: [PATCH] dt-bindings: can: rcar_can: Add r8a774a1 support
Thread-Index: AQHUNjf7nHh7l6LJa0CYNoUoOvJ1AqTLnwIAgABJnwCAArNQAIAAALpg
Date:   Fri, 24 Aug 2018 08:31:42 +0000
Message-ID: <TY1PR01MB177055864EEAD487C2917860C0360@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1534516703-11448-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180822104856.34nusjd4ajtwb4ef@verge.net.au>
 <TYAPR01MB2285834E95AB0D0D3E2C5B72B7300@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20180824082643.7eapxf72iuvkdw3j@verge.net.au>
In-Reply-To: <20180824082643.7eapxf72iuvkdw3j@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1136;20:0FVINSRG+I75c7n+H/I+Be+AXRcZIfvMW5QDQH4r+9WmLNdh9fdC9aajJtxubKN9vZyLQHB7vD46BqrxAMJC3uW+wjbEsVYoubHhBzJQlHTbt4t2/jPKb3lQ6fkOlgcz2P7DNbsFmag3DzhG3YCQ75syTE/k11NaJLvFBo+OsQc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: a208ea7b-41c2-4edd-ba43-08d6099c053f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1136;
x-ms-traffictypediagnostic: TY1PR01MB1136:
x-microsoft-antispam-prvs: <TY1PR01MB1136469F68C2D87EEDA1E0C4C0360@TY1PR01MB1136.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:TY1PR01MB1136;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1136;
x-forefront-prvs: 07749F8C42
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(396003)(376002)(39850400004)(51444003)(189003)(199004)(229853002)(53936002)(55016002)(97736004)(9686003)(76176011)(5660300001)(6306002)(6436002)(345774005)(74316002)(6246003)(110136005)(54906003)(99286004)(8936002)(7696005)(2906002)(7416002)(316002)(68736007)(305945005)(86362001)(14454004)(3846002)(25786009)(478600001)(4326008)(102836004)(2900100001)(186003)(33656002)(7736002)(106356001)(6506007)(966005)(6116002)(26005)(8676002)(81166006)(81156014)(446003)(5250100002)(105586002)(11346002)(256004)(44832011)(14444005)(93886005)(486006)(476003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1136;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gn7Cp677iKyj3XQW8RP+mubDLXPIZCgv3AVs2Uqi/a55o7RpAdNywZVZxfLaoF/EUJDQSn7vVSWgqW6QuXoP5u/YD48NUE7Vq5s33nWiWY8Ei3egEvbDOk9kjjzWEG389XKH4KMOQJWIrEFACKJLFxR4iUmAmS/r9kz5KdQhUlpyElY+mbfx0aIjJVH14Dk1/hxPbtypZR/O78EJ+IcbceMAbu35CuNmAr0/2wGHov3j0zAIeeu9LhRYEgDU1CQEW04M1L2DPe0MV5ksq2EQMKLY8u1GXGfV7ladGbbutIgkv6uP0QgdzBl8KvQcPKodqJ/4y/VS3V2AsR7hLGMsEQjP4n7b6QGvVQG7T+TqTFQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a208ea7b-41c2-4edd-ba43-08d6099c053f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2018 08:31:42.5593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Simon,

Thank you for the feedback!

> >
> > In theory CAN could be broken if renesas,can-clock-select is set to 0x1
> > (clkp2) in the DT, as this value will be written to the CAN Clock Selec=
t
> > Register. However if the documentation is followed there will be no
> > problems.
> >
> > We should probably update the driver to fix this though, which will be =
a
> > change specific to all RZ/G2 devices, so perhaps we should also be addi=
ng
> > a "renesas,rzg-gen2-can" family compatible string as well? (to driver a=
nd
> > documentation)
>
> Yes, I think that sounds reasonable.
>
> But in that case we should pre-emptively not use renesas,rcar-gen3-can fo=
r
> RZ/G2.

What do you think about the following:
https://patchwork.kernel.org/patch/10573795/
https://patchwork.kernel.org/patch/10573791/
https://patchwork.kernel.org/patch/10573805/

Thanks,
Fab




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
