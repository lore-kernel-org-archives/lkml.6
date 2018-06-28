Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84734C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3292227092
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="x0WaD0kE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3292227092
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934556AbeF1H5C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:57:02 -0400
Received: from mail-sn1nam02on0062.outbound.protection.outlook.com ([104.47.36.62]:27472
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934055AbeF1H5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMGd3W/mrx5sqLmF0dxs9Et8JZ6oA9BICpQ+Ov2J1Ek=;
 b=x0WaD0kEmdPRAQY4/1CdKDx/AmhSPDqOz00eLAHVhojssOhHPL4/Wn/80QgwarBculicUKt+VOPdLx/q/9zhPJNJMFCi8H5YnAodkoxdWBQ9s8fXnqM9o4wOY/U1XdBm58IiJPzNd99L5VayxkgGYpDhwVIEyWAOhA/AWqvE2RM=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2880.namprd02.prod.outlook.com (10.175.50.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Thu, 28 Jun 2018 07:56:57 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b%8]) with mapi id 15.20.0884.025; Thu, 28 Jun 2018
 07:56:56 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        =?utf-8?B?TWlxdcOobCBSYXluYWw=?= <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [[LINUX PATCH v10] 1/4] Devicetree: Add pl353 smc controller
 devicetree binding information
Thread-Topic: [[LINUX PATCH v10] 1/4] Devicetree: Add pl353 smc controller
 devicetree binding information
