Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480619-2-3635369363786007023
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
    t=1521480618; b=TmZ2oQaMwTMdAjLo1ERJIemVZRD/pyyZKGwiMWfxGIbz4XH
    TOCGr0NxWrv5/7kTG6GRPck+UIiQK+o++ecAMrKygvb1Cx7Eu0PztR2k8+ZWW3uh
    glmsUbdNB9SbM6REdIWa6nRygVcpewG/MqS8jwudAlaNuKAXJE1oeRKLyicHpqks
    NCNq4otFuX4cgboXyqhLjzTIX/oSXfC2fOl8pDxqVCoeDHC3AFxV2qmMWefBlo+D
    3ayGbMChEO4BNL2WSrnR1a+PjwCS7mPEaIt0IIxZDGK61mT6hFAjEC8aHGssMRz2
    P9dV9xh+ZgZZYJtYCngU/QhlOx2e7q6Qaw7ClXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521480618; bh=2fMBjduaNwS1dixY1EdOJCyKB49SvkCbzYK1Vw
    FN7EU=; b=PrE3OKd4Ojbm84DqMVGXq4zvn2kiHyBl9MwDIkdODH/hJ5hl8y7NQi
    llzncBfHXmNsIvVes/uofAY9MQlZzh+ka1mRzcWDayur5atnEhjJDBwdqmYDjoyG
    iNK4ac7RZhsnNxf7iftZGrpVcoGn+dVwNMiDII4xzRiG2rMtyBrbFKBYUyoSj7ME
    6e1ujCGkqH9TuuurFhgHs0lGdAlh6rXDSbY9EQxri+g83AuORzOwSk3+UW1MNZRo
    ELstcFyxvKKq9ozfrKREzRgxKy4aq478vQTkVbefffan05h+XxblOnSjs4b7v1jM
    xOyKwOHlihpkLXtOlx9O3pl3/BmgeXmQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lUGaM8hS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekleejfeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lUGaM8hS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekleejfeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966106AbeCSQHF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:07:05 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:28800
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966053AbeCSQGt (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jim Baxter <jim_baxter@mentor.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 012/167] net: cdc_ncm: Fix TX zero padding
Thread-Topic: [PATCH AUTOSEL for 4.4 012/167] net: cdc_ncm: Fix TX zero
 padding
