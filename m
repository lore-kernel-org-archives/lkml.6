Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F424C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29CB2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FoXSj/ys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29CB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeIXOnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:43:32 -0400
Received: from mail-bl2nam02on0042.outbound.protection.outlook.com ([104.47.38.42]:32800
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726241AbeIXOnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4pYeDxOs1fj/jEsBB22SJFO6ng9yhJw2OsBC0sKU9k=;
 b=FoXSj/ysv3rmNomxjeijTR95tzMntOQ1hsK5ECkNLtJtPDYWJwuJn88J5X8QSba/hkDd67pI3M+9SEAp9+gnDLggjEFppvmMfhgpDuTLJMGMrn7XaGkb28iJSQzIkDtkJz/ZDIZENbJXdECFZWqk2fTlci5m37LBJ7GJKCLGNyg=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2640.namprd02.prod.outlook.com (10.168.206.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Mon, 24 Sep 2018 08:42:29 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::f0c9:d512:1636:4e40]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::f0c9:d512:1636:4e40%4]) with mapi id 15.20.1164.017; Mon, 24 Sep 2018
 08:42:28 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "richard@nod.at" <richard@nod.at>,
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
Subject: RE: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUNiz7bKojXyawJ0eL/lrCUsemM6TI3JSAgCHUiICAEXVKAIAABYYAgAMslOA=
Date:   Mon, 24 Sep 2018 08:42:28 +0000
Message-ID: <MWHPR02MB2623E91C84E9762E12DCD73BAF170@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180820184013.57fd7b5c@bbrezillon>
        <MWHPR02MB2623A761C40745AD4AE2A295AF040@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20180922095340.4fe373f8@xps13> <20180922101326.6f139da2@bbrezillon>
