Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B98C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57FD20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="K6UXK+Dj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfA1Jf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:35:56 -0500
Received: from mail-eopbgr680054.outbound.protection.outlook.com ([40.107.68.54]:45165
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfA1Jfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg2MmZhWnDybdQpFVaBND0Ld1hkabtc06CLVh1zGRXU=;
 b=K6UXK+Djr0aTonV848UtBQCWjyqiEh170pGefm4jHkfpSAoaJeR6I265Hub3+D95oUz1FdzO4DKRuBQykumTnkFzrJOliK949NL3xYI2arFpXX3otBj5pEkL/gW4M/VjfT29/BstcIjK1+RVgx1gZD+E1quDqx2u/o655+eQyQk=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2333.namprd02.prod.outlook.com (10.168.244.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Mon, 28 Jan 2019 09:35:51 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::d587:e08c:61f5:7aae]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::d587:e08c:61f5:7aae%5]) with mapi id 15.20.1558.021; Mon, 28 Jan 2019
 09:35:51 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
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
Thread-Index: AQHUd+lSRlJXewM/lk6msOyQbhKEh6VQmgMggAVkGQCAAK7ewIAAH7YAgAFcNKCAAGhpAIAAGiwAgATHTPCAHUh8EIAAOYWAgAAN+ACAAAI3gIAAQgWwgAADhoCAB72ScIAAVsEAgADHyzCAAjdOgIACr13ggDn7tyCAAd6ZgIAAAQ/g
Date:   Mon, 28 Jan 2019 09:35:51 +0000
Message-ID: <MWHPR02MB262380CDFCCC382E2181BBA0AF960@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
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
        <MWHPR02MB262396FFF946A95D7821D61BAFB80@MWHPR02MB2623.namprd02.prod.outlook.com>
        <MWHPR02MB262328DF62906C01DCDF18E5AF960@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20190128102720.70a52da7@xps13>
