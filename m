Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AFFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 07:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B81720842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 07:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="w0mZ0LCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfBYHAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 02:00:33 -0500
Received: from mail-eopbgr60051.outbound.protection.outlook.com ([40.107.6.51]:5747
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726780AbfBYHAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 02:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wwWLrgCD5nJRDufovDJHG+W40wWWdEENe9n4/D7X0A=;
 b=w0mZ0LCOGU1lyhbqjlrCPdO0lyjcJ4cibsnFWKWrTJ36yIiaY0r8ROLOrDkFFZhajyf1JjD0FpyRt/YN0GW7BjdjIMqIyQ9Bt+J7ugeErnHq5xyaG+oa45STLdb17x5c9WWucC7uSvWKa4Tyzwx9xhW5yj9ILzZWJ6F6CWbNL/A=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB2701.eurprd04.prod.outlook.com (10.175.22.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Mon, 25 Feb 2019 07:00:28 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%5]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 07:00:28 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     David Miller <davem@davemloft.net>
CC:     Leo Li <leoyang.li@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] soc: fsl: dpio: enable and configure cache stashing
Thread-Topic: [PATCH 0/3] soc: fsl: dpio: enable and configure cache stashing
Thread-Index: AQHUy1SUKSv6icZdy0+EHj+pLsN67qXwCfKAgAANvbA=
Date:   Mon, 25 Feb 2019 07:00:28 +0000
Message-ID: <VI1PR0402MB280056BBF62A86E1703C549BE07A0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <20190223084816.28985-1-ioana.ciornei@nxp.com>
 <20190224.220653.256212672271785631.davem@davemloft.net>
