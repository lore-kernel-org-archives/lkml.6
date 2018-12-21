Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1E5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4846021906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tTgAu4L+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbeLUHgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:36:10 -0500
Received: from mail-eopbgr800084.outbound.protection.outlook.com ([40.107.80.84]:54908
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728808AbeLUHgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNc+DTtgfv5HHL0qq4VqGNfS8jNLgc8lau0yjW9N8Tg=;
 b=tTgAu4L+eXgaFlGugyVqbxIM5UeH3xmjz4EVb9Nr8u+kd9z9U5pbeTuGwn8FO2OOMegW9vg/ZJAN4w/j+rrLAStfcPycQOyLYveArxOjxWwiylBoA7jQjj+7Lr8Sn+DtR2LBTD4JvG5AW+RFDaSiQnKvNv9G/C+sfO/hlfdJ81E=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2750.namprd02.prod.outlook.com (10.175.49.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 07:36:03 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::a8e5:2cda:352a:6e61]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::a8e5:2cda:352a:6e61%12]) with mapi id 15.20.1446.020; Fri, 21 Dec
 2018 07:36:02 +0000
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
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "martin.lund@keep-it-simple.com" <martin.lund@keep-it-simple.com>
Subject: RE: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUd+lSRlJXewM/lk6msOyQbhKEh6VQmgMggAVkGQCAAK7ewIAAH7YAgAFcNKCAAGhpAIAAGiwAgATHTPCAHUh8EIAAOYWAgAAN+ACAAAI3gIAAQgWwgAADhoCAB72ScIAAVsEAgADHyzCAAjdOgIACr13g
Date:   Fri, 21 Dec 2018 07:36:02 +0000
Message-ID: <MWHPR02MB262396FFF946A95D7821D61BAFB80@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <MWHPR02MB2623AAEC160F40F061E23194AFD80@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181119090246.49060019@bbrezillon>
        <BN6PR02MB2610C7D048E4A192E041BE14AFD90@BN6PR02MB2610.namprd02.prod.outlook.com>
        <20181120120244.7d2442b5@bbrezillon>    <20181120133624.3fa4742d@xps13>
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
In-Reply-To: <20181219152647.76f77711@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2750;6:SRGXDPoOsDIWa/aodR6RZQyiHM48S+eO0isMJFVT9v0p5TrgubPFGbC6Uq65WmjKI4tB/+Du/3HwPjJiswwt2DXSajv521qMP1fCGx3UIr3+LoSVaSvUkWjFYlT5Skm/W5a+9ztyuU0K/1CKPl2znYXg10zssgqsG1zxSVU0Fs/cfoDebWemJ7uYjj/Db77p3Qlhd5QC9gn6q9VCBu/lFm2Q+XLGXO5x20U1FFtFiyJBgu4qIRLdHbzGd5voGt3KaUzKVrqoBuwktxKrPaVVZ9WR5skDst5NP6G+tyQ/lgZw1Q3ivw+CgCx3T2wmp1aXIYZZYV0XBIEHHRm2/i9vrolU8klk2/+PZCOQv8LU6hsust2zGSy31FLucwVL1Lr2QE8c1A21yvsW7rC1+w5Tq7dfYonPADjxkDcApv3fL8snonK7EuH4WGLntLnX04a0ZwEVQDKFRib43y4wDF70aA==;5:drqoeeKm2KPIpQnSj/F/SklOaIInnnG5/7DqbJYL5gBF1hJ0xdh+SeVKesI1u/5cuqKtKHcALddRKs6Bi4VOuYv21BLxlkwMCTcAw1aWBLFCgP3UoG19V1vTgNSzF6z145iDc3PklR3ChSq4u3rxr5kvv4yEeVogRRP0DVhbk2Q=;7:mzpLyAy0eQ6mHBgEma8kFRJHhj16BnD0tFh5Us5OFl7m9euInMmPsWAeo+9peOQxt/XZsqdc6KysQKISLa+UPaikMYGZpG5qz+64K8Oo1HfYLYGSwc4xFsGTrL1WiFDyWvbK99H6WgBKQPI2q0+9Qg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(366004)(376002)(13464003)(199004)(189003)(217873002)(14444005)(2906002)(256004)(8676002)(6116002)(3846002)(86362001)(6916009)(26005)(76176011)(66066001)(6506007)(102836004)(53546011)(66574012)(11346002)(486006)(446003)(106356001)(33656002)(105586002)(476003)(6436002)(478600001)(25786009)(53936002)(14454004)(55016002)(9686003)(68736007)(71200400001)(71190400001)(6246003)(4326008)(39060400002)(5660300001)(7416002)(7736002)(305945005)(186003)(74316002)(7696005)(8936002)(229853002)(81166006)(54906003)(97736004)(81156014)(316002)(99286004)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2750;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: e328a9c6-07c7-4a52-0f8d-08d66716f5c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2750;
x-ms-traffictypediagnostic: MWHPR02MB2750:
x-microsoft-antispam-prvs: <MWHPR02MB27506A5A30B5A8E5C1C3904AAFB80@MWHPR02MB2750.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2750;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2750;
x-forefront-prvs: 0893636978
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ty/7ihTje331ovjQSR9IU0vLsjnDIDo5LfGv1mlsVb7IY2LQbu6eec1uhL9F64rAYkRNX1KnlCMyrmQRkmQ304h64kwc6CNUif4q3A9o9b61rW5BzQGLqjMarrpIEFFCcuZeI0rkNGJEmHNWYfYqw0BuRdgAWg1g3YE1mIEOzGzGdlT9T7TtOccVXy9Bwm0B6gFX+prtSnJ12U+XWPFLszYoJkCMQ2FNu+0inF78ol+/VI4rHG33CM8guco49BTfQIfjazB869VyigFwPYJcRztu0NwpjMou6runu7q6GClxxGF4QxVaAJ5Ia3Q0qdrF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e328a9c6-07c7-4a52-0f8d-08d66716f5c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 07:36:02.9071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgW21haWx0bzptaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tXQ0KPiBTZW50OiBXZWRu
ZXNkYXksIERlY2VtYmVyIDE5LCAyMDE4IDc6NTcgUE0NCj4gVG86IE5hZ2EgU3VyZXNoa3VtYXIg
UmVsbGkgPG5hZ2FzdXJlQHhpbGlueC5jb20+DQo+IENjOiBCb3JpcyBCcmV6aWxsb24gPGJvcmlz
LmJyZXppbGxvbkBib290bGluLmNvbT47IHJvYmhAa2VybmVsLm9yZzsgcmljaGFyZEBub2QuYXQ7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsg
bGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IG5hZ2FzdXJlc2gxMkBnbWFpbC5jb207
IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsNCj4gY29tcHV0ZXJzZm9ycGVhY2VA
Z21haWwuY29tOyBkd213MkBpbmZyYWRlYWQub3JnOyBtYXJ0aW4ubHVuZEBrZWVwLWl0LXNpbXBs
ZS5jb20NCj4gU3ViamVjdDogUmU6IFtMSU5VWCBQQVRDSCB2MTIgMy8zXSBtdGQ6IHJhd25hbmQ6
IGFyYXNhbjogQWRkIHN1cHBvcnQgZm9yIEFyYXNhbg0KPiBOQU5EIEZsYXNoIENvbnRyb2xsZXIN
Cj4gDQo+IEhpIE5hZ2EsDQo+IA0KPiArIE1hcnRpbg0KPiANCj4gTmFnYSBTdXJlc2hrdW1hciBS
ZWxsaSA8bmFnYXN1cmVAeGlsaW54LmNvbT4gd3JvdGUgb24gVHVlLCAxOCBEZWMgMjAxOA0KPiAw
NTozMzo1MyArMDAwMDoNCj4gDQo+ID4gSGkgTWlxdWVsLA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTWlxdWVsIFJheW5hbCBbbWFpbHRvOm1pcXVl
bC5yYXluYWxAYm9vdGxpbi5jb21dDQo+ID4gPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDE3LCAy
MDE4IDEwOjExIFBNDQo+ID4gPiBUbzogTmFnYSBTdXJlc2hrdW1hciBSZWxsaSA8bmFnYXN1cmVA
eGlsaW54LmNvbT4NCj4gPiA+IENjOiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBi
b290bGluLmNvbT47IHJvYmhAa2VybmVsLm9yZzsNCj4gPiA+IHJpY2hhcmRAbm9kLmF0OyBsaW51
eC0ga2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsg
bGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBuYWdhc3VyZXNoMTJAZ21haWwu
Y29tOyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47DQo+ID4gPiBjb21wdXRlcnNm
b3JwZWFjZUBnbWFpbC5jb207IGR3bXcyQGluZnJhZGVhZC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJl
OiBbTElOVVggUEFUQ0ggdjEyIDMvM10gbXRkOiByYXduYW5kOiBhcmFzYW46IEFkZCBzdXBwb3J0
DQo+ID4gPiBmb3IgQXJhc2FuIE5BTkQgRmxhc2ggQ29udHJvbGxlcg0KPiA+ID4NCj4gPiA+IEhp
IE5hZ2EsDQo+ID4gPg0KPiA+ID4gWy4uLl0NCj4gPiA+DQo+ID4gPiA+IEluc2VydGVkIGJpdGVy
cm9yIEAgNDgvNw0KPiA+ID4gPiBTdWNjZXNzZnVsbHkgY29ycmVjdGVkIDI1IGJpdCBlcnJvcnMg
cGVyIHN1YnBhZ2UgSW5zZXJ0ZWQgYml0ZXJyb3INCj4gPiA+ID4gQA0KPiA+ID4gPiA1MC83IEVD
QyBmYWlsdXJlLCBpbnZhbGlkIGRhdGEgZGVzcGl0ZSByZWFkIHN1Y2Nlc3MNCj4gPiA+ID4gcm9v
dEB4aWxpbngtemMxNzUxLWRjMi0yMDE4XzE6fiMNCj4gPiA+ID4NCj4gPiA+ID4gQnV0IGV2ZW4g
aW4gdGhpcyBjYXNlIGFsc28sIGRyaXZlciBpcyBzYXlpbmcgRUNDIGZhaWx1cmUgYnV0IHJlYWQg
c3VjY2Vzcy4NCj4gPiA+ID4gVGhhdCBtZWFucyBjb250cm9sbGVyIGlzIGFibGUgdG8gZGV0ZWN0
IGVycm9ycyBvbiByZWFkIHBhZ2UgdXAgdG8gMjQgYml0IG9ubHkuDQo+ID4gPiA+IEFmdGVyIHRo
YXQgdGhlcmUgaXMgbm8gd2F5IHRvIHNheSB0byB0aGUgdXBwZXIgbGF5ZXJzIHRoYXQgdGhlDQo+
ID4gPiA+IHBhZ2UgaXMgYmFkIGJlY2F1c2Ugb2YgdGhlDQo+ID4gPiBsaW1pdGF0aW9uIGluIHRo
ZSBjb250cm9sbGVyLg0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgbW9yZSB0aGFuIGEgImxpbWl0YXRp
b24iLCB0aGUgZGVzaWduIGlzIGJyb2tlbi4gSSBhbSBub3QNCj4gPiA+IHN1cmUgaG93IHRvIHN1
cHBvcnQgc3VjaCBjb250cm9sbGVyLCBhbmQgSSBhbSBub3Qgc3VyZSBpZiB3ZSBldmVuIHdhbnQg
dG8uDQo+ID4NCj4gPiBUaGUgbnVtYmVyIG9mIGVycm9ycyB0aGF0IGFyZSBjb3JyZWN0YWJsZSBp
cyBsaW1pdGVkIGJ5IGEgcGFyYW1ldGVyDQo+ID4gJ3QnKHRvdGFsIG51bWJlciBvZiBlcnJvcnMp
LCBJZiB0aGVyZSBpcyBhIGNvbmRpdGlvbiB0aGF0IHRoZSBudW1iZXIgb2YgZXJyb3JzIGdyZWF0
ZXIgdGhhbiAndCcsDQo+IHRoZW4gdGhlIGNvbnRyb2xsZXIgd29uJ3QgYmUgYWJsZSB0byBkZXRl
Y3QgdGhhdC4NCj4gPiBJIGd1ZXNzIHRoaXMgY29uY2VwdCBpcyBzYW1lIGZvciBvdGhlciBjb250
cm9sbGVycyBhcyB3ZWxsLg0KPiA+IEluIEFyYXNhbiBpdCBpcyBsaW1pdGVkIHRvIDI0LWJpdC4N
Cj4gPg0KPiA+IEV2ZW4sIGluIGNhc2Ugb2YgSGFtbWluZywgaXQgaXMgMS1iaXQgZXJyb3IgY29y
cmVjdGlvbiBhbmQgMi1iaXQgZXJyb3IgZGV0ZWN0aW9uLg0KPiA+IFdoYXQgd2lsbCBoYXBwZW4g
aWYgdGhlcmUgYXJlIG11bHRpcGxlIGVycm9ycyhncmVhdGVyIHRoYW4gMi1iaXQpPw0KPiANCj4g
T2sgbGV0J3MgdXNlIHRoZSBIYW1taW5nIGNvbXBhcmlzb24gaW4geW91ciBFQ0MgZW5naW5lIGNh
c2UuDQo+IA0KPiAtPiBoYW1taW5nOg0KPiAgKiAwIGJmOiBldmVyeXRoaW5nIGlzIGZpbmUNCj4g
ICogMSBiZjogd2lsbCBiZSBkZXRlY3RlZCwgY29ycmVjdGVkLCBzaWduYWxlZA0KPiAgKiAyIGJm
OiB3aWxsIGJlIGRldGVjdGVkLCBub3QgY29ycmVjdGVkLCBzaWduYWxlZA0KPiAgKiAzKyBiZjog
ZG9uJ3QgY2FyZQ0KPiANCj4gLT4gQkNIOg0KPiAgKiAwIGJmOiBldmVyeXRoaW5nIGlzIGZpbmUN
Cj4gICogMS0yNCBiZjogd2lsbCBiZSBkZXRlY3RlZCwgY29ycmVjdGVkLCBzaWduYWxlZA0KPiAg
KiAyNSBiZjogZXZlcnl0aGluZyBpcyBmaW5lDQo+ICAqIDI2KyBiZjogZG9uJ3QgY2FyZQ0KPiAN
Cj4gRG8geW91IHNlZSB0aGUgcHJvYmxlbT8NCk5vLg0KPiANCj4gSW4gdGhlIDI1IGJmIGNhc2Us
IHRoZSBjb250cm9sbGVyIGlzIHJlcG9ydGluZyB0aGF0IGV2ZXJ5dGhpbmcgd2VudCBmaW5lIHdo
aWxlIGl0IHNob3VsZCByZXBvcnQNCj4gdGhhdCBpdCBkZXRlY3RlZCBhbiB1bmNvcnJlY3RhYmxl
IHNpdHVhdGlvbi4NCj4gDQo+IEhlcmUgYXJlIHR3byBsZWFkcyB0byBzb2x2ZSB0aGlzIGlzc3Vl
LCBwbGVhc2UgaW52ZXN0aWdhdGUgdGhlbSBib3RoOg0KPiAxLyBUYWxrIHRvIHlvdXIgY29sbGVh
Z3VlcyB0aGF0IGRldmVsb3BlZCB0aGUgUlRMLCBhc2sgaWYgdGhlcmUgaXMgYQ0KPiAgICBoaWRk
ZW4vcmVzZXJ2ZWQgYml0IGZvciB0aGF0IHB1cnBvc2UgdGhhdCBpcyBub3QgZG9jdW1lbnRlZC4N
Ckkgc3Bva2UgdG8gUlRMIGd1eXMsIHRoZXJlIGlzIG5vdGhpbmcgaGlkZGVuL3Jlc2VydmVkIGJp
dCBmb3IgdGhpcyBwdXJwb3NlLg0KSSB0cmllZCByZWFkaW5nIHRoZSBzdGF0dXMgcmVnaXN0ZXJz
IHJlc2VydmVkIGJpdHMsIGJ1dCB0aGV5IGFyZSByYXoocmVhZCBhcyB6ZXJvKQ0KDQo+IDIvIFNl
YXJjaCBmb3IgYSBzdGF0dXMgaW4gdGhlIHJlZ2lzdGVycyB0aGF0IG1pZ2h0IGluZGljYXRlIHRo
YXQgYW4NCj4gICAgZXJyb3Igb2NjdXJyZWQsIGZvciBpbnN0YW5jZSAiMCBiZiBjb3JyZWN0ZWQi
IGFuZCAiYmYgaGF2ZSBiZWVuDQo+ICAgIGRldGVjdGVkIi4NCkkgdHJpZWQgcmVhZGluZyBzdGF0
dXMgcmVnaXN0ZXJzIGFuZCBvdGhlciByZWdpc3RlcnMgYXMgd2VsbCwgYnV0IG5vIGx1Y2suDQo+
IA0KPiBOQjogSSBrbm93IHRoYXQsIHdpdGggYSBCQ0ggRUNDIGVuZ2luZSwgZXJyb3IgZGV0ZWN0
aW9uIGF0IChzdHJlbmd0aCArDQo+IDEpIGlzIG5vdCAxMDAlIHN1cmUgYnV0IHN0YXRpc3RpY2Fs
bHkgaXQgd2lsbCBhbG1vc3QgYWx3YXlzIGJlIGRldGVjdGVkIGFuZCBpbiB0aGlzIGNhc2Ugd2UN
Cj4gbmVlZCB0aGUgY29udHJvbGxlciB0byB3YXJuIHRoZSB1c2VyIQ0KT2ssIEkgdW5kZXJzdG9v
ZCBub3cuDQoNClRoYW5rcywNCk5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkNCj4gDQo+IA0KPiBUaGFu
a3MsDQo+IE1pcXXDqGwNCg==
