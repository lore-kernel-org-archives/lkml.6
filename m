Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFBAC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F7B21772
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="a0K2+CLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F7B21772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeHUOEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 10:04:40 -0400
Received: from mail-by2nam01on0089.outbound.protection.outlook.com ([104.47.34.89]:50368
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726688AbeHUOEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 10:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZE6mNRJpLKFoeFRYuPvd4JwQ/r9+qEKi9pR9CK5k4U=;
 b=a0K2+CLEPNjcYQ+qSs9b0P/oFvcJYI90KLle/gk2hsmUu2jWBo1I4L9sqyWqB1D99OrW1YbyHICRfq3jr5xyYyjKABZlqj7dKPQHX4nmD5RUVXwVhwZFssfJeKujdPGksl53PYoJhsdRJMc0XgcOPmp3eaOqt9YmLMz58gNfZgI=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2413.namprd02.prod.outlook.com (10.168.244.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Tue, 21 Aug 2018 10:44:56 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68%2]) with mapi id 15.20.1059.023; Tue, 21 Aug 2018
 10:44:54 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "absahu@codeaurora.org" <absahu@codeaurora.org>,
        "peterpandong@micron.com" <peterpandong@micron.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: RE: [LINUX PATCH v10 1/2] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Thread-Topic: [LINUX PATCH v10 1/2] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Thread-Index: AQHUNiz1pd9TJsD6BkCdX9soxsgc9aTIl58AgAEHRSCAAB0XAIAANHvggAAMkwCAAAj5QA==
Date:   Tue, 21 Aug 2018 10:44:54 +0000
Message-ID: <MWHPR02MB2623A681FB4FF038B3F9C758AF310@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180820143324.61af9027@bbrezillon>
        <MWHPR02MB2623F315C6D4C9775CDA08D8AF310@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20180821075948.28962170@bbrezillon>
        <MWHPR02MB2623E78222225D1CE8167463AF310@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20180821115238.1ad4dcb8@xps13>
