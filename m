Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91737C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA302082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="UOjoAssc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA302082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeLDJ6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:58:19 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:50708 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeLDJ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:58:18 -0500
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; 
   d="scan'208";a="21089929"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Dec 2018 02:58:13 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 4 Dec 2018 02:58:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYQoP+NOIrC5TfEOIu6KkjGlkScZMkMMoVxb26diza0=;
 b=UOjoAsscu18tWH9IFB1A5Sdbkqf5P4qJyNhdGJznDbidHu/LferCI7pg6xAUBLKSMATey/dXqjQu5D752VDt1KRiVC2lUaZyHlEXUsW7ejVWnOdXf+dlnlP1OWgVy7i1Oy8ddl2BHRWBzmqyoO2kDiMjO2YO6AWNkYV4eNIz8hQ=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2306.namprd11.prod.outlook.com (10.174.113.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 4 Dec 2018 09:58:10 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 09:58:10 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <robh+dt@kernel.org>
CC:     <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <mark.rutland@arm.com>,
        <Ludovic.Desroches@microchip.com>, <Cristian.Birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: gpio: add SAMA5D2 PIOBU support
Thread-Topic: [PATCH v2 1/2] dt-bindings: gpio: add SAMA5D2 PIOBU support
Thread-Index: AQHUgKg8JYSs1TI8IUy9lTCXxs8No6VubluA
Date:   Tue, 4 Dec 2018 09:58:10 +0000
Message-ID: <b581a73c-2f72-5915-5fc8-3cf9f5518a9c@microchip.com>
References: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
 <1542701330-23466-2-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1542701330-23466-2-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0004.eurprd05.prod.outlook.com
 (2603:10a6:800:92::14) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2306;6://xwXQcocoxBDZ7xtGYN8hwtgdm/NV9L6f4HeuIKA7z+1GH1X8hP1NSnZb0iPOae5DHDUcM810UGO/WtBMDjd2C1q+TsWVvkXwkNO8P/4AVxkacqCD4lLkcrZJoxFPAUjgViOEvLRE4zzmgj7kW/tBjxW6EQ/X/5JMOJOvS5t7wBQRypTjhaW5oW4vA04KqzXgaNndiuTre6NeKCkJgTvf8KxPQpCTeBKuMmAqrTApSstqo37t29Ngbavnpu6DYF5PbTGQNhA4pj5NhcqME55wfrA4YeCgzc3ptK/sbF+34y/9vJn9BxAsMSeetar34DC4476lY9coAUQZ1mSjFmyzXFptVfbnsQl7d1h0kSEcfKpOUepskoFO1lMJZ+B+ntoBk3DZEGtTSxKFKr27cVUWUizvM9xvyW0ROfavoJxM9K7GJB9zofBBedGjBlmo+XHJhFf46ZPWn8avtX3xkTgQ==;5:ziseNfMeFsYVqif/RzQWDbKtWSrQP/19hnm3BggO31qN3r2w+/5mIaHNZYX58c9966v4r9VS2r9DZSPrTCXzVoNGheTEU2fURBuz67rC8B15GlrJWwAB0wzZHlIJ+IPckrnW6HgkIb176HT/tRcCcsIEPAwd04B0073Bf7gnFPc=;7:KbxzEOSnCOxmkHXLC1CPkhZQkc/+9EUqOchGLt2lRSqCl/62H4Q3sgeX8YMPOcj3z+F6LVTaOR5zdWG3TJhLYwkeWFqzJdd6MyMKWb9B4+cNK4hvFay5egoARbHkvZsK7W9Masz0Q0uTiMCYYC7LRw==
x-ms-office365-filtering-correlation-id: 223ff9d9-0a01-4146-2b8f-08d659ceff4a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2306;
x-ms-traffictypediagnostic: BN6PR1101MB2306:
x-microsoft-antispam-prvs: <BN6PR1101MB23064481A9A6643E3686487EEDAF0@BN6PR1101MB2306.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2306;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2306;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(37524003)(199004)(189003)(97736004)(52116002)(14454004)(6116002)(54906003)(3846002)(256004)(478600001)(68736007)(53546011)(6506007)(386003)(99286004)(26005)(76176011)(2906002)(186003)(316002)(53936002)(102836004)(6512007)(5660300001)(66066001)(6436002)(71190400001)(31686004)(106356001)(105586002)(6246003)(7736002)(4326008)(229853002)(6486002)(25786009)(305945005)(476003)(2616005)(72206003)(86362001)(36756003)(71200400001)(8936002)(8676002)(31696002)(446003)(486006)(11346002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2306;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QEn7UWn2gNQ5FW7ch7cZlZ2NS2wuyT9fRHGx8WxzXFKEp/2w/3O/1dZjdbIC7VI6AeLBHmNUstjPGYpzQu5D5A0cyGgI87HLVybsMjoSje6MMV2SvYKdtQbu9DQ5deDZflEvvVi/uI3DrE7imDGupUVYsJvh36DinMVmlkpWFiuz3TdKQIrSh+aTrATu7TEkIFtwEUAHFIRVCVykmh2GE3avbLyBaRjUXAig5UClkzfkrH7kNpGe9YFcxmTn1RvRJK02ZwtD4LIncEVbfAVv5VYbrGqiuV1ocqj5UdG/oY+wGG0EVaeeWz28m1n1vP4gZ7jjBamxa52QKYiRpcXgZzESZFnTokjtbh0S6R9i+PA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF3978FE7B95694CA14EBFFA432BB883@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 223ff9d9-0a01-4146-2b8f-08d659ceff4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 09:58:10.3792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2306
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUm9iLA0KDQpDb3VsZCB5b3UgcGxlYXNlIHRlbGwgbWUgaWYgdGhlcmUgYXJlIGFueSBp
bXByb3ZlbWVudHMNCnRvIGJlIG1hZGUgdG8gdGhlIHBhdGNoPw0KDQpCZXN0IHJlZ2FyZHMsDQpB
bmRyZWkNCg0KT24gMjAuMTEuMjAxOCAxMDowOCwgQW5kcmVpIFN0ZWZhbmVzY3UgLSBNNTA1MDYg
d3JvdGU6DQo+IFRoaXMgcGF0Y2ggZGVzY3JpYmVzIHRoZSBjb21wYXRpYmxlIGFuZCB0aGUgZGV2
aWNlIHRyZWUNCj4gYmluZGluZ3MgbmVjZXNzYXJ5IGZvciB0aGUgU0FNQTVEMiBQSU9CVSBHUElP
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWkgU3RlZmFuZXNjdSA8YW5kcmVpLnN0ZWZhbmVz
Y3VAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICAgLi4uL2JpbmRpbmdzL2dwaW8vZ3Bpby1zYW1h
NWQyLXBpb2J1LnR4dCAgICAgICAgICAgfCAzMSArKysrKysrKysrKysrKysrKysrKysrDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKykNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vZ3Bpby1zYW1hNWQyLXBpb2J1
LnR4dA0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2dwaW8vZ3Bpby1zYW1hNWQyLXBpb2J1LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9ncGlvL2dwaW8tc2FtYTVkMi1waW9idS50eHQNCj4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gaW5kZXggMDAwMDAwMC4uMmUyNjBlMQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL2dwaW8tc2FtYTVkMi1waW9idS50
eHQNCj4gQEAgLTAsMCArMSwzMSBAQA0KPiArR1BJTyBjb250cm9sbGVyIGZvciBTQU1BNUQyIFBJ
T0JVIHBpbnMuDQo+ICsNCj4gK1RoZXNlIHBpbnMgaGF2ZSB0aGUgcHJvcGVydHkgb2Ygbm90IGxv
c2luZyB0aGVpciB2b2x0YWdlDQo+ICtkdXJpbmcgQmFja3VwL1NlbGYtcmVmcmVzaCBtb2RlLg0K
PiArDQo+ICtUaGVzZSBiaW5kaW5ncyBzaG91bGQgYmUgc2V0IHRvIGEgbm9kZSBpbiB0aGUgZHRz
aSBmaWxlLg0KPiArDQo+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiArLSBjb21wYXRpYmxlOgkJ
InN5c2NvbiIsICJtaWNyb2NoaXAsc2FtYTVkMi1waW9idSINCj4gKy0gI2dwaW8tY2VsbHM6CQlU
aGVyZSBhcmUgMi4gVGhlIHBpbiBudW1iZXIgaXMgdGhlDQo+ICsJCQlmaXJzdCwgdGhlIHNlY29u
ZCByZXByZXNlbnRzIGFkZGl0aW9uYWwNCj4gKwkJCXBhcmFtZXRlcnMgc3VjaCBhcyBHUElPX0FD
VElWRV9ISUdIL0xPVy4NCj4gKy0gZ3Bpby1jb250cm9sbGVyOglNYXJrcyB0aGUgcG9ydCBhcyBH
UElPIGNvbnRyb2xsZXIuDQo+ICsNCj4gK05vdGUgdGhhdCB0aGUgZHJpdmVyIHVzZXMgc3lzY29u
IGFuZCBzaG91bGQgYmUgdGhlIGNoaWxkIG9mDQo+ICt0aGUgc3lzY29uIG5vZGUuDQo+ICsNCj4g
K0V4YW1wbGU6DQo+ICsNCj4gKwlzZWN1bW9kQGZjMDQwMDAwIHsNCj4gKwkJY29tcGF0aWJsZSA9
ICJhdG1lbCxzYW1hNWQyLXNlY3Vtb2QiLCAic3lzY29uIiwgInNpbXBsZS1tZmQiOw0KPiArCQlz
dGF0dXMgPSAib2theSI7DQo+ICsJCXJlZyA9IDwweGZjMDQwMDAwIDB4MTAwPjsNCj4gKw0KPiAr
CQlwaW9CVTogcGlvYnUgew0KPiArCQkJc3RhdHVzID0gIm9rYXkiOw0KPiArCQkJY29tcGF0aWJs
ZSA9ICJtaWNyb2NoaXAsc2FtYTVkMi1waW9idSI7DQo+ICsJCQlncGlvLWNvbnRyb2xsZXI7DQo+
ICsJCQkjZ3Bpby1jZWxscyA9IDwyPjsNCj4gKwkJfTsNCj4gKwl9Ow0K
