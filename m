Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E811C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5516F20880
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="RhLWDBhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfAUHOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:14:21 -0500
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:43081
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727169AbfAUHOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4ig44lkgrOYoYZVbQZjTmmO1VguQShh/EcRwbOa7GM=;
 b=RhLWDBhLeMKDbnqYzL5CWs5dXd3ddg3knftFjSZnMHGQhF5BrGihYmoOV9G0/bdxgR9nAbaid+joWbJU37Th3nxNPdLzE5w3pklVcG0XoFDy0tEcrki8Y+M2xXMJED80sireNWKDOe7VPf7xb1/9IrJXK2aEzYdjaDV+/tJhKqY=
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com (20.176.163.138) by
 HE1PR05MB3130.eurprd05.prod.outlook.com (10.170.242.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Mon, 21 Jan 2019 01:59:04 +0000
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3]) by HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3%5]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 01:59:04 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clang-format: Update .clang-format with the latest
 for_each macro list
Thread-Topic: [PATCH] clang-format: Update .clang-format with the latest
 for_each macro list
Thread-Index: AQHUr4Eh70TZu0hTXUGviIikMXZ6KaW26v0AgAAKIACAAAdWAIAAA4CAgAAdQgCAAd2DgA==
Date:   Mon, 21 Jan 2019 01:59:03 +0000
Message-ID: <20190121015855.GD18031@mellanox.com>
References: <20190118225658.GA28312@ziepe.ca>
 <CANiq72=o_7d63MXJJn6dEnt76viF0YV4svp-5VBHk7JKyjXJDw@mail.gmail.com>
 <a5eab6ca68ee1eb837c8c86b69b4696846af719b.camel@perches.com>
 <CANiq72nAX=UjAZnmh7zk+0PUnGBfAjTUfZ1YsXmkeVZ+eMJuHQ@mail.gmail.com>
 <2324fe307d1e077225171e7436ff1a4fc96292f5.camel@perches.com>
 <CANiq72md_UVj2ZYXhmnqK29CNvCOdwOHU0Gfy-Kr50hNDJ7rXg@mail.gmail.com>
