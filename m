Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73803C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5122177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="eRFyywDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733139AbfAKOOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:14:46 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:48163 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733073AbfAKOOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:14:42 -0500
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; 
   d="scan'208";a="25369090"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Jan 2019 07:14:41 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 11 Jan 2019 07:14:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvL+no0KxpoNZpfGiVu0S73UvSSkwTMrQ1idRz+sY9k=;
 b=eRFyywDM6rQptLtqGlsOHMs85dGydszATsyTw+MaKFz+mZ59NkW16lM509vP8SNS/RfzQjkwUINmTMPpGq+b9IoClW8xhB910VbmMgFKcJ+aN8nOwuX5vbttXjGeDt4TrOwZAi7XgpB9LPAMC+RN+OTcvh6WHe3oL+b+rnaHN0U=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1888.namprd11.prod.outlook.com (10.175.54.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Fri, 11 Jan 2019 14:14:39 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5%7]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 14:14:39 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <peda@axentia.se>, <bbrezillon@kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <airlied@linux.ie>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <boris.brezillon@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <Joshua.Henderson@microchip.com>
Subject: Re: [PATCH 2/4] drm/atmel-hlcdc: do not swap w/h of the crtc when a
 plane is rotated
Thread-Topic: [PATCH 2/4] drm/atmel-hlcdc: do not swap w/h of the crtc when a
 plane is rotated
Thread-Index: AQHUqPal2z9iTYzgb0+a4YlOuMR4jaWox3GAgAFJ8YCAAAyhgA==
Date:   Fri, 11 Jan 2019 14:14:39 +0000
Message-ID: <e80fe1f1-afcb-9f81-8d08-d9774bacf123@microchip.com>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110151020.30468-3-peda@axentia.se> <20190110184816.63350396@bbrezillon>
 <23d60fbc-42c4-a2b2-5616-d21eabfd0a3f@axentia.se>
