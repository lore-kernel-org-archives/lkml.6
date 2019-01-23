Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C38C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CAD217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="UrohC1vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfAWIz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:55:26 -0500
Received: from mail-eopbgr1400119.outbound.protection.outlook.com ([40.107.140.119]:41920
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbfAWIzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+JS7fW0d+8McX+X0CIjh28PWs2/m3OsrKNXRdrsARw=;
 b=UrohC1vmnMvgS5Xs9hrUij43S7cR8wndl+YX4+pzzP+oreLuznOPyepqLpwfh8SnWaYuiQ4oBraCOnSVrd/x0/rN68VAHECqZg5q3NpY79sPXxVcKlcdJNz/pfYqtxp0RFzlQ9BHi3f+IcmKfoWljnuMGKXqsfjiezn8TVwNzPU=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1851.jpnprd01.prod.outlook.com (52.133.161.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Wed, 23 Jan 2019 08:55:21 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::4a9:6014:ec1d:1122]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::4a9:6014:ec1d:1122%5]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 08:55:21 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Simon Horman <horms@verge.net.au>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: linux-next: Fixes tag needs some work in the renesas tree
Thread-Topic: linux-next: Fixes tag needs some work in the renesas tree
Thread-Index: AQHUspTn6hlmcCwiD0ScsWfL14p3dqW8jGqQ
Date:   Wed, 23 Jan 2019 08:55:21 +0000
Message-ID: <TY1PR01MB1770C404E14E88CB912D12D4C0990@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <20190123075605.116ddbd0@canb.auug.org.au>
In-Reply-To: <20190123075605.116ddbd0@canb.auug.org.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1851;20:bUW4CJcNcNEypJf/+8Osyz+Nft3xZdxL2lZevISUERp2jP+x3AzIkc/FriI1wbV2YmqsNv1zotc5PaC3jCsi26EZJkF83UzIqQYd1lL1LYBrt/f6sDqv2Pdfk/w/EfzGQ+ZskWM61tGVU6NY/5yYwcgeJdkoFPhGgKnLU4TyB8A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b8485824-fae9-4bd9-29fa-08d6811081b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1851;
x-ms-traffictypediagnostic: TY1PR01MB1851:
x-microsoft-antispam-prvs: <TY1PR01MB18511150AFF978E43DD861D6C0990@TY1PR01MB1851.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(346002)(39860400002)(376002)(53754006)(189003)(199004)(256004)(11346002)(446003)(97736004)(7736002)(74316002)(26005)(6116002)(3846002)(9686003)(476003)(53936002)(486006)(4326008)(186003)(6246003)(68736007)(86362001)(71200400001)(71190400001)(7696005)(66066001)(106356001)(102836004)(76176011)(105586002)(6506007)(53546011)(6346003)(478600001)(6436002)(14454004)(229853002)(55016002)(4744005)(33656002)(25786009)(44832011)(305945005)(2906002)(81156014)(81166006)(316002)(110136005)(54906003)(8936002)(99286004)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1851;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1qlIFaROrV19/4y5xZDIuzlI/TbBEMhEVCWaQ/numdbA0XQKADJSkLAH3fKrA+tZ3pgEdBMfnm4gEk0OWeJLq6/HCUDZqyBVUEyyGtwqVZNQdTZjRucSSNEZzxMUEuQe6GDutLsIaa05jvvTFHpqdMFnhQERN2mCxwrVNAiTpkyfGMNfZtXJm7PJ2jXmpC8zi5pNInVkaQqCHU46FgV6VdpYLC/UJv6Z2Su4Xy9rDa5wBIbRBxA7LuIRYpSt4U3Qvh25nkh9FqAYHMMjkMRZZkB5gf7P5PYN+ogcAh2UpQjJfO614Ry3cL8qtiFDLsFHxGKdW5aZiPriuG/sDvG8KFT9BfkZY1KIZnt5DcfmnXUUVYIbU1Lj24GJ2hU8VxC3XdA34gfecn2y7mtvkswFIFywO+fxkwpYg7tt7GUQ2Bk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8485824-fae9-4bd9-29fa-08d6811081b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 08:55:21.3036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

I am sorry for the trouble. My editor is configured to automatically wrap l=
ines when they are too long, I'll be more careful next time.
Do you need me to do anything about this patch?

Thanks,
Fab

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: 22 January 2019 20:56
> To: Simon Horman <horms@verge.net.au>
> Subject: linux-next: Fixes tag needs some work in the renesas tree
>
> Hi all,
>
> In commit
>
>   8d6e2bbaeceb ("arm64: dts: renesas: r8a774a1: Fix hsusb reg size")
>
> Fixes tag
>
>   Fixes: ed898d4fc19d ("arm64: dts: renesas: r8a774a1: Add USB-DMAC and
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Please don't split Fixes tags across 2 lines.
>
> --
> Cheers,
> Stephen Rothwell



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
