Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AIpwx48jFhg0nGXL3q1CO47II1Uan/8EX/gMfO9+8mlDISIBdALK9ILCI+DHMQjCW5acS0uvLBRE
ARC-Seal: i=1; a=rsa-sha256; t=1523467577; cv=none;
        d=google.com; s=arc-20160816;
        b=htxPIwOtBJ9mHAUBaz0zbOSuxR7rYgY3USPTpRn12K37+E658OiXpN25+I8ForvyWP
         5w3pzcgFDnGQA0rv7txqfxuNpUDWtrs3UG0Y9I/jVbRg6mRiSgX6RX8ujUiY0ZZgt3if
         eMkA8YijBB7AhomORv7WRWsoqt5OWRHoHSlAzMz59h9KlSyIcRR5QPb+s5Cez0fHmtKD
         /gufiji0kH44r/0/t1wETmQBYxr1UlMIpiu3Nkq2PiEXaFrXyU7ny3Cq79PfEjVVxL0p
         Pue+No586IVw/O6Oh0cD6efo/N9yS4jE9EWwdS5wAD4VFeAvFTf2HRmM6kKNMY2GqopC
         vpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=zKq40VOqHjHhQosuitfVe5pIjCkkIee0d+0I4Dy0LaI=;
        b=gjXpODSB83hLSZywgSLsa5nH2gdNlSbhUltkhbatIVlxL++FUMIiUEAOiEkE6FUfGW
         Fr2mk5WTJhP9Iv/8S37K8k+5WX+NN+n7MBMDB6KM6IQehZY1ZPw1deTCwzs5cqrVmjKp
         wYDyre51KLD32rBuxSA8/s//s2BipP0JRL6MjwLPEJTufYXq/DCXMXSlWo2NKkfwbD8d
         mlDUwFzWAOz6pjp464Hf/ARmXLmUuPIirTvdaOlsur8FajKlvuiktJAyvi3H7ZjDVtWO
         P8pXu77z4xdddE/x/GV7+04cxXU0OJ3rDn3/XAsNBRVFmkIzXB2483p5Q6cwYbMBPoSs
         sHEg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=Oj0Q6HPj;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=M74YnBwA;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=Oj0Q6HPj;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=M74YnBwA;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.48,437,1517846400";
   d="scan'208";a="76406373"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@fb.com" <shli@fb.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "00moses.alexander00@gmail.com"
	<00moses.alexander00@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Thread-Topic: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Thread-Index: AQHTzlpM3bNaKsvglEqiCkNE5lEW0KP5AjIAgAJcawCAAEUegIAAAmyAgAAE1ACAAAFugIAAAXEAgAAdtwCAAATdAIAAAccAgAACggCAAALxAA==
Date: Wed, 11 Apr 2018 17:26:12 +0000
Message-ID: <6cd1d285f726f81186dbab57c3308cc0b257ff99.camel@wdc.com>
References: <20180409220938.GI3126663@devbig577.frc2.facebook.com>
	 <20180411101242.GA2322@gmail.com>
	 <20180411142019.GG793541@devbig577.frc2.facebook.com>
	 <20180411142859.GB2322@gmail.com>
	 <20180411144616.GI793541@devbig577.frc2.facebook.com>
	 <20180411145123.GJ793541@devbig577.frc2.facebook.com>
	 <20180411145632.GK793541@devbig577.frc2.facebook.com>
	 <bd60302129cb89bdc3b4f402ce4e061f41851729.camel@wdc.com>
	 <20180411170018.GL793541@devbig577.frc2.facebook.com>
	 <398bad36e2f01e37645a36d052d62136766ee88d.camel@wdc.com>
	 <20180411171538.GN793541@devbig577.frc2.facebook.com>
