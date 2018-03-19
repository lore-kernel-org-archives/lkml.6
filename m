Return-Path: <toshi.kani@hpe.com>
X-Google-Smtp-Source: AG47ELsVVwmzDP88EIj6phM4NV/1lQWQaLVGubpjX2BwLUfZkoygE1vC9yE6lQsI8fgi9cvUHxD+
ARC-Seal: i=1; a=rsa-sha256; t=1521487772; cv=none;
        d=google.com; s=arc-20160816;
        b=G9++34vRHcGYoiAo+PqCqeHPa59EA3BSob0Mw6RkECvCpX37vDxBPRT9BaS5rH0RTh
         lLdN61FTh51gKFgYuZ4TcO3ROJHGIsMyOjGN0Ygz+KL8M1K6e2qqjb21zwsCm4sLkmUP
         R8cynGiLpdqeK+4otlCyozzuRNqdhwe1ZA8PCe/6+9BxQ9QNxkjA4sRJaQpjkAyJfiXQ
         x53xyweGY3Pms943eFinMu9xNa9bGh+qbzEmdkQYxuMHr5YlOL70B0qUI1sYDU6MdFRR
         e/mBV5bF1vo2OTrjWRgEX435JuaogwED7YWw+5dr8+fRW7ZbcEs/EzF4hGof+nAcGWDT
         d4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=bC96q0PDabdYaFOWNzZ4PgkIcZSRO6SQdE4nd+STry4=;
        b=euR5B1TaMPMz4LJeLRXCeAxazCyRvRP/SlfwaVijHUUWde+B9ZA5cV5A26X66AtxD9
         dk8EjBF3hbLC4wH+3oIxC567pp8PDIMrQvcRy9e3RsCoA+A9fIwhy+fsHCnH49UcRepV
         GbJ0xAvkW/XIuY6sknWr98AmeQyWNGAmF6fEB5Se7x5JD4wVGNcnKouCxNDEjoC1NGv0
         AKUTetqXM37AEbVhSkCCjcFAOSmwBDGGiULwLny3zC27g23XLsmDV3mw0k1UUSaPRUnp
         p6Q4qsDCvWU825rcgB+1wlHG7MPccfNs0TxovVvCf2hrEdHRaLBvvpv2k+bAl8sPuE4e
         5wFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of toshi.kani@hpe.com designates 15.233.44.25 as permitted sender) smtp.mailfrom=toshi.kani@hpe.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of toshi.kani@hpe.com designates 15.233.44.25 as permitted sender) smtp.mailfrom=toshi.kani@hpe.com
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
Subject: Re: [PATCH v3 2/3] arm64: Implement page table free interfaces
Thread-Topic: [PATCH v3 2/3] arm64: Implement page table free interfaces
Thread-Index: AQHTv3+bZCOGKIWMhkeiI98Y63aQXqPX8ieA
Date: Mon, 19 Mar 2018 19:29:27 +0000
Message-ID: <1521487759.2693.224.camel@hpe.com>
References: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
	 <1521463256-19858-3-git-send-email-cpandya@codeaurora.org>
