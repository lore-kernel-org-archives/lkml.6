Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lDnpNTIOHFu+PQAAmS7hNA
	; Sat, 09 Jun 2018 17:45:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 959B6608BF; Sat,  9 Jun 2018 17:45:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D18C2608BA;
	Sat,  9 Jun 2018 17:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D18C2608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=hotmail.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753482AbeFIRpC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 13:45:02 -0400
Received: from mail-oln040092066016.outbound.protection.outlook.com ([40.92.66.16]:39536
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753342AbeFIRpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 13:45:00 -0400
Received: from VE1EUR01FT004.eop-EUR01.prod.protection.outlook.com
 (10.152.2.56) by VE1EUR01HT145.eop-EUR01.prod.protection.outlook.com
 (10.152.3.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.841.10; Sat, 9
 Jun 2018 17:44:57 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com (10.152.2.55) by
 VE1EUR01FT004.mail.protection.outlook.com (10.152.2.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.841.10 via Frontend Transport; Sat, 9 Jun 2018 17:44:57 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::106:1799:3361:8e9a]) by AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::106:1799:3361:8e9a%2]) with mapi id 15.20.0863.007; Sat, 9 Jun 2018
 17:44:57 +0000
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
To: Russell King <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jinbum Park <jinb.park7@gmail.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add a configure option ARM_ERRATA_WFE_BROKEN
Thread-Topic: [PATCH] Add a configure option ARM_ERRATA_WFE_BROKEN
Thread-Index: AQHUABmUaSZfCRxcPkmP7piZMOvYuw==
Date: Sat, 9 Jun 2018 17:44:57 +0000
Message-ID: <AM5PR0701MB265786ADF69742D6B139378CE47A0@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR04CA0031.eurprd04.prod.outlook.com
 (2603:10a6:206:1::44) To AM5PR0701MB2657.eurprd07.prod.outlook.com
 (2603:10a6:203:75::7)
