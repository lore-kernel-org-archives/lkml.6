Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8522C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 09:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4FC2086E
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 09:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4FC2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hotmail.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932545AbeGHJ52 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 05:57:28 -0400
Received: from mail-oln040092069044.outbound.protection.outlook.com ([40.92.69.44]:38483
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753952AbeGHJ50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 05:57:26 -0400
Received: from HE1EUR02FT032.eop-EUR02.prod.protection.outlook.com
 (10.152.10.58) by HE1EUR02HT153.eop-EUR02.prod.protection.outlook.com
 (10.152.11.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.20.930.16; Sun, 8
 Jul 2018 09:57:23 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com (10.152.10.55) by
 HE1EUR02FT032.mail.protection.outlook.com (10.152.10.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.930.16 via Frontend Transport; Sun, 8 Jul 2018 09:57:23 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::b1fe:1b4f:88c3:5243]) by AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::b1fe:1b4f:88c3:5243%7]) with mapi id 15.20.0952.013; Sun, 8 Jul 2018
 09:57:23 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add a missing break in parse_station_flags
Thread-Topic: [PATCH] Add a missing break in parse_station_flags
Thread-Index: AQHUFqIR6lIzyDCKGUCOieYfX7oQqQ==
Date:   Sun, 8 Jul 2018 09:57:22 +0000
Message-ID: <AM5PR0701MB265751E3A716081292C5224FE4450@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0165.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::33) To AM5PR0701MB2657.eurprd07.prod.outlook.com
 (2603:10a6:203:75::7)
x-incomingtopheadermarker: OriginalChecksum:7957AAB8A38B2A4132689E7CE1B81F513BA6757C4FC7801138BC76323CAD6AF2;UpperCasedChecksum:FB361BDA253CAC81E2963C398400F629D504E417FF822607AE0E1D89CAAE2A74;SizeAsReceived:7538;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [k6qkRq5BA9pgfDEddE9/7nQU9KUplzzr]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1EUR02HT153;7:uAyCLY7sxVlTBP9MRxL3ixmx7YVCpy9IjSQOy8psAe8aVgA8eWyUJiavAyHYU6GmAtxhzbZe6uXDXkw+MTD58W6sE5FJykHSHNs55HlTp0F+I/0ulb9alRC9IsdD6makeqdK5ezbGilc1LfdfXfcvNG2okvQlDirVFiqo89ynwS0tKw4AhbqUetlFU34nkjd1Zepyvo9kHSRj9v3EWfGUdbxgHQAhZd752WemE4Lh9JeMvfCuf69yBt5YQtrJGRo
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101448)(1701031045);SRVR:HE1EUR02HT153;
x-ms-traffictypediagnostic: HE1EUR02HT153:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(82015058);SRVR:HE1EUR02HT153;BCL:0;PCL:0;RULEID:;SRVR:HE1EUR02HT153;
x-forefront-prvs: 0727122FC6
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(189003)(199004)(97736004)(104016004)(74316002)(14454004)(33656002)(305945005)(25786009)(5250100002)(2501003)(73972006)(75402003)(106356001)(44832011)(105586002)(81156014)(8936002)(74482002)(2900100001)(8676002)(486006)(7696005)(86362001)(386003)(6506007)(55016002)(6436002)(26005)(1857600001)(102836004)(6346003)(5660300001)(9686003)(110136005)(82202002)(2201001)(99286004)(68736007)(14444005)(476003)(256004);DIR:OUT;SFP:1901;SCL:1;SRVR:HE1EUR02HT153;H:AM5PR0701MB2657.eurprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:;
received-spf: None (protection.outlook.com: hotmail.de does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bernd.edlinger@hotmail.de; 
x-microsoft-antispam-message-info: fleZy/OX1tLB7uTWsn9i0gMopCpYh7iJGdJMoIP90iU8kAj6Bm80hX6BPK8F30d1GKFYNFUfu/kQCTOvM0eEQqDY8gjfWEHqJHhzdoijBoJbFdfHz4LGhwHkNi5rB6WJelvL1QqeYHlchnLhgOXbK1tw5Qt/2+6eeTyALqZnGtaN8MBWs2HEIwWt1d8pjV+EGbV0KvDR8oa3XpRgqs9Bz1b6Vb6Q1uGZ/qO/WhZstFE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F3AB3A58BC9AE408FE0239353463F2C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 9191f344-d90d-4a85-587e-08d5e4b9334e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2018 09:57:23.1148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR02HT153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSB3YXMgbG9va2luZyBhdCB1c3VhbGx5IHN1cHByZXNzZWQgZ2NjIHdhcm5pbmdzLA0KWy1XaW1w
bGljaXQtZmFsbHRocm91Z2g9XSBpbiB0aGlzIGNhc2U6DQoNClRoZSBjb2RlIGRlZmluaXRlbHkg
bG9va3MgbGlrZSBhIGJyZWFrIGlzIG1pc3NpbmcgaGVyZS4NCkhvd2V2ZXIgSSBhbSBub3QgYWJs
ZSB0byB0ZXN0IHRoZSBOTDgwMjExX0lGVFlQRV9NRVNIX1BPSU5ULA0Kbm9yIGRvIEkgYWN0dWFs
bHkga25vdyB3aGF0IG1pZ2h0IGJlIDopDQpTbyBwbGVhc2UgdXNlIHRoaXMgcGF0Y2ggd2l0aCBj
YXV0aW9uIGFuZCBvbmx5IGlmIHlvdSBhcmUNCmFibGUgdG8gZG8gc29tZSB0ZXN0aW5nLg0KDQpT
aWduZWQtb2ZmLWJ5OiBCZXJuZCBFZGxpbmdlciA8YmVybmQuZWRsaW5nZXJAaG90bWFpbC5kZT4N
Ci0tLQ0KICBuZXQvd2lyZWxlc3Mvbmw4MDIxMS5jIHwgMSArDQogIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvbmV0L3dpcmVsZXNzL25sODAyMTEuYyBiL25l
dC93aXJlbGVzcy9ubDgwMjExLmMNCmluZGV4IDRlZWNlMDYuLjY1MzdiNWQgMTAwNjQ0DQotLS0g
YS9uZXQvd2lyZWxlc3Mvbmw4MDIxMS5jDQorKysgYi9uZXQvd2lyZWxlc3Mvbmw4MDIxMS5jDQpA
QCAtNDQwOSw2ICs0NDA5LDcgQEAgc3RhdGljIGludCBwYXJzZV9zdGF0aW9uX2ZsYWdzKHN0cnVj
dCBnZW5sX2luZm8gKmluZm8sDQogIAkJcGFyYW1zLT5zdGFfZmxhZ3NfbWFzayA9IEJJVChOTDgw
MjExX1NUQV9GTEFHX0FVVEhFTlRJQ0FURUQpIHwNCiAgCQkJCQkgQklUKE5MODAyMTFfU1RBX0ZM
QUdfTUZQKSB8DQogIAkJCQkJIEJJVChOTDgwMjExX1NUQV9GTEFHX0FVVEhPUklaRUQpOw0KKwkJ
YnJlYWs7DQogIAlkZWZhdWx0Og0KICAJCXJldHVybiAtRUlOVkFMOw0KICAJfQ0KLS0gDQoxLjku
MQ0K
