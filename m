Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FB7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EBE20818
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="kxpqfy12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437767AbfBNJdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:33:38 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:11383 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388196AbfBNJdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:33:37 -0500
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id F4/F9-04268-DE5356C5; Thu, 14 Feb 2019 09:33:33 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRWlGSWpSXmKPExsWSoc9rovvWNDX
  G4N5dPotTLXvYLa5cPMRkMfXhEzaLb1c6mCwu75rDZtG5q5/VYsP3tYwO7B4bPjexebRe+svm
  sXPWXXaPTas62Tz2vV3G5rF+y1UWj8+b5ALYo1gz85LyKxJYM248/cRW0MBV8ejtIZYGxj6OL
  kYuDhaB9cwSzy4+ZgFxhASmMkmsa9nOBuE8ZpQ4susvexcjJwebgIXE5BMPwBIiAvsZJc5OXs
  YO4jAL3AVypr5lAakSFvCRWPbsLFiHiICvxMrFP6FsI4lNn38yg9gsAqoS/14uA6vnFUiU2NK
  /gwnEFhJwk/h54AeYzSngLvHp7E6wXkYBWYkvjavBepkFxCVuPZkPViMhICCxZM95ZghbVOLl
  43+sEPWpEiebbjBCxHUkzl5/AmUrScybewTKlpW4NL8byvaVOLn9ONgzEgJPGSVOnH8D9CYHW
  PO3t74QNRYSS7pbWSBq9vBJXLg7D2pxgcTlTy+hDpKRuDZlIRtE0WQ2icuL57NDfJYs8WEuJF
  QkBOQkVvU+hJp0gVliz/OJ7BMYtWYh+Q7C1pFYsPsTG4StLbFs4WvmWeAQE5Q4OfMJywJGllW
  MFklFmekZJbmJmTm6hgYGuoaGRrqGlma6hibGeolVukl6qaW65anFJbqGeonlxXrFlbnJOSl6
  eaklmxiBqS2l4Ej/DsZny9MPMUpyMCmJ8hpfTIkR4kvKT6nMSCzOiC8qzUktPsQow8GhJMFrZ
  ZwaIyRYlJqeWpGWmQNMsjBpCQ4eJRFeVxOgNG9xQWJucWY6ROoUoy7HgUUP5zILseTl56VKif
  O+ApkhAFKUUZoHNwKW8C8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEubtBFnFk5lXArfpFdA
  RTEBHPBVJATmiJBEhJdXAqLztoXqmerjeMz0v1vO+DHfufs9+vnlBy/FCfn9R2Yvy0+1lD+0o
  eWwglJbXFrJKKDns9OWgxi1ckuapLVrat2cvkt9hVORZ1+/OV3Qqv39BtLOVGmNu+uXYlA3P9
  a8WJZtxMJnPe/Eic6PO942ffa1XFOusanTSFDav1Qv5lh0mMPH7iT9KLMUZiYZazEXFiQBrn8
  TX8wMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-3.tower-288.messagelabs.com!1550136812!2395384!1
X-Originating-IP: [104.47.13.52]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26394 invoked from network); 14 Feb 2019 09:33:33 -0000
Received: from mail-he1eur04lp2052.outbound.protection.outlook.com (HELO EUR04-HE1-obe.outbound.protection.outlook.com) (104.47.13.52)
  by server-3.tower-288.messagelabs.com with AES256-SHA256 encrypted SMTP; 14 Feb 2019 09:33:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhWKhgy8zzaLShj2QxQ4QG4OfJEn1VOP3/AtGQm8t0k=;
 b=kxpqfy12n9FEUd3JJ7f2AMsP/kkNS59vsBslw5V9jV/zp5bdmLaYJZgQHnUEjS4UF/kmoAuqpXkrE9yghZXAzTgvFk6gVmp9pQU/TugJzISCoqTnqqIM2uC40JsHCimjgiS46Yxr4zihclaeDgPRTl+8VUiNLgDoMoIiztEZVy8=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB1073.EURPRD10.PROD.OUTLOOK.COM (10.169.154.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 09:33:31 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10f2:a1bd:4f0d:f118]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10f2:a1bd:4f0d:f118%8]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 09:33:31 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC:     Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 0/2] ASoC: da7219: BCLK and TDM flexibility improvements
