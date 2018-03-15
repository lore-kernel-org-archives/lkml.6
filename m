Return-Path: <toshi.kani@hpe.com>
X-Google-Smtp-Source: AG47ELsZtSpC70qF9e+YgLb9mo184O7lryiWdUUTsU7GgXAWpy/kxRc2XLlxWussVlU687TFUdEp
ARC-Seal: i=1; a=rsa-sha256; t=1521130375; cv=none;
        d=google.com; s=arc-20160816;
        b=m+9zyA+nLEXAGLaRJRPQmu1BE6aDaKA7qDI0fkII750gxT/0UuKilBN4UWbHobfF9k
         0rLV2HHxzu4+jSktu/uNFUNWvw2voDLLteJt0hx2Ifbl8qDzKT8XvIt5jSC9F2Pxf+ih
         4QD8K+Cl51FVZzs5b5DZJXk3yACQe34QgEKxg7COKVdtWgmjCz8LiQAC9SY5i8ib7Qh+
         sXaG+jlmhr3fliowYn6w6zH+D5zReaClklezndkwbsc1ck9gRMa0huH3UZIGYHKBdP0v
         Fd2u1IWmTdukw+ScHLXsn3nZ/h5dA8nPGEzq0uXPY9+8NAUoGgdMnTVwtR4YGnVw5oBU
         xWkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=gfMNLUGBnr7wqfabpi+92fnuavYYOMbtKdHnkgOAL7M=;
        b=tN4GsxPPlbiBoc/WEoHzhxc2l92lAGHHeCNs31LcpA/UhJeSwAuX8WRnAzI5cFFtul
         xKpZbnBaF3ftFdbaQQctScJqZik5dYXM/2IJanCBb5x9yYOG8YgAri3crAk5f1YIE4DE
         ViMWmslpGIkUKinsz6briirUaRCQpu4+fVgdzJNaQMQY8HdudHGsJLBY1favVYc5Zcms
         8uLnWUVgbYvNrNzMURjn+IXySrUX2kWlITAIXyEzA+gPbqsf5yGqE324i/8mlgm/jvH7
         fDtIZp3E5STowdi2982FK5GLBxITQHQnNQf3gxLPuFa2pBX2rfq+An29WHjUdCXQf+dC
         7HPw==
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
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com"
	<marc.zyngier@arm.com>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
Thread-Topic: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
Thread-Index: AQHTvFuW/H5D66EiPUqborstpx0HBaPReDQA
Date: Thu, 15 Mar 2018 16:12:52 +0000
Message-ID: <1521130368.2693.177.camel@hpe.com>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
	 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
