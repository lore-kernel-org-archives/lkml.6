Return-Path: <namit@vmware.com>
X-Google-Smtp-Source: AIpwx490fxqEjW9VoIReY3DbXoBH1ioSq9Ku66Ji11hPcTgVKItGAc48KCkEPeJKv4tF/yTc5Dm4
ARC-Seal: i=1; a=rsa-sha256; t=1524273664; cv=none;
        d=google.com; s=arc-20160816;
        b=DTu2qmjPPep+Gej+OGavuqwbMbzbix94qWsQrN+kr/PHhrYKQZIoSrLbs7/vTADKHY
         R9O4iZ/Bpb1HydyEBHKwFnKKs/Uu8fzuW/FeIW6v4W9LKWBYJ/RhVoDStQgG3aXoTDg6
         0XehkaNEt0OGzBRDkZthZpLy9yn5vL0kxxuAMXvOZuyWr7VcPt1CYFfF4kuY/GQXoGGU
         HRo9r3kFzDzoFC1T/Aj+K1fXd5ehQkGsmU4lxmRybppityXPU89WqHfCxxE1ewN3bmM4
         rWFXr+YVESLXWNZ1x6CdwiUVRdQFrs6+yKtdqQSvKODmbzBU0LsuyHOmdSd1AXa1miJh
         jS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=laztLy7ezD6CG0arXlk6P3hAc6+MPfsk+XBjUfZGnBM=;
        b=06GB3D1zEyo/HngFedcP5ZOXpDpFUR8/dETDGdpPiSe37Eixaqyc8JcnkGn2mK92ui
         TKEkBGPg0SvkM2br/DUIpEurxXTeQuKpJltxLGmVYIU6P0AQsX69XF9iOAQ58c9tTpE5
         yQO4kb7NBaututu3i/3sIdAsaNP5ZPh9/w6c52WBymqftz3dVQ4Y94IMqEq2iLUYO2ED
         3in5rhE/G3kdKA9gV7tR+jCv15RHf836t+6WYdQYP+iYhTcw0U4aDsxqOCGlEwzJmwgf
         gQ0ciJumr37dvw65LTP1JC7E5oO4Sw6wZKIkmjytQRZIO18GrGepDpo/NL5PL/kZQVYd
         3dVA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@onevmw.onmicrosoft.com header.s=selector1-vmware-com header.b=XgQFvlFU;
       spf=pass (google.com: domain of namit@vmware.com designates 104.47.36.40 as permitted sender) smtp.mailfrom=namit@vmware.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@onevmw.onmicrosoft.com header.s=selector1-vmware-com header.b=XgQFvlFU;
       spf=pass (google.com: domain of namit@vmware.com designates 104.47.36.40 as permitted sender) smtp.mailfrom=namit@vmware.com
From: Nadav Amit <namit@vmware.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: LKML <linux-kernel@vger.kernel.org>, "open list:MEMORY MANAGEMENT"
	<linux-mm@kvack.org>, Fengguang Wu <fengguang.wu@intel.com>, Andrea Arcangeli
	<aarcange@redhat.com>, Andy Lutomirski <luto@kernel.org>, Arjan van de Ven
	<arjan@linux.intel.com>, Borislav Petkov <bp@alien8.de>, Dan Williams
	<dan.j.williams@intel.com>, David Woodhouse <dwmw2@infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "hughd@google.com"
	<hughd@google.com>, "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
	"jgross@suse.com" <jgross@suse.com>, "keescook@google.com"
	<keescook@google.com>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH 5/5] x86, pti: filter at vma->vm_page_prot population
Thread-Topic: [PATCH 5/5] x86, pti: filter at vma->vm_page_prot population
Thread-Index: AQHT2PZXaym80tkY9UWPdN7DigYm+qQKbBeA
Date: Sat, 21 Apr 2018 01:21:01 +0000
Message-ID: <295DB0D1-CDFB-482C-93DF-63DAA36DAE22@vmware.com>
References: <20180420222018.E7646EE1@viggo.jf.intel.com>
 <20180420222028.99D72858@viggo.jf.intel.com>
