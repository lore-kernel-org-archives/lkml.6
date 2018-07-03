Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C28C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE594205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ddB+JSYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE594205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753718AbeGCETG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 00:19:06 -0400
Received: from mail-eopbgr720058.outbound.protection.outlook.com ([40.107.72.58]:26688
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751237AbeGCETE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 00:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRJfVEKyTryvvnc+g3hb+gFIwbiBz/RsX2rKB9lT9Lk=;
 b=ddB+JSYbFVOL3jm3Cq0H6QenenWs23IL47DySqLAX1GFC1cwHdFTUXZigt6hLcSyr1cnTjIKm8Epf3IqWaDdQNgW0Y8YzsEhXCCQF1pZ9zoYmaD4KIcRGT+mcZbCIgDnAk+rVFamlbsLh0pCen1YoYrLdPJEHveraREJOuxDEGI=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3184.namprd02.prod.outlook.com (10.164.133.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Tue, 3 Jul 2018 04:19:03 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b%8]) with mapi id 15.20.0906.026; Tue, 3 Jul 2018
 04:19:01 +0000
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
Subject: RE: [[LINUX PATCH v10] 4/4] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Thread-Topic: [[LINUX PATCH v10] 4/4] mtd: rawnand: pl353: Add basic driver
 for arm pl353 smc nand interface
Thread-Index: AQHUCSslFhIqNZ8rp0qjyj+1AxTyIaR1VRMAgABKm0CAAGVwgIAApGBggAVaqgCAAPMrcA==
Date:   Tue, 3 Jul 2018 04:19:00 +0000
Message-ID: <MWHPR02MB26231E0F420D423E60196452AF420@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1529563351-2241-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <CACRpkdaEsEAiGpieJK1AA8HHLzZc7Tdc932rhdayg06rFU1hNA@mail.gmail.com>
 <MWHPR02MB26232270DED605627B2CF22FAF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <CACRpkdZb6NMHtai1DBa+7m2ieZJZiAB7d1vSuP376rHQKpOf+A@mail.gmail.com>
 <MWHPR02MB26239876530B0F5C95289A56AF4E0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <CACRpkdZp+8ZFRF2c+pAy47ZSWjavu3Qo5fz6A41zDty444MWCg@mail.gmail.com>
