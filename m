Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6879BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024E22081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Or/S53EM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024E22081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395147AbeKVXRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:17:36 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:2606 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388460AbeKVXRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:17:36 -0500
X-IronPort-AV: E=Sophos;i="5.56,265,1539673200"; 
   d="scan'208";a="23422969"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Nov 2018 05:38:24 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 22 Nov 2018 05:38:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRb4CFJxGS7MPHHUkegwzwnR+rM/X6HtCA+m4VlMCXA=;
 b=Or/S53EM5JDIoOEUf591WoC5/VJ/MFizkC1BnHaSPJa+WkVaIHXb77hxtoWGIDVvnUkcB8WQAO2QRoyjs84OwaO/M9A7hsZ35jpcWoXo24a7cTItPcFxD/voDBosSbkiVap0FF4spZGca2j2u34JpMKH0viEBlYZfTzYsHE2MiI=
Received: from DM5PR11MB1850.namprd11.prod.outlook.com (10.175.92.17) by
 DM5PR11MB1561.namprd11.prod.outlook.com (10.172.37.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Thu, 22 Nov 2018 12:38:22 +0000
Received: from DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::9198:565d:bbda:6801]) by DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::9198:565d:bbda:6801%8]) with mapi id 15.20.1339.027; Thu, 22 Nov 2018
 12:38:22 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexander.sverdlin@nokia.com>