In-Reply-To: <20190128102720.70a52da7@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2333;6:IcS5csP87zG3T2w+bNyOKRTDYMVKIu/apKvSboNVQ+sutp0IRGcZk3Ytl7OsxlXddgqXNwQHXE2y0XxZY2xuYxZGKj8FJJRncmO7dEqqqmkKhedWZXRvQHGP3m+DY7aKjK3gnzFp6iA2K0n3cAQ8ir4XVb1Fh+oydsbRXuqLiXio7XcYhpA9pf95v9gHH/mWZcVvjMM9ryVOsdOkaCQ5myHO0DkFF3ABPnJ/OPeHBRFabA+tzEhB80PaAnCPGaYIgXYxIk6EIGf1hNCkm9+3mcz8Gwb2tPLonY9+5OufdBYZ7ptnYQsC/mKCrAxk4nI/RUvp3NkXFgikSOme+QJHMnVJQc2KPkkWI+rlK70hequ9BjP7cg2YllmYCNlAGWdWc4hOsJrT42A7UqQ3Ndv81GpGbgHDQRErHV8VT2NmPP9muDFw+zRLibBFVrvjdSIl7jXpJIyVbNgKR643JsRAQA==;5:jy96F2J4s3BfTZEv+atoR9ZO0BXLmIpVir1/5ss/7mvAo/P1Jg3EEHtgncuW+13JRGUPKt+SUYhGDD0tw0Bp8cywgBSe6SGUq1hQwXEoyq1u+3Xxn4sl3D8KE/NOYHUqSxM2jw2/5Lvmw6JWERV4m6MbtPaXXmlvvEaDqSUmnz7kK2Gp+NiEAHCO+ljqu2h9mx0L3z9jKrOpEqr+TSbxEg==;7:87LE8y9hwMYKlQAU+cN2q4KvfE9xWSiq9quTyvsx4eY9n9bJeNIijv6UHCgBi3uosJhBzR/JbVaxVYoX9pz1mBYCkQXrmfd10VotKYz6xg9CG4rF2kSnZdvGj4KdxZhOT57EWUh4+LudQxCLugBcbg==
x-ms-office365-filtering-correlation-id: 07d7f5c0-81be-4cc5-7b90-08d68503fe34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2333;
x-ms-traffictypediagnostic: MWHPR02MB2333:
x-microsoft-antispam-prvs: <MWHPR02MB2333FE81605FEAF193433822AF960@MWHPR02MB2333.namprd02.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(13464003)(189003)(199004)(6916009)(9686003)(66066001)(345774005)(33656002)(66574012)(55016002)(71200400001)(7736002)(305945005)(486006)(476003)(97736004)(71190400001)(14444005)(256004)(39060400002)(11346002)(446003)(4326008)(217873002)(316002)(68736007)(25786009)(99286004)(86362001)(54906003)(6436002)(53936002)(6246003)(74316002)(229853002)(102836004)(2906002)(106356001)(14454004)(105586002)(3846002)(8936002)(26005)(6116002)(8676002)(93886005)(81156014)(53546011)(81166006)(6506007)(7416002)(478600001)(186003)(7696005)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2333;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R86qPZAIM0g9r4FzIIQjwyKg2JnbKOf0nexYzeGcqiRFiJ1TH9Wlnvd6I24NoNhTOI7MGqnkq1dHhJ08qO9zPbzbL1NoVrbCmoBEDyg8npp95Bj1XAy77ZTJ3b9zsH32ldFxjHTYVUH66FeHfSS1RZLri1DVgJhIoei+XfTW5oZSnSRFPIqoUr3HN7f6WgzHLT3VarFWFVihRtEkkZTRNWY/XqIZ089/jon+TjxnH5R0/cQmzQIyiGZh2YUBfLZNVYWd7+/7tUs/EdtUimx6xh4RLqVwW2dHMeHenagWio2KvpIh3uVAFWQl0Z8o7O5C1rD9yhpE67oJBikiILlRS2nVK0vidoa7VEkjYWDpZMJusjDpZSpcR0rnMfXQHRAXcQl/4vVGeA+3wYx7NN8Ae0Jl0Vl1xrVPAxAijs2rpto=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d7f5c0-81be-4cc5-7b90-08d68503fe34
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 09:35:51.3820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlx
dWVsIFJheW5hbCBbbWFpbHRvOm1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb21dDQo+IFNlbnQ6IE1v
bmRheSwgSmFudWFyeSAyOCwgMjAxOSAyOjU4IFBNDQo+IFRvOiBOYWdhIFN1cmVzaGt1bWFyIFJl
bGxpIDxuYWdhc3VyZUB4aWxpbnguY29tPg0KPiBDYzogcm9iaEBrZXJuZWwub3JnOyBtYXJlay52
YXN1dEBnbWFpbC5jb207IHJpY2hhcmRAbm9kLmF0OyBtYXJ0aW4ubHVuZEBrZWVwLWl0LQ0KPiBz
aW1wbGUuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBCb3JpcyBCcmV6aWxsb24g
PGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbT47DQo+IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBuYWdhc3VyZXNoMTJAZ21haWwuY29tOyBNaWNoYWwgU2ltZWsNCj4gPG1pY2hhbHNA
eGlsaW54LmNvbT47IGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbTsgZHdtdzJAaW5mcmFkZWFk
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW0xJTlVYIFBBVENIIHYxMiAzLzNdIG10ZDogcmF3bmFuZDog
YXJhc2FuOiBBZGQgc3VwcG9ydCBmb3IgQXJhc2FuDQo+IE5BTkQgRmxhc2ggQ29udHJvbGxlcg0K
PiANCj4gSGkgTmFnYSwNCj4gDQo+IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJlQHhp
bGlueC5jb20+IHdyb3RlIG9uIE1vbiwgMjggSmFuIDIwMTkNCj4gMDY6MDQ6NTMgKzAwMDA6DQo+
IA0KPiA+IEhpIEJvcmlzICYgTWlxdWVsLA0KPiA+DQo+ID4gQ291bGQgeW91IHBsZWFzZSBwcm92
aWRlIHlvdXIgdGhvdWdodHMgb24gdGhpcyBkcml2ZXIgdG8gc3VwcG9ydCBIVy1FQ0M/DQo+ID4g
QXMgSSBzYWlkIHByZXZpb3VzbHksIHRoZXJlIGlzIG5vIHdheSB0byBkZXRlY3QgZXJyb3JzIGJl
eW9uZCBOIGJpdC4NCj4gPiBJIGFtIG9rIHRvIHVwZGF0ZSB0aGUgZHJpdmVyIGJhc2VkIG9uIHlv
dXIgaW5wdXRzLg0KPiANCj4gV2Ugd29uJ3Qgc3VwcG9ydCB0aGUgRUNDIGVuZ2luZS4gSXQgc2lt
cGx5IGNhbm5vdCBiZSB1c2VkIHJlbGlhYmx5Lg0KPiANCj4gSSBhbSB3b3JraW5nIG9uIGEgZ2Vu
ZXJpYyBFQ0MgZW5naW5lIG9iamVjdC4gSXQncyBnb25uYSB0YWtlIGEgZmV3IG1vbnRocyB1bnRp
bCBpdCBnZXRzDQo+IG1lcmdlZCBidXQgYWZ0ZXIgdGhhdCB5b3UgY291bGQgdXBkYXRlIHRoZSBj
b250cm9sbGVyIGRyaXZlciB0byBkcm9wIGFueSBFQ0MtcmVsYXRlZA0KPiBmdW5jdGlvbi4gQWx0
aG91Z2ggdGhlIEVDQyBlbmdpbmUgcGFydCBpcyBibG9ja2luZywgcmF3IGFjY2VzcyBzdGlsbCBs
b29rIHdyb25nIGFuZCB0aGUNCj4gZHJpdmVyIHN0aWxsIG5lZWRzIGNoYW5nZXMuDQoNClRoYW5r
IHlvdSBmb3IgdGhlIHVwZGF0ZS4NClllcywgY3VycmVudGx5IEVDQyBlbmdpbmUgcGFydCBpcyBi
bG9ja2luZy4NCkFsc28gd2hlbmV2ZXIgeW91IGhhdmUgdGltZSwgcGxlYXNlIHByb3ZpZGUgeW91
ciBjb21tZW50cyB0byB0aGUgZHJpdmVyIHYxMiBwYXRjaC4NCkkgd2lsbCB1cGRhdGUgdGhvc2Uu
DQoNClRoYW5rcywNCk5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkNCj4gDQo+IA0KPiBUaGFua3MsDQo+
IE1pcXXDqGwNCg==