In-Reply-To: <20190224.220653.256212672271785631.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.127.41.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbdb21ac-a809-462a-e147-08d69aeeecd1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2701;
x-ms-traffictypediagnostic: VI1PR0402MB2701:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR0402MB2701;23:8NH/XzKN21P+CMFaSx6C8ON4XJrqo0+Vax80CKy?=
 =?us-ascii?Q?oHVsWuiBWTsyjmhlFJ4vN5pjkIWcwKHCLJFr5H16/Z8YlUsxOCDlcPRXPVC6?=
 =?us-ascii?Q?WaRsXsYm8S/jNCkqe+bp98YBhzaw4TCSJ7xYQSoZyJSjgDVSwaKxINU6RSsa?=
 =?us-ascii?Q?MvHsuWEK4wNzY0Ck4bzb9mHBEXYW6f1PkFP7YTDcayVRdd/7QMtv89W1PCX4?=
 =?us-ascii?Q?cQfD80Gi9rPtV88YhHAeSi0f9MLvvN190Rlvq+3u49fqGPq1DgTK8zyyz1dJ?=
 =?us-ascii?Q?JoYWVIHeC3Rl7CF9QmvfYoJoynrpigbtxwC31xQ+5DgxvGGl1VaplygJry/v?=
 =?us-ascii?Q?cxgZe0/xlQ3it2IRlw5840JV0CbGpMI8wvXwgHcvd8vLiDcxVhvS+RwOpjo5?=
 =?us-ascii?Q?VxmBWlXu9KQo899Ge3JqtOh5lQjm4jltaqtb/6hhjEAg2g9OuAIZjZHkvX6S?=
 =?us-ascii?Q?/j1Uy71/Y6bnslBF4oPP9fMbdDsbQPxv4QlDp+c9EtKCblyE653GxyeKtMf8?=
 =?us-ascii?Q?+jxDc5Kb3U/y1bUOj1u1HsBV0JxSMm0NTA7cSYT/fWIBQzSf6Gm1/W/meHp3?=
 =?us-ascii?Q?D9VMtUYnSRJEFY12kvtlOsHIipKZ4M13oY0GlTUuAnoPgIHXO706qxUouhf9?=
 =?us-ascii?Q?Pi6fPI4q3YPbaCYUT3t+e5BNL/cGUapfAnK+4RxVcyYr6kdM4E45cktkEyhY?=
 =?us-ascii?Q?cR84nxVOU8sGfwCWFnVCJMPvKiIYiz9HA0R8hWNA0rf6LYx3b3tal1iio8fH?=
 =?us-ascii?Q?y4e5Q0jThenWmnIOqPD546ub6z8HIefH2VJpV6WtL+v9ZHAzTzsg9ccT0nFH?=
 =?us-ascii?Q?RlJ9KXY0BiLnLovSCGzpyWq4CYNZriR41SjkNag1tAI8LNfA1d9OTyStRntS?=
 =?us-ascii?Q?rL+78WR5X2/3rRJnFsQehN3e1XE6Shw+i0RWviR6gcR5e1uWGcfpM706wbcb?=
 =?us-ascii?Q?CXlJjoUTzfOeH4cbw3UMFN/zw7S5+CBq5zZc9WCgzWXPLEdtg2qPbnmgtvmN?=
 =?us-ascii?Q?9XbQh87wQafl8+7zwE8YoDbf4DSsBDw5MixLVnfAcFSvzto2Np1122sRpRjn?=
 =?us-ascii?Q?lCZIna5m6GqrD/xqqVFJXjLpr7x/BIYTF3a+hHBXFrEpRqDRi0uiim4mPT81?=
 =?us-ascii?Q?Tmipo31pyMTEDdEb9oemw6NbG8ZhV+vev8rFLj3F44Z9JqqWr42vJVDP+XB3?=
 =?us-ascii?Q?xT7vjQGMzFWnd5LVC9rlfRdeItp7g/igudZn0JXE+kGcKS4iwMSTPQ8uU5wY?=
 =?us-ascii?Q?uu3G5uthmMZLIm3xXAaY=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB2701C310C0957ABD8DF1914AE07A0@VI1PR0402MB2701.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(396003)(346002)(189003)(199004)(66066001)(71190400001)(71200400001)(86362001)(52536013)(106356001)(8936002)(76176011)(54906003)(7696005)(478600001)(44832011)(256004)(4326008)(25786009)(9686003)(6916009)(105586002)(55016002)(5660300002)(6246003)(446003)(476003)(8676002)(486006)(81156014)(11346002)(229853002)(186003)(305945005)(14454004)(33656002)(68736007)(6436002)(99286004)(74316002)(4744005)(7736002)(316002)(2906002)(97736004)(81166006)(53936002)(102836004)(6506007)(26005)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2701;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rb4/b+inFt74vhOOdC84J2mNkMc3wSGT/fyyssEZGQnxHhcozm498ZJMVN0T8uS/HVrw21IzAVn6+0Xyk7eg7zfBodhdokbuEzHtyHVC9PUhXdRmhuFByVzbIajBAqIlLQ3Wl+CM//eU5vc92kQ8Qh1bL7G8U0mz2UM4Q2YfLgVdfUA6MMdmb7QpG3vdoeAo00SplavsbNKQ03qNy9sIJRM8HXc4HB12QBZ+ptSvoEXJsj23H8o6vwIC2vRSnMY7XlnXdTSLqdoe9NfWJQAWSIm3vT5kL4eSkRPJfzRVeG20KRxYib+/pytMc6pPZ3S5RpX3wa4844QlMT7H35CN8MxGpCLuDNyKAPIJ7i4S3nnumTU3CEiIYW5bZnX2c6Dpw/gBJKhC0CzlnVHtjOZuDEOQq8o04j2VxjyleDXOEBw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdb21ac-a809-462a-e147-08d69aeeecd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 07:00:28.4224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2701
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 0/3] soc: fsl: dpio: enable and configure cache stash=
ing
>=20
> From: Ioana Ciornei <ioana.ciornei@nxp.com>
> Date: Sat, 23 Feb 2019 08:48:42 +0000
>=20
> > The first two patches enable cache stashing and configure the core
> > cluster destination per software portal while the third patch is the
> > one configuring the amount of stashing on a queue.
>=20
> Should I merge this series in via my networking tree?

Even though it would be really good to have this on the networking tree as =
soon as possible, I am afraid that patch 2/3 is not going to apply cleanly =
because it touches the same areas of code that some other patches on Leo's =
tree are.

Thanks,
Ioana C