Thread-Topic: [PATCH 0/2] ASoC: da7219: BCLK and TDM flexibility improvements
Thread-Index: AQHUw8QxaOsmPPVjVUG5Ee/Mri8v7KXfCDng
Date:   Thu, 14 Feb 2019 09:33:31 +0000
Message-ID: <AM5PR1001MB099488F6A0CF887CE90C41E880670@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bc67ecc-1945-4065-8b69-08d6925f7b90
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB1073;
x-ms-traffictypediagnostic: AM5PR1001MB1073:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM5PR1001MB1073;23:c+9cIX2u4WZYspfCeKGnyTmnpeGNcq9x/1H4YC7?=
 =?us-ascii?Q?J0S/ih0eViKrRdjcgv/YO6eAl6XxYlZGYWf+RvqzIOE4U7Gknjkr4FKaRpBz?=
 =?us-ascii?Q?ajyxDqG1nTH+0T1Y+xWG5lkwYFcNhsJZgLcHexYAnuN52GGpxOZ1u8O1nnpc?=
 =?us-ascii?Q?/NeAkfhm+dySh3UGz//IKI2GZnvD2h/Ec55kNgZbDEsBK+LC0Ks9nQEq6YOB?=
 =?us-ascii?Q?jwgve75BRNMfKxuFQ+BFxviuACR9znNb+GglPtu03QxsEJ7Eet17weD7hEHv?=
 =?us-ascii?Q?jyfq5ZdnRTQ0779IcA+sDWopNH7ICbaLAwLoMzfndNuagxYQkBAngX/Zoerq?=
 =?us-ascii?Q?eHkzrh1xDjiUurmsc5XJv7RCpc/mJZQnDtJLZW70do5OxitTe+9nPTe37e5g?=
 =?us-ascii?Q?jgeJEzBQkH6VR90OUALoTweWZ4DWxYRQCb4en/lDgIb40ej61pbSUJCA7ltD?=
 =?us-ascii?Q?xlyNbhzvUbtTFCVDfIVvUQ6yUYDcmIDTw7GlHN8UwyrluqfSiNSFbk6rcwzY?=
 =?us-ascii?Q?Jr3chloBcteVy4xf1SitsQbPycOK6WqXR0KLUImTWVYUHNqNj5tDaN2PBtEl?=
 =?us-ascii?Q?kLNbCwyvhc9yBIo2jG5JzDQTTmG027EIATbClQysqOIDmfO0jVjVZ3E8Y0Rf?=
 =?us-ascii?Q?KOWF60kHU65KlQr4sQCQ1HtBTvBjTzg8A+BDlYsKjoFoKIcxKhk1OvpSlpJ1?=
 =?us-ascii?Q?l0WL8FJAfQ1UiCIPK19tvyfO6SXnMSsN2I5t9Zw50WS4V4MgZPA8qufOQbte?=
 =?us-ascii?Q?S2mKJ9+DeQ2hW3cdq6wQu56MH7sgVmzl85Cp1h+SfEYj6khRwqZi4wXNDAn1?=
 =?us-ascii?Q?Dc/V2b36BW3zqJEt0Qvcp0lLLDGW7z2ZkjJmBP3+i7Y4KzbbNj/eHKBw+h/z?=
 =?us-ascii?Q?nQJpiZGIrD2FEP2nfprkQOu8vLVcRrZAhgox0Wjl6lYDj2TktvXX12uH0iom?=
 =?us-ascii?Q?cCDPKzJaiEqaNB2B8CFo4id4juZKt2C/7lgtEd6YH5fHpWIXGvi7FyOb8D79?=
 =?us-ascii?Q?D9KaxJENwiudnawP7e+PwZEN7Tl7heWzPc2JYvatk+J+v6KAVxSaGlQtX7nC?=
 =?us-ascii?Q?92aReu+uV6YM6uu9ovZzpu16g3NhVPxcBJJft9Es/qUNWtOR8xQRMyXraDhj?=
 =?us-ascii?Q?hmkiGjxmqvo+GZSFKm1QQlhhPDJBsWO5lS1zh3RK7GxpaAawmrNqNtDpbwLV?=
 =?us-ascii?Q?PwzH5c/p1xCH0IrXYi19FlQV4C6HFNN1IKAOY5CetsE1drgJ4UtWXk9HJG6x?=
 =?us-ascii?Q?QoS+2W+k8j6xgmKqMeMFxqDnoyoxbeaF2HJ02AbLM+eFztO66lx8HNZmg2v8?=
 =?us-ascii?Q?r1XEcgwMhrfkdrR5rF7uyk80NxyYzrVxL/Vumou6AruWNINa8ZNUg8Y4tzGk?=
 =?us-ascii?Q?nu5dQBOAVSBG/rJ0Beh4NtRNwS4c=3D?=
