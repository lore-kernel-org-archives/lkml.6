Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22597C4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17302148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mwlDdRYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfA1GFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:05:02 -0500
Received: from mail-eopbgr760084.outbound.protection.outlook.com ([40.107.76.84]:65312
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfA1GFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7BnbkVS32Q46FjJbXM+qcCMA9I2QuOsewKSmY1HTmA=;
 b=mwlDdRYngAnbuG1klr2WFB3D9dAITyTaKwhb2l9qLktYeLs/gF4KsJEWrzVPHQoCQttLeHk4SyBzSViuSpLzAZdV8z93u55rkkU1Ec8owrI6ugSYN0SDgv6l5XUnNFtaer2OXdVQxbW9C2L3tzOfu4mEJaCwD4hH0ZDZIBlE6XY=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3358.namprd02.prod.outlook.com (10.164.187.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Mon, 28 Jan 2019 06:04:53 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::d587:e08c:61f5:7aae]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::d587:e08c:61f5:7aae%5]) with mapi id 15.20.1558.021; Mon, 28 Jan 2019
 06:04:53 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "martin.lund@keep-it-simple.com" <martin.lund@keep-it-simple.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: RE: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUd+lSRlJXewM/lk6msOyQbhKEh6VQmgMggAVkGQCAAK7ewIAAH7YAgAFcNKCAAGhpAIAAGiwAgATHTPCAHUh8EIAAOYWAgAAN+ACAAAI3gIAAQgWwgAADhoCAB72ScIAAVsEAgADHyzCAAjdOgIACr13ggDn7tyA=
Date:   Mon, 28 Jan 2019 06:04:53 +0000
Message-ID: <MWHPR02MB262328DF62906C01DCDF18E5AF960@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <MWHPR02MB2623AAEC160F40F061E23194AFD80@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181119090246.49060019@bbrezillon>
 <BN6PR02MB2610C7D048E4A192E041BE14AFD90@BN6PR02MB2610.namprd02.prod.outlook.com>
 <20181120120244.7d2442b5@bbrezillon>   <20181120133624.3fa4742d@xps13>
 <MWHPR02MB26238A2271B33470ABFA1023AFD40@MWHPR02MB2623.namprd02.prod.outlook.com>
 <MWHPR02MB26239C2B2A7050310BEF1E9CAFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181212091135.1d0cc9a6@xps13>
 <MWHPR02MB26236CEF8A2110B20C825198AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181212100931.149b0cac@xps13>
 <MWHPR02MB2623EDA15BE59304795F3034AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181212141825.69711c57@xps13>
 <MWHPR02MB26235AE6567A06EF4C6362E6AFBC0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181217174114.24196d17@xps13>
 <MWHPR02MB26237B932D7F3CCEE0476FE0AFBD0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181219152647.76f77711@xps13>
 <MWHPR02MB262396FFF946A95D7821D61BAFB80@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB262396FFF946A95D7821D61BAFB80@MWHPR02MB2623.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3358;6:QT+qOcL8/nAhSdJTdK98J4MEpfgXcXYwHNnEgs/oKNtM15cqF6JYwFJfSZmNFUkW0CMm4wHTvrB/2KHi/D+8KSY3gFHDhMtI7hvA4IrO0Y5Kn5O5rUTCLaai2G0UPQsNzOtWE37xhhdFfT67kXnZ35a0Jbl59GVTPnnLqo6n8FuI9yGL/Ho/FrCx3CSYUstewS18LPnU6sh1Rm88Vz5u9MZ7/ClFN0jqMN/w5JridIzWSM0Z7o7XVPHIvr9qst7aFaTzVBSVWwsbrF64bLtAzICos4MbHqprFEsj9bl0BNECd27WUj8sf0AQsmjUdsvuUCnORCdpS1BUaVpW/4x0N3RM5DsKixvaAoQ9e51Sbk3N1DzIFHT/B4HLtPDyORwpmVF+Kv59rXx/LWq8gzQwvM2IwzCfRTByywOnOQZCF3IPZhXjwGWL0r4wRcAa7jpkdZNLkOnAmevDjz+Etul/QQ==;5:4qBesj/HmCMHnAGM9MbqYtCrcWOP2GkhYpZqaVXwbgLkCBFUzS1w6jfj/1JlmU3cv1KgGVd7LeHGMd1LklVtO6wYTUV/d5jlTNFxoAdGGZ4wKvu0V1frJsyisiy3nq0E8WruXGqJdOeU+JntjH1U7j5hkAW+EfgZuzdBOzMVyjnTw7GD9/qpfWIl1KzlhZtSfL72p2Cv4K96pxMFj7p5eg==;7:rByftN3EgvdQXRSRCTc/9VK5MG5DQbR9Is6VV5IIEjjSOvHtH2RSjSjMdRiyfsWblj3HozF39LEvpHXveVdpTIB/5K2OtAqVz+91Sd3Ep6OavnwMkQsg9LgVYuBZvtbldILSdggPaWE28FlSgv8hDw==