In-Reply-To: <20180411171538.GN793541@devbig577.frc2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [50.225.201.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0319;7:Xtu3YKzmZ7khKDkDZ+y0E+T5TIfu/u8YrxcrLg9iNAcG/Xl52+/tIG/E8Y2Wv5WSZFO33a6qIoFFeyjFr+d7A7gQNMUJ96e6EULX0XEPC7tWvqePYCOlxQlMrFzOJEVXpa3UYJ0hfv88CrF3/DOHv8bUNh+gCkNC8txk7Ld22C80N3hShYn3lrIWLiPCI6SF3YUUd4hhN5PdkFhhtUQWy6sSXduMFqh9Vlc3tqPZiJqFLX7ssW2xU5TQVS2qU6eB;20:Lfw6K9N90fkBDUbDwcNt4Pa8rnciTh4tZJSeNm4AU0Odj9ozHhlsZNxWSU3Ualwa+5f328HKkzyx62x24khoAKJ7L6hESPI6+GLo2YC2wxxISQCUcN8JpQnM2QG7tRalbo2vTUbB09Xt4nk56tgUIVPAFL6WwQq8HBpM2jkn3v8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0319;
x-ms-traffictypediagnostic: MWHPR04MB0319:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0319AD929B92235717C4319D98BD0@MWHPR04MB0319.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB0319;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0319;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(39860400002)(39380400002)(199004)(189003)(377424004)(72206003)(99286004)(54906003)(2906002)(93886005)(11346002)(446003)(106356001)(2351001)(36756003)(476003)(66066001)(2616005)(6116002)(3846002)(26005)(102836004)(2501003)(76176011)(486006)(5250100002)(14454004)(316002)(3280700002)(3660700001)(478600001)(6506007)(186003)(59450400001)(86362001)(81156014)(4326008)(1730700003)(25786009)(8676002)(81166006)(8936002)(105586002)(6246003)(39060400002)(68736007)(6512007)(5660300001)(53936002)(5640700003)(7736002)(97736004)(2900100001)(6436002)(7416002)(305945005)(118296001)(6486002)(229853002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0319;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Op2R9DmJu5KXEhSSoamwi/pcfTd47keW7z1YrXYPRF8qlJgQMbghzTl3FFg4+ylD67pCHIR3grYGileMlcYw/CSk0UF+7O70sw5J7HdM2R2TGm647eM7K/SqKdGn5L4kD545F/UUCDu7tG6svaD8kyU3q6otyR5vrcLLQk/3NSMlZlF3guq0tBWGLOn2ee/At91xg5OvZrPotBbmYqHWiZMDERqQzfDfBslYOMIWaK7KJt3Odp5wWAbexCy3IYWSqFbYlE7n9mnJ9yiPCh+6OyZYfOuSxzvRc1GgkPMlJ7h2s3d1/+p2Ivhi/qBPTs6NqqPvHWexvuaFVjm6hfJuvAYkf1r8Ckghf+4X7CaRor00mFzZwIRONkvV7jcB94YpH8MgQhRjBwEcu+WFAVfafaLlZgcJ0vhwOvLwQTcNBac=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A129DD37128048479467A594EF4ECEF3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 413b08e2-23b8-4a62-c25c-08d59fd1526f
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413b08e2-23b8-4a62-c25c-08d59fd1526f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 17:26:12.0642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0319
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597471538443775072?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTExIGF0IDEwOjE1IC0wNzAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBPbiBXZWQsIEFwciAxMSwgMjAxOCBhdCAwNTowNjo0MVBNICswMDAwLCBCYXJ0IFZhbiBBc3Nj
aGUgd3JvdGU6DQo+ID4gQSBzaW1wbGUgYW5kIGVmZmVjdGl2ZSBzb2x1dGlvbiBpcyB0byBkaXNz
b2NpYXRlIGEgcmVxdWVzdCBxdWV1ZSBmcm9tIHRoZQ0KPiA+IGJsb2NrIGNncm91cCBjb250cm9s
bGVyIGJlZm9yZSBibGtfY2xlYW51cF9xdWV1ZSgpIHJldHVybnMuIFRoaXMgaXMgd2h5IGNvbW1p
dA0KPiA+IGEwNjMwNTdkN2M3MyAoImJsb2NrOiBGaXggYSByYWNlIGJldHdlZW4gcmVxdWVzdCBx
dWV1ZSByZW1vdmFsIGFuZCB0aGUgYmxvY2sNCj4gPiBjZ3JvdXAgY29udHJvbGxlciIpIG1vdmVk
IHRoZSBibGtjZ19leGl0X3F1ZXVlKCkgY2FsbCBmcm9tIF9fYmxrX3JlbGVhc2VfcXVldWUoKQ0K
PiA+IGludG8gYmxrX2NsZWFudXBfcXVldWUoKS4NCj4gDQo+IHdoaWNoIGlzIGJyb2tlbi4gIFdl
IGNhbiB0cnkgdG8gc3dpdGNoIHRoZSBsaWZldGltZSBtb2RlbCB0byByZXZva2luZw0KPiBhbGwg
bGl2ZSBvYmplY3RzIGJ1dCB0aGF0IGxpa2VseSBpcyBhIGxvdCBtb3JlIGludm9sdmluZyB0aGFu
IGJsaW5kbHkNCj4gbW92aW5nIGJsa2cgc2hvb3Rkb3duIGZyb20gcmVsZWFzZSB0byBjbGVhbnVw
LiAgSW1wbGVtZW50aW5nIHNldmVyDQo+IHNlbWFudGljcyBpcyB1c3VhbGx5IGEgbG90IG1vcmUg
aW52b2x2ZWQgLyBmcmFnaWxlIGJlY2F1c2UgaXQgcmVxdWlyZXMNCj4gZXhwbGljaXQgcGFydGlj
aXBhdGlvbiBmcm9tIGFsbCB1c2VycyAoZXhhY3RseSB0aGUgc2FtZSB3YXkgcmV2b2tpbmcNCj4g
LT5xdWV1ZV9sb2NrIGlzIGRpZmZpY3VsdCkuDQo+IA0KPiBJJ20gbm90IG5lY2Vzc2FyaWx5IGFn
YWluc3Qgc3dpdGNoaW5nIHRvIHNldmVyIG1vZGVsLCBidXQgd2hhdCB0aGUNCj4gcGF0Y2ggZGlk
IGlzbid0IHRoYXQuICBJdCBqdXN0IG1vdmVkIHNvbWUgY29kZSB3aXRob3V0IGFjdHVhbGx5DQo+
IHVuZGVyc3RhbmRpbmcgb3IgYXVkaXRpbmcgd2hhdCB0aGUgaW1wbGljYXRpb25zIGFyZS4NCg0K
SGVsbG8gVGVqdW4sDQoNClBsZWFzZSBleHBsYWluIHdoYXQgeW91IHdyb3RlIGZ1cnRoZXIuIEl0
J3Mgbm90IGNsZWFyIHRvIG1lIHdoeSB5b3UgdGhpbmsNCnRoYXQgYW55dGhpbmcgaXMgYnJva2Vu
IG5vciB3aGF0IGEgInNldmVyIG1vZGVsIiBpcy4NCg0KSSB0aGluayB3ZSByZWFsbHkgbmVlZCB0
aGUgYmxrY2dfZXhpdF9xdWV1ZSgpIGNhbGwgaW4gYmxrX2NsZWFudXBfcXVldWUoKQ0KdG8gYXZv
aWQgcmFjZSBjb25kaXRpb25zIGJldHdlZW4gcmVxdWVzdCBxdWV1ZSBjbGVhbnVwIGFuZCB0aGUg
YmxvY2sgY2dyb3VwDQpjb250cm9sbGVyLiBBZGRpdGlvbmFsbHksIHNpbmNlIGl0IGlzIGd1YXJh
bnRlZWQgdGhhdCBubyBuZXcgcmVxdWVzdHMgd2lsbA0KYmUgc3VibWl0dGVkIHRvIGEgcXVldWUg
YWZ0ZXIgaXQgaGFzIGJlZW4gbWFya2VkIGRlYWQgSSBkb24ndCBzZWUgd2h5IGl0DQp3b3VsZCBt
YWtlIHNlbnNlIHRvIGtlZXAgdGhlIGFzc29jaWF0aW9uIGJldHdlZW4gYSByZXF1ZXN0IHF1ZXVl
IGFuZCB0aGUNCmJsa2NnIGNvbnRyb2xsZXIgdW50aWwgdGhlIGxhc3QgcmVmZXJlbmNlIG9uIGEg
cXVldWUgaXMgZHJvcHBlZC4NCg0KQmFydC4NCg0KDQoNCg==
