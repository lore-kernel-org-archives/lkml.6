Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFADDC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5EF20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aEoy1vnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5EF20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeLLNIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:08:01 -0500
Received: from mail-eopbgr750087.outbound.protection.outlook.com ([40.107.75.87]:39168
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbeLLNIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SQMjsQw4KOxcNrbUt0oLh+NemzjXoKBvgGW9Rw8zlY=;
 b=aEoy1vnz+bZVJvv9wgW5r9FIrGWmm3SZnnURlecY6uET42dvvpCau2UJ9/SoiRwfaeg1u9pokLCPAXQX819DjLLXOo4eK3PGHjoXO7M7j27TNZnVqUtvLzJchQYr3zroR87RIEuAJivgAK12SOKNd1wiBZ5q932ujzzw3ctT/Vk=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2848.namprd02.prod.outlook.com (10.175.50.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 13:07:43 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::a8e5:2cda:352a:6e61]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::a8e5:2cda:352a:6e61%10]) with mapi id 15.20.1425.016; Wed, 12 Dec
 2018 13:07:42 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: RE: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUd+lSRlJXewM/lk6msOyQbhKEh6VQmgMggAVkGQCAAK7ewIAAH7YAgAFcNKCAAGhpAIAAGiwAgATHTPCAHUh8EIAAOYWAgAAN+ACAAAI3gIAAQgWw
Date:   Wed, 12 Dec 2018 13:07:42 +0000
Message-ID: <MWHPR02MB2623EDA15BE59304795F3034AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <MWHPR02MB26234433484426F333E9B60EAFDC0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181118204324.373ca9cc@bbrezillon>
        <MWHPR02MB2623AAEC160F40F061E23194AFD80@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181119090246.49060019@bbrezillon>
        <BN6PR02MB2610C7D048E4A192E041BE14AFD90@BN6PR02MB2610.namprd02.prod.outlook.com>
        <20181120120244.7d2442b5@bbrezillon>    <20181120133624.3fa4742d@xps13>
        <MWHPR02MB26238A2271B33470ABFA1023AFD40@MWHPR02MB2623.namprd02.prod.outlook.com>
        <MWHPR02MB26239C2B2A7050310BEF1E9CAFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181212091135.1d0cc9a6@xps13>
        <MWHPR02MB26236CEF8A2110B20C825198AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181212100931.149b0cac@xps13>
