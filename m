Return-Path: <toshi.kani@hpe.com>
X-Google-Smtp-Source: AG47ELuXN3UEDAQ0HVP080YwKpNez1ixB6+WCl1akTIDnimZb5Hl6dli6GB/TtQQ/6o9eqILdTle
ARC-Seal: i=1; a=rsa-sha256; t=1521211845; cv=none;
        d=google.com; s=arc-20160816;
        b=NY3+biFhAdDfnYf1sKeTBZufxYIbg4HuqNJQ1W580e03EmWl34foMT6XecPe7cnvAQ
         ZQVe/ufunckmoHnJ5E4eoDgIc+mb85HZy8RvZl0u7zuM56d0xFJchZ6pkYsxDy96oP76
         rJxahSPJUO7pCeF7wy0Ho3zhat5xnCuLOIkWRbk30R3JkxzLrdm9OK2O+3exiPIO5Fx+
         qLWz90LA2QeQbeSMj6lCcfl4ZIIut316xhTwKEMgWIUdRR8dT3eqsIkgDA/95tNmc34E
         9mXZfadlc6bqZW5v9vMI1nBtGwIvjPMJ1OlWD3/bmNaw+suaHIbVswVQJNSS8dz71ti3
         S7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=Gkc8IY3YyOze/YNEx4ZVUwYNwAdVC116dUQWCsV9XSg=;
        b=fG984Gon7rwhcefNuxTnbPDw0IHtej5iJK9cwwYxEH4a0RUqCQ8rsg/7UYqFrJUqBZ
         ZUPxDCKasI8YGe2Od0S7gFAvdWetfVqQ3dMt5N7i43meBopOKRkQqg6WvUSGcHGQ7+1X
         UMFrY8dqKoaoqRBylvAn8+VHaVHiu0uggCPnCE+TuqIhUdKFrw+iQLBocuWGEbkTtmaO
         yVy9QHqQlYKGJTFKcVdUSRX/2GQusNigjgsqTZGyYKJAKeawsRBHJwO0He716ztJKN4F
         qi2SIDxp0z/9Znh4Wt1T67rhGTKSwNU1jB6/zCwTj1sROt006DpZRDt6qP0m6R6uim//
         2dDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of toshi.kani@hpe.com designates 15.241.48.73 as permitted sender) smtp.mailfrom=toshi.kani@hpe.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of toshi.kani@hpe.com designates 15.241.48.73 as permitted sender) smtp.mailfrom=toshi.kani@hpe.com
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
	<will.deacon@arm.com>, "arnd@arndb.de" <arnd@arndb.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "takahiro.akashi@linaro.org"
	<takahiro.akashi@linaro.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com"
	<marc.zyngier@arm.com>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
Thread-Topic: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
Thread-Index: AQHTvFuW/H5D66EiPUqborstpx0HBaPReDQAgAEDIICAAHg+gA==
Date: Fri, 16 Mar 2018 14:50:42 +0000
Message-ID: <1521211837.2693.187.camel@hpe.com>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
	 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
	 <1521130368.2693.177.camel@hpe.com>
	 <0cec2b79-1668-68d1-32db-531f5a8a9db2@codeaurora.org>
