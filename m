Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E4EC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E9C2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="S/Xqp5QX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E9C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJ2Vy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:54:29 -0400
Received: from mail-bl2nam02on0053.outbound.protection.outlook.com ([104.47.38.53]:65456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725915AbeJ2Vy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaTX/cDRsc+zfNmb/slK1aBeIX/qRgLh4jATJtgnjZU=;
 b=S/Xqp5QXxL+vtqwLFw4xP8q2V9j9d0QrbcorjIpeuXOm+gu2AVCdCDe0DQqogT9X5jUIq1b6FAj9fNlSJ/5nQk1RsjQILjyofKB4F1k2v6moMfFYNSrHR5wiZ+CV+MDuN8akCAu6DgLfLe/7GehzJML6qZhl8hPDbUofVoXIFcU=
Received: from BN6PR02MB2610.namprd02.prod.outlook.com (10.173.142.137) by
 BN6PR02MB2578.namprd02.prod.outlook.com (10.173.142.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Mon, 29 Oct 2018 13:05:48 +0000
Received: from BN6PR02MB2610.namprd02.prod.outlook.com
 ([fe80::f9d3:f4ab:e736:ee8]) by BN6PR02MB2610.namprd02.prod.outlook.com
 ([fe80::f9d3:f4ab:e736:ee8%7]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 13:05:47 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
Subject: RE: [LINUX PATCH v11 0/3] Add support for Arasan NAND Flash
 controller
Thread-Topic: [LINUX PATCH v11 0/3] Add support for Arasan NAND Flash
 controller
Thread-Index: AQHUVMo9vuoXKkVBvkK1rPf3aUTcEqU2MEAAgAAzGtA=
Date:   Mon, 29 Oct 2018 13:05:47 +0000
Message-ID: <BN6PR02MB2610FC0417A77722E5F63BE3AFF30@BN6PR02MB2610.namprd02.prod.outlook.com>
References: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20181029105108.562ddd21@xps13>
In-Reply-To: <20181029105108.562ddd21@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR02MB2578;6:iXPR36clzJ6xHAXtpj65q5zmRTUGpBVE93aH4B+hBDUs6MN4U5bG1fq5s44D93ryq9fYSCaY/SwpveH6DgA32+3ZgMSpGHu7yxwdbsfNleA7+PaUbEx2A/cxc7hDJIU2KQ42ipsL3EeeuKNA+7UjMNTY195BrLZAiJbgk2sx28ZI6ZiWVhhM+40SeLQOUN+/BybvemzfjPqjMjPrZhQdV6UTe6TZUNxOAWHBbp5ht27C5+TaSmjs0C26LiclvX7HKJP1vw1o7Z0zUdWdSi4pW4Y3vPkxBfqcY4Xr9YxcfrQaoTjcvSlLxbWSnSzUtk3aMhhOEhWJp6yA96nWuWLo1+eoM0yCeXK8cgB3O28MeIWvUYdCKIM6KZSRWlmBKJqujyoVC5dbuLrCjDHA1Ngu7Zu+dVmIrjuIf6xyveHRV0E0vvUgwXJacVBlUEBaVb1XlsaKMmcfEDVXhw1aBug10A==;5:nGm9+0YBneH/dFEYGmgUsYU8Vzg3ZuhUq5IMOQeNFIUmDY9oQrtlcnAhn7HqPzmuEAUDl+pGgVqr202fhbZfSBrMjgeSSXE35X48Z/djJlq2hcoGaTHWRSFXz6dQL4xsOXxECZNOVWoPpPiKKBzAmgV1+ccKAoewafwkCtPW2zA=;7:HPkJFj5H6GV2yXo4g72PBbIxwxbWsd8Nlg3Lg9iLpIfa/7vy+FbUbDRQDfIgMj5iKr87PbDwca6o7Z1PWwcYRpK5ktrvzkFaJ4bkoRAS2GvlGitbNliSUkqa3l2q4NU5Bxvfq/HdDEeQ41pJT/CK1Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(39860400002)(396003)(189003)(13464003)(199004)(5660300001)(39060400002)(3846002)(14454004)(4326008)(186003)(26005)(25786009)(33656002)(6916009)(6116002)(229853002)(11346002)(446003)(476003)(486006)(8676002)(81166006)(8936002)(81156014)(256004)(14444005)(97736004)(66066001)(68736007)(316002)(6246003)(5250100002)(2900100001)(76176011)(7696005)(105586002)(99286004)(102836004)(53936002)(74316002)(54906003)(106356001)(86362001)(217873002)(478600001)(6506007)(53546011)(305945005)(7736002)(6436002)(9686003)(71190400001)(71200400001)(66574009)(55016002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2578;H:BN6PR02MB2610.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: df6d34e5-e82f-4dd5-a27e-08d63d9f3e69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR02MB2578;
x-ms-traffictypediagnostic: BN6PR02MB2578:
x-microsoft-antispam-prvs: <BN6PR02MB2578A13AE1688A3F5E4B343EAFF30@BN6PR02MB2578.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(258649278758335)(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR02MB2578;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2578;
x-forefront-prvs: 084080FC15
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P1tGrxhdws8cGaDJSkHFO46EYMWbhGJcXQHCJSzKafT1A4WKsG9unEUXxbEhJTG8xkvx0gGilURteCZW9aVj4Rcpe6LtPGNnm3DuKBpzSIXeiEpKhi2Lz+DGcV96Kfci6J2kP2FotRAyHBEhrdhEUrcgrg4kJejMnx/fNOVHCGq66FJnEvD2QixT43A0n7p4Z3XopnJo9Yw+STWjQ8s720/7jA3sxs9TwahUM4rPUt58ncJ1Vb4kkn9QY/9eOyak13VovAYQ2coGs+J5ysZ+GyLdVqEyrlKWdVpQdCcUkmgs6B/ha7K7F7+TD79ix/h04WZF6bzwSVao4tLlGYcqh4ZdcNPmSHbiPwg4XbBOvK0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6d34e5-e82f-4dd5-a27e-08d63d9f3e69
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 13:05:47.4771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgW21haWx0bzptaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tXQ0KPiBTZW50OiBNb25k
YXksIE9jdG9iZXIgMjksIDIwMTggMzoyMSBQTQ0KPiBUbzogTmFnYSBTdXJlc2hrdW1hciBSZWxs
aSA8bmFnYXN1cmVAeGlsaW54LmNvbT4NCj4gQ2M6IGJvcmlzLmJyZXppbGxvbkBib290bGluLmNv
bTsgcmljaGFyZEBub2QuYXQ7IGR3bXcyQGluZnJhZGVhZC5vcmc7DQo+IGNvbXB1dGVyc2ZvcnBl
YWNlQGdtYWlsLmNvbTsgbWFyZWsudmFzdXRAZ21haWwuY29tOyBsaW51eC1tdGRAbGlzdHMuaW5m
cmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTWljaGFsIFNpbWVr
IDxtaWNoYWxzQHhpbGlueC5jb20+Ow0KPiBuYWdhc3VyZXNoMTJAZ21haWwuY29tDQo+IFN1Ympl
Y3Q6IFJlOiBbTElOVVggUEFUQ0ggdjExIDAvM10gQWRkIHN1cHBvcnQgZm9yIEFyYXNhbiBOQU5E
IEZsYXNoIGNvbnRyb2xsZXINCj4gDQo+IEhpIE5hZ2EsDQo+IA0KPiBOYWdhIFN1cmVzaGt1bWFy
IFJlbGxpIDxuYWdhLnN1cmVzaGt1bWFyLnJlbGxpQHhpbGlueC5jb20+IHdyb3RlIG9uIFR1ZSwg
MjUgU2VwIDIwMTgNCj4gMTc6NTA6MjggKzA1MzA6DQo+IA0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVz
IGFkZHMgdGhlIGJhc2ljIGRyaXZlciBzdXBwb3J0IGZvciBBcmFzYW4gTkFORCBGbGFzaCBjb250
cm9sbGVyLg0KPiA+IFdlIGFyZSByZWluaXRpYXRpbmcgdGhlIHBhdGNoIHNlcmllcyBieSBmaXhp
bmcgdGhlIGNvbW1lbnRzIGdpdmVuIGJ5IE1pcXVlbCBhbmQgQm9yaXMuDQo+ID4gTWFqb3IgY2hh
bmdlcyBhcmUgZXhlY19vcCgpIGltcGxlbWVudGF0aW9uIHJlbGF0ZWQuDQo+ID4gUmViYXNlZCB0
byA0LjE5IG5hbmQgdHJlZS4NCj4gPiBUZXN0ZWQgTVQyOUYzMkcwOEFCQ0RCSjQuDQo+ID4NCj4g
PiBBcyBzdWdnZXN0ZWQgYnkgQm9yaXMsIGl0IGFsc28gYWRkcyBhIG5ldyB2YXJhaWJsZSBjYWxs
ZWQgbW9kZSBpbg0KPiA+IHN0cnVjdCBuYW5kX3Nkcl90aW1pbmdzLCB3aGljaCB3aWxsIGdpdmUg
ZGlyZWN0bHkgdGhlIHNkciBvcGVyYXRpbmcNCj4gPiBtb2RlLiBhbmQgaXQgaXMgdXNlZnVsIGZv
ciBzb21lIGNvbnRyb2xsZXJzLCB3aGVyZSB3ZSBjYW4gY29uZmlndXJlDQo+ID4gZGlyZWNsdHkg
dGhlIG9wZXJhdGluZyBtb2RlIGluc3RlYWQgb2YgdGltaW5ncy4NCj4gPg0KPiANCj4gVW5sZXNz
IEkgbWlzc2VkIHNvbWV0aGluZyB0aGVyZSBhcmUgc3RpbGwgY29tbWVudHMgZnJvbSBCb3JpcyBw
ZW5kaW5nPw0KPiBJIHdpbGwgd2FpdCBmb3IgeW91ciB2MTIgdG8gZ2l2ZSB0aGlzIGRyaXZlciBh
bm90aGVyIHNob3QuDQpzaGFsbCBJIHNlbmQgdGhlIHYxMiBvbiB0b3Agb2YgbmFuZC9mb3ItNC4y
MD8NCg0KVGhhbmtzLA0KTmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0KPiANCj4gVGhhbmtzLA0KPiBN
aXF1w6hsDQo=