x-incomingtopheadermarker: OriginalChecksum:330502FEA53BF0E06A6728A23678228885052A5F907449C752F1939B3E0E013E;UpperCasedChecksum:ECFEB48CD71DF1AB60AB96E814E14A90A6E2F42F53393E686BC96363464EF08D;SizeAsReceived:7855;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [6rgHHOIWNvatJQxVWOgjsZxNqbf6UZRE]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VE1EUR01HT145;7:nXI8GTEqHyhlEteb2ffWnCSHGkJZUeM7fGm2e54677pNxCRLKK4xJ3Q9phC1U9pst0WlEQT6Xaz50R2DOP+IKVmm3x5Nw79ZA/PNP/i5xGXOhXv/KYGTCU2YlNlIYthG6FGvFdbdJvbw3emVxHeoqhM31HZuDOukZM18i53M6CTYKeA/UsB0WrDV2dHk1FOr4zAGoPw+fo13NfuL9+C7VSdu4CzfyOlM/s1Jhu3rnfBdPhtcQhwDdHYGVRIOAT2D
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101448)(1601125500)(1701031045);SRVR:VE1EUR01HT145;
x-ms-traffictypediagnostic: VE1EUR01HT145:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(444000031);SRVR:VE1EUR01HT145;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR01HT145;
x-forefront-prvs: 06989017E3
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(189003)(199004)(3660700001)(55016002)(82202002)(6436002)(106356001)(7696005)(104016004)(6306002)(105586002)(33656002)(2900100001)(5660300001)(75402003)(73972006)(110136005)(74316002)(8936002)(14454004)(25786009)(44832011)(2501003)(966005)(99286004)(97736004)(305945005)(8676002)(39060400002)(68736007)(74482002)(9686003)(86362001)(575784001)(6346003)(5250100002)(102836004)(81156014)(2201001)(1857600001)(386003)(6506007)(26005)(476003)(486006)(59450400001)(7416002)(3280700002)(921003)(1121003);DIR:OUT;SFP:1901;SCL:1;SRVR:VE1EUR01HT145;H:AM5PR0701MB2657.eurprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:;
received-spf: None (protection.outlook.com: hotmail.de does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bernd.edlinger@hotmail.de;
x-microsoft-antispam-message-info: SzF1JOKY8ZwlDW3CjnQC/RPDeGsjW7gWi3mEGFa4uw1DKdgSb7hOVXCGDdV6/4wiMo52xsSr3zhYbp3IPL3M3+JNR1aVxXmkkDgxlk+Q6PdAsh2oh/W7wp9Z6uxbryX/qSXl4ejxgvp+keiuP+Gd5TNSwAi07SeANUZ5jkvobzYdQHNuW/kfv1ipceefPY7r
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CC706018F64E646BE23FBBDFD1592F3@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7fb37230-bf55-4406-07b6-08d5ce30b72d
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb37230-bf55-4406-07b6-08d5ce30b72d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2018 17:44:57.5401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyB3b3JrcyBhcm91bmQgcHJvYmxlbXMgd2l0aCBBbHRlcmEgQ3ljbG9uZTUgRGV2aWNlcy4g
U2VlDQpodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTExMTk1MQ0K
DQpJIGp1c3Qgd2FudGVkIHRvIGxldCB5b3Uga25vdyB0aGF0IHdlIHVzZSB0aGlzIHBhdGNoIHNp
bmNlIG1vcmUgdGhhbg0KdHdvIHllYXJzIG5vdyBhbmQgdGhlIHByb2JsZW0gbmV2ZXIgcmVwZWF0
ZWQgZm9yIHVzLg0KDQpUaGVyZSBpcyBvbmUgcG9zc2libHkgcmVsYXRlZCBvYnNlcnZhdGlvbiB3
aXRoDQpDT05GSUdfUEwzMTBfRVJSQVRBXzc2OTQxOSB3aGljaCB3YXMgYWx3YXlzIGVuYWJsZWQs
IGFsdGhvdWdoIGl0DQpzaG91bGQgYmUgdW5uZWNlc3NhcnkgYWNjb3JkaW5nIHRvIHRoZSBjb21t
ZW50IGluDQphcmNoL2FybS9tbS9jYWNoZS1sMngwLmM6DQogICogNzY5NDE5OiBQTDMxMCBSMFAw
LT5SM1AxLCBmaXhlZCBSM1AyLg0KICAqICAgICAgQWZmZWN0czogc3RvcmUgYnVmZmVyDQogICog
ICAgICBzdG9yZSBidWZmZXIgaXMgbm90IGF1dG9tYXRpY2FsbHkgZHJhaW5lZC4NCg0KVGhpcyBl
cnJhdHVtIHNob3VsZCBub3QgYmUgbmVlZGVkIGFzIHdlIHVzZSBSM1AzLCBidXQgd2hlbiB0aGlz
DQp3YXMgZGlzYWJsZWQgYSBraW5kIG9mIGRlYWQtbG9jayBoYXBwZW5lZCBhZnRlciBzb21lIHRp
bWUuDQoNCkl0IG1pZ2h0IGJlIGNvbm5lY3RlZCB0byB0aGlzIHByb2JsZW0gc2luY2UgRVJSQVRB
Xzc2OTQxOSBpbmplY3RzDQphIHdtYiBpbiB0aGUgYXJjaF9jcHVfaWRsZV9lbnRlciB3aGljaCBp
cyBvbmUgb2YgdGhlIGxhc3QgYWN0aW9ucw0KYmVmb3JlIHRoZSB3ZmkgaW5zdHJ1Y3Rpb24gd2hp
Y2ggaGFwcGVucyBpbiB0aGUgaWRsZSBmdW5jdGlvbi4NCg0KU28gdGhlIGN1cnJlbnQgd29ya2lu
ZyB0aGVvcnkgaXMgdGhlIGNhY2hlIG1pZ2h0IGZyZWV6ZSBiZWZvcmUNCmFsbCBkYXRhIGlzIHdy
aXR0ZW4gb3V0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBCZXJuZCBFZGxpbmdlciA8YmVybmQuZWRsaW5n
ZXJAaG90bWFpbC5kZT4NCi0tLQ0KICBhcmNoL2FybS9LY29uZmlnICAgICAgICAgICAgICAgIHwg
NyArKysrKysrDQogIGFyY2gvYXJtL2luY2x1ZGUvYXNtL3NwaW5sb2NrLmggfCA3ICsrKysrKysN
CiAgMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNo
L2FybS9LY29uZmlnIGIvYXJjaC9hcm0vS2NvbmZpZw0KaW5kZXggYTdmOGU3Zi4uZjk2YWYzYiAx
MDA2NDQNCi0tLSBhL2FyY2gvYXJtL0tjb25maWcNCisrKyBiL2FyY2gvYXJtL0tjb25maWcNCkBA
IC0xMjE1LDYgKzEyMTUsMTMgQEAgY29uZmlnIEFSTV9FUlJBVEFfODUyNDIzDQogIAkgIGNvbmZp
ZyBvcHRpb24gZnJvbSB0aGUgQTEyIGVycmF0dW0gZHVlIHRvIHRoZSB3YXkgZXJyYXRhIGFyZSBj
aGVja2VkDQogIAkgIGZvciBhbmQgaGFuZGxlZC4NCg0KK2NvbmZpZyBBUk1fRVJSQVRBX1dGRV9C
Uk9LRU4NCisJYm9vbCAiQVJNIGVycmF0YTogd2ZlIGJyb2tlbiINCisJZGVwZW5kcyBvbiBDUFVf
VjcgJiYgU01QDQorCWhlbHANCisJICBUaGlzIG9wdGlvbiBkaXNhYmxlcyB0aGUgd2ZlIGluc3Ry
dWN0aW9uIGZvciByYXdfc3Bpbl9sb2Nrcy4NCisJICBBdCBsZWFzdCBzb21lIEN5Y2xvbmVWIFNv
QyBkZXZpY2VzIHdhaXQgbXVjaCB0b28gbG9uZyBpbiB3ZmUuDQorDQogIGVuZG1lbnUNCg0KICBz
b3VyY2UgImFyY2gvYXJtL2NvbW1vbi9LY29uZmlnIg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2lu
Y2x1ZGUvYXNtL3NwaW5sb2NrLmggDQpiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL3NwaW5sb2NrLmgN
CmluZGV4IDA5OWM3OGYuLjdlZmM0MzEgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9pbmNsdWRlL2Fz
bS9zcGlubG9jay5oDQorKysgYi9hcmNoL2FybS9pbmNsdWRlL2FzbS9zcGlubG9jay5oDQpAQCAt
MTAsNiArMTAsMTIgQEANCiAgI2luY2x1ZGUgPGFzbS9iYXJyaWVyLmg+DQogICNpbmNsdWRlIDxh
c20vcHJvY2Vzc29yLmg+DQoNCisjaWZkZWYgQ09ORklHX0FSTV9FUlJBVEFfV0ZFX0JST0tFTg0K
KyN1bmRlZiB3ZmUNCisjZGVmaW5lIHdmZSgpDQorI2RlZmluZSBXRkUoeCkNCisjZGVmaW5lIGRz
Yl9zZXYoKQ0KKyNlbHNlDQogIC8qDQogICAqIHNldiBhbmQgd2ZlIGFyZSBBUk12NksgZXh0ZW5z
aW9ucy4gIFVuaXByb2Nlc3NvciBBUk12NiBtYXkgbm90IGhhdmUgDQp0aGUgSw0KICAgKiBleHRl
bnNpb25zLCBzbyB3aGVuIHJ1bm5pbmcgb24gVVAsIHdlIGhhdmUgdG8gcGF0Y2ggdGhlc2UgDQpp
bnN0cnVjdGlvbnMgYXdheS4NCkBAIC00NCw2ICs1MCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBk
c2Jfc2V2KHZvaWQpDQogIAlkc2IoaXNoc3QpOw0KICAJX19hc21fXyhTRVYpOw0KICB9DQorI2Vu
ZGlmDQoNCiAgLyoNCiAgICogQVJNdjYgdGlja2V0LWJhc2VkIHNwaW4tbG9ja2luZy4NCi0tIA0K
Mi43LjQNCg==
