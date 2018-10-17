Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E96ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7186B214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Ao0pHBa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7186B214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeJQSqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:46:44 -0400
Received: from mail-eopbgr10113.outbound.protection.outlook.com ([40.107.1.113]:6497
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726868AbeJQSqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/UvljF0UFCwep0DJIRQLiB2dovnOtyRQPsLjR/kk4I=;
 b=Ao0pHBa3fT9p3WZ0O06t0tGLyEALWKal5fdRqdPH0abUlbOUwzWR7nKUzfVtIENOfXhxG2270rmB0msQUkjg1BdbHaLSHAv8+niv60m9pzNfKinW8taq3lJdcx61/h9xB+prtELtzfG+BTWNOrX6u8HImtKMZRs6KBczvvGlMuQ=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2574.eurprd05.prod.outlook.com (10.168.137.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Wed, 17 Oct 2018 10:51:30 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa%3]) with mapi id 15.20.1228.032; Wed, 17 Oct 2018
 10:51:30 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] ARM: dts: tegra: last minute fixes
Thread-Topic: [PATCH v2 0/9] ARM: dts: tegra: last minute fixes
Thread-Index: AQHUZT23D2xEra+FPkWbX0WDmDqGEKUhxLoAgAF/gAA=
Date:   Wed, 17 Oct 2018 10:51:30 +0000
Message-ID: <1539773488.6233.22.camel@toradex.com>
References: <20181016104730.4598-1-marcel@ziswiler.com>
         <20181016115852.GE7449@sirena.org.uk>
