Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480759-2-2445852270334134149
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
    t=1521480758; b=kVfa+gpJhw6rE3ZgdQogWgmyAxrAXq61c/YYuLNlZs5eEm5
    crZsHjqzdtVbaHzO6nJVpbFJpNuMxM/3Qycxz+SmSwD+/UEZzUeiZbvcOpcxW559
    Qzv6erzSUUFGB8yV1RqQ1V0JLxCMJ8wLIe2n7XBRmxvWV1cuEdayjRJCAruMTVMh
    eK+REbv4vDfBebB+U2O2zwS3+xZq7D2MQt3lVfJbYfHQ/fbVeIv9nrP5XGrI1kKd
    WApz8mGIjYLjkAzBAamJQ+Kz8W3PAMq+61n2IvbQHGcyfMe0esLMx5+3EZ+bhBic
    HHQxjltbQXxQ8B2Xpuy6EqgcGQpw0bpF4QQ+2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521480758; bh=cphkncD1lcgj4EdgHsrcp+s+Q9ohWmAVPhrzM0
    4hkak=; b=wYZl28bkdHaZ/uXY1haD6haiV+u7A5B2h8Ef1GlBW24N24AoOJgxfE
    aQEdqcR9Q3VpoW7PvA9e3sW/Q37c9hOGgF0g2gH7lnUcNlZKLlnWcYB4uB8C7UVN
    8w8hD/8wLQKRYqcH5+h3IxAyvHKglkdAURiisaUt37HFBKO9twls3PErUCRKtOyW
    SxfIWFhBiy3fK2udMCTWHR6T/zWmVgxQQ1cS8+QzmfyJs/m6XqaKx37HIWjYQuvb
    2j4mOrAtzXacPzAKbPER3vGX2pwMhEr0uLouvMOUw0izFveV2meFf5QCRfoJLdWa
    OdvX4HE/ojChb0pD/NHL2dYiPSf4eMZg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dntMHbZ4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthgsredttddtjeenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudefheejudenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dntMHbZ4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthgsredttddtjeenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudefheejudenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967469AbeCSRbP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:31:15 -0400
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:10656
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966052AbeCSQHC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 027/167] KVM: PPC: Book3S PR: Check
 copy_to/from_user return values
Thread-Topic: [PATCH AUTOSEL for 4.4 027/167] KVM: PPC: Book3S PR: Check
 copy_to/from_user return values
Thread-Index: AQHTv5wpMByh9Oar+Em1ELT2zWO8HA==
Date: Mon, 19 Mar 2018 16:05:55 +0000
Message-ID: <20180319160513.16384-27-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:oF9M93M0z6ci/5Sl4L6sH7JtrQiCkpsFNvyyWDWOmDjxa0//YDvke9bNzxX8JvLkdVsewVSulunLxsPelZNr0iwOqFBnYM6IzfxhAmffxxT0WAox/ikmvs/QqfdgRuBup2vBLjsdVGcVMiBKOpYLVb3qG9hMpZWy2viM7lp5eL/I/QtN6OgY4nmMadGKx474naogqI0Zz9NDTQXmb/xYhDrV/BHYw4wca16hvxPyA10ZU0HKnTgxRjiDy8qirwz6;20:mGls0Xzsx0pPqRqe13shwOS6fn5HTBYVRANMWJvUeQkdqwddg52l9eVrzaMwDef6q6pjc0s1Tlxw31WGzy1YWhblP1EKVWmfflEDGzTE8CYBogZJsqAj5cNA2ZarHEbK66DYX9meXQKrbl/bIaJ1yORDfxW1owDBxLym2PWfHqo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11d932ae-b8f9-4090-1285-08d58db36ee2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1093028581FE4AF7CAEFA485FBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(76176011)(107886003)(2950100002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(59450400001)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 1GSCDDSrn9WHCg3MucsXQR0dgjqnBp+GnRa7S8iGwcbMynNRoPumCM26gWNb52bfXrzySn1Zfn+iTaPNdJ8x7Ht9GS+2LvGjcN0jMTgPYCcCgC+Er30Ths7dq7Nzo2w72fKJ53kzH3z8gEA3QaOIrnakuL3UBwAwZTx+Hwy/AQqfIXbHk++vp3C5kDZTnAPbhov4L9GZ1EN2QyWXsf5gfdtqjJAMKmK5mUwg+9OUgtQS/cb5nP5Otfv59rKoelhBV7J/DWy9A5eVuYIHX8gzM4qkP0KJp3K94WLZjAcLfUM6OdZme3tKvFtq7F7rgcX39obURzaIHGYabmTij/uzWw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <481BD3AF026A154487788908322A7C57@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d932ae-b8f9-4090-1285-08d58db36ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:55.0556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
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
CmluZGV4IGYyYzc1YTFlMDUzNi4uMGQ5MWJhZjYzZmVkIDEwMDY0NA0KLS0tIGEvYXJjaC9wb3dl
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
