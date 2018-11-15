Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B7BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607A12145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="e1TQ/7ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607A12145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbeKPA0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:26:37 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:28225 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeKPA0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:26:37 -0500
X-IronPort-AV: E=Sophos;i="5.56,236,1539673200"; 
   d="scan'208";a="21190333"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Nov 2018 07:18:32 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 15 Nov 2018 07:18:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT1WkOKenD5Tsxk6czYijQzXppsJN/AF9/CBdEO/8bo=;
 b=e1TQ/7ahv0kDFY6mQb5WGtMrcR7paIaDYG1FmjWEBFAUSSvUaxv1EhENja8tsA/3mcMA5PYC1b3W1V5BalGR6MSE9ulvoA+XAUWRfVivuVx5zQ5E58Q+8hZZNRBA2d8YuKtAIDLDA0CkFwylSQHMvuuJINFivavAeLgq7KRUDFA=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2147.namprd11.prod.outlook.com (10.174.112.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 15 Nov 2018 14:18:28 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6%6]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 14:18:28 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <wsa@the-dreams.de>, <Nicolas.Ferre@microchip.com>,
        <Ludovic.Desroches@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Cristian.Birsan@microchip.com>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: at91: switched to resume/suspend callbacks.
Thread-Topic: [PATCH] i2c: at91: switched to resume/suspend callbacks.
Thread-Index: AQHUafB6HlYWaEsRyEeCWmEZo34VTaVEFukAgAzxgIA=
Date:   Thu, 15 Nov 2018 14:18:28 +0000
Message-ID: <e5210bfd-0ce6-0a15-299f-32e04521667d@microchip.com>
References: <1540203006-805-1-git-send-email-andrei.stefanescu@microchip.com>
 <20181107083928.vqgnpw3mmczjn4el@M43218.corp.atmel.com>
In-Reply-To: <20181107083928.vqgnpw3mmczjn4el@M43218.corp.atmel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0076.eurprd04.prod.outlook.com
 (2603:10a6:802:2::47) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2147;6:A16FBDYekXk7MsltMM0cv338FGvDzAkGtzZwVBf0cgNO/FAZgvrvEzrhDoKk7JBhHFSWYoamJ7pwntuOLMkbPUk7dnXILNCo1+80T7KDp0AD6twyZeBuTXVJ2frxWLvk+oGKnMcImfGpckDiu8m5ll/Z/rCkMXf/scwm4iwdZGkkORf0xAfI/5jm+2etyOvVQQ9Zq2vNYAOXs2LD6lhhLTXNFc23G3xqn61w4eAECajyyMcVElWMSqRGZZcwcUVwWaPJWtny5IUOwZOAUTuMzTXE7ztb+pZpMsmU2CpvCDL7NitQJlunWabqt0ZvPP8X/zhfs6siKeBEYNXVg60nYVT1/qHmTTIOyPX5zGL09DiQeGNnmBmvYEVhsCOCyZYoCtuIeaTrRocb8ZCND+S7kHX1eHLxw7tAqmfnATS845GRr1IFa6U69nkCAPmMxFnftpXcrirAnHGc7bOclaBK6A==;5:5Z+V2skvxeVXx58USC3Xe23ISpP3gyAFgECu8ilSOD2FxJHjeC74x5l2SBSZppJWhRzVKEuxTPaWIGnEHKdHxtMrYtYQN8j+1Su24CXciNVZC+Bd9yrPDbtBTdpsUyJBn+I0iL/ad+brL7Bh91oHCuK7R+Gsu17JDRp0Kb0DBAw=;7:RgQ3NaZdAiXZxpJaX7LsX56NGObJ3UslKMD8ulo8nrwvctW/8dWRNuOqO+kqcGhLwKsv9kUISr/aEihob7D2+nTS0rYQ8rwGxS2iwdisAjGGMXEGzP9MM5TiTrGKnCRD39hMrJuMEMHPsFCQX4Gkfg==