In-Reply-To: <20180922101326.6f139da2@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2640;6:dQ85GpQXbM9og1rIJfIk4SvFabF/VVUkOezZGyezy2Qnct+o1srr04+QcUJAhw/CX72lO+cwbSAU5b2HJT+nFqlyRKjJfa8QPwLtmUKFXb2A3btVSTO6UeAY2sriBBap6muUJ39F25kXZNBSmLym4VkCBVjHOz30YEOAtdh54UacqItFW+36/jQRjSLb6sddFSG7E0MHE94P9WYiMyvrnq9QCMZ4s1fjTgjdErO7nRG9VnQ4KNNekc0ZxEkCevuLNzHXXCugidAIMR8CG6ovArXgwSWLcUIHOr925Q5/h4c2x44sHDIsf+6KU4bB74yjlTQ5WMZZ8Py/t762xIts5jng5rJwxB4L3hK5TltZ0ii4k0U7w1kpcaQY8YTgK5FMlucB/SDk2PqGNMM2eN/uNscTGRBvNYXkATi7gVzd4h+LGAQVT2YDRpYwVat+1jmHjwPdvFRNqrVpFitM9nuEQg==;5:+HiBeSMKO+KRquWBccBoF6GN60lJsfUSsC/1XiEaQwxDgqKLGBqxYEcuzle2Bp+uGvUOQYNSbEVE2ljYYssp5YscGB93pGOe0++V4oZU/Vfbtx7+XvzThl5fqUDvhC9/F81hZEe2Z++gRxjapmSTxNZ0vTrszJbFRKoEERnVBdk=;7:kZGNvwNvw8i2nTtcM7P6+BM5z3itMo2yoVxjK+u+isOMRW7AdzBQGb7say9cAExf/WkTrRMMDo62gdhKQUgAW2jQv4N0SVsYRYXB+yBft4V4Ud8l5cB8eGW5a9ErKnnZSD5GWhgItejaXyuErWuRJtzSfbnSw7+EmartSfMZULenODJemquIqWVc/BEdMcBbp0+oVNb2mwroOFtnk3R6lcPCq92fLwPqwXs0TVYJ0gOil3EPNAx8L8JS7mJq0uL6
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(366004)(199004)(13464003)(189003)(33656002)(14444005)(9686003)(55016002)(217873002)(446003)(11346002)(229853002)(478600001)(102836004)(26005)(6506007)(53546011)(186003)(6436002)(106356001)(105586002)(6116002)(71200400001)(71190400001)(97736004)(5250100002)(486006)(53936002)(3846002)(476003)(7696005)(81166006)(81156014)(316002)(110136005)(74316002)(99286004)(39060400002)(4326008)(8676002)(76176011)(8936002)(2900100001)(66066001)(86362001)(93886005)(54906003)(7736002)(2906002)(5660300001)(25786009)(14454004)(7416002)(256004)(305945005)(6246003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2640;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: a1bf7674-1951-4b1b-3e36-08d621f9a920
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2640;
x-ms-traffictypediagnostic: MWHPR02MB2640:
x-microsoft-antispam-prvs: <MWHPR02MB26407A457E1B21F9CB2A71B1AF170@MWHPR02MB2640.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(7411616537696)(34377916053724)(258649278758335)(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:MWHPR02MB2640;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2640;
x-forefront-prvs: 0805EC9467
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l87v9RMaNTodwb2k88gZ14sXbnSKSjt3djC9p3hL5U9N/1SrQLjqyrN8IqQcaGOkxqfAEmftwoHH25kvLh8xDWi7F+NaFsHc+FZVvl6IdkOaD0AkYQ++t8i7+enTPys5h1vwA1WAAkMg2QxSzs1Lp5fB6+Vdm/8lkb1BeYHVPnSm0siZ/Ga/48tvJ4YVlOaMlBF13ZK4JA9juPN3U6fq3hB9/bNINS4saaMDyWjUHRFgDkuJyrXxLfLngIBAPeCzG6MNxsX2k/lvsmVvPn7hBwCUhfVgWJPz8YZeQx7m85RxlvGonXteYXj+1yLKgUC6T/j61u/enpB0/Vz/F4LeCclyatv1AkBYjLAoD6xeQ9c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bf7674-1951-4b1b-3e36-08d621f9a920
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 08:42:28.6088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMgJiBNaXF1ZWwsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogQm9yaXMgQnJlemlsbG9uIFttYWlsdG86Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tXQ0K
PiBTZW50OiBTYXR1cmRheSwgU2VwdGVtYmVyIDIyLCAyMDE4IDE6NDMgUE0NCj4gVG86IE1pcXVl
bCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IENjOiBOYWdhIFN1cmVzaGt1
bWFyIFJlbGxpIDxuYWdhc3VyZUB4aWxpbnguY29tPjsgcmljaGFyZEBub2QuYXQ7IGR3bXcyQGlu
ZnJhZGVhZC5vcmc7DQo+IGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbTsgbWFyZWsudmFzdXRA
Z21haWwuY29tOyBreXVuZ21pbi5wYXJrQHNhbXN1bmcuY29tOw0KPiBhYnNhaHVAY29kZWF1cm9y
YS5vcmc7IHBldGVycGFuZG9uZ0BtaWNyb24uY29tOyBmcmllZGVyLnNjaHJlbXBmQGV4Y2VldC5k
ZTsgbGludXgtDQo+IG10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47DQo+IG5hZ2FzdXJl
c2hrdW1hcnJlbGxpQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW0xJTlVYIFBBVENIIHYxMCAy
LzJdIG10ZDogcmF3bmFuZDogYXJhc2FuOiBBZGQgc3VwcG9ydCBmb3IgQXJhc2FuIE5BTkQNCj4g
Rmxhc2ggQ29udHJvbGxlcg0KPiANCj4gT24gU2F0LCAyMiBTZXAgMjAxOCAwOTo1Mzo0MCArMDIw
MA0KPiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZToNCj4g
DQo+ID4gSGkgTmFnYSwNCj4gPg0KPiA+IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJl
QHhpbGlueC5jb20+IHdyb3RlIG9uIFR1ZSwgMTEgU2VwIDIwMTgNCj4gPiAwNToyMzowOSArMDAw
MDoNCj4gPg0KPiA+ID4gSGkgQm9yaXMsDQo+ID4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+ID4gPiBGcm9tOiBCb3JpcyBCcmV6aWxsb24gW21haWx0bzpib3Jpcy5i
cmV6aWxsb25AYm9vdGxpbi5jb21dDQo+ID4gPiA+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDIwLCAy
MDE4IDEwOjEwIFBNDQo+ID4gPiA+IFRvOiBOYWdhIFN1cmVzaGt1bWFyIFJlbGxpIDxuYWdhc3Vy
ZUB4aWxpbnguY29tPg0KPiA+ID4gPiBDYzogbWlxdWVsLnJheW5hbEBib290bGluLmNvbTsgcmlj
aGFyZEBub2QuYXQ7DQo+ID4gPiA+IGR3bXcyQGluZnJhZGVhZC5vcmc7IGNvbXB1dGVyc2ZvcnBl
YWNlQGdtYWlsLmNvbTsNCj4gPiA+ID4gbWFyZWsudmFzdXRAZ21haWwuY29tOyBreXVuZ21pbi5w
YXJrQHNhbXN1bmcuY29tOw0KPiA+ID4gPiBhYnNhaHVAY29kZWF1cm9yYS5vcmc7IHBldGVycGFu
ZG9uZ0BtaWNyb24uY29tOw0KPiA+ID4gPiBmcmllZGVyLnNjaHJlbXBmQGV4Y2VldC5kZTsgbGlu
dXgtIG10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47DQo+ID4gPiA+IG5h
Z2FzdXJlc2hrdW1hcnJlbGxpQGdtYWlsLmNvbQ0KPiA+ID4gPiBTdWJqZWN0OiBSZTogW0xJTlVY
IFBBVENIIHYxMCAyLzJdIG10ZDogcmF3bmFuZDogYXJhc2FuOiBBZGQNCj4gPiA+ID4gc3VwcG9y
dCBmb3IgQXJhc2FuIE5BTkQgRmxhc2ggQ29udHJvbGxlcg0KPiA+ID4gPg0KPiA+ID4gPiBIaSBO
YWdhLA0KPiA+ID4gPg0KPiA+ID4gPiBPbiBGcmksIDE3IEF1ZyAyMDE4IDE4OjQ5OjI0ICswNTMw
IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkNCj4gPiA+ID4gPG5hZ2Euc3VyZXNoa3VtYXIucmVsbGlA
eGlsaW54LmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEkgaGF2ZW4ndCBm
aW5pc2hlZCByZXZpZXdpbmcgdGhlIGRyaXZlciBidXQgdGhlcmUgYXJlIHN0aWxsIGENCj4gPiA+
ID4gYnVuY2ggb2YgdGhpbmdzIHRoYXQgbG9vayBzdHJhbmdlLCBmb3IgaW5zdGFuY2UsIHlvdXIN
Cj4gPiA+ID4gLT5yZWFkL3dyaXRlX3BhZ2UoKSBpbXBsZW1lbnRhdGlvbiBsb29rcyBzdXNwaWNp
b3VzLiBMZXQncyBkaXNjdXNzIHRoYXQgYmVmb3JlIHlvdSBzZW5kIGENCj4gbmV3IHZlcnNpb24u
DQo+IA0KPiBTb3JyeSwgSSd2ZSBiZWVuIHRvbyBidXN5IHRvIGZpbmlzaCBteSByZXZpZXcgOi0v
LiBQbGVhc2Ugc3VibWl0IHRoZSBuZXcgdmVyc2lvbiBhcyBNaXF1ZWwNCj4gc3VnZ2VzdGVkLg0K
T2ssIEkgd2lsbCBkby4NCg0KVGhhbmtzLA0KTmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0KPiANCj4g
PiA+IENvdWxkIHlvdSBwbGVhc2UgcmV2aWV3IHRoZSByZW1haW5pbmcgc3R1ZmY/DQo+ID4gPiBJ
IGhhdmUgdGhlIGNoYW5nZXMgcmVhZHkgd2l0aCBtZSB3aGljaCB3aWxsIGFkZHJlc3MgYWxsIHlv
dXIgY29tbWVudHMgZ2l2ZW4gdG8gdGhpcyBzZXJpZXMuDQo+ID4gPg0KPiA+ID4gVGhhbmtzLA0K
PiA+ID4gTmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0KPiA+DQo+ID4gUGxlYXNlIHN1Ym1pdCB0aGUg
bmV3IHZlcnNpb24gdGhhdCBpcyByZWFkeSwgdGhlIHJlc3Qgb2YgdGhlIHJldmlldw0KPiA+IHdp
bGwgY29tZS4NCj4gPg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IE1pcXXDqGwNCg0K