In-Reply-To: <20181212100931.149b0cac@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2848;6:E6R2lSJbpCJ7r1jrtu/5LrR8R57i/x0H6d//OaUfeLjkSm14otc+nd7lCnyy5XD8DFIa9iIK3VLd4dNgmUEhAvKhTqnh7TS9WUu2a0h9nYkbtQX0zW0g4QDOch8i2dsl/VVVU4r42u9At6CcHWiGtmh1nDPmeHnqsh6oQpg5nq1Ss/LeUFNJI4lp+/+jVcMTf+0pmSPHqW1ySceYnLmD1BQzpuLHw7uk93U/yql3v5GXNcS0wC7G4Jdj6uHtcqnhA7Uy112kqX6g6RmLPzug0WhnMuFoCjTmQNFuorRfGlEHUbrz9RiY0hF6oUnYMp2U/6MgqEwcdnL+BPZP63ZyrUyyQi4HYiTFDbvV06wcKHGcq+He+41q818F7Xj6em41Tdol2dLZ0asiX+FrSZf1fEMglsLFFbuSK0eoL2JnpLEzvUu8zkI8B9tmrR5CvPrKQBptMo8wur37V+Xwj3kMIQ==;5:w13lRTmIMo8Bn/GbqBD7hzB6RUuod+9nCbAN7kfiA180wvSLQ8/EszP/fDMSV7hUWf7XzVH25RvbVUMj720Uh9q3c5b0DWz3bQ2Ecc7MyGtyuRI7qt3t7MvJHbzLr9zoz5X87FdZEvMCK4Unw3+AAz38482/Q6IP9wLTDUZDbd4=;7:OJ4OYupky/vTUK+WZ+Gj1D7oDd1PisCxFu9iNyulI5wnj134fv2B7raW8hAwkuDfMuMh4hyFiJuQSO2s0vRU89ijka78/fcoZwdBjS/f/V/CC+ruaoPhAWM5VN9MChnjG6RDNzesQuLAcYjEnhqxXQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(13464003)(8936002)(5660300001)(6436002)(68736007)(7696005)(305945005)(26005)(7736002)(74316002)(102836004)(7416002)(446003)(217873002)(54906003)(6306002)(6506007)(66574011)(76176011)(53936002)(9686003)(2906002)(99286004)(66066001)(55016002)(3846002)(86362001)(6116002)(97736004)(478600001)(8676002)(81166006)(81156014)(4326008)(316002)(106356001)(476003)(105586002)(14454004)(53546011)(93886005)(14444005)(5024004)(6246003)(33656002)(71200400001)(71190400001)(39060400002)(25786009)(11346002)(229853002)(6916009)(186003)(486006)(966005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2848;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 68f15a77-e3d6-4a5b-49d4-08d66032cd12
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2848;
x-ms-traffictypediagnostic: MWHPR02MB2848:
x-microsoft-antispam-prvs: <MWHPR02MB2848445FAC530A4393423E23AFA70@MWHPR02MB2848.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2848;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2848;
x-forefront-prvs: 0884AAA693
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aTIG6mb4BCxZc8atSBeUoCKF+jLFi9PJlUyxcBDcv/Vg708nXQCIHCLQZGgJEXeYuHNL1T9fYDGMyvUrRNKTRFQGkpqSDK43rULLmMZbEyA7XGDTjWH5riXxaOpCAX5PDTy4L6ygBkAwFdZgI77CYWzld3JjSGEOwyF0F/pGtlrzoqGfma7fwruKvE/y/MZegYWNEOMsAqUbl+6q+J/Y1yIbzvAf00MJTxVGgHecStabBCBS89/vUHEnNQRQdM2aUWIVNHOQp+olY5EW1D0uEm5JuD04QkVbLqNCVONJaIOjQsvs4WfoiSsPATo7ROuX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f15a77-e3d6-4a5b-49d4-08d66032cd12
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 13:07:42.4194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2848
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgW21haWx0bzptaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tXQ0KPiBTZW50OiBXZWRu
ZXNkYXksIERlY2VtYmVyIDEyLCAyMDE4IDI6NDAgUE0NCj4gVG86IE5hZ2EgU3VyZXNoa3VtYXIg
UmVsbGkgPG5hZ2FzdXJlQHhpbGlueC5jb20+DQo+IENjOiBCb3JpcyBCcmV6aWxsb24gPGJvcmlz
LmJyZXppbGxvbkBib290bGluLmNvbT47IHJvYmhAa2VybmVsLm9yZzsgcmljaGFyZEBub2QuYXQ7
IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBtYXJlay52YXN1dEBnbWFpbC5jb207
IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBuYWdhc3VyZXNoMTJAZ21haWwuY29t
OyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47DQo+IGNvbXB1dGVyc2ZvcnBlYWNl
QGdtYWlsLmNvbTsgZHdtdzJAaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW0xJTlVYIFBB
VENIIHYxMiAzLzNdIG10ZDogcmF3bmFuZDogYXJhc2FuOiBBZGQgc3VwcG9ydCBmb3IgQXJhc2Fu
DQo+IE5BTkQgRmxhc2ggQ29udHJvbGxlcg0KPiANCj4gSGkgTmFnYSwNCj4gDQo+IE5hZ2EgU3Vy
ZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJlQHhpbGlueC5jb20+IHdyb3RlIG9uIFdlZCwgMTIgRGVj
IDIwMTgNCj4gMDk6MDQ6MTYgKzAwMDA6DQo+IA0KPiA+IEhpIE1pcXVlbCwNCj4gPg0KPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE1pcXVlbCBSYXluYWwgW21h
aWx0bzptaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tXQ0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBE
ZWNlbWJlciAxMiwgMjAxOCAxOjQyIFBNDQo+ID4gPiBUbzogTmFnYSBTdXJlc2hrdW1hciBSZWxs
aSA8bmFnYXN1cmVAeGlsaW54LmNvbT4NCj4gPiA+IENjOiBCb3JpcyBCcmV6aWxsb24gPGJvcmlz
LmJyZXppbGxvbkBib290bGluLmNvbT47IHJvYmhAa2VybmVsLm9yZzsNCj4gPiA+IHJpY2hhcmRA
bm9kLmF0OyBsaW51eC0ga2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IG1hcmVrLnZhc3V0
QGdtYWlsLmNvbTsgbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBuYWdhc3Vy
ZXNoMTJAZ21haWwuY29tOyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47DQo+ID4g
PiBjb21wdXRlcnNmb3JwZWFjZUBnbWFpbC5jb207IGR3bXcyQGluZnJhZGVhZC5vcmcNCj4gPiA+
IFN1YmplY3Q6IFJlOiBbTElOVVggUEFUQ0ggdjEyIDMvM10gbXRkOiByYXduYW5kOiBhcmFzYW46
IEFkZCBzdXBwb3J0DQo+ID4gPiBmb3IgQXJhc2FuIE5BTkQgRmxhc2ggQ29udHJvbGxlcg0KPiA+
ID4NCj4gPiA+IEhpIE5hZ2EsDQo+ID4gPg0KPiA+ID4gTmFnYSBTdXJlc2hrdW1hciBSZWxsaSA8
bmFnYXN1cmVAeGlsaW54LmNvbT4gd3JvdGUgb24gV2VkLCAxMiBEZWMNCj4gPiA+IDIwMTgNCj4g
PiA+IDA1OjI3OjAzICswMDAwOg0KPiA+ID4NCj4gPiA+ID4gSGkgQm9yaXMgJiBNaXF1ZWwsDQo+
ID4gPiA+DQo+ID4gPiA+IEFuIHVwZGF0ZSB0byBteSBjb21tZW50cyBvbiB0aHJlYWQgaHR0cHM6
Ly9sa21sLm9yZy9sa21sLzIwMTgvMTEvMTUvNjU2Lg0KPiA+ID4gPiBJbiB0aGlzIEkgc2FpZCwg
d2lsbCB0YWtlIGEgZGVmYXVsdCBlcnJvciBjb3VudCB2YWx1ZSBhcyAxNiBhbmQNCj4gPiA+ID4g
ZHVyaW5nIHBhZ2UgcmVhZCwgd2lsbCBjaGVjayB0aGUgZXJyb3IgY291bnQgUmVnaXN0ZXIgdmFs
dWUgd2l0aA0KPiA+ID4gPiB0aGlzIGFuZCBpZiBpdCBpcyBlcXVhbCB0byBvciBncmVhdGVyIHRo
YW4gdGhlIGRlZmF1bHQgY291bnQoMTYpIHRoZW4gSSBhbSBjaGVja2luZyBmb3INCj4gRXJhc2Vk
IHBhZ2VzLg0KPiA+ID4gPiBCdXQgYml0Wzc6MF0gaW4gRUNDX0Vycm9yX0NvdW50X1JlZ2lzdGVy
KDB4MzgpIHdpbGwgdXBkYXRlIGZvciBlYWNoIGVycm9yIG9jY3VycmVkLg0KPiA+ID4gPiBMaW5r
Og0KPiA+ID4gPiBodHRwczovL3d3dy54aWxpbnguY29tL2h0bWxfZG9jcy9yZWdpc3RlcnMvdWcx
MDg3L3VnMTA4Ny16eW5xLXVsdHINCj4gPiA+ID4gYXNjYWxlLQ0KPiA+ID4gcmVnaXN0ZXJzLmh0
bWwgYW5kIGNoZWNrIGZvciBOQU5EIG1vZHVsZSwgRUNDX0Vycm9yX0NvdW50X1JlZ2lzdGVyLg0K
PiA+ID4gPg0KPiA+ID4gPiBJIG1lYW4gcHJldmlvdXNseSBJIGRlcGVuZGVudCBvbiBUb3RhbCBl
cnJvciBjb3VudCB2YWx1ZQ0KPiA+ID4gPiAoYml0WzE2OjhdKSwgYnV0IHdlIGNhbiBzaW1wbHkg
Y2hlY2sgZm9yIGJpdFs3OjBdIFRvIHNlZSB0aGUgZXJyb3Igb2NjdXJyZWQgb3Igbm90Lg0KPiA+
ID4gPiBJIHRyaWVkIHdpdGggdGhpcyBhcHByb2FjaCBhbmQgSSBkb24ndCBzZWUgYW55IGlzc3Vl
cyB3aXRoIHRoYXQuDQo+ID4gPiA+IEkgcmFuIHViaWZzIHdpdGggdGhpcyBhbmQgSSBhbSBhYmxl
IHRvIHNlZSB0aGUgYml0Wzc6MF0gY291bnQgaXMNCj4gPiA+ID4gdXBkYXRlZCBmb3IgZXJhc2Vk
IHBhZ2UgcmVhZCBhbmQgdGhlbiB3aWxsIFVzZQ0KPiA+ID4gPiBuYW5kX2NoZWNoX2VyYXNlZF9l
Y2NfY2h1bmsoKSB0byBzZWUgdGhlDQo+ID4gPiBiaXRmbGlwcy4NCj4gPiA+ID4NCj4gPiA+ID4g
SWYgaXQgaXMgb2ssIEkgd2lsbCB1cGRhdGUgdGhlIGRyaXZlciBhbmQgd2lsbCBzZW5kIG5ldyBw
YXRjaCwgYnV0DQo+ID4gPiA+IGRvIHlvdSBoYXZlIGFueSBvdGhlcg0KPiA+ID4gY29tbWVudHMg
b24gdjEyPw0KPiA+ID4NCj4gPiA+IElzICduYW5kYml0ZXJycyAtaScgcnVubmluZyBjb3JyZWN0
bHkgbm93Pw0KPiA+IFllcywgYnV0IHdpdGggc29tZSBjaGFuZ2VzIGluIGRyaXZlci4NCj4gPiBJ
IGhhdmUgYWRkZWQgdGhlIGxvZyBhbmQgY2hhbmdlcyBkb25lIGluIGh0dHBzOi8vbGttbC5vcmcv
bGttbC8yMDE4LzExLzIzLzcwNS4NCj4gDQo+IE5vLCBJIGRvbid0IHNlZSBhIHdvcmtpbmcgbmFu
ZGJpdGVycnMgdGhlcmUsIHNvcnJ5Lg0KVGhlIGxvZyB0aGF0IEkgaGF2ZSBhdHRhY2hlZCBpcyBm
cm9tIG10ZF9uYW5kYml0ZXJycyB0ZXN0DQpTbyBhcyBwZXIgQVJBU0FOIGNvbnRyb2xsZXIgRUND
IG1lY2hhbmlzbSwgaXQgd2lsbCBjb3JyZWN0IHVwdG8gMjQtYml0LiBBZnRlciB0aGF0IHRoZSB0
ZXN0IHdpbGwgZmFpbC4NCg0KSSBhbSBydW5uaW5nIG10ZC11dGlscyBuYW5kYml0ZXJyIHRlc3Qg
bm93LiBXaWxsIGxldCB5b3Uga25vdyBvbmNlIEkgY29tcGxldGVkIHRoYXQuDQoNClRoYW5rcywN
Ck5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkNCj4gDQo+IA0KPiBUaGFua3MsDQo+IE1pcXXDqGwNCg==
