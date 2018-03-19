Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495632-2-4881639536868807327
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521495632; b=pbUtIP6mAo9q1OsAmJKZii9jlULNMa0hGVZHlcbSpt2JZK2
    /xOXpPMryZBW8FhP6g5Pts1L6eFwxht5geRKbmx63yTp6LQqGwKMSZ3NHU3VLaTe
    v4kSbyPqyA1FPb+R/uXEZYYnTa7GlueQLNVYUP4/kUtNr2SRohMi2hRuYECK8rKm
    a9SJLjAcO8/P/yW9hPCPGnevhjVbv15+47qi7AbWLcP6Duz9ZoXX7BlfvABGpOXY
    NmXsJy5HFe/BDCcZ0zRNLI/REisTDDu97dZIAX5WS+7pg/sW+60mkPdMy9au7U1M
    adYkTu+W1/ky9RN0VPLx76ysIpvQsnTr7iggQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521495632; bh=h2g3SUhbvyAo27/9JoQ5gZtrULpNt9C1OYgkdV
    z3RIc=; b=gZn/N5U/srJfbHf0jnpbFQG7EHF+zIf9fittXXmi2hE63cnf2ax/lO
    +GpW/iP633ioyxi1bPwT5+MgnjPG1PeyuyZ0uBH3twplwBNLx1JeNhinyPSjK5/k
    aori/8CUhdsPrALsKdurA4njYqNF7Pw9WotVoOw0Z9q9TzFfcMNNYIsiiikqEv9H
    YuxXXTmCgTl6QvdXPhKzYUNpg6y0AwvLZKC7tYT+ty3GPzY/Cxnb5wUcUCAiWbYJ
    JdBrhpF5mlQQ6RZVm41uWgtCN9KI8oPz5lpBuMaoeXjxUEj9xTjN16iPrTX+FLCd
    JhbsU8cZHwAnrttdIXQDyOIcD0fzSz3A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OybVXrLN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthgsredttddtjeenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudefheektdenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OybVXrLN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthgsredttddtjeenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudefheektdenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965048AbeCSVkS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:40:18 -0400
