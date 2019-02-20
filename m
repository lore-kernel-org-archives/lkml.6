Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1758C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE0B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2q3aslAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfBTU3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:29:16 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:49500 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTU3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:29:16 -0500
X-IronPort-AV: E=Sophos;i="5.58,392,1544511600"; 
   d="scan'208";a="24976088"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Feb 2019 13:29:15 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 20 Feb 2019 13:29:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfRU53lpMO7ckD7SCwoOvgjFqf+enkMa76z4tzacGmE=;
 b=2q3aslAlhj+NodUKFR7rBkuaKfc2lnlPXYaVGOolyVPU2P7I1TH+YwVFUaaWLUnsyd2z2Sy+rEpC22OL82gIscbNEy7a+kRZN2M92idIM5l8taXiAAebDtagCY5mw1IFUMyKYEUj5hYd3syeaUVUS98QrCgcnPQ1DiLLr7N1rVw=
Received: from DM5PR11MB1850.namprd11.prod.outlook.com (10.175.92.17) by
 DM5PR11MB0075.namprd11.prod.outlook.com (10.164.155.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 20:29:07 +0000
Received: from DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::4125:8d55:234b:a4a1]) by DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::4125:8d55:234b:a4a1%11]) with mapi id 15.20.1622.018; Wed, 20 Feb
 2019 20:29:07 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <robimarko@gmail.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <bbrezillon@kernel.org>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Add Winbond w25q16jv support
