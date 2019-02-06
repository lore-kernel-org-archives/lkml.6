Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA512C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66CB20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="TPn/Y8UU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfBFJqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:46:32 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:61887 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfBFJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 04:46:32 -0500
X-IronPort-AV: E=Sophos;i="5.58,339,1544511600"; 
   d="scan'208";a="25905709"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Feb 2019 02:46:31 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 6 Feb 2019 02:46:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4EO6iRQYmYFszQtcqFjJxO8U4by9QSUMfqSkX/THpo=;
 b=TPn/Y8UUSDLbX4C2x9r9KSIsymJ7pZC/ovJsfTKsUOGr2bcZgvg2zuYeLJ3AW3cp4My4P8eQK+3WuHiN5QqCJDaxMN20qv5onCYxFFJk8Ii1A+aog7+TV3SJy+AOCVCB5ZOsjK5W//ZJFQ43yghs6rEnyYsuGhdeo7iCOuObSXQ=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1310.namprd11.prod.outlook.com (10.169.237.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 09:46:28 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Wed, 6 Feb 2019
 09:46:28 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] pinctrl: at91: add option to use drive strength
 bits
Thread-Topic: [PATCH v2 1/7] pinctrl: at91: add option to use drive strength
 bits
Thread-Index: AQHUuYCLA9fU9IUpL0SQqk5ieOzKJqXSdJAAgAAaDAA=
Date:   Wed, 6 Feb 2019 09:46:28 +0000
Message-ID: <f0022bfc-6deb-de77-857c-c70d41f4fc78@microchip.com>
References: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
 <1548951466-26297-2-git-send-email-claudiu.beznea@microchip.com>
 <20190206081304.cv344rjzvz7wzih5@M43218.corp.atmel.com>
