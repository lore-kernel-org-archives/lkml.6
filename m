Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B44C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6D72070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="WotuE2Vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfAGJbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:31:01 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:6021 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfAGJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:31:00 -0500
X-IronPort-AV: E=Sophos;i="5.56,450,1539673200"; 
   d="scan'208";a="24729271"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Jan 2019 02:30:58 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 7 Jan 2019 02:31:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA9eRy7K7tOWgXKsvPvikobClDAamc4d8ySpCsuvDYQ=;
 b=WotuE2VstOXr096qxoxw6aKv73rn+GqeJz1FzXC0Ir0j32PPo2iXDJUHetZbR+dx/xO6jTtnDSO3HrummOfb9tA5iJNuI7hTYqxJuWxMt67HkVcI1KaAeTDmHc1QmM+wv2vEF8x6GXNdb0ip+11BFBMP/k3OVxXAEIBNNy0elpM=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1760.namprd11.prod.outlook.com (10.175.53.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 09:30:55 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 09:30:55 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <thierry.reding@gmail.com>
CC:     <corbet@lwn.net>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Thread-Topic: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Thread-Index: AQHUo2hjF9SHYVC+/UyvQjeBLKSGN6WhLe0AgAJimAA=
Date:   Mon, 7 Jan 2019 09:30:55 +0000
Message-ID: <67e881c5-0ea7-3d2f-5910-534729097d11@microchip.com>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
 <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
In-Reply-To: <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::16) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1760;6:yqowwRcDWwdtt0QILXJ3Gz7NW+QIjGO9+WAVjRyoOefVXiUPFSDdWk7wjDL0hYNX2PKWPwcWnFlD3CHxtbabfbt4Xf3aAlowZXDAjOuYxjieTZy4Zb1M4PzUu5rr3rImTziHeWS5iMx0lQPLUr6sI77Wme4zm9/i5AQLclCsum6KvKN/H6ktYoFmJXq1nWrdvWW+IoaDvJPdINXWyKQHTamsw+yruNcvbxjPeT8ex+0o89ahLJwSlj00WetGJyzbktfsmkEXbVaXa9lSAPuPD+S6ZImybwYYRUObhSJflFnYXGKy4JVYjEfUUCylPZ4Se3kauELw23s9m/t6Q4BTAMmw+V2a42CniW4roXvSWacxMkWF/iybFoMZKNSFy3tN+szO0vzebZl95chXovYlqBXWR2muFQ3V5av9NdjPtqFIXnK16wvdoznSKPymelTowc9E8jXuURgmu89eDArblQ==;5:55dANSK1BoWHR58Ct4DhEdQr8m3DcRQ89AdyWpUBfUKPKflobEK6nK7YlM9FRcKwvmpdAI6xgpBvjrTGKZtnGVWiPJxP99PlMZ93MJ+5O0ePK2acgN6OmCIE2IGIvLJvFQi0ld8l0FLOCqnsL9pOrx8S2huFcii7DryrzDSCGzU5AmErMnHfNK1aHvVHDhzjVfoeivJwQEdGi81/5f06Wg==;7:iojORA0FplvtLiEDwNMtz+TQEscIBccc+O5t981aLbrtZd/4NdZSvYKruYGWCookAqFj3UTwCopAjJ9I9dsHlC07k1nVW7yowWp/CTyCkCUiEQ3xA8DVokogHWhlBh+rfESHsULwq/nKi1dlmpbsEQ==
x-ms-office365-filtering-correlation-id: a5847ebf-06df-440b-01c3-08d67482d28f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1760;
x-ms-traffictypediagnostic: MWHPR11MB1760:
x-microsoft-antispam-prvs: <MWHPR11MB1760D6B60D82A31E0CFE160087890@MWHPR11MB1760.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR11MB1760;BCL:0;PCL:0;RULEID:;SRVR:MWHPR11MB1760;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(51444003)(476003)(446003)(186003)(110136005)(316002)(54906003)(102836004)(97736004)(68736007)(2616005)(11346002)(386003)(71190400001)(86362001)(53546011)(99286004)(6506007)(76176011)(52116002)(71200400001)(5660300001)(31696002)(2906002)(305945005)(31686004)(7736002)(14444005)(256004)(105586002)(106356001)(26005)(39060400002)(8676002)(6436002)(66066001)(966005)(8936002)(6486002)(36756003)(3846002)(6116002)(14454004)(81156014)(81166006)(486006)(66574012)(53936002)(229853002)(6306002)(2501003)(6246003)(478600001)(25786009)(4326008)(72206003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1760;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /gz1Ih3SsSaIZ4hf0GQ676TV11Gm+AqhrBOKPgweOyhACAqjVt/1dAUxY9OzxhqME3PKIVHDRdAJkTUPqmkUjDfllkG7J4X09r0wHcoS10r7ZTQp/4MFugliuUlgU6HG1Tk6m71rE2jjjYmKEoefaHBilTALM1z9uDPQb/Bmxq/y3FknCacZdXqe7MYI3WsfICDLVJMmt9boRA7XonnW0fRtMraaWG+3+N+qm9elcdTqvb2cHfmyJgXIfkoRCeERD0hxbDFg1fSr9qmxCG/Mohvu6NBkqh4vqnDnENhAjtx4cx7wFvM3W1jAVlIZNjjO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC42B9F668D275479C29E3610322FFF9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a5847ebf-06df-440b-01c3-08d67482d28f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 09:30:55.0545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1760
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA1LjAxLjIwMTkgMjM6MDUsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBIZWxs
bywNCj4gDQo+IE9uIFRodSwgSmFuIDAzLCAyMDE5IGF0IDAxOjI5OjQ0UE0gKzAwMDAsIENsYXVk
aXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8
Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBBZGQgYmFzaWMgUFdNIG1vZGVz
OiBub3JtYWwgYW5kIGNvbXBsZW1lbnRhcnkuIFRoZXNlIG1vZGVzIHNob3VsZA0KPj4gZGlmZmVy
ZW50aWF0ZSB0aGUgc2luZ2xlIG91dHB1dCBQV00gY2hhbm5lbHMgZnJvbSB0d28gb3V0cHV0cyBQ
V00NCj4+IGNoYW5uZWxzLiBUaGVzZSBtb2RlcyBjb3VsZCBiZSBzZXQgYXMgZm9sbG93Og0KPj4g
MS4gUFdNIGNoYW5uZWxzIHdpdGggb25lIG91dHB1dCBwZXIgY2hhbm5lbDoNCj4+IC0gbm9ybWFs
IG1vZGUNCj4+IDIuIFBXTSBjaGFubmVscyB3aXRoIHR3byBvdXRwdXRzIHBlciBjaGFubmVsOg0K
Pj4gLSBub3JtYWwgbW9kZQ0KPj4gLSBjb21wbGVtZW50YXJ5IG1vZGUNCj4+IFNpbmNlIHVzZXJz
IGNvdWxkIHVzZSBhIFBXTSBjaGFubmVsIHdpdGggdHdvIG91dHB1dCBhcyBvbmUgb3V0cHV0IFBX
TQ0KPj4gY2hhbm5lbCwgdGhlIFBXTSBub3JtYWwgbW9kZSBpcyBhbGxvd2VkIHRvIGJlIHNldCBm
b3IgUFdNIGNoYW5uZWxzIHdpdGgNCj4+IHR3byBvdXRwdXRzOyBpbiBmYWN0IFBXTSBub3JtYWwg
bW9kZSBzaG91bGQgYmUgc3VwcG9ydGVkIGJ5IGFsbCBQV01zLg0KPiANCj4gSSBzdGlsbCB0aGlu
ayB0aGF0IG15IHN1Z2dlc3Rpb24gdGhhdCBJIHNlbnQgaW4gcmVwbHkgdG8geW91ciB2NSB1c2lu
Zw0KPiAuYWx0X2R1dHlfY3ljbGUgYW5kIC5hbHRfb2Zmc2V0IGlzIHRoZSBiZXR0ZXIgb25lIGFz
IGl0IGlzIG1vcmUgZ2VuZXJpYy4NCg0KSSBsaWtlIGl0IGJldHRlciBteSB3YXksIEkgZXhwbGFp
bmVkIG15c2VsZiB3aHkuDQoNCj4gQSB3b3JkIGFib3V0IHRoYXQgZnJvbSBUaGllcnJ5IGJlZm9y
ZSBwdXR0aW5nIHRoZSBtb2RlIGludG8gdGhlIHB3bSBBUEkNCj4gd291bGQgYmUgZ3JlYXQuDQoN
ClllcywgbGV0J3Mgd2FpdCBUaGllcnJ5IGlucHV0cyBvbiB0aGlzLg0KDQo+IA0KPiBJIGRvbid0
IHJlcGVhdCB3aGF0IEkgd3JvdGUgdGhlcmUgYXNzdW1pbmcgeW91IHN0aWxsIHJlbWVtYmVyIG9y
IGFyZQ0KPiB3aWxsaW5nIHRvIGxvb2sgaXQgdXAgYXQNCj4gZS5nLiBodHRwczovL3d3dy5zcGlu
aWNzLm5ldC9saXN0cy9saW51eC1wd20vbXNnMDgxNzQuaHRtbCAoaW4gdGhlIDJuZCBoYWxmDQo+
IG9mIG15IG1haWwpLg0KDQpZZXMsIEkgcmVtZW1iZXIgaXQuDQoNCj4gDQo+IEFsc28gSSB0aGlu
ayB0aGF0IGlmIHRoZSBjYXBhYmlsaXRpZXMgZnVuY3Rpb24gaXMgdGhlIHdheSBmb3J3YXJkIGFk
ZGluZw0KPiBzdXBwb3J0IHRvIGRldGVjdCBhdmFpbGFiaWxpdHkgb2YgcG9sYXJpdHkgaW52ZXJz
aW9uIHNob3VsZCBiZQ0KPiBjb25zaWRlcmVkLiANCg0KWWVwLCB3aHkgbm90LiBCdXQgaXQgc2hv
dWxkIGJlIGRvbmUgaW4gYSBkaWZmZXJlbnQgcGF0Y2guIEl0IGlzIG5vdCByZWxhdGVkDQp0byB0
aGlzIHNlcmllcy4NCg0KVGhpcyB3b3VsZCBhbHNvIGJlIGFuIG9wcG9ydHVuaXR5IHRvIHNwbGl0
IHRoZSBpbnRyb2R1Y3Rpb24NCj4gb2YgdGhlIGNhcGFiaWxpdGllcyBmdW5jdGlvbiBhbmQgdGhl
IGludHJvZHVjdGlvbiBvZiBjb21wbGVtZW50YXJ5IG1vZGUuDQo+IChCdXQgbXkgcGVyc29uYWwg
cHJlZmVyZW5jZSB3b3VsZCBiZSB0byBqdXN0IGxldCAuYXBwbHkgZmFpbCB3aGVuIGFuDQo+IHVu
c3VwcG9ydGVkIGNvbmZpZ3VyYXRpb24gaXMgcmVxdWVzdGVkLikNCg0KLmFwcGx5IGZhaWxzIHdo
ZW4gc29tZXRoaW5nIHdyb25nIGlzIHJlcXVlc3RlZC4NCg0KPiANCj4+ICtzdGF0aWMgaW50IHB3
bV9nZXRfZGVmYXVsdF9jYXBzKHN0cnVjdCBwd21fY2FwcyAqY2FwcykNCj4+ICt7DQo+PiArCXN0
YXRpYyBjb25zdCBzdHJ1Y3QgcHdtX2NhcHMgZGVmYXVsdF9jYXBzID0gew0KPj4gKwkJLm1vZGVz
X21zayA9IFBXTV9NT0RFX0JJVChOT1JNQUwpLA0KPj4gKwl9Ow0KPj4gKw0KPj4gKwlpZiAoIWNh
cHMpDQo+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsNCj4+ICsJKmNhcHMgPSBkZWZhdWx0X2Nh
cHM7DQo+PiArDQo+PiArCXJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+ICsvKioNCj4+ICsgKiBw
d21fZ2V0X2NhcHMoKSAtIGdldCBQV00gY2FwYWJpbGl0aWVzIG9mIGEgUFdNIGRldmljZQ0KPj4g
KyAqIEBwd206IFBXTSBkZXZpY2UgdG8gZ2V0IHRoZSBjYXBhYmlsaXRpZXMgZm9yDQo+PiArICog
QGNhcHM6IHJldHVybmVkIGNhcGFiaWxpdGllcw0KPj4gKyAqDQo+PiArICogUmV0dXJuczogMCBv
biBzdWNjZXNzIG9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvbiBmYWlsdXJlDQo+PiArICovDQo+
PiAraW50IHB3bV9nZXRfY2Fwcyhjb25zdCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLCBzdHJ1Y3Qg
cHdtX2NhcHMgKmNhcHMpDQo+PiArew0KPj4gKwlpZiAoIXB3bSB8fCAhY2FwcykNCj4+ICsJCXJl
dHVybiAtRUlOVkFMOw0KPj4gKw0KPj4gKwlpZiAocHdtLT5jaGlwLT5vcHMtPmdldF9jYXBzKQ0K
Pj4gKwkJcmV0dXJuIHB3bS0+Y2hpcC0+b3BzLT5nZXRfY2Fwcyhwd20tPmNoaXAsIHB3bSwgY2Fw
cyk7DQo+PiArDQo+PiArCXJldHVybiBwd21fZ2V0X2RlZmF1bHRfY2FwcyhjYXBzKTsNCj4gDQo+
IEknZCBkcm9wIHB3bV9nZXRfZGVmYXVsdF9jYXBzICh1bmxlc3MgeW91IGludHJvZHVjZSBzb21l
IG1vcmUgY2FsbGVycw0KPiBsYXRlcikgYW5kIGZvbGQgaXRzIGltcGxlbWVudGF0aW9uIGludG8g
cHdtX2dldF9jYXBzLg0KDQpJIGRpZCBpdCBhcyBUaGllcnJ5IHByb3Bvc2VkLg0KDQo+IA0KPj4g
K30NCj4+ICtFWFBPUlRfU1lNQk9MX0dQTChwd21fZ2V0X2NhcHMpOw0KPj4gWy4uLl0NCj4+IEBA
IC01MywxMiArNzUsMTQgQEAgZW51bSB7DQo+PiAgICogQHBlcmlvZDogUFdNIHBlcmlvZCAoaW4g
bmFub3NlY29uZHMpDQo+PiAgICogQGR1dHlfY3ljbGU6IFBXTSBkdXR5IGN5Y2xlIChpbiBuYW5v
c2Vjb25kcykNCj4+ICAgKiBAcG9sYXJpdHk6IFBXTSBwb2xhcml0eQ0KPj4gKyAqIEBtb2RlYml0
OiBQV00gbW9kZSBiaXQNCj4+ICAgKiBAZW5hYmxlZDogUFdNIGVuYWJsZWQgc3RhdHVzDQo+PiAg
ICovDQo+PiAgc3RydWN0IHB3bV9zdGF0ZSB7DQo+PiAgCXVuc2lnbmVkIGludCBwZXJpb2Q7DQo+
PiAgCXVuc2lnbmVkIGludCBkdXR5X2N5Y2xlOw0KPj4gIAllbnVtIHB3bV9wb2xhcml0eSBwb2xh
cml0eTsNCj4+ICsJdW5zaWduZWQgbG9uZyBtb2RlYml0Ow0KPiANCj4gSSBmYWlsIHRvIHNlZSB0
aGUgdXBzaWRlIG9mIHN0b3JpbmcgdGhlIG1vZGUgYXMgMl5tb2RlIGluc3RlYWQgb2YgYQ0KPiBw
bGFpbiBlbnVtIHB3bV9tb2RlLiBHaXZlbiB0aGF0IHN0cnVjdCBwd21fc3RhdGUgaXMgdmlzaWJs
ZSBmb3IgcHdtDQo+IHVzZXJzIGEgcGxhaW4gcHdtX21vZGUgd291bGQgYXQgbGVhc3QgYmUgbW9y
ZSBpbnR1aXRpdmUuDQoNClRvIGhhdmUgYWxsIG1vZGVzIHN1cHBvcnRlZCBieSBhIGNvbnRyb2xs
ZXIgZ3JvdXBlZCBpbiBwd21fY2Fwczo6bW9kZXNfbXNrLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMN
Cj4gVXdlDQo+IA0K