Thread-Index: AQHUCSscPFU/PMrwLUOEuJ/raMMjQaR1R0EAgAAQUaA=
Date:   Thu, 28 Jun 2018 07:56:55 +0000
Message-ID: <MWHPR02MB2623D909645D0AEB426C205CAF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1529563351-2241-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <CACRpkdaX8KrZ=3GwFUje05kYV61bRfTSJQ9fCQwVk5ot3cxvpQ@mail.gmail.com>
In-Reply-To: <CACRpkdaX8KrZ=3GwFUje05kYV61bRfTSJQ9fCQwVk5ot3cxvpQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2880;7:jp5BG7uFhMoxDOSrPmib+qW/kzDqDkTbNq8GGwiCxa/qQHM3v/2eYmMi6bxAtRwJe9GUZJX8rnV0lGBUv9iq6rnt1KAvQQKfwSmcmxe/irxGXLJlUZwge6s4VTEuifcjAnTi1Z3+/7TeGoWarT4PgenqqHhrpkOwOBmd/pXOTuA0d+c1XDZJlYWNdm+pd4dH0QTaBZArIoJpxKGdhv6FcS4EYlLyRDZg0TwaVxI00xfeUVjyHcXcQ7O5hkeqaKhC
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(51914003)(199004)(13464003)(189003)(99286004)(476003)(2900100001)(11346002)(446003)(186003)(33656002)(486006)(102836004)(3846002)(6116002)(9686003)(14454004)(6436002)(55016002)(4326008)(53936002)(97736004)(86362001)(76176011)(55236004)(54906003)(6506007)(53546011)(14444005)(26005)(25786009)(39060400002)(316002)(6246003)(256004)(107886003)(81166006)(7416002)(305945005)(7736002)(7696005)(478600001)(5660300001)(229853002)(5250100002)(105586002)(106356001)(8676002)(6916009)(66066001)(81156014)(8936002)(2906002)(68736007)(74316002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2880;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 22646da1-e9bf-4733-f0be-08d5dcccb7f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2880;
x-ms-traffictypediagnostic: MWHPR02MB2880:
x-microsoft-antispam-prvs: <MWHPR02MB2880BF24F12C4A946F085334AF4F0@MWHPR02MB2880.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2880;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2880;
x-forefront-prvs: 0717E25089
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dPb6EMMCipfvrgxMg1rVDY7T9G+b/5cYfXi5aFkfNbWCVHTb0OB9mlOJsNoclwlfAAsui4be9aOv9EshH6dm9Jh5Sj8aIsxC20FHpa5BuQovMR/QEH8ekbr9D52C8nsQiq8nbdrwBMwVdWk+1feO4v8k1MfCJjMTBy9u/Vr7S8+ThKQZdMQ90R7k3GKIi4LIW3hkFidktfyO16c2yM8FyfAlEcmNDO1UP5SPpvkqjbXCKDViDrM+ES3BDJW87niGJOTUcOREnpS1bgKs38/IoQ5L7uSskLYdBeoZB4PP+kGlQ4ZddcuiBX8XNaWQm4EcKvTBFf8hDt3NB9QuE3JVS9s7d06Swq//GvUvdNW83pg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22646da1-e9bf-4733-f0be-08d5dcccb7f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 07:56:55.9089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2880
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBXYWxsZWlqIFttYWlsdG86bGludXMud2FsbGVpakBs
aW5hcm8ub3JnXQ0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAyOCwgMjAxOCAxMjoyNCBQTQ0KPiBU
bzogTmFnYSBTdXJlc2hrdW1hciBSZWxsaSA8bmFnYXN1cmVAeGlsaW54LmNvbT4NCj4gQ2M6IEJv
cmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPjsgUmljaGFyZCBXZWlu
YmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD47DQo+IERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFk
ZWFkLm9yZz47IEJyaWFuIE5vcnJpcw0KPiA8Y29tcHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tPjsg
TWFyayBWYXN1dCA8bWFyZWsudmFzdXRAZ21haWwuY29tPjsgRmxvcmlhbiBGYWluZWxsaQ0KPiA8
Zi5mYWluZWxsaUBnbWFpbC5jb20+OyBNYXJrdXMgTWF5ZXIgPG1tYXllckBicm9hZGNvbS5jb20+
OyBSb2dlciBRdWFkcm9zDQo+IDxyb2dlcnFAdGkuY29tPjsgTGFkaXNsYXYgTWljaGwgPGxhZGlz
QGxpbnV4LW1pcHMub3JnPjsgYWRhQHRob3JzaXMuY29tOw0KPiBob25naHVpLnpoYW5nQG1lZGlh
dGVrLmNvbTsgTWlxdcOobCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+OyBsaW51
eC0NCj4gbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IG5hZ2FzdXJlc2hrdW1hcnJlbGxpQGdtYWlsLmNvbTsNCj4gTWljaGFsIFNpbWVrIDxtaWNo
YWxzQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbW0xJTlVYIFBBVENIIHYxMF0gMS80XSBE
ZXZpY2V0cmVlOiBBZGQgcGwzNTMgc21jIGNvbnRyb2xsZXIgZGV2aWNldHJlZQ0KPiBiaW5kaW5n
IGluZm9ybWF0aW9uDQo+IA0KPiBPbiBUaHUsIEp1biAyMSwgMjAxOCBhdCA4OjQzIEFNIE5hZ2Eg
U3VyZXNoa3VtYXIgUmVsbGkNCj4gPG5hZ2Euc3VyZXNoa3VtYXIucmVsbGlAeGlsaW54LmNvbT4g
d3JvdGU6DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+IEFkZCBwbDM1MyBz
dGF0aWMgbWVtb3J5IGNvbnRyb2xsZXIgZGV2aWNldHJlZSBiaW5kaW5nIGluZm9ybWF0aW9uLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0KPiA+IDxuYWdh
LnN1cmVzaGt1bWFyLnJlbGxpQHhpbGlueC5jb20+DQo+ID4gK0RldmljZSB0cmVlIGJpbmRpbmdz
IGZvciBBUk0gUEwzNTMgc3RhdGljIG1lbW9yeSBjb250cm9sbGVyDQo+ID4gKw0KPiA+ICtQTDM1
MyBzdGF0aWMgbWVtb3J5IGNvbnRyb2xsZXIgc3VwcG9ydHMgdHdvIGtpbmRzIG9mIG1lbW9yeQ0K
PiA+ICtpbnRlcmZhY2VzLmkuZSBOQU5EIGFuZCBTUkFNL05PUiBpbnRlcmZhY2VzLg0KPiA+ICtU
aGUgYWN0dWFsIGRldmljZXMgYXJlIGluc3RhbnRpYXRlZCBmcm9tIHRoZSBjaGlsZCBub2RlcyBv
ZiBwbDM1MyBzbWMgbm9kZS4NCj4gDQo+IFNlZSBhbmQgcmVmZXJlbmNlIHRoZSBzcGVjaWFsIFBy
aW1lQ2VsbCBEVCBiaW5kaW5nczoNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2FybS9wcmltZWNlbGwudHh0DQo+IA0KPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICst
IGNvbXBhdGlibGUgICAgICAgICAgIDogTXVzdCBiZSAiYXJtLHBsMzUzLXNtYy1yMnAxIg0KPiAN
Cj4gU2hvdWxkIGJlOg0KPiANCj4gImFybSxwbDM1My1zbWMtcjJwMSIsICJhcm0scHJpbWVjZWxs
IjsNCj4gDQo+IEl0IHdpbGwgYmUgcG9zc2libGUgZm9yIHRoZSBMaW51eCBBTUJBIGNvcmUgdG8g
cHJvYmUgdGhlIGRldmljZSBmcm9tIGp1c3QgcmVhZGluZyBvdXQgdGhlDQo+IHByaW1lY2VsbCBJ
RCByZWdpc3RlcnMsIHNvIHRoZSBmaXJzdCBjb21wYXRpYmxlIHN0cmluZyB3aWxsIG5vdCBldmVu
IGJlIHVzZWQgYnkgbWFueSBPUzplcy4NClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhlIHByaW1lY2Vs
bC50eHQsIHdpbGwgYXBwZW5kIHRoZSAiYXJtLHByaW1lY2VsbCIgZW50cnkgaW4gbmV4dCB2ZXJz
aW9uLg0KPiANCj4gPiArLSByZWcgICAgICAgICAgICAgICAgICA6IENvbnRyb2xsZXIgcmVnaXN0
ZXJzIG1hcCBhbmQgbGVuZ3RoLg0KPiA+ICstIGNsb2NrLW5hbWVzICAgICAgICAgIDogTGlzdCBv
ZiBpbnB1dCBjbG9jayBuYW1lcyAtICJyZWZfY2xrIiwgImFwZXJfY2xrIg0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgKFNlZSBjbG9jayBiaW5kaW5ncyBmb3IgZGV0YWlscykuDQo+IA0K
PiBUaGUgQU1CQSBwcmltZWNlbGwgcGVyaXBoZXJhbCBjbG9jayAoY2xvY2tpbmcgdGhlIHNpbGlj
b24pIG11c3QgYmUgbmFtZWQgImFwYl9wY2xrIi4NCk9rLCB3aWxsIHVwZGF0ZSBpbiBuZXh0IHZl
cnNpb24uDQo+IA0KPiA+ICstIGNsb2NrcyAgICAgICAgICAgICAgIDogQ2xvY2sgcGhhbmRsZXMg
KHNlZSBjbG9jayBiaW5kaW5ncyBmb3IgZGV0YWlscykuDQo+ID4gKy0gYWRkcmVzcy1jZWxscyAg
ICAgICAgICAgICAgICA6IE11c3QgYmUgMS4NCj4gPiArLSBzaXplLWNlbGxzICAgICAgICAgICA6
IE11c3QgYmUgMS4NCj4gPiArDQo+ID4gK0NoaWxkIG5vZGVzOg0KPiA+ICsgRm9yIE5BTkQgdGhl
ICJhcm0scGwzNTMtbmFuZC1yMnAxIiBhbmQgZm9yIE5PUiB0aGUgImNmaS1mbGFzaCINCj4gPiAr
ZHJpdmVycyBhcmUgc3VwcG9ydGVkIGFzIGNoaWxkIG5vZGVzLg0KPiA+ICsNCj4gPiArZm9yIE5B
TkQgcGFydGl0aW9uIGluZm9ybWF0aW9uIHBsZWFzZSByZWZlciB0aGUgYmVsb3cgZmlsZQ0KPiA+
ICtEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL3BhcnRpdGlvbi50eHQNCj4g
PiArDQo+ID4gK0V4YW1wbGU6DQo+ID4gKyAgICAgICBzbWNjOiBtZW1vcnktY29udHJvbGxlckBl
MDAwZTAwMA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLHBs
MzUzLXNtYy1yMnAxIg0KPiANCj4gQWRkICwgImFybSxwcmltZWNlbGwiOw0KT2suIFdpbGwgdXBk
YXRlIGluIG5leHQgdmVyc2lvbi4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xv
Y2stbmFtZXMgPSAibWVtY2xrIiwgImFjbGsiOw0KPiANCj4gVGhpcyBkb2Vzbid0IGV2ZW4gaGF2
ZSB0aGUgc2FtZSBuYW1lIGFzIGluIHRoZSBiaW5kaW5ncyBhYm92ZSwgSSB0aGluayB0aGUgbGF0
dGVyIHNob3VsZCBiZQ0KPiBuYW1lZCAiYXBiX3BjbGsiLg0KT2ssIGl04oCZcyBhIG1pc3Rha2Us
IEkgd2lsbCBjb3JyZWN0IGl0IGluIG5leHQgdmVyc2lvbi4NCj4gDQo+IE90aGVyd2lzZSBpdCBs
b29rcyBnb29kIQ0KPiANCj4gWW91cnMsDQo+IExpbnVzIFdhbGxlaWoNCg0KVGhhbmtzIGZvciB5
b3VyIHJldmlldy4NCg0KVGhhbmtzLA0KTmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0K
