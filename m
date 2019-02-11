Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C82C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697BE20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="XhDKWu39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfBKQMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:12:31 -0500
Received: from mail-eopbgr130129.outbound.protection.outlook.com ([40.107.13.129]:21568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727135AbfBKQM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH754bPOFjYZYohRol4EKaSsqWW+Ri0zxOoPaCpdTe0=;
 b=XhDKWu39UX6inYRepSADK6fUrEEc7o81gRQPGeqhrfV5aiZmD0mZGOT/uSg3pw2LIuA+QUCgHVOcPSKBAsoPnZEWBt6JZQ2Rnvkd+wmEHPt0bdTxl6prMM9nG5FPUWcDK4JNhoegQuFM6XxiA0gHouji4eeN8Wh3PTDMuJUZPhk=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB5134.eurprd02.prod.outlook.com (20.178.13.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Mon, 11 Feb 2019 16:12:23 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 16:12:23 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] i2c:ocores: checkpatch fixes
Thread-Topic: [PATCH v5 5/5] i2c:ocores: checkpatch fixes
Thread-Index: AQHUwiPA9FIqyrmCzk2qZYbW0uqNAKXaxNkA
Date:   Mon, 11 Feb 2019 16:12:23 +0000
Message-ID: <bbaaa303-75f1-9272-c01f-914175237f05@axentia.se>
References: <20190211160529.23858-1-federico.vaga@cern.ch>
 <20190211160529.23858-6-federico.vaga@cern.ch>
In-Reply-To: <20190211160529.23858-6-federico.vaga@cern.ch>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR08CA0053.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::24) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB5134;6:pVdeQpnGlupbB7kxXY84xSfacOMj11Yb9qGi7IEorb9oUaEm7IvC8vIiLtJpfEopAo8LlDRImG/YSka2DBkeBb+og5T9/28h1yuk73EscK8qHolLaHa2mALp5sF5ash+xww+1R3JrurEkU2RxdDVWlR1QkmSQnHWyI5ZvzJNRmN7YwA02hM8Lp224nfwQL2elz674gDh/13/JYrf3Pw8KaH65nYN3V89efUXjoepEEsP0LBTvhuGNU1QAte5zt8zgj6pi+noNAZCAIJxOBR5HAQAxfqMlSrSOdoi7YhRxCPUdT+p/0GePU3lj45crxY+HsmAHS1FGWICmKky6kj0EKnJEWSR6Cp+nVgB6Z662cePHa6PgZ4Y8Kz7dmEzn8e9eQbiLnOluE6fLz+2VNGGdTZF09P5WsB002ajATK3irBc8L0sPWbI8CaC3RrgkCZ5nb4cLXw/tKol4N83RUHScQ==;5:+lIXBN8YudRUo3+XLYwyXqvjrGFCaBEKOdoj3UFfbsotwWN5jmp6DAtnKmsP6mr7wtO+WmWaT98zA+iuvVs8WIDfoi3LK/WeRAVYFvKt6jDVBghbkwJ2Lar3WXbVf0rzJCHiCth4dCJ2pSFQzodtAttCUg1KhndhyoWhFw1bvOnjqopZbVyb5IWeQ4DgCQUnm6OV5nUndXdGLsI5tx9uMA==;7:h863BH8Pr0XQRvZQtXIx/aexRzveauUSB9xy3nlmkrYn+XLl7sqcDgeKkFkOXLvH+4EMK/Ob9Cz0rCq7TL+fbRmiQUH++JhGfAt1mHAY1w6SYoJLw1yb+Wjky4K73dy0hTVP07dIxE8DEFpZx4Of8w==
x-ms-office365-filtering-correlation-id: 5f5d8163-b597-4b07-6946-08d6903bb4c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB5134;
x-ms-traffictypediagnostic: VI1PR02MB5134:
x-microsoft-antispam-prvs: <VI1PR02MB5134432C5DA2A39A82CBB0C0BC640@VI1PR02MB5134.eurprd02.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(376002)(366004)(136003)(396003)(199004)(189003)(486006)(256004)(26005)(106356001)(65826007)(186003)(316002)(6512007)(58126008)(110136005)(508600001)(2906002)(71190400001)(71200400001)(14454004)(476003)(2616005)(11346002)(446003)(81156014)(14444005)(74482002)(3846002)(8936002)(6116002)(305945005)(97736004)(7736002)(81166006)(8676002)(31686004)(65806001)(66066001)(99286004)(54906003)(102836004)(64126003)(52116002)(105586002)(86362001)(65956001)(36756003)(4326008)(6486002)(68736007)(53936002)(6246003)(229853002)(25786009)(6436002)(386003)(6506007)(31696002)(76176011)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB5134;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q4b9YEYgX8DIhckQeusbP1YjHR2xupEroWhrYGl9vwFa0mko5QW+i0QX1OkriSx7ixrzo0OWorTebxeQlfIXIpjrTNuW2u1OWchfkWC9yCywECkpOWy0nwDvt2fp1eqnlPL5Cd2l7BZ9Fhx8nUI1cY/YAApSWUr5Jyo9TucIXJXimRoEK5t2Njd6DGwuje2I/fD/iYZN3yvOhKkR+3lSxtozNH5qAnV1e4lHUYetKcwqyASmCOPi5d05Kx2jVLkt8mRF2eXBbfoXiLqGLsnZj9vCPCv2jwDp6EbAYflOHUsiz8OicH5eaVwDrCpRTg1WyHhyzsDhwkZ60ryGGka3MBH5mUkiuYnDoKE6Cy09NkpaGjEK2wboFWTw/lZblHv+MRr6/+Awm4AQeIDeY5LCSnZ8xy0BkmeaP3cDa6KN3OA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DBBBF2B3DCE7A43B7F7F646A610C835@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5d8163-b597-4b07-6946-08d6903bb4c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 16:12:22.4614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMi0xMSAxNzowNSwgRmVkZXJpY28gVmFnYSB3cm90ZToNCj4gTWlzY2VsbGFuZW91
cyBzdHlsZSBmaXhlcyBmcm9tIGNoZWNrcGF0Y2gNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZlZGVy
aWNvIFZhZ2EgPGZlZGVyaWNvLnZhZ2FAY2Vybi5jaD4NCj4gLS0tDQo+ICBkcml2ZXJzL2kyYy9i
dXNzZXMvaTJjLW9jb3Jlcy5jIHwgMzAgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1vY29yZXMuYyBiL2RyaXZlcnMv
aTJjL2J1c3Nlcy9pMmMtb2NvcmVzLmMNCj4gaW5kZXggNzgwODVhOC4uNTRiMjE1NiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1vY29yZXMuYw0KPiArKysgYi9kcml2ZXJz
L2kyYy9idXNzZXMvaTJjLW9jb3Jlcy5jDQo+IEBAIC0xNzksOCArMTc5LDkgQEAgc3RhdGljIHZv
aWQgb2NvcmVzX3Byb2Nlc3Moc3RydWN0IG9jb3Jlc19pMmMgKmkyYywgdTggc3RhdCkNCj4gIAkJ
CW9jX3NldHJlZyhpMmMsIE9DSTJDX0NNRCwgT0NJMkNfQ01EX1NUT1ApOw0KPiAgCQkJZ290byBv
dXQ7DQo+ICAJCX0NCj4gLQl9IGVsc2UNCj4gKwl9IGVsc2Ugew0KPiAgCQltc2ctPmJ1ZltpMmMt
PnBvcysrXSA9IG9jX2dldHJlZyhpMmMsIE9DSTJDX0RBVEEpOw0KPiArCX0NCj4gIA0KPiAgCS8q
IGVuZCBvZiBtc2c/ICovDQo+ICAJaWYgKGkyYy0+cG9zID09IG1zZy0+bGVuKSB7DQo+IEBAIC0x
OTcsMTEgKzE5OCwxMSBAQCBzdGF0aWMgdm9pZCBvY29yZXNfcHJvY2VzcyhzdHJ1Y3Qgb2NvcmVz
X2kyYyAqaTJjLCB1OCBzdGF0KQ0KPiAgCQkJCWkyYy0+c3RhdGUgPSBTVEFURV9TVEFSVDsNCj4g
IA0KPiAgCQkJCW9jX3NldHJlZyhpMmMsIE9DSTJDX0RBVEEsIGFkZHIpOw0KPiAtCQkJCW9jX3Nl
dHJlZyhpMmMsIE9DSTJDX0NNRCwgIE9DSTJDX0NNRF9TVEFSVCk7DQo+ICsJCQkJb2Nfc2V0cmVn
KGkyYywgT0NJMkNfQ01ELCBPQ0kyQ19DTURfU1RBUlQpOw0KPiAgCQkJCWdvdG8gb3V0Ow0KPiAt
CQkJfSBlbHNlDQo+IC0JCQkJaTJjLT5zdGF0ZSA9IChtc2ctPmZsYWdzICYgSTJDX01fUkQpDQo+
IC0JCQkJCT8gU1RBVEVfUkVBRCA6IFNUQVRFX1dSSVRFOw0KPiArCQkJfQ0KPiArCQkJaTJjLT5z
dGF0ZSA9IChtc2ctPmZsYWdzICYgSTJDX01fUkQpDQo+ICsJCQkJPyBTVEFURV9SRUFEIDogU1RB
VEVfV1JJVEU7DQo+ICAJCX0gZWxzZSB7DQo+ICAJCQlpMmMtPnN0YXRlID0gU1RBVEVfRE9ORTsN
Cj4gIAkJCW9jX3NldHJlZyhpMmMsIE9DSTJDX0NNRCwgT0NJMkNfQ01EX1NUT1ApOw0KPiBAQCAt
NDYxLDEzICs0NjIsMTYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgb2NvcmVz
X2kyY19tYXRjaFtdID0gew0KPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgb2NvcmVzX2kyY19t
YXRjaCk7DQo+ICANCj4gICNpZmRlZiBDT05GSUdfT0YNCj4gLS8qIFJlYWQgYW5kIHdyaXRlIGZ1
bmN0aW9ucyBmb3IgdGhlIEdSTElCIHBvcnQgb2YgdGhlIGNvbnRyb2xsZXIuIFJlZ2lzdGVycyBh
cmUNCj4gKy8qDQo+ICsgKiBSZWFkIGFuZCB3cml0ZSBmdW5jdGlvbnMgZm9yIHRoZSBHUkxJQiBw
b3J0IG9mIHRoZSBjb250cm9sbGVyLiBSZWdpc3RlcnMgYXJlDQo+ICAgKiAzMi1iaXQgYmlnIGVu
ZGlhbiBhbmQgdGhlIFBSRUxPVyBhbmQgUFJFSElHSCByZWdpc3RlcnMgYXJlIG1lcmdlZCBpbnRv
IG9uZQ0KPiAtICogcmVnaXN0ZXIuIFRoZSBzdWJzZXF1ZW50IHJlZ2lzdGVycyBoYXMgdGhlaXIg
b2Zmc2V0IGRlY3JlYXNlZCBhY2NvcmRpbmdseS4gKi8NCj4gKyAqIHJlZ2lzdGVyLiBUaGUgc3Vi
c2VxdWVudCByZWdpc3RlcnMgaGF2ZSB0aGVpciBvZmZzZXRzIGRlY3JlYXNlZCBhY2NvcmRpbmds
eS4NCj4gKyAqLw0KPiAgc3RhdGljIHU4IG9jX2dldHJlZ19ncmxpYihzdHJ1Y3Qgb2NvcmVzX2ky
YyAqaTJjLCBpbnQgcmVnKQ0KPiAgew0KPiAgCXUzMiByZDsNCj4gIAlpbnQgcnJlZyA9IHJlZzsN
Cj4gKw0KPiAgCWlmIChyZWcgIT0gT0NJMkNfUFJFTE9XKQ0KPiAgCQlycmVnLS07DQo+ICAJcmQg
PSBpb3JlYWQzMmJlKGkyYy0+YmFzZSArIChycmVnIDw8IGkyYy0+cmVnX3NoaWZ0KSk7DQo+IEBA
IC00ODEsNiArNDg1LDcgQEAgc3RhdGljIHZvaWQgb2Nfc2V0cmVnX2dybGliKHN0cnVjdCBvY29y
ZXNfaTJjICppMmMsIGludCByZWcsIHU4IHZhbHVlKQ0KPiAgew0KPiAgCXUzMiBjdXJyLCB3cjsN
Cj4gIAlpbnQgcnJlZyA9IHJlZzsNCj4gKw0KPiAgCWlmIChyZWcgIT0gT0NJMkNfUFJFTE9XKQ0K
PiAgCQlycmVnLS07DQo+ICAJaWYgKHJlZyA9PSBPQ0kyQ19QUkVMT1cgfHwgcmVnID09IE9DSTJD
X1BSRUhJR0gpIHsNCj4gQEAgLTU2OSw3ICs1NzQsNyBAQCBzdGF0aWMgaW50IG9jb3Jlc19pMmNf
b2ZfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gIAlyZXR1cm4gMDsNCj4g
IH0NCj4gICNlbHNlDQo+IC0jZGVmaW5lIG9jb3Jlc19pMmNfb2ZfcHJvYmUocGRldixpMmMpIC1F
Tk9ERVYNCj4gKyNkZWZpbmUgb2NvcmVzX2kyY19vZl9wcm9iZShwZGV2LCBpMmMpIC1FTk9ERVYN
Cj4gICNlbmRpZg0KPiAgDQo+ICBzdGF0aWMgaW50IG9jb3Jlc19pMmNfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gQEAgLTY4NiwxMCArNjkxLDExIEBAIGVycl9jbGs6DQo+
ICBzdGF0aWMgaW50IG9jb3Jlc19pMmNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICB7DQo+ICAJc3RydWN0IG9jb3Jlc19pMmMgKmkyYyA9IHBsYXRmb3JtX2dldF9kcnZk
YXRhKHBkZXYpOw0KPiArCXU4IGN0cmwgPSBvY19nZXRyZWcoaTJjLCBPQ0kyQ19DT05UUk9MKTsN
Cj4gIA0KPiAgCS8qIGRpc2FibGUgaTJjIGxvZ2ljICovDQo+IC0Jb2Nfc2V0cmVnKGkyYywgT0NJ
MkNfQ09OVFJPTCwgb2NfZ2V0cmVnKGkyYywgT0NJMkNfQ09OVFJPTCkNCj4gLQkJICAmIH4oT0NJ
MkNfQ1RSTF9FTnxPQ0kyQ19DVFJMX0lFTikpOw0KPiArCWN0cmwgJj0gfihPQ0kyQ19DVFJMX0VO
IHwgT0NJMkNfQ1RSTF9JRU4pOw0KPiArCW9jX3NldHJlZyhpMmMsIE9DSTJDX0NPTlRST0wsIGN0
cmwpOw0KPiAgDQo+ICAJLyogcmVtb3ZlIGFkYXB0ZXIgJiBkYXRhICovDQo+ICAJaTJjX2RlbF9h
ZGFwdGVyKCZpMmMtPmFkYXApOw0KPiBAQCAtNzA3LDcgKzcxMyw5IEBAIHN0YXRpYyBpbnQgb2Nv
cmVzX2kyY19zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAl1OCBjdHJsID0gb2NfZ2V0
cmVnKGkyYywgT0NJMkNfQ09OVFJPTCk7DQo+ICANCj4gIAkvKiBtYWtlIHN1cmUgdGhlIGRldmlj
ZSBpcyBkaXNhYmxlZCAqLw0KPiAtCW9jX3NldHJlZyhpMmMsIE9DSTJDX0NPTlRST0wsIGN0cmwg
JiB+KE9DSTJDX0NUUkxfRU58T0NJMkNfQ1RSTF9JRU4pKTsNCj4gKwljdHJsID0gb2NfZ2V0cmVn
KGkyYywgT0NJMkNfQ09OVFJPTCk7DQoNClRoZXJlJ3MgYSBwb2ludGxlc3MgZG91YmxlIG9jX2dl
dHJlZyhpMmMsIE9DSTJDX0NPTlRST0wpLg0KDQpDaGVlcnMsDQpQZXRlcg0KDQo+ICsJY3RybCAm
PSB+KE9DSTJDX0NUUkxfRU4gfCBPQ0kyQ19DVFJMX0lFTik7DQo+ICsJb2Nfc2V0cmVnKGkyYywg
T0NJMkNfQ09OVFJPTCwgY3RybCk7DQo+ICANCj4gIAlpZiAoIUlTX0VSUihpMmMtPmNsaykpDQo+
ICAJCWNsa19kaXNhYmxlX3VucHJlcGFyZShpMmMtPmNsayk7DQo+IA0KDQo=
