Return-Path: <toshi.kani@hpe.com>
X-Google-Smtp-Source: AG47ELuCTpH/b8Y/ddcMSX5FLR4U9E3Ij/7H+UQujV+0xE7luxKL3zpNZ+Ac6yvrIPfz0BhKv6XP
ARC-Seal: i=1; a=rsa-sha256; t=1521486133; cv=none;
        d=google.com; s=arc-20160816;
        b=cHIS3GouGeYv+X0jv2LiRW9ZDj6Tfmu2baok3Q6bgM+/Xq2GnjTJUBMzare2X0DRvB
         XSFtJl3lgNcCmzeRBfM+/+IePJippxRVEzcPqIu5wlKTWVfmIZdh5Nv7Fs01HzUKiG6h
         mCw0x2TfbnkUB3hh7BJnX3efEkVLLQZcxhbY29FRNdqO0w4NxoNLbEv3cOjZ8GYRFmNL
         EDXHf9pqZUJ0E1Vw+l8G5iqoadF5dEDl/cPVGHs8oUqLBKQmUADmn2JcRXnerp/hqHPG
         YS4MxKBNiszKY4VwBkhGzj2RjZ+pEDWMaBOGpgfFI014lZBagEIRLEQ6bzHiFSjAjINp
         Enkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=EWaDw63gtwzxKPBvwJ4qvSgOdOdR4TrYbDd3moNAWkw=;
        b=cOVcvb5qyJUPL3SZ/zANVaNemDQkCF7eyFu3iDTR7YTrQUXVxmD+YFJkL4nV8lqoEO
         ijM/B40yhU1o+SkVF594+VQ9Sx1N3+WR139KG6J52wg/qzMbL7hVHHrLQCo2ejijUFJE
         I0tfO8JPRYYQsw3wr0JdLQR5KqGzEJxLVpUd0+TsBVTVj9aRWDzOmyAumOGEIwOtlK/h
         KfNUBFjA8sHEiwEdiVjJct1D4Q+cfWKbRsEy9r+aiMkO9oQcoMK/z675/RsGD8p8kra7
         JXAk5CvwJn2PSAunVbv05M9/Xc9Fez6jgW1kyOIjcyqHFH29flSnFa+3PG23Fs0pyvn0
         3a7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of toshi.kani@hpe.com designates 15.233.44.27 as permitted sender) smtp.mailfrom=toshi.kani@hpe.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of toshi.kani@hpe.com designates 15.233.44.27 as permitted sender) smtp.mailfrom=toshi.kani@hpe.com
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "cpandya@codeaurora.org" <cpandya@codeaurora.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will.deacon@arm.com" <will.deacon@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "takahiro.akashi@linaro.org"
	<takahiro.akashi@linaro.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com"
	<marc.zyngier@arm.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] ioremap: Update pgtable free interfaces with addr
Thread-Topic: [PATCH v3 1/3] ioremap: Update pgtable free interfaces with addr
Thread-Index: AQHTv3+bqW60RJpW6UmX3r/sSteNW6PX6mgA
Date: Mon, 19 Mar 2018 19:01:45 +0000
Message-ID: <1521486096.2693.202.camel@hpe.com>
References: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
	 <1521463256-19858-2-git-send-email-cpandya@codeaurora.org>
