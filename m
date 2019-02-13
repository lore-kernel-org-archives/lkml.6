Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5755CC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A860218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="LwxrNef1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389251AbfBMNK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:10:57 -0500
Received: from mail-eopbgr150100.outbound.protection.outlook.com ([40.107.15.100]:39744
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726084AbfBMNK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1clPg7Uik6VYe1mL1htvKa19T4doT8r0l/aH4E83JQ=;
 b=LwxrNef1qRJE/mW0aL+aeKlwIGo8eL4fO1XR2AfdAGaa70Wijt+XM1DDHWuVcg3u5Y27MblOmLGT0/VtAn3MZojjFVSKTyRDlcu1pdmseDItnzAbwNYGDWKBhmCZtRHQk6RU/B6yXbiAmuN8iv59bFGuTq7odPSQsI0EhmYm9eA=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3787.eurprd07.prod.outlook.com (52.133.7.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.13; Wed, 13 Feb 2019 13:10:52 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 13:10:52 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "acme@redhat.com" <acme@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>
Subject: Re: Suspected SPAM - Re: [PATCH 4.14 198/205] perf/core: Dont WARN()
 for impossible ring-buffer sizes
Thread-Topic: Suspected SPAM - Re: [PATCH 4.14 198/205] perf/core: Dont WARN()
 for impossible ring-buffer sizes
Thread-Index: AQHUwh2ts6Ir49zUHk2QMyWGshaphqXdtNCAgAACBAA=
Date:   Wed, 13 Feb 2019 13:10:52 +0000
Message-ID: <d15a67222b278a95488390ed4da98b8c50691aba.camel@nokia.com>
References: <20190211141827.214852402@linuxfoundation.org>
         <20190211141841.367111122@linuxfoundation.org>
         <1eb319822aa9f75f423a7790e78315e7672036b9.camel@nokia.com>
In-Reply-To: <1eb319822aa9f75f423a7790e78315e7672036b9.camel@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e96aa674-f332-4d3b-4d32-08d691b4ae37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3787;
x-ms-traffictypediagnostic: HE1PR0702MB3787:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtIRTFQUjA3MDJNQjM3ODc7MjM6TEtTMCtjR3MrSFpXd0pUSXJYNkh1amVh?=
 =?utf-8?B?Q2VUOW1zRFlpWFdFQ0xiNHlVY1Vzem85c0ptcGxTNWk0M1Z4MG9SbFBYcnFI?=
 =?utf-8?B?WDJlSzhFVU1CZTVvR05UdmtIMkp1NkdsblI2czljQmxLM0VTTjlNN2w0bGxH?=
 =?utf-8?B?alYzZEQ0OG9KU1BkQVhkeFVpVERndFpSaFE0dU82UjhMZ3RpbE5rcjlKYzhJ?=
 =?utf-8?B?K051VFNnekt3L2s5TWNJVS9DVUFFMmFvRnhZRVRreFllMGt1cmtJQitJMWds?=
 =?utf-8?B?RHJSMEZrNXJYdGdrdWRtUzNyc2tFa0lwWkNKYjhERTA1RzNCRXlwajZyT0ps?=
 =?utf-8?B?eEtacStPd3ZlREVpWjM0UGlic09qMnFGcCt5Qi9QRGJmSnk0SUlNcHBoNHdk?=
 =?utf-8?B?YVdzWUptblduNkpPajRjL1d6cjhsNE45cmhEU2tNMmpIL1RielljNUw1blhs?=
 =?utf-8?B?OS93U0JDQVNGK0pzOHVVYUdhS1BkNUlPL2lDOVFZcGY3cmU0NkFUNEVSQzFl?=
 =?utf-8?B?SVB2TXF6dm05Tzl4eWU3UEUxeGNpbUdKVURxMDVTeitwZFJGR1VKVS8vUFhs?=
 =?utf-8?B?SFFzSDZ2NzdaYlBvcmczR2hXMTVKOTU0RytwTnN2Y3QzVTRWRmhqNjZJMXQr?=
 =?utf-8?B?dW9JWHZkeVNOVElzWGo1R3RyLyt6QUlpNTk0NzZmUE5jaUZna1pMQ2FSYXlq?=
 =?utf-8?B?b3VlVUg1NHVNTDhrK21HV0p5YnlhZ1dpSUlpcUxoNDVCRm1yK0FSZGZvL2VZ?=
 =?utf-8?B?RmNWTnJ4dlFrS2FXeGY0TjhoN3VYTktSRk5HZVRMMkpYS01QZmF6aGdZazFy?=
 =?utf-8?B?aXpBdVplT2xuaWhxODZnSnorY2tNRFVpa1Z4Y2htNGVYakNraTBweW44dHhO?=
 =?utf-8?B?RTdnRDNyOTFRNWlpemFGYlpDMjI0cHF4aGtTNlZiMzRXMlcvN2tvT1d3aVZE?=
 =?utf-8?B?dDNhUENvOVFRUGlkaEtZMmdkNEhVZmNkVnhYSDlvK2t1M3U3WnJTMS9MQXhl?=
 =?utf-8?B?L1Q5ZGVrRFNtUWlDZjcwSVVoNVZJOEFOdlVtbEh5dDcwY1FyWEhMdE0yQUFt?=
 =?utf-8?B?ZU9vTzlsd0UxTHZjRnVSTUFHWjZ0VXFnQ3ZSQklSSWM4UWVPS3RDS09iNHJN?=
 =?utf-8?B?ME56T25iN2Q0OFI3eGw5OVpEQ0l0dzJYbGV1M0IvdENMUUo2T1FuMS9YcU1T?=
 =?utf-8?B?bWZwUUY3bTFKRVZOcDc3akFqRmhpVHB5Y3YxTXpDSnVHQWFmMUpmY0J4L3ZZ?=
 =?utf-8?B?MVZLRTZjQk0xSC9QSEowS3d1aFpIc25oRndwRmJjZkhkQmdCMEZWRUZSclIx?=
 =?utf-8?B?bFMwcGkreGNhMGhld1phSzNidS95TXBrdUtheW5nV0ZtSEtScWRsbmlrUXhY?=
 =?utf-8?B?aU9sNDBjU2lrL0VMTnQ0bHBhSUJteFg0UFo3MzBEMURNSlZJeFFRSE1lRFhQ?=
 =?utf-8?B?WTBQQ2Ztekp0SEhXRVVKQzBNOHVMZ1oxYU1uelp0N2I1RnhCeWlEZjNYZWx5?=
 =?utf-8?B?N1ZRTk9nWDNUczZUeThWREhmaTBTZ2c1RTVhQ3pEOVg0SWtZOFZWS1BkQ2Iv?=
 =?utf-8?B?NFl5YVpEY1crekJpSFBRb0xYOG5mejl0SkFObWZEVzZ4SWNreE9UNFdGY2p5?=
 =?utf-8?B?RDREc1c0UTVmMGFJVmxDaUhFblp4aW5JVXljWGdPSUk0MVVJZnU0UG8rWTM0?=
 =?utf-8?Q?CjbNc7mWqw1EsJn06LOsIYH96vAhNspDiwGeR0Gxj?=
x-microsoft-antispam-prvs: <HE1PR0702MB378761AECF70DA137246A2B8B4660@HE1PR0702MB3787.eurprd07.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(2906002)(11346002)(102836004)(71190400001)(186003)(66066001)(6116002)(26005)(25786009)(966005)(2616005)(71200400001)(36756003)(3846002)(446003)(486006)(14454004)(476003)(2501003)(7416002)(6306002)(76176011)(6512007)(81156014)(54906003)(6486002)(110136005)(6506007)(305945005)(99286004)(97736004)(7736002)(106356001)(6436002)(53936002)(105586002)(6246003)(86362001)(81166006)(8676002)(68736007)(478600001)(316002)(118296001)(229853002)(8936002)(256004)(14444005)(4326008)(192303002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3787;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DcmDETCi8HFRBpqU7clfHxvmB+ZDtZdBZZ9BQTJfSJualfQlDjD3n72X2KYDHlgTuwD7F3B6hHBOoeccfx7dpmF8ai7MjXLT3ozAkrOa0/Q5Al6foTe4Xq6/v7Y+YOBAnBKfR7+bX1f+cGi5H3Dn/qAQcrCxG6DMX5nXuv+2C7d1wT179Han4sWhIYPe8MatVmG6vxyXAAy+H7HRmx97upf1wRWHeL+p2i08expcmFCxFmCE1prTZfpJ7AjKTdjX0bJQEagRFIoQSU2ZwydoZygx/p4roExVHdLcE77A3T2l18sOOcHGIb1fOF0BNWH1fQ3CJUn5N91/k0KgHE2FpavquYJVwYc2IStsexrgRqRcCyQxV3uGgvXnry8htog8WibYx8w6PSqGsE3hnTR57g+h/1PQFrgcU75sUvOXi34=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D1F5B0B7B358D4B969A9306B2B6F49E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96aa674-f332-4d3b-4d32-08d691b4ae37
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 13:10:52.0743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAyLTEzIGF0IDEzOjAzICswMDAwLCBSYW50YWxhLCBUb21taSBULiAoTm9r
aWEgLSBGSS9Fc3BvbykNCndyb3RlOg0KPiBPbiBNb24sIDIwMTktMDItMTEgYXQgMTU6MTkgKzAx
MDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gPiA0LjE0LXN0YWJsZSByZXZpZXcgcGF0
Y2guICBJZiBhbnlvbmUgaGFzIGFueSBvYmplY3Rpb25zLCBwbGVhc2UgbGV0DQo+ID4gbWUga25v
dy4NCj4gPiANCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiANCj4gPiBGcm9tOiBNYXJrIFJ1
dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPg0KPiA+IA0KPiA+IGNvbW1pdCA5ZGZmMGFhOTVh
MzI0ZTI2MmZmYjAzZjQyNWQwMGU0NzUxZjMyOTRlIHVwc3RyZWFtLg0KPiA+IA0KPiA+IFRoZSBw
ZXJmIHRvb2wgdXNlcyAvcHJvYy9zeXMva2VybmVsL3BlcmZfZXZlbnRfbWxvY2tfa2IgdG8NCj4g
PiBkZXRlcm1pbmUNCj4gPiBob3cNCj4gPiBsYXJnZSBpdHMgcmluZ2J1ZmZlciBtbWFwIHNob3Vs
ZCBiZS4gVGhpcyBjYW4gYmUgY29uZmlndXJlZCB0bw0KPiA+IGFyYml0cmFyeQ0KPiA+IHZhbHVl
cywgd2hpY2ggY2FuIGJlIGxhcmdlciB0aGFuIHRoZSBtYXhpbXVtIHBvc3NpYmxlIGFsbG9jYXRp
b24NCj4gPiBmcm9tDQo+ID4ga21hbGxvYy4NCj4gPiANCj4gPiBXaGVuIHRoaXMgaXMgY29uZmln
dXJlZCB0byBhIHN1aXRhYmx5IGxhcmdlIHZhbHVlIChlLmcuIHRoYW5rcyB0bw0KPiA+IHRoZQ0K
PiA+IHBlcmYgZnV6emVyKSwgYXR0ZW1wdGluZyB0byB1c2UgcGVyZiByZWNvcmQgdHJpZ2dlcnMg
YQ0KPiA+IFdBUk5fT05fT05DRSgpDQo+ID4gaW4NCj4gPiBfX2FsbG9jX3BhZ2VzX25vZGVtYXNr
KCk6DQo+ID4gDQo+ID4gICAgV0FSTklORzogQ1BVOiAyIFBJRDogNTY2NiBhdCBtbS9wYWdlX2Fs
bG9jLmM6NDUxMQ0KPiA+IF9fYWxsb2NfcGFnZXNfbm9kZW1hc2srMHgzZjgvMHhiYzgNCj4gPiAN
Cj4gPiBMZXQncyBhdm9pZCB0aGlzIGJ5IGNoZWNraW5nIHRoYXQgdGhlIHJlcXVlc3RlZCBhbGxv
Y2F0aW9uIGlzDQo+ID4gcG9zc2libGUNCj4gPiBiZWZvcmUgY2FsbGluZyBremFsbG9jLg0KPiAN
Cj4gSGksDQo+IA0KPiBQZXJmIHRvb2wgaXMgYnJva2VuIGZvciBtZSBpbiA0LjE0Ljk5IChydW5u
aW5nIGluIHg4Nl82NCBWTSksDQo+IGJpc2VjdGlvbg0KPiBwb2ludHMgdG8gdGhpcyBwYXRjaC4N
Cg0KLi4uIGFuZCBJIHNlZSB0aGVyZSdzIGEgZml4IGF2YWlsYWJsZToNCg0KaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQvY29tbWl0Lz9p
ZD01Mjg4NzFiNDU2MDI2ZTYxMjdkOTViMWIyYmQ4ZTNhMDAzZGMxNjE0DQoNCi1Ub21taQ0KDQo+
IA0KPiANCj4gPiBSZXBvcnRlZC1ieTogSnVsaWVuIFRoaWVycnkgPGp1bGllbi50aGllcnJ5QGFy
bS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJt
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxwZXRlcnpA
aW5mcmFkZWFkLm9yZz4NCj4gPiBSZXZpZXdlZC1ieTogSnVsaWVuIFRoaWVycnkgPGp1bGllbi50
aGllcnJ5QGFybS5jb20+DQo+ID4gQ2M6IEFsZXhhbmRlciBTaGlzaGtpbiA8YWxleGFuZGVyLnNo
aXNoa2luQGxpbnV4LmludGVsLmNvbT4NCj4gPiBDYzogQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxv
IDxhY21lQHJlZGhhdC5jb20+DQo+ID4gQ2M6IEppcmkgT2xzYSA8am9sc2FAcmVkaGF0LmNvbT4N
Cj4gPiBDYzogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0K
PiA+IENjOiBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IFBldGVy
IFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4gPiBDYzogVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0K
PiA+IExpbms6IA0KPiA+IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxOTAxMTAxNDI3NDUu
MjU0OTUtMS1tYXJrLnJ1dGxhbmRAYXJtLmNvbQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEluZ28gTW9s
bmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEdyZWcgS3JvYWgtSGFy
dG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gDQo+ID4gLS0tDQo+ID4gIGtl
cm5lbC9ldmVudHMvcmluZ19idWZmZXIuYyB8ICAgIDMgKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiAtLS0gYS9rZXJuZWwvZXZlbnRzL3JpbmdfYnVm
ZmVyLmMNCj4gPiArKysgYi9rZXJuZWwvZXZlbnRzL3JpbmdfYnVmZmVyLmMNCj4gPiBAQCAtNzE5
LDYgKzcxOSw5IEBAIHN0cnVjdCByaW5nX2J1ZmZlciAqcmJfYWxsb2MoaW50IG5yX3BhZ2UNCj4g
PiAgCXNpemUgPSBzaXplb2Yoc3RydWN0IHJpbmdfYnVmZmVyKTsNCj4gPiAgCXNpemUgKz0gbnJf
cGFnZXMgKiBzaXplb2Yodm9pZCAqKTsNCj4gPiAgDQo+ID4gKwlpZiAob3JkZXJfYmFzZV8yKHNp
emUpID49IE1BWF9PUkRFUikNCj4gPiArCQlnb3RvIGZhaWw7DQo+ID4gKw0KPiA+ICAJcmIgPSBr
emFsbG9jKHNpemUsIEdGUF9LRVJORUwpOw0KPiA+ICAJaWYgKCFyYikNCj4gPiAgCQlnb3RvIGZh
aWw7DQo+ID4gDQo+ID4gDQoNCg==
