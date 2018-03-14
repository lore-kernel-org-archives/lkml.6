Return-Path: <SRS0=mXP0=GE=wdc.com=prvs=6043d9405=Bart.VanAssche@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2529736-1521058460-2-17918677880452898816
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
    t=1521058459; b=jmbm2X6qKU+MFCPmcFke2UA6P4vUyCzeH0f3IcCb64Lzzbj
    HYGuQoowulLkVGZsPp7G+X6D5oQkeWjGWHsnlF8n/zWmMgJCKs0LjWR7nVACEIYL
    RP9gBhx6w3Jrktuf+sunBE6/2PdlIfbq01TE7OvR9zbjPsaySCha8haLDxjES4HR
    +8ntX8s6ZrHnB3MYvPfrOEbUo761uKK9VGUpZ5E0TZKhQdTxxjOZe0GLGUqWYddH
    6XcZLfpfNkZANjrwpU0Y+L99ZQ5v8PjeJO79oCbXaJg/zw4XsV8b0o2h5DA8dl+g
    OrKSQybyxnQ2jTpYoJsDphVH5Aq5LD0a20aisrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version; s=arctest; t=
    1521058459; bh=lltDlpbWSwZ631so6Wp282mgoNFZOsMYoCnpD8gE1QY=; b=m
    mVVBlCzxAFlo/eEtvhspJuYqoIVqEEabcuHhS9d3khc+l0B/v21pcsUUFXKkf3Y3
    09k1+rlAuFDZL5o8ug4yODi/9ZGgrDVTftE7qaNNlDQl+Qwp5asyjHVH2VasUCg1
    TmW/3XceWkdwTpL+krBz5ChscvsM6ay3gwKplH/c8iLvKr7csF8ZrXZGmCgm3wLL
    HXM6ScsFs7Lw4OrNA1jv9bfgxE1OwP6x9EAbL4g5Ngt6GGecJ9Fq6ekHhI282YLJ
    4SRZadMBeDHqm500yK9/ibr3/x8R+gK6mHSoh/3PsY+JsS7rQNzBdptqNC22mdVj
    SZWFAF7VREruplDofyCFg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KvbWWDF5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=pass (2048-bit rsa key sha256) header.d=wdc.com header.i=@wdc.com header.b=FYzSamJH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
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
    dkim=pass (1024-bit rsa key sha256) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KvbWWDF5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=pass (2048-bit rsa key sha256) header.d=wdc.com header.i=@wdc.com header.b=FYzSamJH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=mXP0=GE=wdc.com=prvs=6043d9405=Bart.VanAssche@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9765120779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=prvs=6043d9405=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.48,306,1517846400";
   d="scan'208";a="73663265"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "peterz@infradead.org" <peterz@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jannh@google.com" <jannh@google.com>, "bcrl@kvack.org" <bcrl@kvack.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>, "kent.overstreet@gmail.com"
	<kent.overstreet@gmail.com>, "security@kernel.org" <security@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
	"tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH 5/7] block: Remove superflous rcu_read_[un]lock_sched() in
 blk_queue_enter()
Thread-Topic: [PATCH 5/7] block: Remove superflous rcu_read_[un]lock_sched()
 in blk_queue_enter()
Thread-Index: AQHTtXF+r00ELC+QgkOKRsA7lcNfRKPDfP6AgAyhrgCAABYKgIAAAOsAgAABgAA=
Date: Wed, 14 Mar 2018 20:14:09 +0000
Message-ID: <1521058448.3006.32.camel@wdc.com>
References: <20180306172657.3060270-1-tj@kernel.org>
	 <20180306173316.3088458-1-tj@kernel.org>
	 <20180306173316.3088458-5-tj@kernel.org> <1520358769.3578.21.camel@wdc.com>
	 <20180314184636.GC2943022@devbig577.frc2.facebook.com>
	 <1521057929.3006.31.camel@wdc.com>
	 <20180314200846.GR4064@hirez.programming.kicks-ass.net>
