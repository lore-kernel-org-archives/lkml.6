Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5FDC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF94221726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="YwHSGPoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfAWM3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:29:19 -0500
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:39136
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727105AbfAWM3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LjDc4JCmcwSfquiNfBqJ0iuxOUaU8zD6R41tnX0fH0=;
 b=YwHSGPoCFr5gCz+BhS0HU1k9YNAhukT4NObE6XxC0jI+jp3PcQdSasgFK9EAdlC9Et/+Y/Hpu5A4Yhvu8ioJlqxvlToqcTxH4SAMma948j0EJI5AruaWdtTXqYI58w+SozOtSgPufga0HAengSSnBv0+ex/4F22Q8v+HHOxk6Pk=
Received: from HE1PR05MB3257.eurprd05.prod.outlook.com (10.170.243.19) by
 HE1PR05MB3484.eurprd05.prod.outlook.com (10.170.244.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Wed, 23 Jan 2019 12:29:13 +0000
Received: from HE1PR05MB3257.eurprd05.prod.outlook.com
 ([fe80::6442:f114:69b6:e8be]) by HE1PR05MB3257.eurprd05.prod.outlook.com
 ([fe80::6442:f114:69b6:e8be%3]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 12:29:13 +0000
From:   Tariq Toukan <tariqt@mellanox.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net/mlx4: Mark expected switch fall-through
Thread-Topic: [PATCH net-next] net/mlx4: Mark expected switch fall-through
Thread-Index: AQHUsvKMXov6xCBEAkSqlPWQSZkpsqW8yJSA
Date:   Wed, 23 Jan 2019 12:29:13 +0000
Message-ID: <1598bfeb-0061-1d52-6b10-a3740ee25f46@mellanox.com>
References: <20190123080511.GA32528@embeddedor>
In-Reply-To: <20190123080511.GA32528@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR03CA0003.eurprd03.prod.outlook.com (2603:10a6:20b::16)
 To HE1PR05MB3257.eurprd05.prod.outlook.com (2603:10a6:7:35::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.124.63.215]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR05MB3484;6:cABhdeCcEInay6Nw5C5/kGHst75Rfm6pevDi0OItSax8QQpoZSa2Zk1QbXVa5HBKBchuew2pwTz5K3tOINu3XzxEwoIq1yHD3YSZyJeNITx0VBnmJei9S4+pYl0Gzym2Iw1I4frLDt8ooIr8pcRMb01VluybkP8lRhzLUrNbacEUwC5+2rq4KON3lZZeSbPj4IPGcat5PllLEiidxr6YfMcsbT2aMnGpSvCkVxRC0q0JHLAl1sxMktyumZ4RU39svAoo5/RtvJdZnrVmsbJzQfm/wTTbc2kKIoGIMrl8kLxtKV8RvRxKxurwz567LnXjSkHx+7j6pcyH/vJTEMpqYmK/NTNoyVe/HTLMo3QfmPIxu3TK4/ST9h10/wMaVjVTOwcL9OutDp79SbNA3cWkFRgcyp1Qa4Ij6bm2XeMUUB7yZPjjdep9o8kGU4cEanWTDaYxV4Ix0pLeh142ZTE6mA==;5:9KU2i5w5jCOXBAqB7VC2AfDbbR1fk3dHMg6V+Kg5omXxk4LNt5Kl/lXRVuyt+D4wFkp8+GhllUauC9rNQZDIwGvcwo7Jn21llEoEzAr6BvF2ZYLlo8wK5NO7tj+UZjFsKoZSClONs+V8nCNFHMs1smRNNClKf7EgVBM1yj2MFedjCuGyIzWvM3l3duMZBXsSQVfuhAzCuONSflS95h6NDg==;7:eTSd6gZK8A9yvmPr+Fgf7gkiNOFrkLLCa+XO5Rc9+J1jaoEeUw6dGFTMNMgy7vdIXYL1bkjp0dbPFP0OnqwVvngYoIrllJLGEyPgmD6chxroegzx1p5TJ5nrM79HCQh4Ek6PZrWPshd6VlhSKOEzrQ==
x-ms-office365-filtering-correlation-id: d68d9698-679d-4238-25fa-08d6812e61f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3484;
x-ms-traffictypediagnostic: HE1PR05MB3484:
x-microsoft-antispam-prvs: <HE1PR05MB3484AB86956F0C20519037DBAE990@HE1PR05MB3484.eurprd05.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(486006)(186003)(8936002)(81156014)(25786009)(6436002)(8676002)(476003)(99286004)(31696002)(14454004)(105586002)(81166006)(106356001)(6246003)(31686004)(53936002)(6486002)(36756003)(229853002)(2616005)(11346002)(446003)(4326008)(66066001)(71200400001)(71190400001)(6506007)(386003)(3846002)(6116002)(316002)(54906003)(53546011)(102836004)(26005)(76176011)(7736002)(305945005)(2906002)(68736007)(14444005)(478600001)(256004)(86362001)(97736004)(6512007)(52116002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3484;H:HE1PR05MB3257.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5i2TgoYHuyWtjhoE5ufjt2xPK70fACAUrirk2HmELu/7dLYq5khOYNNnpi450t0ecui6NT4lykddMwVYbQOTXgpyz6DND0TW/8OfukLPxqQXAK0h2N2ykJioK+U5pYYcBx5rcBa7soRN6Y+ILbkum0sNM9BLqO2wH4lWNIUe0c2gU5rgO3OhGD6A4kME5FIMzE0QDjH+gYtiwPGe9d76lk1bnFHV1NqP8WCm+fk7cipOHkeHQRkwEgvqQOs3syTLTANL+POM15y0a7BcYZ7eMh/PLxl5qmYiAJRpxozsD58n/T2NwJrtwximAE48ceiv1vBvY6ISxmmVr44x0PpTFi4nztMb0bh0IgAzj3pVsuvc9TwUmFdLXbi/jJ7BvM72bEryA/4Hf7dwzqSUu5+A8oUnubkgt/RgLxXIfbGXrUU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF27542629F5864D91EF9F3C2D9E1F1C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68d9698-679d-4238-25fa-08d6812e61f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 12:29:12.1336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3484
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEvMjMvMjAxOSAxMDowNSBBTSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCj4g
SW4gcHJlcGFyYXRpb24gdG8gZW5hYmxpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCwgbWFyayBz
d2l0Y2ggY2FzZXMNCj4gd2hlcmUgd2UgYXJlIGV4cGVjdGluZyB0byBmYWxsIHRocm91Z2guDQo+
IA0KPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBmb2xsb3dpbmcgd2FybmluZzoNCj4gDQo+IGRyaXZl
cnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDQvZXEuYzogSW4gZnVuY3Rpb24g4oCYbWx4NF9l
cV9pbnTigJk6DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDQvbWx4NC5oOjIx
OTo1OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0
LWZhbGx0aHJvdWdoPV0NCj4gICAgaWYgKG1seDRfZGVidWdfbGV2ZWwpICAgICAgXA0KPiAgICAg
ICBeDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDQvZXEuYzo1NTg6NDogbm90
ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmG1seDRfZGJn4oCZDQo+ICAgICAgbWx4NF9kYmco
ZGV2LCAiJXM6IE1MWDRfRVZFTlRfVFlQRV9TUlFfTElNSVQuIHNycV9ubz0weCV4LCBlcSAweCV4
XG4iLA0KPiAgICAgIF5+fn5+fn5+DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21s
eDQvZXEuYzo1NjE6Mzogbm90ZTogaGVyZQ0KPiAgICAgY2FzZSBNTFg0X0VWRU5UX1RZUEVfU1JR
X0NBVEFTX0VSUk9SOg0KPiAgICAgXn5+fg0KPiANCj4gV2FybmluZyBsZXZlbCAzIHdhcyB1c2Vk
OiAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTMNCj4gDQo+IFRoaXMgcGF0Y2ggaXMgcGFydCBvZiB0
aGUgb25nb2luZyBlZmZvcnRzIHRvIGVuYWJsaW5nDQo+IC1XaW1wbGljaXQtZmFsbHRocm91Z2gu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVk
ZGVkb3IuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0
L2VxLmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0L2VxLmMgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0L2VxLmMNCj4gaW5kZXggNDk1M2M4NTJjMjQ3
Li4yZjQyMDEwMjM4MzYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxh
bm94L21seDQvZXEuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0
L2VxLmMNCj4gQEAgLTU1OCw2ICs1NTgsNyBAQCBzdGF0aWMgaW50IG1seDRfZXFfaW50KHN0cnVj
dCBtbHg0X2RldiAqZGV2LCBzdHJ1Y3QgbWx4NF9lcSAqZXEpDQo+ICAgCQkJbWx4NF9kYmcoZGV2
LCAiJXM6IE1MWDRfRVZFTlRfVFlQRV9TUlFfTElNSVQuIHNycV9ubz0weCV4LCBlcSAweCV4XG4i
LA0KPiAgIAkJCQkgX19mdW5jX18sIGJlMzJfdG9fY3B1KGVxZS0+ZXZlbnQuc3JxLnNycW4pLA0K
PiAgIAkJCQkgZXEtPmVxbik7DQo+ICsJCQkvKiBmYWxsIHRocm91Z2ggKi8NCj4gICAJCWNhc2Ug
TUxYNF9FVkVOVF9UWVBFX1NSUV9DQVRBU19FUlJPUjoNCj4gICAJCQlpZiAobWx4NF9pc19tYXN0
ZXIoZGV2KSkgew0KPiAgIAkJCQkvKiBmb3J3YXJkIG9ubHkgdG8gc2xhdmUgb3duaW5nIHRoZSBT
UlEgKi8NCj4gDQoNCg0KUmV2aWV3ZWQtYnk6IFRhcmlxIFRvdWthbiA8dGFyaXF0QG1lbGxhbm94
LmNvbT4NClRoYW5rcyBmb3IgeW91ciBwYXRjaC4NCg==