x-ms-office365-filtering-correlation-id: 39d83d9d-df2c-4a51-8f18-08d684e685a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3358;
x-ms-traffictypediagnostic: MWHPR02MB3358:
x-microsoft-antispam-prvs: <MWHPR02MB3358DC774485FFDC6126B8D6AF960@MWHPR02MB3358.namprd02.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(136003)(396003)(189003)(13464003)(199004)(33656002)(55016002)(186003)(14444005)(7736002)(476003)(446003)(11346002)(6246003)(39060400002)(6436002)(9686003)(6306002)(99286004)(14454004)(486006)(7416002)(53936002)(256004)(110136005)(54906003)(316002)(74316002)(53546011)(93886005)(68736007)(6506007)(86362001)(8936002)(6116002)(3846002)(97736004)(76176011)(25786009)(7696005)(66574012)(305945005)(66066001)(26005)(4326008)(105586002)(217873002)(478600001)(2906002)(81166006)(71200400001)(81156014)(229853002)(102836004)(106356001)(71190400001)(966005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3358;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n3+DnLIhrGmUWdGaqhQNWE/9nkFn4Ce/dkGwEXIDWiGfAnBck/9RCUdZQVOsnC+y1fgWwUWCN2eF+lV0fhtCst+dkT3chiInrJzi6Urg91RVmOVBXbdtOBJR5NPHUccmKNKy/Yfk3ni8sBvpVD6tDcXjKe1x6oY/tkU5KxhKPL1UDY3xjwzwd1lnNcHMtYDHTaGKuQMvbqOPj+GvIdi76xMEwc3PBRX8rzOfzqbxjpifWZ5Xkea+Ef8DdOoK382j8YeVutk3+rxKdl5SIoGJKiX15cS5HOKB4VviijAy8+3CP0dsx7fV9sskEL2emNgd+Bj7NSfBVZq6KkgxnsKQQiBR3HFLLE3E1xbQL4dMB7QtvlGMgmFoe6lI8486gBxb78W3fqbcslPA183ecyqTh/XTvLZ8/YhZ84gLBBoiiac=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d83d9d-df2c-4a51-8f18-08d684e685a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 06:04:53.7271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3358
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMgJiBNaXF1ZWwsDQoNCkNvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSB5b3VyIHRob3Vn
aHRzIG9uIHRoaXMgZHJpdmVyIHRvIHN1cHBvcnQgSFctRUNDPw0KQXMgSSBzYWlkIHByZXZpb3Vz
bHksIHRoZXJlIGlzIG5vIHdheSB0byBkZXRlY3QgZXJyb3JzIGJleW9uZCBOIGJpdC4NCkkgYW0g
b2sgdG8gdXBkYXRlIHRoZSBkcml2ZXIgYmFzZWQgb24geW91ciBpbnB1dHMuDQoNClRoYW5rcywN
Ck5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBsaW51eC1tdGQgW21haWx0bzpsaW51eC1tdGQtYm91bmNlc0BsaXN0cy5pbmZyYWRl
YWQub3JnXSBPbiBCZWhhbGYgT2YgTmFnYQ0KPiBTdXJlc2hrdW1hciBSZWxsaQ0KPiBTZW50OiBG
cmlkYXksIERlY2VtYmVyIDIxLCAyMDE4IDE6MDYgUE0NCj4gVG86IE1pcXVlbCBSYXluYWwgPG1p
cXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IENjOiByb2JoQGtlcm5lbC5vcmc7IG1hcmVrLnZh
c3V0QGdtYWlsLmNvbTsgcmljaGFyZEBub2QuYXQ7IG1hcnRpbi5sdW5kQGtlZXAtaXQtDQo+IHNp
bXBsZS5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEJvcmlzIEJyZXppbGxvbiA8
Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPjsNCj4gbGludXgtbXRkQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IG5hZ2FzdXJlc2gxMkBnbWFpbC5jb207IE1pY2hhbCBTaW1law0KPiA8bWljaGFsc0B4
aWxpbnguY29tPjsgY29tcHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tOyBkd213MkBpbmZyYWRlYWQu
b3JnDQo+IFN1YmplY3Q6IFJFOiBbTElOVVggUEFUQ0ggdjEyIDMvM10gbXRkOiByYXduYW5kOiBh
cmFzYW46IEFkZCBzdXBwb3J0IGZvciBBcmFzYW4NCj4gTkFORCBGbGFzaCBDb250cm9sbGVyDQo+
IA0KPiBIaSBNaXF1ZWwsDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
RnJvbTogTWlxdWVsIFJheW5hbCBbbWFpbHRvOm1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb21dDQo+
ID4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAxOSwgMjAxOCA3OjU3IFBNDQo+ID4gVG86IE5h
Z2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJlQHhpbGlueC5jb20+DQo+ID4gQ2M6IEJvcmlz
IEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPjsgcm9iaEBrZXJuZWwub3Jn
Ow0KPiA+IHJpY2hhcmRAbm9kLmF0OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBtYXJl
ay52YXN1dEBnbWFpbC5jb207DQo+ID4gbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IG5h
Z2FzdXJlc2gxMkBnbWFpbC5jb207IE1pY2hhbCBTaW1law0KPiA+IDxtaWNoYWxzQHhpbGlueC5j
b20+OyBjb21wdXRlcnNmb3JwZWFjZUBnbWFpbC5jb207DQo+ID4gZHdtdzJAaW5mcmFkZWFkLm9y
ZzsgbWFydGluLmx1bmRAa2VlcC1pdC1zaW1wbGUuY29tDQo+ID4gU3ViamVjdDogUmU6IFtMSU5V
WCBQQVRDSCB2MTIgMy8zXSBtdGQ6IHJhd25hbmQ6IGFyYXNhbjogQWRkIHN1cHBvcnQNCj4gPiBm
b3IgQXJhc2FuIE5BTkQgRmxhc2ggQ29udHJvbGxlcg0KPiA+DQo+ID4gSGkgTmFnYSwNCj4gPg0K
PiA+ICsgTWFydGluDQo+ID4NCj4gPiBOYWdhIFN1cmVzaGt1bWFyIFJlbGxpIDxuYWdhc3VyZUB4
aWxpbnguY29tPiB3cm90ZSBvbiBUdWUsIDE4IERlYyAyMDE4DQo+ID4gMDU6MzM6NTMgKzAwMDA6
DQo+ID4NCj4gPiA+IEhpIE1pcXVlbCwNCj4gPiA+DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IE1pcXVlbCBSYXluYWwgW21haWx0bzptaXF1ZWwucmF5
bmFsQGJvb3RsaW4uY29tXQ0KPiA+ID4gPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDE3LCAyMDE4
IDEwOjExIFBNDQo+ID4gPiA+IFRvOiBOYWdhIFN1cmVzaGt1bWFyIFJlbGxpIDxuYWdhc3VyZUB4
aWxpbnguY29tPg0KPiA+ID4gPiBDYzogQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5icmV6aWxsb25A
Ym9vdGxpbi5jb20+Ow0KPiA+ID4gPiByb2JoQGtlcm5lbC5vcmc7IHJpY2hhcmRAbm9kLmF0OyBs
aW51eC0ga2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+ID4gbWFyZWsudmFzdXRAZ21haWwu
Y29tOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+ID4gbmFnYXN1cmVzaDEy
QGdtYWlsLmNvbTsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+Ow0KPiA+ID4gPiBj
b21wdXRlcnNmb3JwZWFjZUBnbWFpbC5jb207IGR3bXcyQGluZnJhZGVhZC5vcmcNCj4gPiA+ID4g
U3ViamVjdDogUmU6IFtMSU5VWCBQQVRDSCB2MTIgMy8zXSBtdGQ6IHJhd25hbmQ6IGFyYXNhbjog
QWRkDQo+ID4gPiA+IHN1cHBvcnQgZm9yIEFyYXNhbiBOQU5EIEZsYXNoIENvbnRyb2xsZXINCj4g
PiA+ID4NCj4gPiA+ID4gSGkgTmFnYSwNCj4gPiA+ID4NCj4gPiA+ID4gWy4uLl0NCj4gPiA+ID4N
Cj4gPiA+ID4gPiBJbnNlcnRlZCBiaXRlcnJvciBAIDQ4LzcNCj4gPiA+ID4gPiBTdWNjZXNzZnVs
bHkgY29ycmVjdGVkIDI1IGJpdCBlcnJvcnMgcGVyIHN1YnBhZ2UgSW5zZXJ0ZWQNCj4gPiA+ID4g
PiBiaXRlcnJvciBADQo+ID4gPiA+ID4gNTAvNyBFQ0MgZmFpbHVyZSwgaW52YWxpZCBkYXRhIGRl
c3BpdGUgcmVhZCBzdWNjZXNzDQo+ID4gPiA+ID4gcm9vdEB4aWxpbngtemMxNzUxLWRjMi0yMDE4
XzE6fiMNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEJ1dCBldmVuIGluIHRoaXMgY2FzZSBhbHNvLCBk
cml2ZXIgaXMgc2F5aW5nIEVDQyBmYWlsdXJlIGJ1dCByZWFkIHN1Y2Nlc3MuDQo+ID4gPiA+ID4g
VGhhdCBtZWFucyBjb250cm9sbGVyIGlzIGFibGUgdG8gZGV0ZWN0IGVycm9ycyBvbiByZWFkIHBh
Z2UgdXAgdG8gMjQgYml0IG9ubHkuDQo+ID4gPiA+ID4gQWZ0ZXIgdGhhdCB0aGVyZSBpcyBubyB3
YXkgdG8gc2F5IHRvIHRoZSB1cHBlciBsYXllcnMgdGhhdCB0aGUNCj4gPiA+ID4gPiBwYWdlIGlz
IGJhZCBiZWNhdXNlIG9mIHRoZQ0KPiA+ID4gPiBsaW1pdGF0aW9uIGluIHRoZSBjb250cm9sbGVy
Lg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGlzIG1vcmUgdGhhbiBhICJsaW1pdGF0aW9uIiwgdGhl
IGRlc2lnbiBpcyBicm9rZW4uIEkgYW0gbm90DQo+ID4gPiA+IHN1cmUgaG93IHRvIHN1cHBvcnQg
c3VjaCBjb250cm9sbGVyLCBhbmQgSSBhbSBub3Qgc3VyZSBpZiB3ZSBldmVuIHdhbnQgdG8uDQo+
ID4gPg0KPiA+ID4gVGhlIG51bWJlciBvZiBlcnJvcnMgdGhhdCBhcmUgY29ycmVjdGFibGUgaXMg
bGltaXRlZCBieSBhIHBhcmFtZXRlcg0KPiA+ID4gJ3QnKHRvdGFsIG51bWJlciBvZiBlcnJvcnMp
LCBJZiB0aGVyZSBpcyBhIGNvbmRpdGlvbiB0aGF0IHRoZSBudW1iZXINCj4gPiA+IG9mIGVycm9y
cyBncmVhdGVyIHRoYW4gJ3QnLA0KPiA+IHRoZW4gdGhlIGNvbnRyb2xsZXIgd29uJ3QgYmUgYWJs
ZSB0byBkZXRlY3QgdGhhdC4NCj4gPiA+IEkgZ3Vlc3MgdGhpcyBjb25jZXB0IGlzIHNhbWUgZm9y
IG90aGVyIGNvbnRyb2xsZXJzIGFzIHdlbGwuDQo+ID4gPiBJbiBBcmFzYW4gaXQgaXMgbGltaXRl
ZCB0byAyNC1iaXQuDQo+ID4gPg0KPiA+ID4gRXZlbiwgaW4gY2FzZSBvZiBIYW1taW5nLCBpdCBp
cyAxLWJpdCBlcnJvciBjb3JyZWN0aW9uIGFuZCAyLWJpdCBlcnJvciBkZXRlY3Rpb24uDQo+ID4g
PiBXaGF0IHdpbGwgaGFwcGVuIGlmIHRoZXJlIGFyZSBtdWx0aXBsZSBlcnJvcnMoZ3JlYXRlciB0
aGFuIDItYml0KT8NCj4gPg0KPiA+IE9rIGxldCdzIHVzZSB0aGUgSGFtbWluZyBjb21wYXJpc29u
IGluIHlvdXIgRUNDIGVuZ2luZSBjYXNlLg0KPiA+DQo+ID4gLT4gaGFtbWluZzoNCj4gPiAgKiAw
IGJmOiBldmVyeXRoaW5nIGlzIGZpbmUNCj4gPiAgKiAxIGJmOiB3aWxsIGJlIGRldGVjdGVkLCBj
b3JyZWN0ZWQsIHNpZ25hbGVkDQo+ID4gICogMiBiZjogd2lsbCBiZSBkZXRlY3RlZCwgbm90IGNv
cnJlY3RlZCwgc2lnbmFsZWQNCj4gPiAgKiAzKyBiZjogZG9uJ3QgY2FyZQ0KPiA+DQo+ID4gLT4g
QkNIOg0KPiA+ICAqIDAgYmY6IGV2ZXJ5dGhpbmcgaXMgZmluZQ0KPiA+ICAqIDEtMjQgYmY6IHdp
bGwgYmUgZGV0ZWN0ZWQsIGNvcnJlY3RlZCwgc2lnbmFsZWQNCj4gPiAgKiAyNSBiZjogZXZlcnl0
aGluZyBpcyBmaW5lDQo+ID4gICogMjYrIGJmOiBkb24ndCBjYXJlDQo+ID4NCj4gPiBEbyB5b3Ug
c2VlIHRoZSBwcm9ibGVtPw0KPiBOby4NCj4gPg0KPiA+IEluIHRoZSAyNSBiZiBjYXNlLCB0aGUg
Y29udHJvbGxlciBpcyByZXBvcnRpbmcgdGhhdCBldmVyeXRoaW5nIHdlbnQNCj4gPiBmaW5lIHdo
aWxlIGl0IHNob3VsZCByZXBvcnQgdGhhdCBpdCBkZXRlY3RlZCBhbiB1bmNvcnJlY3RhYmxlIHNp
dHVhdGlvbi4NCj4gPg0KPiA+IEhlcmUgYXJlIHR3byBsZWFkcyB0byBzb2x2ZSB0aGlzIGlzc3Vl
LCBwbGVhc2UgaW52ZXN0aWdhdGUgdGhlbSBib3RoOg0KPiA+IDEvIFRhbGsgdG8geW91ciBjb2xs
ZWFndWVzIHRoYXQgZGV2ZWxvcGVkIHRoZSBSVEwsIGFzayBpZiB0aGVyZSBpcyBhDQo+ID4gICAg
aGlkZGVuL3Jlc2VydmVkIGJpdCBmb3IgdGhhdCBwdXJwb3NlIHRoYXQgaXMgbm90IGRvY3VtZW50
ZWQuDQo+IEkgc3Bva2UgdG8gUlRMIGd1eXMsIHRoZXJlIGlzIG5vdGhpbmcgaGlkZGVuL3Jlc2Vy
dmVkIGJpdCBmb3IgdGhpcyBwdXJwb3NlLg0KPiBJIHRyaWVkIHJlYWRpbmcgdGhlIHN0YXR1cyBy
ZWdpc3RlcnMgcmVzZXJ2ZWQgYml0cywgYnV0IHRoZXkgYXJlIHJheihyZWFkIGFzIHplcm8pDQo+
IA0KPiA+IDIvIFNlYXJjaCBmb3IgYSBzdGF0dXMgaW4gdGhlIHJlZ2lzdGVycyB0aGF0IG1pZ2h0
IGluZGljYXRlIHRoYXQgYW4NCj4gPiAgICBlcnJvciBvY2N1cnJlZCwgZm9yIGluc3RhbmNlICIw
IGJmIGNvcnJlY3RlZCIgYW5kICJiZiBoYXZlIGJlZW4NCj4gPiAgICBkZXRlY3RlZCIuDQo+IEkg
dHJpZWQgcmVhZGluZyBzdGF0dXMgcmVnaXN0ZXJzIGFuZCBvdGhlciByZWdpc3RlcnMgYXMgd2Vs
bCwgYnV0IG5vIGx1Y2suDQo+ID4NCj4gPiBOQjogSSBrbm93IHRoYXQsIHdpdGggYSBCQ0ggRUND
IGVuZ2luZSwgZXJyb3IgZGV0ZWN0aW9uIGF0IChzdHJlbmd0aCArDQo+ID4gMSkgaXMgbm90IDEw
MCUgc3VyZSBidXQgc3RhdGlzdGljYWxseSBpdCB3aWxsIGFsbW9zdCBhbHdheXMgYmUNCj4gPiBk
ZXRlY3RlZCBhbmQgaW4gdGhpcyBjYXNlIHdlIG5lZWQgdGhlIGNvbnRyb2xsZXIgdG8gd2FybiB0
aGUgdXNlciENCj4gT2ssIEkgdW5kZXJzdG9vZCBub3cuDQo+IA0KPiBUaGFua3MsDQo+IE5hZ2Eg
U3VyZXNoa3VtYXIgUmVsbGkNCj4gPg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IE1pcXXDqGwNCj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+
IExpbnV4IE1URCBkaXNjdXNzaW9uIG1haWxpbmcgbGlzdA0KPiBodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW10ZC8NCg==
