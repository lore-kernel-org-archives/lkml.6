Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44720C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAE924BBA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ifiQMhgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAE924BBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932191AbeGCNBE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:01:04 -0400
Received: from mail-co1nam03on0082.outbound.protection.outlook.com ([104.47.40.82]:11783
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752560AbeGCNBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddtGg4PiRqcQ8+NzKNTHwpq9wDw1TjevLSOhH1VpjMg=;
 b=ifiQMhgTJGGgFqgFdGPbrmZ5ktCjmnsoT7jw/1P4pW0cMoRjFQeLQidxaTYuGWg2jOuic38KRFT7FbmWBeMCEsH/wzqhTdk/1cLcWbXByMbp7wTgNGRSWBdOBSF+AkuUwsFABUwNPcJ67HpDIIOt3VNWAdg4l+tUgEL2QHiGQvU=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2414.namprd02.prod.outlook.com (10.168.244.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Tue, 3 Jul 2018 13:00:57 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b%8]) with mapi id 15.20.0906.026; Tue, 3 Jul 2018
 13:00:55 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [[LINUX PATCH v10] 4/4] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Thread-Topic: [[LINUX PATCH v10] 4/4] mtd: rawnand: pl353: Add basic driver
 for arm pl353 smc nand interface
Thread-Index: AQHUCSslFhIqNZ8rp0qjyj+1AxTyIaR0QxOAgADd5DCAACwaAIAIOYMg
Date:   Tue, 3 Jul 2018 13:00:55 +0000
Message-ID: <MWHPR02MB262302F2D504A4783CF60832AF420@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1529563351-2241-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180627172249.72f878a2@xps13>
        <MWHPR02MB26236BEABAAF0213B49EC21EAF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20180628091450.25bd54e5@xps13>