In-Reply-To: <23d60fbc-42c4-a2b2-5616-d21eabfd0a3f@axentia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::34) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1888;6:BEIdp3raQd1UTIbmgdCK6ZJa1b9/8X9uZ+2zl5kZtRm0z4z1ytcOCgTlFZkdu5ANA0LNKJDVMQR2l3aiGuAkXfVWdpAEgh5J8+J4fe1pmebygn4KCAQte8r1YrqK4X/gJrY/hganZiuMAPzx3C//djK9k9v6TqHd7eh6Xx9OYvIPKOb9sXZnJ0c+ymFpnHD31yRMeko+5iZwIhh0iNAjaEjM6y3SK6gLDgxrCXh/EWMrLl1fQS8PL4YvSzm+yspYK+r4QI3M0ahj58X5o+RbKJSUyLpmoqGIfIOuQC+s1Am+vEkTSi05IqJWF63daOI91/7fd7d3JfWxe1zdDWJ44ro5Cxn91VYGCKWaujCwDYjxdbStEohjauX9CnlFFxuaVhs3PsoEofPbej7Sfzesfv58CMcWAmsQdmAPRuEJDQJaqRUmx8TLQH/pwGoW8CFs64I7arhYHMozN130qsMVlw==;5:cUx7ZMnOBdeKR/wWcjERyB/sjVq4HdLrTBCFgFXZQNGmdW6YXOzwCITLdx0kf0Uxs1gj4yMVD1pKdMUwVb+qQCxjeg+iyQwT+9YuSWXZvzCjmW/53FNrIQ5M4s+qBJdRH8u/CF0J5wG/ENAkCdKfzny+jaEXd8vcjPzx+ep0Ne18leDKQQIU4zWXd2BZf+LAjT2DSyPwD9G1geUsX48Mxg==;7:KWHIKV4zw9v4alY/JZHEcYSx1conpaQXsPr7/khq7eDuzciq2nEzON92i/cJXpm4bkIgG22kn/ZoaO0W1bM5P5kfFcISPuAlwnzY2QKDebBVh/S9MZO1OWK0IV6cWJmuQDAtSoEONZcDkmmfDRzDsw==
x-ms-office365-filtering-correlation-id: c5f96ed9-1303-4fa7-75aa-08d677cf1f6b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1888;
x-ms-traffictypediagnostic: MWHPR11MB1888:
x-microsoft-antispam-prvs: <MWHPR11MB1888183726A2BB64D173F916E0850@MWHPR11MB1888.namprd11.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(136003)(39860400002)(189003)(199004)(6512007)(2906002)(71200400001)(8676002)(6506007)(386003)(186003)(6116002)(3846002)(6436002)(81166006)(102836004)(26005)(71190400001)(81156014)(7736002)(72206003)(305945005)(316002)(86362001)(446003)(107886003)(575784001)(66066001)(8936002)(6246003)(6486002)(31696002)(5660300001)(478600001)(53546011)(4326008)(966005)(11346002)(54906003)(110136005)(76176011)(486006)(256004)(2616005)(53936002)(106356001)(105586002)(14444005)(97736004)(476003)(52116002)(229853002)(68736007)(36756003)(14454004)(93886005)(31686004)(6306002)(99286004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1888;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ufCxkAuw9/zN48MUwg/O5VseVrpSyzYn/doeGWxpAFSloul5ti4I0oFRRdcxFWR52i0jaOqYpJJr7ceIefJg8Xe+4mFoUqL+GYxvV9gYUcRUmyETgFRdvkiRz7NvzhfjNmM/gcNC3Ch8G7RwBGL7RYFVpcBV415Q+5ca09OhtcWp7b2m7k5GgMBRP1p36xji7E/kr2cnfzsqbGTawCIx3vZu7cmD4SlNFSSj9zAhdlDb6W2ce0g+gSDxa9V/BbpbcMYFwYzSnsAYY8znFMGIi+6XtT8/P9/dNzeVuw65WZmzJy8PF/kp0k3tF+9KjkJ2TVDcSGVWptAcnf8j2F8kfl4PFzkIRZ6zd5o1EFaaSRrAE0O15rT4rFW9WqSLPPNjPZoKgNEbfoLqXLXY7dIUXCHWWEQCsXSF/5gCsUxWloU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <90F372EEF003F0469F01431B958359F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f96ed9-1303-4fa7-75aa-08d677cf1f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 14:14:39.1938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1888
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDEvMjAxOSBhdCAxNDoyOSwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+IE9uIDIwMTktMDEt
MTAgMTg6NDgsIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4+IE9uIFRodSwgMTAgSmFuIDIwMTkg
MTU6MTA6MzkgKzAwMDANCj4+IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+IHdyb3RlOg0K
Pj4NCj4+PiBUaGUgZGVzdGluYXRpb24gY3J0YyByZWN0YW5nbGUgaXMgaW5kZXBlbmRlbnQgb2Yg
c291cmNlIHBsYW5lIHJvdGF0aW9uLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgUm9z
aW4gPHBlZGFAYXhlbnRpYS5zZT4NCj4+PiAtLS0NCj4+PiAgIGRyaXZlcnMvZ3B1L2RybS9hdG1l
bC1obGNkYy9hdG1lbF9obGNkY19wbGFuZS5jIHwgMyAtLS0NCj4+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
dG1lbC1obGNkYy9hdG1lbF9obGNkY19wbGFuZS5jIGIvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhs
Y2RjL2F0bWVsX2hsY2RjX3BsYW5lLmMNCj4+PiBpbmRleCBlYThmYzBkZWI4MTQuLmQ2ZjkzZjAy
OTAyMCAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxf
aGxjZGNfcGxhbmUuYw0KPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1l
bF9obGNkY19wbGFuZS5jDQo+Pj4gQEAgLTY0Miw5ICs2NDIsNiBAQCBzdGF0aWMgaW50IGF0bWVs
X2hsY2RjX3BsYW5lX2F0b21pY19jaGVjayhzdHJ1Y3QgZHJtX3BsYW5lICpwLA0KPj4+ICAgCSAq
IFN3YXAgd2lkdGggYW5kIHNpemUgaW4gY2FzZSBvZiA5MCBvciAyNzAgZGVncmVlcyByb3RhdGlv
bg0KPj4+ICAgCSAqLw0KPj4+ICAgCWlmIChkcm1fcm90YXRpb25fOTBfb3JfMjcwKHN0YXRlLT5i
YXNlLnJvdGF0aW9uKSkgew0KPj4+IC0JCXRtcCA9IHN0YXRlLT5jcnRjX3c7DQo+Pj4gLQkJc3Rh
dGUtPmNydGNfdyA9IHN0YXRlLT5jcnRjX2g7DQo+Pj4gLQkJc3RhdGUtPmNydGNfaCA9IHRtcDsN
Cj4+DQo+PiBBZ2FpbiwgSSBndWVzcyBJIGFzc3VtZWQgLT5jcnRjX2gvdyB3ZXJlIHRoZSB3aWR0
aCBhbmQgaGVpZ2h0IGJlZm9yZQ0KPj4gcm90YXRpb24gd2hlbiBJIGluaXRpYWxseSBhZGRlZCBy
b3RhdGlvbiBzdXBwb3J0Lg0KPiANCj4gQW5kIEkgdGhvdWdodCBzbyB0b28sIHBvc3NpYmx5IHNp
bmNlIEkgaGF2ZSBvbmx5IGJlZW4gZG9pbmcgZHJtLXN0dWZmDQo+IHdpdGggdGhpcyBkcml2ZXIs
IGJ1dCBJIGFsc28gc3VzcGVjdCB0aGF0IHRoZSBpbmNvbXBsZXRlbmVzcyBvZiB0aGUNCj4gbGli
ZHJtIG1vZGV0ZXN0IHByb2dyYW0gaXMgdG8gYmxhbWUuIEkgZG9uJ3QgdGhpbmsgaXQncyBwb3Nz
aWJsZSB0bw0KPiBzcGVjaWZ5IGluZGl2aWR1YWwgc3JjIGFuZCBkc3QgcmVjdGFuZ2xlcyB3aXRo
IGl0LCBhbmQgdGhhdCBzZWVtcw0KPiByYXRoZXIgbGltaXRpbmcgd2hlbiBkZWFsaW5nIHdpdGgg
cm90YXRlZCBwbGFuZXMuIEkgY2FuIGVhc2lseSBzZWUNCj4gd2h5IHNvbWVvbmUgdXNpbmcgbW9k
ZXRlc3QgdGhpbmtzIHRoZSBjcnRjIHJlY3Qgc2hvdWxkIGJlIHJvdGF0ZWQgYnkNCj4gdGhlIGRy
aXZlci4uLg0KPiANCj4+IFRoaXMgY2hhbmdlIG1pZ2h0IGJyZWFrIHVzZXJzIHRvby4NCj4gDQo+
IFJpZ2h0IHlvdSBhcmUsIGFuZCB0aGUgc2FtZSBpbXBvc3NpYmxlIHNjZW5hcmlvLiBGaXggdGhp
bmdzIHRvIGRvIHRoZQ0KPiByaWdodCB0aGluZyBhbmQgcmlzayBicmVha2luZyB1c2Vycywgb3Ig
ZG9uJ3QgYW5kIHByZXNlcnZlIHRoZSBidWdneQ0KPiBub24tcG9ydGFibGUgaXNzdWVzIG9mIHRo
ZSBkcml2ZXIgbWFraW5nIGl0IHVudXNhYmxlIGZvciBvdGhlcnMuDQoNCkkgdW5kZXJzdGFuZCB0
aGF0IHdlIGFyZSB0aGUgb25seSBvbmVzIHRvIGJlIGRpZmZlcmVudCBoZXJlLiBNeSANCmNvbGxl
YWd1ZSBKb3NoIGFsc28gaGVscGVkIG1lIGdyYXNwIHRoZSBpbXBsaWNhdGlvbnMgb2YgdGhpcyBp
c3N1ZS4NCg0KSSB3b3VsZCBzYXkgdGhhdCB3ZSBtdXN0bid0IGJlIGRpZmZlcmVudC4gU28gcGxl
YXNlIGNvbnNpZGVyIGZpeGluZyANCnRoaXMuIFNvbWUgdXNlcnMgbWlnaHQgaGF2ZSBzdGFydGVk
IHNvbWV0aGluZyB3aXRoIHJvdGF0aW9ucyBidXQgd2UnbGwgDQptYWtlIHN1cmUgdG8gaGVscCB0
aGVtIHdpdGggdGhlIGlzc3VlIGVuY291bnRlcmVkIGFuZCBvdXIgYWRkaXRpb25hbCBEUk0gDQps
aWJyYXJpZXMgKGxpa2UgbGlicGxhbmVzKSBjYW4gYmUgZml4ZWQgZWFzaWx5IHRvIG1ha2UgdGhp
cyBjaGFuZ2UgDQp0cmFuc3BhcmVudC4NCg0KPiBJIGRvbid0IGNhcmUgZWl0aGVyIHdheSwgYmVj
YXVzZSByb3RhdGluZyBwbGFuZXMgd2l0aCB0aGlzIHN0cmlkZS0NCj4gbWV0aG9kIGlzIHByYWN0
aWNhbGx5IHVzZWxlc3MgaGVyZS4gSXQgc2ltcGx5IHJlcXVpcmVzIHRvIG11Y2gNCj4gbWVtb3J5
IGJhbmR3aWR0aC4gSSBtaWdodCB3b3JrIG9rIGZvciBzbWFsbGVyIHBhbmVscyB3aXRoIGxvd2Vy
DQo+IHBpeGVsIGNsb2NrIGZyZXF1ZW5jaWVzIHRob3VnaD8NCg0KUm90YXRpb24gd29ya3MgZm9y
IG91ciB1c2UgY2FzZXMuDQoNCj4gSSB0aGluayB0aGUgTENEQyBtaWdodCByZWFkIHRoZSBzYW1l
DQo+IGRhdGEgbW9yZSB0aGFuIG9uY2Ugd2hlbiBkYXRhIGlzIG5vdCBpbiB0aGUgIm5hdHVyYWwi
IG9yZGVyPyAobm8sDQo+IEkgZG8gbm90IG5lZWQgYW4gYW5zd2VyIHRvIHRoaXMgcXVlc3Rpb24s
IGFuZCBJIGRvIG5vdCBoYXZlIHRpbWUgdG8NCj4gZGlnIGluIHRoaXMgYXJlYSBhdCB0aGUgbW9t
ZW50Li4uKQ0KPiANCj4gSG93ZXZlciwgaWYgeW91IGNhbid0IGRvIGJvdGggcGF0Y2ggMSBhbmQg
MiAoYmVjYXVzZSB1c2VycyByZWdyZXNzKSwNCj4gdGhlbiBwYXRjaCAzIGlzIG5vIGdvb2QgZWl0
aGVyLiBUaGUgcmVhc29uIGlzIHRoYXQNCj4gZHJtX2F0b21pY19oZWxwZXJfY2hlY2tfcGxhbmVf
c3RhdGUgYXNzdW1lcyB0aGUgcm90YXRpb25hbA0KPiBwcm9wZXJ0aWVzIGZpeGVkIGJ5IHBhdGNo
IDEgYW5kIDIsIGFuZCB0aGUgYmVoYXZpb3IgaXMgIm9kZCIgaWYgeW91DQo+IGhhdmUgdGhhdCB3
cm9uZy4NCg0KVGhhbmtzIGZvciBjb250aW51aW5nIHRoZSBkaXNjdXNzaW9uIEJvcmlzIGFuZCB0
aGFua3MgdG8gUGV0ZXIgZm9yIHRoaXMgDQp3b3JrLiBZb3UgaGF2ZSBteSBvcGluaW9uOiBwbGVh
c2UgZ28tb24gd2l0aCB0aGUgZml4Lg0KDQpCZXN0IHJlZ2FyZHMsDQogICBOaWNvbGFzDQoNCj4+
PiAgIAkJdG1wID0gc3RhdGUtPnNyY193Ow0KPj4+ICAgCQlzdGF0ZS0+c3JjX3cgPSBzdGF0ZS0+
c3JjX2g7DQo+Pj4gICAJCXN0YXRlLT5zcmNfaCA9IHRtcDsNCj4+DQo+IA0KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4g
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsDQo+IA0KDQoNCi0tIA0KTmljb2xhcyBGZXJyZQ0K
