Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD63ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D992081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="CA6uxHWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D992081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeKIFb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:31:29 -0500
Received: from mail-eopbgr740055.outbound.protection.outlook.com ([40.107.74.55]:6690
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbeKIFb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Oy+EHUew50a4WwzzL+iPFE1YWFo4MV1tfsCf6ow14A=;
 b=CA6uxHWXY15M1TxhrZ0P9yxn3MTyhf3m6P5+q5/oivfq58ME5xAK+BIxkBMBgUdR0jHGxTejJAD/xrBBKYi85cDbvyv4GSecBO8JeoFvxgKNTw1qLNlfvqbsLxhDJnEZj+Sw6/y3KPLCOlZ1o5mk2I6x3bb05IK2O/T9d/B9O+I=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5911.namprd05.prod.outlook.com (20.178.50.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.16; Thu, 8 Nov 2018 19:54:22 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.009; Thu, 8 Nov 2018
 19:54:22 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "hpa@zytor.com" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Topic: [PATCH v9 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Index: AQHUW2CZ0dZfAolPxUG9hT8O5ZUp5qVDToGAgAAFpACAAAwfgIABcMKAgAAOcACAAAERgIAALpuAgAAB5wCAAI3zgIAAt2kAgAAshwA=
Date:   Thu, 8 Nov 2018 19:54:22 +0000
Message-ID: <080748A5-2588-47C9-BC2A-E643630FB9A7@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-3-namit@vmware.com>
 <89262174-6f15-6116-e67f-436f7c1bfe99@deltatee.com>
 <6651971B-E3AB-4CDD-868C-2338593F7D83@vmware.com>
 <d0812681-4a8f-8cc4-24ce-d02002ee34d2@deltatee.com>
 <DC1EA50F-FAC3-4750-BCF7-0622D1FB4756@vmware.com>
 <a3902c4c-64b1-9c49-02fb-d5e4c9b04314@deltatee.com>
 <192946CF-8543-4CF5-B2A3-93674FCD07E2@vmware.com>
 <7bc80811-8ab3-d26a-6fb3-b7aeebcfce43@deltatee.com>
 <85B77A64-5FF3-4B82-8A07-E045E259C985@zytor.com>
 <3B824A03-AB76-4B34-B1CA-F27C0F1B0575@vmware.com>
 <2c022676-9299-bb5f-023b-5c114cd79f81@deltatee.com>
In-Reply-To: <2c022676-9299-bb5f-023b-5c114cd79f81@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4580:b719:dc2c:5266:45a2:22ce]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5911;20:dsVqQPQrYdFEx5Ui2EStRMMdcXUgnTnZ1R6ipJDwXxLKqqd+TV6dvfUqupOs2f20Zu85/tMeBL/K5DZGGjRAysEq8lBUNnyyJAX03QMSNKJbNZNZWQDIzv9LDBnjrO500/ZscdXZJmTIFA61+N3cNp+MWjd5TJCRKi+0RP/wec4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3f20f170-941a-4f0d-3883-08d645b3fa94
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5911;
x-ms-traffictypediagnostic: BYAPR05MB5911:
x-microsoft-antispam-prvs: <BYAPR05MB5911621C0F981C06E2142B70D0C50@BYAPR05MB5911.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5911;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5911;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(39860400002)(396003)(199004)(189003)(46003)(6116002)(25786009)(186003)(2906002)(68736007)(2900100001)(71200400001)(106356001)(7416002)(86362001)(6436002)(71190400001)(82746002)(256004)(11346002)(2616005)(8936002)(8676002)(446003)(486006)(81156014)(54906003)(105586002)(110136005)(81166006)(305945005)(4326008)(5660300001)(7736002)(316002)(102836004)(99286004)(97736004)(93886005)(53936002)(229853002)(2501003)(83716004)(6486002)(6246003)(36756003)(478600001)(6506007)(14454004)(76176011)(33656002)(53546011)(6512007)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5911;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VQ19Mh88K0XpXGUlsh8ExwqL7ZpscEz5gpsCeY5lY+K9K7T2pSiTHH6L+l3WiBI79mScIXQ+Fw/nmtZkL4GcBdZEZl/BKe74pOx1t8R/Opl5Pl5vG/erENRLC5aQDrvQJ8EpVWme3E5201jKBY5Cpz8JnUyMpYzxxVMHBNNVda+0bnPIw7qT6P8hpDS8t/s5LGIlEMwgzgOIhkKeS5IHerhu1V1a8AxP74FSOhGvzewEhNfLMgH65AM07oWgp5MCpzwRZE6T32OxzNZvSCljX0uja5My7oAoTsc8Wdj7vJvzID6PYBVxElTqDRK99Si7Zi4RxvWEs8rLNr/NDtRHSDzD5d2+3kWGxQZNa/kNbwU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <12F5485F1E903D4CB4E7F8EFC9A3B29E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f20f170-941a-4f0d-3883-08d645b3fa94
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 19:54:22.3421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTG9nYW4gR3VudGhvcnBlDQpTZW50OiBOb3ZlbWJlciA4LCAyMDE4IGF0IDU6MTQ6NTgg
UE0gR01UDQo+IFRvOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiwgaHBhQHp5dG9yLmNv
bSA8aHBhQHp5dG9yLmNvbT4sIEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPg0KPiBDYzog
TEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4sIFg4NiBNTCA8eDg2QGtlcm5lbC5v
cmc+LCBTYW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+LCBNaWNoYWwgTWFyZWsgPG1pY2hh
bC5sa21sQG1hcmtvdmkubmV0PiwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+
LCBMaW51eCBLYnVpbGQgbWFpbGluZyBsaXN0IDxsaW51eC1rYnVpbGRAdmdlci5rZXJuZWwub3Jn
PiwgU3RlcGhlbiBCYXRlcyA8c2JhdGVzQHJhaXRobGluLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2OSAwMi8xMF0gTWFrZWZpbGU6IFByZXBhcmUgZm9yIHVzaW5nIG1hY3JvcyBmb3IgaW5s
aW5lIGFzbQ0KPiANCj4gDQo+IA0KPiANCj4gT24gMjAxOC0xMS0wNyAxMToxOCBwLm0uLCBOYWRh
diBBbWl0IHdyb3RlOg0KPj4+IEFwcGFyZW50bHkgZ2NjIHdpbGwgdHJlYXQgdGhlbSBsaWtlIGJh
c2ljIGJsb2NrcyBhbmQgcG9zc2libHkgbW92ZSB0aGVtIGFyb3VuZC4NCj4+IA0KPj4gTWF5YmUg
aXQgaXMgcG9zc2libGUgdG8gYnJlYWsgdGhlIGNvbXBpbGF0aW9uIG9mIGVhY2ggb2JqZWN0IGlu
dG8gdHdvDQo+PiBzdGFnZXM6IGZpcnN0LCBjb21waWxlIHRoZSBzb3VyY2Ugd2l0aG91dCBhc3Nl
bWJseSwgYW5kIHRoZW4gdGFrZSB0aGUNCj4+IGdlbmVyYXRlZCAucyBmaWxlIGFuZCBhc3NlbWJs
ZSBpdCB3aXRoIHRoZSAucyBmaWxlIG9mIHRoZSBtYWNyb3MuDQo+PiANCj4+IERvZXMgaXQgc291
bmRzIGFzIHNvbWV0aGluZyB0aGF0IG1heSB3b3JrPyBJIGd1ZXNzIGl0IHNob3VsZCBvbmx5IGJl
IGRvbmUNCj4+IHdoZW4gZGlzdGNjIGlzIHVzZWQuDQo+IA0KPiBJbiB0aGVvcnkgaXQgd291bGQg
YXQgbGVhc3QgYWxsb3cgdGhlIGNvbXBpbGUgc3RlcCB0byBiZSBkaXN0cmlidXRlZCwNCj4gdGhl
IGFzc2VtYmx5IHN0ZXAgd291bGQgc3RpbGwgaGF2ZSB0byBiZSBkb25lIGxvY2FsbHkuLi4gSXQn
ZCBiZSBiZXR0ZXINCj4gdGhhbiBub3RoaW5nLCBJIGd1ZXNzLg0KDQpJIGRvbuKAmXQgdGhpbmsg
dGhlIGFzc2VtYmx5IHN0YWdlIG5lZWRzIHRvIGJlIGRvbmUgbG9jYWxseS4gZ2NjIGNhbiBzdGls
bCBiZQ0KdXNlZCB0byBkZXBsb3kgdGhlIGFzc2VtYmxlci4gSSBhbSBub3QgdG9vIGZhbWlsaWFy
IHdpdGggZGlzdGNjLCBzbyBJIGRvbuKAmXQNCmtub3cgd2hldGhlciB0aGUgcHJlcHJvY2Vzc2lu
ZyBzdXBwb3J0cyBtdWx0aXBsZSBzb3VyY2UtZmlsZXMsIGFuZCB3aGV0aGVyDQppdCBoYXMgc29t
ZSBzdHJhbmdlLWJlaGF2aW9yIHdoZW4gaXQgY29tZXMgdG8gLlMvLnMgZmlsZXMuDQoNCldlbGws
IEnigJlsbCBnaXZlIGl0IGEgdHJ5Lg0KDQo=