In-Reply-To: <CANiq72md_UVj2ZYXhmnqK29CNvCOdwOHU0Gfy-Kr50hNDJ7rXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:300:117::17) To HE1PR05MB4601.eurprd05.prod.outlook.com
 (2603:10a6:7:99::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR05MB3130;6:hbCwcysPlvQ+Sc78dYR3ALj+wMMpuwEl8T6XQqJu2S8VLywbU7oVJGtwDAajIJdyV3lEgN6Pl49Thkq/SgYgyeMMJxUashfQ9/zyfrgIjMCl9DmgNUw6ZSBhcaRxaiR+mOpliDQgz9Jw86ogxVzeUtbCXtqZI8qFdq7iUjMQKbrg6npJucrR4lkfl9NkASXbeMTX+oNKm3BNQA3USRedyBusQrd3BZDvEytX05s8ecE9GK0WfanmSLrRaUze8UntM4bEOWJqnY67zuvNnekxbIstQrcoD/S7kGEESB8aFnuJBzTMhWhcxBIrRT9fHDizrmSXtbUmlrksuSAIcDU3yL5iK4FLfgWIXdN7HUr6d0csNWrrZENQK0OLQ5kepblFHsWpYMLti8dY+AlM9rVqSDGHSC996Mdt2VfrSWidtqd8HG2CdWq200JupsvG2jHWOtdpx4MUKax8ISWKO2RupQ==;5:fVlIEpPPk1+Pg0ho9tAZD4+/xs5RMNhkYt3PuhoulDPWSp510Km7PB7lgmSVBPWm+0FdCV7m/bM1k/jE1J1Da+eLIENB3QG7iSexDnu72WeSquTbbH+i1hlOfx/45DKzjX3sPxLdydFFPgk5ilRR5qvfpTFItA20AhchLFsUe/YHyg7jYmR2UIIvK2asrtNaJJYEwYl8sCuCZla15TmxgQ==;7:tsBNIxs2imS34cj1sJ4DT6JFFR/4oHIxfnT07gV3f5NX4SzfVD4OEAwxLTMeSYqeRgtBdWwYXIzhWYd7HzP9mW93lh7OlmhabOQAjjzNxnloazJAYSI87i6XwbH5EZ6YcorSK3t/mBKRzDnhp+kWpQ==
x-ms-office365-filtering-correlation-id: bd2a29bb-d812-46c3-ca50-08d67f4404c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3130;
x-ms-traffictypediagnostic: HE1PR05MB3130:
x-microsoft-antispam-prvs: <HE1PR05MB3130DBC7E44B33283B8A41CFCF9F0@HE1PR05MB3130.eurprd05.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(39060400002)(14454004)(36756003)(386003)(6506007)(53546011)(1076003)(97736004)(93886005)(76176011)(52116002)(6512007)(66066001)(53936002)(102836004)(2906002)(71190400001)(71200400001)(86362001)(99286004)(106356001)(105586002)(229853002)(6916009)(6246003)(6486002)(81156014)(81166006)(8936002)(256004)(478600001)(33656002)(316002)(25786009)(68736007)(54906003)(7736002)(8676002)(15650500001)(14444005)(4326008)(6116002)(2616005)(476003)(186003)(11346002)(26005)(3846002)(446003)(486006)(6436002)(305945005)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3130;H:HE1PR05MB4601.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AuNREpue2JQqfFHBFeksYLlVcbYJ+6ym3x1MwBaAA7EYSzQ9lM+M6k/TGKqlKLQSIScxttO7XXZyOfR46CLt6Egt1taTtfJoCDe2u7M972pgEG3B7mI1JBCKHUxCgdv6xRQaijqZr4znzvZ77Fefu1FYnnUDmfbcJ+BOsjL4ySEIUoCcUV1uOSRrIav2o4CQTKB7qK3JwnqedGadVUwRE05hnY9P44VP+pWyMLruN8BOrh+jhaFOBEDQBdkYKQJwNcunWWRNt0Oogg9EHfh0JIK3USRaXK8zrHHWtj/b3QirdaX1N66wafjUGZViVRLYwAmH30Qc/RhFmQ2yX/AVoPIEvdqzeHGEXyZN4pE+3trTfiNq0+lEVFphwF3UCh6B4/IQ+J+ed6o1IqVnj02QZXMw0tE3LcglzQip6QE4wLg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <421E6BDEBD98324A8702DEFC09E6FAB7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2a29bb-d812-46c3-ca50-08d67f4404c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 01:59:03.3872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 10:29:50PM +0100, Miguel Ojeda wrote:
> Hi Joe,
>=20
> On Sat, Jan 19, 2019 at 8:45 PM Joe Perches <joe@perches.com> wrote:
> >
> > I suggest clang-format's ForEachMacros statement vector
> > be expanded to support regexes ala
> >
> > ForEachMacros:
> >   - Regex:           '\b(?:(?:[a-z0-9_]+_)?for_each(?:_[a-z_]+)|[a-z0-9=
_]+_for_each)\b'
>=20
> Ah, yeah, of course. And it should be easy, because there is already
> support for regexes in the IncludeCategories option. However, the
> configuration file was intended for clang-format >=3D 4 (when I added
> the file, the intention was to make it usable as easily as possible,
> i.e. taking into account the availability of clang-format in distros).
>=20
> Actually, if we were to change clang-format and then require in the
> kernel the latest release, we could go a bit further and add the
> missing features needed to match the kernel style almost completely. I
> have been trying to allocate some time to start that project in my
> backlog, but... :-)

It is unfortunate that clang format does not have a way for old
versions to parse new .clang-format files.

Perhaps the best course is to get that ability and then go ahead and
bump the min required version to there.. Otherwise this is a never
ending upgrade treadmill.

ie if clang-format would look for a .clang-format.VERSION first and
then try for the generic we could at least have a (somewhat painful)
path.. Or if it would run it through cpp first we could use
#ifdef/etc.

Jason