In-Reply-To: <20180821115238.1ad4dcb8@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2413;6:vEVmHw7wSC+jezGTd7f3u0eux1nWc2qS+vHWt/kN7r0dSkFedRLNDVnVT8DVhjDcqOcP5c/xgAi9c0RTxxvWwC6dwsdFjG0YQm4oPQIeh3AaeerKPnDSGEVNu6CmzrQuSqdjCRba5oQr3EluXHQnH0poXV8NIaw1udcnVvFRZATT5QLgjux15Tm75/bSDl/CWvpTJqxBOJLgE/RI4CDEgQtc/nBJtgs+U6J4n1ULiZrka0gdZ1fFcJY2r6p+6gfqOv+xYWaor310UMbPUPYbUm8IjWFL0kCSgU2LphW8A2TR6aOemRvwf0a0FSgIydhZ5GDfintKfCn5frymtG3UTLBYmpSI8iewRWPm6R4HU8nxZifYZN115Lcs9Udc4GqRHcnjVjHIGc5yWCMuuC7+X1tyDi9SvAIIb7Dcyicimxwt8X/yK5GGqLC/D5/i2JpZHDBgXUra1p5m6M/kDCnFEw==;5:mmKmrLMXy7oZZbqMdzykPxCOrG+T2QbOgOc7KNzesvOHbDr9IsECEYD/MsijqiHphVD7ATHmSc5Nl4/i6yTPHO/LDkVYqg3x0AhZvhvEIzZMlj54JlJUlnUSWNKC/zb7MN6Il7Io//BrkM871aplFYMNLLaPZr4J3c8fy0jhlwc=;7:AXOlIzJxFlgLJej+tE7T0/6w+tGP12L3jxnA0MUKuyJ7btINwxEXOaAfkziyV1wx8zkw7+pedth6fMyniKClnb8vnlvxCawy7+RPx89Fkrz5TBdXa9m4kRA5FNbWJMwy5CBVTIJSoicLvgLbpxAwEAuyx332eCv8+c62f8P540uDRBKd1bFJCOlE9mNWJgNDLrj8kZA/3Dr1d2j1FpyPPtvm1bA0mgJZVSJSDse0VOSWve+2hvWE9rW2IAfwIst2
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(376002)(346002)(396003)(13464003)(199004)(189003)(74316002)(55016002)(5250100002)(316002)(9686003)(229853002)(39060400002)(105586002)(81166006)(25786009)(8676002)(81156014)(7736002)(97736004)(305945005)(8936002)(106356001)(54906003)(217873002)(68736007)(478600001)(6436002)(6246003)(6306002)(966005)(14444005)(53936002)(76176011)(256004)(4326008)(446003)(2906002)(102836004)(93886005)(186003)(26005)(2900100001)(3846002)(66066001)(11346002)(7696005)(99286004)(14454004)(476003)(33656002)(7416002)(486006)(86362001)(6916009)(53546011)(5660300001)(6506007)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2413;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: f392277f-0955-461e-1598-08d6075321a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2413;
x-ms-traffictypediagnostic: MWHPR02MB2413:
x-microsoft-antispam-prvs: <MWHPR02MB2413C0CCA9142BE6C8544508AF310@MWHPR02MB2413.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(34377916053724)(163750095850)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:MWHPR02MB2413;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2413;
x-forefront-prvs: 0771670921
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VHmy5Nm094PnJjARvZpaAWZHYRb1cYOy1cixGIe7rV3vTKtou2eVdSPLWpDcnOEbB6Ad/kAtPVoaKl78s/NThCLZEcyllSG04zeDKVwhh7hAG58+JYGt+XIuMx9wfRyog7ManqutSL4U6+7/t217BWI9/KrwE7ys2yWAseiE3wiZJKkcA3s7156d6E6rNDsu1g8+Nsmj3GU2q+5WfK85U/fmAulVb/Kn9XkTrXi7IIPkl95/RaI5PQrjOQaD0gYCSUEoJmFwpAKo2hVFRY9LOfpcESVdkArM7a6/CIE9t+zIhR5FtrM4mRBm+D3LcuSxMje1eDY4vSHo6y3N/eQTmG9FtPUSxJFg4RVIBoBVREw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f392277f-0955-461e-1598-08d6075321a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2018 10:44:54.5422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgW21haWx0bzptaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tXQ0KPiBTZW50OiBUdWVz
ZGF5LCBBdWd1c3QgMjEsIDIwMTggMzoyMyBQTQ0KPiBUbzogTmFnYSBTdXJlc2hrdW1hciBSZWxs
aSA8bmFnYXN1cmVAeGlsaW54LmNvbT4NCj4gQ2M6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJl
emlsbG9uQGJvb3RsaW4uY29tPjsgcmljaGFyZEBub2QuYXQ7IGR3bXcyQGluZnJhZGVhZC5vcmc7
DQo+IGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbTsgbWFyZWsudmFzdXRAZ21haWwuY29tOyBr
eXVuZ21pbi5wYXJrQHNhbXN1bmcuY29tOw0KPiBhYnNhaHVAY29kZWF1cm9yYS5vcmc7IHBldGVy
cGFuZG9uZ0BtaWNyb24uY29tOyBmcmllZGVyLnNjaHJlbXBmQGV4Y2VldC5kZTsgbGludXgtDQo+
IG10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBN
aWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47DQo+IG5hZ2FzdXJlc2hrdW1hcnJlbGxp
QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW0xJTlVYIFBBVENIIHYxMCAxLzJdIGR0LWJpbmRp
bmdzOiBtdGQ6IGFyYXNhbjogQWRkIGRldmljZSB0cmVlIGJpbmRpbmcNCj4gZG9jdW1lbnRhdGlv
bg0KPiANCj4gSGkgTmFnYSwNCj4gDQo+IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJl
QHhpbGlueC5jb20+IHdyb3RlIG9uIFR1ZSwgMjEgQXVnIDIwMTgNCj4gMDk6MjI6MDcgKzAwMDA6
DQo+IA0KPiA+IEhpIEJvcmlzLA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gRnJvbTogQm9yaXMgQnJlemlsbG9uIFttYWlsdG86Ym9yaXMuYnJlemlsbG9uQGJv
b3RsaW4uY29tXQ0KPiA+ID4gU2VudDogVHVlc2RheSwgQXVndXN0IDIxLCAyMDE4IDExOjMwIEFN
DQo+ID4gPiBUbzogTmFnYSBTdXJlc2hrdW1hciBSZWxsaSA8bmFnYXN1cmVAeGlsaW54LmNvbT4N
Cj4gPiA+IENjOiBtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tOyByaWNoYXJkQG5vZC5hdDsgZHdt
dzJAaW5mcmFkZWFkLm9yZzsNCj4gPiA+IGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbTsgbWFy
ZWsudmFzdXRAZ21haWwuY29tOw0KPiA+ID4ga3l1bmdtaW4ucGFya0BzYW1zdW5nLmNvbTsgYWJz
YWh1QGNvZGVhdXJvcmEub3JnOw0KPiA+ID4gcGV0ZXJwYW5kb25nQG1pY3Jvbi5jb207IGZyaWVk
ZXIuc2NocmVtcGZAZXhjZWV0LmRlOyBsaW51eC0NCj4gPiA+IG10ZEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNaWNoYWwgU2ltZWsNCj4gPiA+IDxt
aWNoYWxzQHhpbGlueC5jb20+OyBuYWdhc3VyZXNoa3VtYXJyZWxsaUBnbWFpbC5jb20NCj4gPiA+
IFN1YmplY3Q6IFJlOiBbTElOVVggUEFUQ0ggdjEwIDEvMl0gZHQtYmluZGluZ3M6IG10ZDogYXJh
c2FuOiBBZGQNCj4gPiA+IGRldmljZSB0cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbg0KPiA+ID4N
Cj4gPiA+IE9uIFR1ZSwgMjEgQXVnIDIwMTggMDU6NDc6MTggKzAwMDANCj4gPiA+IE5hZ2EgU3Vy
ZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJlQHhpbGlueC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+
ID4gPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiA+ID4gKy0gY29tcGF0aWJsZToJ
CVNob3VsZCBiZSAieGxueCx6eW5xbXAtbmFuZCIgb3IgImFyYXNhbixuZmMtdjNwMTAiDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBJbiB5b3VyIGV4YW1wbGUgaXQncyBub3QgYW4gIm9yIiBzaW5jZSBi
b3RoIGFyZSBkZWZpbmVkLg0KPiA+ID4gPiBJbiBvdXIgcHJldmlvdXMgZGlzY3Vzc2lvbg0KPiA+
ID4gPiAoaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzc0ODkwMS8pDQo+
ID4gPiA+IFdlIGRlY2lkZWQgdG8gaGF2ZSBjb21wYXRpYmxlIHN0cmluZ3MgbGlrZSAiIGNvbXBh
dGlibGUgPQ0KPiA+ID4gPiAiPHNvYy12ZW5kb3I+LDxpcC1yZXZpc2lvbj4iLA0KPiA+ID4gImFy
YXNhbiw8aXAtcmV2aXNpb24+IjsiDQo+ID4gPiA+IFNvIGl0IHNob3VsZCBiZSBlaXRoZXIgb2Yg
dGhlc2UuDQo+ID4gPiA+IHNvIEkgd2lsbCB3cml0ZSBzb21ldGhpbmcgbGlrZSBiZWxvdyAiUG9z
c2libGUgdmFsdWVzIGFyZQ0KPiA+ID4gPiAieGxueCx6eW5xbXAtbmFuZCINCj4gPiA+ID4gCQkJ
ImFyYXNhbixuZmMtdjNwMTAiDQo+ID4gPiA+IEFuZCBpbiBleGFtcGxlIEkgd2lsbCBtZW50aW9u
IGFueSBvbmUgY29tcGF0aWJsZS4NCj4gPiA+ID4gSXMgaXQgb2s/DQo+ID4gPg0KPiA+ID4gSG0s
IHdoeSBkbyB5b3UgbmVlZCBhcmFzYW4sbmZjLXYzcDEwIGF0IGFsbCBpZiBpdCdzIHN1cHBvc2Vk
IHRvIGJlDQo+ID4gPiBvdmVybG9hZGVkIGJ5IGEgc29jIHNwZWNpZmljIGNvbXBhdD8NCj4gPiBB
Y3R1YWxseSB3ZSBwdXQgdGhlc2UgY29tcGF0aWJsZSBzdHJpbmdzIGJhc2VkIG9uIHRoZSBjb21t
ZW50cyBvbiB2NyBzZXJpZXMuDQo+ID4gQW55d2F5IEkgd2lsbCBqdXN0IGtlZXAgInhsbngsenlu
cW1wLW5hbmQiIGFzIGNvbXBhdGlibGUuDQo+ID4gPg0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+
ID4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+ID4gPiA+ID4gPiArLSBhcmFzYW4saGFzLW1kbWE6
IEVuYWJsZXMgRE1BIHN1cHBvcnQNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IENhbid0IHlvdSBkZXRl
Y3QgdGhhdCBiYXNlZCBvbiB0aGUgY29tcGF0aWJsZSAob3IgdGhhbmtzIHRvIGENCj4gPiA+ID4g
PiByZWdpc3RlcikuIElmIGl0J3Mgc29tZXRoaW5nIHlvdSBjaG9vc2Ugd2hlbiBjb25maWd1cmlu
ZyB0aGUgSVANCj4gPiA+ID4gPiBhbmQgY2FuJ3QgZGV0ZWN0IGF0DQo+ID4gPiBydW50aW1lIEkg
Z3Vlc3MgaXQncyBmaW5lLg0KPiA+ID4gPiBUaGVyZSBpcyBubyB3YXkgdG8gc2VsZWN0IERNQSB3
aGVuIGNvbmZpZ3VyaW5nIHRoZSBJUC4NCj4gPiA+ID4gQnV0IGl0IGhhcyBpbnRlcm5hbCBETUEg
YW5kIHRoZXJlIGlzIGEgcmVnaXN0ZXIgdG8gc2VsZWN0IFBJTyBvcg0KPiA+ID4gPiBETUEgd2hp
bGUgc3RhcnRpbmcgYQ0KPiA+ID4gdHJhbnNmZXIuDQo+ID4gPiA+IFNvIGlmIHVzZXIgcmVhbGx5
IGRvbid0IHdhbnQgRE1BLCB0aGVuIHdlIHdpbGwgbmV2ZXIgc2V0IERNQSBpbg0KPiA+ID4gPiB0
aGUgY29kZSBiYXNlZCBvbiBEVA0KPiA+ID4gcHJvcGVydHkuDQo+ID4gPg0KPiA+ID4gSWYgaXQn
cyBhIHB1cmVseSBTVyBjaG9pY2UsIHRoZW4gaXMgc2hvdWxkbid0IGJlIGRlc2NyaWJlZCBpbiB0
aGUgRFQuDQo+ID4gPiBZb3UgY2FuIHVzZSBhIG1vZHVsZSBwYXJhbSwgYnV0IEknbSBub3QgZXZl
biBzdXJlIHdoeSBvbmUgd291bGQgd2FudCB0byBkaXNhYmxlIERNQS4NCj4gPiBVQklGUyBkb2Vz
bid0IHdvcmsgd2l0aCBETUEsIGhlbmNlIHdlIGFyZSB1c2luZyBhIERUIHByb3BlcnR5IHRvIG9w
ZXJhdGUgdGhlIGRyaXZlciBpbg0KPiBJTy4NCj4gPiBCdXQgYXMgeW91IHBvaW50ZWQgKHVzZSB2
aXJ0X2lzX3ZhbGlkKCkpLCB3aXRoIHRoaXMgd2UgY2FuIHN3aXRjaCBvdXIgZHJpdmVyIHRvIG9w
ZXJhdGUgaW4NCj4gUElPIG9yIERNQS4NCj4gPiBJIHdpbGwgcmVtb3ZlIHRoaXMgZnJvbSBEVC4N
Cj4gDQo+IEkgZG9uJ3QgZ2V0IHdoeSBVQklGUyB3b3VsZCBub3Qgd29yayB3aXRoIERNQT8gVGhp
cyBpcyBhIHNpZ25pZmljYW50IGRyYXdiYWNrLg0KVUJJRlMgdXNlcyB2bWFsbG9jJ2VkIGJ1ZmZl
cnMgd2hlcmVhcyBmb3IgRE1BIGl0IHNob3VsZCBiZSBETUEtYWJsZSwgaS5lIHVzZXMgcGh5c2lj
YWxseSBjb250aWd1b3VzIG1lbW9yeS4NCkhlbmNlIHdlIHVzZWQgYSBEVCBwcm9wZXJ0eSB0byBt
YWtlIGl0IHdvcmsgaW4gUElPIG1vZGUuDQpTb21lIGRpc2N1c3Npb24gaGFwcGVuZWQgaW4gaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC85Njc1MDA3Ly4NCkJ1dCB3aGF0ZXZlciBJ
IHNhaWQgYWJvdmUsIGlzIHdpdGggb2xkZXIgYXJhc2FuX25hbmQgZHJpdmVyLCBub3cgYW55d2F5
IHdlIGhhdmUNCnZpcnRfYWRkcl92YWxpZCgpLiBCeSBjaGVja2luZyB0aGlzIHdlIGNhbiB1c2Ug
RE1BIG9yIFBJTy4NClRoaXMgaXMgdGhlIGluZm9ybWF0aW9uIEkgaGF2ZSwgYnV0IEkgbWF5IGJl
IHdyb25nLg0KDQpUaGFua3MsDQpOYWdhIFN1cmVzaGt1bWFyIFJlbGxpLg0KPiANCj4gTWlxdcOo
bA0K
