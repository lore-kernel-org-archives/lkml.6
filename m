Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483BCC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 08:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7918208A6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 08:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7918208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hotmail.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932436AbeGHIJG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 04:09:06 -0400
Received: from mail-oln040092069039.outbound.protection.outlook.com ([40.92.69.39]:30533
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752901AbeGHIJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 04:09:04 -0400
Received: from VE1EUR02FT026.eop-EUR02.prod.protection.outlook.com
 (10.152.12.52) by VE1EUR02HT121.eop-EUR02.prod.protection.outlook.com
 (10.152.13.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.20.906.15; Sun, 8
 Jul 2018 08:09:01 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com (10.152.12.51) by
 VE1EUR02FT026.mail.protection.outlook.com (10.152.12.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.930.16 via Frontend Transport; Sun, 8 Jul 2018 08:09:01 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::b1fe:1b4f:88c3:5243]) by AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::b1fe:1b4f:88c3:5243%7]) with mapi id 15.20.0952.008; Sun, 8 Jul 2018
 08:09:01 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the oldconfig target rule
Thread-Topic: [PATCH] Fix the oldconfig target rule
Thread-Index: AQHUFoVN4VKe8QEqTUu43IsWDRn/EqSE+MyA
Date:   Sun, 8 Jul 2018 08:09:01 +0000
Message-ID: <AM5PR0701MB265789020943AD2E03E81AD2E4450@AM5PR0701MB2657.eurprd07.prod.outlook.com>
References: <AM5PR0701MB2657B3C36CDB2D67702077D8E4450@AM5PR0701MB2657.eurprd07.prod.outlook.com>
In-Reply-To: <AM5PR0701MB2657B3C36CDB2D67702077D8E4450@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0157.eurprd06.prod.outlook.com
 (2603:10a6:7:16::44) To AM5PR0701MB2657.eurprd07.prod.outlook.com
 (2603:10a6:203:75::7)
