Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FB4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42EE20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="nXSBjrrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42EE20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502890AbeKWU0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:26:32 -0500
Received: from mail-eopbgr80132.outbound.protection.outlook.com ([40.107.8.132]:59909
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387987AbeKWU0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MN5RiuKrs9W6IJIbeNB235bIhcgNkW/Wl38IVK9NIKs=;
 b=nXSBjrrqWVTk3Y2fQH5XcLwga/zGj9XEuPEzZS/bfAPsR5/83ngv1N5mYAM6ij7dXsnoAt40nkRHOl0gUT+/xb2J+pHE+ZxxLFwbaemH4edp/63MRHUyDiH3qqLh0CpOCdqTRmScI1Hi34d62HfLVpi9cZWkApHMAHkCYG6OSA4=
Received: from HE1PR0701MB2729.eurprd07.prod.outlook.com (10.168.188.135) by
 HE1PR0701MB2683.eurprd07.prod.outlook.com (10.168.188.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.6; Fri, 23 Nov 2018 09:42:56 +0000
Received: from HE1PR0701MB2729.eurprd07.prod.outlook.com
 ([fe80::35b1:90ba:fa:3c77]) by HE1PR0701MB2729.eurprd07.prod.outlook.com
 ([fe80::35b1:90ba:fa:3c77%9]) with mapi id 15.20.1361.013; Fri, 23 Nov 2018
 09:42:56 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Topic: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Index: AQHUgxDmRuGauPbUmUaN5hsWx0CViA==
Date:   Fri, 23 Nov 2018 09:42:55 +0000
Message-ID: <3d8a2b83-282d-7cb2-3c8b-addae3c2af7f@nokia.com>
References: <20181122123552.15756-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181122123552.15756-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.165]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
x-clientproxiedby: HE1PR0701CA0074.eurprd07.prod.outlook.com
 (2603:10a6:3:64::18) To HE1PR0701MB2729.eurprd07.prod.outlook.com
 (2603:10a6:3:99::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0701MB2683;6:3mHiyPguNg+ecxWsgbh+rStO0U5+4CHKNLFAIG/mxXQGCHLOWoN0oLTQKhQqG6qjGN9yRn3ERlVIB57Awpd8Wi9FQ94xu/mMArDoS5ejvcSP1wGFDJVC0+ef95EZjEVUmg+fjtd1Oe5JT5QAQWgsVWvLw7FgdijpwepJbMIvUjMxFXPutPDPUSa/RBAI+nF8alFH0INEcytfQiQGuknR9taiuo7VJ6BWzzzyLSxzBxmEb6sqZ3MRuCYBl14jTinPQoX4INMXQtBPuQ9SfV8JjpRD9XyI1trpa9JFczYdi8dhEg/AIpVjahwFH1vLWlrnDCRTJXOZ42j6q7iaJuEAn8AbhyD/1lRdRCB8V9r3sGGw+0WOn6O/9qP3GUOYL/DiF4/kOhNpiZAky6Rq9n72Pfutlht+D87zLjathIB722UwfWR+ZaeUxD7qOed5DeZ69Vth6pL6PXXpq3lY0BjOWQ==;5:OFBhf2XK0LCOjRgRbUNSHATiYFc6hQ/hfzvHKacOoAsH9Evj+bOY7EXrmZOLmbG7tFghxdCcaBpMlbG6QG/VaMdJLhOVSd+8k1atMP6AcHdLznUXnKc/mlbPeUQIsJEAIVWQwQkgxr3gsWLnkh5HyDvLpGf0TeAqxZmbBvNj6Ts=;7:66EzG1/6SbSxGufnJo9os3t0xmq14SYi9vZNpCahCn2BCSame7CDpFB857d3gekJ/8VsLejIL5KTwQjY+M+eKp9aERno1OroFszqJ/gMfOHI18zhmcjKAmXoJoWmiu5IxTMaZOSBW1aXODHjn4n0AQ==
x-ms-office365-filtering-correlation-id: 71dd9d05-0f89-400d-4e85-08d651280a7e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HE1PR0701MB2683;
x-ms-traffictypediagnostic: HE1PR0701MB2683:
x-microsoft-antispam-prvs: <HE1PR0701MB268366469888F6E54ECB984588D40@HE1PR0701MB2683.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(11241501184)(806099)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:HE1PR0701MB2683;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0701MB2683;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(376002)(366004)(396003)(199004)(189003)(105586002)(8936002)(476003)(106356001)(58126008)(25786009)(14444005)(31686004)(256004)(54906003)(110136005)(486006)(8676002)(71200400001)(71190400001)(81166006)(36756003)(81156014)(2501003)(4326008)(2900100001)(6116002)(3846002)(39060400002)(305945005)(7736002)(6246003)(186003)(64126003)(6506007)(386003)(99286004)(26005)(76176011)(102836004)(6436002)(53936002)(14454004)(6512007)(97736004)(68736007)(53546011)(6486002)(52116002)(31696002)(478600001)(229853002)(66066001)(65956001)(65806001)(11346002)(2906002)(2201001)(316002)(446003)(2616005)(5660300001)(86362001)(65826007);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2683;H:HE1PR0701MB2729.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4g0uZrSVy8tovUQkok0B0ua0t9liTUTzaSVihW6k9gOxhSRq9Lh4jVriWthBQBHc4Br1BlnldBgFWVgPkHUhTt3SSCmMkPnST1LnI9ppBpK15i9pqLiWpGOL6ww4nrwj+pPQHVXrlw8CC3u+CR7JUBSFpjqtGODvhgRfN2L2duIOw8UzddfthrocnykudcAZVKGvCjpwvpKm2WG2vWs61sf7ZUFa0cPyUB5hb6EiBi8lDYNPDJaGeL2kOUO5yVL511lQ2VA334XOCUIVl4WRPHLExoflEaDvVmorGDsNAQ+FOE4h1tETOeBIkA/9cyKPyqX/tx6l/xg9wtKhuB3h87YrcqFa0bHyzXop+fqE+fQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EA63EDDC3F1D24893EFA08E4526E482@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71dd9d05-0f89-400d-4e85-08d651280a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 09:42:55.9324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2683
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVHVkb3IsDQoNCk9uIDIyLzExLzIwMTggMTM6MzYsIFR1ZG9yLkFtYmFydXNAbWljcm9j
aGlwLmNvbSB3cm90ZToNCj4gRnJvbTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNy
b2NoaXAuY29tPg0KPiANCj4gQnVnIHJlcG9ydGVkIGZvciB0aGUgb3V0LW9mLXRyZWUgUzI1RlMx
MjhTIGZsYXNoIG1lbW9yeS4NCj4gDQo+IEJGUFQgdGFibGUgYWR2ZXJ0aXNlcyBhbGwgdGhlIGVy
YXNlIHR5cGVzIHN1cHBvcnRlZCBieSBhbGwgdGhlDQo+IHBvc3NpYmxlIG1hcCBjb25maWd1cmF0
aW9ucy4gVXBkYXRlIHRoZSBlcmFzZV90eXBlIGFycmF5IHRvIGluZGljYXRlDQo+IHdoaWNoIGVy
YXNlIHR5cGVzIGFyZSBhcHBsaWNhYmxlIHRvIHRoZSBjdXJyZW50IG1hcCBjb25maWd1cmF0aW9u
Lg0KPiANCj4gQmFja3dhcmQgY29tcGF0aWJpbGl0eSB0ZXN0IGRvbmUgb24gc3N0MjZ2ZjA2NGIu
DQo+IA0KPiBGaXhlczogYjAzOGU4ZTNiZTcyICgibXRkOiBzcGktbm9yOiBwYXJzZSBTRkRQIFNl
Y3RvciBNYXAgUGFyYW1ldGVyIFRhYmxlIikNCj4gUmVwb3J0ZWQtYnk6IEFsZXhhbmRlciBTdmVy
ZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQG5va2lhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQpJJ3ZlIHRlc3RlZCB0
aGlzIHBhdGNoIGFuZCBpdCBmaXhlcyB0aGUgZXJhc2VzaXplIGZvciBTMjVGUzEyOFMgYW5kDQpv
dXIgMTI4ayBwYXJ0aXRpb25zIGFyZSB3cml0ZWFibGUgYWdhaW4gd2l0aCB0aGlzIHBhdGNoLg0K
DQpOZXZlcnRoZWxlc3MsIEkgdGhpbmsgdGhpcyBpcyBjb2luY2lkZW5jZS4gSSBkb24ndCB0aGlu
ayB0aGF0IGl0DQptYWtlcyBzZW5zZSB0byBPUiBhbGwgdGhlIGVyYXNlIHR5cGVzIGZyb20gYWxs
IHJlZ2lvbnMgaW4gb25lDQpiaXRtYXNrIGFuZCBkZXJpdmUgYW55IHVuaWZvcm0gZXJhc2VzaXpl
IG91dCBvZiBpdC4NClRoaXMgbWFrZXMgbGl0dGxlIHNlbnNlIGZvciBtZSBpbiBjYXNlIG9mIG5v
bi11bmlmb3JtIG1hcHMuDQoNCkkgYmVsaWV2ZSwgdGhlIGN1bHByaXQgaGVyZSBpcyBvbmUgbGV2
ZWwgaGlnaGVyLCBpbiB0aGUgTVREIHBhcnRpdGlvbmluZw0KY29kZSAobXRkcGFydC5jKSB3aGlj
aCBoYXMgdG8gYmUgdGF1Z2h0IGFib3V0IG5vbi11bmlmb3JtIG1hcHMNCmJ1dCB0aGVyZSBpcyBu
byBpbmZyYXN0cnVjdHVyZSBmb3IgdGhpcyBjdXJyZW50bHkuDQoNCldoYXQgaXMgcG9zc2libGUg
dG8gZml4IHN0aWxsIGlzIHRvIGNob29zZSBzbWFsbGVzdCwgbm90IGJpZ2dlc3QNCmVyYXNlc2l6
ZSBmb3IgdW5pZm9ybSBjYXNlLiBJIGhhdmUgc3VjaCBhIHBhdGNoLCBidXQgSSBuZWVkIGhhbmRz
DQpvbiBvbiBhIFMyNUZTMTI4UyBjb25maWd1cmVkIGluIHVuaWZvcm0gbW9kZS4NCg0KTm9uIHVu
aWZvcm0gY2FzZSByZXF1aXJlcyBNVEQgbGF5ZXIgcmV3b3JrLiBXZSBqdXN0IGNhbm5vdCBoYW5k
bGUNCnRoaXMgaGFyZHdhcmUgd2l0aCBqdXN0IG9uZSBlcmFzZXNpemUgaW4gbWluZC4gDQoNCj4g
LS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDI5ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5v
ci5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4gaW5kZXggOTNjOWJjODkzMWZj
Li5hNzFhZGNkNmRkZmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5v
ci5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+IEBAIC0zMDAwLDcg
KzMwMDAsOCBAQCBzdGF0aWMgaW50IHNwaV9ub3JfaW5pdF9ub25fdW5pZm9ybV9lcmFzZV9tYXAo
c3RydWN0IHNwaV9ub3IgKm5vciwNCj4gIAl1NjQgb2Zmc2V0Ow0KPiAgCXUzMiByZWdpb25fY291
bnQ7DQo+ICAJaW50IGksIGo7DQo+IC0JdTggZXJhc2VfdHlwZSwgdW5pZm9ybV9lcmFzZV90eXBl
Ow0KPiArCXU4IHVuaWZvcm1fZXJhc2VfdHlwZSwgc2F2ZV91bmlmb3JtX2VyYXNlX3R5cGU7DQo+
ICsJdTggZXJhc2VfdHlwZSwgcmVnaW9uc19lcmFzZV90eXBlOw0KPiAgDQo+ICAJcmVnaW9uX2Nv
dW50ID0gU01QVF9NQVBfUkVHSU9OX0NPVU5UKCpzbXB0KTsNCj4gIAkvKg0KPiBAQCAtMzAxNCw2
ICszMDE1LDcgQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXRfbm9uX3VuaWZvcm1fZXJhc2VfbWFw
KHN0cnVjdCBzcGlfbm9yICpub3IsDQo+ICAJbWFwLT5yZWdpb25zID0gcmVnaW9uOw0KPiAgDQo+
ICAJdW5pZm9ybV9lcmFzZV90eXBlID0gMHhmZjsNCj4gKwlyZWdpb25zX2VyYXNlX3R5cGUgPSAw
Ow0KPiAgCW9mZnNldCA9IDA7DQo+ICAJLyogUG9wdWxhdGUgcmVnaW9ucy4gKi8NCj4gIAlmb3Ig
KGkgPSAwOyBpIDwgcmVnaW9uX2NvdW50OyBpKyspIHsNCj4gQEAgLTMwMzAsMTMgKzMwMzIsMzgg
QEAgc3RhdGljIGludCBzcGlfbm9yX2luaXRfbm9uX3VuaWZvcm1fZXJhc2VfbWFwKHN0cnVjdCBz
cGlfbm9yICpub3IsDQo+ICAJCSAqLw0KPiAgCQl1bmlmb3JtX2VyYXNlX3R5cGUgJj0gZXJhc2Vf
dHlwZTsNCj4gIA0KPiArCQkvKg0KPiArCQkgKiByZWdpb25zX2VyYXNlX3R5cGUgbWFzayB3aWxs
IGluZGljYXRlIGFsbCB0aGUgZXJhc2UgdHlwZXMNCj4gKwkJICogc3VwcG9ydGVkIGluIHRoaXMg
Y29uZmlndXJhdGlvbiBtYXAuDQo+ICsJCSAqLw0KPiArCQlyZWdpb25zX2VyYXNlX3R5cGUgfD0g
ZXJhc2VfdHlwZTsNCj4gKw0KPiAgCQlvZmZzZXQgPSAocmVnaW9uW2ldLm9mZnNldCAmIH5TTk9S
X0VSQVNFX0ZMQUdTX01BU0spICsNCj4gIAkJCSByZWdpb25baV0uc2l6ZTsNCj4gIAl9DQo+ICAN
Cj4gKwlzYXZlX3VuaWZvcm1fZXJhc2VfdHlwZSA9IG1hcC0+dW5pZm9ybV9lcmFzZV90eXBlOw0K
PiAgCW1hcC0+dW5pZm9ybV9lcmFzZV90eXBlID0gc3BpX25vcl9zb3J0X2VyYXNlX21hc2sobWFw
LA0KPiAgCQkJCQkJCSAgdW5pZm9ybV9lcmFzZV90eXBlKTsNCj4gIA0KPiArCWlmICghcmVnaW9u
c19lcmFzZV90eXBlKSB7DQo+ICsJCS8qDQo+ICsJCSAqIFJvbGwgYmFjayB0byB0aGUgcHJldmlv
dXMgdW5pZm9ybV9lcmFzZV90eXBlIG1hc2ssIFNNUFQgaXMNCj4gKwkJICogYnJva2VuLg0KPiAr
CQkgKi8NCj4gKwkJbWFwLT51bmlmb3JtX2VyYXNlX3R5cGUgPSBzYXZlX3VuaWZvcm1fZXJhc2Vf
dHlwZTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArDQo+ICsJLyoNCj4gKwkgKiBC
RlBUIHRhYmxlIGFkdmVydGlzZXMgYWxsIHRoZSBlcmFzZSB0eXBlcyBzdXBwb3J0ZWQgYnkgYWxs
IHRoZQ0KPiArCSAqIHBvc3NpYmxlIG1hcCBjb25maWd1cmF0aW9ucy4gVXBkYXRlIHRoZSBlcmFz
ZV90eXBlIGFycmF5IHRvIGluZGljYXRlDQo+ICsJICogd2hpY2ggZXJhc2UgdHlwZXMgYXJlIGFw
cGxpY2FibGUgdG8gdGhlIGN1cnJlbnQgbWFwIGNvbmZpZ3VyYXRpb24uDQo+ICsJICovDQo+ICsJ
Zm9yIChpID0gMDsgaSA8IFNOT1JfRVJBU0VfVFlQRV9NQVg7IGkrKykNCj4gKwkJaWYgKCEocmVn
aW9uc19lcmFzZV90eXBlICYgQklUKGVyYXNlW2ldLmlkeCkpKQ0KPiArCQkJc3BpX25vcl9zZXRf
ZXJhc2VfdHlwZSgmZXJhc2VbaV0sIDAsIDB4RkYpOw0KPiArDQo+ICAJc3BpX25vcl9yZWdpb25f
bWFya19lbmQoJnJlZ2lvbltpIC0gMV0pOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KQWxleGFuZGVyIFN2ZXJkbGluLg0K