In-Reply-To: <1521463256-19858-2-git-send-email-cpandya@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB0363;7:YYquVKquvhFAxRQlFwoD/GNy4wJCU6RqwFC+bnxpcYW4uFCEUzvNLpPaBUqrV/QXW7G/hYp/N0ylboaWaiBuuIdJEdP1YrQlUwRHc7xtRJkb/gt/X2qtybcg30VqKy9mt9NcjkAa0ZhdgH4P0mwGj4z1rSQxN7Uz2F2lzrDzbAq/Hl7/kSbrBO91ruRse9QTgFmxM34dS3Unc6KdKq+5P0XgI4PlAmomWFMUlaytWcMSa8o3m8VqNeQMqMV6y98w
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 368ef11a-9485-43fc-4c2e-08d58dcbdc27
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB0363;
x-ms-traffictypediagnostic: DF4PR8401MB0363:
x-microsoft-antispam-prvs: <DF4PR8401MB036311779E34F2E7A7C38BCF82D40@DF4PR8401MB0363.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DF4PR8401MB0363;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB0363;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39380400002)(396003)(346002)(39860400002)(377424004)(189003)(199004)(966005)(68736007)(110136005)(478600001)(229853002)(99286004)(36756003)(6246003)(7736002)(305945005)(103116003)(76176011)(2950100002)(26005)(97736004)(6436002)(54906003)(6486002)(25786009)(4326008)(15650500001)(3660700001)(186003)(53936002)(2501003)(81156014)(81166006)(8676002)(5250100002)(2906002)(2900100001)(86362001)(5660300001)(2201001)(3846002)(6306002)(7416002)(6116002)(8936002)(3280700002)(66066001)(59450400001)(316002)(6506007)(6512007)(106356001)(105586002)(14454004)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0363;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: bXaM+N6yf6il1bu07RgqynhaaBWeLaiLpp7gXc4Y4wRJxWVBSXDhKK4NuxM4Q/jsdO/61SZscwdHviyO+jrKxvn2WskGzyE91Rgh0KQmopQSeI0OAFX/aqc3rwYdJQ8BpIlAOFofTYAklp+BR2pJvH80XvmI6h2xGcIy/Os1FYujVF+x2IcL+GqEEbGwTM6/UOkkFnRf0SHssgoWLkiBReQqOMIsSVoFOi/Uw4yurLgfN0CNDvcoeSNGcJeSVBoDWkV9zFKZAZYW359gi1pW5mKpeAGKgziHol+2mrLzYuSyT3LKXxZhW6uXtWqsV3vdGpy2go9Uszo/hUWUafUHaQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E918B9CB35AE6047A33C70C73CA038E8@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 368ef11a-9485-43fc-4c2e-08d58dcbdc27
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 19:01:45.2983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0363
X-OriginatorOrg: hpe.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595369882117983930?=
X-GMAIL-MSGID: =?utf-8?q?1595393843812849962?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gTW9uLCAyMDE4LTAzLTE5IGF0IDE4OjEwICswNTMwLCBDaGludGFuIFBhbmR5YSB3cm90ZToN
Cj4gVGhpcyBwYXRjaCAoIm1tL3ZtYWxsb2M6IEFkZCBpbnRlcmZhY2VzIHRvIGZyZWUgdW5tYXBw
ZWQNCj4gcGFnZSB0YWJsZSIpIGFkZHMgZm9sbG93aW5nIDIgaW50ZXJmYWNlcyB0byBmcmVlIHRo
ZSBwYWdlDQo+IHRhYmxlIGluIGNhc2Ugd2UgaW1wbGVtZW50IGh1Z2UgbWFwcGluZy4NCj4gDQo+
IHB1ZF9mcmVlX3BtZF9wYWdlKCkgYW5kIHBtZF9mcmVlX3B0ZV9wYWdlKCkNCj4gDQo+IFNvbWUg
YXJjaGl0ZWN0dXJlcyAobGlrZSBhcm02NCkgbmVlZHMgdG8gZG8gcHJvcGVyIFRMQg0KPiBtYWlu
dGFuYW5jZSBhZnRlciB1cGRhdGluZyBwYWdldGFibGUgZW50cnkgZXZlbiBpbiBtYXAuDQo+IFdo
eSA/IFJlYWQgdGhpcywNCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDEz
NDU4MS8NCj4gDQo+IFBhc3MgJ2FkZHInIGluIHRoZXNlIGludGVyZmFjZXMgc28gdGhhdCBwcm9w
ZXIgVExCIG9wcw0KPiBjYW4gYmUgcGVyZm9ybWVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hp
bnRhbiBQYW5keWEgPGNwYW5keWFAY29kZWF1cm9yYS5vcmc+DQogOg0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYvbW0vcGd0YWJsZS5jIGIvYXJjaC94ODYvbW0vcGd0YWJsZS5jDQo+IGluZGV4IDM0
Y2RhN2UuLjIwYjAzMjIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L21tL3BndGFibGUuYw0KPiAr
KysgYi9hcmNoL3g4Ni9tbS9wZ3RhYmxlLmMNCj4gQEAgLTcxMCw3ICs3MTAsNyBAQCBpbnQgcG1k
X2NsZWFyX2h1Z2UocG1kX3QgKnBtZCkNCj4gICAqIENvbnRleHQ6IFRoZSBwdWQgcmFuZ2UgaGFz
IGJlZW4gdW5tYXBlZCBhbmQgVExCIHB1cmdlZC4NCj4gICAqIFJldHVybjogMSBpZiBjbGVhcmlu
ZyB0aGUgZW50cnkgc3VjY2VlZGVkLiAwIG90aGVyd2lzZS4NCj4gICAqLw0KPiAtaW50IHB1ZF9m
cmVlX3BtZF9wYWdlKHB1ZF90ICpwdWQpDQo+ICtpbnQgcHVkX2ZyZWVfcG1kX3BhZ2UocHVkX3Qg
KnB1ZCwgdW5zaWduZWQgbG9uZyBhZGRyKQ0KDQpQbGVhc2UgdXBkYXRlIHRoZSBmdW5jdGlvbiBo
ZWFkZXIgYXMgd2VsbC4gIFNhbWUgZm9yIHBtZC4NCg0KKyAqIEBhZGRyOiBWaXJ0dWFsIGFkZHJl
c3MgYXNzb2NpYXRlZCB3aXRoIHB1ZC4NCg0KLS0tIGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9wZ3Rh
YmxlLmgNCj4gKysrIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9wZ3RhYmxlLmgNCj4gQEAgLTk4Myw4
ICs5ODMsOCBAQCBzdGF0aWMgaW5saW5lIGludCBwNGRfY2xlYXJfaHVnZShwNGRfdCAqcDRkKQ0K
PiAgaW50IHBtZF9zZXRfaHVnZShwbWRfdCAqcG1kLCBwaHlzX2FkZHJfdCBhZGRyLCBwZ3Byb3Rf
dCBwcm90KTsNCj4gIGludCBwdWRfY2xlYXJfaHVnZShwdWRfdCAqcHVkKTsNCj4gIGludCBwbWRf
Y2xlYXJfaHVnZShwbWRfdCAqcG1kKTsNCj4gLWludCBwdWRfZnJlZV9wbWRfcGFnZShwdWRfdCAq
cHVkKTsNCj4gLWludCBwbWRfZnJlZV9wdGVfcGFnZShwbWRfdCAqcG1kKTsNCj4gK2ludCBwdWRf
ZnJlZV9wbWRfcGFnZShwdWRfdCAqcHVkLCB1bnNpZ25lZCBsb25nIGFkZHIpOw0KPiAraW50IHBt
ZF9mcmVlX3B0ZV9wYWdlKHBtZF90ICpwbWQsIHVuc2lnbmVkIGxvbmcgYWRkcik7DQo+ICAjZWxz
ZQkvKiAhQ09ORklHX0hBVkVfQVJDSF9IVUdFX1ZNQVAgKi8NCj4gIHN0YXRpYyBpbmxpbmUgaW50
IHA0ZF9zZXRfaHVnZShwNGRfdCAqcDRkLCBwaHlzX2FkZHJfdCBhZGRyLCBwZ3Byb3RfdA0KcHJv
dCkNCj4gIHsNCj4gQEAgLTEwMTAsMTEgKzEwMTAsMTEgQEAgc3RhdGljIGlubGluZSBpbnQgcG1k
X2NsZWFyX2h1Z2UocG1kX3QgKnBtZCkNCj4gIHsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gLXN0
YXRpYyBpbmxpbmUgaW50IHB1ZF9mcmVlX3BtZF9wYWdlKHB1ZF90ICpwdWQpDQo+ICtzdGF0aWMg
aW5saW5lIGludCBwdWRfZnJlZV9wbWRfcGFnZShwdWRfdCAqcHVkLCB1bnNpZ25lZCBsb25nIGFk
ZHIpDQo+ICB7DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IC1zdGF0aWMgaW5saW5lIGludCBwbWRf
ZnJlZV9wdGVfcGFnZShwdWRfdCAqcG1kKQ0KPiArc3RhdGljIGlubGluZSBpbnQgcG1kX2ZyZWVf
cHRlX3BhZ2UocHVkX3QgKnBtZCwgdW5zaWduZWQgbG9uZyBhZGRyKQ0KDQpQbGVhc2UgYmFzZSB5
b3VyIHBhdGNoZXMgb24gdG9wIG9mIHRoZSBtbSB0cmVlIG9yIGF0IGxlYXN0IHBpY2sgdXANCjhj
YWI5M2RlOTk0ZjYgaW4gdGhlIG1tIHRyZWUuICBBbmRyZXcgZml4ZWQgdGhlIHR5cG87IHRoZSAn
cHVkX3QnIGFib3ZlDQpzaG91bGQgaGF2ZSBiZWVuICdwbWRfdCcuDQoNClRoYW5rcywNCi1Ub3No
aQ0K