x-incomingtopheadermarker: OriginalChecksum:56A3300B93BB77A4A5BE19272031048081574C7D8F6CC45BB0FBC8C114650469;UpperCasedChecksum:ED6F595061B0C2940AD84082F3BBAB123DE4250125D9079634A1E41077DA0212;SizeAsReceived:7603;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Eyw29mETidyFLa8rS5tO6Zr5ti2dNO2k]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VE1EUR02HT121;7:in/3Z1TmneUnU/dc9AboKKPJ1ZATI4fKOFDE07gVzZO/LRvV+iCtthhHtVf5n/6G0YTrTFRe7/CHLyi37gblLwMm7twrztfNF3EXHqAtQ/juOSIkZA7f790TtPihRDGa005dstW8gXgi65QA9IPbxhg4Q4UkffgrJWLuIM3KIhGY/f78M8+8BqUdxpveDeeQ0L4Pitht3m2gisEmNJhvosZzXELaP+jYRtx+H4vZDgvCWQGc5afRMPzbX6NihlwI
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101448)(1701031045);SRVR:VE1EUR02HT121;
x-ms-traffictypediagnostic: VE1EUR02HT121:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(82015058);SRVR:VE1EUR02HT121;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR02HT121;
x-forefront-prvs: 0727122FC6
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(979002)(199004)(189003)(7696005)(14444005)(6346003)(11346002)(102836004)(110136005)(2201001)(76176011)(9686003)(6506007)(386003)(25786009)(446003)(81156014)(6246003)(8936002)(104016004)(53546011)(476003)(486006)(2900100001)(86362001)(26005)(97736004)(44832011)(106356001)(2940100002)(105586002)(74316002)(305945005)(6436002)(99286004)(82202002)(55016002)(74482002)(73972006)(75402003)(8676002)(68736007)(33656002)(5250100002)(256004)(229853002)(5660300001)(2501003)(14454004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1901;SCL:1;SRVR:VE1EUR02HT121;H:AM5PR0701MB2657.eurprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:;
received-spf: None (protection.outlook.com: hotmail.de does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bernd.edlinger@hotmail.de; 
x-microsoft-antispam-message-info: dbKOdGcEY/JidIsgHaZMbAGFc2Y18qzJRwTCuBPlThQr8p5SNtKLWU/ATKIU1BfSiCCUERZu9jIWci+PHEHFydvRtaPBnu7I1C2sKi49kSsbCVQidU1WyBHepJyvWCe/EVn5OMXWKrvc3Nt9kco+Vfk2iQgJNjqBBarxKcXKYP+iunUeAspC5N9nRm5kcxwRftfeSA2KuQLvg3tdEM/aX1tvLIMKLz5i1+16yC3Gog0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA5D4214F98ED2439D46822A041300BD@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 96675e3f-9926-43f6-d432-08d5e4aa0fe2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2018 08:09:01.3327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDgvMTggMDg6MzEsIEJlcm5kIEVkbGluZ2VyIHdyb3RlOg0KPiBUaGUgbmV4dCBtYWtl
IGFmdGVyIGFuIG9sZGNvbmZpZyByZWFkcyBpbiB0aGUgb3V0ZGF0ZWQNCj4gaW5jbHVkZS9jb25m
aWcvYXV0by5jb25mIHdoaWNoIGNhbiBraWxsIHRoZSBtYWtlIGJlZm9yZQ0KPiBpdCBpcyBhYmxl
IHRvIGNhbGwgdGhlIHN5bmNjb25maWcgdGFyZ2V0Lg0KPiANCj4gJCBtYWtlIGRlZmNvbmZpZw0K
PiAqKiogRGVmYXVsdCBjb25maWd1cmF0aW9uIGlzIGJhc2VkIG9uICd4ODZfNjRfZGVmY29uZmln
Jw0KPiAkIG1ha2UNCj4gc2NyaXB0cy9rY29uZmlnL2NvbmbCoCAtLXN5bmNjb25maWcgS2NvbmZp
Zw0KPiBNYWtlZmlsZTo5MzY6ICoqKiAiQ2Fubm90IGdlbmVyYXRlIE9SQyBtZXRhZGF0YSBmb3Ig
Q09ORklHX1VOV0lOREVSX09SQz15LA0KPiBwbGVhc2UgaW5zdGFsbCBsaWJlbGYtZGV2LCBsaWJl
bGYtZGV2ZWwgb3IgZWxmdXRpbHMtbGliZWxmLWRldmVsIi7CoCBTdG9wLg0KPiANCj4gJCBzZWQg
LWkgcy9DT05GSUdfVU5XSU5ERVJfT1JDPXkvLyAuY29uZmlncw0KPiAkIG1ha2Ugb2xkY29uZmln
DQo+IENob29zZSBrZXJuZWwgdW53aW5kZXINCj4+IDEuIE9SQyB1bndpbmRlciAoVU5XSU5ERVJf
T1JDKSAoTkVXKQ0KPiAgwqAgMi4gRnJhbWUgcG9pbnRlciB1bndpbmRlciAoVU5XSU5ERVJfRlJB
TUVfUE9JTlRFUikNCj4gY2hvaWNlWzEtMj9dOiAyDQo+ICQgbWFrZQ0KPiBNYWtlZmlsZTo5MzY6
ICoqKiAiQ2Fubm90IGdlbmVyYXRlIE9SQyBtZXRhZGF0YSBmb3IgQ09ORklHX1VOV0lOREVSX09S
Qz15LA0KPiBwbGVhc2UgaW5zdGFsbCBsaWJlbGYtZGV2LCBsaWJlbGYtZGV2ZWwgb3IgZWxmdXRp
bHMtbGliZWxmLWRldmVsIi7CoCBTdG9wLg0KPiANCj4gV2l0aCB0aGlzIHBhdGNoIG9sZGNvbmZp
ZyBhbmQgc2ltaWxhciB0YXJnZXRzIGxpa2UNCj4gbWVudWNvbmZpZyBjYWxsIHN5bmNjb25maWcg
dG8gYXZvaWQgdGhpcyBmYWlsdXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmVybmQgRWRsaW5n
ZXIgPGJlcm5kLmVkbGluZ2VyQGhvdG1haWwuZGU+DQo+IC0tLQ0KPiAgwqBzY3JpcHRzL2tjb25m
aWcvTWFrZWZpbGUgfCAxICsNCj4gIMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9rY29uZmlnL01ha2VmaWxlIGIvc2NyaXB0cy9rY29u
ZmlnL01ha2VmaWxlDQo+IGluZGV4IGEzYWMyYzkuLmVmMzQyNzUgMTAwNjQ0DQo+IC0tLSBhL3Nj
cmlwdHMva2NvbmZpZy9NYWtlZmlsZQ0KPiArKysgYi9zY3JpcHRzL2tjb25maWcvTWFrZWZpbGUN
Cj4gQEAgLTYyLDYgKzYyLDcgQEAgUEhPTlkgKz0gJChzaW1wbGUtdGFyZ2V0cykNCj4gDQo+ICDC
oCQoc2ltcGxlLXRhcmdldHMpOiAkKG9iaikvY29uZg0KPiAgwqDCoMKgwqAgJDwgJChzaWxlbnQp
IC0tJEAgJChLY29uZmlnKQ0KPiArwqDCoMKgICQoUSkkKE1BS0UpIC1mICQoc3JjdHJlZSkvTWFr
ZWZpbGUgc3luY2NvbmZpZw0KDQpPbiBzZWNvbmQgdGhvdWdodCwgcmVtb3ZpbmcgdGhlIGF1dG8u
Y29uZiBtaWdodCBiZSBzdWZmaWNpZW50Og0KJChRKXJtIC1mIGluY2x1ZGUvY29uZmlnL2F1dG8u
Y29uZiBpbmNsdWRlL2NvbmZpZy9hdXRvLmNvbmYuY21kDQoNCldvdWxkIHlvdSBwcmVmZXIgdGhh
dD8NCg0KDQo+IA0KPiAgwqBQSE9OWSArPSBvbGRub2NvbmZpZyBzaWxlbnRvbGRjb25maWcgc2F2
ZWRlZmNvbmZpZyBkZWZjb25maWcNCj4gDQo=