In-Reply-To: <20180314200846.GR4064@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0463;7:CZzQHt9c+IXIRHN9SteVNSIjE2TB/AnhWH7AGyOr9kH4Ub2IpdwLQ5Clgmov7soNFtnbAI5Y2WyJ9xCQxTj2NdYEp+Dt94ZyF2CI45t1IRevGSqCtHqlZ9gVWJ/ro0AoCnWa1OuZY+R89jvEm18WXsQPTDCiLFoswD7eXkPLp1iOi5huSJI4wbxKMVdYlDHbFT0G/bp5Q8RnitEdE3zrvEjasEOuKbQHfrrCQvAcxNsvWrBHAMS+kIohRrrnPwZU;20:roMpvL6WMHzG4bfE1eufc9fS6/cq9T5KmaxpGJN4b4ncFLnMo8KkzJtYM4FEW8+TeFQAg3qRYafpG8dRUxCfdd45Tt4JipUJVaS4sQCqUAdOPR+Taj3nZuEIUyP2I2XlSUHCwGZPcPqzeqx0BZ+WTPHH9mWCWBNWOFQiK/bungw=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6a1f85d-745e-4c1f-dc20-08d589e825a5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0463;
x-ms-traffictypediagnostic: MWHPR04MB0463:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB046359077CC784EB66A64B9E98D10@MWHPR04MB0463.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR04MB0463;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0463;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(39380400002)(376002)(346002)(51914003)(377424004)(199004)(189003)(186003)(8676002)(2501003)(53936002)(76176011)(93886005)(2950100002)(3660700001)(229853002)(316002)(105586002)(6916009)(5250100002)(68736007)(478600001)(2900100001)(5660300001)(72206003)(3280700002)(7416002)(14454004)(99286004)(26005)(86362001)(7736002)(6436002)(5640700003)(2351001)(305945005)(97736004)(36756003)(4326008)(6246003)(39060400002)(6486002)(54906003)(66066001)(6116002)(3846002)(81156014)(1730700003)(8936002)(81166006)(6506007)(103116003)(106356001)(102836004)(2906002)(6512007)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0463;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 7GrJwF75DZIOkklFBn9U7j0h8T9bAYv2r0kcTcIWNI5mahWg8myY0ZW856SKuQeFuxJMdHfyo/CqqyP8UTIvgYWEtC58/EwIR1nqF/f/1qwcS1nFOMom95Utt/KQPe/6N048LZlxeVCwjbjpMuUYZFAHF5L25086rWlCdlzvzIaPe7esylcAVqijLn0l+7hKSouPHQocg5kqtynwUunIyCMynAqX1yfF/1vGReg6BZ3KBDZby9c0cW8yXmQFP2UGtQemy9O9tbVcMYLFMTtBE8S/mBkaXSdzGQZIom4KeEiY5I5MYwm4ciNHfx5A2TGB/7hLtMH+sWw1QnwnvqpZnw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BF306CA1E382F43A59B4E23C4C2FC81@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a1f85d-745e-4c1f-dc20-08d589e825a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 20:14:09.8744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0463
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gV2VkLCAyMDE4LTAzLTE0IGF0IDIxOjA4ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gV2VkLCBNYXIgMTQsIDIwMTggYXQgMDg6MDU6MzBQTSArMDAwMCwgQmFydCBWYW4gQXNz
Y2hlIHdyb3RlOg0KPiA+IENhbiB5b3UgY2xhcmlmeSB0aGlzIGZ1cnRoZXI/IEZyb20gPGxpbnV4
L3JjdXBkYXRlLmg+Og0KPiA+IA0KPiA+IHN0YXRpYyBpbmxpbmUgdm9pZCBzeW5jaHJvbml6ZV9y
Y3Uodm9pZCkNCj4gPiB7DQo+ID4gCXN5bmNocm9uaXplX3NjaGVkKCk7DQo+ID4gfQ0KPiANCj4g
WW91J2xsIGZpbmQgdGhhdCBpcyBmb3IgIUNPTkZJR19QUkVFTVBUX1JDVS4NCg0KVGhhbmtzIGZv
ciB0aGUgY2xhcmlmaWNhdGlvbi4gSSB3aWxsIHN1Ym1pdCBhIGZpeCBmb3IgdGhlIFNDU0kgY29k
ZS4NCg0KQmFydC4NCg0KDQo=