In-Reply-To: <20190206081304.cv344rjzvz7wzih5@M43218.corp.atmel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0202CA0019.eurprd02.prod.outlook.com
 (2603:10a6:803:14::32) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190206114618544
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1310;6:ewJyLSB6+U9/6DmF9FgP8Zwa3USTM7FJv4X5YqpXYrLv5KyznhR9Piclw321PypAuP8Ig/qAQ3sDYySrlpU2P2TiOvtkwmvOB4ux8R/qItNYk7JTMI9eoTsI5r5LTVI51zdweZ7TwxmzogSJoSTZk3qatTrxjtXlkItxIwSRCX+jZuO7MDHMxNPsHDX7mm/4mX1Qcj139BmZ7PFA5DWm3dodNEGzgLd8Wfty5P1kve3v+MPb30eeEGYLFvKdbMENajCj6wiVl8HFZdFI4uR5kCPOV6CPwuuxfs9apcv3eRv7wm1JLT4v9/4/FtGKeDjenTM3yYHZtfRdGZk/h0HjV08x6CyTImM2bZBQJjrnT6vFh28fXjekQfULGUqt6Mcr2S0WcFwzY3X0zNPaKPb+JqMZRG/7EnIz4Rb1Bcg3SG5HKyN1IUo7yyb1VhurSGG0ACRR/ZQWhRgKxs9VAZVIXw==;5:UNMXwIPgHYrscCZjotru5R+UzTTS3C61rarsiACdPtkD0zQfFewibePK8luWZwBYUmi77gIC5pGCgEHyJUU4+KUaA8/Eh9mHtT5kcl+iqUu9IJw1BVt0+aJBI2iMqSBFtycJ6AaEo4U0DFOwOOFZ1++cXlWIUUffKxF/jcHlRZdXlBWYdWkgsgnzBPM22mS8VMbMwf3tw7poX8lRcn/7QA==;7:cHFvdQE3BmP87BM0/ZIRlcw4bPeFtNhspP3ECtKzFo8mjqjsBcqE5qr1iIezxUfra0/N6xr2Ajd66Xt0+iB7TGuvHkUOfVF0lxLgzoz4OAnBKIwVkFH8p46r+wBq6Z0eq5wFaOvgKjXlpTw/k14hUQ==
x-ms-office365-filtering-correlation-id: fa0a0820-9705-4b64-e0fc-08d68c17f73f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1310;
x-ms-traffictypediagnostic: MWHPR11MB1310:
x-microsoft-antispam-prvs: <MWHPR11MB1310676546170F4858C6D604876F0@MWHPR11MB1310.namprd11.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(6486002)(71200400001)(229853002)(99286004)(52116002)(2201001)(71190400001)(6436002)(106356001)(305945005)(68736007)(66066001)(316002)(76176011)(31696002)(2906002)(110136005)(86362001)(2501003)(256004)(97736004)(36756003)(26005)(186003)(7736002)(14454004)(3846002)(6116002)(102836004)(53546011)(386003)(6506007)(31686004)(486006)(476003)(2616005)(11346002)(6512007)(105586002)(446003)(81156014)(81166006)(25786009)(8676002)(53936002)(6246003)(72206003)(8936002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1310;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pMQyPMNYsx0KazrG4wKVu/P7GZ9Z5qTOjw0zyugJ90SaTIg9VofRmDEc3t6GoAR2/izG5BrFNdoStUpbq8+9kyoMpKfe25gSLY/Gya25pZShqhE1po7l7r38IZ56aYJqsZrwZj9anYQL/TTXjJ9Kum86n90o/FW6awuZ4qhwmKURhr1eGCT2nX28fqja9fHwvnvxxpKqaIuJmNR206Arl5Vuu0czIRn1+e2Uvs9eRLIeFEhDXNKogmKns7BBV2+O8WqDjbtDDjT3SZKLNTHZmGj0+c9LkZ64ptRWRZUxcUWKn9Vbm1KwKalw77ZQR4LAIu5CN4FCGJmX6WN2jeymsVpUl7HsTbdiV6f6Y/x3hc+0upx2uVU+QV0MkKgp9KA89CVS0wlHUN3NWap7FRuu7mcDPZ25If7C/KsnRwd4vHU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C770342E8E3C249B19C195ADB94C3BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0a0820-9705-4b64-e0fc-08d68c17f73f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 09:46:24.5501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1310
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA2LjAyLjIwMTkgMTA6MTMsIEx1ZG92aWMgRGVzcm9jaGVzIHdyb3RlOg0KPiBPbiBU
aHUsIEphbiAzMSwgMjAxOSBhdCAwNToxODowNFBNICswMTAwLCBDbGF1ZGl1IEJlem5lYSAtIE0x
ODA2MyB3cm90ZToNCj4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNy
b2NoaXAuY29tPg0KPj4NCj4+IFNBTTlYNjAgdXNlcyBoaWdoIGFuZCBsb3cgZHJpdmUgc3RyZW5n
dGhzLiBUbyBpbXBsZW1lbnQgdGhpcywgaW4NCj4+IGF0OTFfcGluY3RybF9tdXhfb3BzOjpzZXRf
ZHJpdmVzdHJlbmd0aCBhbmQNCj4+IGF0OTFfcGluY3RybF9tdXhfb3BzOjpnZXRfZHJpdmVzdHJl
bmd0aCB3ZSBuZWVkIGJpdCBudW1iZXJzIG9mDQo+PiBkcml2ZSBzdHJlbmd0aHMgKDEgZm9yIGxv
dywgMiBmb3IgaGlnaCksIHRodXMgY2hhbmdlIHRoZSBjb2RlIHRvDQo+PiBhbGxvdyB0aGUgdXNh
Z2Ugb2YgZHJpdmUgc3RyZW5ndGggYml0IG51bWJlcnMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+
ICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMgfCAzMiArKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMiBk
ZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwt
YXQ5MS5jIGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jDQo+PiBpbmRleCAzZDQ5YmJi
Y2RiYzcuLjMxZjA2ZGFmY2EyZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvcGluY3RybC9waW5j
dHJsLWF0OTEuYw0KPj4gKysrIGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jDQo+PiBA
QCAtNzIsMTAgKzcyLDE1IEBAIHN0YXRpYyBpbnQgZ3Bpb19iYW5rczsNCj4+ICAgKiBEUklWRV9T
VFJFTkdUSF9ERUZBVUxUIGlzIGp1c3QgYSBwbGFjZWhvbGRlciB0byBhdm9pZCBjaGFuZ2luZyB0
aGUgZHJpdmUNCj4+ICAgKiBzdHJlbmd0aCB3aGVuIHRoZXJlIGlzIG5vIGR0IGNvbmZpZyBmb3Ig
aXQuDQo+PiAgICovDQo+PiAtI2RlZmluZSBEUklWRV9TVFJFTkdUSF9ERUZBVUxUCQkoMCA8PCBE
UklWRV9TVFJFTkdUSF9TSElGVCkNCj4+IC0jZGVmaW5lIERSSVZFX1NUUkVOR1RIX0xPVyAgICAg
ICAgICAoMSA8PCBEUklWRV9TVFJFTkdUSF9TSElGVCkNCj4+IC0jZGVmaW5lIERSSVZFX1NUUkVO
R1RIX01FRCAgICAgICAgICAoMiA8PCBEUklWRV9TVFJFTkdUSF9TSElGVCkNCj4+IC0jZGVmaW5l
IERSSVZFX1NUUkVOR1RIX0hJICAgICAgICAgICAoMyA8PCBEUklWRV9TVFJFTkdUSF9TSElGVCkN
Cj4+ICtlbnVtIGRyaXZlX3N0cmVuZ3RoX2JpdCB7DQo+PiArCURSSVZFX1NUUkVOR1RIX0JJVF9E
RUYsDQo+PiArCURSSVZFX1NUUkVOR1RIX0JJVF9MT1csDQo+PiArCURSSVZFX1NUUkVOR1RIX0JJ
VF9NRUQsDQo+PiArCURSSVZFX1NUUkVOR1RIX0JJVF9ISSwNCj4+ICt9Ow0KPj4gKw0KPj4gKyNk
ZWZpbmUgRFJJVkVfU1RSRU5HVEhfQklUX01TSyhuYW1lKQkoRFJJVkVfU1RSRU5HVEhfQklUXyMj
bmFtZSA8PCBcDQo+PiArCQkJCQkgRFJJVkVfU1RSRU5HVEhfU0hJRlQpDQo+PiAgDQo+PiAgLyoq
DQo+PiAgICogc3RydWN0IGF0OTFfcG14X2Z1bmMgLSBkZXNjcmliZXMgQVQ5MSBwaW5tdXggZnVu
Y3Rpb25zDQo+PiBAQCAtNTUxLDcgKzU1Niw3IEBAIHN0YXRpYyB1bnNpZ25lZCBhdDkxX211eF9z
YW1hNWQzX2dldF9kcml2ZXN0cmVuZ3RoKHZvaWQgX19pb21lbSAqcGlvLA0KPj4gIAkvKiBTQU1B
NSBzdHJlbmd0aCBpcyAxOjEgd2l0aCBvdXIgZGVmaW5lcywNCj4+ICAJICogZXhjZXB0IDAgaXMg
ZXF1aXZhbGVudCB0byBsb3cgcGVyIGRhdGFzaGVldCAqLw0KPj4gIAlpZiAoIXRtcCkNCj4+IC0J
CXRtcCA9IERSSVZFX1NUUkVOR1RIX0xPVzsNCj4+ICsJCXRtcCA9IERSSVZFX1NUUkVOR1RIX0JJ
VF9NU0soTE9XKTsNCj4+ICANCj4+ICAJcmV0dXJuIHRtcDsNCj4+ICB9DQo+PiBAQCAtNTY0LDcg
KzU2OSw3IEBAIHN0YXRpYyB1bnNpZ25lZCBhdDkxX211eF9zYW05eDVfZ2V0X2RyaXZlc3RyZW5n
dGgodm9pZCBfX2lvbWVtICpwaW8sDQo+PiAgDQo+PiAgCS8qIHN0cmVuZ3RoIGlzIGludmVyc2Ug
aW4gU0FNOXg1cyBoYXJkd2FyZSB3aXRoIHRoZSBwaW5jdHJsIGRlZmluZXMNCj4+ICAJICogaGFy
ZHdhcmU6IDAgPSBoaSwgMSA9IG1lZCwgMiA9IGxvdywgMyA9IHJzdmQgKi8NCj4+IC0JdG1wID0g
RFJJVkVfU1RSRU5HVEhfSEkgLSB0bXA7DQo+PiArCXRtcCA9IERSSVZFX1NUUkVOR1RIX0JJVF9N
U0soSEkpIC0gdG1wOw0KPj4gIA0KPj4gIAlyZXR1cm4gdG1wOw0KPj4gIH0NCj4+IEBAIC02MDAs
NyArNjA1LDcgQEAgc3RhdGljIHZvaWQgYXQ5MV9tdXhfc2FtOXg1X3NldF9kcml2ZXN0cmVuZ3Ro
KHZvaWQgX19pb21lbSAqcGlvLCB1bnNpZ25lZCBwaW4sDQo+PiAgDQo+PiAgCS8qIHN0cmVuZ3Ro
IGlzIGludmVyc2Ugb24gU0FNOXg1cyB3aXRoIG91ciBkZWZpbmVzDQo+PiAgCSAqIDAgPSBoaSwg
MSA9IG1lZCwgMiA9IGxvdywgMyA9IHJzdmQgKi8NCj4+IC0Jc2V0dGluZyA9IERSSVZFX1NUUkVO
R1RIX0hJIC0gc2V0dGluZzsNCj4+ICsJc2V0dGluZyA9IERSSVZFX1NUUkVOR1RIX0JJVF9NU0so
SEkpIC0gc2V0dGluZzsNCj4+ICANCj4+ICAJc2V0X2RyaXZlX3N0cmVuZ3RoKHBpbyArIGF0OTFz
YW05eDVfZ2V0X2RyaXZlX3JlZ2lzdGVyKHBpbiksIHBpbiwNCj4+ICAJCQkJc2V0dGluZyk7DQo+
PiBAQCAtOTU5LDExICs5NjQsMTEgQEAgc3RhdGljIGludCBhdDkxX3BpbmNvbmZfc2V0KHN0cnVj
dCBwaW5jdHJsX2RldiAqcGN0bGRldiwNCj4+ICAJfQkJCQkJXA0KPj4gIH0gd2hpbGUgKDApDQo+
PiAgDQo+PiAtI2RlZmluZSBEQkdfU0hPV19GTEFHX01BU0tFRChtYXNrLGZsYWcpIGRvIHsJXA0K
Pj4gKyNkZWZpbmUgREJHX1NIT1dfRkxBR19NQVNLRUQobWFzayxmbGFnLG5hbWUpIGRvIHsJXA0K
PiANCj4gY2hlY2twYXRjaCBlcnJvcjogc3BhY2UgcmVxdWlyZWQNCg0KSSdtIGF3YXJlIG9mIHRo
YXQgYnV0IEkgYWRkZWQgaXQgaW4gdGhlIHdheSBpdCB3YXMgcHJldmlvdXNseSAod2VyZSB0aGUN
CmNoZWNrcGF0Y2ggZXJyb3Igd2FzIHN0aWxsIHByZXNlbnQpLiBQbGVhc2UgbGV0IG1lIGtub3cg
aWYgeW91IHdhbnQgbWUgdG8NCnNlbmQgYSBuZXcgdmVyc2lvbiBmaXhpbmcgdGhpcy4NCg0KVGhh
bmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiANCj4+ICAJaWYgKChjb25maWcgJiBtYXNrKSA9
PSBmbGFnKSB7CQlcDQo+PiAgCQlpZiAobnVtX2NvbmYpCQkJXA0KPj4gIAkJCXNlcV9wdXRzKHMs
ICJ8Iik7CVwNCj4+IC0JCXNlcV9wdXRzKHMsICNmbGFnKTsJCVwNCj4+ICsJCXNlcV9wdXRzKHMs
ICNuYW1lKTsJCVwNCj4+ICAJCW51bV9jb25mKys7CQkJXA0KPj4gIAl9CQkJCQlcDQo+PiAgfSB3
aGlsZSAoMCkNCj4+IEBAIC05ODEsOSArOTg2LDEyIEBAIHN0YXRpYyB2b2lkIGF0OTFfcGluY29u
Zl9kYmdfc2hvdyhzdHJ1Y3QgcGluY3RybF9kZXYgKnBjdGxkZXYsDQo+PiAgCURCR19TSE9XX0ZM
QUcoUFVMTF9ET1dOKTsNCj4+ICAJREJHX1NIT1dfRkxBRyhESVNfU0NITUlUKTsNCj4+ICAJREJH
X1NIT1dfRkxBRyhERUdMSVRDSCk7DQo+PiAtCURCR19TSE9XX0ZMQUdfTUFTS0VEKERSSVZFX1NU
UkVOR1RILCBEUklWRV9TVFJFTkdUSF9MT1cpOw0KPj4gLQlEQkdfU0hPV19GTEFHX01BU0tFRChE
UklWRV9TVFJFTkdUSCwgRFJJVkVfU1RSRU5HVEhfTUVEKTsNCj4+IC0JREJHX1NIT1dfRkxBR19N
QVNLRUQoRFJJVkVfU1RSRU5HVEgsIERSSVZFX1NUUkVOR1RIX0hJKTsNCj4+ICsJREJHX1NIT1df
RkxBR19NQVNLRUQoRFJJVkVfU1RSRU5HVEgsIERSSVZFX1NUUkVOR1RIX0JJVF9NU0soTE9XKSwN
Cj4+ICsJCQkgICAgIERSSVZFX1NUUkVOR1RIX0xPVyk7DQo+PiArCURCR19TSE9XX0ZMQUdfTUFT
S0VEKERSSVZFX1NUUkVOR1RILCBEUklWRV9TVFJFTkdUSF9CSVRfTVNLKE1FRCksDQo+PiArCQkJ
ICAgICBEUklWRV9TVFJFTkdUSF9NRUQpOw0KPj4gKwlEQkdfU0hPV19GTEFHX01BU0tFRChEUklW
RV9TVFJFTkdUSCwgRFJJVkVfU1RSRU5HVEhfQklUX01TSyhISSksDQo+PiArCQkJICAgICBEUklW
RV9TVFJFTkdUSF9ISSk7DQo+PiAgCURCR19TSE9XX0ZMQUcoREVCT1VOQ0UpOw0KPj4gIAlpZiAo
Y29uZmlnICYgREVCT1VOQ0UpIHsNCj4+ICAJCXZhbCA9IGNvbmZpZyA+PiBERUJPVU5DRV9WQUxf
U0hJRlQ7DQo+PiAtLSANCj4+IDIuNy40DQo+Pg0KPiANCg==