x-microsoft-antispam-prvs: <AM5PR1001MB107393BE5947B4201C26B666A7670@AM5PR1001MB1073.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(346002)(396003)(136003)(376002)(189003)(199004)(11346002)(72206003)(86362001)(476003)(6506007)(478600001)(102836004)(14454004)(71190400001)(53546011)(26005)(74316002)(55236004)(71200400001)(446003)(186003)(68736007)(110136005)(54906003)(33656002)(229853002)(316002)(97736004)(76176011)(55016002)(81166006)(8676002)(81156014)(256004)(99286004)(2906002)(66066001)(14444005)(8936002)(305945005)(486006)(53936002)(4326008)(107886003)(6246003)(7736002)(106356001)(3846002)(9686003)(6116002)(25786009)(6436002)(105586002)(7696005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1073;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QBjML6F8XwExH1dvEnYq1kVm8OAVpDvP36bcda9Q9usqTCJkpkAeXLtB7C2nBKFQnuVGYoIWwwVH7glKB3big1JlXuqlMSm7+XZvX2sWirPH8MBLM5xSJlfUDNuPAKKgRFE+R6uAY6sxUgPbXXVEbu15h3NdU/FDOqVZ9yKxD3ZXFL9nHowdnhIYYYO7llUsD+ttQt8+porXRHyWdi68oR+HsY4HoUhUIkLWIx6asH/tz3uyJ8wWHhQiP3InnyQoPjob5kt5dTw5+jpTBk8RDfdwERiNLkFQlCJjH8F+YUTYX3KRgJ6Ck2OomFUg8iNz+ckZ2RobNUNJ3MjFaSP9RtUoHZ4WIuKoc1v9FL9CrWR/jIKTBCTUcmt9oWCFHNlfozCbKVCi0GjJjcSl0I3jEOodKYTtA1edfvb4WmdW5oY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc67ecc-1945-4065-8b69-08d6925f7b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 09:33:31.1642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 February 2019 17:48, Adam Thomson wrote:

 This patch set updates the driver to be more flexible regarding the BCLK a=
nd TDM
> configurations of the device.
>=20
> Previously the BCLK rate was fixed at 64 periods per WCLK, when the codec=
 is DAI
> clock master, but to satisfy devices which prefer a lower rate, and to sa=
ve power,
> the BCLK rate is now calculated based on hw_params() data.
>=20
> As a fallout of the BCLK efforts it was also apparent that the TDM code c=
ould be
> made more flexible as well. The device is capable of automatically detect=
ing the
> BCLK rate when it is clock slave, so previous limitations imposed were no=
t
> necessary. The mask handling is now used as an input to determine the BCL=
K
> offset to align closer with other examples within ALSA.

Spotted a silly '&' instead of '&&' error in the 1st patch. Functionally wi=
ll work
but technically should be updated. Will send V2 soon.

>=20
> Adam Thomson (2):
>   ASoC: da7219: Add support for master mode BCLK rate adjustment
>   ASoC: da7219: Update TDM usage to be more flexible
>=20
>  sound/soc/codecs/da7219.c | 116 +++++++++++++++++++++++++++++----------
> -------
>  sound/soc/codecs/da7219.h |   1 +
>  2 files changed, 74 insertions(+), 43 deletions(-)
>=20
> --
> 1.9.1
