Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076C7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F1520684
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="X/YYqMUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F1520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389793AbeKVHsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:48:05 -0500
Received: from mail-eopbgr820042.outbound.protection.outlook.com ([40.107.82.42]:20531
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733229AbeKVHsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js4KMiad9rcDgdy9eiRANGI9XjtLzl24Xa9tnp3Q2Xs=;
 b=X/YYqMUQMkWpQ8U7EAw14d0di49sQKx7i/EdEPo4p3F+w7cvzItAK/z/nSfSdII3khi6iBdAfz5BPnpzRlsJHwsLmh6UoOQvfvj7dgrAqavQXpgqkJbbHYl0470J6gxzNumHjUHyt3fJ3huNmDhD1gT9bR7OS9ESo7tOO1r6Jfs=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4263.namprd05.prod.outlook.com (20.176.252.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.9; Wed, 21 Nov 2018 21:12:01 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1361.015; Wed, 21 Nov 2018
 21:12:01 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Out of tree module build errors since v4.20-rc1
Thread-Topic: Out of tree module build errors since v4.20-rc1
Thread-Index: AQHUgdzMTiVodyHxTkqOhap0cKGZo6VaufUA
Date:   Wed, 21 Nov 2018 21:12:01 +0000
Message-ID: <5A24CA1A-3059-44BE-A0D5-4E29FC6E5BE9@vmware.com>
References: <20181121205633.oxksehwjg5a2q6rt@oracle.com>
In-Reply-To: <20181121205633.oxksehwjg5a2q6rt@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4263;20:8wwg0GjyzulsYec9+BDEnu0s2B+d568vow1uUNETovCJKdPjXj+pBTmVhhiv9tx6qS88C4GtRQIPl4z5yYLuvzMtAXQHxVKneb/PIALjHzNKFIY5t3PShIz689wxv6MH5FpKbODTSv94rQQkxuSfvFYNw/wkca9LYdMfk1UxsHc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e96ce7f6-8a0b-417a-78c7-08d64ff5face
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4263;
x-ms-traffictypediagnostic: BYAPR05MB4263:
x-microsoft-antispam-prvs: <BYAPR05MB4263C1830514698C57EA94D4D0DA0@BYAPR05MB4263.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4263;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4263;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(54906003)(256004)(66066001)(7736002)(81166006)(6512007)(81156014)(229853002)(478600001)(71190400001)(71200400001)(6916009)(53936002)(36756003)(8676002)(316002)(14454004)(33656002)(106356001)(2616005)(105586002)(8936002)(11346002)(2906002)(476003)(446003)(25786009)(68736007)(305945005)(5660300001)(3846002)(6116002)(4326008)(6246003)(186003)(6486002)(6436002)(86362001)(26005)(486006)(2900100001)(76176011)(6506007)(53546011)(82746002)(99286004)(102836004)(97736004)(83716004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4263;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uzZ2ouNVzBeEvTvtCtY/QwrdrT3gOKs+zbptC4GAC1n/XSdxOLPozURZsX+UFLRU98kOaJLDkP+TY5Hf8onGRxvuGoPia3G4sg8crCto7OPBUKYtCsAXEvF0OvxyCGUz4vJCTlwlQxrQQWBgIDne3IgfFFUbkdiOyxhug1vW12UjAj4Ncqlu+enEF7nvEkHxijHpkwODmb7+tiHsLXKaG3t2wtl2qsZ6e5Y8MwT36CQb8bOfI8wj0ZwJOfFZeT5P45JcvYrAx6ygOdQYoS4VImOxB2AyUsV/wk/GhKQB9grqayZDWh8DL12LlN50KMeEy/qEmjVv/92CeogfedMLuSNyGm5NTQCuaaR4ressH84=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4700948FEADE224E8982F96357EDEA81@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96ce7f6-8a0b-417a-78c7-08d64ff5face
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 21:12:01.1089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBOb3YgMjEsIDIwMTgsIGF0IDEyOjU2IFBNLCBMaWFtIFIuIEhvd2xldHQgPExpYW0uSG93
bGV0dEBPcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IA0KPiBNeSBvdXQgb2YgdHJlZSBkcml2ZXIg
YnVpbGQgaXMgbm93IHJlcG9ydGluZyBpc3N1ZXMgd2l0aCB0aGUganVtcCB0YWJsZToNCj4gDQo+
IC4vaW5jbHVkZS9saW51eC9qdW1wX2xhYmVsLmg6IEluIGZ1bmN0aW9uIOKAmGp1bXBfZW50cnlf
Y29kZeKAmToNCj4gLi9pbmNsdWRlL2xpbnV4L2p1bXBfbGFiZWwuaDoxNTM6MTQ6IGVycm9yOiBk
ZXJlZmVyZW5jaW5nIHBvaW50ZXIgdG8gaW5jb21wbGV0ZSB0eXBlIOKAmGNvbnN0IHN0cnVjdCBq
dW1wX2VudHJ54oCZDQo+ICByZXR1cm4gZW50cnktPmNvZGU7DQo+ICAgICAgICAgICAgICBefg0K
PiAuL2luY2x1ZGUvbGludXgvanVtcF9sYWJlbC5oOiBJbiBmdW5jdGlvbiDigJhqdW1wX2VudHJ5
X3NldF9pbml04oCZOg0KPiAuL2luY2x1ZGUvbGludXgvanVtcF9sYWJlbC5oOjE4MDo3OiBlcnJv
cjogZGVyZWZlcmVuY2luZyBwb2ludGVyIHRvIGluY29tcGxldGUgdHlwZSDigJhzdHJ1Y3QganVt
cF9lbnRyeeKAmQ0KPiAgZW50cnktPmtleSB8PSAyOw0KPiAgICAgICBefg0KPiAuL2luY2x1ZGUv
bGludXgvanVtcF9sYWJlbC5oOiBBdCB0b3AgbGV2ZWw6DQo+IC4vaW5jbHVkZS9saW51eC9qdW1w
X2xhYmVsLmg6MjEyOjI2OiBlcnJvcjogYXJyYXkgdHlwZSBoYXMgaW5jb21wbGV0ZSBlbGVtZW50
IHR5cGUg4oCYc3RydWN0IGp1bXBfZW50cnnigJkNCj4gZXh0ZXJuIHN0cnVjdCBqdW1wX2VudHJ5
IF9fc3RhcnRfX19qdW1wX3RhYmxlW107DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+
fn5+fn5+fn5+fn5+fn5+fg0KPiAuL2luY2x1ZGUvbGludXgvanVtcF9sYWJlbC5oOjIxMzoyNjog
ZXJyb3I6IGFycmF5IHR5cGUgaGFzIGluY29tcGxldGUgZWxlbWVudCB0eXBlIOKAmHN0cnVjdCBq
dW1wX2VudHJ54oCZDQo+IGV4dGVybiBzdHJ1Y3QganVtcF9lbnRyeSBfX3N0b3BfX19qdW1wX3Rh
YmxlW107DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+DQo+
IA0KPiANCj4gVGhpcyBoYXBwZW5zIGluIHY0LjIwLXJjMyBhcyB3ZWxsLCBzbyBJIGJpc2VjdGVk
IGJldHdlZW4gdjQuMTkgdG8NCj4gdjQuMjAtcmMxIHdoaWNoIHJlc3VsdGVkIGluIHRoZSBmb2xs
b3dpbmcgY29tbWl0Og0KPiANCj4gYjM0MDA2YzQyNThjOWM4NjU5N2I2YjcxMjNkNmE5YTM1MTNk
NmNkNyBpcyB0aGUgZmlyc3QgYmFkIGNvbW1pdA0KPiBjb21taXQgYjM0MDA2YzQyNThjOWM4NjU5
N2I2YjcxMjNkNmE5YTM1MTNkNmNkNw0KPiBBdXRob3I6IEFyZCBCaWVzaGV1dmVsIDxhcmQuYmll
c2hldXZlbEBsaW5hcm8ub3JnPg0KPiBEYXRlOiAgIFR1ZSBTZXAgMTggMjM6NTE6NDEgMjAxOCAt
MDcwMA0KPiANCj4gICAgeDg2L2p1bXBfdGFibGU6IFVzZSByZWxhdGl2ZSByZWZlcmVuY2VzDQo+
IA0KPiANCj4gDQo+IA0KPiBJbml0aWFsbHkgSSBhc3N1bWVkIHRoaXMgd2FzIG15IG93biBmYXVs
dCwgYnV0IG15IG1vZHVsZSBkb2VzIG5vdCBoYXZlDQo+IHRoZXNlIGlzc3VlcyB3aGVuIHVzaW5n
IHY0LjE5LiAgSXMgdGhlcmUgYW55dGhpbmcgSSBzaG91bGQgdHJ5L2NoYW5nZSBpbg0KPiBteSBt
b2R1bGUgbWFrZWZpbGUsIGluY2x1ZGVzLCBldGMgdG8gc3VwcG9ydCB0aGlzIHJlbGF0aXZlIHJl
ZmVyZW5jZQ0KPiBjb2RlPw0KDQpEbyB5b3Ugc2VlIEhBVkVfQVJDSF9KVU1QX0xBQkVMX1JFTEFU
SVZFIHNldCBpbiB5b3VyIGtlcm5lbCBjb25maWc/DQoNCg==
