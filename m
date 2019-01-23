Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C37C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AB920861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="KVb7W5fY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfAWKlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:41:25 -0500
Received: from mail-eopbgr1410112.outbound.protection.outlook.com ([40.107.141.112]:45696
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727050AbfAWKlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzyV3c3FciZmLbbUYTaoE16LNp6+NZw6JjEleR+wklE=;
 b=KVb7W5fYFh8RzUWZAhJ7O7bolzSsj6vkUH+nRk1OB+AUCJ0/I/0Omf3YrIhB2r2ddrOEY8pqL1QdFciLeEjoRa5vYzBwevkG8T+d2FZ0PIZjrne3jqdZ8erc1UwBiH2ewEBDknmw2rPLdlELls5hSWohXL/LiUUVSsIg/SGgln0=
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com (52.133.168.140) by
 TYXPR01MB1728.jpnprd01.prod.outlook.com (52.133.168.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Wed, 23 Jan 2019 10:41:20 +0000
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::b5fe:6253:600a:4540]) by TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::b5fe:6253:600a:4540%3]) with mapi id 15.20.1558.016; Wed, 23 Jan 2019
 10:41:20 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: linux-next: Fixes tag needs some work in the renesas tree
Thread-Topic: linux-next: Fixes tag needs some work in the renesas tree
Thread-Index: AQHUspTn6hlmcCwiD0ScsWfL14p3dqW8jGqQgAAeMgCAAABhcA==
Date:   Wed, 23 Jan 2019 10:41:20 +0000
Message-ID: <TYXPR01MB1775F5B4C96D81299ECC3AF9C0990@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <20190123075605.116ddbd0@canb.auug.org.au>
 <TY1PR01MB1770C404E14E88CB912D12D4C0990@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20190123103914.u7nlz624j5dmy7yr@verge.net.au>
In-Reply-To: <20190123103914.u7nlz624j5dmy7yr@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYXPR01MB1728;20:Q/n/BaJZvrTMjoRBEb0OuXpaA00ZQ17v4sMFSY36+Xv8yCKJQIv4jqdmnyqYwVY+lc677xulEpAwkpnvNrQvQRfu8asIjBYTVX12JQXE/2Gc3SoUWVR2yJka9Db2wMDttUsvIHLXmaM7W8cMnU+X1s1X5SJBG4euiiNfaP++gG8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 09c711d5-6100-47f1-03e7-08d6811f4fd0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB1728;
x-ms-traffictypediagnostic: TYXPR01MB1728:
x-microsoft-antispam-prvs: <TYXPR01MB1728D17F47D289A6FD4C7433C0990@TYXPR01MB1728.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(53754006)(189003)(105586002)(44832011)(99286004)(53936002)(486006)(11346002)(446003)(7696005)(476003)(14454004)(97736004)(54906003)(6116002)(478600001)(106356001)(3846002)(316002)(53546011)(6916009)(4326008)(6506007)(102836004)(76176011)(25786009)(2906002)(6246003)(33656002)(26005)(186003)(68736007)(55016002)(229853002)(6436002)(9686003)(86362001)(74316002)(71190400001)(305945005)(7736002)(8676002)(81156014)(71200400001)(66066001)(81166006)(256004)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1728;H:TYXPR01MB1775.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y26Q5i/OaI8dEQfq7TCdqolqmFbh8xtBgebqvpTU8sJ9EDh/rf2nbhoMn8O5A4oAnPPxon4jNSjO70Mi9zYQPyjIuMEjj61lN/3ZmLPPn1qpP2Kg1JMoxd5DP1w4+Ench3byZxuqHpr9Wv2xJ2KlHzCv6J352R1lPsh4cIshXi7npc8BW5zFre2Toy/HmaVzeUFjzeWodmiAIcfBM+kFgx9HqHohIc5uvoeE9hAXtfaL9L+AoXPOmVLMQb7ZpByj6tIdIIUEcdxWGv/RDkVJ3moMRmKa+BHfDwMdgQOF9OlN4K29L/l7tmZpj5vVt4YNNkZ3ulQZQ1oQPS5x82MoLAx0tfjpMQgjR2HCFNb7z9KO3hAyCQhUlnY/K+TxIbOnBgCY8ZHhlbsHxIlFCk0yd1iTB6Q2FYA1L+tILApch8Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c711d5-6100-47f1-03e7-08d6811f4fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 10:41:20.1255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Simon.

Fab

> From: Simon Horman <horms@verge.net.au>
> Sent: 23 January 2019 10:39
> Subject: Re: linux-next: Fixes tag needs some work in the renesas tree
>
> [CC linux-renesas-soc]
>
> On Wed, Jan 23, 2019 at 08:55:21AM +0000, Fabrizio Castro wrote:
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Sent: 22 January 2019 20:56
> > > To: Simon Horman <horms@verge.net.au>
> > > Subject: linux-next: Fixes tag needs some work in the renesas tree
> > >
> > > Hi all,
> > >
> > > In commit
> > >
> > >   8d6e2bbaeceb ("arm64: dts: renesas: r8a774a1: Fix hsusb reg size")
> > >
> > > Fixes tag
> > >
> > >   Fixes: ed898d4fc19d ("arm64: dts: renesas: r8a774a1: Add USB-DMAC a=
nd
> > >
> > > has these problem(s):
> > >
> > >   - Subject has leading but no trailing parentheses
> > >   - Subject has leading but no trailing quotes
> > >
> > > Please don't split Fixes tags across 2 lines.
> >
> > Hello Stephen,
> >
> > I am sorry for the trouble. My editor is configured to automatically wr=
ap lines when they are too long, I'll be more careful next time.
> > Do you need me to do anything about this patch?
>
> Hi Fabrizio,
>
> I should have noticed this myself. I'll fix up the fixes tag
> in my next push. I don't think any action is needed by you
> at this time.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
