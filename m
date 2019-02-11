Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7867CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB4720838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="FM0mXWw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBKKQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:16:49 -0500
Received: from mail-eopbgr00098.outbound.protection.outlook.com ([40.107.0.98]:12288
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfBKKQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGDFULO2pmLaBxCfSBUmW1/xJbj4coDWdrJQa7hv/wg=;
 b=FM0mXWw+FUIr818SqLWPTeLFzCqlhcu/PhYetp2dRKwFBwEpORSTU/OtmmQlNleeRtJnb1PgrUu1rDR45Ju5vYzSQ1/RbiXMyGgsN/FDceM0YAyagmR4rdZmGAruGkG75pfc+eY1b7mvHH8rDj6nfv+eG/fUjJiEM7oEQSBFpLA=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB3231.eurprd02.prod.outlook.com (10.170.237.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Mon, 11 Feb 2019 10:16:42 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 10:16:42 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] i2c:ocores: checkpatch fixes
Thread-Topic: [PATCH v4 5/5] i2c:ocores: checkpatch fixes
Thread-Index: AQHUweRFFunq7wteFEm0TQ/ULVV8ZKXaYfiA
Date:   Mon, 11 Feb 2019 10:16:41 +0000
Message-ID: <fd5b5044-2415-c52c-ecb0-1f0f38267355@axentia.se>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
 <20190211083122.32485-6-federico.vaga@cern.ch>
In-Reply-To: <20190211083122.32485-6-federico.vaga@cern.ch>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:7:67::13) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB3231;6:wgU/iS1GDSHCc6Br0E39ubbvhcao7UQBQxHUjyVLCoOl/E189/NBz/GGRxqZqroBJVpmax8u55C9DDltyx7yvM3uMl9HPHneXw7ycLazdEa7QcKsT6gpIJVCgjYKOUnlnHxpd+geuMkOlSrzxQn7LGX6MQiQpQ3qBjU/Uma2gl6wFoIRKQxqkD396vf99fgSsni3Crm3+cbtl6Ap+hhsqcVRyYN7PlCD34oFrpBgxvxsfh2/VzSjmvP2+2mnJEkMAALznpBJ9Ev7FlzQoDhD7STFoRfDZXSaJkrF8SrToMc8sTQh2YD0jWwqgPjDnOz8Abb83wZDHGRx3/QiHcKdIOWksxZDdHtXFwwVfqqcakxj0kg4Hm/FPoOlZcg1f8JWL7ccIp1o0SKE86U+S5rBvksy/cZFtmW04rF2P8oY348AcaKhpspA7ncLC/cpYis2b0CCrrFq/inimZIBtFv2oA==;5:6NEuzgU5VOl1CKY+MbjzKNAkYwPjOSz53hWSi7laLVX/H+ZWzTVuB3dvRzt09i8p5k77EpvaYMzyStHFtSs3TToLX90sHhaMmF36f6Y6yhzEXMgxMeS64RS5hsBu79GrkFC0xjyt2IRRY73UsFJ2rxM/TVGrAfR2gEod5JC0YculCo9JwpeBKCq8t7eUKiPQ4NmwGRimuCpPwlKmAy7TBw==;7:kE4aQffMJ+4ko+XcVQJFB09LLcZJa83flsJ6h7InNfFaUOx+Tg4+JJ3dcsAxfM9jI1bPRzatoXUCywHFLKgYzlZ1G+LkcTWw6BsbCKo5T3Tcd5DZ80TpJ5tk7nYpfEv/+IkhZdFXeT2anIScF4KIrQ==
x-ms-office365-filtering-correlation-id: e3fb167f-43c4-4c99-3609-08d6900a0457
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB3231;
x-ms-traffictypediagnostic: VI1PR02MB3231:
x-microsoft-antispam-prvs: <VI1PR02MB323137516F6A528DC62BCA63BC640@VI1PR02MB3231.eurprd02.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(39830400003)(366004)(189003)(199004)(316002)(99286004)(2906002)(476003)(2616005)(6116002)(53936002)(105586002)(65956001)(66066001)(65806001)(52116002)(106356001)(26005)(25786009)(76176011)(71200400001)(71190400001)(486006)(54906003)(3846002)(110136005)(36756003)(229853002)(58126008)(53546011)(6506007)(386003)(97736004)(6512007)(186003)(6436002)(6486002)(74482002)(446003)(11346002)(102836004)(65826007)(6246003)(14444005)(31686004)(31696002)(86362001)(68736007)(14454004)(64126003)(305945005)(508600001)(7736002)(4326008)(8936002)(8676002)(81166006)(81156014)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3231;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GPCn+YCxxZryzL699IBF+VZq9+OlsC18DSTd518AhMxpWKwPL0nWbPfiUs2OsCIW3jBl+Rzauvmbb+hc+IXYsH0NLh9l1EGAZcL5WHgZqkhsoTbUCnx/8NOcxieE23yuzz18rB2ZL9MY6HeAfnY3M8yeWQaDPY4hHylumYMoNhflkSW3j372otQRBFWyNWg2+jzjsSfwzTEKe86kOAauo8g09Cj8X1h1HI0c0PrGa9bXsPUhmu26qTe9NfObN3Vem/7+tO/yXARzHkcMqpuDdhqsXgTpOnQI51M7dGkKNppaDO9Jk3l5uI+mAmAFjDsn6xIZ+xIPAroZH8QBoRdqTab8E36l7ChqY2kK+caidwRENhdgc/kCwMg4EREDEdTBJYYWmZs6QhLi06rwo0/KPln7kKfg4iIj7c65PReXLIA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D8B36CAC418574786DCADDF0B51E068@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fb167f-43c4-4c99-3609-08d6900a0457
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 10:16:41.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMi0xMSAwOTozMSwgRmVkZXJpY28gVmFnYSB3cm90ZToNCj4gTWlzY2VsbGFuZW91
cyBzdHlsZSBmaXhlcyBmcm9tIGNoZWNrcGF0Y2gNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZlZGVy
aWNvIFZhZ2EgPGZlZGVyaWNvLnZhZ2FAY2Vybi5jaD4NCj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBM
dW5uIDxhbmRyZXdAbHVubi5jaD4NCj4gDQo+IC0tLQ0KPiAgZHJpdmVycy9pMmMvYnVzc2VzL2ky
Yy1vY29yZXMuYyB8IDE5ICsrKysrKysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
MiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaTJjL2J1c3Nlcy9pMmMtb2NvcmVzLmMgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLW9jb3Jl
cy5jDQo+IGluZGV4IDViODAxOTAuLmJhMzVkMmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaTJj
L2J1c3Nlcy9pMmMtb2NvcmVzLmMNCj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1vY29y
ZXMuYw0KPiBAQCAtMTgyLDggKzE4Miw5IEBAIHN0YXRpYyB2b2lkIG9jb3Jlc19wcm9jZXNzKHN0
cnVjdCBvY29yZXNfaTJjICppMmMsIHU4IHN0YXQpDQo+ICAJCQlvY19zZXRyZWcoaTJjLCBPQ0ky
Q19DTUQsIE9DSTJDX0NNRF9TVE9QKTsNCj4gIAkJCWdvdG8gb3V0Ow0KPiAgCQl9DQo+IC0JfSBl
bHNlDQo+ICsJfSBlbHNlIHsNCj4gIAkJbXNnLT5idWZbaTJjLT5wb3MrK10gPSBvY19nZXRyZWco
aTJjLCBPQ0kyQ19EQVRBKTsNCj4gKwl9DQo+ICANCj4gIAkvKiBlbmQgb2YgbXNnPyAqLw0KPiAg
CWlmIChpMmMtPnBvcyA9PSBtc2ctPmxlbikgew0KPiBAQCAtMjAyLDkgKzIwMyw5IEBAIHN0YXRp
YyB2b2lkIG9jb3Jlc19wcm9jZXNzKHN0cnVjdCBvY29yZXNfaTJjICppMmMsIHU4IHN0YXQpDQo+
ICAJCQkJb2Nfc2V0cmVnKGkyYywgT0NJMkNfREFUQSwgYWRkcik7DQo+ICAJCQkJb2Nfc2V0cmVn
KGkyYywgT0NJMkNfQ01ELCAgT0NJMkNfQ01EX1NUQVJUKTsNCj4gIAkJCQlnb3RvIG91dDsNCj4g
LQkJCX0gZWxzZQ0KPiAtCQkJCWkyYy0+c3RhdGUgPSAobXNnLT5mbGFncyAmIEkyQ19NX1JEKQ0K
PiAtCQkJCQk/IFNUQVRFX1JFQUQgOiBTVEFURV9XUklURTsNCj4gKwkJCX0NCj4gKwkJCWkyYy0+
c3RhdGUgPSAobXNnLT5mbGFncyAmIEkyQ19NX1JEKQ0KPiArCQkJCT8gU1RBVEVfUkVBRCA6IFNU
QVRFX1dSSVRFOw0KPiAgCQl9IGVsc2Ugew0KPiAgCQkJaTJjLT5zdGF0ZSA9IFNUQVRFX0RPTkU7
DQo+ICAJCQlvY19zZXRyZWcoaTJjLCBPQ0kyQ19DTUQsIE9DSTJDX0NNRF9TVE9QKTsNCj4gQEAg
LTQwNSw3ICs0MDYsOCBAQCBzdGF0aWMgaW50IG9jb3Jlc19pbml0KHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IG9jb3Jlc19pMmMgKmkyYykNCj4gIAl1OCBjdHJsID0gb2NfZ2V0cmVnKGkyYywg
T0NJMkNfQ09OVFJPTCk7DQo+ICANCj4gIAkvKiBtYWtlIHN1cmUgdGhlIGRldmljZSBpcyBkaXNh
YmxlZCAqLw0KPiAtCW9jX3NldHJlZyhpMmMsIE9DSTJDX0NPTlRST0wsIGN0cmwgJiB+KE9DSTJD
X0NUUkxfRU58T0NJMkNfQ1RSTF9JRU4pKTsNCj4gKwljdHJsICY9IH4oT0NJMkNfQ1RSTF9FTiB8
IE9DSTJDX0NUUkxfSUVOKTsNCj4gKwlvY19zZXRyZWcoaTJjLCBPQ0kyQ19DT05UUk9MLCBjdHJs
KTsNCj4gIA0KPiAgCXByZXNjYWxlID0gKGkyYy0+aXBfY2xvY2tfa2h6IC8gKDUgKiBpMmMtPmJ1
c19jbG9ja19raHopKSAtIDE7DQo+ICAJcHJlc2NhbGUgPSBjbGFtcChwcmVzY2FsZSwgMCwgMHhm
ZmZmKTsNCj4gQEAgLTQ2MiwxMSArNDY0LDEzIEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG9j
b3Jlc19pMmNfbWF0Y2gpOw0KPiAgI2lmZGVmIENPTkZJR19PRg0KPiAgLyogUmVhZCBhbmQgd3Jp
dGUgZnVuY3Rpb25zIGZvciB0aGUgR1JMSUIgcG9ydCBvZiB0aGUgY29udHJvbGxlci4gUmVnaXN0
ZXJzIGFyZQ0KPiAgICogMzItYml0IGJpZyBlbmRpYW4gYW5kIHRoZSBQUkVMT1cgYW5kIFBSRUhJ
R0ggcmVnaXN0ZXJzIGFyZSBtZXJnZWQgaW50byBvbmUNCj4gLSAqIHJlZ2lzdGVyLiBUaGUgc3Vi
c2VxdWVudCByZWdpc3RlcnMgaGFzIHRoZWlyIG9mZnNldCBkZWNyZWFzZWQgYWNjb3JkaW5nbHku
ICovDQo+ICsgKiByZWdpc3Rlci4gVGhlIHN1YnNlcXVlbnQgcmVnaXN0ZXJzIGhhcyB0aGVpciBv
ZmZzZXQgZGVjcmVhc2VkIGFjY29yZGluZ2x5Lg0KPiArICovDQoNClRoZSBwcmVmZXJyZWQgbXVs
dGktbGluZSBjb21tZW50IHN0eWxlcyBpczoNCg0KLyoNCiAqIFJlYWQuLi4NCiAqIC4uLmFjY29y
ZGluZ2x5Lg0KICovDQoNClNvLCBwbGVhc2UgZml4IGFsbCBpc3N1ZXMgd2hlbiB5b3UgYXJlIGNo
YW5naW5nIGl0IHRvIGNvbmZvcm0uDQoNCkNoZWVycywNClBldGVyDQoNCj4gIHN0YXRpYyB1OCBv
Y19nZXRyZWdfZ3JsaWIoc3RydWN0IG9jb3Jlc19pMmMgKmkyYywgaW50IHJlZykNCj4gIHsNCj4g
IAl1MzIgcmQ7DQo+ICAJaW50IHJyZWcgPSByZWc7DQo+ICsNCj4gIAlpZiAocmVnICE9IE9DSTJD
X1BSRUxPVykNCj4gIAkJcnJlZy0tOw0KPiAgCXJkID0gaW9yZWFkMzJiZShpMmMtPmJhc2UgKyAo
cnJlZyA8PCBpMmMtPnJlZ19zaGlmdCkpOw0KPiBAQCAtNDgwLDYgKzQ4NCw3IEBAIHN0YXRpYyB2
b2lkIG9jX3NldHJlZ19ncmxpYihzdHJ1Y3Qgb2NvcmVzX2kyYyAqaTJjLCBpbnQgcmVnLCB1OCB2
YWx1ZSkNCj4gIHsNCj4gIAl1MzIgY3Vyciwgd3I7DQo+ICAJaW50IHJyZWcgPSByZWc7DQo+ICsN
Cj4gIAlpZiAocmVnICE9IE9DSTJDX1BSRUxPVykNCj4gIAkJcnJlZy0tOw0KPiAgCWlmIChyZWcg
PT0gT0NJMkNfUFJFTE9XIHx8IHJlZyA9PSBPQ0kyQ19QUkVISUdIKSB7DQo+IEBAIC01NjgsNyAr
NTczLDcgQEAgc3RhdGljIGludCBvY29yZXNfaTJjX29mX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYsDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICAjZWxzZQ0KPiAtI2RlZmluZSBv
Y29yZXNfaTJjX29mX3Byb2JlKHBkZXYsaTJjKSAtRU5PREVWDQo+ICsjZGVmaW5lIG9jb3Jlc19p
MmNfb2ZfcHJvYmUocGRldiwgaTJjKSAtRU5PREVWDQo+ICAjZW5kaWYNCj4gIA0KPiAgc3RhdGlj
IGludCBvY29yZXNfaTJjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IA0K
DQo=