In-Reply-To: <20180628091450.25bd54e5@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2414;7:MrYaU7HqBW11xzwYPmKYFxirLSKEOjnWiEDGZgpsktkv+hMtL5D532jR+xPxX2YpsovbMYmXExArO40GpktEjpq1lylb/Fslkogc/dcOc4XUktIiwIbmWlb03jT3hATbwpryeDGh/b84z00RWXemZ108/lyMoChQa/oTM+trI7mAQ1XUulEzwhaCoAwJPLdMEgsOfsbB2yi4lKopdYCrKKTCEdpRBfw0pCVmVZQ07lSej54Qhoonv7UyDweQtFYN
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(366004)(376002)(396003)(189003)(199004)(13464003)(6506007)(68736007)(93886005)(186003)(55236004)(102836004)(966005)(26005)(5660300001)(446003)(11346002)(76176011)(476003)(486006)(14454004)(7696005)(9686003)(54906003)(2906002)(33656002)(53546011)(106356001)(105586002)(7416002)(316002)(99286004)(2900100001)(6916009)(6436002)(229853002)(66066001)(107886003)(6246003)(39060400002)(53936002)(4326008)(25786009)(74316002)(6116002)(3846002)(478600001)(305945005)(7736002)(55016002)(97736004)(8676002)(81156014)(81166006)(6306002)(8936002)(86362001)(5250100002)(256004)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2414;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f6a1bca-4e65-48a4-2032-08d5e0e50391
x-microsoft-antispam: UriScan:(258095267146985);BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2414;
x-ms-traffictypediagnostic: MWHPR02MB2414:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-microsoft-antispam-prvs: <MWHPR02MB24143950B9A448ED8578793CAF420@MWHPR02MB2414.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(258095267146985)(85827821059158)(258649278758335)(192813158149592)(261952635957900);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231280)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2414;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2414;
x-forefront-prvs: 0722981D2A
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H6GnQJfvD60u9gyeX+pIbq+t6rfEu8mO9kyhCHLwsjipsR1A+CNpFqpFfnsJ0kAfM44FNVfiRoiXIBKiYQP9dGXZKFBuToi8d1UyMVUONWT5RnPC8QfpyB9n0FRgLwC4obiUaIW6TYPxMJgJRq5/k20nWlZZ6fq0aK70aSLb3X3S2lsE6hzXXx0pPMJ7rAaLPyNJ3J+2fxeaEaqdYCC696SavGQ4R5HS4gtrc4pvd0UTv27a0xV5VhqrDCF2IECQly5BxtASck/i8GT7V0MeD9A+d29UrUM2ORspdhcnoNcfhwChIS84m5cfSnoz06HQi1iY4co8AwYKYJTldb4esHc6XcUfOqOaEiDXas1AL6o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6a1bca-4e65-48a4-2032-08d5e0e50391
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2018 13:00:55.3417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgW21haWx0bzptaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tXQ0KPiBTZW50OiBUaHVy
c2RheSwgSnVuZSAyOCwgMjAxOCAxMjo0NSBQTQ0KPiBUbzogTmFnYSBTdXJlc2hrdW1hciBSZWxs
aSA8bmFnYXN1cmVAeGlsaW54LmNvbT4NCj4gQ2M6IGJvcmlzLmJyZXppbGxvbkBib290bGluLmNv
bTsgcmljaGFyZEBub2QuYXQ7IGR3bXcyQGluZnJhZGVhZC5vcmc7DQo+IGNvbXB1dGVyc2ZvcnBl
YWNlQGdtYWlsLmNvbTsgbWFyZWsudmFzdXRAZ21haWwuY29tOyBmLmZhaW5lbGxpQGdtYWlsLmNv
bTsNCj4gbW1heWVyQGJyb2FkY29tLmNvbTsgcm9nZXJxQHRpLmNvbTsgbGFkaXNAbGludXgtbWlw
cy5vcmc7IGFkYUB0aG9yc2lzLmNvbTsNCj4gaG9uZ2h1aS56aGFuZ0BtZWRpYXRlay5jb207IGxp
bnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Ow0KPiBuYWdhc3VyZXNoa3VtYXJyZWxsaUBnbWFpbC5jb207IE1pY2hhbCBTaW1layA8bWljaGFs
c0B4aWxpbnguY29tPg0KPiBTdWJqZWN0OiBSZTogW1tMSU5VWCBQQVRDSCB2MTBdIDQvNF0gbXRk
OiByYXduYW5kOiBwbDM1MzogQWRkIGJhc2ljIGRyaXZlciBmb3IgYXJtDQo+IHBsMzUzIHNtYyBu
YW5kIGludGVyZmFjZQ0KPiANCj4gSGkgTmFnYSwNCj4gDQo+ID4gPiA+ICsvKioNCj4gPiA+ID4g
KyAqIHBsMzUzX25hbmRfcmVhZF9wYWdlX2h3ZWNjIC0gSGFyZHdhcmUgRUNDIGJhc2VkIHBhZ2Ug
cmVhZCBmdW5jdGlvbg0KPiA+ID4gPiArICogQG10ZDoJCVBvaW50ZXIgdG8gdGhlIG10ZCBpbmZv
IHN0cnVjdHVyZQ0KPiA+ID4gPiArICogQGNoaXA6CQlQb2ludGVyIHRvIHRoZSBOQU5EIGNoaXAg
aW5mbyBzdHJ1Y3R1cmUNCj4gPiA+ID4gKyAqIEBidWY6CQlQb2ludGVyIHRvIHRoZSBidWZmZXIg
dG8gc3RvcmUgcmVhZCBkYXRhDQo+ID4gPiA+ICsgKiBAb29iX3JlcXVpcmVkOglDYWxsZXIgcmVx
dWlyZXMgT09CIGRhdGEgcmVhZCB0byBjaGlwLT5vb2JfcG9pDQo+ID4gPiA+ICsgKiBAcGFnZToJ
CVBhZ2UgbnVtYmVyIHRvIHJlYWQNCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBUaGlzIGZ1bmN0
aW9ucyByZWFkcyBkYXRhIGFuZCBjaGVja3MgdGhlIGRhdGEgaW50ZWdyaXR5IGJ5DQo+ID4gPiA+
ICtjb21wYXJpbmcgaGFyZHdhcmUNCj4gPiA+ID4gKyAqIGdlbmVyYXRlZCBFQ0MgdmFsdWVzIGFu
ZCByZWFkIEVDQyB2YWx1ZXMgZnJvbSBzcGFyZSBhcmVhLg0KPiA+ID4gPiArICoNCj4gPiA+ID4g
KyAqIFJldHVybjoJMCBhbHdheXMgYW5kIHVwZGF0ZXMgRUNDIG9wZXJhdGlvbiBzdGF0dXMgaW4g
dG8gTVREIHN0cnVjdHVyZQ0KPiA+ID4gPiArICovDQo+ID4gPiA+ICtzdGF0aWMgaW50IHBsMzUz
X25hbmRfcmVhZF9wYWdlX2h3ZWNjKHN0cnVjdCBtdGRfaW5mbyAqbXRkLA0KPiA+ID4gPiArCQkJ
CSAgICAgIHN0cnVjdCBuYW5kX2NoaXAgKmNoaXAsDQo+ID4gPiA+ICsJCQkJICAgICAgdTggKmJ1
ZiwgaW50IG9vYl9yZXF1aXJlZCwgaW50IHBhZ2UpIHsNCj4gPiA+ID4gKwlpbnQgaSwgc3RhdCwg
ZWNjc2l6ZSA9IGNoaXAtPmVjYy5zaXplOw0KPiA+ID4gPiArCWludCBlY2NieXRlcyA9IGNoaXAt
PmVjYy5ieXRlczsNCj4gPiA+ID4gKwlpbnQgZWNjc3RlcHMgPSBjaGlwLT5lY2Muc3RlcHM7DQo+
ID4gPiA+ICsJdTggKnAgPSBidWY7DQo+ID4gPiA+ICsJdTggKmVjY19jYWxjID0gY2hpcC0+ZWNj
LmNhbGNfYnVmOw0KPiA+ID4gPiArCXU4ICplY2MgPSBjaGlwLT5lY2MuY29kZV9idWY7DQo+ID4g
PiA+ICsJdW5zaWduZWQgaW50IG1heF9iaXRmbGlwcyA9IDA7DQo+ID4gPiA+ICsJdTggKm9vYl9w
dHI7DQo+ID4gPiA+ICsJdTMyIHJldDsNCj4gPiA+ID4gKwl1bnNpZ25lZCBsb25nIGRhdGFfcGhh
c2VfYWRkcjsNCj4gPiA+ID4gKwlzdHJ1Y3QgcGwzNTNfbmFuZF9pbmZvICp4bmZjID0NCj4gPiA+
ID4gKwkJY29udGFpbmVyX29mKGNoaXAsIHN0cnVjdCBwbDM1M19uYW5kX2luZm8sIGNoaXApOw0K
PiA+ID4gPiArCXVuc2lnbmVkIGxvbmcgbmFuZF9vZmZzZXQgPSAodW5zaWduZWQgbG9uZw0KPiA+
ID4gPiArX19mb3JjZSl4bmZjLT5uYW5kX2Jhc2U7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlwbDM1
M19wcmVwYXJlX2NtZChtdGQsIGNoaXAsIHBhZ2UsIDAsIE5BTkRfQ01EX1JFQUQwLA0KPiA+ID4g
PiArCQkJICBOQU5EX0NNRF9SRUFEU1RBUlQsIDEpOw0KPiA+ID4gPiArCW5kZWxheSgxMDApOw0K
PiA+ID4NCj4gPiA+IFdoYXQgaXMgdGhpcyBkZWxheSBmb3I/DQo+ID4gV2UgaGF2ZSBzZWVuIGZh
aWx1cmVzIHdpdGggb3V0IHRoaXMgZGVsYXksIHdpdGggb2xkZXIgY29kZS4NCj4gPiBCdXQgaSB3
aWxsIGNoZWNrIHRoaXMgYnkgcmVtb3ZpbmcgdGhpcyBkZWxheSwgaW4gdGhpcyBuZXcgZHJpdmVy
Lg0KPiANCj4gUGxlYXNlIGNoZWNrIGFsbCBvZiB0aGVtLiBXZSBzaG91bGQgZ2V0IHJpZCBvZiBy
YW5kb20gZGVsYXlzIGxpa2UgdGhhdC4NCj4gRWl0aGVyIHRoZXJlIGlzIHNvbWV0aGluZyB0byBw
b2xsLCBvciB0aGVyZSBpcyBhIHNwZWNpZmljIHZhbHVlIHRvIHVzZSAoeW91IGNhbiBnZXQgdGhl
bSBmcm9tIHRoZQ0KPiBTRFIgaW50ZXJmYWNlIHN0cnVjdHVyZSkuDQo+IA0KPiBbLi4uXQ0KPiAN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArCWlmIChjc2xpbmUgPT0gTkFORF9EQVRBX0lGQUNFX0NIRUNL
X09OTFkpDQo+ID4gPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4NCj4gPiA+IFdoeT8NCj4g
PiBJdCBpcyBzaW1pbGFyIHRvDQo+ID4gaWYgKGNoaXBuciA8IDApDQo+ID4gCXJldHVybiAwOw0K
PiANCj4gTW1tbW1oLCBubz8NCj4gDQo+IChyZXR1cm4gMCkgIT0gKHJldHVybiAtRUlOVkFMKQ0K
PiANCj4gVGhlIGNvcmUgaXMgYXNraW5nIHlvdSB0byBjaGVjayBpZiB0aGUgY29udHJvbGxlciBk
cml2ZXIgc3VwcG9ydCBwYXJ0aWN1bGFyIHRpbWluZ3MgKHVzdWFsbHkNCj4gT05GSSBtb2RlcyAx
LTUpLiBSZXR1cm5pbmcgYW4gZXJyb3IgbWVhbnMgIkkgb25seSBzdXBwb3J0IHRoZSBzbG93ZXN0
IHRpbWluZ3MiIHdoaWNoLCBJDQo+IHN1cHBvc2UsIGlzIHdyb25nLiBQbGVhc2UgZml4IHRoaXMg
YW5kIGNvbXBhcmUgdGhlIHNwZWVkcy4NCkkgdHJpZWQgdXBkYXRpbmcgdGhlIGRyaXZlciBhcyBw
ZXIgeW91ciBjb21tZW50cy4NCkJ1dCBJIGFtIGZhY2luZyBhbiBpc3N1ZSBoZXJlLg0KVGhlIHBh
cnQgSSBhbSB1c2luZyBpcyBodHRwOi8vd3d3LmN5cHJlc3MuY29tL2ZpbGUvMjA3NTIxL2Rvd25s
b2FkLg0KVGhpcyBwYXJ0IGRvZXNuJ3Qgc3VwcG9ydCBnZXQvc2V0IGZlYXR1cmVzLiBCdXQgdGhl
IGNvbnRyb2xsZXIgc3VwcG9ydHMgaXQuDQpJbiB0aGlzIGNhc2UsIHRoZSBmcmFtZSB3b3JrIGlz
IGRvaW5nIGxpa2UgdGhpcw0KSWYgY2hpcCBzdXBwb3J0cyBzZXRfZmVhdHVyZXMsIHRoZW4gaXQg
aXNzdWVzIHRoZSBPTkZJX0ZFQVRVUkVfQUREUl9USU1JTkdfTU9ERSBvdGhlciB3aXNlIG5vdC4N
CkluIG91ciBjYXNlIGl0IHdvbid0IGFuZCB0aGVuIG5leHQgaXQgc2ltcGx5IGNoYW5nZXMgdGhl
IGNvbnRyb2xsZXIgbW9kZS4gSGVuY2UgYm90aCBhcmUgaW4gZGlmZmVyZW50IHRpbWluZyBtb2Rl
IGFuZCBub3QNCkFibGUgdG8gY29tbXVuaWNhdGUgd2l0aCB0aGUgbmFuZCBmbGFzaCBkZXZpY2Uu
DQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NC4xOC1yYzMvc291cmNlL2RyaXZl
cnMvbXRkL25hbmQvcmF3L25hbmRfYmFzZS5jI0wxMjg1DQpBbSBJIG1pc3Npbmcgc29tZXRoaW5n
Pw0KQ291bGQgeW91IHBsZWFzZSBoZWxwIG9uIHRoaXMuDQoNClRoZSBjb2RlIHNuaXBwZXQgaXMg
bGlrZSB0aGlzDQp0YXRpYyBpbnQgcGwzNTNfc2V0dXBfZGF0YV9pbnRlcmZhY2Uoc3RydWN0IG10
ZF9pbmZvICptdGQsIGludCBjc2xpbmUsDQoJCQkJICAgICAgIGNvbnN0IHN0cnVjdCBuYW5kX2Rh
dGFfaW50ZXJmYWNlICpjb25mKQ0Kew0KCXNkciA9IG5hbmRfZ2V0X3Nkcl90aW1pbmdzKGNvbmYp
Ow0KCWlmIChJU19FUlIoc2RyKSkgew0KDQoJCXJldHVybiBQVFJfRVJSKHNkcik7DQoJfQ0KCWlm
IChjc2xpbmUgPT0gTkFORF9EQVRBX0lGQUNFX0NIRUNLX09OTFkpIHsNCgkJcmV0dXJuIDA7DQoJ
fQ0KfQ0KDQpUaGFua3MsDQpOYWdhIFN1cmVzaGt1bWFyIFJlbGxpLg0K