In-Reply-To: <20181016115852.GE7449@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2574;6:XiJj57zj7Jb57ZVBv1qloDX3b4cC+XCauFSD/ZlOYBCUrBxMeKlv/spq/BCmSaIsV1WbDgSSfy98STuj8K7q7m6WxotX6naXp7piLyYFGSBoHXQG+rB6GzDiT5nd/1ZEbQSDEzB8ihdMY0FgZnO4+62D7U6pG06iUOaPScdRi5ch047cJAG17y2ezFsM4Yj+X+gtX0sLT9bsBNBKrHn1wF5INipmWKLI7pKS1DAZgWfbDNNqvO+62PDAq7duFZlByl80N7gkJK4xKbxU1W047RJ5iYc4c0nRQiyvnaYoZSxizueM0AuIalAjalnmAuHEfu53FVDfsEHgWJMBTrKbHiTZjtpHjI5b8nkvnEoysqqC2iS/0WcspTxHo73ufKWAy2EgqqKcBXGLtpXqggqa7rjO5pOhVVyhNFDX3Z4r0yox9S7MaMykXa87G+kx+q0bNy3TzN4DYHsWysRTVuJoHg==;5:5AQgyxiPByff2QC1HCDLJgkFb8BjMubj5vJAZxqsuzZWmsMWn2faUYUf0wY6pCmCGVr+DSGSkJzVdZGYp+J6pdAiUtfFok24yYdtXthRuqqB7n7d40bKPO/yg3FkTcLU23boynSDTUZCyffBXjNl4upvXaChp+acixZCseZMqQU=;7:LUgtyRmu9QfFJUlx0sQn1kCgN1AqlqKvV7ghuVjJ10+G7anycZz0gmCZ88yRE2F1Eak4LPkYdjqswY91XSIa4Lu8GdNbW+t141uJnaKNR2jawmZYmk7C9GMwxTAvuc5IvoUhH2i6xXQnk0ZIfyz+hKrBQhydTfVQmNNdjru1lETLUrK2iWzKFYfhqB9L096M5+rLwLKC4DC3t/z1iUf7bSw/3bmuLLWrq3oJ+HDGaa+gEI6S/SxhAOIoZvMXOMpb
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 91e9e709-ef2c-4c1c-1f4b-08d6341e7f2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2574;
x-ms-traffictypediagnostic: VI1PR0501MB2574:
x-microsoft-antispam-prvs: <VI1PR0501MB25741A191C01242E7861D99CFBFF0@VI1PR0501MB2574.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0501MB2574;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2574;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(346002)(136003)(376002)(396003)(366004)(199004)(189003)(6436002)(54906003)(229853002)(105586002)(6916009)(2351001)(106356001)(6486002)(6506007)(76176011)(99286004)(3846002)(256004)(102836004)(36756003)(71190400001)(14454004)(8936002)(81156014)(478600001)(71200400001)(316002)(6116002)(81166006)(1730700003)(2906002)(68736007)(11346002)(446003)(2501003)(2616005)(476003)(103116003)(97736004)(5250100002)(7416002)(5660300001)(486006)(86362001)(44832011)(305945005)(4326008)(25786009)(66066001)(7736002)(39060400002)(6246003)(26005)(5640700003)(53936002)(186003)(6512007)(2900100001)(8676002)(4001150100001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2574;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Tf4+kpB+LW/RCnfga6ALIart2+A1NHBy0zg0QfjbIf1NoWWIOlDpn+g6PIf856lOabAzJf6486It92uH+i04A7TMz5AxNRZWdmWUtGwYTM3x3P5xa5rwZK6SDGlnD1VxQGj0mRAjzXnbf2iZsvgayf0mokMHzF3TR6xmz3qTs8+Y1e2TM9X01Dz5+PdUDzYHm4FYEkt7omNhitO8gyAD5Uz8tZqu3gN7tLDbuFvmFe4l3M+S4QpuJj/kYBtykpgj4clerS1soXPjl7JNK0+skMEgrtoAT59tyVH9XMjM5OxEkgCGnSSGZJG+sfMvnXEj/4TikZ1y9pOUuJlDT45+Vsxh8wnTU9gVsCoyzQVMMbQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EF134A37DAD084B910FC81E187F1986@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e9e709-ef2c-4c1c-1f4b-08d6341e7f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 10:51:30.5448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTEwLTE2IGF0IDEyOjU4ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUdWUsIE9jdCAxNiwgMjAxOCBhdCAxMjo0NzoyMVBNICswMjAwLCBNYXJjZWwgWmlzd2lsZXIg
d3JvdGU6DQo+IA0KPiA+IE1hcmNlbCBaaXN3aWxlciAoOSk6DQo+ID4gICBBUk06IHRlZ3JhOiBm
aXggc2ltcGxlLXBhbmVsIGNvbXBhdGlibGVzDQo+ID4gICBBUk06IHRlZ3JhOiBhcGFsaXMtdGsx
L2NvbGlicmlfdDIwL3QzMDogZXZhbC9pcmlzOiBmaXggcmVndWxhdG9yDQo+ID4gZ3Bpbw0KPiA+
ICAgICBlbmFibGUNCj4gPiAgIEFSTTogdGVncmE6IGNvbGlicmlfdDIwOiByZW9yZGVyIHBtaWMg
cHJvcGVydGllcw0KPiA+ICAgQVJNOiB0ZWdyYTogYXBhbGlzLXRrMTogZnVydGhlciByZWd1bGF0
b3IgY2xlYW4tdXANCj4gPiAgIEFSTTogdGVncmE6IGFwYWxpc190MzAvdGsxOiBhbm5vdGF0ZSBw
b3dlciBJMkMgYmVpbmcgb24tbW9kdWxlDQo+ID4gICBBUk06IHRlZ3JhOiBjb2xpYnJpX3QzMDog
ZnVydGhlciByZWd1bGF0b3IgY2xlYW4tdXANCj4gPiAgIEFSTTogdGVncmE6IGFwYWxpc190MzA6
IGZ1cnRoZXIgcmVndWxhdG9yIGNsZWFuLXVwDQo+ID4gICBBU29DOiB0ZWdyYV9zZ3RsNTAwMDog
Zml4IGRldmljZV9ub2RlIHJlZmNvdW50aW5nDQo+ID4gICBBU29DOiB0ZWdyYV9zZ3RsNTAwMDog
Zml4IHBsYXRmb3JtIG5hbWUgdnMuIG9mX25vZGUgYXNzaWduZW1lbnQNCj4gDQo+IFRoZXNlIEFT
b0MgcGF0Y2hlcyBhcHBlYXIgdG8gaGF2ZSBhYnNvbHV0ZWx5IG5vIHJlbGF0aW9uc2hpcCB3aXRo
IHRoZQ0KPiByZXN0IG9mIHRoZSBzZXJpZXMuICBJcyB0aGF0IHRoZSBjYXNlIG9yIGlzIHRoZXJl
IHNvbWUgZGVwZW5kZW5jeSBJJ20NCj4gbWlzc2luZz8NCg0KTm90IG91dHNpZGUgb2YgYWxsIGJl
aW5nIFRlZ3JhIHNwZWNpZmljIHN0dWZmLCBuby4gSWYgeW91IHByZWZlciBJIG1heQ0Kc2VuZCB0
aGVtIGFzIGEgc2VwYXJhdGUgc2VyaWVzLg==
