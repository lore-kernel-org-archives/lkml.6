Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8BDC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317F82082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Y79b9Zdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317F82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeLJIxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:53:54 -0500
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:19456
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeLJIxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ax5wr/LLTzArrQzAW+0ktKaeNZlMP1UEmzjHHWvSqko=;
 b=Y79b9Zdv4aMTSAFQNsgnHC9dZusuSUWAqhMdwuWyXv86b9HtBF/zwRjtmHx8Ic1dXqq98gBt6RkzlMPjcajmmZZ+r5AyB9tMKpozUA3YOdq7PKvXMqOipm1k8sc9AsBlNatNpJrtkERzJqHydzN8muzdfvPfAStjtMjjF1XYbNs=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0261.eurprd08.prod.outlook.com (10.161.35.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Mon, 10 Dec 2018 08:53:37 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 08:53:37 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 9/9] MAINTAINERS: Add maintainer for arm komeda driver
Thread-Topic: [PATCH v1 9/9] MAINTAINERS: Add maintainer for arm komeda driver
Thread-Index: AQHUjIQbKMr93tXBlkCa4E/cbgjDyg==
Date:   Mon, 10 Dec 2018 08:53:37 +0000
Message-ID: <20181210085323.GA8863@james-ThinkStation-P300>
References: <20181205101635.7696-1-james.qian.wang@arm.com>
 <20181205101635.7696-10-james.qian.wang@arm.com>
 <20181205115915.aakaiqpjxs62b3xl@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20181205115915.aakaiqpjxs62b3xl@DESKTOP-E1NTVVP.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0094.ausprd01.prod.outlook.com
 (2603:10c6:10:3::34) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0261;6:2upDeYvuuNpNOK0eB93Oqz3AZFrO0x23k0J1jSsus0WcYiFGE8IuYFixKxnVAYuXCvHzcwC9ZZFqVzAWjmr2Cez30IKJ3hr3Md9IMc9tb0JWnqxEXZ9RHsM1fQsdnkdl8ztyN3HNP+b9G2SXhl4+jDPXQq0AMr6bbIFxOsLNSFEnhovzYOOQBCIUtTJm/tM0UDwD19MUUNpC2QCjK/P4ivv4VT7xP85NcAjKPn2ZJK6a7oUOf3ds/ZknDqaVeBsvxiUeQyhe9f0DF/yALwk1MLtgIJ+sB1lZMdk0pI9NOxgA+UqHyWTaai/3/ggp3rx074miBqD19tMSjthfX1tL3Be40k4V89qbr87Y6p782VEKyDHHo6LDtftXMVpRbik1okma4aLHuJKBARaEupjIiUT3KBHXexqnRnE2yXG3nS10GYydgTY0Pvcjw5JorEcbrm6U7+27YWHIkzd0ptZURQ==;5:0V+JpkOV2/kRWUOmoUrOaGHZyT1Akyo/k1x/IG/BO3vOZphLq7ewK9PFV2I+MAz0BujorEpxOSDEGkPqdRnJtY16Kf4iQfqlhorcyQBG8oLW6QZI2Kf3bCo2qI8MmjINyTgjd6AD3jb8URwVgR/LL5a0WhmL+VrtrZcWZb65eIA=;7:tRqdD4CbJOsIOpwMe/iOU1EoY7O8RPnhS1QM44YmaR366ratYPKolzV8fILBNQR+zYvQb2r0XmpGFcVOH+OJSlhLQfRxY1ctCv5Xd/EUkui9H7DRbYtxMxgl/h/JPC/GX5LyBbXaxsNxQUE9DZsB6A==
x-ms-office365-filtering-correlation-id: 2ce221c2-e940-49cc-9657-08d65e7cf935
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0261;
x-ms-traffictypediagnostic: AM3PR08MB0261:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0261A89C1524CA2C36CB0013B3A50@AM3PR08MB0261.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0261;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0261;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(14454004)(3846002)(6512007)(6116002)(6506007)(6486002)(386003)(1076002)(8936002)(76176011)(81156014)(33716001)(86362001)(316002)(102836004)(5660300001)(8676002)(229853002)(106356001)(52116002)(6636002)(446003)(54906003)(66066001)(105586002)(33656002)(9686003)(81166006)(4326008)(55236004)(7736002)(58126008)(305945005)(6246003)(2906002)(99286004)(14444005)(68736007)(25786009)(11346002)(476003)(478600001)(6862004)(6436002)(186003)(486006)(33896004)(71190400001)(71200400001)(53936002)(97736004)(256004)(26005)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0261;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SXn6y7xfaZl1J0kTKLOVI871gS/1j54FhORumxZzmaJdxJuWwwtSwgPZGAE16FJcyMLz168HAWk+iORB+V4qhGTpLmNWHvlRTuz/lT5Zo+JzWRJ0IGvgkF1VrdIQjCCvCD2cT3Yh1qNLSZWwoKq7CzSajNB9qLvDx/bj3mcbDocxSJxsE5irn+2gHFFKsOE+POL8UctISGveqAkLqiSbMq2f++UG6bhecfkp/kP7nit0TQT62Sw1ngSaEehfcuFsOQJTeaNOVaHsG7v0+qbTkfVY0K0mUZLcZTKbNPTfyXE7nBKe3p2a3XfbiaBjGfVs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92329407A8DD974B8BCD4DC764B102C1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce221c2-e940-49cc-9657-08d65e7cf935
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 08:53:37.2490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 07:59:17PM +0800, Brian Starkey wrote:
> Hi James,
>=20
> On Wed, Dec 05, 2018 at 10:20:13AM +0000, james qian wang (Arm Technology=
 China) wrote:
> > Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 254b7b267731..9e44c2c2e234 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1132,6 +1132,14 @@ S:	Supported
> >  F:	drivers/gpu/drm/arm/
> >  F:	Documentation/devicetree/bindings/display/arm,malidp.txt
> > =20
> > +ARM KOMEDA DRM-KMS DRIVER
>=20
> The list is meant to be in alphabetical order, so I think this entry
> should be before the MALI-DP one.
>=20
> Perhaps we should make the Mali-DP "F:" rule more specific too. At
> the moment any changes under display/komeda will match that too (so
> Liviu and myself are returned by get_maintainer.pl for Komeda
> patches).
>

OK, will fix it in the next version.

> > +M:	James (Qian) Wang <james.qian.wang@arm.com>
> > +M:	Mali DP Maintainers <malidp@foss.arm.com>
> > +S:	Supported
> > +F:	drivers/gpu/drm/arm/display/komeda
>=20
> This one should have a trailing slash to include the directory tree.
>=20
> Cheers,
> -Brian
>=20

Yes, thank you

> > +F:	Documentation/devicetree/bindings/display/arm/arm,komeda.txt
> > +F:	Documentation/gpu/komeda-kms.rst
> > +
> >  ARM MFM AND FLOPPY DRIVERS
> >  M:	Ian Molton <spyro@f2s.com>
> >  S:	Maintained
> > --=20
> > 2.17.1
> >=20
