Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41189C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 04:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09BD2191D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 04:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sbjpVUfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09BD2191D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeHRH4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 03:56:45 -0400
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com ([104.47.36.72]:27651
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbeHRH4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 03:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGOB4RoYqeoqO0m35Z8ufRKH6L7aeLLFtM4mgSXmb4A=;
 b=sbjpVUfk1Rh84AxSOZ1uYcgRWFqev2ixYiIXA4LhRwtcsvv+Ss7nLyxlAwRqifxnnedpjcqc5abDVTeJGHgi3X6sc71OGx1N/dlEQvpuWYKc9sY3dPtdEnEQCyB+DYnsiFaZDvmTokE/6wZDfeEiYbNmOtVy5+OzKznh0xwAMjc=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2815.namprd02.prod.outlook.com (10.175.50.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.20; Sat, 18 Aug 2018 04:48:46 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68%2]) with mapi id 15.20.1038.026; Sat, 18 Aug 2018
 04:48:36 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
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
Subject: RE: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUNiz7bKojXyawJ0eL/lrCUsemM6TEA1CAgADpIlA=
Date:   Sat, 18 Aug 2018 04:48:35 +0000
Message-ID: <MWHPR02MB2623E97FE72F5ABC3D0A3AABAF3C0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20180817163733.34d3199c@xps13>
In-Reply-To: <20180817163733.34d3199c@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2815;6:3AKWbENX62thQrisit73M2V2srxO7gvZdurtXMf/EhTXP4ce1KMMxAOlDSEzkXm6NsaJC+ucxOBQzyyHKU+BqTWjS1c8ZABQbpc47U0KEdqv5zArsahyM1vkmcT8GJrHd71vL6OcMMBRlsQvu2Ot7qqjFM18aX1I8VzbTYqO7RfxVYqXhXxcAZ6hBJ+P4r9SNoRcqwCOb8qaOg+ZsiWKVAAWOJVz3QPPyKV0TU9WLLz6bnjqWl7CXhJXlP1unCH6MpnpmFg1TNxW2H90WggP7ZIuvHhAisoE3nzEwsaQGGkFLnw+y48bWfXFrM0PHsaq9l3lQ4adfZMVHUtFGpjQh+NiGD/1hNLqNTL/8u2GmR3NNZ16n2E/ZRzErLv8HPVeQ6R0ie4QSZsOSq1ZoTVOpYet1UG5C1x7B/0YDaSIQXCJs/jMEuoeWVIR7NcqIUaB15LpPxNMQtrcaX+qVvDMVA==;5:bJ+3awUM8cNY9a2378XTYcrLz5XZvNoHAKwHwrINV7DBlAfxPKzPAZwXaGuG9tlyirsjtf5hA4rYWLXI/BBzEuOxj2D14JdhMs/txjAqr4ZEqIEfk5FOHigwTjCPVZxk/Nx5xZ33iFc1eIrJ5W6Nk8e69RdBiyQsUrvZYwVgF+g=;7:EUemnqY6aafBfTaKjrjuOVMAEzCGUGGqw/DlaiQH0Y8iu/5xGlUa0u9LF06LFiRGC/uQaUvC09hAO0++dmOdRDxRwBNu7oIuN8hehiAdbv+lyRW7qZZOT0qxGEXeQYfq0cW8Gv5zdLe7yE/3vp4TvbtpWTNqKbAg7gsV2TuQpX+WEhL+MVnbm8KPTg6zz5tHH65lL1R5qwcpV1dVuvP+ZI/6t0MoPYGEvVtehxCz8DyKTO5Snawkps9pWbmLqdVM
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(13464003)(51914003)(199004)(189003)(4326008)(39060400002)(25786009)(6246003)(476003)(11346002)(6436002)(55016002)(229853002)(14454004)(2900100001)(106356001)(6116002)(486006)(446003)(8676002)(3846002)(97736004)(81166006)(86362001)(81156014)(9686003)(66066001)(53936002)(14444005)(68736007)(5250100002)(316002)(7696005)(6506007)(6916009)(5660300001)(99286004)(256004)(53546011)(54906003)(305945005)(7736002)(74316002)(8936002)(478600001)(33656002)(105586002)(7416002)(2906002)(186003)(76176011)(217873002)(102836004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2815;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: baf70721-4518-4ef8-a13e-08d604c5dbb7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2815;
x-ms-traffictypediagnostic: MWHPR02MB2815:
x-microsoft-antispam-prvs: <MWHPR02MB28154F51BDD19AA36DCDF1BFAF3C0@MWHPR02MB2815.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(34377916053724)(211171220733660)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301072)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:MWHPR02MB2815;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2815;
x-forefront-prvs: 076804FE30
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3ZRgmOB6F6qgK+qOvLoj/GHYNlSTwTVOJeXqyIOHuGOAllrVLi0oAKNFN9m5MBbQlgwi3c9zv7jgGefVj+Vnr136vO5wHSWMgiL02uMmD+WzF5tBbJvjQIQEqbyxGWbQJLppckVirHgBPxnOfkKAmeheNpXOW+RV9Aj3dJnS/1pyMc0Z+M/geiQjDGWoTyO6hdy7eItDYxiqOR9uWnrHRtLwLxNLddPniiZN4VUopVbrdIoewEtWJwPftIYKDjFb0oEqNr/kIMDZLu8BDB6xrzZAptJhQCX9G2nzOLxhboF5xTNhnDMf8jRU9vH/8XE0Fyi7/cuO7YFxWfjbzdd9lyZVAGjrjIF1SS0kOPI6a50=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf70721-4518-4ef8-a13e-08d604c5dbb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2018 04:48:35.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCBbbWFpbHRvOm1pcXVlbC5yYXluYWxA
Ym9vdGxpbi5jb21dDQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDE3LCAyMDE4IDg6MDggUE0NCj4g
VG86IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJlQHhpbGlueC5jb20+DQo+IENjOiBi
b3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb207IHJpY2hhcmRAbm9kLmF0OyBkd213MkBpbmZyYWRl
YWQub3JnOw0KPiBjb21wdXRlcnNmb3JwZWFjZUBnbWFpbC5jb207IG1hcmVrLnZhc3V0QGdtYWls
LmNvbTsga3l1bmdtaW4ucGFya0BzYW1zdW5nLmNvbTsNCj4gYWJzYWh1QGNvZGVhdXJvcmEub3Jn
OyBwZXRlcnBhbmRvbmdAbWljcm9uLmNvbTsgZnJpZWRlci5zY2hyZW1wZkBleGNlZXQuZGU7IGxp
bnV4LQ0KPiBtdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+Ow0KPiBuYWdhc3VyZXNoa3Vt
YXJyZWxsaUBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtMSU5VWCBQQVRDSCB2MTAgMi8yXSBt
dGQ6IHJhd25hbmQ6IGFyYXNhbjogQWRkIHN1cHBvcnQgZm9yIEFyYXNhbg0KPiBOQU5EIEZsYXNo
IENvbnRyb2xsZXINCj4gDQo+IEhpIE5hZ2EsDQo+IA0KPiBBIHVzZXIgb2YgWGlsaW54IEJTUCBy
ZXBvcnRlZCBhIHByb2JsZW0gd2l0aCBsb2NrZGVwIHRoYXQgSSBjYW4gc2VlIGlzIG5vdCB5ZXQg
Zml4ZWQgaW4gdGhpcw0KPiBjb2RlOg0KSSBkaWRuJ3Qga25vdyB0aGlzLiB0aGFua3MgZm9yIHJl
cG9ydGluZyB0aGUgaXNzdWUuIGxldCBtZSBjaGVjay4NCj4gDQo+IE5hZ2EgU3VyZXNoa3VtYXIg
UmVsbGkgPG5hZ2Euc3VyZXNoa3VtYXIucmVsbGlAeGlsaW54LmNvbT4gd3JvdGUgb24gRnJpLCAx
NyBBdWcgMjAxOA0KPiAxODo0OToyNCArMDUzMDoNCj4gDQo+ID4gK3N0YXRpYyBpbnQgYW5mY19w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+ID4gKwlzdHJ1Y3QgYW5mY19u
YW5kX2NvbnRyb2xsZXIgKm5mYzsNCj4gPiArCXN0cnVjdCBhbmZjX25hbmRfY2hpcCAqYW5hbmRf
Y2hpcDsNCj4gPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBwZGV2LT5kZXYub2Zfbm9kZSwg
KmNoaWxkOw0KPiA+ICsJc3RydWN0IHJlc291cmNlICpyZXM7DQo+ID4gKwlpbnQgZXJyOw0KPiA+
ICsNCj4gPiArCW5mYyA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKm5mYyksIEdG
UF9LRVJORUwpOw0KPiA+ICsJaWYgKCFuZmMpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4g
Kw0KPiA+ICsJaW5pdF93YWl0cXVldWVfaGVhZCgmbmZjLT5jb250cm9sbGVyLndxKTsNCj4gDQo+
IFRoZSBjb250cm9sbGVyIHN0cnVjdHVyZSBoYXMgYSBsb2NrIHdoaWNoIGlzIG5vdCBpbml0aWFs
aXplZCBoZXJlLiBZb3Ugc2hvdWxkIG5vdCBpbml0aWFsaXplIHRoZQ0KPiB3YWl0cXVldWUgbWFu
dWFsbHkgbmVpdGhlciBhbmQgaW5zdGVhZCB1c2UgbmFuZF9jb250cm9sbGVyX2luaXQoJm5mYy0+
Y29udHJvbGxlcikuDQpPay4gSnVzdCBub3cgSSBzYXcgbWFydmVsbCBuYW5kIGRyaXZlci4gSSB3
aWxsIHVwZGF0ZSBhY2NvcmRpbmdseS4NCj4gDQo+ID4gKwlJTklUX0xJU1RfSEVBRCgmbmZjLT5j
aGlwcyk7DQo+ID4gKwlpbml0X2NvbXBsZXRpb24oJm5mYy0+ZXZlbnQpOw0KPiA+ICsJbmZjLT5k
ZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgbmZjKTsN
Cj4gPiArCW5mYy0+Y3NudW0gPSAtMTsNCj4gPiArCW5mYy0+Y29udHJvbGxlci5vcHMgPSAmYW5m
Y19uYW5kX2NvbnRyb2xsZXJfb3BzOw0KPiANCj4gTW9yZSB0byBjb21lLg0KDQpUaGFua3MsDQpO
YWdhIFN1cmVzaGt1bWFyIFJlbGxpLg0KPiANCj4gVGhhbmtzLA0KPiBNaXF1w6hsDQo=
