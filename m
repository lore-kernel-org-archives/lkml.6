Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521496021-2-10937037215886624260
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
    t=1521496020; b=Y52I5l67y3gHtF4Qi/ZwTCI3LQFkHsyYXBAO30a9stUSsZ3
    pCaFo4eytTbRw/otpAIO3U5aSjz4YryapAwJKp6ZZCkegGdwsAfmAmAi6bp0L0zh
    Sy0Qwmhx9as81QtFg8LCg+/AyU4aQV8cTkkHrRRS7xswLvFLIoawE46M+4Bxl+b1
    VAbH6nXhjFRjyPNzMyBO/9vCCVVU7RwP/9kSARO1p7kgkMMgX+nkOodMRZcLQIrR
    7uhbFGeYD17inwxZEmBmnnMaZI+SqN00KSz8d3iGN0eGc/7GkOPTlvT5xBN1orYM
    Eod+XGzE2jtystC1AP7w0aVJ+diY3KsFmOBLq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521496020; bh=chO5Lirf1ZsdrsAxRant6EGm6EyspS8CZhzSXr
    4t8Xg=; b=tHCZM82AOw1zYi8u/duLrRsQ2puPEi+wXNZfGLffh7UrfulMpGc0/H
    TNr9FTEjGPiyelUSMCm8CPw1MaNmn0gB/V/8Q+8BAbrse23qr1LuvIUXqo7Q6/Za
    BuKKs9hKyIHnf+YkRExOGHgJDasLACEP7nK5GtYJLoXaB7cjLQO+hWaR4anDacGj
    wCWu2Ukp6iR4441scl6ugXwC8H3fe7H46ilTOpjGkjAOYOupxnitHEKb+rq+Lu86
    ieaoU4yEGgvanJKXwXBxwrLr2cJNcOZEblNFM/fevT7nuPVaAtwsudCBIrPetoBN
    Srx16eiqpS+eq43rn2SqIEXidNX1A5ag==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ICrJjBjZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekleeifeenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ICrJjBjZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekleeifeenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972010AbeCSVql (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:46:41 -0400
Received: from mail-by2nam01on0127.outbound.protection.outlook.com ([104.47.34.127]:11541
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934766AbeCSP6V (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jim Baxter <jim_baxter@mentor.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 018/281] net: cdc_ncm: Fix TX zero padding
Thread-Topic: [PATCH AUTOSEL for 4.9 018/281] net: cdc_ncm: Fix TX zero
 padding
Thread-Index: AQHTv5sU4qQ97g+O6kCklqAYLSjmKA==
Date: Mon, 19 Mar 2018 15:58:10 +0000
Message-ID: <20180319155742.13731-18-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:ZStTfxL19bKz3AWn5IfZeTsscJRXzfQC++oLuUuWV2hbAp58FS+wxCxVAbI7wmeE6qGFMk69bxcoVA8/N3Obt6cMAnsNbT+QvS53vEkMiymMsGixh72jUZYCvFXjxGukxUHDgIWpkhoiy1Vm+PPopSKzS4tC9AG7GAR19QkqsEilwr4vaE8RtEimBujb7PyGgMyYX1wYRg5njXYagmKWsDuGUTCpZwXPXBK3zLp7qyI2SjShkjD99nr9sMtAJg4k;20:X44xNKa9za2o1/QsjhPJpnSr4ISUIvhmL2lR4jxw2qinX1c9R36m1ZEu3mgctFUmfft48LYKe/iSiKaK+TKKD4D5Tw2q1fnkNnYNQ7py9O3P6GDoG5yr2y6gix5D2Zop9kH65YnckXrzHc+22/ZvLGiYCbrAZuLYBEkK2hH+Px4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf33575a-7965-48a5-72e4-08d58db237af
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07261249625EE293AACF621DFBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(575784001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(186003)(1076002)(3846002)(25786009)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: T2ljEvAgZsII3pt8Qr16HKnMK0obScodCn2wLi58ijcH2SyVDFOKIPeUCGOinXhtid8f312YoXqctKx306JYAKJy2doD+GKD7B8tv4hAuW9t0Q82vsduTFm3JrHcrxn9Ew/SLAa90SjnENTO8elAUtEObBujR9NlU7OLGrI+49x2ijCaFX+l9Iv/P0mWukoWOXJFlsEv07Iu1kSALmSrIN55R1Wdk0pdCx9Ew0SJPCUCekwe4pI531WoA6AaaYGgjOU1sr7XRaDuh9RsG4PoynloDpwaaexkp/zB6hmpI8nyKiGVyh00aKmnvIGYNkLDKisW36dVaTnt7oP4LuRzpA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD231F669851A24E9D2DB8EB1E0A03AA@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf33575a-7965-48a5-72e4-08d58db237af
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:10.9885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
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
Y19uY20uYw0KaW5kZXggZGM2ZDNiMGEwYmU4Li5mZWI2MWVhZmZlMzIgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL25ldC91c2IvY2RjX25jbS5jDQorKysgYi9kcml2ZXJzL25ldC91c2IvY2RjX25jbS5j
DQpAQCAtMTExOCw2ICsxMTE4LDcgQEAgY2RjX25jbV9maWxsX3R4X2ZyYW1lKHN0cnVjdCB1c2Ju
ZXQgKmRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYiwgX19sZTMyIHNpZ24pDQogCXUxNiBuID0gMCwg
aW5kZXgsIG5kcGxlbjsNCiAJdTggcmVhZHkyc2VuZCA9IDA7DQogCXUzMiBkZWxheWVkX25kcF9z
aXplOw0KKwlzaXplX3QgcGFkZGluZ19jb3VudDsNCiANCiAJLyogV2hlbiBvdXIgTkRQIGdldHMg
d3JpdHRlbiBpbiBjZGNfbmNtX25kcCgpLCB0aGVuIHNrYl9vdXQtPmxlbiBnZXRzIHVwZGF0ZWQN
CiAJICogYWNjb3JkaW5nbHkuIE90aGVyd2lzZSwgd2Ugc2hvdWxkIGNoZWNrIGhlcmUuDQpAQCAt
MTI3NCwxMSArMTI3NSwxMyBAQCBjZGNfbmNtX2ZpbGxfdHhfZnJhbWUoc3RydWN0IHVzYm5ldCAq
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