In-Reply-To: <CACRpkdZp+8ZFRF2c+pAy47ZSWjavu3Qo5fz6A41zDty444MWCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3184;7:SZUS0cLmvHTZYSUr83h67S2gR32LKjqvnkKroeZm/VkYBY91QonNDmnMpwpjnPFJc5QJyWb4gPpx/T8DZcnZQgK0+vJIodgUgGSQXds1dBlR8+bJYd5RKvDjjLNEurxgpHjGSa+eP2dfH4VVJjSA+oamcU7B+waX/fZ3cseCyVUzEFhwPWasxkfsA9mvyQnhUtTz5L2vBV7bXl36fx8s3Kayzy92A7V1PZ41nkZujAcNGCT4n1FqtBXtH9fjllmj
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(396003)(136003)(13464003)(57704003)(189003)(199004)(478600001)(53936002)(33656002)(66066001)(6116002)(97736004)(99286004)(5660300001)(8936002)(25786009)(81166006)(93886005)(81156014)(316002)(54906003)(8676002)(3846002)(39060400002)(7736002)(74316002)(6246003)(305945005)(2900100001)(107886003)(4326008)(26005)(9686003)(55016002)(6506007)(14454004)(5250100002)(76176011)(6436002)(86362001)(2906002)(6346003)(476003)(102836004)(53546011)(11346002)(446003)(55236004)(6916009)(105586002)(7416002)(68736007)(7696005)(486006)(14444005)(229853002)(256004)(106356001)(186003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3184;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: b0cfbfb3-f8de-4844-97f1-08d5e09c1aaf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3184;
x-ms-traffictypediagnostic: MWHPR02MB3184:
x-microsoft-antispam-prvs: <MWHPR02MB3184D5EE58C903F87A54F7FFAF420@MWHPR02MB3184.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB3184;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3184;
x-forefront-prvs: 0722981D2A
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-microsoft-antispam-message-info: ZELXdmlG92M7OMCuRk1R2NYLLl+LuRuWwwW3xRR7l3p5tV6GVxC5YLLkDD7Jkbau6f2dT6e5P7kexS0IUUKXGjSFdDxNxvqGn/gJsv9Abk2QSyNg5ukykvRxoM2ckbv5wkGsqZx2/r9Z8kDy2cYlbyQ5P+QfDYdKbV42olEjARYazMLxMRdn9Znt6rYqXK13XX5bHDqAQZUPYuN8cBtx12Gl58aSpAwP+rrl46TomQBWs1TDENY+q435cYCXFfsadm3txCgFUZ+805Gi0zbWrGLUWihd++e8lDtI8Flrz6X0L1fOQZ+ClvS8uCxr1JHXUXjxjflASmdInwYWd1r2Ld8UFxD5eMh+VYme5J14B8E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cfbfb3-f8de-4844-97f1-08d5e09c1aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2018 04:19:00.8827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXMg
V2FsbGVpaiBbbWFpbHRvOmxpbnVzLndhbGxlaWpAbGluYXJvLm9yZ10NCj4gU2VudDogTW9uZGF5
LCBKdWx5IDIsIDIwMTggNzoxOCBQTQ0KPiBUbzogTmFnYSBTdXJlc2hrdW1hciBSZWxsaSA8bmFn
YXN1cmVAeGlsaW54LmNvbT4NCj4gQ2M6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9u
QGJvb3RsaW4uY29tPjsgUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD47DQo+IERh
dmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz47IEJyaWFuIE5vcnJpcw0KPiA8Y29t
cHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tPjsgTWFyayBWYXN1dCA8bWFyZWsudmFzdXRAZ21haWwu
Y29tPjsgRmxvcmlhbiBGYWluZWxsaQ0KPiA8Zi5mYWluZWxsaUBnbWFpbC5jb20+OyBNYXJrdXMg
TWF5ZXIgPG1tYXllckBicm9hZGNvbS5jb20+OyBSb2dlciBRdWFkcm9zDQo+IDxyb2dlcnFAdGku
Y29tPjsgTGFkaXNsYXYgTWljaGwgPGxhZGlzQGxpbnV4LW1pcHMub3JnPjsgYWRhQHRob3JzaXMu
Y29tOw0KPiBob25naHVpLnpoYW5nQG1lZGlhdGVrLmNvbTsgTWlxdcOobCBSYXluYWwgPG1pcXVl
bC5yYXluYWxAYm9vdGxpbi5jb20+OyBsaW51eC0NCj4gbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5hZ2FzdXJlc2hrdW1hcnJlbGxpQGdtYWls
LmNvbTsNCj4gTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbW0xJTlVYIFBBVENIIHYxMF0gNC80XSBtdGQ6IHJhd25hbmQ6IHBsMzUzOiBBZGQgYmFzaWMg
ZHJpdmVyIGZvciBhcm0NCj4gcGwzNTMgc21jIG5hbmQgaW50ZXJmYWNlDQo+IA0KPiBPbiBGcmks
IEp1biAyOSwgMjAxOCBhdCA2OjE1IEFNIE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJl
QHhpbGlueC5jb20+IHdyb3RlOg0KPiA+ID4gT24gVGh1LCBKdW4gMjgsIDIwMTggYXQgMjoxMyBQ
TSBOYWdhIFN1cmVzaGt1bWFyIFJlbGxpIDxuYWdhc3VyZUB4aWxpbnguY29tPg0KPiB3cm90ZToN
Cj4gPiA+DQo+ID4gPg0KPiA+ID4gPiA+IFRoaXMgZHJpdmVyIGhhcyB0aGUgc2FtZSBwcm9ibGVt
IGFzIHRoZSBvdGhlciBwYXRjaGVzOg0KPiA+ID4gPiA+IHVzZSB0aGUgQVJNX0FNQkEgcHJpbWVj
ZWxsIG1hZ2ljIG51bWJlcnMgZGV0ZWN0aW9uLCBhbmQgdGhlIFByaW1lQ2VsbCBidXMuDQo+ID4g
PiA+DQo+ID4gPiA+IEhlcmUgdGhlIGNoaWxkIGlzIE5BTkQgY29udHJvbGxlciBhbmQgdGhlIHBh
cmVudCBpcyBQTDM1MyBTTUMsIHNvDQo+ID4gPiA+IGRvIHdlIG5lZWQgdG8gdXBkYXRlIHRoaXMg
YWxzbyBhcyBBTUJBIGRyaXZlcj8NCj4gPiA+DQo+ID4gPiBObywgc29ycnkuIFRoZSBwYXJlbnQg
aXMgc3Bhd25pbmcgYW5vdGhlciBkZXZpY2UgYW5kIHlvdSBzaG91bGQNCj4gPiA+IGluZGVlZCB1
c2UgYSBwbGF0Zm9ybSBkZXZpY2UgZm9yIHRoYXQuDQo+ID4gPg0KPiA+IE9rLCB5b3UgbWVhbiBw
bGF0Zm9ybSBkcml2ZXIgbW9kZWwgaXMgc3VmZmljaWVudCBmb3IgYm90aCBwbDM1My1zbWMuYyBh
bmQgcGwzNTNfbmFuZC5jDQo+IGRyaXZlcnM/DQo+ID4gT3IgQU1CQSBtb2RlbCBpcyBmb3IgcGwz
NTMtc21jIGFuZCBwbGF0Zm9ybSBkcml2ZXIgbW9kZWwgaXMgZm9yIHBsMzUzLW5hbmQ/DQo+IA0K
PiBUaGUgbGF0dGVyLCBBTUJBIHByaW1lY2VsbCBidXMgZm9yIHBsMzUzLXNtYyBhbmQgcGxhdGZv
cm0gZGV2aWNlIGZvciB0aGUgbmFuZCBzdWJkZXZpY2UuDQo+IA0KPiBQbGF0Zm9ybSBkZXZpY2Ug
aXMgZm9yIGFueXRoaW5nIHRoYXQgY2Fubm90IGJlIGF1dG9kZXRlY3RlZCB3aXRoIGUuZy4NCj4g
bWFnaWMgaGFyZGFyZSBudW1iZXJzLCBhbmQgdGhlIGZpcnN0IGRldmljZSBjYW4gYmUgYXV0b2Rl
dGVjdGVkIGFzIGEgcHJpbWUgY2VsbCBidXQgbm90IHRoZQ0KPiBzdWJkZXZpY2UuDQpUaGFua3Mg
Zm9yIHlvdXIgaW5wdXRzLCBJIGFscmVhZHkgc3RhcnRlZCB1cGRhdGluZyB0aGlzLg0KSSB3aWxs
IHNlbmQgdjExLg0KDQpUaGFua3MsDQpOYWdhIFN1cmVzaGt1bWFyIFJlbGxpLg0KPiANCj4gWW91
cnMsDQo+IExpbnVzIFdhbGxlaWoNCg==
