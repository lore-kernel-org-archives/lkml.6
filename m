Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A7CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCEE2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="XbMqX20l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCEE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeKCAED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:04:03 -0400
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:28981
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726849AbeKCAEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rld2iaq1NWEpCFF+aedRSI+221uiWVKuw7W+gycP0cw=;
 b=XbMqX20lTJ4h/sW9uvmPF5oRTRmz5ntWjUkSfz5v4pHYQBQVRMJd6ODPOTHqYEP31ZUWGoXNh2L5uK/86cp9kPh6CkyrqfkyNzbYM0YeLysDgL6RGW0eFNnYtZ6c4UmOsISyHaXO8nyeYP1tj1bxCAww6JjKclZQzvd6/QvOrqo=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4987.eurprd04.prod.outlook.com (20.176.234.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 2 Nov 2018 14:56:35 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2849:23b4:7b26:a421]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2849:23b4:7b26:a421%3]) with mapi id 15.20.1294.024; Fri, 2 Nov 2018
 14:56:35 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [PATCH fbdev-for-next 2/2] video: ssd1307fb: Add support for the
 reset-active-low property
Thread-Topic: [PATCH fbdev-for-next 2/2] video: ssd1307fb: Add support for the
 reset-active-low property
Thread-Index: AQHUcrw/3qwIrYVC/Uy4SnGDDmELbw==
Date:   Fri, 2 Nov 2018 14:56:35 +0000
Message-ID: <1541170556-75032-2-git-send-email-michal.vokac@ysoft.com>
References: <1541170556-75032-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1541170556-75032-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0086.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::27) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4987;6:sTQQ+vY576DDcYEIuNDceNHyFgem2YPV49r2J9anE/FoH3bC5W5kwunbtGEocK4z1fn1lhqgzhApJwtNpttSmz9Hwext/8MlLPs+4pU9FNWjgHHhGVLgDpzr7bOHhZ7+ih4e+SQUQ1TBZEFpOrzXoQNwOr9k3X4LDYWgU0uM5CLqcIeMBHVc6kRF24lKsKmFLlXJJR7RkCnB8Zh4vS3nTj/JZXeoTuyss/jLjvwJkqh8gsw/ADCf6Rs39mRYemafhJu4dYfFsS8EA2FCO5demG6I2mbK1tswYv9Cqax1qu8CUyY1+ipJZCx6GjnT3b7Rxeg5yH1Mjs81tA5E2fK6+4hDX/raJsy57kz9UE90V8qtRj7CkmLtZ9FUxkN4NsH3EaZGpW5M+PL1aWE+Zh8jOsDqZhAvWmKEsFvuIcm96PUhnKZghjFaQ+1StVVBRWVpEZ6EF0gnrFYSBK3cR4f5LA==;5:9FMaPu/DiaKqe6zucfRpGdKbw9IIqKnfIf7hYNbdxO2/qN+JnHI0wfLEv07+ffVpIxmX6dgDBSluq92bi7R+p1Ey6qkry2kXNJ9hP5Lx8j8SXK/IlIbFK87/+07Wuqn0GcYkcj3VNNCUTEndv1ZqpWDFYiL5KXAhvvtVyg6ORBg=;7:6arS4jMVUDfQh5TFSqiU3T7osdvKa8fyFUGGot+GtlULo7+bBAu9hN99Mhl0Box0DeKr1EnaQIXREfcdhzdLoEeN1yzlbz6yYuNyCrZsIZaAOhdjxLgTl8JEevDU4EdXbNS2jbNQ9g1mumZLYFsdqg==
x-ms-office365-filtering-correlation-id: 983bd67c-6719-48bd-39b7-08d640d36242
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4987;
x-ms-traffictypediagnostic: DB7PR04MB4987:
x-microsoft-antispam-prvs: <DB7PR04MB4987DACE9EFFB430803B54CB9ECF0@DB7PR04MB4987.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231382)(944501410)(52105095)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4987;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4987;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(366004)(376002)(346002)(396003)(189003)(199004)(6512007)(52116002)(54906003)(110136005)(386003)(53936002)(6116002)(2906002)(3846002)(6506007)(476003)(486006)(76176011)(2900100001)(186003)(8676002)(86362001)(26005)(6436002)(316002)(102836004)(66066001)(99286004)(85182001)(81166006)(81156014)(7736002)(8936002)(305945005)(25786009)(68736007)(36756003)(14454004)(5660300001)(107886003)(6486002)(97736004)(478600001)(446003)(71200400001)(4326008)(11346002)(2616005)(106356001)(105586002)(14444005)(72206003)(256004)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4987;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1UEPURNBqevTvr8sOM8TXyKyT8tEu/xVDJZW6i3DZ4cYdCJqGS2rzbBM7FFlSphTDAnnRSi8+njhg3xX9Q4gYYGHjGk+WYZHjp8THTTFqDbE6VoFFJlaa2AZ9CBp8B+d/Yz/240KPbwCd9zEvum7GLk+rH+xWDqUsvEfdSVE+qF3evdpoWEJhvQDR4V+0MdaJLbKnGO7hNOTlkEMOMOlZwV4lj25f4PVJaf7NqkJwd8dIdask6kGcxeRTxDvHz0jCpAdjc9rwr2NKAeWV2TLiow2oWkA1pKp7Zv/ue/vm+oiFLxFYSJUTRG/cJPT6HlTFA60g/83h7jK+Luask2Kg8KInxj8kg0MieVaWwkpD98=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FF874686236FD4DB68E4A9A103ABD13@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983bd67c-6719-48bd-39b7-08d640d36242
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 14:56:35.2029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4987
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIFNTRDEzMHggT0xFRMKgZGlzcGxheSByZXNldCBzaWduYWwgaXMgYWN0aXZlIGxvdy4gTm93
IHRoZSByZXNldA0Kc2VxdWVuY2UgaXMgaW1wbGVtZW50ZWQgaW4gc3VjaCBhIHdheSB0aGF0IERU
UyBhdXRob3JzIGFyZSBmb3JjZWQgdG8NCmRlZmluZSB0aGUgcmVzZXQtZ3Bpb3MgcHJvcGVydHkg
d2l0aCBHUElPX0FDVElWRV9ISUdIIHRvIG1ha2UgdGhlIHJlc2V0DQp3b3JrLg0KDQpBZGQgdGhl
IHJlc2V0LWFjdGl2ZS1sb3cgcHJvcGVydHkgc28gdGhlIHNpZ25hbCBpcyBpbnZlcnRlZCBvbmNl
IGFnYWluDQphbmQgdGhlIEdQSU9fQUNUSVZFX0xPVyB3b3JrIGFzIGV4cGVjdGVkLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBNaWNoYWwgVm9rw6HEjSA8bWljaGFsLnZva2FjQHlzb2Z0LmNvbT4NCi0tLQ0K
IGRyaXZlcnMvdmlkZW8vZmJkZXYvc3NkMTMwN2ZiLmMgfCA2ICsrKystLQ0KIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZpZGVvL2ZiZGV2L3NzZDEzMDdmYi5jIGIvZHJpdmVycy92aWRlby9mYmRldi9zc2QxMzA3
ZmIuYw0KaW5kZXggZTdhZTEzNS4uNzkwZjFjNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdmlkZW8v
ZmJkZXYvc3NkMTMwN2ZiLmMNCisrKyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvc3NkMTMwN2ZiLmMN
CkBAIC02MDgsNiArNjA4LDcgQEAgc3RhdGljIGludCBzc2QxMzA3ZmJfcHJvYmUoc3RydWN0IGky
Y19jbGllbnQgKmNsaWVudCwNCiAJc3RydWN0IGZiX2RlZmVycmVkX2lvICpzc2QxMzA3ZmJfZGVm
aW87DQogCXUzMiB2bWVtX3NpemU7DQogCXN0cnVjdCBzc2QxMzA3ZmJfcGFyICpwYXI7DQorCWJv
b2wgcmVzZXRfYWN0aXZlX2xvdzsNCiAJdTggKnZtZW07DQogCWludCByZXQ7DQogDQpAQCAtNjcx
LDYgKzY3Miw3IEBAIHN0YXRpYyBpbnQgc3NkMTMwN2ZiX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50
ICpjbGllbnQsDQogCXBhci0+Y29tX3NlcSA9IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChub2RlLCAi
c29sb21vbixjb20tc2VxIik7DQogCXBhci0+Y29tX2xycmVtYXAgPSBvZl9wcm9wZXJ0eV9yZWFk
X2Jvb2wobm9kZSwgInNvbG9tb24sY29tLWxycmVtYXAiKTsNCiAJcGFyLT5jb21faW52ZGlyID0g
b2ZfcHJvcGVydHlfcmVhZF9ib29sKG5vZGUsICJzb2xvbW9uLGNvbS1pbnZkaXIiKTsNCisJcmVz
ZXRfYWN0aXZlX2xvdyA9IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChub2RlLCAicmVzZXQtYWN0aXZl
LWxvdyIpOw0KIA0KIAlwYXItPmNvbnRyYXN0ID0gMTI3Ow0KIAlwYXItPnZjb21oID0gcGFyLT5k
ZXZpY2VfaW5mby0+ZGVmYXVsdF92Y29taDsNCkBAIC03MjgsOSArNzMwLDkgQEAgc3RhdGljIGlu
dCBzc2QxMzA3ZmJfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCiANCiAJaWYgKHBh
ci0+cmVzZXQpIHsNCiAJCS8qIFJlc2V0IHRoZSBzY3JlZW4gKi8NCi0JCWdwaW9kX3NldF92YWx1
ZV9jYW5zbGVlcChwYXItPnJlc2V0LCAwKTsNCisJCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChw
YXItPnJlc2V0LCByZXNldF9hY3RpdmVfbG93KTsNCiAJCXVkZWxheSg0KTsNCi0JCWdwaW9kX3Nl
dF92YWx1ZV9jYW5zbGVlcChwYXItPnJlc2V0LCAxKTsNCisJCWdwaW9kX3NldF92YWx1ZV9jYW5z
bGVlcChwYXItPnJlc2V0LCAhcmVzZXRfYWN0aXZlX2xvdyk7DQogCQl1ZGVsYXkoNCk7DQogCX0N
CiANCi0tIA0KMi4xLjQNCg0K