In-Reply-To: <0cec2b79-1668-68d1-32db-531f5a8a9db2@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB0585;7:nS4z4oQoH0ncxll6yRuK5R16aJChSANJ4m6vdSb7WWG0MYFs5h1OI6Uu4TauD3VW3uhR4lGrhpna2vdXj5PYZncoTd/V/MpoI66PUlCFuxteWh1/dI6T780gtWd4IEyz9LURquYKihpFi3QdjRqUxcwkReU9GFe7FqXJS5EsXlxbmuNcsIbgsyZJm+uk6wnhSbvOjRDBo2AkVp4/PhFvfiJCUjojQ8FjaOMZjpjbONN3oAYkvmiKJOuexvf6SWWK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65ed1715-ce46-4dc0-cd33-08d58b4d4acc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB0585;
x-ms-traffictypediagnostic: DF4PR8401MB0585:
x-microsoft-antispam-prvs: <DF4PR8401MB0585294BAF0AF0FA3843E82182D70@DF4PR8401MB0585.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DF4PR8401MB0585;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB0585;
x-forefront-prvs: 0613912E23
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(39380400002)(346002)(199004)(377424004)(189003)(86362001)(68736007)(105586002)(6486002)(4326008)(3280700002)(76176011)(99286004)(26005)(3660700001)(2950100002)(6116002)(478600001)(97736004)(2201001)(3846002)(2906002)(14454004)(6436002)(36756003)(66066001)(2501003)(5250100002)(6246003)(25786009)(81166006)(2900100001)(7416002)(5660300001)(8676002)(6512007)(7736002)(305945005)(8936002)(106356001)(81156014)(102836004)(110136005)(103116003)(54906003)(6506007)(53546011)(93886005)(186003)(316002)(53936002)(229853002)(14583001);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0585;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: cXSbgE8DZnREOfbx8bpJT6SekDlZUPc2NEPLNG+bnsMZkRvP0ndz+qOkkrKjUjH8Xk26RFr4yjLGqyRm7UM0MLoXXrDgYRM3Tu7gzinKbqRRK61nj0E7R4Nm9sQ3ZfGtFRMMOVDd6dXVDrz+X1ulSpT4FQo7cH3gcYqykgMnb0vNyWZHR2tY8wa85ZKqHQ1oenhGEUhE8idMVsoHn/nxIsgTz4Dxg7S/ADxIQ+LYhBXNDFu9yYLxJrMWhnF4Y8lhbnp4JU/ZzCWeTz3cRFEel8RhbX3wwXXJnBe1ME3j1drqrc3cYYwWCMAksDIRM0j4eSw0gGwrreSU+/44TsmZBg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5223E06372499429F6515DDC7FDBEC5@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ed1715-ce46-4dc0-cd33-08d58b4d4acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 14:50:42.5846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0585
X-OriginatorOrg: hpe.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007763353693659?=
X-GMAIL-MSGID: =?utf-8?q?1595106232276896451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gRnJpLCAyMDE4LTAzLTE2IGF0IDEzOjEwICswNTMwLCBDaGludGFuIFBhbmR5YSB3cm90ZToN
Cj4gDQo+IE9uIDMvMTUvMjAxOCA5OjQyIFBNLCBLYW5pLCBUb3NoaSB3cm90ZToNCj4gPiBPbiBU
aHUsIDIwMTgtMDMtMTUgYXQgMTg6MTUgKzA1MzAsIENoaW50YW4gUGFuZHlhIHdyb3RlOg0KPiA+
ID4gSHVnZSBtYXBwaW5nIGNoYW5nZXMgUE1EL1BVRCB3aGljaCBjb3VsZCBoYXZlDQo+ID4gPiB2
YWxpZCBwcmV2aW91cyBlbnRyaWVzLiBUaGlzIHJlcXVpcmVzIHByb3Blcg0KPiA+ID4gVExCIG1h
aW50YW5hbmNlIG9uIHNvbWUgYXJjaGl0ZWN0dXJlcywgbGlrZQ0KPiA+ID4gQVJNNjQuDQo+ID4g
PiANCj4gPiA+IEltcGxlbnQgQkJNIChicmVhay1iZWZvcmUtbWFrZSkgc2FmZSBUTEINCj4gPiA+
IGludmFsaWRhdGlvbi4NCj4gPiA+IA0KPiA+ID4gSGVyZSwgSSd2ZSB1c2VkIGZsdXNoX3RsYl9w
Z3RhYmxlKCkgaW5zdGVhZA0KPiA+ID4gb2YgZmx1c2hfa2VybmVsX3JhbmdlKCkgYmVjYXVzZSBp
bnZhbGlkYXRpbmcNCj4gPiA+IGludGVybWVkaWF0ZSBwYWdlX3RhYmxlIGVudHJpZXMgY291bGQg
aGF2ZQ0KPiA+ID4gYmVlbiBvcHRpbWl6ZWQgZm9yIHNwZWNpZmljIGFyY2guIFRoYXQncyB0aGUN
Cj4gPiA+IGNhc2Ugd2l0aCBBUk02NCBhdCBsZWFzdC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogQ2hpbnRhbiBQYW5keWEgPGNwYW5keWFAY29kZWF1cm9yYS5vcmc+DQo+ID4gPiAtLS0N
Cj4gPiA+ICAgbGliL2lvcmVtYXAuYyB8IDI1ICsrKysrKysrKysrKysrKysrKystLS0tLS0NCj4g
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+
ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9saWIvaW9yZW1hcC5jIGIvbGliL2lvcmVtYXAuYw0K
PiA+ID4gaW5kZXggNTRlNWJiYS4uNTVmODY0OCAxMDA2NDQNCj4gPiA+IC0tLSBhL2xpYi9pb3Jl
bWFwLmMNCj4gPiA+ICsrKyBiL2xpYi9pb3JlbWFwLmMNCj4gPiA+IEBAIC0xMyw2ICsxMyw3IEBA
DQo+ID4gPiAgICNpbmNsdWRlIDxsaW51eC9leHBvcnQuaD4NCj4gPiA+ICAgI2luY2x1ZGUgPGFz
bS9jYWNoZWZsdXNoLmg+DQo+ID4gPiAgICNpbmNsdWRlIDxhc20vcGd0YWJsZS5oPg0KPiA+ID4g
KyNpbmNsdWRlIDxhc20tZ2VuZXJpYy90bGIuaD4NCj4gPiA+ICAgDQo+ID4gPiAgICNpZmRlZiBD
T05GSUdfSEFWRV9BUkNIX0hVR0VfVk1BUA0KPiA+ID4gICBzdGF0aWMgaW50IF9fcmVhZF9tb3N0
bHkgaW9yZW1hcF9wNGRfY2FwYWJsZTsNCj4gPiA+IEBAIC04MCw2ICs4MSw3IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGlvcmVtYXBfcG1kX3JhbmdlKHB1ZF90ICpwdWQsIHVuc2lnbmVkIGxvbmcgYWRk
ciwNCj4gPiA+ICAgCQl1bnNpZ25lZCBsb25nIGVuZCwgcGh5c19hZGRyX3QgcGh5c19hZGRyLCBw
Z3Byb3RfdCBwcm90KQ0KPiA+ID4gICB7DQo+ID4gPiAgIAlwbWRfdCAqcG1kOw0KPiA+ID4gKwlw
bWRfdCBvbGRfcG1kOw0KPiA+ID4gICAJdW5zaWduZWQgbG9uZyBuZXh0Ow0KPiA+ID4gICANCj4g
PiA+ICAgCXBoeXNfYWRkciAtPSBhZGRyOw0KPiA+ID4gQEAgLTkxLDEwICs5MywxNSBAQCBzdGF0
aWMgaW5saW5lIGludCBpb3JlbWFwX3BtZF9yYW5nZShwdWRfdCAqcHVkLCB1bnNpZ25lZCBsb25n
IGFkZHIsDQo+ID4gPiAgIA0KPiA+ID4gICAJCWlmIChpb3JlbWFwX3BtZF9lbmFibGVkKCkgJiYN
Cj4gPiA+ICAgCQkgICAgKChuZXh0IC0gYWRkcikgPT0gUE1EX1NJWkUpICYmDQo+ID4gPiAtCQkg
ICAgSVNfQUxJR05FRChwaHlzX2FkZHIgKyBhZGRyLCBQTURfU0laRSkgJiYNCj4gPiA+IC0JCSAg
ICBwbWRfZnJlZV9wdGVfcGFnZShwbWQpKSB7DQo+ID4gPiAtCQkJaWYgKHBtZF9zZXRfaHVnZShw
bWQsIHBoeXNfYWRkciArIGFkZHIsIHByb3QpKQ0KPiA+ID4gKwkJICAgIElTX0FMSUdORUQocGh5
c19hZGRyICsgYWRkciwgUE1EX1NJWkUpKSB7DQo+ID4gPiArCQkJb2xkX3BtZCA9ICpwbWQ7DQo+
ID4gPiArCQkJcG1kX2NsZWFyKHBtZCk7DQo+ID4gDQo+ID4gcG1kX2NsZWFyKCkgaXMgb25lIG9m
IHRoZSBvcGVyYXRpb25zIHBtZF9mcmVlX3B0ZV9wYWdlKCkgbmVlZHMgdG8gZG8uDQo+ID4gU2Vl
IHRoZSB4ODYgdmVyc2lvbi4NCj4gPiANCj4gPiA+ICsJCQlmbHVzaF90bGJfcGd0YWJsZSgmaW5p
dF9tbSwgYWRkcik7DQo+ID4gDQo+ID4gWW91IGNhbiBjYWxsIGl0IGluIHBtZF9mcmVlX3B0ZV9w
YWdlKCkgb24gYXJtNjQgYXMgd2VsbC4NCj4gPiANCj4gPiA+ICsJCQlpZiAocG1kX3NldF9odWdl
KHBtZCwgcGh5c19hZGRyICsgYWRkciwgcHJvdCkpIHsNCj4gPiA+ICsJCQkJcG1kX2ZyZWVfcHRl
X3BhZ2UoJm9sZF9wbWQpOw0KPiA+ID4gICAJCQkJY29udGludWU7DQo+ID4gPiArCQkJfSBlbHNl
DQo+ID4gPiArCQkJCXNldF9wbWQocG1kLCBvbGRfcG1kKTsNCj4gPiANCj4gPiBJIGRvIG5vdCB1
bmRlcnN0YW5kIHdoeSB5b3UgbmVlZGVkIHRvIG1ha2UgdGhpcyBjaGFuZ2UuDQo+ID4gcG1kX2Zy
ZWVfcHRlX3BhZ2UoKSBpcyBkZWZpbmVkIGFzIGFuIGFyY2gtc3BlY2lmaWMgZnVuY3Rpb24gc28g
dGhhdCB5b3UNCj4gPiBjYW4gYWRkaXRpb25hbGx5IHBlcmZvcm0gVExCIHB1cmdlcyBvbiBhcm02
NC4gIFBsZWFzZSB0cnkgdG8gbWFrZSBwcm9wZXINCj4gPiBhcm02NCBpbXBsZW1lbnRhdGlvbiBv
ZiB0aGlzIGludGVyZmFjZS4gIEFuZCBpZiB5b3UgZmluZCBhbnkgaXNzdWUgaW4NCj4gPiB0aGlz
IGludGVyZmFjZSwgcGxlYXNlIGxldCBtZSBrbm93Lg0KPiANCj4gVExCIG9wcyByZXF1aXJlIFZB
IGF0IGxlYXN0LiBBbmQgdGhpcyBpbnRlcmZhY2UgcGFzc2VzIGp1c3QgdGhlIFBNRC9QVUQuDQoN
CllvdSBjYW4gYWRkICdhZGRyJyBhcyB0aGUgMm5kIGFyZy4gIFN1Y2ggbWlub3IgdHdlYWsgaXMg
ZXhwZWN0ZWQgd2hlbg0KaW1wbGVtZW50aW5nIG9uIG11bHRpcGxlIGFyY2hlcy4NCg0KPiBTZWNv
bmQgaXMsIGlmIHdlIGNsZWFyIHRoZSBwcmV2aW91cyB0YWJsZSBlbnRyeSBpbnNpZGUgdGhlIGFy
Y2ggc3BlY2lmaWMNCj4gY29kZSBhbmQgdGhlbiB3ZSBmYWlsIGluIHBtZC9wdWRfc2V0X2h1Z2Us
IHdlIGNhbid0IGZhbGxiYWNrICh4ODYgY2FzZSkuDQo+IA0KPiBTbywgd2UgY2FuIGRvIHNvbWV0
aGluZyBsaWtlIHRoaXMgKGZvbGxvd2luZyBNYXJrJ3Mgc3VnZ2VzdGlvbiksDQo+IA0KPiAJaWYg
KGlvcmVtYXBfcG1kX2VuYWJsZWQoKSAmJg0KPiAgICAgICAgICAJKChuZXh0IC0gYWRkcikgPT0g
UE1EX1NJWkUpICYmDQo+IAkJSVNfQUxJR05FRChwaHlzX2FkZHIgKyBhZGRyLCBQTURfU0laRSkg
JiYNCj4gCQlwbWRfY2FuX3NldF9odWdlKHBtZCwgcGh5c19hZGRyICsgYWRkciwgcHJvdCkpIHsN
Cj4gCQkJLyoNCj4gCQkJICogQ2xlYXIgZXhpc3RpbmcgdGFibGUgZW50cnksDQo+IAkJCSAqIElu
dmFsaWRhdGUsDQo+IAkJCSAqIEZyZWUgdGhlIHBhZ2UgdGFibGUNCj4gCQkJICogaW5zaWRlIHRo
aXMgY29kZQ0KPiAJCQkgKi8NCj4gCQkJcG1kX2ZyZWVfcHRlX3BhZ2UocG1kLCBhZGRyLCBhZGRy
ICsgUE1EX1NJWkUpOw0KPiAJCQlwbWRfc2V0X2h1Z2UoLi4uKSAvL3dpdGhvdXQgZmFpbA0KPiAJ
CQljb250aW51ZTsNCj4gCX0NCg0KVGhhdCdzIG5vdCBuZWNlc3NhcnkuICBwbWQgYmVpbmcgbm9u
ZSBpcyBhIGxlZ2l0aW1hdGUgc3RhdGUuICBJbiBmYWN0LA0KaXQgaXMgdGhlIGNhc2Ugd2hlbiBw
bWRfYWxsb2MoKSBhbGxvY2F0ZWQgYW5kIHBvcHVsYXRlZCBhIG5ldyBwbWQuDQoNClRoYW5rcywN
Ci1Ub3NoaQ0K
