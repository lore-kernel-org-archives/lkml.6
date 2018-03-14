Return-Path: <SRS0=mXP0=GE=wdc.com=prvs=6043d9405=Bart.VanAssche@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2529736-1521057939-2-2973828004260499229
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=mXP0=GE=wdc.com=prvs=6043d9405=Bart.VanAssche@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521057938; b=dXb2X/j5yAezflLzFyhooL8upEGQcHBODNicbHdkNOodifQ
    ngUIVpCLtBRzLWuH6WDkhToWot4TvbUbwZ637FlUBn8illtvNEI3A4h+Omo+bxEy
    KRWnYYX0Wu67TeIx1Xm4BM+X+pcwqCDbJAC92SdIs7GgsmtsR1qjSlLpepdfvZwO
    UEg8eIGLPgePVMI7FmM0WCpQsfFjLIo/5Jj7PJnQcRvTYaAlPunSey4JOkRIXmRC
    MS7Xj5KzFc8DlR/lyhgsTF/8cbUcx7HH4hmRoPar27dIKFVntBFTIVwnl+pbRilz
    qPethLNS9UWJhMIE2+xzkQ/qZ4qudOHvTNDfJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version; s=arctest; t=
    1521057938; bh=X29Yc4yPMgQpxXB7cTKleOavrzu9sGsaC/lci+ADni4=; b=r
    wcEIdaxPDbVkZydk4D949hvmkT9R+ixQ8AS8MzWFQfpM0CXb6AUR6+KDqg0xvYhQ
    GFKUPh8yLSCrFggstwwpTjsqiczS7smKsz94uTaHnGYk9Xg4Qj5Y5NsCu68BjE9h
    P/xAIcKrFkisSm/8Luy7mmrXHC0+Kz13aVGkfw/uaEtSeE09/D8MuLnGSfcLIXkM
    337SLq77KZAeq5woyXmS3orfotaCzN2e7yIuRtIci67yGx6h54wNKd+qMRfz+zyW
    b2LkI+IGl9/kDvDDSDl41Y7/CPGM/PUl11LkZ/EVBaQP+1B94WqIsPnNel0SaPQj
    ymOntuDMLbPriDpyCLwaA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eXw674RS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=pass (2048-bit rsa key sha256) header.d=wdc.com header.i=@wdc.com header.b=n6SJVSCR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=mXP0=GE=wdc.com=prvs=6043d9405=Bart.VanAssche@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eXw674RS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=pass (2048-bit rsa key sha256) header.d=wdc.com header.i=@wdc.com header.b=n6SJVSCR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=mXP0=GE=wdc.com=prvs=6043d9405=Bart.VanAssche@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AC82077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=prvs=6043d9405=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.48,306,1517846400";
   d="scan'208";a="73662668"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jannh@google.com" <jannh@google.com>, "bcrl@kvack.org" <bcrl@kvack.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>, "security@kernel.org"
	<security@kernel.org>, "kent.overstreet@gmail.com"
	<kent.overstreet@gmail.com>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/7] block: Remove superflous rcu_read_[un]lock_sched() in
 blk_queue_enter()
Thread-Topic: [PATCH 5/7] block: Remove superflous rcu_read_[un]lock_sched()
 in blk_queue_enter()
Thread-Index: AQHTtXF+r00ELC+QgkOKRsA7lcNfRKPDfP6AgAyhrgCAABYKgA==
Date: Wed, 14 Mar 2018 20:05:30 +0000
Message-ID: <1521057929.3006.31.camel@wdc.com>
References: <20180306172657.3060270-1-tj@kernel.org>
	 <20180306173316.3088458-1-tj@kernel.org>
	 <20180306173316.3088458-5-tj@kernel.org> <1520358769.3578.21.camel@wdc.com>
	 <20180314184636.GC2943022@devbig577.frc2.facebook.com>