x-ms-office365-filtering-correlation-id: 765d4e24-d32f-49c2-91f3-08d64b053631
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2147;
x-ms-traffictypediagnostic: BN6PR1101MB2147:
x-microsoft-antispam-prvs: <BN6PR1101MB214748B78AEDDCD4DDE40C40EDDC0@BN6PR1101MB2147.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231415)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2147;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2147;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(81166006)(6246003)(53936002)(105586002)(8676002)(25786009)(2900100001)(106356001)(81156014)(2906002)(6116002)(486006)(3846002)(71200400001)(31686004)(71190400001)(14454004)(6436002)(6512007)(2616005)(72206003)(476003)(478600001)(14444005)(446003)(256004)(11346002)(36756003)(386003)(6506007)(53546011)(2501003)(31696002)(2201001)(86362001)(305945005)(76176011)(66066001)(99286004)(52116002)(316002)(68736007)(110136005)(7736002)(15650500001)(26005)(5660300001)(102836004)(6486002)(8936002)(186003)(229853002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2147;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kWq9Kr+EhERR1kvXuHCDbQj6HkI2VdD+N62Rc9KzBKErLW7PqasxGKNMroKO/24XvmLtzRkvtXBiBQM2SA57VPm2EpG6Z2q3KiVwQQOQGR40IH5hBEzQvHvUjgl0IYAdOINx73m7J3StvdAZtyRR9bqdH6RBGzj7j0iTNzu4SkFlAjNbQr5umKne+vRNSqOGdv5SrIPhvDSy+7gXu1C0K1/GYAMD3de+wknXy9f48Xp/JTOgvSyEDeFBcSlcZIG48aeMcTU5X8A4jNW8HpQzvDMQDYun9CSk+gO6D9mPdklqNiNoCsEJ0pIbNsW9l1ZgwqOZB5tWiUlgReeyVEnAYJIPu5wZLx6jnXnP2nDkodU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA9B339F548A8E4C8925C1E64D198771@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 765d4e24-d32f-49c2-91f3-08d64b053631
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 14:18:28.3708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2147
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gV29sZnJhbSwNCg0KQ291bGQgeW91IHBsZWFzZSB0ZWxsIG1lIGlmIHRoZXJlIGFyZSBh
bnkgY2hhbmdlcyB0aGF0IEkgc2hvdWxkIG1ha2UNCnRvIHRoZSBwYXRjaD8NCg0KVGhhbmsgeW91
LA0KQW5kcmVpIFN0ZWZhbmVzY3UNCg0KT24gMDcuMTEuMjAxOCAxMDozOSwgTHVkb3ZpYyBEZXNy
b2NoZXMgd3JvdGU6DQo+IE9uIE1vbiwgT2N0IDIyLCAyMDE4IGF0IDEyOjE3OjQ3UE0gKzAyMDAs
IEFuZHJlaSBTdGVmYW5lc2N1IC0gTTUwNTA2IHdyb3RlOg0KPj4gSW4gdGhlIHByZXZpb3VzIHZl
cnNpb24gb2YgdGhlIGRyaXZlciByZXN1bWUvc3VzcGVuZF9ub2lycSBjYWxsYmFja3MNCj4+IHdl
cmUgdXNlZC4gQmVjYXVzZSBvZiB0aGlzLCB3aGVuIHJlc3VtaW5nIGZyb20gc3VzcGVuZC10by1y
YW0sDQo+PiBhbiBJMkMgKGJlbG9uZ2luZyB0byBhIEZMRVhDT00pIHdvdWxkIHJlc3VtZSBiZWZv
cmUgRkxFWENPTS4NCj4+IFRoZSBmaXJzdCByZWFkIG9uIHRoZSBJMkMgYnVzIHdvdWxkIHRoZW4g
cmVzdWx0IGluIGEgdGltZW91dC4NCj4+DQo+PiBUaGlzIHBhdGNoIHN3aXRjaGVzIHRvIHJlc3Vt
ZS9zdXNwZW5kIGNhbGxiYWNrcyB3aGljaCBhcmUNCj4+IGNhbGxlZCBhZnRlciBGTEVYQ09NIHJl
c3VtZXMuIEZMRVhDT00sIFNQSSBhbmQgVVNBUlQgZHJpdmVycyB1c2UNCj4+IHJlc3VtZS9zdXNw
ZW5kIGNhbGxiYWNrcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWkgU3RlZmFuZXNjdSA8
YW5kcmVpLnN0ZWZhbmVzY3VAbWljcm9jaGlwLmNvbT4NCj4gSSBjYW4ndCBmaWd1cmUgb3V0IHdo
eSB3ZSB1c2UgdGhlIF9ub2lycSB2YXJpYW50LiBXaGVuIHBhdGNoZXMgZm9yIFBNDQo+IHN0dWZm
IHdlcmUgc2VudCwgc3VzcGVuZC9yZXN1bWUgY2FsbGJhY2tzIHdlcmUgdXNlZCBidXQgaW4gdGhl
IGxhdGVzdA0KPiB2ZXJzaW9uIGl0IG1vdmVkIHRvIHRoZSBfbm9pcnEgdmFyaWFudCB3aXRob3V0
IGV4cGxhbmF0aW9uLg0KPg0KPiBFeGNlcHRpbmcgaWYgc29tZW9uZSBoYXMgYW4gYXJndW1lbnQg
dG8ga2VlcCB0aGUgX25vaXJxIHZhcmlhbnQsDQo+IEFja2VkLWJ5OiBMdWRvdmljIERlc3JvY2hl
cyA8bHVkb3ZpYy5kZXNyb2NoZXNAbWljcm9jaGlwLmNvbT4NCj4NCj4gVGhhbmtzDQo+DQo+IFJl
Z2FyZHMNCj4NCj4gTHVkb3ZpYw0KPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvaTJjL2J1c3Nlcy9p
MmMtYXQ5MS5jIHwgOCArKysrLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9idXNz
ZXMvaTJjLWF0OTEuYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtYXQ5MS5jDQo+PiBpbmRleCBi
ZmQxZmRmLi44MWY3Yjk0IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1h
dDkxLmMNCj4+ICsrKyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtYXQ5MS5jDQo+PiBAQCAtMTE3
NCw3ICsxMTc0LDcgQEAgc3RhdGljIGludCBhdDkxX3R3aV9ydW50aW1lX3Jlc3VtZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQo+PiAgIAlyZXR1cm4gY2xrX3ByZXBhcmVfZW5hYmxlKHR3aV9kZXYtPmNs
ayk7DQo+PiAgIH0NCj4+ICAgDQo+PiAtc3RhdGljIGludCBhdDkxX3R3aV9zdXNwZW5kX25vaXJx
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4+ICtzdGF0aWMgaW50IGF0OTFfdHdpX3N1c3BlbmQoc3Ry
dWN0IGRldmljZSAqZGV2KQ0KPj4gICB7DQo+PiAgIAlpZiAoIXBtX3J1bnRpbWVfc3RhdHVzX3N1
c3BlbmRlZChkZXYpKQ0KPj4gICAJCWF0OTFfdHdpX3J1bnRpbWVfc3VzcGVuZChkZXYpOw0KPj4g
QEAgLTExODIsNyArMTE4Miw3IEBAIHN0YXRpYyBpbnQgYXQ5MV90d2lfc3VzcGVuZF9ub2lycShz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+PiAgIAlyZXR1cm4gMDsNCj4+ICAgfQ0KPj4gICANCj4+IC1z
dGF0aWMgaW50IGF0OTFfdHdpX3Jlc3VtZV9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+PiAr
c3RhdGljIGludCBhdDkxX3R3aV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPj4gICB7DQo+
PiAgIAlzdHJ1Y3QgYXQ5MV90d2lfZGV2ICp0d2lfZGV2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+PiAgIAlpbnQgcmV0Ow0KPj4gQEAgLTEyMDIsOCArMTIwMiw4IEBAIHN0YXRpYyBpbnQgYXQ5
MV90d2lfcmVzdW1lX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+ICAgfQ0KPj4gICANCj4+
ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIGF0OTFfdHdpX3BtID0gew0KPj4gLQku
c3VzcGVuZF9ub2lycQk9IGF0OTFfdHdpX3N1c3BlbmRfbm9pcnEsDQo+PiAtCS5yZXN1bWVfbm9p
cnEJPSBhdDkxX3R3aV9yZXN1bWVfbm9pcnEsDQo+PiArCS5zdXNwZW5kCT0gYXQ5MV90d2lfc3Vz
cGVuZCwNCj4+ICsJLnJlc3VtZQkJPSBhdDkxX3R3aV9yZXN1bWUsDQo+PiAgIAkucnVudGltZV9z
dXNwZW5kCT0gYXQ5MV90d2lfcnVudGltZV9zdXNwZW5kLA0KPj4gICAJLnJ1bnRpbWVfcmVzdW1l
CQk9IGF0OTFfdHdpX3J1bnRpbWVfcmVzdW1lLA0KPj4gICB9Ow0KPj4gLS0gDQo+PiAyLjcuNA0K
Pj4NCg==
