Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C2BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCA620657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p/qQ7/iD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404178AbfAPK7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:59:17 -0500
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:48032
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731772AbfAPK7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A33BbPg3genoIgXfTc0nIsv0MKciTREacU0wBCdNuQI=;
 b=p/qQ7/iDugzqOa+PbQM59coqzWJrYE/qrjSumjnUKRsRNJ6z4aJrN1jxM4AEYQfBYJZOkQa8MY6Ns9hSz2jTulJ+gUy/oehLqUgiQFKk3BqwwWP0Aj3rSgLkM/uTeC8ma8kU8fuRcLl22paE/YCuEEpVhEBprAQUduiNIRPQMjI=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3438.eurprd04.prod.outlook.com (52.134.3.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Wed, 16 Jan 2019 10:59:10 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::8c7b:7d91:36c7:1426]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::8c7b:7d91:36c7:1426%7]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 10:59:10 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
 platforms
Thread-Topic: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
 platforms
Thread-Index: AQHUmUIyF6ylLjPS3UibJyYT5PgWG6WrD8gAgAbCicCAAA9NgIAAALAA
Date:   Wed, 16 Jan 2019 10:59:10 +0000
Message-ID: <VI1PR0402MB28007817A29E6116D1FAFC2BE0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-2-git-send-email-ioana.ciornei@nxp.com>
 <20190112024725.GO32649@dragon>
 <VI1PR0402MB2800E8F9F1884EB0669EE9F0E0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
 <20190116105559.GM15808@dragon>
In-Reply-To: <20190116105559.GM15808@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3438;6:MZZNlSHAFcknU/tjPt352wO7ni0G/kZYGjw5jGNFqE6M8SpBk2n27S9ZL5hgPUpvMO9PF3w1RQ0jpfvqtTObUn87Da7UjD83MMvA5SNTMoWicTlAkntciAepjaNgdzhd4DEyqegsJsv5f/2HVF/VnPfh2dxRNPTnvo6hFnwO2P8uWWXmxxltbIVp+lNgne07ZetuuAVNDZCkhzNXcL8alP0/SbvdmWg8u/s7okdcJyZ4Ba9xj5NKv74wPXyhJUncSUR0FBlUN2a+noHmpQNXdSwEDmnd/Aen0v6i/d7xlMrgjaseEEI/UqY1oGPUqF8AxweIysteADgSiRJro5tJk7n/Y0i+o5SdCOmeZqv7FEpWOL5ayKkndueVZuADxe4adKvCKE1rr54o5EdChBvFLVPvaoEFtLJrJjSq6QDmiHNtr1380hGvBmQ5gSNE5fm1xqQHU9E/cCTpiMKGR1/+Zw==;5:tTWa5HmWJ1tnaaqTULZ/3f9t/uJXv3fIS+exDn59HRBIFvRenu+WV2QpeyoxdrsyT/aRe5vrDtITWLvQ9DZ8GLyzaHxnSjqJiouSxdTnT8OQNixtHkZlJapOiqd87ECxE0SmFn3LlHzWeNJo/PQbY/fbhf0soqsLXyXUJZTvSLvXDfC93C4pXL+c3SP4QfkectuFdqWHXrPzU2yVKwt+SA==;7:eO/mHGTf0rNVJI/53cB63Lu2OZAQ06YxB8Ct8MiUzKwjGsATicv4K1oldtXhLvTC/DqAiPqI9jcirmsEg4QKZaKxbHbM6Sn4KgtHZVozGJPjMxRAhXtXDjtWEWhKi6GkwRreCApkclHSEpYGwU4zzQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5633100a-063f-49bb-1dc2-08d67ba1a4de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3438;
x-ms-traffictypediagnostic: VI1PR0402MB3438:
x-microsoft-antispam-prvs: <VI1PR0402MB34381864296D43B7BD809370E0820@VI1PR0402MB3438.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(51914003)(199004)(189003)(68736007)(8936002)(54906003)(11346002)(66066001)(44832011)(6436002)(5660300001)(229853002)(81166006)(81156014)(316002)(55016002)(446003)(476003)(26005)(186003)(6116002)(99286004)(486006)(8676002)(6916009)(3846002)(74316002)(305945005)(7736002)(4744005)(6346003)(102836004)(14454004)(105586002)(93886005)(86362001)(76176011)(6506007)(7696005)(9686003)(2906002)(53936002)(71190400001)(71200400001)(4326008)(478600001)(33656002)(6246003)(97736004)(106356001)(256004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3438;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: be9UDOnKSrFq952RJExiLc7SeM0IB2xMUVGHpvwXBjOusw1ZFhMTcz/y7P8UUUkf93Z8w2VfA3arQ+1ESwccEgwI4W+yYAJ9iRLfQtVvwF2wtkZTKlHQQU25o4VJO7N1+tSPnjskafHJGRs52v6gFz1+xDKKbl8QtTEy240k+3Mo32H/ih45oVwc6orD5Zz5U7NAnUwVlO6MOwXQhZ1n+r2fPHnmvFHnLCAxc2IL4E5Kh2GFjFANKyKd6b8Rw186F4unBfyZ/I6l8SGH867oTF+VKAdR5lJ9UXw0CEcCI9ufUhGXdZKjOwGXj7P87vxpwC07WC7SkuTrqaeV3tb5agRpyzJmtg4sPfqRSb2ucPChdsQvCGHsVwPfiaFSrAivfR/tFfVmSSkWZIi42URFm0R81D3xKosR4OclQZiLttc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5633100a-063f-49bb-1dc2-08d67ba1a4de
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 10:59:10.4143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3438
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
> platforms
>=20
> On Wed, Jan 16, 2019 at 10:02:01AM +0000, Ioana Ciornei wrote:
> > > Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for
> > > DPAA2 platforms
> > >
> > > On Fri, Dec 21, 2018 at 03:31:09PM +0000, Ioana Ciornei wrote:
> > > > Add the dpaa2-console device tree node for the following
> > > > DPAA2 based platforms: LS1088A, LS2080A and LS2088A.
> > > >
> > > > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > >
> > > DTS patch generally goes to the last in a series.
> >
> > Should I resend this with the DTS patch the last?
>=20
> You do not have to resend the series only for this.  It's pretty much a s=
uggestion
> for future posting.

Ok, thanks for the suggestion.

Ioana


