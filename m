Return-Path: <toshi.kani@hpe.com>
X-Google-Smtp-Source: AG47ELtdLoqVR8/hqlHMeVY34LTLhCLOq5ktuO3quSyL84LwjGqWKU4VfP7WYKW/RteYfxV7XdfP
ARC-Seal: i=1; a=rsa-sha256; t=1521124711; cv=none;
        d=google.com; s=arc-20160816;
        b=mvDi1lk6zKtSK01bXSEgQ2kD/nZ81qLpDk6l6h12ABUljsRFrHPnqmhewQ9jQOQAA6
         1E0fxuUrr6AAEIMfiCj2vCfzEmdgHXvFQdFjkvQ3o/c42qnEqwzEE+C0w8Nl9QFwa6KC
         3ipjuONGvaoMlq6qK/fJNM7qfvE1fQ7j9c+9gp99VABJq1iGPI0rdh4qbO8zIHL5YaMl
         3eGwILMWs6fy2IQdBn7QybC87FFRq24U8JJbGqT9aab4F+pFsaM0QMi0aevOQt2p8JY0
         4N8xmkL9aBvBh9k4O8FBMsCgBIRFoC8KNtKoy8EQ87GFuZ9d5p0CeXEpj8+dqekjNTPM
         WDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=F2YhE9Lica+Q7lHoB4aOVMBR2z7wog2/G9GkLDNinpU=;
        b=Ae2gI6S727DbviFaK48yWTNPTZxs829X74V/5r1Tq+96+E9a+miGwWVkohrzXCKxEz
         NOMP+pQzF2LlCCR+kSZBCbPAwkUGIizcWyoGyzLYyJ0mVNrYJv53Pr5dg8GJPxq6qRst
         lRzmDbBG6UyeY0BCWjOYN+e4Shk9zUkXmVvgGmPbkhaflxikPL2rona87NPRyuebxxu1
         7qhn9tIxjRiNso9zYtUomXhp8R9ATBbA6+SFcP/6nAYuum8kHyodEfd334gRN1lXijOV
         9FAURoYmuPRx+xGvqRe07jJOmoM+CXRA4DAh/A853IYANrGhbariJAsqlqH/sN+v4B1p
         59OA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of toshi.kani@hpe.com designates 15.233.44.27 as permitted sender) smtp.mailfrom=toshi.kani@hpe.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of toshi.kani@hpe.com designates 15.233.44.27 as permitted sender) smtp.mailfrom=toshi.kani@hpe.com
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
Subject: Re: [PATCH v1 0/4] Fix issues with huge mapping in ioremap
Thread-Topic: [PATCH v1 0/4] Fix issues with huge mapping in ioremap
Thread-Index: AQHTu3FSGWoL5FTXrkiY4uG3QiL07aPPzTOAgAEXQICAAHszAA==
Date: Thu, 15 Mar 2018 14:38:27 +0000
Message-ID: <1521124702.2693.145.camel@hpe.com>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
	 <1521038277.2693.131.camel@hpe.com>
	 <9954bd28-0457-b80e-8af7-6259b63533f2@codeaurora.org>
