Return-Path: <SRS0=WxbV=F4=wdc.com=prvs=59601bb56=Bart.VanAssche@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-961214-1520358785-2-17770762746667758933
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=WxbV=F4=wdc.com=prvs=59601bb56=Bart.VanAssche@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520358784; b=ZRzFiCpOJ4Yz0SdkK9uOIgYAh5J3wuRG6GRg2KTRVk+P4NU
    x1nGlarBltzfJmff+555gfPCE1m809r51SShEbmTsHwiclPlIqkqy0Zs1ce8E6iu
    LRUjwDeDhnzXgs+wcc+Gf36HuY//oojp/5Lt0IhslkHIhjbXpcfsIaVhO+BDXtj7
    ooCi7fajlCjv95+ONo/qtXGxkwXF+tR1HTynY48O5sm6SjlmVQzy4GLdMbI483c1
    TtzsETG8MLSBg6QSEXy8QGv3mSLfjCGq4oAxAR+evtCTypjpkZUyw7rs0Yapzzdw
    moL8H+Yb5jkLHyMSXkFcJrnRZejr1Dg7Qy9TUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version; s=arctest; t=
    1520358784; bh=xw2qh60FoQYKNBL1IVzd6FGyRIHEr2XBkuEcwa2HLsc=; b=f
    juUZ4yctK476ylaCk+MoghjTq+oHwnhgrFusqA91nNlcFO2/hN5gnGXLNyehceiI
    IKOUAajyKn7ios1dIgvHQKUWVbtDgwBzB5mkzI0M9bs3Nwg7dEUe8KannbVIXzGG
    IwMu5rQtE2OKC8ukt8zSKGLwuUaaPO2M4WtDGLYGp2ctkhdVAAkOwpT4nus0OItW
    l8XPrgKFsOUSzwAke1mIKOv32SPTSPC/1t0N9TGMu1nzx8FxPUqoL3R9KRO8lL9e
    PYz9F7Mkr7SZWb01oq8ly8Cq3bSjxU8AIZq86sI5lzoL8uV0a63Ryc+mUfOBDMBS
    rKYp+84FTqPi4qpVr5jUA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FDg6mEXi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=pass (2048-bit rsa key sha256) header.d=wdc.com header.i=@wdc.com header.b=egVu1bm6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=WxbV=F4=wdc.com=prvs=59601bb56=Bart.VanAssche@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FDg6mEXi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=pass (2048-bit rsa key sha256) header.d=wdc.com header.i=@wdc.com header.b=egVu1bm6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=WxbV=F4=wdc.com=prvs=59601bb56=Bart.VanAssche@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568D42133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=prvs=59601bb56=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.47,432,1515427200";
   d="scan'208";a="73564556"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"tj@kernel.org" <tj@kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "jannh@google.com" <jannh@google.com>,
	"paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "bcrl@kvack.org"
	<bcrl@kvack.org>, "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
CC: "security@kernel.org" <security@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: Re: [PATCH 5/7] block: Remove superflous rcu_read_[un]lock_sched() in
 blk_queue_enter()
Thread-Topic: [PATCH 5/7] block: Remove superflous rcu_read_[un]lock_sched()
 in blk_queue_enter()
Thread-Index: AQHTtXF+r00ELC+QgkOKRsA7lcNfRKPDfP6A
Date: Tue, 6 Mar 2018 17:52:50 +0000
Message-ID: <1520358769.3578.21.camel@wdc.com>
References: <20180306172657.3060270-1-tj@kernel.org>
	 <20180306173316.3088458-1-tj@kernel.org>
	 <20180306173316.3088458-5-tj@kernel.org>
