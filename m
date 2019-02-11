Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3151CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D088920821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="lE72jTYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfBKK25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:28:57 -0500
Received: from mail-eopbgr30099.outbound.protection.outlook.com ([40.107.3.99]:6386
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbfBKK24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED6rybNGYA241lx93K39BJF+hq6FylN2jtYOsUpw+No=;
 b=lE72jTYjGm8p/fRh1zlHocJTECiH8uTqTgcy0SAVz2z/fYpqkHRKJEjEnhZ+LzftE4JvI6IfxtpjCDSYeqNOgUzcjk2s8QexFLe+9qiaFvi27DS5SUjKDo6a8MemPjNBX8j0ldfNPcrVstDpurpd8XS3cXvCgW7aWqGCZZ6tQBo=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4672.eurprd02.prod.outlook.com (20.177.63.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Mon, 11 Feb 2019 10:28:52 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 10:28:52 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] i2c:ocores: checkpatch fixes
Thread-Topic: [PATCH v4 5/5] i2c:ocores: checkpatch fixes
Thread-Index: AQHUweRFFunq7wteFEm0TQ/ULVV8ZKXacruA///yogA=
Date:   Mon, 11 Feb 2019 10:28:52 +0000
Message-ID: <ff1e4bec-b15e-0085-6d4e-cd351e000f0f@axentia.se>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
 <20190211083122.32485-6-federico.vaga@cern.ch>
 <fd5b5044-2415-c52c-ecb0-1f0f38267355@axentia.se>
In-Reply-To: <fd5b5044-2415-c52c-ecb0-1f0f38267355@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0701CA0076.eurprd07.prod.outlook.com
 (2603:10a6:3:64::20) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB4672;6:6S+8SFIorqWDGbqLmJJMHbDiWLKaVFfVcxNcgXSZDkz9rvc++nnRldrbuwgvv6/86BXinhOvbSwDnDYnXWX9VMNbKHdZiJ/EFMtdPp1IAymaF6e68jUEcerBrHHbHV3poC5MEDa6etR5J9bBxuvgrrX25Nn/73DKAFyT3PLdUztgvKGSLhRTcb3sHEwurGRDVt8M/BAGMhbNIghz2Xc2SMhVfIDpyX5W2pFNp0F4u4gFUiikWJvQTaj1UYvTW/DbQou6pc7V8bvxAtnvlF+Ss7gKORZVzfKtyMwnSyjA9iK9DYcN5mqzHKOLbdbFyDnRUnLlUuQX/Pb6e7/SJPD1aFK4Q6rK8AK2fhkCCiiUiWEeBxf9pYihVw44CuCm1lP5MDft688YRvCDhXojLupcsKrj2BRAWcUNoAyRWeTxMJPWRNlh0nXPlyn2bEZnGbRC34+A0aql4OnE6qtu+fr3jA==;5:nKhCH7Rhs1hmUyCgi5QyhECG76/7nk5zr9bQJwv8wc+F5yVntUqh4LFaFTLzuL3PctRic3/ltlltC1PxTJL+Ko4Gj4iKvHIxcbtqS7UnQyHLZdVbXTWGiiFy1LcK1lgLIZvsiFspyBR6lu8PH2B7seRyWSJSwXZBus6CDWXNQ4n5jE+tzUmzZrN3myIWg3/KfTjVudZtmVJz1RA51Xq8mA==;7:mlJWCFr2N4q+YtKOZfQtj/r3q/rPjaVVaK7DQgXtPqFz8fUDCMkjkRi2Gh/8WCOswAxf2Riw9nzzXr4rRCTpFB4/treRSXuKBmHVNfiLcIr3H1mkdw5JF8KAzjOeK8iDkRvq/a/JGsWzAfbJxV+bpA==
x-ms-office365-filtering-correlation-id: 08f5ebd1-a4c7-45e3-e6a9-08d6900bb784
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4672;
x-ms-traffictypediagnostic: VI1PR02MB4672:
x-microsoft-antispam-prvs: <VI1PR02MB4672981CE27911C97828B395BC640@VI1PR02MB4672.eurprd02.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(366004)(39830400003)(346002)(189003)(199004)(7736002)(74482002)(186003)(476003)(2616005)(31686004)(71190400001)(52116002)(446003)(6246003)(11346002)(97736004)(486006)(25786009)(2906002)(76176011)(71200400001)(4326008)(305945005)(53936002)(6116002)(3846002)(68736007)(65806001)(65956001)(66066001)(6512007)(81166006)(8936002)(316002)(58126008)(110136005)(54906003)(386003)(102836004)(81156014)(14454004)(8676002)(31696002)(106356001)(256004)(86362001)(14444005)(6436002)(64126003)(105586002)(6486002)(26005)(229853002)(508600001)(6506007)(65826007)(53546011)(99286004)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4672;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NMkukZzZ5JLX8ayJAihfS8eG6tVx1OOpEYHSJ1Uw6fzVM1e3Uk6fgKgYWdlGtJIiqy+koI/ejcP4u4XIK3Nbydl7/oNUvuzf4NufWjUvZcp+iZ8LxB/TUkI4lp+ZKF3idgdhjcBH3RJktsOxo/L1tOwFkeAk7HHKoRQ2u2FyMcqCYUUHsLAJ++j1d5O9VBGq8zaobLEUciQ2G2YJLWTSDoEAL82fIMNHlqM859brnDgOWYpymKB7i7ze64KH0HgwD774RdbV4e00qRNE2u2QRQBYi2OckrKBQ6ZMG0U4HUue+sOs4i33c5cC4fnm9/Dq3cTYQ6iMb/hgRIQnWf8bpGj6lKWauHZS5O2TtKghZeUpkjO4oAqg5CFqORUQy3p2UyYf2TuboN8oQ3qIBMJ7hWmcv1UAQ0uKrK6frwn1IWA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A31621E2ECFFFA478B29FB9B2B718735@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f5ebd1-a4c7-45e3-e6a9-08d6900bb784
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 10:28:51.1339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4672
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMi0xMSAxMToxNiwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+IE9uIDIwMTktMDItMTEg
MDk6MzEsIEZlZGVyaWNvIFZhZ2Egd3JvdGU6DQo+PiBNaXNjZWxsYW5lb3VzIHN0eWxlIGZpeGVz
IGZyb20gY2hlY2twYXRjaA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEZlZGVyaWNvIFZhZ2EgPGZl
ZGVyaWNvLnZhZ2FAY2Vybi5jaD4NCj4+IFJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+Pg0KPj4gLS0tDQo+PiAgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1vY29yZXMu
YyB8IDE5ICsrKysrKysrKysrKy0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMv
YnVzc2VzL2kyYy1vY29yZXMuYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb2NvcmVzLmMNCj4+
IGluZGV4IDViODAxOTAuLmJhMzVkMmEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2kyYy9idXNz
ZXMvaTJjLW9jb3Jlcy5jDQo+PiArKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLW9jb3Jlcy5j
DQo+PiBAQCAtMTgyLDggKzE4Miw5IEBAIHN0YXRpYyB2b2lkIG9jb3Jlc19wcm9jZXNzKHN0cnVj
dCBvY29yZXNfaTJjICppMmMsIHU4IHN0YXQpDQo+PiAgCQkJb2Nfc2V0cmVnKGkyYywgT0NJMkNf
Q01ELCBPQ0kyQ19DTURfU1RPUCk7DQo+PiAgCQkJZ290byBvdXQ7DQo+PiAgCQl9DQo+PiAtCX0g
ZWxzZQ0KPj4gKwl9IGVsc2Ugew0KPj4gIAkJbXNnLT5idWZbaTJjLT5wb3MrK10gPSBvY19nZXRy
ZWcoaTJjLCBPQ0kyQ19EQVRBKTsNCj4+ICsJfQ0KPj4gIA0KPj4gIAkvKiBlbmQgb2YgbXNnPyAq
Lw0KPj4gIAlpZiAoaTJjLT5wb3MgPT0gbXNnLT5sZW4pIHsNCj4+IEBAIC0yMDIsOSArMjAzLDkg
QEAgc3RhdGljIHZvaWQgb2NvcmVzX3Byb2Nlc3Moc3RydWN0IG9jb3Jlc19pMmMgKmkyYywgdTgg
c3RhdCkNCj4+ICAJCQkJb2Nfc2V0cmVnKGkyYywgT0NJMkNfREFUQSwgYWRkcik7DQo+PiAgCQkJ
CW9jX3NldHJlZyhpMmMsIE9DSTJDX0NNRCwgIE9DSTJDX0NNRF9TVEFSVCk7DQo+PiAgCQkJCWdv
dG8gb3V0Ow0KPj4gLQkJCX0gZWxzZQ0KPj4gLQkJCQlpMmMtPnN0YXRlID0gKG1zZy0+ZmxhZ3Mg
JiBJMkNfTV9SRCkNCj4+IC0JCQkJCT8gU1RBVEVfUkVBRCA6IFNUQVRFX1dSSVRFOw0KPj4gKwkJ
CX0NCj4+ICsJCQlpMmMtPnN0YXRlID0gKG1zZy0+ZmxhZ3MgJiBJMkNfTV9SRCkNCj4+ICsJCQkJ
PyBTVEFURV9SRUFEIDogU1RBVEVfV1JJVEU7DQo+PiAgCQl9IGVsc2Ugew0KPj4gIAkJCWkyYy0+
c3RhdGUgPSBTVEFURV9ET05FOw0KPj4gIAkJCW9jX3NldHJlZyhpMmMsIE9DSTJDX0NNRCwgT0NJ
MkNfQ01EX1NUT1ApOw0KPj4gQEAgLTQwNSw3ICs0MDYsOCBAQCBzdGF0aWMgaW50IG9jb3Jlc19p
bml0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG9jb3Jlc19pMmMgKmkyYykNCj4+ICAJdTgg
Y3RybCA9IG9jX2dldHJlZyhpMmMsIE9DSTJDX0NPTlRST0wpOw0KPj4gIA0KPj4gIAkvKiBtYWtl
IHN1cmUgdGhlIGRldmljZSBpcyBkaXNhYmxlZCAqLw0KPj4gLQlvY19zZXRyZWcoaTJjLCBPQ0ky
Q19DT05UUk9MLCBjdHJsICYgfihPQ0kyQ19DVFJMX0VOfE9DSTJDX0NUUkxfSUVOKSk7DQo+PiAr
CWN0cmwgJj0gfihPQ0kyQ19DVFJMX0VOIHwgT0NJMkNfQ1RSTF9JRU4pOw0KPj4gKwlvY19zZXRy
ZWcoaTJjLCBPQ0kyQ19DT05UUk9MLCBjdHJsKTsNCj4+ICANCj4+ICAJcHJlc2NhbGUgPSAoaTJj
LT5pcF9jbG9ja19raHogLyAoNSAqIGkyYy0+YnVzX2Nsb2NrX2toeikpIC0gMTsNCj4+ICAJcHJl
c2NhbGUgPSBjbGFtcChwcmVzY2FsZSwgMCwgMHhmZmZmKTsNCj4+IEBAIC00NjIsMTEgKzQ2NCwx
MyBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBvY29yZXNfaTJjX21hdGNoKTsNCj4+ICAjaWZk
ZWYgQ09ORklHX09GDQo+PiAgLyogUmVhZCBhbmQgd3JpdGUgZnVuY3Rpb25zIGZvciB0aGUgR1JM
SUIgcG9ydCBvZiB0aGUgY29udHJvbGxlci4gUmVnaXN0ZXJzIGFyZQ0KPj4gICAqIDMyLWJpdCBi
aWcgZW5kaWFuIGFuZCB0aGUgUFJFTE9XIGFuZCBQUkVISUdIIHJlZ2lzdGVycyBhcmUgbWVyZ2Vk
IGludG8gb25lDQo+PiAtICogcmVnaXN0ZXIuIFRoZSBzdWJzZXF1ZW50IHJlZ2lzdGVycyBoYXMg
dGhlaXIgb2Zmc2V0IGRlY3JlYXNlZCBhY2NvcmRpbmdseS4gKi8NCj4+ICsgKiByZWdpc3Rlci4g
VGhlIHN1YnNlcXVlbnQgcmVnaXN0ZXJzIGhhcyB0aGVpciBvZmZzZXQgZGVjcmVhc2VkIGFjY29y
ZGluZ2x5Lg0KDQpoYXMgLT4gaGF2ZQ0KDQpvZmZzZXQgLT4gb2Zmc2V0cyAgPz8/IEkgdGhpbms/
DQoNCj4+ICsgKi8NCj4gDQo+IFRoZSBwcmVmZXJyZWQgbXVsdGktbGluZSBjb21tZW50IHN0eWxl
cyBpczoNCg0KQW5kIGZpbmFsbHksIHRoaXMgdHlwbyBpcyBteSBvd24uLi4NCg0Kc3R5bGVzIC0+
IHN0eWxlDQoNCkNoZWVycyBhbmQgc29ycnkgZm9yIHJlcGx5aW5nIHRvIHNlbGYsDQpQZXRlcg0K
DQo+IA0KPiAvKg0KPiAgKiBSZWFkLi4uDQo+ICAqIC4uLmFjY29yZGluZ2x5Lg0KPiAgKi8NCj4g
DQo+IFNvLCBwbGVhc2UgZml4IGFsbCBpc3N1ZXMgd2hlbiB5b3UgYXJlIGNoYW5naW5nIGl0IHRv
IGNvbmZvcm0uDQo+IA0KPiBDaGVlcnMsDQo+IFBldGVyDQo+IA0KPj4gIHN0YXRpYyB1OCBvY19n
ZXRyZWdfZ3JsaWIoc3RydWN0IG9jb3Jlc19pMmMgKmkyYywgaW50IHJlZykNCj4+ICB7DQo+PiAg
CXUzMiByZDsNCj4+ICAJaW50IHJyZWcgPSByZWc7DQo+PiArDQo+PiAgCWlmIChyZWcgIT0gT0NJ
MkNfUFJFTE9XKQ0KPj4gIAkJcnJlZy0tOw0KPj4gIAlyZCA9IGlvcmVhZDMyYmUoaTJjLT5iYXNl
ICsgKHJyZWcgPDwgaTJjLT5yZWdfc2hpZnQpKTsNCj4+IEBAIC00ODAsNiArNDg0LDcgQEAgc3Rh
dGljIHZvaWQgb2Nfc2V0cmVnX2dybGliKHN0cnVjdCBvY29yZXNfaTJjICppMmMsIGludCByZWcs
IHU4IHZhbHVlKQ0KPj4gIHsNCj4+ICAJdTMyIGN1cnIsIHdyOw0KPj4gIAlpbnQgcnJlZyA9IHJl
ZzsNCj4+ICsNCj4+ICAJaWYgKHJlZyAhPSBPQ0kyQ19QUkVMT1cpDQo+PiAgCQlycmVnLS07DQo+
PiAgCWlmIChyZWcgPT0gT0NJMkNfUFJFTE9XIHx8IHJlZyA9PSBPQ0kyQ19QUkVISUdIKSB7DQo+
PiBAQCAtNTY4LDcgKzU3Myw3IEBAIHN0YXRpYyBpbnQgb2NvcmVzX2kyY19vZl9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPj4gIAlyZXR1cm4gMDsNCj4+ICB9DQo+PiAgI2Vs
c2UNCj4+IC0jZGVmaW5lIG9jb3Jlc19pMmNfb2ZfcHJvYmUocGRldixpMmMpIC1FTk9ERVYNCj4+
ICsjZGVmaW5lIG9jb3Jlc19pMmNfb2ZfcHJvYmUocGRldiwgaTJjKSAtRU5PREVWDQo+PiAgI2Vu
ZGlmDQo+PiAgDQo+PiAgc3RhdGljIGludCBvY29yZXNfaTJjX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+Pg0KPiANCg0K
