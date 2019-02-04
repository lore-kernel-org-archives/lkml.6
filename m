Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57260C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E05F20820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="aVcXCELk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfBDSDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:03:31 -0500
Received: from mailout.micron.com ([137.201.242.129]:58861 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfBDSDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:03:31 -0500
Received: from mail.micron.com (bowex17d.micron.com [137.201.21.212])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x14I2x0K005527;
        Mon, 4 Feb 2019 11:02:59 -0700
Received: from bowex36c.micron.com (137.201.84.132) by bowex17d.micron.com
 (137.201.21.212) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Mon, 4 Feb
 2019 11:02:58 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (137.201.84.23)
 by bowex36c.micron.com (137.201.84.132) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Mon, 4 Feb 2019 11:02:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df6LN7xNdCowr9cijOPW9Dd0dRs3Yo3J9a+uqIKRLI8=;
 b=aVcXCELkIt/8axrZwYggdyhqvgWiK2H5hMYPe43AHhZNJ9advFKLfLSVX7tHsjgdgce/sDu1/FdRrX8QF1RvIAvr8rIYhQdHEbD/pfkd7QzYV8+hGiDt+/vpAARJpet+Nyx/Y4Bd4YJ2hTNGMONO2xTnTpccz0JAfFQ6BdzqdrU=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.98.155) by
 MN2PR08MB5870.namprd08.prod.outlook.com (20.179.87.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Mon, 4 Feb 2019 18:02:57 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::8cda:e314:bfb0:41fe]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::8cda:e314:bfb0:41fe%5]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 18:02:56 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Emil Lenngren <emil.lenngren@gmail.com>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        "Frieder Schrempf" <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Subject: Re: [PATCH 2/2] mtd: spinand: micron: Support for all Micron SPI NAND
 flashes
Thread-Topic: [PATCH 2/2] mtd: spinand: micron: Support for all Micron SPI
 NAND flashes