CC:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Topic: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Index: AQHUgmAPRuGauPbUmUaN5hsWx0CViKVbu7uA
Date:   Thu, 22 Nov 2018 12:38:22 +0000
Message-ID: <53927e56-4546-91bd-bae7-66bd049bdd9e@microchip.com>
References: <20181122123552.15756-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181122123552.15756-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0902CA0054.eurprd09.prod.outlook.com
 (2603:10a6:802:1::43) To DM5PR11MB1850.namprd11.prod.outlook.com
 (2603:10b6:3:114::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1561;6:XTt0oVj1y7Z0NH3U/dfcZ0hpPLupa6Kc2IE54+mY2jtwUzo77seQp14X4OitIRhtRhaoc6Ve/Ve8n7PhPb3sP6NbEyymgM85znU2uyoJw8FlA6oEHsFCfKmJKbzdKcJgI2J40uQzsB32Pz0G9tYT462an1rdGJkYUQknwvnqw0J6yz/7RcB7R169gCWp0/1peEhbt1XE73W9RR6IbxwKFb2KsDS1opRliveOnWrkyINHQiaxHcHRKnp+ie6ZodrS/xYRTspF99f5Xmw/cuoisQBysXZBplYP1OCe3UntWyLv9SSbqRDzj/T03kgHLitiUKS9XPHwU+H651GI2o4UdJIXAdW9+m8J8No0OXge6aWrWM7PEME4JAX/dE8KDeVBUnhp8fccmC7epmxpexXdnGQF5vctXsT4KBdGLfOrC8Wv7DmN3IRaEl7AJwbo9LKbGTMfrey1OVUqmAUB0OrtEQ==;5:1mMof37Vjf9w3DZNW3pTZJ9jVPsVRv74N+AJWU6wXnILKOc4DSPXwR1vGYczSLmDR5D8Sd77IiowdtMJZF/kbtdwlFQN7xGPaIKGs87uFxzGzH+St9/scmQUVpxHpXDJ65C1BzpEUL71+moIJqhtPBYfHVFZeKpV4r2Wd28HBTw=;7:nkys22pTZUEIrGNykHwVavR6LRYNkepO/FV4A/1BG+XLzShnQK8jY/Gn6Ock2b6rb5w5Kwn0hDeG7/OCr0t2NTtPAtMTi3hUJB0u1VbfkRVLPn4yMDrC+y4kQDsDMxqRYX0jsGytHbkO/btn0RkHCw==
x-ms-office365-filtering-correlation-id: 1255ee74-0bdc-49ff-ece4-08d650776358
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB1561;
x-ms-traffictypediagnostic: DM5PR11MB1561:
x-microsoft-antispam-prvs: <DM5PR11MB1561FB989CE1AC19540C6152F0DB0@DM5PR11MB1561.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR11MB1561;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB1561;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(366004)(376002)(189003)(199004)(81156014)(81166006)(305945005)(6512007)(7736002)(8676002)(66066001)(478600001)(486006)(25786009)(2351001)(54906003)(105586002)(106356001)(2501003)(8936002)(72206003)(6916009)(5660300001)(6436002)(6486002)(68736007)(14444005)(229853002)(86362001)(31696002)(11346002)(14454004)(476003)(446003)(39060400002)(76176011)(26005)(4326008)(2906002)(5640700003)(3846002)(6116002)(2616005)(256004)(97736004)(2900100001)(31686004)(316002)(186003)(71190400001)(71200400001)(102836004)(6506007)(99286004)(53546011)(386003)(53936002)(52116002)(36756003)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1561;H:DM5PR11MB1850.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: omv8NRPWV0cEzn9ircFiwqGJXn9n1/uMDkYsGokRCYeLiCnqXkoILjw7tjReu4ahGbJQ507za857T0quWxnGOBu6m0ktP5yz753cYNMQOgY7L3ijjpeETdbOlKmWCXJVvkVzHuEPKgJFpRcpIluvWrKvgyk6egX3ELdwIc44ZaIRjrNmAwyNyEbyNeM4og0XTQgPQ5B8qgIHcFzPFuv27NOZOK1C7UtecyUcd6oWqHhsL57XgfbHPRR499i434qSCicOunQ29G+4vAAy/s5jGgeYqLG1kxtdXUhfyPxD3sl96qx1N2MWrxMmVs5KGmHRG5H0Ai3dETir2tel8kp7bXmqRrRATM7jqOsC0vrWX/o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4E27BCF04708C4C89F70E82E8689F20@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1255ee74-0bdc-49ff-ece4-08d650776358
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 12:38:22.0498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1561
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFsZXhhbmRlciwNCg0KQ2FuIHlvdSBwbGVhc2UgdGVzdCB0aGlzIHBhdGNoIHRvIHNlZSBp
ZiBpdCBmaXhlcyB5b3VyIHByb2JsZW0/DQoNClRoYW5rcywNCnRhDQoNCk9uIDExLzIyLzIwMTgg
MDI6MzYgUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6DQo+IEZyb206IFR1ZG9yIEFt
YmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4gDQo+IEJ1ZyByZXBvcnRlZCBm
b3IgdGhlIG91dC1vZi10cmVlIFMyNUZTMTI4UyBmbGFzaCBtZW1vcnkuDQo+IA0KPiBCRlBUIHRh
YmxlIGFkdmVydGlzZXMgYWxsIHRoZSBlcmFzZSB0eXBlcyBzdXBwb3J0ZWQgYnkgYWxsIHRoZQ0K
PiBwb3NzaWJsZSBtYXAgY29uZmlndXJhdGlvbnMuIFVwZGF0ZSB0aGUgZXJhc2VfdHlwZSBhcnJh
eSB0byBpbmRpY2F0ZQ0KPiB3aGljaCBlcmFzZSB0eXBlcyBhcmUgYXBwbGljYWJsZSB0byB0aGUg
Y3VycmVudCBtYXAgY29uZmlndXJhdGlvbi4NCj4gDQo+IEJhY2t3YXJkIGNvbXBhdGliaWxpdHkg
dGVzdCBkb25lIG9uIHNzdDI2dmYwNjRiLg0KPiANCj4gRml4ZXM6IGIwMzhlOGUzYmU3MiAoIm10
ZDogc3BpLW5vcjogcGFyc2UgU0ZEUCBTZWN0b3IgTWFwIFBhcmFtZXRlciBUYWJsZSIpDQo+IFJl
cG9ydGVkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBub2tpYS5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9j
aGlwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDI5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3Ivc3BpLW5vci5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4gaW5kZXgg
OTNjOWJjODkzMWZjLi5hNzFhZGNkNmRkZmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3Ivc3BpLW5vci5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+
IEBAIC0zMDAwLDcgKzMwMDAsOCBAQCBzdGF0aWMgaW50IHNwaV9ub3JfaW5pdF9ub25fdW5pZm9y
bV9lcmFzZV9tYXAoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gIAl1NjQgb2Zmc2V0Ow0KPiAgCXUz
MiByZWdpb25fY291bnQ7DQo+ICAJaW50IGksIGo7DQo+IC0JdTggZXJhc2VfdHlwZSwgdW5pZm9y
bV9lcmFzZV90eXBlOw0KPiArCXU4IHVuaWZvcm1fZXJhc2VfdHlwZSwgc2F2ZV91bmlmb3JtX2Vy
YXNlX3R5cGU7DQo+ICsJdTggZXJhc2VfdHlwZSwgcmVnaW9uc19lcmFzZV90eXBlOw0KPiAgDQo+
ICAJcmVnaW9uX2NvdW50ID0gU01QVF9NQVBfUkVHSU9OX0NPVU5UKCpzbXB0KTsNCj4gIAkvKg0K
PiBAQCAtMzAxNCw2ICszMDE1LDcgQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXRfbm9uX3VuaWZv
cm1fZXJhc2VfbWFwKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+ICAJbWFwLT5yZWdpb25zID0gcmVn
aW9uOw0KPiAgDQo+ICAJdW5pZm9ybV9lcmFzZV90eXBlID0gMHhmZjsNCj4gKwlyZWdpb25zX2Vy
YXNlX3R5cGUgPSAwOw0KPiAgCW9mZnNldCA9IDA7DQo+ICAJLyogUG9wdWxhdGUgcmVnaW9ucy4g
Ki8NCj4gIAlmb3IgKGkgPSAwOyBpIDwgcmVnaW9uX2NvdW50OyBpKyspIHsNCj4gQEAgLTMwMzAs
MTMgKzMwMzIsMzggQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXRfbm9uX3VuaWZvcm1fZXJhc2Vf
bWFwKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+ICAJCSAqLw0KPiAgCQl1bmlmb3JtX2VyYXNlX3R5
cGUgJj0gZXJhc2VfdHlwZTsNCj4gIA0KPiArCQkvKg0KPiArCQkgKiByZWdpb25zX2VyYXNlX3R5
cGUgbWFzayB3aWxsIGluZGljYXRlIGFsbCB0aGUgZXJhc2UgdHlwZXMNCj4gKwkJICogc3VwcG9y
dGVkIGluIHRoaXMgY29uZmlndXJhdGlvbiBtYXAuDQo+ICsJCSAqLw0KPiArCQlyZWdpb25zX2Vy
YXNlX3R5cGUgfD0gZXJhc2VfdHlwZTsNCj4gKw0KPiAgCQlvZmZzZXQgPSAocmVnaW9uW2ldLm9m
ZnNldCAmIH5TTk9SX0VSQVNFX0ZMQUdTX01BU0spICsNCj4gIAkJCSByZWdpb25baV0uc2l6ZTsN
Cj4gIAl9DQo+ICANCj4gKwlzYXZlX3VuaWZvcm1fZXJhc2VfdHlwZSA9IG1hcC0+dW5pZm9ybV9l
cmFzZV90eXBlOw0KPiAgCW1hcC0+dW5pZm9ybV9lcmFzZV90eXBlID0gc3BpX25vcl9zb3J0X2Vy
YXNlX21hc2sobWFwLA0KPiAgCQkJCQkJCSAgdW5pZm9ybV9lcmFzZV90eXBlKTsNCj4gIA0KPiAr
CWlmICghcmVnaW9uc19lcmFzZV90eXBlKSB7DQo+ICsJCS8qDQo+ICsJCSAqIFJvbGwgYmFjayB0
byB0aGUgcHJldmlvdXMgdW5pZm9ybV9lcmFzZV90eXBlIG1hc2ssIFNNUFQgaXMNCj4gKwkJICog
YnJva2VuLg0KPiArCQkgKi8NCj4gKwkJbWFwLT51bmlmb3JtX2VyYXNlX3R5cGUgPSBzYXZlX3Vu
aWZvcm1fZXJhc2VfdHlwZTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArDQo+ICsJ
LyoNCj4gKwkgKiBCRlBUIHRhYmxlIGFkdmVydGlzZXMgYWxsIHRoZSBlcmFzZSB0eXBlcyBzdXBw
b3J0ZWQgYnkgYWxsIHRoZQ0KPiArCSAqIHBvc3NpYmxlIG1hcCBjb25maWd1cmF0aW9ucy4gVXBk
YXRlIHRoZSBlcmFzZV90eXBlIGFycmF5IHRvIGluZGljYXRlDQo+ICsJICogd2hpY2ggZXJhc2Ug
dHlwZXMgYXJlIGFwcGxpY2FibGUgdG8gdGhlIGN1cnJlbnQgbWFwIGNvbmZpZ3VyYXRpb24uDQo+
ICsJICovDQo+ICsJZm9yIChpID0gMDsgaSA8IFNOT1JfRVJBU0VfVFlQRV9NQVg7IGkrKykNCj4g
KwkJaWYgKCEocmVnaW9uc19lcmFzZV90eXBlICYgQklUKGVyYXNlW2ldLmlkeCkpKQ0KPiArCQkJ
c3BpX25vcl9zZXRfZXJhc2VfdHlwZSgmZXJhc2VbaV0sIDAsIDB4RkYpOw0KPiArDQo+ICAJc3Bp
X25vcl9yZWdpb25fbWFya19lbmQoJnJlZ2lvbltpIC0gMV0pOw0KPiAgDQo+ICAJcmV0dXJuIDA7
DQo+IA0K
