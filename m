Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497840-2-965898855511047691
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
    t=1521497840; b=FUwME1GNCGCFN01m8aYmY+FvKrabrcizfL2xz3WXpR+bHkz
    KoZ/zqQ/yA6cR0jjRt7dX0C2oDK2y+O/FzR+vmnAVRl30M2luY2J6eDHoYs04mdn
    2PJz9Ki0RF4lZbBu/unGNVgt+om/M3Mct7SlB2kQsAwPu/+aBmVfizSTHffTOpq0
    6vwJvjWn/KH56DyqsTrlbY7teSHLtXE8OUmHc7ebIqmj3LVDJvtB8lYiVN/Sy6S5
    ApoNDssI2LCY7NnXDUumuX9nI7/Ytk2x1ZuakOsVgsmsCSu+pqrMPyrHr+Jk0ZJ4
    Xb0HTTry+CcatkcFlfjjTofxiT0RPs7LoHm+X0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521497840; bh=A0TcJZyUXzZRiljV1xE1wuQIGTnvPnKiYvOVhQ
    UJxLo=; b=gLItUw1wFriMk66EbrVdAbuoB439YWrab0u4TlLR3tZC4fWPeZa+/R
    b9M7DPezQjFPikoDzDdQk0768K6XOFnc5ihIuAOkhIBwljQzWjJwZpGGGdJbO0b3
    2iqrgR8LBk0j8aULmWPOH/3UiWFRmsm+YtC/9qdPFGMvIBb/3dMfEwz2CBmjCAqA
    +4fuoDBzVrvfK9yRzLHuYS0cfAgVQTwKbG8FP8un1vSlIWBYnHIo/O7zBS33Iat9
    Er2WBVkde5+9LVg4F8mt/yMg4VetvbsIM0/MG+qLnZkOD1JZHZEBXIiKBaOpptnp
    wX6xkOybDQ1k3klgGcM4GPzkFJ2Jm3ig==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B/EuLGZC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelgeelgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B/EuLGZC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelgeelgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933962AbeCSPts (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:49:48 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:20557
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933855AbeCSPtk (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Paolo Valente <paolo.valente@linaro.org>,
        Davide Ferrari <davideferrari8@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 093/124] block, bfq: put async queues for
 root bfq groups too
Thread-Topic: [PATCH AUTOSEL for 4.15 093/124] block, bfq: put async queues
 for root bfq groups too
Thread-Index: AQHTv5nCLkWSTRGPYUOHds/U6G1Fgw==
Date: Mon, 19 Mar 2018 15:48:44 +0000
Message-ID: <20180319154645.11350-93-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:DU/S8+y2gvvZHUAsK9GhDcwR7p6elC1/71bsUu/+RqMXt7NQyYxSBH5mNj3jAdjY5VcTwgN0KfqbOKwwv/zCYbLpMgzDkvm6swaTdH4h4i8BA/BMl8y+hUUJzWcjd+bXUb+r+0ZErN8av9yAbExEMnlvhRTZBQ9ZBZP/caigTg7NFv20jgB6oe0rh6GdyG68oEmj39XU0BswnNadQUG2nKwK64ULOpMBBVr7X9PJzekMhKSbmFKUjg2FAiRHYW4V;20:8909PVRT5S7yMZSeMWlGiGuTM2y6zJdRGyFsBj28N3IkfVeyzdTNs/mOaZrFeLTtXU9PUBNRdMqFDbm5JX0UrGyCC8tutL/kODYKuNt94tUphLgyMExdCY4ggnZPHeeKECfNmuRbTA7sEBUMnZdoPm8BHfh1lEsHdT16vuS/uAo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db45fdb3-1bf2-4007-4540-08d58db10532
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09813C7849D579A0CE171F73FBD40@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(39380400002)(189003)(199004)(66066001)(6486002)(26005)(110136005)(5660300001)(54906003)(3280700002)(6512007)(68736007)(102836004)(6436002)(107886003)(10290500003)(53936002)(186003)(59450400001)(72206003)(14454004)(36756003)(6666003)(2950100002)(316002)(6506007)(22452003)(478600001)(10090500001)(106356001)(105586002)(99286004)(7736002)(3660700001)(86362001)(76176011)(305945005)(86612001)(2501003)(97736004)(5250100002)(39060400002)(4326008)(3846002)(6116002)(1076002)(8936002)(25786009)(81156014)(81166006)(8676002)(2900100001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: nBwPtQtGcmwwebESax6zQHsA6n4t8Jbi6isIg8hFsexPRO3GrbnMZVInScZDVg8GAS03Wp3twFO0NWOZoKDPuhDw73Wcz+ipNedvmRlz197TXe1LEnIvekH3sk/UuH14ndK+zD9KfLPUO59c9ljyJXPVGLHYwRLTmnB1VewaTorehk5XgkXNOtADxj1y6azaRwdsbBEhPDUQjgcIe2yIZXVCIbJTkJ2usAc5ByjN5cA/pXOSV7kITDFh6rNH0N8MV2H4ZalOG+g3kdR2ExMHIk3FD7jgZp7vkYrd4tf3xsJ7E1FhavOw9gDBthixPmpzZIJbhNyNiCSHdbBliUqCHA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <70CA0F2D4A74EB4CAED18D1B31C8472B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db45fdb3-1bf2-4007-4540-08d58db10532
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:44.0915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogUGFvbG8gVmFsZW50ZSA8cGFvbG8udmFsZW50ZUBsaW5hcm8ub3JnPg0KDQpbIFVwc3Ry
ZWFtIGNvbW1pdCA1MjI1N2ZmYmZjYWY1OGQyNDdiMTNmYjE0OGUyN2VkMTdjMzNlNTI2IF0NCg0K
Rm9yIGVhY2ggcGFpciBbZGV2aWNlIGZvciB3aGljaCBiZnEgaXMgc2VsZWN0ZWQgYXMgSS9PIHNj
aGVkdWxlciwNCmdyb3VwIGluIGJsa2lvL2lvXSwgYmZxIG1haW50YWlucyBhIGNvcnJlc3BvbmRp
bmcgYmZxIGdyb3VwLiBFYWNoIHN1Y2gNCmJmcSBncm91cCBjb250YWlucyBhIHNldCBvZiBhc3lu
YyBxdWV1ZXMsIHdpdGggZWFjaCBhc3luYyBxdWV1ZQ0KY3JlYXRlZCBvbiBkZW1hbmQsIGkuZS4s
IHdoZW4gc29tZSBJL08gcmVxdWVzdCBhcnJpdmVzIGZvciBpdC4gIE9uDQpjcmVhdGlvbiwgYW4g
YXN5bmMgcXVldWUgZ2V0cyBhbiBleHRyYSByZWZlcmVuY2UsIHRvIG1ha2Ugc3VyZSB0aGF0DQp0
aGUgcXVldWUgaXMgbm90IGZyZWVkIGFzIGxvbmcgYXMgaXRzIGJmcSBncm91cCBleGlzdHMuICBB
Y2NvcmRpbmdseSwNCnRvIGFsbG93IHRoZSBxdWV1ZSB0byBiZSBmcmVlZCBhZnRlciB0aGUgZ3Jv
dXAgZXhpdGVkLCB0aGlzIGV4dHJhDQpyZWZlcmVuY2UgbXVzdCByZWxlYXNlZCBvbiBncm91cCBl
eGl0Lg0KDQpUaGUgYWJvdmUgaG9sZHMgYWxzbyBmb3IgYSBiZnEgcm9vdCBncm91cCwgaS5lLiwg
Zm9yIHRoZSBiZnEgZ3JvdXANCmNvcnJlc3BvbmRpbmcgdG8gdGhlIHJvb3QgYmxraW8vaW8gcm9v
dCBmb3IgYSBnaXZlbiBkZXZpY2UuIFlldCwgYnkNCm1pc3Rha2UsIHRoZSByZWZlcmVuY2VzIHRv
IHRoZSBleGlzdGluZyBhc3luYyBxdWV1ZXMgb2YgYSByb290IGdyb3VwDQphcmUgbm90IHJlbGVh
c2VkIHdoZW4gdGhlIGxhdHRlciBleGl0cy4gVGhpcyBjYXVzZXMgYSBtZW1vcnkgbGVhayB3aGVu
DQp0aGUgaW5zdGFuY2Ugb2YgYmZxIGZvciBhIGdpdmVuIGRldmljZSBleGl0cy4gSW4gYSBzaW1p
bGFyIHZlaW4sDQpiZnFnX3N0YXRzX3hmZXJfZGVhZCBpcyBub3QgZXhlY3V0ZWQgZm9yIGEgcm9v
dCBncm91cC4NCg0KVGhpcyBjb21taXQgZml4ZXMgYmZxX3BkX29mZmxpbmUgc28gdGhhdCB0aGUg
bGF0dGVyIGV4ZWN1dGVzIHRoZSBhYm92ZQ0KbWlzc2luZyBvcGVyYXRpb25zIGZvciBhIHJvb3Qg
Z3JvdXAgdG9vLg0KDQpSZXBvcnRlZC1ieTogSG9sZ2VyIEhvZmZzdMOkdHRlIDxob2xnZXJAYXBw
bGllZC1hc3luY2hyb255LmNvbT4NClJlcG9ydGVkLWJ5OiBHdW9xaW5nIEppYW5nIDxncWppYW5n
QHN1c2UuY29tPg0KVGVzdGVkLWJ5OiBIb2xnZXIgSG9mZnN0w6R0dGUgPGhvbGdlckBhcHBsaWVk
LWFzeW5jaHJvbnkuY29tPg0KU2lnbmVkLW9mZi1ieTogRGF2aWRlIEZlcnJhcmkgPGRhdmlkZWZl
cnJhcmk4QGdtYWlsLmNvbT4NClNpZ25lZC1vZmYtYnk6IFBhb2xvIFZhbGVudGUgPHBhb2xvLnZh
bGVudGVAbGluYXJvLm9yZz4NClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5l
bC5kaz4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9z
b2Z0LmNvbT4NCi0tLQ0KIGJsb2NrL2JmcS1jZ3JvdXAuYyB8IDcgKysrKystLQ0KIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9i
bG9jay9iZnEtY2dyb3VwLmMgYi9ibG9jay9iZnEtY2dyb3VwLmMNCmluZGV4IGRhMTUyNWVjNGM4
Ny4uZDgxOWRjNzdmZTY1IDEwMDY0NA0KLS0tIGEvYmxvY2svYmZxLWNncm91cC5jDQorKysgYi9i
bG9jay9iZnEtY2dyb3VwLmMNCkBAIC03NzUsMTAgKzc3NSwxMSBAQCBzdGF0aWMgdm9pZCBiZnFf
cGRfb2ZmbGluZShzdHJ1Y3QgYmxrZ19wb2xpY3lfZGF0YSAqcGQpDQogCXVuc2lnbmVkIGxvbmcg
ZmxhZ3M7DQogCWludCBpOw0KIA0KKwlzcGluX2xvY2tfaXJxc2F2ZSgmYmZxZC0+bG9jaywgZmxh
Z3MpOw0KKw0KIAlpZiAoIWVudGl0eSkgLyogcm9vdCBncm91cCAqLw0KLQkJcmV0dXJuOw0KKwkJ
Z290byBwdXRfYXN5bmNfcXVldWVzOw0KIA0KLQlzcGluX2xvY2tfaXJxc2F2ZSgmYmZxZC0+bG9j
aywgZmxhZ3MpOw0KIAkvKg0KIAkgKiBFbXB0eSBhbGwgc2VydmljZV90cmVlcyBiZWxvbmdpbmcg
dG8gdGhpcyBncm91cCBiZWZvcmUNCiAJICogZGVhY3RpdmF0aW5nIHRoZSBncm91cCBpdHNlbGYu
DQpAQCAtODA5LDYgKzgxMCw4IEBAIHN0YXRpYyB2b2lkIGJmcV9wZF9vZmZsaW5lKHN0cnVjdCBi
bGtnX3BvbGljeV9kYXRhICpwZCkNCiAJfQ0KIA0KIAlfX2JmcV9kZWFjdGl2YXRlX2VudGl0eShl
bnRpdHksIGZhbHNlKTsNCisNCitwdXRfYXN5bmNfcXVldWVzOg0KIAliZnFfcHV0X2FzeW5jX3F1
ZXVlcyhiZnFkLCBiZnFnKTsNCiANCiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYmZxZC0+bG9j
aywgZmxhZ3MpOw0KLS0gDQoyLjE0LjENCg==