Received: from mail-by2nam01on0118.outbound.protection.outlook.com ([104.47.34.118]:14025
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965033AbeCSP7H (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 036/281] KVM: PPC: Book3S PR: Check
 copy_to/from_user return values
Thread-Topic: [PATCH AUTOSEL for 4.9 036/281] KVM: PPC: Book3S PR: Check
 copy_to/from_user return values
Thread-Index: AQHTv5shyHxM5AwZO0ul3eBaU/6I7Q==
Date: Mon, 19 Mar 2018 15:58:32 +0000
Message-ID: <20180319155742.13731-36-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:d5Uf/GhmE7Ot4jlR1+l/jneqzRE2L/LLGPM6pUBopYdHEz3L2S+7hmpUFWjP5qBFfOAFwk1DClQcuNQqwWxzG/F+ByvLywtLiHY+X0N+eDyKRr60OGhjBoPhua2lt6FtqaUoYRC+hdmPs9EsJDnVByNyFmpZeBN/x7Z72xYBEWgR4o3bD7phB5rzZ8d6CvPUYcDj2hmaOZYqlvd2d05Nc2m7Gqy7lkIHyIM+j0f3i2w/+P4CNvFo7vH3wXqeSS2z;20:Cvz6nXL2YCtwLM4d/JJtgQ4+xRBB/6SgtsaAjQ1YXS09ThcpRUTpMgKnwKMfJMcejgtg1nCZ+ZTsGn9yEutBX9AwzoIPivXsTbu1QB2ON11OanzYdKu/HFSDrveZHNgmoTGkjAUeRjPFhJ7GPkICFjciiqIJdKNuVd/mrWbjXK4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb599ae0-2ced-462c-c459-08d58db254a1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726644E518AE0FB579C5995FBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(6666003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(59450400001)(186003)(1076002)(3846002)(25786009)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: BuxszGhdppJ61AZbEW8BPh036UcjFB10Y/RcPv3/a5QSKGWoFVIKRRKkNijy11ZnhtenRxjfvE+BXs8TVddpAr4fZlcqEkv4rWXnpFKpWwves3jGb72qj8jeHudYVHeEDgemCPREfFWuewgGNNBAc2YwUyJWjbH/c9xdQlIPPd2oYTucsqNHwVngyzoqDam7wItIOlvejtbQg1aDOSnQrqlGc5K99gkN+gvLrZ04ot6hy0CrOi481t3BAuVGVWvznRch03hkltBa62eDBueFR3ShJ187iOi4UgL3xA8cpcVH/BNLQyOGaRYs3NgnCQKNKKUnSak2n1Uj4hwUYIZIQQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A8C4EF3D0E990488E4B0819A4C1BB08@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb599ae0-2ced-462c-c459-08d58db254a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:32.7644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogUGF1bCBNYWNrZXJyYXMgPHBhdWx1c0BvemxhYnMub3JnPg0KDQpbIFVwc3RyZWFtIGNv
bW1pdCA2NzMyNWU5ODhmYWVhNzM1ZDY2Mzc5OWI2ZDE1MmI1ZjQyNTQwOTNjIF0NCg0KVGhlIFBS
IEtWTSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgUEFQUiBIUFQgaHlwZXJjYWxscyAoSF9FTlRFUiBl
dGMuKQ0KYWNjZXNzIGFuIGltYWdlIG9mIHRoZSBIUFQgaW4gdXNlcnNwYWNlIG1lbW9yeSB1c2lu
ZyBjb3B5X2Zyb21fdXNlcg0KYW5kIGNvcHlfdG9fdXNlci4gIFJlY2VudGx5LCB0aGUgZGVjbGFy
YXRpb25zIG9mIHRob3NlIGZ1bmN0aW9ucyB3ZXJlDQphbm5vdGF0ZWQgdG8gaW5kaWNhdGUgdGhh
dCB0aGUgcmV0dXJuIHZhbHVlIG11c3QgYmUgY2hlY2tlZC4gIFNpbmNlDQp0aGlzIGNvZGUgZG9l
c24ndCBjdXJyZW50bHkgY2hlY2sgdGhlIHJldHVybiB2YWx1ZSwgdGhpcyBjYXVzZXMNCmNvbXBp
bGUgd2FybmluZ3MgbGlrZSB0aGUgb25lcyBzaG93biBiZWxvdywgYW5kIHNpbmNlIG9uIFBQQyB0
aGUNCmRlZmF1bHQgaXMgdG8gY29tcGlsZSBhcmNoL3Bvd2VycGMgd2l0aCAtV2Vycm9yLCB0aGlz
IGNhdXNlcyB0aGUNCmJ1aWxkIHRvIGZhaWwuDQoNClRvIGZpeCB0aGlzLCB3ZSBjaGVjayB0aGUg
cmV0dXJuIHZhbHVlcywgYW5kIGlmIG5vbi16ZXJvLCBmYWlsIHRoZQ0KaHlwZXJjYWxsIGJlaW5n
IHByb2Nlc3NlZCB3aXRoIGEgSF9GVU5DVElPTiBlcnJvciByZXR1cm4gdmFsdWUuDQpUaGVyZSBp
cyByZWFsbHkgbm8gZ29vZCBlcnJvciByZXR1cm4gdmFsdWUgdG8gdXNlIHNpbmNlIFBBUFIgZGlk
bid0DQplbnZpc2FnZSB0aGUgcG9zc2liaWxpdHkgdGhhdCB0aGUgaHlwZXJ2aXNvciBtYXkgbm90
IGJlIGFibGUgdG8gYWNjZXNzDQp0aGUgZ3Vlc3QncyBIUFQsIGFuZCBIX0ZVTkNUSU9OIChmdW5j
dGlvbiBub3Qgc3VwcG9ydGVkKSBzZWVtcyBhcw0KZ29vZCBhcyBhbnkuDQoNClRoZSB0eXBpY2Fs
IGNvbXBpbGUgd2FybmluZ3MgbG9vayBsaWtlIHRoaXM6DQoNCiAgQ0MgICAgICBhcmNoL3Bvd2Vy
cGMva3ZtL2Jvb2szc19wcl9wYXByLm8NCi9ob21lL3BhdWx1cy9rZXJuZWwva3ZtL2FyY2gvcG93
ZXJwYy9rdm0vYm9vazNzX3ByX3BhcHIuYzogSW4gZnVuY3Rpb24g4oCYa3ZtcHBjX2hfcHJfZW50
ZXLigJk6DQovaG9tZS9wYXVsdXMva2VybmVsL2t2bS9hcmNoL3Bvd2VycGMva3ZtL2Jvb2szc19w
cl9wYXByLmM6NTM6MjogZXJyb3I6IGlnbm9yaW5nIHJldHVybiB2YWx1ZSBvZiDigJhjb3B5X2Zy
b21fdXNlcuKAmSwgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUgd2Fybl91bnVzZWRfcmVzdWx0IFst
V2Vycm9yPXVudXNlZC1yZXN1bHRdDQogIGNvcHlfZnJvbV91c2VyKHB0ZWcsICh2b2lkIF9fdXNl
ciAqKXB0ZWdfYWRkciwgc2l6ZW9mKHB0ZWcpKTsNCiAgXg0KL2hvbWUvcGF1bHVzL2tlcm5lbC9r
dm0vYXJjaC9wb3dlcnBjL2t2bS9ib29rM3NfcHJfcGFwci5jOjc0OjI6IGVycm9yOiBpZ25vcmlu
ZyByZXR1cm4gdmFsdWUgb2Yg4oCYY29weV90b191c2Vy4oCZLCBkZWNsYXJlZCB3aXRoIGF0dHJp
YnV0ZSB3YXJuX3VudXNlZF9yZXN1bHQgWy1XZXJyb3I9dW51c2VkLXJlc3VsdF0NCiAgY29weV90
b191c2VyKCh2b2lkIF9fdXNlciAqKXB0ZWdfYWRkciwgaHB0ZSwgSFBURV9TSVpFKTsNCiAgXg0K
DQouLi4gZXRjLg0KDQpTaWduZWQtb2ZmLWJ5OiBQYXVsIE1hY2tlcnJhcyA8cGF1bHVzQG96bGFi
cy5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jv
c29mdC5jb20+DQotLS0NCiBhcmNoL3Bvd2VycGMva3ZtL2Jvb2szc19wcl9wYXByLmMgfCAzNCAr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDI2IGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMv
a3ZtL2Jvb2szc19wcl9wYXByLmMgYi9hcmNoL3Bvd2VycGMva3ZtL2Jvb2szc19wcl9wYXByLmMN
CmluZGV4IDAyMTc2ZmQ1MmY4NC4uMjg2YTNiMDUxZmY2IDEwMDY0NA0KLS0tIGEvYXJjaC9wb3dl
cnBjL2t2bS9ib29rM3NfcHJfcGFwci5jDQorKysgYi9hcmNoL3Bvd2VycGMva3ZtL2Jvb2szc19w
cl9wYXByLmMNCkBAIC01MCw3ICs1MCw5IEBAIHN0YXRpYyBpbnQga3ZtcHBjX2hfcHJfZW50ZXIo
c3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KIAlwdGVnX2FkZHIgPSBnZXRfcHRlZ19hZGRyKHZjcHUs
IHB0ZV9pbmRleCk7DQogDQogCW11dGV4X2xvY2soJnZjcHUtPmt2bS0+YXJjaC5ocHRfbXV0ZXgp
Ow0KLQljb3B5X2Zyb21fdXNlcihwdGVnLCAodm9pZCBfX3VzZXIgKilwdGVnX2FkZHIsIHNpemVv
ZihwdGVnKSk7DQorCXJldCA9IEhfRlVOQ1RJT047DQorCWlmIChjb3B5X2Zyb21fdXNlcihwdGVn
LCAodm9pZCBfX3VzZXIgKilwdGVnX2FkZHIsIHNpemVvZihwdGVnKSkpDQorCQlnb3RvIGRvbmU7
DQogCWhwdGUgPSBwdGVnOw0KIA0KIAlyZXQgPSBIX1BURUdfRlVMTDsNCkBAIC03MSw3ICs3Myw5
IEBAIHN0YXRpYyBpbnQga3ZtcHBjX2hfcHJfZW50ZXIoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0K
IAlocHRlWzBdID0gY3B1X3RvX2JlNjQoa3ZtcHBjX2dldF9ncHIodmNwdSwgNikpOw0KIAlocHRl
WzFdID0gY3B1X3RvX2JlNjQoa3ZtcHBjX2dldF9ncHIodmNwdSwgNykpOw0KIAlwdGVnX2FkZHIg
Kz0gaSAqIEhQVEVfU0laRTsNCi0JY29weV90b191c2VyKCh2b2lkIF9fdXNlciAqKXB0ZWdfYWRk
ciwgaHB0ZSwgSFBURV9TSVpFKTsNCisJcmV0ID0gSF9GVU5DVElPTjsNCisJaWYgKGNvcHlfdG9f
dXNlcigodm9pZCBfX3VzZXIgKilwdGVnX2FkZHIsIGhwdGUsIEhQVEVfU0laRSkpDQorCQlnb3Rv
IGRvbmU7DQogCWt2bXBwY19zZXRfZ3ByKHZjcHUsIDQsIHB0ZV9pbmRleCB8IGkpOw0KIAlyZXQg
PSBIX1NVQ0NFU1M7DQogDQpAQCAtOTMsNyArOTcsOSBAQCBzdGF0aWMgaW50IGt2bXBwY19oX3By
X3JlbW92ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQogDQogCXB0ZWcgPSBnZXRfcHRlZ19hZGRy
KHZjcHUsIHB0ZV9pbmRleCk7DQogCW11dGV4X2xvY2soJnZjcHUtPmt2bS0+YXJjaC5ocHRfbXV0
ZXgpOw0KLQljb3B5X2Zyb21fdXNlcihwdGUsICh2b2lkIF9fdXNlciAqKXB0ZWcsIHNpemVvZihw
dGUpKTsNCisJcmV0ID0gSF9GVU5DVElPTjsNCisJaWYgKGNvcHlfZnJvbV91c2VyKHB0ZSwgKHZv
aWQgX191c2VyICopcHRlZywgc2l6ZW9mKHB0ZSkpKQ0KKwkJZ290byBkb25lOw0KIAlwdGVbMF0g
PSBiZTY0X3RvX2NwdSgoX19mb3JjZSBfX2JlNjQpcHRlWzBdKTsNCiAJcHRlWzFdID0gYmU2NF90
b19jcHUoKF9fZm9yY2UgX19iZTY0KXB0ZVsxXSk7DQogDQpAQCAtMTAzLDcgKzEwOSw5IEBAIHN0
YXRpYyBpbnQga3ZtcHBjX2hfcHJfcmVtb3ZlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCiAJICAg
ICgoZmxhZ3MgJiBIX0FORENPTkQpICYmIChwdGVbMF0gJiBhdnBuKSAhPSAwKSkNCiAJCWdvdG8g
ZG9uZTsNCiANCi0JY29weV90b191c2VyKCh2b2lkIF9fdXNlciAqKXB0ZWcsICZ2LCBzaXplb2Yo
dikpOw0KKwlyZXQgPSBIX0ZVTkNUSU9OOw0KKwlpZiAoY29weV90b191c2VyKCh2b2lkIF9fdXNl
ciAqKXB0ZWcsICZ2LCBzaXplb2YodikpKQ0KKwkJZ290byBkb25lOw0KIA0KIAlyYiA9IGNvbXB1
dGVfdGxiaWVfcmIocHRlWzBdLCBwdGVbMV0sIHB0ZV9pbmRleCk7DQogCXZjcHUtPmFyY2gubW11
LnRsYmllKHZjcHUsIHJiLCByYiAmIDEgPyB0cnVlIDogZmFsc2UpOw0KQEAgLTE3MSw3ICsxNzks
MTAgQEAgc3RhdGljIGludCBrdm1wcGNfaF9wcl9idWxrX3JlbW92ZShzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUpDQogCQl9DQogDQogCQlwdGVnID0gZ2V0X3B0ZWdfYWRkcih2Y3B1LCB0c2ggJiBIX0JV
TEtfUkVNT1ZFX1BURVgpOw0KLQkJY29weV9mcm9tX3VzZXIocHRlLCAodm9pZCBfX3VzZXIgKilw
dGVnLCBzaXplb2YocHRlKSk7DQorCQlpZiAoY29weV9mcm9tX3VzZXIocHRlLCAodm9pZCBfX3Vz
ZXIgKilwdGVnLCBzaXplb2YocHRlKSkpIHsNCisJCQlyZXQgPSBIX0ZVTkNUSU9OOw0KKwkJCWJy
ZWFrOw0KKwkJfQ0KIAkJcHRlWzBdID0gYmU2NF90b19jcHUoKF9fZm9yY2UgX19iZTY0KXB0ZVsw
XSk7DQogCQlwdGVbMV0gPSBiZTY0X3RvX2NwdSgoX19mb3JjZSBfX2JlNjQpcHRlWzFdKTsNCiAN
CkBAIC0xODQsNyArMTk1LDEwIEBAIHN0YXRpYyBpbnQga3ZtcHBjX2hfcHJfYnVsa19yZW1vdmUo
c3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KIAkJCXRzaCB8PSBIX0JVTEtfUkVNT1ZFX05PVF9GT1VO
RDsNCiAJCX0gZWxzZSB7DQogCQkJLyogU3BsYXQgdGhlIHB0ZWcgaW4gKHVzZXJsYW5kKSBocHQg
Ki8NCi0JCQljb3B5X3RvX3VzZXIoKHZvaWQgX191c2VyICopcHRlZywgJnYsIHNpemVvZih2KSk7
DQorCQkJaWYgKGNvcHlfdG9fdXNlcigodm9pZCBfX3VzZXIgKilwdGVnLCAmdiwgc2l6ZW9mKHYp
KSkgew0KKwkJCQlyZXQgPSBIX0ZVTkNUSU9OOw0KKwkJCQlicmVhazsNCisJCQl9DQogDQogCQkJ
cmIgPSBjb21wdXRlX3RsYmllX3JiKHB0ZVswXSwgcHRlWzFdLA0KIAkJCQkJICAgICAgdHNoICYg
SF9CVUxLX1JFTU9WRV9QVEVYKTsNCkBAIC0yMTEsNyArMjI1LDkgQEAgc3RhdGljIGludCBrdm1w
cGNfaF9wcl9wcm90ZWN0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCiANCiAJcHRlZyA9IGdldF9w
dGVnX2FkZHIodmNwdSwgcHRlX2luZGV4KTsNCiAJbXV0ZXhfbG9jaygmdmNwdS0+a3ZtLT5hcmNo
LmhwdF9tdXRleCk7DQotCWNvcHlfZnJvbV91c2VyKHB0ZSwgKHZvaWQgX191c2VyICopcHRlZywg
c2l6ZW9mKHB0ZSkpOw0KKwlyZXQgPSBIX0ZVTkNUSU9OOw0KKwlpZiAoY29weV9mcm9tX3VzZXIo
cHRlLCAodm9pZCBfX3VzZXIgKilwdGVnLCBzaXplb2YocHRlKSkpDQorCQlnb3RvIGRvbmU7DQog
CXB0ZVswXSA9IGJlNjRfdG9fY3B1KChfX2ZvcmNlIF9fYmU2NClwdGVbMF0pOw0KIAlwdGVbMV0g
PSBiZTY0X3RvX2NwdSgoX19mb3JjZSBfX2JlNjQpcHRlWzFdKTsNCiANCkBAIC0yMzQsNyArMjUw
LDkgQEAgc3RhdGljIGludCBrdm1wcGNfaF9wcl9wcm90ZWN0KHN0cnVjdCBrdm1fdmNwdSAqdmNw
dSkNCiAJdmNwdS0+YXJjaC5tbXUudGxiaWUodmNwdSwgcmIsIHJiICYgMSA/IHRydWUgOiBmYWxz
ZSk7DQogCXB0ZVswXSA9IChfX2ZvcmNlIHU2NCljcHVfdG9fYmU2NChwdGVbMF0pOw0KIAlwdGVb
MV0gPSAoX19mb3JjZSB1NjQpY3B1X3RvX2JlNjQocHRlWzFdKTsNCi0JY29weV90b191c2VyKCh2
b2lkIF9fdXNlciAqKXB0ZWcsIHB0ZSwgc2l6ZW9mKHB0ZSkpOw0KKwlyZXQgPSBIX0ZVTkNUSU9O
Ow0KKwlpZiAoY29weV90b191c2VyKCh2b2lkIF9fdXNlciAqKXB0ZWcsIHB0ZSwgc2l6ZW9mKHB0
ZSkpKQ0KKwkJZ290byBkb25lOw0KIAlyZXQgPSBIX1NVQ0NFU1M7DQogDQogIGRvbmU6DQotLSAN
CjIuMTQuMQ0K
