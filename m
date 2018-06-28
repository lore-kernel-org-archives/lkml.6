Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF388C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D172467B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vlzwfacU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D172467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964989AbeF1Hhx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:37:53 -0400
Received: from mail-co1nam03on0050.outbound.protection.outlook.com ([104.47.40.50]:36928
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934030AbeF1Hhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq11UT2+8G9ng4yj4jE+5oBg5yNAWr8u96pZ6BEMDJI=;
 b=vlzwfacUYKEXdNwYX35zPU5dfLtOJyIfuwhzom6WJS1TWsN+r59EVUtJ7osoSsBb870NJRcbgT0y/eAeiH4dLD4P3sOO0TJdxIyST7e7lqs4fGSVrjeAxI8iz0SHwXFXs566yI1+1OkXCW44axlhF10uDdEg44P4iJ9vp/XzAKc=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2734.namprd02.prod.outlook.com (10.175.49.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Thu, 28 Jun 2018 07:37:36 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b%8]) with mapi id 15.20.0884.025; Thu, 28 Jun 2018
 07:37:36 +0000
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
Thread-Index: AQHUCSslFhIqNZ8rp0qjyj+1AxTyIaR0QxOAgADd5DCAACwaAIAABcEQ
Date:   Thu, 28 Jun 2018 07:37:36 +0000
Message-ID: <MWHPR02MB262356C47919D1190B477CF0AF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
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
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2734;7:xycRuzW4W3DKSl+FGt0Kzvscrm3ZFIGevo93D2HVpgATfdbRxFCkb3ttpMp0+gqKnkvx6yKR5bki78TAEk1Fv6qh7gXtDKYA9CfLSfmFRnPL43ducouGXW/QRcXZtXms4IW5gDpq4W7DK22pnpV1KsUpIUtwCQD221rafEm6fFCbsjCg7cTwu1w2t8yetwEyDeai6zvpb1gEidJHj9nZhrOO3+tFhPgR3RJyMWX9Ii1gvC2fY75hSY5y0NlNzajP
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39850400004)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(13464003)(14454004)(6916009)(6116002)(66066001)(74316002)(3846002)(107886003)(256004)(7416002)(53936002)(305945005)(6436002)(2906002)(7736002)(229853002)(5250100002)(25786009)(9686003)(4326008)(14444005)(68736007)(102836004)(486006)(39060400002)(97736004)(6506007)(86362001)(53546011)(6246003)(11346002)(105586002)(93886005)(55236004)(55016002)(33656002)(186003)(99286004)(5660300001)(106356001)(2900100001)(446003)(478600001)(316002)(476003)(26005)(54906003)(81166006)(8676002)(7696005)(76176011)(8936002)(81156014)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2734;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 8bef9587-6551-4f0b-641a-08d5dcca04a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2734;
x-ms-traffictypediagnostic: MWHPR02MB2734:
x-microsoft-antispam-prvs: <MWHPR02MB273480905ADCA967A36560D5AF4F0@MWHPR02MB2734.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2734;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2734;
x-forefront-prvs: 0717E25089
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qul3lPNl3er+LTukECLogPBjti9S+Fai2VV3Dne9uQ04MERvti+F6Olmq+opleb0yLg9V/jCOmL78dn2QCSNS4+Rcz0ZK4wiyaNkVrh3GSXmjmnW9PzgpomeHEXDk4oAeI2BitpXk5V3uM9gYwWSZpV3m+dTXcxM8oXVZmijh6Bix+JCrwpP98KNRLRRfhXKbUS71p47Pm0cf+lZo56tP2gJUFRTjywfRnTrMd3hQIZwf/QjrwTOmZs7x6ov03svkARfSJnHjY1TNx7xDAZI+TI4dIvGWXpF0rdWcZrOB3U2kIAL5JEgaTOfPCVGkbcWX1Yao58WhE1L0F/b8A1CqSrRCW5HoE7Jir5io2kXaxs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bef9587-6551-4f0b-641a-08d5dcca04a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 07:37:36.1121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2734
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
bSBmcm9tIHRoZQ0KPiBTRFIgaW50ZXJmYWNlIHN0cnVjdHVyZSkuDQpTdXJlLiANCj4gDQo+IFsu
Li5dDQo+IA0KPiA+ID4gPiArDQo+ID4gPiA+ICsJaWYgKGNzbGluZSA9PSBOQU5EX0RBVEFfSUZB
Q0VfQ0hFQ0tfT05MWSkNCj4gPiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPg0KPiA+ID4g
V2h5Pw0KPiA+IEl0IGlzIHNpbWlsYXIgdG8NCj4gPiBpZiAoY2hpcG5yIDwgMCkNCj4gPiAJcmV0
dXJuIDA7DQo+IA0KPiBNbW1tbWgsIG5vPw0KPiANCj4gKHJldHVybiAwKSAhPSAocmV0dXJuIC1F
SU5WQUwpDQo+IA0KPiBUaGUgY29yZSBpcyBhc2tpbmcgeW91IHRvIGNoZWNrIGlmIHRoZSBjb250
cm9sbGVyIGRyaXZlciBzdXBwb3J0IHBhcnRpY3VsYXIgdGltaW5ncyAodXN1YWxseQ0KPiBPTkZJ
IG1vZGVzIDEtNSkuIFJldHVybmluZyBhbiBlcnJvciBtZWFucyAiSSBvbmx5IHN1cHBvcnQgdGhl
IHNsb3dlc3QgdGltaW5ncyIgd2hpY2gsIEkNCj4gc3VwcG9zZSwgaXMgd3JvbmcuIFBsZWFzZSBm
aXggdGhpcyBhbmQgY29tcGFyZSB0aGUgc3BlZWRzLg0KT2suDQo+IA0KPiA+IGhlbmNlIHdyaXR0
ZW4gbGlrZSB0aGF0Lg0KPiA+IEFsc28gaWYgSSBkaWRuJ3QgZG8gdGhhdCwgdGhlbiBwcm9iZSBp
cyBmYWlsaW5nLg0KPiA+IEFtIEkgbWlzc2luZyBzb21lIHRoaW5nPw0KPiA+ID4NCj4gDQo+IFsu
Li5dDQo+IA0KPiA+ID4gPiArLyoqDQo+ID4gPiA+ICsgKiBwbDM1M19uYW5kX3Byb2JlIC0gUHJv
YmUgbWV0aG9kIGZvciB0aGUgTkFORCBkcml2ZXINCj4gPiA+ID4gKyAqIEBwZGV2OglQb2ludGVy
IHRvIHRoZSBwbGF0Zm9ybV9kZXZpY2Ugc3RydWN0dXJlDQo+ID4gPiA+ICsgKg0KPiA+ID4gPiAr
ICogVGhpcyBmdW5jdGlvbiBpbml0aWFsaXplcyB0aGUgZHJpdmVyIGRhdGEgc3RydWN0dXJlcyBh
bmQgdGhlIGhhcmR3YXJlLg0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIFJldHVybjoJMCBvbiBz
dWNjZXNzIG9yIGVycm9yIHZhbHVlIG9uIGZhaWx1cmUNCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiAr
c3RhdGljIGludCBwbDM1M19uYW5kX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
IHsNCj4gPiA+ID4gKwlzdHJ1Y3QgcGwzNTNfbmFuZF9pbmZvICp4bmZjOw0KPiA+ID4gPiArCXN0
cnVjdCBtdGRfaW5mbyAqbXRkOw0KPiA+ID4gPiArCXN0cnVjdCBuYW5kX2NoaXAgKmNoaXA7DQo+
ID4gPiA+ICsJc3RydWN0IHJlc291cmNlICpyZXM7DQo+ID4gPiA+ICsJc3RydWN0IGRldmljZV9u
b2RlICpucDsNCj4gPiA+ID4gKwl1MzIgcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJeG5mYyA9
IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKnhuZmMpLCBHRlBfS0VSTkVMKTsNCj4g
PiA+ID4gKwlpZiAoIXhuZmMpDQo+ID4gPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ID4gPiAr
CXhuZmMtPmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gPiA+ICsJLyogTWFwIHBoeXNpY2FsIGFkZHJl
c3Mgb2YgTkFORCBmbGFzaCAqLw0KPiA+ID4gPiArCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJj
ZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+ID4gPiA+ICsJeG5mYy0+bmFuZF9iYXNlID0g
ZGV2bV9pb3JlbWFwX3Jlc291cmNlKHhuZmMtPmRldiwgcmVzKTsNCj4gPiA+ID4gKwlpZiAoSVNf
RVJSKHhuZmMtPm5hbmRfYmFzZSkpDQo+ID4gPiA+ICsJCXJldHVybiBQVFJfRVJSKHhuZmMtPm5h
bmRfYmFzZSk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwljaGlwID0gJnhuZmMtPmNoaXA7DQo+ID4g
PiA+ICsJbXRkID0gbmFuZF90b19tdGQoY2hpcCk7DQo+ID4gPiA+ICsJY2hpcC0+ZXhlY19vcCA9
IHBsMzUzX25mY19leGVjX29wOw0KPiA+ID4gPiArCW5hbmRfc2V0X2NvbnRyb2xsZXJfZGF0YShj
aGlwLCB4bmZjKTsNCj4gPiA+ID4gKwltdGQtPnByaXYgPSBjaGlwOw0KPiA+ID4gPiArCW10ZC0+
b3duZXIgPSBUSElTX01PRFVMRTsNCj4gPiA+ID4gKwlpZiAoIW10ZC0+bmFtZSkgew0KPiA+ID4g
PiArCQkvKg0KPiA+ID4gPiArCQkgKiBJZiB0aGUgbmV3IGJpbmRpbmdzIGFyZSB1c2VkIGFuZCB0
aGUgYm9vdGxvYWRlciBoYXMgbm90IGJlZW4NCj4gPiA+ID4gKwkJICogdXBkYXRlZCB0byBwYXNz
IGEgbmV3IG10ZHBhcnRzIHBhcmFtZXRlciBvbiB0aGUgY21kbGluZSwgeW91DQo+ID4gPiA+ICsJ
CSAqIHNob3VsZCBkZWZpbmUgdGhlIGZvbGxvd2luZyBwcm9wZXJ0eSBpbiB5b3VyIE5BTkQgbm9k
ZSwgaWU6DQo+ID4gPiA+ICsJCSAqDQo+ID4gPiA+ICsJCSAqCWxhYmVsID0gInBsMzUzLW5hbmQi
Ow0KPiA+ID4gPiArCQkgKg0KPiA+ID4gPiArCQkgKiBUaGlzIHdheSwgbXRkLT5uYW1lIHdpbGwg
YmUgc2V0IGJ5IHRoZSBjb3JlIHdoZW4NCj4gPiA+ID4gKwkJICogbmFuZF9zZXRfZmxhc2hfbm9k
ZSgpIGlzIGNhbGxlZC4NCj4gPiA+ID4gKwkJICovDQo+ID4gPiA+ICsJCW10ZC0+bmFtZSA9IGRl
dm1fa2FzcHJpbnRmKHhuZmMtPmRldiwgR0ZQX0tFUk5FTCwNCj4gPiA+ID4gKwkJCQkJICAgIiVz
IiwgUEwzNTNfTkFORF9EUklWRVJfTkFNRSk7DQo+ID4gPiA+ICsJCWlmICghbXRkLT5uYW1lKSB7
DQo+ID4gPiA+ICsJCQlkZXZfZXJyKHhuZmMtPmRldiwgIkZhaWxlZCB0byBhbGxvY2F0ZSBtdGQt
Pm5hbWVcbiIpOw0KPiA+ID4gPiArCQkJcmV0dXJuIC1FTk9NRU07DQo+ID4gPiA+ICsJCX0NCj4g
PiA+ID4gKwl9DQo+ID4gPiA+ICsJbmFuZF9zZXRfZmxhc2hfbm9kZShjaGlwLCB4bmZjLT5kZXYt
Pm9mX25vZGUpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJLyogU2V0IGFkZHJlc3Mgb2YgTkFORCBJ
TyBsaW5lcyAqLw0KPiA+ID4gPiArCWNoaXAtPklPX0FERFJfUiA9IHhuZmMtPm5hbmRfYmFzZTsN
Cj4gPiA+ID4gKwljaGlwLT5JT19BRERSX1cgPSB4bmZjLT5uYW5kX2Jhc2U7DQo+ID4gPiA+ICsJ
LyogU2V0IHRoZSBkcml2ZXIgZW50cnkgcG9pbnRzIGZvciBNVEQgKi8NCj4gPiA+ID4gKwljaGlw
LT5kZXZfcmVhZHkgPSBwbDM1M19uYW5kX2RldmljZV9yZWFkeTsNCj4gPiA+ID4gKwljaGlwLT5z
ZWxlY3RfY2hpcCA9IHBsMzUzX25hbmRfc2VsZWN0X2NoaXA7DQo+ID4gPiA+ICsJLyogSWYgd2Ug
ZG9uJ3Qgc2V0IHRoaXMgZGVsYXkgZHJpdmVyIHNldHMgMjB1cyBieSBkZWZhdWx0ICovDQo+ID4g
PiA+ICsJbnAgPSBvZl9nZXRfbmV4dF9wYXJlbnQoeG5mYy0+ZGV2LT5vZl9ub2RlKTsNCj4gPiA+
ID4gKwl4bmZjLT5tY2xrID0gb2ZfY2xrX2dldChucCwgMCk7DQo+ID4gPiA+ICsJaWYgKElTX0VS
Uih4bmZjLT5tY2xrKSkgew0KPiA+ID4gPiArCQlkZXZfZXJyKHhuZmMtPmRldiwgIkZhaWxlZCB0
byByZXRyaWV2ZSBNQ0sgY2xrXG4iKTsNCj4gPiA+ID4gKwkJcmV0dXJuIFBUUl9FUlIoeG5mYy0+
bWNsayk7DQo+ID4gPiA+ICsJfQ0KPiA+ID4gPiArCWNoaXAtPmNoaXBfZGVsYXkgPSAzMDsNCj4g
PiA+ID4gKwkvKiBTZXQgdGhlIGRldmljZSBvcHRpb24gYW5kIGZsYXNoIHdpZHRoICovDQo+ID4g
PiA+ICsJY2hpcC0+b3B0aW9ucyA9IE5BTkRfQlVTV0lEVEhfQVVUTzsNCj4gPiA+ID4gKwljaGlw
LT5iYnRfb3B0aW9ucyA9IE5BTkRfQkJUX1VTRV9GTEFTSDsNCj4gPiA+ID4gKwlwbGF0Zm9ybV9z
ZXRfZHJ2ZGF0YShwZGV2LCB4bmZjKTsNCj4gPiA+ID4gKwljaGlwLT5zZXR1cF9kYXRhX2ludGVy
ZmFjZSA9IHBsMzUzX3NldHVwX2RhdGFfaW50ZXJmYWNlOw0KPiA+ID4gPiArCS8qIGZpcnN0IHNj
YW4gdG8gZmluZCB0aGUgZGV2aWNlIGFuZCBnZXQgdGhlIHBhZ2Ugc2l6ZSAqLw0KPiA+ID4gPiAr
CWlmIChuYW5kX3NjYW5faWRlbnQobXRkLCAxLCBOVUxMKSkgew0KPiA+ID4gPiArCQlkZXZfZXJy
KHhuZmMtPmRldiwgIm5hbmRfc2Nhbl9pZGVudCBmb3IgTkFORCBmYWlsZWRcbiIpOw0KPiA+ID4g
PiArCQlyZXR1cm4gLUVOWElPOw0KPiA+ID4gPiArCX0NCj4gDQo+IFNwYWNlIGhlcmUNCk9rLg0K
PiANCj4gPiA+ID4gKwlyZXQgPSBwbDM1M19uYW5kX2VjY19pbml0KG10ZCwgJmNoaXAtPmVjYywg
Y2hpcC0+ZWNjLm1vZGUpOw0KPiANCj4gcmV0IHNob3VsZCBiZSBjaGVja2VkDQpPay4NCj4gDQo+
ID4gPiA+ICsJaWYgKGNoaXAtPm9wdGlvbnMgJiBOQU5EX0JVU1dJRFRIXzE2KQ0KPiA+ID4gPiAr
CQlwbDM1M19zbWNfc2V0X2J1c3dpZHRoKFBMMzUzX1NNQ19NRU1fV0lEVEhfMTYpOw0KPiANCj4g
U3BhY2UNCk9rLg0KPiANCj4gPiA+ID4gKwkvKiBzZWNvbmQgcGhhc2Ugc2NhbiAqLw0KPiA+ID4g
PiArCWlmIChuYW5kX3NjYW5fdGFpbChtdGQpKSB7DQo+ID4gPiA+ICsJCWRldl9lcnIoeG5mYy0+
ZGV2LCAibmFuZF9zY2FuX3RhaWwgZm9yIE5BTkQgZmFpbGVkXG4iKTsNCj4gPiA+ID4gKwkJcmV0
dXJuIC1FTlhJTzsNCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwltdGRfZGV2aWNl
X3JlZ2lzdGVyKG10ZCwgTlVMTCwgMCk7DQo+ID4gPg0KPiA+ID4gQ2hlY2sgdGhlIHJldHVybmVk
IGNvZGUNCj4gPiBPay4NCj4gDQo+IEFuZCBpZiBpdCByZXR1cm5zIGFuIGVycm9yLCBwbGVhc2Ug
Y2FsbCBuYW5kX2NsZWFudXAoKS4NCk9rLCBJIHdpbGwgdXBkYXRlIGl0Lg0KPiANCj4gPiA+DQo+
ID4gPiA+ICsNCj4gPiA+ID4gKwlyZXR1cm4gMDsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+
ID4gPiArLyoqDQo+ID4gPiA+ICsgKiBwbDM1M19uYW5kX3JlbW92ZSAtIFJlbW92ZSBtZXRob2Qg
Zm9yIHRoZSBOQU5EIGRyaXZlcg0KPiA+ID4gPiArICogQHBkZXY6CVBvaW50ZXIgdG8gdGhlIHBs
YXRmb3JtX2RldmljZSBzdHJ1Y3R1cmUNCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBUaGlzIGZ1
bmN0aW9uIGlzIGNhbGxlZCBpZiB0aGUgZHJpdmVyIG1vZHVsZSBpcyBiZWluZw0KPiA+ID4gPiAr
dW5sb2FkZWQuIEl0IGZyZWVzIGFsbA0KPiA+ID4gPiArICogcmVzb3VyY2VzIGFsbG9jYXRlZCB0
byB0aGUgZGV2aWNlLg0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIFJldHVybjoJMCBvbiBzdWNj
ZXNzIG9yIGVycm9yIHZhbHVlIG9uIGZhaWx1cmUNCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiArc3Rh
dGljIGludCBwbDM1M19uYW5kX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7
DQo+ID4gPiA+ICsJc3RydWN0IHBsMzUzX25hbmRfaW5mbyAqeG5mYyA9IHBsYXRmb3JtX2dldF9k
cnZkYXRhKHBkZXYpOw0KPiA+ID4gPiArCXN0cnVjdCBtdGRfaW5mbyAqbXRkID0gbmFuZF90b19t
dGQoJnhuZmMtPmNoaXApOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJLyogUmVsZWFzZSByZXNvdXJj
ZXMsIHVucmVnaXN0ZXIgZGV2aWNlICovDQo+ID4gPiA+ICsJbmFuZF9yZWxlYXNlKG10ZCk7DQo+
ID4gPg0KPiA+ID4gV2hhdCBhYm91dCBNVEQgY29yZSBkZXJlZ2lzdHJhdGlvbj8NCj4gPiBuYW5k
X3JlbGVhc2UoKSwgaXQgc2VsZiB3aWxsIGRvIHRoYXQuDQo+IA0KPiBNeSBiYWQuDQo+IA0KPiA+
ID4NCj4gPiA+ID4gKw0KPiA+ID4gPiArCXJldHVybiAwOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiAr
DQo+ID4gPiA+ICsvKiBNYXRjaCB0YWJsZSBmb3IgZGV2aWNlIHRyZWUgYmluZGluZyAqLyBzdGF0
aWMgY29uc3Qgc3RydWN0DQo+ID4gPiA+ICtvZl9kZXZpY2VfaWQgcGwzNTNfbmFuZF9vZl9tYXRj
aFtdID0gew0KPiA+ID4gPiArCXsgLmNvbXBhdGlibGUgPSAiYXJtLHBsMzUzLW5hbmQtcjJwMSIg
fSwNCj4gPiA+ID4gKwl7fSwNCj4gPiA+ID4gK307DQo+IA0KPiBUaGFua3MsDQo+IE1pcXXDqGwN
Cg0KVGhhbmtzLA0KTmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0K