In-Reply-To: <20180306173316.3088458-5-tj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0879;7:UcVLUKcZFLEdUMpmEGTCmIZITVJDqtvZcPnMOvFTSavmNrVX7L847u4PIBoJa4UuYIWfXvK8qwX/MgCUBHKOSk0eMK1jJVX6AX3dV2KSmTwkLGUR27PRmEm+8qOT0qM+hbcsTSPOPYp0XgiQaWkMBpjcgwskSl6KkLMn8Q15LToR21c4XQ1ElRmt/2Mro/b/pnWUzTiLfzNRjTAWF8kT6e8pDPbK5FXTWaNvLqWpvXTlMsYaJAeW4zoelppZkO2e;20:Ozw/W9gQu/iCjvuGjnd84zaGTPp7trW45tLsJivH9YClALXNoZQuNVdN5m1gNmYQ7uz+8s/d+zvRDpUYUsvjsDNo6/KmHNTOrD2m2hOu0r2WzlOFrE7K9La4M2YhP/5bIUoD41q6oIrWzp+BYX2QnYOM97rX1GDuiJuKa5viY8M=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e34b2b4d-d0b0-4723-ceb5-08d5838b14a2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0879;
x-ms-traffictypediagnostic: MWHPR04MB0879:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB08798FBAF37854CF46E39F6B98D90@MWHPR04MB0879.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0879;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0879;
x-forefront-prvs: 06036BD506
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(346002)(39380400002)(39860400002)(199004)(189003)(377424004)(11905935001)(76176011)(66066001)(59450400001)(39060400002)(97736004)(6116002)(3660700001)(3846002)(4326008)(68736007)(103116003)(2950100002)(6486002)(229853002)(25786009)(105586002)(106356001)(6436002)(6246003)(81166006)(8936002)(81156014)(8676002)(7416002)(7736002)(5250100002)(2900100001)(478600001)(6306002)(53936002)(26005)(36756003)(6512007)(72206003)(305945005)(2201001)(14454004)(110136005)(2501003)(54906003)(186003)(6506007)(102836004)(316002)(86362001)(575784001)(3280700002)(2906002)(99286004)(5660300001)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0879;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: +zfCpHej57w0hVytJRBJEPM1sBws0kYR1OlZVAxI2asiIzq7Z00/hth1s6BA3Doe4g9VqbFSU2DvzY3crPBZPzYOpQOkkKNQecyuT8SbjxLxqQHVM13kLD6dQedL+HbY5NpJexP7P0sxT4Xf294GayLqIT3EDgGfXuyKrTa1Kl4zDEss1sMUhB+XahnGgN5e0Oxf1bTyNtGk1v1B02qMLQo7inxS74S+1bsulgooTBilnKeEU+bRFf2O0Zlbdkh+ZpIZ0gLtLBgzh0SAJf/p44cm6N1D6I5F6VI/i0FGW7et6MPNntv+fKmJ6siBaWDN8t1iVeKm8YuisfeusJv38g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F629C51ED064AB4A961816A0F1609F30@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34b2b4d-d0b0-4723-ceb5-08d5838b14a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 17:52:51.0356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0879
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVHVlLCAyMDE4LTAzLTA2IGF0IDA5OjMzIC0wODAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IDNh
MGE1Mjk5NzFlYyAoImJsb2NrLCBzY3NpOiBNYWtlIFNDU0kgcXVpZXNjZSBhbmQgcmVzdW1lIHdv
cmsNCj4gcmVsaWFibHkiKSBhZGRlZCByY3VfcmVhZF9bdW5dbG9ja19zY2hlZCgpIHRvIGJsa19x
dWV1ZV9lbnRlcigpIGFsb25nDQo+IHdpdGggb3RoZXIgY2hhbmdlcyBidXQgaXQgZG9lc24ndCBz
ZWVtIHRvIGJlIGRvaW5nIGFueXRoaW5nLg0KPiANCj4gYmxrX3F1ZXVlX2VudGVyKCkgaXMgY2Fs
bGVkIHdpdGggQHEgLSB0aGUgcG9pbnRlciB0byB0aGUgdGFyZ2V0DQo+IHJlcXVlc3RfcXVldWUs
IHNvIHRoZSBjYWxsZXIgb2J2aW91c2x5IGhhcyB0byBndWFyYW50ZWUgdGhhdCBAcSBjYW4gYmUN
Cj4gZGVyZWZlcmVuY2VkLCBhbmQgaW5zaWRlIHRoZSBSQ1Utc2NoZWQgcHJvdGVjdGVkIGFyZWEs
IHRoZXJlJ3Mgbm90aGluZw0KPiB3aGljaCBuZWVkcyBmdXJ0aGVyIHByb3RlY3Rpb24uDQo+IA0K
PiBMZXQncyByZW1vdmUgdGhlIHN1cGVyZmxvdXMgcmN1X3JlYWRfW3VuXWxvY2tfc2NoZWQoKS4N
Cj4gDQo+IFsgLi4uIF0NCj4NCj4gVGhpcyBjYW1lIHVwIHdoaWxlIGF1ZGl0aW5nIHBlcmNwdV9y
ZWYgdXNlcnMgZm9yIHByb2JsZW1hdGljIFJDVQ0KPiB1c2FnZXMuICBJIGNvdWxkbid0IHVuZGVy
c3RhbmQgd2hhdCB0aGUgUkNVIHByb3RlY3Rpb24gd2FzIGRvaW5nLg0KPiBJdCdkIGJlIGdyZWF0
IGlmIHlvdSBjYW4gdGFrZSBhIGxvb2sgYW5kIHRlbGwgbWUgd2hldGhlciBJIG1pc3NlZA0KPiBz
b21ldGhpbmcuDQoNCkhlbGxvIFRlanVuLA0KDQpJIHRoaW5rIHRoZSByY3VfcmVhZF9sb2NrKCkg
YW5kIHJjdV9yZWFkX3VubG9jaygpIGFyZSByZWFsbHkgbmVjZXNzYXJ5IGluIHRoaXMNCmNvZGUu
IEluIHRoZSBMV04gYXJ0aWNsZSAiVGhlIFJDVS1iYXJyaWVyIG1lbmFnZXJpZSIgaXQgaXMgZXhw
bGFpbmVkIHRoYXQgUkNVDQpjYW4gYmUgdXNlZCB0byBlbmZvcmNlIHdyaXRlIG9yZGVyaW5nIGds
b2JhbGx5IGlmIHRoZSBjb2RlIHRoYXQgcmVhZHMgdGhlIHdyaXRlcw0KdGhhdCBhcmUgb3JkZXJl
ZCB3aXRoIGFuIFJDVSByZWFkIGxvY2sgKGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy81NzM0OTcv
KS4gU2VlDQphbHNvIHRoZSBmb2xsb3dpbmcgY29tbWVudCBpbiBzY3NpX2RldmljZV9xdWllc2Nl
KCk6DQoNCgkvKg0KCSAqIEVuc3VyZSB0aGF0IHRoZSBlZmZlY3Qgb2YgYmxrX3NldF9wcmVlbXB0
X29ubHkoKSB3aWxsIGJlIHZpc2libGUNCgkgKiBmb3IgcGVyY3B1X3JlZl90cnlnZXQoKSBjYWxs
ZXJzIHRoYXQgb2NjdXIgYWZ0ZXIgdGhlIHF1ZXVlDQoJICogdW5mcmVlemUgZXZlbiBpZiB0aGUg
cXVldWUgd2FzIGFscmVhZHkgZnJvemVuIGJlZm9yZSB0aGlzIGZ1bmN0aW9uDQoJICogd2FzIGNh
bGxlZC4gU2VlIGFsc28gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzU3MzQ5Ny8uDQoJICovDQoN
ClNpbmNlIHRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIHN1YnRsZSBhbmQgaGFyZCB0byBkZWJ1ZyBy
YWNlIGNvbmRpdGlvbiwgcGxlYXNlDQpkcm9wIHRoaXMgcGF0Y2guDQoNClRoYW5rcywNCg0KQmFy
dC4NCg0KDQo=
