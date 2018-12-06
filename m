Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E466AC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9693A214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XEXsSf5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9693A214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbeLFIaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:30:07 -0500
Received: from mail-eopbgr780075.outbound.protection.outlook.com ([40.107.78.75]:19776
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeLFIaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUfwKd7yVIXvk6/iEAckiwbcUKI0kfhRyaAPNmQIwSo=;
 b=XEXsSf5jrBALNfckxTCpHo7ClPazn5Gpv1kbhBgsqMq1mBtewxj+oOg1mYuo0+M6CavLVPuQZxTO1zntPG1igzZ4+AZo9cAVNivl+XX2mfAq51OKtEHlh4XUSULoPvCtjxLWVPkYSMg38XZWydc11gJ78C93Ovg9hsNPiBOPc0E=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2381.namprd02.prod.outlook.com (10.168.244.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 6 Dec 2018 08:30:02 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::95ca:9c47:8102:97b1]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::95ca:9c47:8102:97b1%4]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 08:29:58 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "d-gerlach@ti.com" <d-gerlach@ti.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [LINUX PATCH v12 2/2] memory: pl353: Add driver for arm pl353
 static memory controller
Thread-Topic: [LINUX PATCH v12 2/2] memory: pl353: Add driver for arm pl353
 static memory controller
Thread-Index: AQHUh+MxuNm9GuV0E0u4D7cKJcRdbaVwQvWAgAEo1YA=
Date:   Thu, 6 Dec 2018 08:29:57 +0000
Message-ID: <MWHPR02MB262379941E7314EA6C3FC68DAFA90@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1543496278-6524-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <e27c9c14-2b2d-3f8b-0371-9c82a0721b8e@xilinx.com>
In-Reply-To: <e27c9c14-2b2d-3f8b-0371-9c82a0721b8e@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2381;6:LG+K9E5273M7Om6axEZ5DvEFShfV/WxYloYVeXkvmXHcIRykHxpGJMxT3VrB778T/kcE+PW8XhzFc5blTrjRUdj/QZIU5d8jRaXjmYkZlrfC6OsuRSJC0dYzIISIEexkesL/0LHG44BetGMIJngvUj7Ne2E6urABUUcSnEatG60AhaoesoyQ+uELP1pEd1/+VrFp/QyUcZIqTosdotHz5TyflW8khELdS+QndRCKOOX8aDKAFqjUqa78FIyJDeW8ytnhk7LYrU1+6LhrCaZ9twDqh4W8L5vCh6wSMf6N65fdF817AgS7QJy9EAaDbufvGL3G7IBk8j/nCnw8Zh8LS4iOZHcIS7lt9G1BITdaj5+kUhf+CI8j2JFEhHMMZxkkzjp1Lg/Ik/a3mgMvWpoJ4n8cu4uwXwPUd1W0HW9u1aP6Nelj55LDtIb2Rrx3btczKoMiU7s0ijXSE/qXoLKzqA==;5:PFglDhBGUvhcIDQiZ6mO2u5vOQXzJxdbvyJBge/sNXNsrX9Nt6o0Dgijx0rRs0Pw/cBgo/PcXID1AS0PAfs9ih1/xowHsvgoGCqe3na+SL93uOEF/TytpKRRif+HHfql9nchJ1FKjAD8JhRIz5+iGEwEod4TvrIY70EnvDZeCGY=;7:GUl5DyYzZ8HbPKbFARRdYV7MBWw4I50h+kJ/hxTVEilU7RkTU0rFYrTSv3+0kh8IPn8B9HYY6EWwlzrfvnE0T9DRGgpJpxwXpZmKjt1T6YPS0qP4mAv86r7zFQTBYWGanHX+PNDoNTxMoWmPycCCuQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(13464003)(54534003)(2501003)(446003)(11346002)(217873002)(99286004)(14444005)(14454004)(5660300001)(486006)(2906002)(476003)(76176011)(8936002)(33656002)(7696005)(186003)(229853002)(305945005)(53936002)(256004)(102836004)(6246003)(6306002)(9686003)(71190400001)(71200400001)(8676002)(74316002)(53546011)(6116002)(3846002)(110136005)(316002)(4326008)(54906003)(66066001)(6436002)(7736002)(39060400002)(68736007)(81156014)(26005)(106356001)(478600001)(55016002)(105586002)(97736004)(2201001)(966005)(6506007)(25786009)(81166006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2381;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 3ce10a86-44e8-416c-7101-08d65b5501eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2381;
x-ms-traffictypediagnostic: MWHPR02MB2381:
x-microsoft-antispam-prvs: <MWHPR02MB2381FC9531D13B73824ECE49AFA90@MWHPR02MB2381.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2381;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2381;
x-forefront-prvs: 087894CD3C
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ggkJAGJY9EMUp//9DvsnuM07D9Kcm40R0KSrVLQQ70+omi9lxl4bcNuLNEoH9LGQgXL0wb7SdeaVXrPrvng8WYsXvaf9s5wvs3HO5CmZIDZ2bPSOPmJyuWQroM6gXK0gK7tKpVp04TjDXUUcjz646ayWZe8auAOh0JTB4TPxWhVujATtLPT0pWASakYJQaOlyUsyCDfN/nSoNpegPPno/28aNLTrjLZQ+7aTyKCnr1+pWkKHS31DwjMz6+2M2G4PVyXXwX7F9lbB8ZcXKcRW1gQDxz4vVwvcSU5toQb9BZHdnjk+AYvGcjQtkBtHr6w91na7m4NjUmyxLk8BbLeW3ESz4zBvOToB5UhSDZSB+jE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce10a86-44e8-416c-7101-08d65b5501eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 08:29:58.0807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFsLA0KDQpPaywgd2lsbCB1cGRhdGUgYW5kIHdpbGwgc2VuZCBuZXcgcGF0Y2guDQoN
ClRoYW5rcywNCk5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWwgU2ltZWsgW21haWx0bzptaWNoYWwuc2ltZWtAeGlsaW54
LmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciA1LCAyMDE4IDg6MTcgUE0NCj4gVG86
IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJlQHhpbGlueC5jb20+OyBtbWF5ZXJAYnJv
YWRjb20uY29tOw0KPiBmLmZhaW5lbGxpQGdtYWlsLmNvbTsgbGFkaXNAbGludXgtbWlwcy5vcmc7
IHRyZWRpbmdAbnZpZGlhLmNvbTsgZGlnZXR4QGdtYWlsLmNvbTsgZC0NCj4gZ2VybGFjaEB0aS5j
b20NCj4gQ2M6IGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZzsgTWljaGFsIFNpbWVrIDxtaWNoYWxz
QHhpbGlueC5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW0xJTlVYIFBBVENIIHYxMiAyLzJdIG1lbW9yeTogcGwzNTM6IEFkZCBkcml2ZXIgZm9y
IGFybSBwbDM1MyBzdGF0aWMNCj4gbWVtb3J5IGNvbnRyb2xsZXINCj4gDQo+IE9uIDI5LiAxMS4g
MTggMTM6NTcsIE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgd3JvdGU6DQo+ID4gQWRkIGRyaXZlciBm
b3IgYXJtIHBsMzUzIHN0YXRpYyBtZW1vcnkgY29udHJvbGxlci4gVGhpcyBjb250cm9sbGVyIGlz
DQo+ID4gdXNlZCBpbiBYaWxpbnggWnlucSBTb0MgZm9yIGludGVyZmFjaW5nIHRoZSBOQU5EIGFu
ZCBOT1IvU1JBTSBtZW1vcnkgZGV2aWNlcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hZ2Eg
U3VyZXNoa3VtYXIgUmVsbGkNCj4gPiA8bmFnYS5zdXJlc2hrdW1hci5yZWxsaUB4aWxpbnguY29t
Pg0KPiA+IFJldmlld2VkLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5v
cmc+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWVtb3J5L0tjb25maWcgICAgIHwgICA5ICsNCj4g
PiAgZHJpdmVycy9tZW1vcnkvTWFrZWZpbGUgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL21lbW9y
eS9wbDM1My1zbWMuYyB8IDQ2OA0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3BsMzUzLXNtYy5oICB8ICAzMCArKysN
Cj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA1MDggaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9tZW1vcnkvcGwzNTMtc21jLmMgIGNyZWF0ZSBtb2RlIDEwMDY0NA0K
PiA+IGluY2x1ZGUvbGludXgvcGwzNTMtc21jLmgNCj4gPg0KPiANCj4gTWlzc2luZyBjaGFuZ2Vs
b2cgd2hpY2ggd2FzIHRoZXJlIGluIHYxMQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRj
aHdvcmsvcGF0Y2gvOTYxNjA0Lw0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZW1vcnkv
S2NvbmZpZyBiL2RyaXZlcnMvbWVtb3J5L0tjb25maWcgaW5kZXgNCj4gPiA2MzM4OWYwLi4yZDkx
YjAwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVtb3J5L0tjb25maWcNCj4gPiArKysgYi9k
cml2ZXJzL21lbW9yeS9LY29uZmlnDQo+ID4gQEAgLTE0NSw2ICsxNDUsMTUgQEAgY29uZmlnIERB
OFhYX0REUkNUTA0KPiA+ICAJICBUZXhhcyBJbnN0cnVtZW50cyBkYTh4eCBTb0NzLiBJdCdzIHVz
ZWQgdG8gdHdlYWsgdmFyaW91cyBtZW1vcnkNCj4gPiAgCSAgY29udHJvbGxlciBjb25maWd1cmF0
aW9uIG9wdGlvbnMuDQo+ID4NCj4gPiArY29uZmlnIFBMMzUzX1NNQw0KPiA+ICsJdHJpc3RhdGUg
IkFSTSBQTDM1WCBTdGF0aWMgTWVtb3J5IENvbnRyb2xsZXIoU01DKSBkcml2ZXIiDQo+ID4gKwlk
ZWZhdWx0IHkNCj4gPiArCWRlcGVuZHMgb24gQVJNDQo+ID4gKwlkZXBlbmRzIG9uIEFSTV9BTUJB
DQo+ID4gKwloZWxwDQo+ID4gKwkgIFRoaXMgZHJpdmVyIGlzIGZvciB0aGUgQVJNIFBMMzUxL1BM
MzUzIFN0YXRpYyBNZW1vcnkNCj4gPiArCSAgQ29udHJvbGxlcihTTUMpIG1vZHVsZS4NCj4gPiAr
DQo+ID4gIHNvdXJjZSAiZHJpdmVycy9tZW1vcnkvc2Ftc3VuZy9LY29uZmlnIg0KPiA+ICBzb3Vy
Y2UgImRyaXZlcnMvbWVtb3J5L3RlZ3JhL0tjb25maWciDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tZW1vcnkvTWFrZWZpbGUgYi9kcml2ZXJzL21lbW9yeS9NYWtlZmlsZSBpbmRleA0K
PiA+IGEwMWFiM2UuLjkwMTYxZGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZW1vcnkvTWFr
ZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL21lbW9yeS9NYWtlZmlsZQ0KPiA+IEBAIC0xOSw2ICsx
OSw3IEBAIG9iai0kKENPTkZJR19NVkVCVV9ERVZCVVMpCSs9IG12ZWJ1LWRldmJ1cy5vDQo+ID4g
IG9iai0kKENPTkZJR19KWjQ3ODBfTkVNQykJKz0gano0NzgwLW5lbWMubw0KPiA+ICBvYmotJChD
T05GSUdfTVRLX1NNSSkJCSs9IG10ay1zbWkubw0KPiA+ICBvYmotJChDT05GSUdfREE4WFhfRERS
Q1RMKQkrPSBkYTh4eC1kZHJjdGwubw0KPiA+ICtvYmotJChDT05GSUdfUEwzNTNfU01DKQkJKz0g
cGwzNTMtc21jLm8NCj4gPg0KPiA+ICBvYmotJChDT05GSUdfU0FNU1VOR19NQykJKz0gc2Ftc3Vu
Zy8NCj4gPiAgb2JqLSQoQ09ORklHX1RFR1JBX01DKQkJKz0gdGVncmEvDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbWVtb3J5L3BsMzUzLXNtYy5jIGIvZHJpdmVycy9tZW1vcnkvcGwzNTMtc21j
LmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NCBpbmRleCAwMDAwMDAwLi42NzM4YTg0DQo+ID4g
LS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvbWVtb3J5L3BsMzUzLXNtYy5jDQo+ID4g
QEAgLTAsMCArMSw0NjggQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjANCj4gPiArLyoNCj4gPiArICogQVJNIFBMMzUzIFNNQyBkcml2ZXINCj4gPiArICoNCj4gPiAr
ICogQ29weXJpZ2h0IChDKSAyMDEyIC0gMjAxOCBYaWxpbngsIEluYw0KPiA+ICsgKiBBdXRob3I6
IFB1bm5haWFoIENob3VkYXJ5IEthbGx1cmkgPHB1bm5haWFoQHhpbGlueC5jb20+DQo+ID4gKyAq
IEF1dGhvcjogTmFnYSBTdXJlc2hrdW1hciBSZWxsaSA8bmFnYXN1cmVAeGlsaW54LmNvbT4NCj4g
PiArICoNCj4gDQo+IHJlbW92ZSBsaW5lIGFib3ZlLg0KPiANCj4gYW5kIHRoZW4gZml4IHRoZXNl
IHR3bw0KPiANCj4gQ0hFQ0s6IFBsZWFzZSB1c2UgYSBibGFuayBsaW5lIGFmdGVyIGZ1bmN0aW9u
L3N0cnVjdC91bmlvbi9lbnVtIGRlY2xhcmF0aW9ucw0KPiAjMzU5OiBGSUxFOiBkcml2ZXJzL21l
bW9yeS9wbDM1My1zbWMuYzoyOTk6DQo+ICt9DQo+ICtzdGF0aWMgc3RydWN0IGFtYmFfZHJpdmVy
IHBsMzUzX3NtY19kcml2ZXI7DQo+IA0KPiBDSEVDSzogQWxpZ25tZW50IHNob3VsZCBtYXRjaCBv
cGVuIHBhcmVudGhlc2lzDQo+ICMzNjk6IEZJTEU6IGRyaXZlcnMvbWVtb3J5L3BsMzUzLXNtYy5j
OjMwOToNCj4gK3ZvaWQgcGwzNTNfc21jX2luaXRfbmFuZF9pbnRlcmZhY2Uoc3RydWN0IGFtYmFf
ZGV2aWNlICphZGV2LA0KPiArCQkJCQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5hbmRfbm9kZSkNCj4g
DQo+IHRvdGFsOiAwIGVycm9ycywgMiB3YXJuaW5ncywgMiBjaGVja3MsIDUyMCBsaW5lcyBjaGVj
a2VkDQo+IA0KPiBOT1RFOiBGb3Igc29tZSBvZiB0aGUgcmVwb3J0ZWQgZGVmZWN0cywgY2hlY2tw
YXRjaCBtYXkgYmUgYWJsZSB0bw0KPiANCj4gYW5kIGFsc28NCj4gdGhpcyBkb2Vzbid0IHJpZ2h0
IHRvby4NCj4gDQo+IGRyaXZlcnMvbWVtb3J5L3BsMzUzLXNtYy5jOjMwODo2OiB3YXJuaW5nOiBz
eW1ib2wgJ3BsMzUzX3NtY19pbml0X25hbmRfaW50ZXJmYWNlJyB3YXMNCj4gbm90IGRlY2xhcmVk
LiBTaG91bGQgaXQgYmUgc3RhdGljPw0KPiAgIENDICAgICAgZHJpdmVycy9tZW1vcnkvcGwzNTMt
c21jLm8NCj4gZHJpdmVycy9tZW1vcnkvcGwzNTMtc21jLmM6MzA4OjY6IHdhcm5pbmc6IG5vIHBy
ZXZpb3VzIHByb3RvdHlwZSBmb3INCj4g4oCYcGwzNTNfc21jX2luaXRfbmFuZF9pbnRlcmZhY2Xi
gJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXSAgdm9pZA0KPiBwbDM1M19zbWNfaW5pdF9uYW5kX2lu
dGVyZmFjZShzdHJ1Y3QgYW1iYV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgIF5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+DQo+IGRyaXZlcnMvbWVtb3J5L3BsMzUzLXNtYy5jOjQzOTozNDogd2Fy
bmluZzog4oCYcGwzNTNfc21jX29mX21hdGNo4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkDQo+IFst
V3VudXNlZC1jb25zdC12YXJpYWJsZT1dICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCBwbDM1M19zbWNfb2ZfbWF0Y2hbXSA9IHsNCj4gDQo+IFRoYW5rcywNCj4gTWljaGFsDQo=