In-Reply-To: <1521463256-19858-3-git-send-email-cpandya@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB1162;7:9OhdG4VNgntpMMw8MWPtti4rAGV0904tjzwfFbTiTdDvIQyv3WU5P7/IEtiAiLNZPL4DUFr0DNHiz4y9APReIpuYC9T0+9QI0nmyuUsDCPKVSnVpx3aNKE5XB0ZOCuiL2W90WZMfTkHnMpxV4Kj/J8APX8ejQbZ2/2Gt8XDF31FXwDxwzfTae+xBmOdTf9crVyEyep3Oi+aTTUP/voVcr3PGI1Er6//mTkMPlxiJmCBufN7lzqxc67063TOUtIyE
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8df7710b-fb02-41d3-bfdd-08d58dcfbb15
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB1162;
x-ms-traffictypediagnostic: DF4PR8401MB1162:
x-microsoft-antispam-prvs: <DF4PR8401MB1162530D260D60A46FB6C08582D40@DF4PR8401MB1162.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231221)(944501302)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DF4PR8401MB1162;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB1162;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39380400002)(376002)(39860400002)(189003)(199004)(377424004)(6486002)(6436002)(305945005)(2950100002)(66066001)(36756003)(99286004)(6512007)(5660300001)(7736002)(76176011)(68736007)(14454004)(3660700001)(54906003)(3280700002)(3846002)(4326008)(6116002)(110136005)(2906002)(106356001)(229853002)(2501003)(103116003)(26005)(6246003)(316002)(53936002)(97736004)(8676002)(186003)(478600001)(5250100002)(102836004)(6506007)(25786009)(8936002)(2900100001)(105586002)(86362001)(81156014)(7416002)(81166006)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB1162;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: bu5/pY3OGQG3ovsZc6CiypwYmZ8mq8XIdH6uF1iR/O5v8IFDH+/V9Jf8jBk0iuFEx4mLzI23+xKLo+8MkT90kdQzWMDa+FjYh3W56VgkY8q8OsyZXUa+wh3egFUGAmIvOrmtIOb5xhO3exGVb5J9ge+chR84Ni1WdaBRGk5aMz585L6RKrSyigYx/Mggk9H2/yJBFZzZxG6Il9bPYfW64pDV6IcNajrAdtkyuLol1ALwqODjsGR4sHakCkKzySZFTc6VCsg3VDxWt/fVlluzDwt4scgQ+jZW0OCT6z8B1pAA2oEqhkuFvSQnQwXOD6Ln4l6biCDcgaDB8w/1RRfSOA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <343C81ABBCE43E429C438C0119AB3BC0@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df7710b-fb02-41d3-bfdd-08d58dcfbb15
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 19:29:27.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB1162
X-OriginatorOrg: hpe.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007777008930452?=
X-GMAIL-MSGID: =?utf-8?q?1595395562190432069?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gTW9uLCAyMDE4LTAzLTE5IGF0IDE4OjEwICswNTMwLCBDaGludGFuIFBhbmR5YSB3cm90ZToN
Cj4gSW1wbGVtZW50IHB1ZF9mcmVlX3BtZF9wYWdlKCkgYW5kIHBtZF9mcmVlX3B0ZV9wYWdlKCku
DQo+IA0KPiBJbXBsZW1lbnRhdGlvbiByZXF1aXJlcywNCj4gIDEpIEZyZWVpbmcgb2YgdGhlIHVu
LXVzZWQgbmV4dCBsZXZlbCBwYWdlIHRhYmxlcw0KPiAgMikgQ2xlYXJpbmcgb2ZmIHRoZSBjdXJy
ZW50IHB1ZC9wbWQgZW50cnkNCj4gIDMpIEludmFsaWRhdGUgVExCIHdoaWNoIGNvdWxkIGhhdmUg
cHJldmlvdXNseQ0KPiAgICAgdmFsaWQgYnV0IG5vdCBzdGFsZSBlbnRyeQ0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQ2hpbnRhbiBQYW5keWEgPGNwYW5keWFAY29kZWF1cm9yYS5vcmc+DQo+IC0tLQ0K
PiAgYXJjaC9hcm02NC9tbS9tbXUuYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9tbS9tbXUuYyBiL2FyY2gvYXJtNjQvbW0vbW11
LmMNCj4gaW5kZXggZGE5ODgyOC4uYzcwZjEzOSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9t
bS9tbXUuYw0KPiArKysgYi9hcmNoL2FybTY0L21tL21tdS5jDQo+IEBAIC00NSw2ICs0NSw3IEBA
DQo+ICAjaW5jbHVkZSA8YXNtL21lbWJsb2NrLmg+DQo+ICAjaW5jbHVkZSA8YXNtL21tdV9jb250
ZXh0Lmg+DQo+ICAjaW5jbHVkZSA8YXNtL3B0ZHVtcC5oPg0KPiArI2luY2x1ZGUgPGFzbS90bGJm
bHVzaC5oPg0KPiAgDQo+ICAjZGVmaW5lIE5PX0JMT0NLX01BUFBJTkdTCUJJVCgwKQ0KPiAgI2Rl
ZmluZSBOT19DT05UX01BUFBJTkdTCUJJVCgxKQ0KPiBAQCAtOTc1LDEwICs5NzYsMzUgQEAgaW50
IHBtZF9jbGVhcl9odWdlKHBtZF90ICpwbWRwKQ0KPiAgDQo+ICBpbnQgcHVkX2ZyZWVfcG1kX3Bh
Z2UocHVkX3QgKnB1ZCwgdW5zaWduZWQgbG9uZyBhZGRyKQ0KPiAgew0KPiAtCXJldHVybiBwdWRf
bm9uZSgqcHVkKTsNCj4gKwlwbWRfdCAqcG1kOw0KPiArCWludCBpOw0KPiArDQo+ICsJcG1kID0g
X192YShwdWRfdmFsKCpwdWQpKTsNCj4gKwlpZiAocHVkX3ZhbCgqcHVkKSkgew0KPiArCQlmb3Ig
KGkgPSAwOyBpIDwgUFRSU19QRVJfUE1EOyBpKyspDQo+ICsJCQlwbWRfZnJlZV9wdGVfcGFnZSgm
cG1kW2ldLCBhZGRyICsgKGkgKiBQTURfU0laRSkpOw0KPiArDQo+ICsJCWZyZWVfcGFnZSgodW5z
aWduZWQgbG9uZykgcG1kKTsNCg0KV2h5IGRvIHlvdSB3YW50IHRvIGZyZWUgdGhpcyBwbWQgcGFn
ZSBiZWZvcmUgY2xlYXJpbmcgdGhlIHB1ZCBlbnRyeSBvbg0KdGhpcyBhcm02NCB2ZXJzaW9uIChh
cyBpdCBzZWVtcyB5b3UgaW50ZW50aW9uYWxseSBjaGFuZ2VkIGl0IGZyb20gdGhlDQp4ODYgdmVy
c2lvbik/ICBJdCBjYW4gYmUgcmV1c2VkIHdoaWxlIGJlaW5nIHBvaW50ZWQgYnkgdGhlIHB1ZC4g
IFNhbWUNCmZvciBwbWQuDQoNCj4gKwkJcHVkX2NsZWFyKHB1ZCk7DQo+ICsJCWZsdXNoX3RsYl9r
ZXJuZWxfcmFuZ2UoYWRkciwgYWRkciArIFBVRF9TSVpFKTsNCg0KU2luY2UgeW91IHB1cmdlIHRo
ZSBlbnRpcmUgcHVkIHJhbmdlIGhlcmUsIGRvIHlvdSBzdGlsbCBuZWVkIHRvIGNhbGwgDQpwbWRf
ZnJlZV9wdGVfcGFnZSgpIHRvIHB1cmdlIGVhY2ggcG1kIHJhbmdlPyAgVGhpcyBsb29rcyB2ZXJ5
IGV4cGVuc2l2ZS4NCllvdSBtYXkgd2FudCB0byBjb25zaWRlciBpZiBjYWxsaW5nIGludGVybmFs
IF9fcG1kX2ZyZWVfcHRlX3BhZ2UoKQ0Kd2l0aG91dCB0aGUgcHVyZ2Ugb3BlcmF0aW9uIHdvcmtz
Lg0KDQotVG9zaGk=