In-Reply-To: <20180314184636.GC2943022@devbig577.frc2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0814;7:7NaUqigds1LoobPwaX/01A6GVoHLJaEskckLOBRaBVgW2TIWhedYSccGbvW0cMpMcd4g7/ldtwgPWd8+abdfKezJ0yg0o2zu3xfbhRf1LlXX8pIWUhZmYxO220BmpEX96lIUgrxReS90KhF/vckG8nf2bPAupvpAKgHosoXJvV0gl5Wkef4PCJ+qYDnlq8eoxkjYGlmsbH04ZeqkwIBdJ3m2D00jc1cd/6Qd4DrrGDLEUG2xJd/hCWlPKb5NQXDT;20:2e3ZnQPWLHbVGY7Fqadsch2O/snZRcPvCH1dcRvkI224B87tHpd1Il0jgzhgirgRl+5tlQqb3HGY6oE4HxpRaUbj7Dgl5wRCBwWsNKDPmj8edyjyOhZC8VV19ey1H9QH/Otw4Rz3EA5MdJrpO7KgoCun7XlDExYrF5gzZ68BNhU=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6442ae94-7a87-40a3-41cd-08d589e6eff1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0814;
x-ms-traffictypediagnostic: MWHPR04MB0814:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0814F833678C9061417C402298D10@MWHPR04MB0814.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR04MB0814;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0814;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39860400002)(346002)(11905935001)(199004)(189003)(377424004)(1730700003)(105586002)(68736007)(8676002)(3846002)(7736002)(305945005)(478600001)(2351001)(6246003)(8936002)(6512007)(6306002)(6436002)(81166006)(316002)(81156014)(106356001)(54906003)(5640700003)(72206003)(5250100002)(2900100001)(229853002)(2501003)(14454004)(53936002)(2950100002)(2906002)(66066001)(36756003)(5660300001)(86362001)(966005)(7416002)(6506007)(76176011)(6486002)(93886005)(99286004)(3280700002)(6116002)(97736004)(103116003)(59450400001)(3660700001)(102836004)(4326008)(186003)(25786009)(6916009)(26005)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0814;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: St0a6686diJA2h7Bm4GFAqt7iZMsRYiiad8F8hsy5Lk+RYy4YOLzkUktxqtvAgYnJg2YQnoLiw2YEhBuCF0HWH76lzk273BNpmXhpW7Cu5DR8TA/CW3ktNVoCh1Vzh9uy8O8uG8lZjQN81tlJPTtWpEsPVh40Z2HEwqmHEaL5fD11wvUWxKJzIa9qIeJEUxBdy9VNvViWWAKc3LAc6Ph5/w9nzqjmI37bkh3uUs+j20Su2ZkbvYDMHjFEG9u7IYKz6U9ya/nPGJLvoxV/okOZ2PqFbfUQCnw2ljpcJGQiahob9PqqtZbRoMFIoB6rc0CmzZ1sVAZHuFZroegl8X8zw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7960294D653B24B88A183BE7B31A1EB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6442ae94-7a87-40a3-41cd-08d589e6eff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 20:05:30.2279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0814
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gV2VkLCAyMDE4LTAzLTE0IGF0IDExOjQ2IC0wNzAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiA+IHRoYXQgYXJlIG9yZGVyZWQgd2l0aCBhbiBSQ1UgcmVhZCBsb2NrIChodHRwczovL2x3bi5u
ZXQvQXJ0aWNsZXMvNTczNDk3LykuIFNlZQ0KPiA+IGFsc28gdGhlIGZvbGxvd2luZyBjb21tZW50
IGluIHNjc2lfZGV2aWNlX3F1aWVzY2UoKToNCj4gPiANCj4gPiAJLyoNCj4gPiAJICogRW5zdXJl
IHRoYXQgdGhlIGVmZmVjdCBvZiBibGtfc2V0X3ByZWVtcHRfb25seSgpIHdpbGwgYmUgdmlzaWJs
ZQ0KPiA+IAkgKiBmb3IgcGVyY3B1X3JlZl90cnlnZXQoKSBjYWxsZXJzIHRoYXQgb2NjdXIgYWZ0
ZXIgdGhlIHF1ZXVlDQo+ID4gCSAqIHVuZnJlZXplIGV2ZW4gaWYgdGhlIHF1ZXVlIHdhcyBhbHJl
YWR5IGZyb3plbiBiZWZvcmUgdGhpcyBmdW5jdGlvbg0KPiA+IAkgKiB3YXMgY2FsbGVkLiBTZWUg
YWxzbyBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvNTczNDk3Ly4NCj4gPiAJICovDQo+ID4gDQo+
ID4gU2luY2UgdGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgc3VidGxlIGFuZCBoYXJkIHRvIGRlYnVn
IHJhY2UgY29uZGl0aW9uLCBwbGVhc2UNCj4gPiBkcm9wIHRoaXMgcGF0Y2guDQo+IA0KPiBIYWgs
IHRoZSBwYWlyaW5nIGlzIGJldHdlZW4gc2NzaV9kZXZpY2VfcXVpZXNjZSgpIGFuZA0KPiBibGtf
cXVldWVfZW50ZXIoKT8gIEJ1dCB0aGF0IGRvZXNuJ3QgbWFrZSBzZW5zZSBlaXRoZXIgYmVjYXVz
ZQ0KPiBzY3NpX2RldmljZV9xdWllc2NlKCkgaXMgZG9pbmcgcmVndWxhciBzeW5jaHJvbml6ZV9y
Y3UoKSBhbmQNCj4gYmxrX3F1ZXVlX2VudGVyKCkgaXMgZG9pbmcgcmN1X3JlYWRfbG9ja19zY2hl
ZCgpLiAgVGhleSBkb24ndA0KPiBpbnRlcmxvY2sgd2l0aCBlYWNoIG90aGVyIGluIGFueSB3YXku
DQoNCkNhbiB5b3UgY2xhcmlmeSB0aGlzIGZ1cnRoZXI/IEZyb20gPGxpbnV4L3JjdXBkYXRlLmg+
Og0KDQpzdGF0aWMgaW5saW5lIHZvaWQgc3luY2hyb25pemVfcmN1KHZvaWQpDQp7DQoJc3luY2hy
b25pemVfc2NoZWQoKTsNCn0NCg0KPiBTbywgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvIGhlcmUgd291
bGQgYmUgc29tZWhvdyBtb3ZpbmcgdGhlIFJDVQ0KPiBzeW5jaHJvbml6YXRpb24gaW50byBibGtf
c2V0X3ByZWVtcHRfb25seSgpIGFuZCBzd2l0Y2hpbmcgdG8gcmVndWxhcg0KPiBSQ1UgcHJvdGVj
dGlvbiBpbiBibGtfcXVldWVfZW50ZXIoKS4gIFRoZSBjb2RlIGFzLWlzIGlzbid0IHJlYWxseQ0K
PiBkb2luZyBhbnl0aGluZy4NCg0KU2luY2UgdGhlIFJDVSBwcm90ZWN0aW9uIGluIGJsa19xdWV1
ZV9lbnRlcigpIHN1cnJvdW5kcyBhIHBlcmNwdV9yZWZfdHJ5Z2V0X2xpdmUoKQ0KY2FsbCBhbmQg
c2luY2UgcGVyY3B1X3JlZl90cnlnZXRfbGl2ZSgpIGNhbGxzIHJjdV9yZWFkX2xvY2svdW5sb2Nr
X3NjaGVkKCkgaXRzZWxmDQpJIGRvbid0IHRoaW5rIHRoYXQgaXQgaXMgYWxsb3dlZCB0byBzd2l0
Y2ggdG8gcmVndWxhciBSQ1UgcHJvdGVjdGlvbiBpbg0KYmxrX3F1ZXVlX2VudGVyKCkgd2l0aG91
dCBtb2RpZnlpbmcgdGhlIFJDVSBpbXBsZW1lbnRhdGlvbi4NCg0KQmFydC4NCg0KDQo=
