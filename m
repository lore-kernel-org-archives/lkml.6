Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0215C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329AB2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="HyHHAZUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfBFNqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:46:08 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:26689 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfBFNqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:46:08 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="24289027"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Feb 2019 06:46:05 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 6 Feb 2019 06:46:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxttacHnw5X/Qf2S6wJ69U3uxwPkIq8GDEQYTDMB/H0=;
 b=HyHHAZUlTOUhcMY4SWWejFACwpZTI7mPLir53IfI7zUEHqTRxHcsGGwf8d83ffh1G9Jx5On4LJWkGMtT1adxzgYAri4jrsJ3pEB7oyEI5PBQBzP/tvDkGsATsJrMbSZNxt0hcgxSWC0uBmh9JA1LJ+fcl+0SrGg7MQ2ImXkDQeY=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1982.namprd11.prod.outlook.com (10.175.54.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Wed, 6 Feb 2019 13:46:01 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Wed, 6 Feb 2019
 13:46:01 +0000
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
Thread-Index: AQHUuYCLA9fU9IUpL0SQqk5ieOzKJqXSdJAAgAAaDACAAAqQAIAAOF6A
Date:   Wed, 6 Feb 2019 13:46:01 +0000
Message-ID: <8880dfa2-4bbd-d3c8-b692-180555636926@microchip.com>
References: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
 <1548951466-26297-2-git-send-email-claudiu.beznea@microchip.com>
 <20190206081304.cv344rjzvz7wzih5@M43218.corp.atmel.com>
 <f0022bfc-6deb-de77-857c-c70d41f4fc78@microchip.com>
 <20190206102406.r45rb5bfjk2j45dr@M43218.corp.atmel.com>
In-Reply-To: <20190206102406.r45rb5bfjk2j45dr@M43218.corp.atmel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0224.eurprd07.prod.outlook.com
 (2603:10a6:802:58::27) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190206154551761
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1982;6:Hq6JoyCEzUcPu13eAnIKYhwRYFrnZXUyHMXALKw31NcqZSHsxSHjDm1MI8KWOdE8f1wju1ERdHY9bQ7Aj10eMNhP0alqk+XlT4QRRlF9+wW6RVNp+oqObGLpCPGZuh90q9PxuUoI48Pwi7+X0/DzYFkYa8mxGBJhpvLUjj/IX1csJSzICdR4W/kGwBbWySqWzCCyL7CV1QvXPsp0QXlSd/6v1CrUx6DT4dXIwkGeWkGWqfVa0tll8vYNKrZoea0wOviaI+LoFGzX/ZlVBY2jvjJggbuX6pBjl5jsLhF+NYKq0RhzgUNR2fQxKUfXtRmxTB42TKasros/rnz7s6xczRResiWMOM0y6rhbYZulKgVI1/Rx5RO9jdCz7lKYQNKXptcNL/tRGbHyT2Jg98/6+s95AgBzwxY7SsUATUoTE50NEble8+EFRHF8HRBQxbege15NH1LQYh5v2I8geRm/Rw==;5:GHgB/8GkBTW2067i/pWEkeoHUb8aVupeBigDAHknlTMVV5g75YrK8M6gn54YbFpxPnCBqJucKlMp8deYC9LN/Y52w1PtzamCNmaHTUF7TirEH941zVyF3wCwLkbupsDvCcj7/Tv3TdanQLrYPD6IyQXWyc3VPH0GKyS5jQhQ/v/oxih7c3PdKVn8hAAtjLQ0+yG041ZyNw/DQZt9ls5fzw==;7:kKlfewkKq5hdhVJmLe6slDFKI3bHu+Ju1xqK3GO0lW/KRJoiQa8Km7Kz4bYBs7A5xltbNCgg6QrOb61D8ZGUoHqtkzfXayIgXyjVrAR+y+Y4PKj/SWKRaOvL+rSoJnr+JTakCI8DlpfUl5VCQfmX7A==
x-ms-office365-filtering-correlation-id: ade7bc4c-e357-4d4c-4f32-08d68c396e36
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1982;
x-ms-traffictypediagnostic: MWHPR11MB1982:
x-microsoft-antispam-prvs: <MWHPR11MB1982735AED30D6AAB0A27D54876F0@MWHPR11MB1982.namprd11.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(72206003)(36756003)(486006)(6436002)(6306002)(6512007)(256004)(76176011)(53936002)(31696002)(52116002)(86362001)(2201001)(11346002)(305945005)(105586002)(6246003)(26005)(6506007)(6116002)(229853002)(106356001)(446003)(476003)(6486002)(53546011)(186003)(386003)(31686004)(2616005)(102836004)(66066001)(7736002)(316002)(2501003)(110136005)(2906002)(8676002)(71200400001)(71190400001)(478600001)(68736007)(8936002)(3846002)(81166006)(81156014)(966005)(93886005)(99286004)(97736004)(14454004)(25786009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1982;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0igF9Gho+VVLJZ6VTbv9XWyYMd9a+eEM0s0RVL5D+IMa5kHC6kwYGbIj13Jwi/OsFQKZFrEc3WEI8+f3bzJfp8yk6WiZ/g4TSd2CFmqSKt/xc8L33/sQmf+VUDwTF0aYGsYJA+cXzjRnzj+bG+6ap/iiWrD5PYyjEeAtE9SjmuHqREK4lnQl7pMiU9gPYOXhhohnkrmj7Ek4oUhnowZKCc9tshpxbB3cD3ajT3Fjj0a8t8kvgsYCweqXGkpsZCSaFWskxmKpo/4QLf1rty7+raC+g0m85MXyiu51Dyx0MyacRs9y2pbt0KvS/SSLBYud0OVHz7HaRUVDYbbU9NdvlowHOPwKDF1S8K9oNUFlRgMiqrxsZ9Asv+39fbCdlEgQHUwpzdoWWwZj3WUq3k//UwFbW1hzGxAzEmfvXkREwIc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85B05BE69312EF4B81D66117CB99F4F1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ade7bc4c-e357-4d4c-4f32-08d68c396e36
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 13:45:57.4782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1982
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA2LjAyLjIwMTkgMTI6MjQsIEx1ZG92aWMgRGVzcm9jaGVzIHdyb3RlOg0KPiBPbiBX
ZWQsIEZlYiAwNiwgMjAxOSBhdCAwOTo0NjoyOEFNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNy
b2NoaXAuY29tIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAwNi4wMi4yMDE5IDEwOjEzLCBMdWRvdmlj
IERlc3JvY2hlcyB3cm90ZToNCj4+PiBPbiBUaHUsIEphbiAzMSwgMjAxOSBhdCAwNToxODowNFBN
ICswMTAwLCBDbGF1ZGl1IEJlem5lYSAtIE0xODA2MyB3cm90ZToNCj4+Pj4gRnJvbTogQ2xhdWRp
dSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+Pj4+DQo+Pj4+IFNBTTlY
NjAgdXNlcyBoaWdoIGFuZCBsb3cgZHJpdmUgc3RyZW5ndGhzLiBUbyBpbXBsZW1lbnQgdGhpcywg
aW4NCj4+Pj4gYXQ5MV9waW5jdHJsX211eF9vcHM6OnNldF9kcml2ZXN0cmVuZ3RoIGFuZA0KPj4+
PiBhdDkxX3BpbmN0cmxfbXV4X29wczo6Z2V0X2RyaXZlc3RyZW5ndGggd2UgbmVlZCBiaXQgbnVt
YmVycyBvZg0KPj4+PiBkcml2ZSBzdHJlbmd0aHMgKDEgZm9yIGxvdywgMiBmb3IgaGlnaCksIHRo
dXMgY2hhbmdlIHRoZSBjb2RlIHRvDQo+Pj4+IGFsbG93IHRoZSB1c2FnZSBvZiBkcml2ZSBzdHJl
bmd0aCBiaXQgbnVtYmVycy4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpu
ZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgZHJpdmVy
cy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jIHwgMzIgKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0NCj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlv
bnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0
OTEuYyBiL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0OTEuYw0KPj4+PiBpbmRleCAzZDQ5YmJi
Y2RiYzcuLjMxZjA2ZGFmY2EyZSAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9waW5jdHJsL3Bp
bmN0cmwtYXQ5MS5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0OTEuYw0K
Pj4+PiBAQCAtNzIsMTAgKzcyLDE1IEBAIHN0YXRpYyBpbnQgZ3Bpb19iYW5rczsNCj4+Pj4gICAq
IERSSVZFX1NUUkVOR1RIX0RFRkFVTFQgaXMganVzdCBhIHBsYWNlaG9sZGVyIHRvIGF2b2lkIGNo
YW5naW5nIHRoZSBkcml2ZQ0KPj4+PiAgICogc3RyZW5ndGggd2hlbiB0aGVyZSBpcyBubyBkdCBj
b25maWcgZm9yIGl0Lg0KPj4+PiAgICovDQo+Pj4+IC0jZGVmaW5lIERSSVZFX1NUUkVOR1RIX0RF
RkFVTFQJCSgwIDw8IERSSVZFX1NUUkVOR1RIX1NISUZUKQ0KPj4+PiAtI2RlZmluZSBEUklWRV9T
VFJFTkdUSF9MT1cgICAgICAgICAgKDEgPDwgRFJJVkVfU1RSRU5HVEhfU0hJRlQpDQo+Pj4+IC0j
ZGVmaW5lIERSSVZFX1NUUkVOR1RIX01FRCAgICAgICAgICAoMiA8PCBEUklWRV9TVFJFTkdUSF9T
SElGVCkNCj4+Pj4gLSNkZWZpbmUgRFJJVkVfU1RSRU5HVEhfSEkgICAgICAgICAgICgzIDw8IERS
SVZFX1NUUkVOR1RIX1NISUZUKQ0KPj4+PiArZW51bSBkcml2ZV9zdHJlbmd0aF9iaXQgew0KPj4+
PiArCURSSVZFX1NUUkVOR1RIX0JJVF9ERUYsDQo+Pj4+ICsJRFJJVkVfU1RSRU5HVEhfQklUX0xP
VywNCj4+Pj4gKwlEUklWRV9TVFJFTkdUSF9CSVRfTUVELA0KPj4+PiArCURSSVZFX1NUUkVOR1RI
X0JJVF9ISSwNCj4+Pj4gK307DQo+Pj4+ICsNCj4+Pj4gKyNkZWZpbmUgRFJJVkVfU1RSRU5HVEhf
QklUX01TSyhuYW1lKQkoRFJJVkVfU1RSRU5HVEhfQklUXyMjbmFtZSA8PCBcDQo+Pj4+ICsJCQkJ
CSBEUklWRV9TVFJFTkdUSF9TSElGVCkNCj4+Pj4gIA0KPj4+PiAgLyoqDQo+Pj4+ICAgKiBzdHJ1
Y3QgYXQ5MV9wbXhfZnVuYyAtIGRlc2NyaWJlcyBBVDkxIHBpbm11eCBmdW5jdGlvbnMNCj4+Pj4g
QEAgLTU1MSw3ICs1NTYsNyBAQCBzdGF0aWMgdW5zaWduZWQgYXQ5MV9tdXhfc2FtYTVkM19nZXRf
ZHJpdmVzdHJlbmd0aCh2b2lkIF9faW9tZW0gKnBpbywNCj4+Pj4gIAkvKiBTQU1BNSBzdHJlbmd0
aCBpcyAxOjEgd2l0aCBvdXIgZGVmaW5lcywNCj4+Pj4gIAkgKiBleGNlcHQgMCBpcyBlcXVpdmFs
ZW50IHRvIGxvdyBwZXIgZGF0YXNoZWV0ICovDQo+Pj4+ICAJaWYgKCF0bXApDQo+Pj4+IC0JCXRt
cCA9IERSSVZFX1NUUkVOR1RIX0xPVzsNCj4+Pj4gKwkJdG1wID0gRFJJVkVfU1RSRU5HVEhfQklU
X01TSyhMT1cpOw0KPj4+PiAgDQo+Pj4+ICAJcmV0dXJuIHRtcDsNCj4+Pj4gIH0NCj4+Pj4gQEAg
LTU2NCw3ICs1NjksNyBAQCBzdGF0aWMgdW5zaWduZWQgYXQ5MV9tdXhfc2FtOXg1X2dldF9kcml2
ZXN0cmVuZ3RoKHZvaWQgX19pb21lbSAqcGlvLA0KPj4+PiAgDQo+Pj4+ICAJLyogc3RyZW5ndGgg
aXMgaW52ZXJzZSBpbiBTQU05eDVzIGhhcmR3YXJlIHdpdGggdGhlIHBpbmN0cmwgZGVmaW5lcw0K
Pj4+PiAgCSAqIGhhcmR3YXJlOiAwID0gaGksIDEgPSBtZWQsIDIgPSBsb3csIDMgPSByc3ZkICov
DQo+Pj4+IC0JdG1wID0gRFJJVkVfU1RSRU5HVEhfSEkgLSB0bXA7DQo+Pj4+ICsJdG1wID0gRFJJ
VkVfU1RSRU5HVEhfQklUX01TSyhISSkgLSB0bXA7DQo+Pj4+ICANCj4+Pj4gIAlyZXR1cm4gdG1w
Ow0KPj4+PiAgfQ0KPj4+PiBAQCAtNjAwLDcgKzYwNSw3IEBAIHN0YXRpYyB2b2lkIGF0OTFfbXV4
X3NhbTl4NV9zZXRfZHJpdmVzdHJlbmd0aCh2b2lkIF9faW9tZW0gKnBpbywgdW5zaWduZWQgcGlu
LA0KPj4+PiAgDQo+Pj4+ICAJLyogc3RyZW5ndGggaXMgaW52ZXJzZSBvbiBTQU05eDVzIHdpdGgg
b3VyIGRlZmluZXMNCj4+Pj4gIAkgKiAwID0gaGksIDEgPSBtZWQsIDIgPSBsb3csIDMgPSByc3Zk
ICovDQo+Pj4+IC0Jc2V0dGluZyA9IERSSVZFX1NUUkVOR1RIX0hJIC0gc2V0dGluZzsNCj4+Pj4g
KwlzZXR0aW5nID0gRFJJVkVfU1RSRU5HVEhfQklUX01TSyhISSkgLSBzZXR0aW5nOw0KPj4+PiAg
DQo+Pj4+ICAJc2V0X2RyaXZlX3N0cmVuZ3RoKHBpbyArIGF0OTFzYW05eDVfZ2V0X2RyaXZlX3Jl
Z2lzdGVyKHBpbiksIHBpbiwNCj4+Pj4gIAkJCQlzZXR0aW5nKTsNCj4+Pj4gQEAgLTk1OSwxMSAr
OTY0LDExIEBAIHN0YXRpYyBpbnQgYXQ5MV9waW5jb25mX3NldChzdHJ1Y3QgcGluY3RybF9kZXYg
KnBjdGxkZXYsDQo+Pj4+ICAJfQkJCQkJXA0KPj4+PiAgfSB3aGlsZSAoMCkNCj4+Pj4gIA0KPj4+
PiAtI2RlZmluZSBEQkdfU0hPV19GTEFHX01BU0tFRChtYXNrLGZsYWcpIGRvIHsJXA0KPj4+PiAr
I2RlZmluZSBEQkdfU0hPV19GTEFHX01BU0tFRChtYXNrLGZsYWcsbmFtZSkgZG8gewlcDQo+Pj4N
Cj4+PiBjaGVja3BhdGNoIGVycm9yOiBzcGFjZSByZXF1aXJlZA0KPj4NCj4+IEknbSBhd2FyZSBv
ZiB0aGF0IGJ1dCBJIGFkZGVkIGl0IGluIHRoZSB3YXkgaXQgd2FzIHByZXZpb3VzbHkgKHdlcmUg
dGhlDQo+PiBjaGVja3BhdGNoIGVycm9yIHdhcyBzdGlsbCBwcmVzZW50KS4gUGxlYXNlIGxldCBt
ZSBrbm93IGlmIHlvdSB3YW50IG1lIHRvDQo+PiBzZW5kIGEgbmV3IHZlcnNpb24gZml4aW5nIHRo
aXMuDQo+IA0KPiBJIHRoaW5rIGl0J3MgdGhlIG9wcG9ydHVuaXR5IHRvIGZpeCBpdC4gSWYgeW91
IGNhbiByZXNlbmQgYSBuZXcgdmVyc2lvbg0KPiBpbmNsdWRpbmcgbXkgYWNrLg0KDQpTdXJlIQ0K
DQpUaGFua3MsDQpDbGF1ZGl1DQoNCj4gDQo+IFJlZ2FyZHMNCj4gDQo+IEx1ZG92aWMNCj4gDQo+
Pg0KPj4gVGhhbmsgeW91LA0KPj4gQ2xhdWRpdSBCZXpuZWENCj4+DQo+Pj4NCj4+Pj4gIAlpZiAo
KGNvbmZpZyAmIG1hc2spID09IGZsYWcpIHsJCVwNCj4+Pj4gIAkJaWYgKG51bV9jb25mKQkJCVwN
Cj4+Pj4gIAkJCXNlcV9wdXRzKHMsICJ8Iik7CVwNCj4+Pj4gLQkJc2VxX3B1dHMocywgI2ZsYWcp
OwkJXA0KPj4+PiArCQlzZXFfcHV0cyhzLCAjbmFtZSk7CQlcDQo+Pj4+ICAJCW51bV9jb25mKys7
CQkJXA0KPj4+PiAgCX0JCQkJCVwNCj4+Pj4gIH0gd2hpbGUgKDApDQo+Pj4+IEBAIC05ODEsOSAr
OTg2LDEyIEBAIHN0YXRpYyB2b2lkIGF0OTFfcGluY29uZl9kYmdfc2hvdyhzdHJ1Y3QgcGluY3Ry
bF9kZXYgKnBjdGxkZXYsDQo+Pj4+ICAJREJHX1NIT1dfRkxBRyhQVUxMX0RPV04pOw0KPj4+PiAg
CURCR19TSE9XX0ZMQUcoRElTX1NDSE1JVCk7DQo+Pj4+ICAJREJHX1NIT1dfRkxBRyhERUdMSVRD
SCk7DQo+Pj4+IC0JREJHX1NIT1dfRkxBR19NQVNLRUQoRFJJVkVfU1RSRU5HVEgsIERSSVZFX1NU
UkVOR1RIX0xPVyk7DQo+Pj4+IC0JREJHX1NIT1dfRkxBR19NQVNLRUQoRFJJVkVfU1RSRU5HVEgs
IERSSVZFX1NUUkVOR1RIX01FRCk7DQo+Pj4+IC0JREJHX1NIT1dfRkxBR19NQVNLRUQoRFJJVkVf
U1RSRU5HVEgsIERSSVZFX1NUUkVOR1RIX0hJKTsNCj4+Pj4gKwlEQkdfU0hPV19GTEFHX01BU0tF
RChEUklWRV9TVFJFTkdUSCwgRFJJVkVfU1RSRU5HVEhfQklUX01TSyhMT1cpLA0KPj4+PiArCQkJ
ICAgICBEUklWRV9TVFJFTkdUSF9MT1cpOw0KPj4+PiArCURCR19TSE9XX0ZMQUdfTUFTS0VEKERS
SVZFX1NUUkVOR1RILCBEUklWRV9TVFJFTkdUSF9CSVRfTVNLKE1FRCksDQo+Pj4+ICsJCQkgICAg
IERSSVZFX1NUUkVOR1RIX01FRCk7DQo+Pj4+ICsJREJHX1NIT1dfRkxBR19NQVNLRUQoRFJJVkVf
U1RSRU5HVEgsIERSSVZFX1NUUkVOR1RIX0JJVF9NU0soSEkpLA0KPj4+PiArCQkJICAgICBEUklW
RV9TVFJFTkdUSF9ISSk7DQo+Pj4+ICAJREJHX1NIT1dfRkxBRyhERUJPVU5DRSk7DQo+Pj4+ICAJ
aWYgKGNvbmZpZyAmIERFQk9VTkNFKSB7DQo+Pj4+ICAJCXZhbCA9IGNvbmZpZyA+PiBERUJPVU5D
RV9WQUxfU0hJRlQ7DQo+Pj4+IC0tIA0KPj4+PiAyLjcuNA0KPj4+Pg0KPj4+DQo+PiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4gbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QNCj4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KPj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsDQo+IA0K