In-Reply-To: <20180420222028.99D72858@viggo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR05MB2661;7:g5l+rAQt/z702k6oET4oL8o4IVgiMTkcFTY/z/UgkT4tshg5GJzyJnQhuOibM2F0owiSHp0LCBlpCLS3dMpEt5TFCMA5/bApkVjaGu4zIF4ItnriWS1HRU9gW/05mQtW9mfkn92eVhz5dC1XwP+I4kwFn+7auX3xSugPNpeXkG3DDUnFftx0zGIktPui67v+w6u2bW1VI3GCyk2TSdv2gR4F09KnNdQc50HgS5gJ96Pf8i4JyVuRjNuFvTd9W+Mp;20:AVJTR+4fY7tonu8nKah1NotoD3a/Sp9WqsGvGJcQmq9lmHYvd3bmY6l11syX/dPjHcc9oTiZ/bPKy3USZtmXwBCdoXXwEcDeWaFwoPmDSpZJxdD0ezJuzi5Cpfn+SumCZ2tMaYP3PbMd4rbk9Z60tAHlnNyO80EOliXndnZypWo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR05MB2661;
x-ms-traffictypediagnostic: CO2PR05MB2661:
x-microsoft-antispam-prvs: <CO2PR05MB2661AB759EE6E351FB336515D08B0@CO2PR05MB2661.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(211936372134217)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501400)(52105095)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO2PR05MB2661;BCL:0;PCL:0;RULEID:;SRVR:CO2PR05MB2661;
x-forefront-prvs: 064903DDDC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(2900100001)(11346002)(446003)(6512007)(53936002)(33656002)(25786009)(8676002)(81166006)(8936002)(7736002)(6916009)(6506007)(82746002)(3846002)(102836004)(26005)(6116002)(59450400001)(6246003)(316002)(186003)(54906003)(6486002)(99286004)(229853002)(6436002)(36756003)(2906002)(476003)(86362001)(76176011)(7416002)(2616005)(305945005)(14454004)(5250100002)(3280700002)(478600001)(3660700001)(66066001)(83716003)(4326008)(5660300001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR05MB2661;H:CO2PR05MB2646.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: 3b1g9cFxz0TxzBCcOvSWKuG+sK+/QgKhj/zX8BLgsyhScM+UkptMR0YU2o2h9m1A1UQYiUy5jcZAFqvQX47y9K65MziAbPClYFQcbHWzNYeAS5qimIDl/ZqexWqsIitfx6LgkPjG6GFZP9/ny1JdpNjJcjE3cQoZ37TYcuMUD1NhNLEaJZz+kqzJxYopk9Rh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C077810B70D68746AC8E7EAAAC06FE6A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8b3ace58-8fc4-4c08-3074-08d5a7262564
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3ace58-8fc4-4c08-3074-08d5a7262564
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2018 01:21:01.8320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR05MB2661
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598305663974065245?=
X-GMAIL-MSGID: =?utf-8?q?1598316781772619608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQoNCj4gDQo+
IEZyb206IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQo+IA0KPiAw
ZGF5IHJlcG9ydGVkIHdhcm5pbmdzIGF0IGJvb3Qgb24gMzItYml0IHN5c3RlbXMgd2l0aG91dCBO
WCBzdXBwb3J0Og0KPiANCj4gWyAgIDEyLjM0OTE5M10gYXR0ZW1wdGVkIHRvIHNldCB1bnN1cHBv
cnRlZCBwZ3Byb3Q6IDgwMDAwMDAwMDAwMDAwMjUgYml0czogODAwMDAwMDAwMDAwMDAwMCBzdXBw
b3J0ZWQ6IDdmZmZmZmZmZmZmZmZmZmYNCj4gWyAgIDEyLjM1MDc5Ml0gV0FSTklORzogQ1BVOiAw
IFBJRDogMSBhdCBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlLmg6NTQwIGhhbmRsZV9tbV9m
YXVsdCsweGZjMS8weGZlMDoNCj4gCQkJCQkJY2hlY2tfcGdwcm90IGF0IGFyY2gveDg2L2luY2x1
ZGUvYXNtL3BndGFibGUuaDo1MzUNCj4gCQkJCQkJIChpbmxpbmVkIGJ5KSBwZm5fcHRlIGF0IGFy
Y2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGUuaDo1NDkNCj4gCQkJCQkJIChpbmxpbmVkIGJ5KSBk
b19hbm9ueW1vdXNfcGFnZSBhdCBtbS9tZW1vcnkuYzozMTY5DQo+IAkJCQkJCSAoaW5saW5lZCBi
eSkgaGFuZGxlX3B0ZV9mYXVsdCBhdCBtbS9tZW1vcnkuYzozOTYxDQo+IAkJCQkJCSAoaW5saW5l
ZCBieSkgX19oYW5kbGVfbW1fZmF1bHQgYXQgbW0vbWVtb3J5LmM6NDA4Nw0KPiAJCQkJCQkgKGlu
bGluZWQgYnkpIGhhbmRsZV9tbV9mYXVsdCBhdCBtbS9tZW1vcnkuYzo0MTI0DQo+IA0KPiBUaGUg
cHJvYmxlbSB3YXMgdGhhdCB3ZSBzdG9wcGVkIG1hc3NhZ2luZyBwYWdlIHBlcm1pc3Npb25zIGF0
IFBURSBjcmVhdGlvbg0KPiB0aW1lLCBzbyB2bWEtPnZtX3BhZ2VfcHJvdCB3YXMgcGFzc2VkIHVu
ZmlsdGVyZWQgdG8gUFRFIGNyZWF0aW9uLg0KPiANCj4gVG8gZml4IGl0LCBmaWx0ZXIgdGhlIHBh
Z2UgcHJvdGVjdGlvbnMgYmVmb3JlIHRoZXkgYXJlIGluc3RhbGxlZCBpbg0KPiB2bWEtPnZtX3Bh
Z2VfcHJvdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBs
aW51eC5pbnRlbC5jb20+DQo+IFJlcG9ydGVkLWJ5OiBGZW5nZ3VhbmcgV3UgPGZlbmdndWFuZy53
dUBpbnRlbC5jb20+DQo+IEZpeGVzOiBmYjQzZDZjYjkxICgieDg2L21tOiBEbyBub3QgYXV0by1t
YXNzYWdlIHBhZ2UgcHJvdGVjdGlvbnMiKQ0KPiBDYzogQW5kcmVhIEFyY2FuZ2VsaSA8YWFyY2Fu
Z2VAcmVkaGF0LmNvbT4NCj4gQ2M6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPg0K
PiBDYzogQXJqYW4gdmFuIGRlIFZlbiA8YXJqYW5AbGludXguaW50ZWwuY29tPg0KPiBDYzogQm9y
aXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IENjOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndp
bGxpYW1zQGludGVsLmNvbT4NCj4gQ2M6IERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFk
Lm9yZz4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+DQo+IENjOiBIdWdoIERpY2tpbnMgPGh1Z2hkQGdvb2dsZS5jb20+DQo+IENjOiBKb3NoIFBv
aW1ib2V1ZiA8anBvaW1ib2VAcmVkaGF0LmNvbT4NCj4gQ2M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9z
c0BzdXNlLmNvbT4NCj4gQ2M6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAZ29vZ2xlLmNvbT4NCj4gQ2M6
IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gQ2M6IE5h
ZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+DQo+IENjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6
QGluZnJhZGVhZC5vcmc+DQo+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5k
ZT4NCj4gQ2M6IGxpbnV4LW1tQGt2YWNrLm9yZw0KPiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQGtl
cm5lbC5vcmc+DQo+IC0tLQ0KPiANCj4gYi9hcmNoL3g4Ni9LY29uZmlnICAgICAgICAgICAgICAg
fCAgICA0ICsrKysNCj4gYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggfCAgICA1ICsr
KysrDQo+IGIvbW0vbW1hcC5jICAgICAgICAgICAgICAgICAgICAgIHwgICAxMSArKysrKysrKysr
LQ0KPiAzIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLXB1TiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlLmh+cHRpLWdsYi1wcm90
ZWN0aW9uX21hcCBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4gLS0tIGEvYXJjaC94
ODYvaW5jbHVkZS9hc20vcGd0YWJsZS5ofnB0aS1nbGItcHJvdGVjdGlvbl9tYXAJMjAxOC0wNC0y
MCAxNDoxMDowOC4yNTE3NDkxNTEgLTA3MDANCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20v
cGd0YWJsZS5oCTIwMTgtMDQtMjAgMTQ6MTA6MDguMjYwNzQ5MTUxIC0wNzAwDQo+IEBAIC02MDEs
NiArNjAxLDExIEBAIHN0YXRpYyBpbmxpbmUgcGdwcm90X3QgcGdwcm90X21vZGlmeShwZ3ANCj4g
DQo+ICNkZWZpbmUgY2Fub25fcGdwcm90KHApIF9fcGdwcm90KG1hc3NhZ2VfcGdwcm90KHApKQ0K
PiANCj4gK3N0YXRpYyBpbmxpbmUgcGdwcm90X3QgYXJjaF9maWx0ZXJfcGdwcm90KHBncHJvdF90
IHByb3QpDQo+ICt7DQo+ICsJcmV0dXJuIGNhbm9uX3BncHJvdChwcm90KTsNCj4gK30NCj4gKw0K
PiBzdGF0aWMgaW5saW5lIGludCBpc19uZXdfbWVtdHlwZV9hbGxvd2VkKHU2NCBwYWRkciwgdW5z
aWduZWQgbG9uZyBzaXplLA0KPiAJCQkJCSBlbnVtIHBhZ2VfY2FjaGVfbW9kZSBwY20sDQo+IAkJ
CQkJIGVudW0gcGFnZV9jYWNoZV9tb2RlIG5ld19wY20pDQo+IGRpZmYgLXB1TiBhcmNoL3g4Ni9L
Y29uZmlnfnB0aS1nbGItcHJvdGVjdGlvbl9tYXAgYXJjaC94ODYvS2NvbmZpZw0KPiAtLS0gYS9h
cmNoL3g4Ni9LY29uZmlnfnB0aS1nbGItcHJvdGVjdGlvbl9tYXAJMjAxOC0wNC0yMCAxNDoxMDow
OC4yNTM3NDkxNTEgLTA3MDANCj4gKysrIGIvYXJjaC94ODYvS2NvbmZpZwkyMDE4LTA0LTIwIDE0
OjEwOjA4LjI2MDc0OTE1MSAtMDcwMA0KPiBAQCAtNTIsNiArNTIsNyBAQCBjb25maWcgWDg2DQo+
IAlzZWxlY3QgQVJDSF9IQVNfREVWTUVNX0lTX0FMTE9XRUQNCj4gCXNlbGVjdCBBUkNIX0hBU19F
TEZfUkFORE9NSVpFDQo+IAlzZWxlY3QgQVJDSF9IQVNfRkFTVF9NVUxUSVBMSUVSDQo+ICsJc2Vs
ZWN0IEFSQ0hfSEFTX0ZJTFRFUl9QR1BST1QNCj4gCXNlbGVjdCBBUkNIX0hBU19GT1JUSUZZX1NP
VVJDRQ0KPiAJc2VsZWN0IEFSQ0hfSEFTX0dDT1ZfUFJPRklMRV9BTEwNCj4gCXNlbGVjdCBBUkNI
X0hBU19LQ09WCQkJaWYgWDg2XzY0DQo+IEBAIC0yNzMsNiArMjc0LDkgQEAgY29uZmlnIEFSQ0hf
SEFTX0NQVV9SRUxBWA0KPiBjb25maWcgQVJDSF9IQVNfQ0FDSEVfTElORV9TSVpFDQo+IAlkZWZf
Ym9vbCB5DQo+IA0KPiArY29uZmlnIEFSQ0hfSEFTX0ZJTFRFUl9QR1BST1QNCj4gKwlkZWZfYm9v
bCB5DQo+ICsNCj4gY29uZmlnIEhBVkVfU0VUVVBfUEVSX0NQVV9BUkVBDQo+IAlkZWZfYm9vbCB5
DQo+IA0KPiBkaWZmIC1wdU4gbW0vbW1hcC5jfnB0aS1nbGItcHJvdGVjdGlvbl9tYXAgbW0vbW1h
cC5jDQo+IC0tLSBhL21tL21tYXAuY35wdGktZ2xiLXByb3RlY3Rpb25fbWFwCTIwMTgtMDQtMjAg
MTQ6MTA6MDguMjU2NzQ5MTUxIC0wNzAwDQo+ICsrKyBiL21tL21tYXAuYwkyMDE4LTA0LTIwIDE0
OjEwOjA4LjI2MTc0OTE1MSAtMDcwMA0KPiBAQCAtMTAwLDExICsxMDAsMjAgQEAgcGdwcm90X3Qg
cHJvdGVjdGlvbl9tYXBbMTZdIF9fcm9fYWZ0ZXJfaQ0KPiAJX19TMDAwLCBfX1MwMDEsIF9fUzAx
MCwgX19TMDExLCBfX1MxMDAsIF9fUzEwMSwgX19TMTEwLCBfX1MxMTENCj4gfTsNCj4gDQo+ICsj
aWZuZGVmIENPTkZJR19BUkNIX0hBU19GSUxURVJfUEdQUk9UDQo+ICtzdGF0aWMgaW5saW5lIHBn
cHJvdF90IGFyY2hfZmlsdGVyX3BncHJvdChwZ3Byb3RfdCBwcm90KQ0KPiArew0KPiArCXJldHVy
biBwcm90Ow0KPiArfQ0KPiArI2VuZGlmDQo+ICsNCj4gcGdwcm90X3Qgdm1fZ2V0X3BhZ2VfcHJv
dCh1bnNpZ25lZCBsb25nIHZtX2ZsYWdzKQ0KPiB7DQo+IC0JcmV0dXJuIF9fcGdwcm90KHBncHJv
dF92YWwocHJvdGVjdGlvbl9tYXBbdm1fZmxhZ3MgJg0KPiArCXBncHJvdF90IHJldCA9IF9fcGdw
cm90KHBncHJvdF92YWwocHJvdGVjdGlvbl9tYXBbdm1fZmxhZ3MgJg0KPiAJCQkJKFZNX1JFQUR8
Vk1fV1JJVEV8Vk1fRVhFQ3xWTV9TSEFSRUQpXSkgfA0KPiAJCQlwZ3Byb3RfdmFsKGFyY2hfdm1f
Z2V0X3BhZ2VfcHJvdCh2bV9mbGFncykpKTsNCj4gKw0KPiArCXJldHVybiBhcmNoX2ZpbHRlcl9w
Z3Byb3QocmV0KTsNCj4gfQ0KPiBFWFBPUlRfU1lNQk9MKHZtX2dldF9wYWdlX3Byb3QpOw0KDQpX
b3VsZG7igJl0IGl0IGJlIHNpbXBsZXIgb3IgYXQgbGVhc3QgY2xlYW5lciB0byBjaGFuZ2UgdGhl
IHByb3RlY3Rpb24gbWFwIGlmDQpOWCBpcyBub3Qgc3VwcG9ydGVkPyBJIHByZXN1bWUgaXQgY2Fu
IGJlIGRvbmUgcGFnaW5nX2luaXQoKSBzaW1pbGFybHkgdG8gdGhlDQp3YXkgb3RoZXIgYXJjaHMg
KGUuZy4sIGFybSwgbWlwcykgZG8uDQoNCg==
