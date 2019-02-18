Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8324BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F97520449
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="D2HYSKt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbfBRQN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:13:57 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:45222 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730659AbfBRQN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:13:56 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6ad9bf0000>; Tue, 19 Feb 2019 00:13:51 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 08:13:51 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 18 Feb 2019 08:13:51 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 16:13:49 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.55) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Mon, 18 Feb 2019 16:13:49 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2742.namprd12.prod.outlook.com (20.177.125.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 16:13:46 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1622.020; Mon, 18 Feb 2019
 16:13:46 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     Timo Alho <talho@nvidia.com>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V1] i2c: tegra: fix tegra186 hw supported features
Thread-Topic: [PATCH V1] i2c: tegra: fix tegra186 hw supported features
Thread-Index: AQHUxhVQ1WlW0g4S4kamGG0+ILXH8KXlP5aAgAAOlACAAFgfAIAAFYDQ
Date:   Mon, 18 Feb 2019 16:13:46 +0000
Message-ID: <BYAPR12MB3398E17BB92CC0D33996FBD4C2630@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1550334787-27703-1-git-send-email-skomatineni@nvidia.com>
 <20190218084227.GB19363@ulmo>
 <42aa92c1-309e-88c1-1cd6-07592990730b@nvidia.com>
 <20190218145002.GC19190@ulmo>
In-Reply-To: <20190218145002.GC19190@ulmo>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3180a67d-41f9-41f9-3541-08d695bc0f3f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2742;
x-ms-traffictypediagnostic: BYAPR12MB2742:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR12MB2742;23:0qkZEBs5jMjOpXl8ZJmLOvCj8JyDlzNYWkE11Bix+?=
 =?us-ascii?Q?LZC6jfqVjKLDwo3AJxOY9d60psF/2V3KUhd8j6lgAqUycYe6ROfFBPhKZTwB?=
 =?us-ascii?Q?qD/5DaNjWoyv+ZkBrHtJKadPLLN0JHm5+Nht3ylVJWTaOkGmh5twyc7WLdjg?=
 =?us-ascii?Q?1uTF6aeRDl6K9d/ZTFpwTX0NuVkxqYl5jwqLcGEu9kVTGcQs5DCtjhqRm1/r?=
 =?us-ascii?Q?96n0tgKK4dljWEzpk+D2y3+XSuf4qwjf/XHBczW4ulqOe1hMzWgp3le3NfMD?=
 =?us-ascii?Q?Pe3ZpA0sFkbKmgQSUmIU5+vK7gqXzGQLv+HLLiJfaoaOV9hQNfgGdHWu7bCd?=
 =?us-ascii?Q?bgDkVDwxx1MZI5E9XFHdTr25Nq404+2a/ezcXzEgVWumPsL5Xv/DAWNpRus5?=
 =?us-ascii?Q?8jB5TR33PZduuxX9c4w1ruJV59Nsm3zcr7qxhgOn06Ls8WJCR8H1XBkTAEZB?=
 =?us-ascii?Q?+Uj765NVupgfmiFtc6RjSi3ZnXPuyQJZhK2oSjGLglDrmSWM7NAbPZI82e4f?=
 =?us-ascii?Q?4vln+AAq1x4gQojXoNNMGrx0OfxICY8GEGKEfzKE30MdxxPQor+8BfAc8q0i?=
 =?us-ascii?Q?rmXhsTs23ByEX8B4UMEsmsuOkeQauRwfi/NYaa0fn9BJKlRnja/4t05BxZ1N?=
 =?us-ascii?Q?/OeVlTe7vavq33lKW0UItmiYJZ9+05D93mQtnUa9XiE3cJsNl2woRZ+oriNp?=
 =?us-ascii?Q?PIX2UWPFvTj7+MsfIWVc6yy/dDTAU0Pew9f0p1p64pIKmLlZiOUUWi/RjuEk?=
 =?us-ascii?Q?jnt9v14cE01HbaJoYxdxUNfsOdNO0+5S/0OVhsTbW6Rd2Gmof8Y/RcOWqufv?=
 =?us-ascii?Q?Bo3mkLi3upYo7hmAwk+FqcAIhYy1OieRZGyB+GVePMPXWpRSuQ8uuAeuZDTD?=
 =?us-ascii?Q?sigFRaPU87IwyMzGKd0ipsBpsqZqh8zjIBc9TJf366PLowHPXwaxv3VElWnT?=
 =?us-ascii?Q?8qtO9C8YpPyRTthMmm75KUDVO7RMChWCthGZTfkJCbRph0fnFRtDnxg/NPZu?=
 =?us-ascii?Q?DeaCATdp9aTuUZwEoeAtqVCR2HpIN7KdITi4JBgCbb+iHA5tS314mTE5ZW32?=
 =?us-ascii?Q?H4TxHTiV/nmO/tAXuQzdVX9O00UyggLbqwLCAtKHQmiFkbtjVxNfXbdKkvNY?=
 =?us-ascii?Q?hgRtLu4uPfhxuUDKJGZqv9L1sPpr5QPj0p1RKMHHq4/ulAzOQEPAjB2Spcaz?=
 =?us-ascii?Q?Zr/XGhPrHLOxyn06PZ/YKBa9eG2qxn3MLwcW4PtVq806xXmkFI9euvCTxg/F?=
 =?us-ascii?Q?Wtk4knT5Q2OcbLlKa4=3D?=