Thread-Index: AdS8s2lcWEr7eBaOQtSO7/EkVUm5Nw==
Date:   Mon, 4 Feb 2019 18:02:56 +0000
Message-ID: <MN2PR08MB5951CEE5E54676FDA619490BB86D0@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR08MB5870;6:MCaNMkh0HFse1BRDPrThwb/CRQ2bzASLGPFrDwjLuK3xrAhpQuCKoq0Q2nq7Rja2K6vD+FyBuXF27CneshpI5Tbde3bG1hwXqLbcT6OxAp+7UNK9SXZyOf2w63jFgB1RY/G40Ze6pPgAp0CYoKAaoVYN3tZw691gWQcVQx2Mgplj85XNVh3Jo2etgeD6l8xA8jdqqnVzaLoZwCpmszyrCl3tB6lUDfXSdY0FaAx3Qny5ia1UjCBnTsFwYqWgWqCGYot2JbMOWdt96wuwBsoKEm1n69UYrmhG20gnQWJ8MZjSdAjRr/MEairTqufLA6c0LqkbdeU/byqzkWVZHAwloYN9nmVYWogNr+0YD23oAq2H9fU7JsVQ1VF1DvYl1rA8/x1qTdRtUbyLe4G7b57ndN+O6V1LSgX2/fRbq68awIjH/aKhLl4S7f6rv8rbfTlsOutUA+7e6ayHPW2b355qAQ==;5:ann95w+45LitmZCfNOgFyrHRjdtA37EZ5juMTNaQqQUF3CNUSzdRGbB0Ha0YOLygAt4CAMEj55pedctEtspWr8kp6suYGserPIcmuI+HQmm1+Z243j4/1kvsK9f4bLLh6G5J3+AAIcwtDu2ZwNrVGd+/3TPdYsIooapCDuWf6i9WVTmxvJTyyAyqe7p0pFWFh5RWFOx2G5FhTnOW6APfDg==;7:Xuq9BIKrzhDp1L6+I058tHlHzbOrLvfXwtlSILL7I7E/d/jgDztTMrG43hbb8qTLwuWjNSfwUszkLFWerzm06wKJFbIttNvz37PiKqiRFme+Zghwya2vUjQM3wdQ+lzrKZ/1jhMES4SDxKWoO2jACA==
x-ms-office365-filtering-correlation-id: cf7c2b05-a2a2-4153-9810-08d68acafe0b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MN2PR08MB5870;
x-ms-traffictypediagnostic: MN2PR08MB5870:|MN2PR08MB5870:
x-microsoft-antispam-prvs: <MN2PR08MB5870773D2EC61D6D67E82E06B86D0@MN2PR08MB5870.namprd08.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(366004)(136003)(199004)(189003)(305945005)(3846002)(966005)(5024004)(7736002)(14454004)(71200400001)(71190400001)(478600001)(97736004)(7696005)(256004)(6246003)(8676002)(99286004)(68736007)(6506007)(102836004)(2906002)(33656002)(4326008)(107886003)(106356001)(8936002)(74316002)(6116002)(53936002)(217873002)(55236004)(105586002)(81156014)(81166006)(229853002)(26005)(9686003)(25786009)(54906003)(66574012)(186003)(86362001)(6306002)(6436002)(66066001)(476003)(7416002)(55016002)(6916009)(316002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5870;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z3OpUHVqWH89uRXm8ST6wLZ8HfIGI2pWt4UZLvvo8CXKCDbgCPieqmvl+HAU3AJKubr9qZjlb6XTxcUo10K+ooiAMmZrTjIpPEGbB+DvKaftvWx9VP9QheAlRxnKKj5lmdwqeMABa95uWNQmBPd9FeJsPHX6kt7+JVfIWsMkCHyZpvFNmWndNSAnpKP0KrnZ5/9K6Nbcg2iRAp55/b2q8JWMPVBjgij+zNNeBvpdaghwrcTTXJirDwqThuhTsw/Z/aQlAtie/myRuasLJp4MWdefXTnUxDsJ0FWi5FDcKe+4LMNaWoHe/hpjmyGSsxcqOIe9NhaVZo6MlBzzk2ZZi6aI6+Ui4faoGzrlZtFMPTOJzci8ur6V2Ci8sjpoH0Xx4GzTQ+lQC0p9u6smexF/sVmezgGjaNtumFASc3K9W/w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7c2b05-a2a2-4153-9810-08d68acafe0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 18:02:56.8622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5870
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24408.005
X-TM-AS-Result: No--28.475100-0.000000-31
X-TM-AS-MatchedID: 150567-139010-110462-708060-700038-708733-702198-706290-7
        00057-700492-711608-121367-702020-702379-139705-780058-101349-188199-780016
        -708712-705969-701594-701298-701698-701604-106230-704425-139704-701295-7002
        72-780022-700469-705584-702358-703410-702050-709185-700648-710970-701249-70
        0047-148004-148007-148020-148046-148133-20020-20043-42000-42003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.82.98
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRW1pbCwNCg0KPiBIaSwNCj4gDQo+IERlbiBtw6VuIDQgZmViLiAyMDE5IGtsIDEyOjE4IHNr
cmV2IFNoaXZhbXVydGh5IFNoYXN0cmkgKHNzaGl2YW11cnRoeSkNCj4gPHNzaGl2YW11cnRoeUBt
aWNyb24uY29tPjoNCj4gPg0KPiA+IERyaXZlciBpcyByZWRlc2lnbmVkIHVzaW5nIHBhcmFtZXRl
ciBwYWdlIHRvIHN1cHBvcnQgYWxsIHRoZSBNaWNyb24NCj4gPiBTUEkgTkFORCBmbGFzaGVzLg0K
PiA+DQo+ID4gUGFyYW1ldGVyIHBhZ2Ugb2YgTWljcm9uIGZsYXNoZXMgaXMgc2ltaWxhciB0byBP
TkZJIHBhcmFtZXRlciB0YWJsZQ0KPiA+IGFuZCBmdW5jdGlvbmFsaXR5IGlzIHNhbWUsIHNvIGNv
cGllZCBzb21lIG9mIHRoZSBjb21tb24gZnVuY3Rpb25zIGxpa2UNCj4gPiBjcmMxNiBhbmQgYml0
X3dpc2VfbWFqb3JpdHkgZnJvbSBuYW5kX29uZmkuYy4NCj4gPg0KPiA+IFRoaXMgZHJpdmVyIGlz
IHRlc3RlZCB1c2luZyBNVDI5RjJHMDFBQlhHRCwgTVQyOUY0RzAxQUJYRkQsDQo+ID4gTVQyOUY4
RzAxQURYRkQsIE1UMjlGMUcwMUFCWEZELg0KPiA+DQo+IA0KPiA+IC1zdGF0aWMgY29uc3Qgc3Ry
dWN0IHNwaW5hbmRfaW5mbyBtaWNyb25fc3BpbmFuZF90YWJsZVtdID0gew0KPiA+IC0gICAgICAg
U1BJTkFORF9JTkZPKCJNVDI5RjJHMDFBQkFHRCIsIDB4MjQsDQo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgTkFORF9NRU1PUkcoMSwgMjA0OCwgMTI4LCA2NCwgMjA0OCwgMiwgMSwgMSksDQo+IA0K
PiA+ICsgICAgICAgZGV2aWNlaW5mby5tZW1vcmcuZXJhc2VibG9ja3NfcGVyX2x1biA9DQo+ID4g
KyAgICAgICAgICAgICAgIHBhcmFtcy0+YmxvY2tzX3Blcl9sdW4gKiBwYXJhbXMtPmx1bl9jb3Vu
dDsNCj4gPiArICAgICAgIGRldmljZWluZm8ubWVtb3JnLnBsYW5lc19wZXJfbHVuID0gcGFyYW1z
LT5sdW5fY291bnQ7DQo+ID4gKyAgICAgICBkZXZpY2VpbmZvLm1lbW9yZy5sdW5zX3Blcl90YXJn
ZXQgPSAxOw0KPiA+ICsgICAgICAgZGV2aWNlaW5mby5tZW1vcmcubnRhcmdldHMgPSAxOw0KPiAN
Cj4gPiArICAgICAgIF9fbGUzMiBibG9ja3NfcGVyX2x1bjsNCj4gPiArICAgICAgIHU4IGx1bl9j
b3VudDsNCj4gPiArICAgICAgIHU4IGFkZHJfY3ljbGVzOw0KPiA+ICsgICAgICAgdTggYml0c19w
ZXJfY2VsbDsNCj4gPiArICAgICAgIF9fbGUxNiBiYl9wZXJfbHVuOw0KPiANCj4gSSBoYXZlIGEg
cXVlc3Rpb24gYWJvdXQgdGhlIGx1bl9jb3VudC4gQXMgaXQgaXMgbm93LCB0aGUgcGxhbmVzX3Bl
cl9sdW4NCj4gcGFyYW1ldGVyIGlzIGluaXRpYWxpemVkIHRvIDIgaW4gTkFORF9NRU1PUkcuIElu
IHlvdXIgcGF0Y2gsIGl0IGlzIGluc3RlYWQNCj4gaW5pdGlhbGl6ZWQgZnJvbSB0aGUgImx1bl9j
b3VudCIgcHJvcGVydHkgZnJvbSB0aGUgcGFyYW1ldGVyIHRhYmxlLiBCdXQgSQ0KPiBsb29rZWQg
YXQgYSBkYXRhc2hlZXQgSSBmb3VuZCBieSBhIHNpbXBsZSBHb29nbGUgc2VhcmNoDQo+IChodHRw
czovL3d3dy5nb29nbGUuc2Uvc2VhcmNoP3E9bWljcm9uK25hbmQrc3BpK2RhdGFzaGVldCksDQo+
IHRoZSBmaXJzdCBoaXQgaXMgdG8gdGhlIDEgR2IgZmxhc2ggTVQyOUYxRzAxQUFBREQuIFRoYXQg
ZGV2aWNlIGNsZWFybHkgaGFzDQo+IHR3byBwbGFuZXMgcGVyIGx1biAoeW91IG5lZWQgdGhlICJw
bGFuZSBzZWxlY3QiIGJpdCBpbiB0aGUgcmVxdWVzdHMpLCBidXQgc3RpbGwsDQo+IGFjY29yZGlu
ZyB0byB0aGUgcGFyYW1ldGVyIHBhZ2UgZGF0YSBzdHJ1Y3R1cmUsIGJ5dGUgMTAwLCBOdW1iZXIg
b2YgbG9naWNhbA0KPiB1bml0cyBpcyBzZXQgdG8gMDFoLiBBbHNvLCB0aGUgImJsb2NrcyBwZXIg
bHVuIiBjb3VudCwgd2hpY2ggaXMgY2FsbGVkICJibG9ja3MgcGVyDQo+IHVuaXQiIGlzIDEwMjQs
IHdoaWNoIHNob3VsZCBiZQ0KPiA1MTIgaWYgdGhpcyBwYXJhbWV0ZXIgcmVhbGx5IG1lYW50ICJi
bG9ja3MgcGVyIHBsYW5lIiBhbmQgdGhlIGNhbGN1bGF0aW9uIGluDQo+IHRoZSBwYXRjaCB3YXMg
Y29ycmVjdC4NCg0KWW91IGFyZSByaWdodCwgSSBzb21laG93IGRpZG4ndCBzZW5kIHRoZSBjb3Jy
ZWN0IHBhdGNoIGZvciB0aGlzLg0KVGhpcyBpcyBteSBmaXJzdCB0aW1lIHNlbmRpbmcgcGF0Y2gg
dG8gbWFpbmxpbmUsIGxvc3QgaW4gbmVydm91c25lc3MuDQoNCkluIG1pY3JvbiBmbGFzaGVzIHdl
IGNhbiBpZGVudGlmeSBudW1iZXIgb2YgcGxhbmVzIGluIExVTiB1c2luZyANCnBhcmFtZXRlciBw
YWdlIEJ5dGUgMTY2IC0+IHZlbmRvcl9zcGVjaWZpY1swXS4NCkJ5dGUgMTY2IHdpbGwgYmUgIjEi
LCBpZiBMVU4gaGFzIG1vcmUgdGhhbiBvbmUgcGxhbmUuIA0KSSB3aWxsIHJlc2VuZCB0aGUgY29y
cmVjdCBwYXRjaC4NCg0KSG93ZXZlciwgdGhlIGRldmljZSB5b3UgbWVudGlvbmVkIGlzIG9ic29s
ZXRlLCB2ZXJ5IG9sZCBhbmQgbm90IGluIHByb2R1Y3Rpb24uDQpUaGlzIGNvZGUgd2lsbCBub3Qg
c3VwcG9ydCB0aGF0Lg0KUGxlYXNlIHJlZmVyIG5ldyBkYXRhc2hlZXRzIG1lbnRpb25lZCBpbiB0
aGUgY29tbWl0IG1lc3NhZ2VzLg0KDQo+IA0KPiBBcyBhIHJlZmVyZW5jZSwgdGhlIDIgR2IgdmVy
c2lvbiBvZiB0aGUgTWFjcm9uaXggZmxhc2gNCj4gKGh0dHA6Ly93d3cubWFjcm9uaXguY29tL0xp
c3RzL0RhdGFzaGVldC9BdHRhY2htZW50cy82ODY2L01YMzVMRjJHRQ0KPiA0QUIsJTIwM1YsJTIw
MkdiLCUyMHYxLjUucGRmKSwNCj4gYWxzbyBoYXMgdHdvIHBsYW5lcyBwZXIgbHVuLiBJdCBhbHNv
IHNldHMgYnl0ZSAxMDAsIE51bWJlciBvZiBsb2dpY2FsIHVuaXRzIHRvDQo+IDAxaC4NCj4gDQo+
IFNvIHdoYXQgSSdtIHdvbmRlcmluZyBpcyBvZiBjb3Vyc2UgaWYgdGhpcyBwYXJhbWV0ZXIgaXMg
dGhlIGNvcnJlY3Qgb25lIHRvIHVzZQ0KPiBmb3IgcGxhbmVzX3Blcl9sdW4uIEkgdHJpZWQgdG8g
bG9jYXRlIHRoZSBjb3JyZWN0ICJwbGFuZXMgcGVyIGx1biIgcGFyYW1ldGVyIGluDQo+IHRoZSB0
YWJsZSwgYnV0IGRpZG4ndCBmaW5kIGFueW9uZS4gTWF5YmUgaXQncyB0aGUgdW5mb3J0dW5hdGUg
ZmFjdCB0aGF0DQo+ICJwbGFuZXMgcGVyIGx1biIgaXNuJ3QgZXhwb3NlZCBpbiB0aGUgcGFyYW1l
dGVyIHRhYmxlPw0KPiANCj4gL0VtaWwNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eCBNVEQgZGlzY3Vzc2lvbiBtYWls
aW5nIGxpc3QNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1tdGQvDQo=