Thread-Topic: [PATCH] mtd: spi-nor: Add Winbond w25q16jv support
Thread-Index: AQHUxKf5P1ZBDcn1LEmHy4bSCo3uraXpLIAA
Date:   Wed, 20 Feb 2019 20:29:07 +0000
Message-ID: <97e48e85-9700-53e3-0f7a-eeac6f93f721@microchip.com>
References: <20190214205723.9011-1-robimarko@gmail.com>
In-Reply-To: <20190214205723.9011-1-robimarko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0011.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::21) To DM5PR11MB1850.namprd11.prod.outlook.com
 (2603:10b6:3:114::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.52.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f06c2109-b14c-4875-f25c-08d697720fde
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB0075;
x-ms-traffictypediagnostic: DM5PR11MB0075:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtETTVQUjExTUIwMDc1OzIzOnhTMHptNFNCTWFyRldrVHRtalA0aXZISDgx?=
 =?utf-8?B?RHd4UDllUUQ1TmhFaVg1U051SEVZT3kwd2lOamo5TDF2OUIyT2UwUVNZWFVI?=
 =?utf-8?B?VTcrakY2VisrNmFTaHdGSm8zSnVFZ0laR0R2MXhISUtQajgxcmZXZzhxRDlW?=
 =?utf-8?B?Z0llcXJyc0ZBY1JoY1ZFWVB0WDQvTHpFR0lTaUE3T0xIQ0lYOXF2K1YvRUh0?=
 =?utf-8?B?Ukc0bXcxUm5zejhkMXc3OU95UFRtcWVOVUhuWFVMZTRnVmV5ZGc4NlV5M1VQ?=
 =?utf-8?B?bGM4c0JQbmtrSXNQOWtsUUd0Q0dBVFhMS3lhRC9OTVIzWGpnWDRTTG52bW1x?=
 =?utf-8?B?b01ZeURvMjZLaVlwTjA0OW4rWUovZjJFMkhGUW1KZTlPWFMzMWdUQTNIL3d2?=
 =?utf-8?B?SlFWNGw4OVh4R1QySEg0UWhnZUtYaEUzekM2d1VmbmdUb0pTd2MvZHd4SE9H?=
 =?utf-8?B?c1FLMG5mMHQ2RUQvSmNvUHF2MDR6d0tJS215ZlFYeVFkSjBtd01QeXBwa0NV?=
 =?utf-8?B?WFJWL2I0SmtrM3BpcjJhSXVEdXNLeUh3UzQxajUrNkhQWHBMN21TdHdDWWpz?=
 =?utf-8?B?M3d6cE1SYXY2SVM2QUJzNld5ckdwQkJFMUFrY3RmcEZhYUxDUldxM2x3L1gy?=
 =?utf-8?B?UTlNS1JzTFhGNVJRcGFmVzI0TEdXdW1LbEVtbzl3YmVKeEE0TWFpSmhySmt5?=
 =?utf-8?B?VUNxeGkvcjVQTDIyWXdsWFhNLzQwSnVFdWNrRk5TVXdYY0dwOC9YUmQwUHFF?=
 =?utf-8?B?UGVqbGlTTkpscVZpeTJZYUhJRjMyV2JkUm5iQzcyeTNXVzc0TEt4dnpCQlNK?=
 =?utf-8?B?MUVDbTZFL0ZNbFptUEEwaExDU0ZkWllzTjlHcXdvMXYvMURndXV4STQ2S0FB?=
 =?utf-8?B?NnlCN2dtSHlCSWI5ZUlHUEdUdTRTUGRwaDd3elpNYmRSV2FlZExHc3E2ZGJj?=
 =?utf-8?B?UCtxTGVtVkpLbDBlbFVCSm9UY0h1cWFIa3prK0NyWXM2Q2dPZDlZZDIxN1JD?=
 =?utf-8?B?L3ZFb3E2bUdkbUhVNFhPcHpRNkU5ei9HV01UTjNLZEUvN2NSR0JqVFVVS2Jq?=
 =?utf-8?B?UEFCVzZiL1FUNlZmekI3cER1L0hncS90d3ZoTjByVElQaE5qUTBrMHJwK2tU?=
 =?utf-8?B?YU9FbElTWnRBK1lCMUNOSmVRODg0VG9aOGZhbzA0RmZ2OGJPOU96TU5lN0dN?=
 =?utf-8?B?ajFTUVlmK0JtU0dGMmtlaWdVSmxaZEpGSU1qTU8wK0ZJcndUR2FYUTc3aU1v?=
 =?utf-8?B?cjlmcktva1pLbDgxSHIvOFdla0RUcWlEd3BuSGNVaFFrbkpodFpiREZXU0hF?=
 =?utf-8?B?RzJuUHlxMEVrU2pXWWNaWWJia2gza1hNWEIrZFN5VUpHUUhDQUVBRE9vY2lp?=
 =?utf-8?B?b0JKZHRpVUh2SG45eThmN2VhVy9ZaXIvdWlMc3RrVzE2MFZFSmhXcmZ3b3Ar?=
 =?utf-8?B?eFFzOElscldnVjVHQVR3anJLY0JJakx6TlE5SE5lRUhocHRGNEkzU2E5aXlq?=
 =?utf-8?B?VFdDcWpyenYxdks0dlBaTHlzSWJDQVVyOE5YRGd1VzlUK21lQnUwQWpxazFY?=
 =?utf-8?B?L1pzb3NSQW96L1d2Y0VVSlJOcHFTTGFTZlptNTdPSWp6Z1lyY3NOVzhjcUFI?=
 =?utf-8?B?NXZOWlI3RC9yNm1uNUtUU2MvTHlCMkl1Ykh6UlovVnZDVGoyRVUxbTZPd0VC?=
 =?utf-8?B?cVhMd252UWlsVlNkSTUwRlVST1A4UXNvUnlWdlduRUNIejVmRlFFQm1NZW8y?=
 =?utf-8?B?THN3bGF6bzRka2tNc3dKYXNjSjQ3eVRpZWRldXNHWERBUTIySThhTUlUcUx6?=
 =?utf-8?Q?54FBaiCFoWzLp?=
x-microsoft-antispam-prvs: <DM5PR11MB00756472E365EA99C8D455A6F07D0@DM5PR11MB0075.namprd11.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(39860400002)(376002)(396003)(199004)(189003)(53546011)(25786009)(102836004)(316002)(26005)(2906002)(105586002)(386003)(6506007)(110136005)(8936002)(52116002)(186003)(7736002)(31686004)(106356001)(76176011)(5660300002)(14454004)(6436002)(36756003)(66066001)(6486002)(2616005)(6306002)(2201001)(966005)(8676002)(71200400001)(71190400001)(476003)(53936002)(486006)(31696002)(305945005)(2501003)(256004)(14444005)(229853002)(68736007)(6512007)(99286004)(81156014)(6246003)(97736004)(6116002)(3846002)(81166006)(86362001)(11346002)(478600001)(72206003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0075;H:DM5PR11MB1850.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N58pyBurLdYgibwOUL2+z+nw7fp1UCyWC+loBEogm8qGcoGewMUBPuUv4WbdXjcOac1h8iSIZaAFpJVlwgpqUt8HX2+xAXU96bdZ4MX3Btnv2NSQEoLt3O7KfVJWRgUSgBL+nmExuH7lyFYLBiL3vxU0nNfIf/xekpQbn5RHuQkN30E3VL0FabxMjeIqCpOnGuInUG8s/M+3Yh5B7dAd6lqAysB8FSga3LGMkGY+TfHba83QOazvDmCd8Mj2VCOMrrB55uM6gz3f+akVkaxIlMAKwBNdqZfAxH4e0CCHmbTu4iIF5L33CODg3GFgkCjRGwVj4jiQME3OIfYzMPwgC6HkTf8+P3Z5kN/gYfazKCnJLKr64ztQdGshvfVnBIPgAZfUb1Om6jU9O/UowB/48m8JH2NB+9pRZaQpdNL69EE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDE3322BD4CD994FB02BF8EA54F2D97B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f06c2109-b14c-4875-f25c-08d697720fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 20:29:04.8563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0075
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYmVydCwNCg0KT24gMDIvMTQvMjAxOSAxMDo1NyBQTSwgUm9iZXJ0IE1hcmtvIHdyb3Rl
Og0KPiBEYXRhc2hlZXQ6IGh0dHBzOi8vd3d3LndpbmJvbmQuY29tL3Jlc291cmNlLWZpbGVzL3cy
NXExNmp2JTIwc3BpJTIwcmV2ZyUyMDAzMjIyMDE4JTIwcGx1cy5wZGYNCj4gDQo+IFRlc3Rpbmcg
ZG9uZSBvbiBNaWtyb3RpayBSb3V0ZXJib2FyZCBSQjQ1MEd4NCBib2FyZCB1bmRlciA0LjE5LjE5
IGtlcm5lbC4NCg0KSXQgaXMgcHJlZmVyYWJsZSB0byBkbyB0aGUgdGVzdCBvbiBzcGktbm9yL25l
eHQNCj4gDQo+IFRlc3QgYm9hcmQgZG9lcyBub3Qgc3VwcG9ydCBEdWFsIG9yIFF1YWQgbW9kZXMu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgTWFya28gPHJvYmltYXJrb0BnbWFpbC5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCA1ICsrKysrDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tdGQvc3BpLW5vci9zcGktbm9yLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0K
PiBpbmRleCA2ZTEzYmJkMWFhYTUuLjBlOTU4ZjQ4ZGIxYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGkt
bm9yLmMNCj4gQEAgLTE5NzUsNiArMTk3NSwxMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNo
X2luZm8gc3BpX25vcl9pZHNbXSA9IHsNCj4gIAkJCVNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVB
RCB8IFNQSV9OT1JfUVVBRF9SRUFEIHwNCj4gIAkJCVNQSV9OT1JfSEFTX0xPQ0sgfCBTUElfTk9S
X0hBU19UQikNCj4gIAl9LA0KPiArCXsNCj4gKwkJIncyNXExNmp2IiwgSU5GTygweGVmNzAxNSwg
MCwgNjQgKiAxMDI0LCAgMzIsDQo+ICsJCQlTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBT
UElfTk9SX1FVQURfUkVBRCB8DQo+ICsJCQlTUElfTk9SX0hBU19MT0NLIHwgU1BJX05PUl9IQVNf
VEIpDQoNCllvdSdsbCBuZWVkIGEgd2F5IHRvIGRpZmZlcmVudGlhdGUgYmV0d2VlbiBXMjVRMTZK
Vi1JUS9KUSBhbmQgVzI1UTE2SlYtSU0vSk0uDQoNCkFuZCBJIHdvdWxkIHByZWZlciB0byBoYXZl
IHRoZSBuZXcgZW50cmllcyBvcmRlcmVkIGFscGhhYmV0aWNhbGx5IGFzIG11Y2ggYXMNCnBvc3Np
YmxlLiBUaGlzIG9uZSBzaG91bGQgZml0IGp1c3QgYmVmb3JlIHcyNXEyMGNsLiBNYW51ZmFjdHVy
ZXJzIGFyZSBuYW1pbmcNCmZsYXNoZXMgYmFzZWQgb24gYSBwcm9kdWN0IGlkZW50aWZpY2F0aW9u
IHN5c3RlbS4gVGhlIGZsYXNoZXMgYXJlIHByZXNlbnRlZCBpbg0KYWxwaGFiZXRpY2FsIG9yZGVy
LCB3ZSBzaG91bGQgZG8gdGhlIHNhbWUuDQoNCkNoZWVycywNCnRhDQo=