In-Reply-To: <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB0569;7:JEzIv46nPb7yFED/iigF0Qk7UMpSljvTaCo0c2J5DXMelYvPVeaESNIg19C1Eemtt92J0b5kSOW/zsweikSfV1IsGHaEqsaFfP63t0WOV9JafZEl7umzcg03AcnYOs4yOLG5UQHZ2jD7vJOyvu2ZMqRv8NztbLG4fSmXLhOeGc93tRpy/PtbX7iv4jLHdDQivyQhbiZmg9gyPkHChXptEAusbEFt9HYOkLPxNX4DEzHq0SH4nZufUDyfzlkyAj/L
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 575f9ae9-deaa-41a9-50be-08d58a8f9b07
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB0569;
x-ms-traffictypediagnostic: DF4PR8401MB0569:
x-microsoft-antispam-prvs: <DF4PR8401MB05697D9630EE7732B596553D82D00@DF4PR8401MB0569.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DF4PR8401MB0569;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB0569;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(377424004)(189003)(199004)(2900100001)(106356001)(2906002)(7416002)(5660300001)(3660700001)(105586002)(66066001)(3280700002)(97736004)(76176011)(2950100002)(68736007)(36756003)(229853002)(99286004)(110136005)(54906003)(14454004)(6506007)(6486002)(103116003)(478600001)(102836004)(6246003)(4326008)(2201001)(316002)(8676002)(6116002)(3846002)(305945005)(6512007)(26005)(81166006)(81156014)(7736002)(8936002)(186003)(25786009)(2501003)(53936002)(86362001)(5250100002)(6436002)(14583001);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0569;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: /ufZtpDmM1mZa/g/PeeuD71IstvKp2fBswL7adxtw4mga1A6aVmqiCPyMeogcimWQDu8O+G1ijPr4FexfZz0gITAJDYFoEJOA50pdkv5XXXRYVSlhUG8Vv1sVTZlmZ2apKUte5o0S+xdShaPquYHB4HU5VZE8hjq+9wKEDzQMU0rTv2d8VK1cGvtJ3X2ht5jCe0he0Q72C2Fs/ZxLXlt2ntvzCefYL2iPlVDXyKS3eP+Z1o6OjB1aRf5PK0rr2bPrB2IgVs7WPMkCP9DgjZwBAUOWCEPzlT4TYFC9KkcX0kZTmlrGVuTVVMHN0RAqgPPGm+0Szysttiz0KrsGXlg9Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9168F7EEE5567C4387AEFF4307500D03@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 575f9ae9-deaa-41a9-50be-08d58a8f9b07
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 16:12:52.8072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0569
X-OriginatorOrg: hpe.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007763353693659?=
X-GMAIL-MSGID: =?utf-8?q?1595020804359330767?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTAzLTE1IGF0IDE4OjE1ICswNTMwLCBDaGludGFuIFBhbmR5YSB3cm90ZToN
Cj4gSHVnZSBtYXBwaW5nIGNoYW5nZXMgUE1EL1BVRCB3aGljaCBjb3VsZCBoYXZlDQo+IHZhbGlk
IHByZXZpb3VzIGVudHJpZXMuIFRoaXMgcmVxdWlyZXMgcHJvcGVyDQo+IFRMQiBtYWludGFuYW5j
ZSBvbiBzb21lIGFyY2hpdGVjdHVyZXMsIGxpa2UNCj4gQVJNNjQuDQo+IA0KPiBJbXBsZW50IEJC
TSAoYnJlYWstYmVmb3JlLW1ha2UpIHNhZmUgVExCDQo+IGludmFsaWRhdGlvbi4NCj4gDQo+IEhl
cmUsIEkndmUgdXNlZCBmbHVzaF90bGJfcGd0YWJsZSgpIGluc3RlYWQNCj4gb2YgZmx1c2hfa2Vy
bmVsX3JhbmdlKCkgYmVjYXVzZSBpbnZhbGlkYXRpbmcNCj4gaW50ZXJtZWRpYXRlIHBhZ2VfdGFi
bGUgZW50cmllcyBjb3VsZCBoYXZlDQo+IGJlZW4gb3B0aW1pemVkIGZvciBzcGVjaWZpYyBhcmNo
LiBUaGF0J3MgdGhlDQo+IGNhc2Ugd2l0aCBBUk02NCBhdCBsZWFzdC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IENoaW50YW4gUGFuZHlhIDxjcGFuZHlhQGNvZGVhdXJvcmEub3JnPg0KPiAtLS0NCj4g
IGxpYi9pb3JlbWFwLmMgfCAyNSArKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9saWIvaW9yZW1hcC5jIGIvbGliL2lvcmVtYXAuYw0KPiBpbmRleCA1NGU1YmJhLi41NWY4
NjQ4IDEwMDY0NA0KPiAtLS0gYS9saWIvaW9yZW1hcC5jDQo+ICsrKyBiL2xpYi9pb3JlbWFwLmMN
Cj4gQEAgLTEzLDYgKzEzLDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9leHBvcnQuaD4NCj4gICNp
bmNsdWRlIDxhc20vY2FjaGVmbHVzaC5oPg0KPiAgI2luY2x1ZGUgPGFzbS9wZ3RhYmxlLmg+DQo+
ICsjaW5jbHVkZSA8YXNtLWdlbmVyaWMvdGxiLmg+DQo+ICANCj4gICNpZmRlZiBDT05GSUdfSEFW
RV9BUkNIX0hVR0VfVk1BUA0KPiAgc3RhdGljIGludCBfX3JlYWRfbW9zdGx5IGlvcmVtYXBfcDRk
X2NhcGFibGU7DQo+IEBAIC04MCw2ICs4MSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IGlvcmVtYXBf
cG1kX3JhbmdlKHB1ZF90ICpwdWQsIHVuc2lnbmVkIGxvbmcgYWRkciwNCj4gIAkJdW5zaWduZWQg
bG9uZyBlbmQsIHBoeXNfYWRkcl90IHBoeXNfYWRkciwgcGdwcm90X3QgcHJvdCkNCj4gIHsNCj4g
IAlwbWRfdCAqcG1kOw0KPiArCXBtZF90IG9sZF9wbWQ7DQo+ICAJdW5zaWduZWQgbG9uZyBuZXh0
Ow0KPiAgDQo+ICAJcGh5c19hZGRyIC09IGFkZHI7DQo+IEBAIC05MSwxMCArOTMsMTUgQEAgc3Rh
dGljIGlubGluZSBpbnQgaW9yZW1hcF9wbWRfcmFuZ2UocHVkX3QgKnB1ZCwgdW5zaWduZWQgbG9u
ZyBhZGRyLA0KPiAgDQo+ICAJCWlmIChpb3JlbWFwX3BtZF9lbmFibGVkKCkgJiYNCj4gIAkJICAg
ICgobmV4dCAtIGFkZHIpID09IFBNRF9TSVpFKSAmJg0KPiAtCQkgICAgSVNfQUxJR05FRChwaHlz
X2FkZHIgKyBhZGRyLCBQTURfU0laRSkgJiYNCj4gLQkJICAgIHBtZF9mcmVlX3B0ZV9wYWdlKHBt
ZCkpIHsNCj4gLQkJCWlmIChwbWRfc2V0X2h1Z2UocG1kLCBwaHlzX2FkZHIgKyBhZGRyLCBwcm90
KSkNCj4gKwkJICAgIElTX0FMSUdORUQocGh5c19hZGRyICsgYWRkciwgUE1EX1NJWkUpKSB7DQo+
ICsJCQlvbGRfcG1kID0gKnBtZDsNCj4gKwkJCXBtZF9jbGVhcihwbWQpOw0KDQpwbWRfY2xlYXIo
KSBpcyBvbmUgb2YgdGhlIG9wZXJhdGlvbnMgcG1kX2ZyZWVfcHRlX3BhZ2UoKSBuZWVkcyB0byBk
by4NClNlZSB0aGUgeDg2IHZlcnNpb24uDQoNCj4gKwkJCWZsdXNoX3RsYl9wZ3RhYmxlKCZpbml0
X21tLCBhZGRyKTsNCg0KWW91IGNhbiBjYWxsIGl0IGluIHBtZF9mcmVlX3B0ZV9wYWdlKCkgb24g
YXJtNjQgYXMgd2VsbC4gDQoNCj4gKwkJCWlmIChwbWRfc2V0X2h1Z2UocG1kLCBwaHlzX2FkZHIg
KyBhZGRyLCBwcm90KSkgew0KPiArCQkJCXBtZF9mcmVlX3B0ZV9wYWdlKCZvbGRfcG1kKTsNCj4g
IAkJCQljb250aW51ZTsNCj4gKwkJCX0gZWxzZQ0KPiArCQkJCXNldF9wbWQocG1kLCBvbGRfcG1k
KTsNCg0KSSBkbyBub3QgdW5kZXJzdGFuZCB3aHkgeW91IG5lZWRlZCB0byBtYWtlIHRoaXMgY2hh
bmdlLiANCnBtZF9mcmVlX3B0ZV9wYWdlKCkgaXMgZGVmaW5lZCBhcyBhbiBhcmNoLXNwZWNpZmlj
IGZ1bmN0aW9uIHNvIHRoYXQgeW91DQpjYW4gYWRkaXRpb25hbGx5IHBlcmZvcm0gVExCIHB1cmdl
cyBvbiBhcm02NC4gIFBsZWFzZSB0cnkgdG8gbWFrZSBwcm9wZXINCmFybTY0IGltcGxlbWVudGF0
aW9uIG9mIHRoaXMgaW50ZXJmYWNlLiAgQW5kIGlmIHlvdSBmaW5kIGFueSBpc3N1ZSBpbg0KdGhp
cyBpbnRlcmZhY2UsIHBsZWFzZSBsZXQgbWUga25vdy4NCg0KU2FtZSBmb3IgcHVkLg0KDQpUaGFu
a3MsDQotVG9zaGkNCg==