Thread-Index: AQHTv5wdkMNQEd9JR0Kzw1YyFieQKA==
Date: Mon, 19 Mar 2018 16:05:35 +0000
Message-ID: <20180319160513.16384-12-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:P+3swLfDiAopt6X/atEg551ZfObY4Xc73bFV1300jd605YdxSi+LcA2MRfGEZOliyPProR53TDE0W5rmkVh8KRTy+gc9NmJGrRQDEOykKihoEH7kPwuN1WbYN8k8TlRpxtv2MWz29M9XpMIX0KynSXasbsR+iWxrUrKxqV5T/y/WbCx74NM5hWAcLPx5DdwP2A75iQ0D0oUeXps47ILH4BOa6252cIZ3ECEwfJeLAz/MTZPxR8bGKkeMl8Gs55Z4;20:qEJ2y+8uLmEbTv/0pVH5/swBVfppimc7nFjUX1HjdFUz8gpm5TXRG9T1w3Gc9MNQVY1NAKqXuKw30OSR3Q9qa6ql9P0O62+zzgyB8e/fX02GC2PDVzFp6iT6W95u305HsCjI5ZCJDR9L5fCTBhjDPwNbTg7CQZdQyAtyANORtbI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83b4aa66-cd9d-48f5-d2bb-08d58db369b4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920CF5192B6D977B990FF6EFBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 7yNlOxbv1wvnxOnkJcZoJ9lBXDyhjvLLG8ep0DnIDCqzHKqJhCPdhWjLvjDkpq8lVNnQJx//fPLzXtS7CqHT3xB4s+rhXYRFqg80N29NlqC+RrJGKvWegr2zYgIdcr9J+6W/gXoqUJ8gJsR+jX1WdBR4tc+u3sO4aM3uxMJ6rPwAzBijqz1OlprXDtaffHv9oXAPO72k5EZCIsaYPlBr+U6ZMhqOYgRquW99ElDEhSXvTATuw0d7JovsApzsuk114UJZ+YQ3he5ADaBX99cmM+MUakYrX9j6FBUa8nqN5TAJNG9u5zygDZZ3w9sWfiYWjy/XvGHyctE3YeFPooXJtg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A431187389D3134C99C3F4ADFE9881D1@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b4aa66-cd9d-48f5-d2bb-08d58db369b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:35.2085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSmltIEJheHRlciA8amltX2JheHRlckBtZW50b3IuY29tPg0KDQpbIFVwc3RyZWFtIGNv
bW1pdCBhZWNhM2E3N2IxZTBlZDA2YTA5NTkzM2I4OWM4NmFlZDAwNzM4M2ViIF0NCg0KVGhlIHpl
cm8gcGFkZGluZyB0aGF0IGlzIGFkZGVkIHRvIE5UQidzIGRvZXMNCm5vdCB6ZXJvIHRoZSBtZW1v
cnkgY29ycmVjdGx5Lg0KVGhpcyBpcyBiZWNhdXNlIHRoZSBza2JfcHV0IG1vZGlmaWVzIHRoZSB2
YWx1ZQ0Kb2Ygc2tiX291dC0+bGVuIHdoaWNoIHJlc3VsdHMgaW4gdGhlIG1lbXNldA0KY29tbWFu
ZCBub3Qgc2V0dGluZyBhbnkgbWVtb3J5IHRvIHplcm8gYXMNCihjdHgtPnR4X21heCAtIHNrYl9v
dXQtPmxlbikgPT0gMC4NCg0KSSBoYXZlIHJlc29sdmVkIHRoaXMgYnkgc3RvcmluZyB0aGUgc2l6
ZSBvZg0KdGhlIG1lbW9yeSB0byBiZSB6ZXJvZWQgYmVmb3JlIHRoZSBza2JfcHV0DQphbmQgdXNp
bmcgdGhpcyBpbiB0aGUgbWVtc2V0IGNhbGwuDQoNClNpZ25lZC1vZmYtYnk6IEppbSBCYXh0ZXIg
PGppbV9iYXh0ZXJAbWVudG9yLmNvbT4NClJldmlld2VkLWJ5OiBCasO4cm4gTW9yayA8Ympvcm5A
bW9yay5ubz4NClNpZ25lZC1vZmYtYnk6IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0
Lm5ldD4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9z
b2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvbmV0L3VzYi9jZGNfbmNtLmMgfCAxMSArKysrKysrLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC91c2IvY2RjX25jbS5jIGIvZHJpdmVycy9uZXQvdXNiL2Nk
Y19uY20uYw0KaW5kZXggNzJjYjMwODI4YTEyLi5jOGU5OGM4ZTI5ZmEgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL25ldC91c2IvY2RjX25jbS5jDQorKysgYi9kcml2ZXJzL25ldC91c2IvY2RjX25jbS5j
DQpAQCAtMTA2OSw2ICsxMDY5LDcgQEAgY2RjX25jbV9maWxsX3R4X2ZyYW1lKHN0cnVjdCB1c2Ju
ZXQgKmRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYiwgX19sZTMyIHNpZ24pDQogCXUxNiBuID0gMCwg
aW5kZXgsIG5kcGxlbjsNCiAJdTggcmVhZHkyc2VuZCA9IDA7DQogCXUzMiBkZWxheWVkX25kcF9z
aXplOw0KKwlzaXplX3QgcGFkZGluZ19jb3VudDsNCiANCiAJLyogV2hlbiBvdXIgTkRQIGdldHMg
d3JpdHRlbiBpbiBjZGNfbmNtX25kcCgpLCB0aGVuIHNrYl9vdXQtPmxlbiBnZXRzIHVwZGF0ZWQN
CiAJICogYWNjb3JkaW5nbHkuIE90aGVyd2lzZSwgd2Ugc2hvdWxkIGNoZWNrIGhlcmUuDQpAQCAt
MTIyNSwxMSArMTIyNiwxMyBAQCBjZGNfbmNtX2ZpbGxfdHhfZnJhbWUoc3RydWN0IHVzYm5ldCAq
ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBfX2xlMzIgc2lnbikNCiAJICogYSBaTFAgYWZ0ZXIg
ZnVsbCBzaXplZCBOVEJzLg0KIAkgKi8NCiAJaWYgKCEoZGV2LT5kcml2ZXJfaW5mby0+ZmxhZ3Mg
JiBGTEFHX1NFTkRfWkxQKSAmJg0KLQkgICAgc2tiX291dC0+bGVuID4gY3R4LT5taW5fdHhfcGt0
KQ0KLQkJbWVtc2V0KHNrYl9wdXQoc2tiX291dCwgY3R4LT50eF9tYXggLSBza2Jfb3V0LT5sZW4p
LCAwLA0KLQkJICAgICAgIGN0eC0+dHhfbWF4IC0gc2tiX291dC0+bGVuKTsNCi0JZWxzZSBpZiAo
c2tiX291dC0+bGVuIDwgY3R4LT50eF9tYXggJiYgKHNrYl9vdXQtPmxlbiAlIGRldi0+bWF4cGFj
a2V0KSA9PSAwKQ0KKwkgICAgc2tiX291dC0+bGVuID4gY3R4LT5taW5fdHhfcGt0KSB7DQorCQlw
YWRkaW5nX2NvdW50ID0gY3R4LT50eF9tYXggLSBza2Jfb3V0LT5sZW47DQorCQltZW1zZXQoc2ti
X3B1dChza2Jfb3V0LCBwYWRkaW5nX2NvdW50KSwgMCwgcGFkZGluZ19jb3VudCk7DQorCX0gZWxz
ZSBpZiAoc2tiX291dC0+bGVuIDwgY3R4LT50eF9tYXggJiYNCisJCSAgIChza2Jfb3V0LT5sZW4g
JSBkZXYtPm1heHBhY2tldCkgPT0gMCkgew0KIAkJKnNrYl9wdXQoc2tiX291dCwgMSkgPSAwOwkv
KiBmb3JjZSBzaG9ydCBwYWNrZXQgKi8NCisJfQ0KIA0KIAkvKiBzZXQgZmluYWwgZnJhbWUgbGVu
Z3RoICovDQogCW50aDE2ID0gKHN0cnVjdCB1c2JfY2RjX25jbV9udGgxNiAqKXNrYl9vdXQtPmRh
dGE7DQotLSANCjIuMTQuMQ0K