In-Reply-To: <9954bd28-0457-b80e-8af7-6259b63533f2@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB0649;7:RTM+RaSZ1x53beRGsUlmfzbQX9zWkVbyxucgs/qML4TQ28QvTcUtniLDvqpER3oFyZrEXFIek2QuGbbUxiXqo8SlfUfpzZUDuiFdyqX6SxClB1JG8zdqQ1a3IiaitaMkEPb2P+Kjk712tJWJVXwnpi0P807lihC2RaXlCxoOnppVQa+/hXWiDObqz+QVOKGrrDZ96i2Za5XE6jVECHqPzrvnywOXDtV1Wk5wYWqT4kEjDaO5NjrXqncTzlEIsF7H
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d247b4c0-dd51-4396-6ade-08d58a826a7b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB0649;
x-ms-traffictypediagnostic: DF4PR8401MB0649:
x-microsoft-antispam-prvs: <DF4PR8401MB064992E3A07CDBA96B0C18D382D00@DF4PR8401MB0649.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DF4PR8401MB0649;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB0649;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(366004)(376002)(39380400002)(189003)(377424004)(199004)(5660300001)(7416002)(103116003)(7736002)(106356001)(81166006)(3660700001)(305945005)(2950100002)(3846002)(105586002)(2201001)(25786009)(8676002)(99286004)(86362001)(4326008)(81156014)(54906003)(8936002)(110136005)(68736007)(2501003)(6506007)(36756003)(53936002)(5250100002)(66066001)(6512007)(186003)(6436002)(6486002)(53546011)(229853002)(97736004)(26005)(3280700002)(478600001)(76176011)(6116002)(316002)(2900100001)(2906002)(14454004)(6246003)(102836004)(14583001);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0649;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: L1SIyXB64qQy+7RuuXQ2vAxVkMPgYPs0p2Z9uMLDWVHxHrVgkLupcA7QzUgze/oh5yOMIvjk7+7wu7vU/mXlrMhLF91TB/wLMQyYiKor8FuBFlQL6FxpFColCDXdH25MIFeVB/uDsgKw8cU/NvZ4Nvoy/eHT27Z649i7Zv9EUcDkcBscFuDMBMwSSy6SMH1APg+m1TTV0l2pEN1DmzEVhhLH3i04zvP04Wp1NodCr4R9a4cFyW5lVoaVaogCf6LKZs7qrFsjq+2rgnh+Kz8Cwd2pAOZ2cjhXmQU0faucRM3kTCyKSXduTymEKvbRUolgjEHow+6UxT8Vb08SURRRbA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <891312FA6E232C4A9E87CA5353C923DE@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d247b4c0-dd51-4396-6ade-08d58a826a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 14:38:27.8554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0649
X-OriginatorOrg: hpe.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902258124982014?=
X-GMAIL-MSGID: =?utf-8?q?1595014864912456196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTAzLTE1IGF0IDEyOjQ3ICswNTMwLCBDaGludGFuIFBhbmR5YSB3cm90ZToN
Cj4gDQo+IE9uIDMvMTQvMjAxOCA4OjA4IFBNLCBLYW5pLCBUb3NoaSB3cm90ZToNCj4gPiBPbiBX
ZWQsIDIwMTgtMDMtMTQgYXQgMTQ6MTggKzA1MzAsIENoaW50YW4gUGFuZHlhIHdyb3RlOg0KPiA+
ID4gTm90ZTogSSB3YXMgd29ya2luZyBvbiB0aGVzZSBwYXRjaGVzIGZvciBxdWl0ZSBzb21ldGlt
ZQ0KPiA+ID4gYW5kIHJlYWxpemVkIHRoYXQgVG9zaGkgS2FuaSBoYXMgc2hhcmVkIHNvbWUgcGF0
Y2hlcw0KPiA+ID4gYWRkcmVzc2luZyB0aGUgc2FtZSBpc3NzdWUgd2l0aCBzdWJqZWN0DQo+ID4g
PiAiW1BBVENIIDAvMl0gZml4IG1lbW9yeSBsZWFrIC8gcGFuaWMgaW4gaW9yZW1hcCBodWdlIHBh
Z2VzIi4NCj4gPiA+IEkndmUgdGFrZW4gc2xpZ2h0bHkgZGlmZmVyZW50IGFwcHJvYWNoIGhlcmUs
IHNvIHNlbmRpbmcNCj4gPiA+IHRvIHRoZSBsaXN0LCBmaW5hbGx5Lg0KPiA+IA0KPiA+IEhpIENo
aW50YW4sDQo+IA0KPiBIaSBUb3NoaQ0KPiA+IA0KPiA+IERvIHlvdSBoYXZlIGFueSBpc3N1ZSBp
biBteSBwYXRjaHNldD8gIElmIHNvLCBjYW4geW91IHBsZWFzZSBjb21tZW50IG9uDQo+IA0KPiBO
b3QgZnVuY3Rpb25hbCBpc3N1ZXMuIEJ1dCBJIGRpZG4ndCBzZWUgaXNzdWVzIHlvdSBtZW50aW9u
ZWQgaW4geW91cg0KPiBjb21taXQgdGV4dCBiZWluZyBzb2x2ZWQgZm9yIEFSTTY0IGluIHlvdXIg
cGF0Y2hlcy4gSXQgaXMganVzdCBiZWluZw0KPiBtYXNrZWQgd2hpY2ggdGhleSB3ZXJlIGFscmVh
ZHkgYnkgV2lsbCdzIHBhdGNoLiBJbiBteSBhcHByb2FjaCwgZW5kDQo+IGdvYWwgd2FzIHRvIGdl
dCBiZW5lZml0cyBvZiBodWdlIG1hcHBpbmcgYmFjayBmb3IgQVJNNjQuDQoNClJpZ2h0LCBteSBw
YXRjaHNldCBkb2VzIG5vdCBpbXBsZW1lbnQgdGhlIGZpeCBmb3IgYXJtNjQuICBUaGUgc3R1Yg0K
dmVyc2lvbiBpcyBvbmx5IGEgd29ya2Fyb3VuZCBhbmQgaXMgbWVhbnQgdG8gYmUgcmVwbGFjZWQg
YnkgdGhlIGZpeC4NCg0KPiA+IHRoZW0/ICBJdCBjb21wbGljYXRlcyB0aGUgdGhpbmcgd2hlbiB5
b3Ugc2VuZCBhIGRpZmZlcmVudCBhcHByb2FjaA0KPiA+IHdpdGhvdXQgdGVsbGluZyB3aHkgYSBk
aWZmZXJlbnQgYXBwcm9hY2ggaXMgbmVlZGVkLiAgWW91ciBhcHByb2FjaA0KPiANCj4gU2VlIG15
IHJlcGx5IGFib3ZlLiBJIGp1c3QgaGFkIG15IG9yaWdpbmFsIHBhdGNoZXMgYW5kIEkgc2VudCBp
dC4NCj4gDQo+ID4gcHVyZ2VzIFRMQiBhZnRlciB1cGRhdGluZyBwbWQvcHVkLCB3aGljaCBJIHRo
aW5rIGlzIGJyb2tlbi4gIENhbiB5b3UNCj4gDQo+IFllcywgdGhleSBhcmUgYnJva2VuLiBJIHVu
ZGVyc3Rvb2QgdGhlIGlzc3VlcyBhZnRlciBNYXJrIGFuZCBNYXJjJ3MNCj4gcmV2aWV3IGNvbW1l
bnRzLg0KPiANCj4gPiB3b3JrIG9uIHRvcCBvZiBteSBwYXRjaHNldCBhbmQgcHJvcGVybHkgaW1w
bGVtZW50IHBYZF9mcmVlX3B0ZV9wYWdlKCkNCj4gDQo+IEkgaGF2ZSByZWFsaXplZCB0aGF0IGlm
IEkgYWRkcmVzcyBNYXJrJ3MgY29tbWVudHMsIG15IG5ldyBwYXRjaCB3aWxsDQo+IGxvb2sgc2lt
aWxhciB0byB3aGF0IHlvdSBoYXZlIGRvbmUuIFNvLCBJIHdpbGwgd29yayBvbiB0b3Agb2YgeW91
cg0KPiBwYXRjaGVzLg0KDQpTb3VuZHMgZ3JlYXQuDQoNClRoYW5rcywNCi1Ub3NoaQ0K