x-microsoft-antispam-prvs: <BYAPR12MB27427BFFA74200EE7327989EC2630@BYAPR12MB2742.namprd12.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(376002)(39860400002)(199004)(189003)(5660300002)(106356001)(9686003)(86362001)(6506007)(68736007)(6436002)(478600001)(71190400001)(71200400001)(102836004)(105586002)(256004)(316002)(110136005)(55016002)(53936002)(305945005)(25786009)(6246003)(3846002)(6116002)(53546011)(4326008)(7736002)(93886005)(54906003)(74316002)(97736004)(7696005)(66066001)(2906002)(446003)(11346002)(76176011)(33656002)(486006)(81166006)(81156014)(8676002)(99286004)(14454004)(476003)(6636002)(26005)(229853002)(186003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2742;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KByop3y/93xUwZ0MWkvThS2EuNzps8kdH77fATX54JCK8TSdgtqAvRoNlZIN5DOnKVp7hZP3MnonMYzVddXOzk55q72NfaCCd+Tr77/EboaEIq0rSlYhuL/xarzQ9bAGyH/FoeKWPLWXjLooD3FZ/QJ91Uz19rd+xjpXPhwN3YXKNlnid/eXqnsPtLeRuJisEEgdgpyEiK4WcFZcdOCY5B/vH9dpM71/ZsK8oKMvDLnEelJcajh45i2d8JQAOcOUnUsVlLGiiyhA6zgSv8YxSvrObFv+B9n/A4beiqE9jN93MhqtlxUJtzaof1k5WNsY3Khnyk0UaMd5ufpaiPRSGhBIdhWqEcUtGz0+NuuxXaYVVj5v/yVKD1qbRqfurRoDgB438MGo031jbk/7anEiW787VqkKwjDFgqFANsgyhNA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3180a67d-41f9-41f9-3541-08d695bc0f3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 16:13:46.0383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2742
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550506431; bh=kcJmxxmv9GZP0GhS+h8mZsISAPVJsI/oa0Ug5IN29mY=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-microsoft-exchange-diagnostics:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=D2HYSKt5+M38YD54qKTEgqF+p1+cVFPpRs03LbAhYGLMuZ8Du3P+DjnoiBHIZv6aj
         SPo8wo/BYRr3s+DszF+rBjeK9T98pp6V9S9TEc7l+0//lZJ143HOY/NIeLAXg+Fhol
         12ECJFeMuKHGBxhxi9HIiqGzaK9Q7FozMyhyk60k8ni/kU+FJSSnePn3kPNEdiO64r
         vpQdYvBFCghHtp7tzd1jT8cPVbW7SmQ/sMtdjPT7XZD0IBK3aHwbLT0y8g8pH9/xOH
         CU4b8FT6PHUy4gJED651gk2HSV+/oAHTJG9GknMmj9kX8ydbNNfqST3DyiHJEm6mqr
         9yQZ+VTmfG7qg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >=20
> > On 18/02/2019 08:42, Thierry Reding wrote:
> > > On Sat, Feb 16, 2019 at 08:33:07AM -0800, Sowjanya Komatineni wrote:
> > >> Tegra186 does not support multi-master mode and also there is no=20
> > >> master fifo control register.
> > >>
> > >> This patch fixes supported features of Tegra186 and prevents=20
> > >> crashing during boot as master fifo control register are not=20
> > >> present on Tegra186 and prior.
> > >>
> > >> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > >> ---
> > >>  drivers/i2c/busses/i2c-tegra.c | 4 ++--
> > >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > We really should've caught this earlier. Jon, let's think about ways=
=20
> > > to make it easier to catch these things in the future on our test sys=
tem.
> >=20
> > Indeed. This has fixed the boot regression I was seeing over the=20
> > weekend on -next for Tegra186. However, I am bit confused here,=20
> > because when I look at the Tegra186 TRM it states that the I2C=20
> > supports multi-master mode which disagrees with this patch.=20
> > Furthermore, it seems odd that
> > Tegra210 and Tegra194 would support multi-master mode but Tegra186=20
> > does not. So is this really correct?
> >
> > I would expect at least the missing master FIFO registers to cause a cr=
ash on Tegra186. The internal architecture specification also says that mul=
ti-master is supported.
> >
> > Sowjanya: do you have other documents that suggest we don't support mul=
ti-master on Tegra186 specifically? Or is this to work around an issue spec=
ific to Tegra186?
> >
> > As it is this contradicts documentation, so we need to either fix the c=
ommit to remove only master FIFO support or we need to fix the docs to refl=
ect reality.
> >
> > Thierry

Thierry/Jonathan,

Design wise we support but due to known hw bugs we defeatured multi-master =
mode. TRM docs also says no multi master support for T210, T186 and multi-m=
aster is supported only on T194.

T210 also has multi master enabled in driver. We should disable that also.

Thanks
sowjanya
