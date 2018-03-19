Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521477330-2-16221539738724220512
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521477329; b=jLyMuHUEwjj0iIzar5Rvsw6cwuuJPU6sSkqBiC3spGUI7xt
    HdzjPGPeQmVmP/wzXg756KUYt5ZGNWGQAgoIbGENlPGX47KrVtKvOcnUJVVRwXWP
    VZ5bjMKwbQCBs5VpkhcjVfyf0SjTd6OlGrXPA7hA61CJTPShgVTVvpFLVoh8yIMu
    7XOJkINY4YONRX18KMRrBeaCfjSFlizSNKs7z4lCjRT9+7B9WeUOatV4wd77yeEw
    AdYZvr0HU+DLIkmBol9bTGpgBjB4iaaBRpMaeIvsFINX2qZrNBFKc4qZgiTmEzcx
    eDrCq+N4QP09blESVz02Qkedky4WeuhKEX0p6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521477329; bh=AZ1ny/gpNhhan937mS4xHNjIEY+F7bnYWpTk28
    RqRio=; b=G18c+HV1yDqhySPl6El/1I6AO53mj/zv+HEDECH9zgpZqp4bZFKwjw
    rcre4FwniIgQzUfk1f1MCF9Cf7V2YmVedGeKMPgCpIRkFg0mMJXqN9FCIa0Po5af
    Uo3DvGQn9XMFRk+Tlu9Z5vwQ9wDk3gxEuDVsSigA33q2oZgULDqE0gPrqYccehok
    pDu+BPdjx/SvVh/zT+ZUtbbUyaEhm0V97jVuuGB/4D88I9rqYavCudKc9aKVffyv
    BnwMo6elUlCMX6EUKmAwHyBfgCcWOrtEuTYhq7IpSMY4+pvdANSu5XAOV3OwkaTz
    U1l32UdshqyidhtEIC8o6JTMmzMQk/kg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LInpvKAs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeltdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthgsredttddtjeenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddufeehudenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LInpvKAs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeltdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthgsredttddtjeenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddufeehudenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935294AbeCSQfY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:35:24 -0400
Received: from mail-dm3nam03on0123.outbound.protection.outlook.com ([104.47.41.123]:2048
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935293AbeCSQN0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Roman Pen <roman.penyaev@profitbricks.com>,
        Mikhail Sennikovskii <mikhail.sennikovskii@profitbricks.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LDhG3Dg8Khw4XihKI=?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 061/102] KVM: SVM: do not zero out segment
 attributes if segment is unusable or not present
Thread-Topic: [PATCH AUTOSEL for 3.18 061/102] KVM: SVM: do not zero out
 segment attributes if segment is unusable or not present
Thread-Index: AQHTv50d9kaHbKThZEmjqjO7gqLGKQ==
Date: Mon, 19 Mar 2018 16:12:45 +0000
Message-ID: <20180319161117.17833-61-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:GJU0jbELJ/Lenp6C+9/8szMaCvHrupSNZ6pxN/v9UqVeVCVCjz/HBgH9+wFIlRpqVxTLGKwWsFO8NCyo9pa/mSUeDgO55szLp0i0dV+JhTVz6R/neDNY5gIwRWczdhYll3DOQaQIbkf3P18/lF2TkHaCURvLON+x2Qh+glBZ4AEMEX99hHbc6ruJNkTtM6b85zJ9XmGDE0kjtPptG+somr+aG0ZZdh6b81G8padfnDYhIcztIgSLdOLjGnOWvGPX;20:NDiwrl2pK5rPNdqduxkvNKnyPg8FOJCwXK+i5e+BXddjvehb6vX8+4jABp6TyHcTMqYnp6aDqIgWgZcREB9SZ4+EIl/E3Adi1lrcQdpjhhk/DhJg0yWjcz9XQKyty/TlKuMZ6THC3r7BP5hqjypoLlWrKkBdCxQqHS5g/jKzvgw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 433e281e-f8d5-471a-acd7-08d58db45324
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032E327F55E03FCAD447FC4FBD40@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(3660700001)(5250100002)(3280700002)(8936002)(3846002)(6116002)(1076002)(10090500001)(105586002)(72206003)(81156014)(8676002)(81166006)(2906002)(5660300001)(97736004)(2501003)(36756003)(6666003)(2900100001)(14454004)(6512007)(6436002)(2950100002)(53936002)(4326008)(54906003)(305945005)(6486002)(25786009)(68736007)(22452003)(316002)(59450400001)(6506007)(86612001)(66066001)(76176011)(102836004)(7736002)(10290500003)(110136005)(106356001)(99286004)(107886003)(26005)(186003)(575784001)(86362001)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: MAT2XkcAGk7vXdFlpo2AJHGhbI2hmTyjBoIJUUQU82ctGt60rIlhCnmaecv85EqG+ZLwEBNMCkDd26z0sDvOqX1PnseRd+g/CjhFEy0R8+hZkenuLLqef9TCHGpNIrP0xdXZNRlzXuZfv5Ox9tl4/VuYGDhzGCTbmWi5Q1IsO320T3T7lCZXMwd70wyn7Dwno/e+1/mgGTauw5sUN9ThpLpCT1VcJzrZpSgJtTL4U1RLyXMq/98ILIk54OhEgdMScvDYHO3k//HUYDL0r6ZTNc7gfpF+tlxHQWpuqsr+okdm3iac94nwIsI1CHITNa0a94xSbPRhLSrUSZMgILLC1w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <35F45444BF56C54FA0D759DD965043B0@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433e281e-f8d5-471a-acd7-08d58db45324
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:45.8574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogUm9tYW4gUGVuIDxyb21hbi5wZW55YWV2QHByb2ZpdGJyaWNrcy5jb20+DQoNClsgVXBz
dHJlYW0gY29tbWl0IGQ5YzFiNTQzMWQ1ZjBlMDc1NzVkYjc4NWEwMjJiY2U5MTA1MWFjMWQgXQ0K
DQpUaGlzIGlzIGEgZml4IGZvciB0aGUgcHJvYmxlbSBbMV0sIHdoZXJlIFZNQ0IuQ1BMIHdhcyBz
ZXQgdG8gMCBhbmQgaW50ZXJydXB0DQp3YXMgdGFrZW4gb24gdXNlcnNwYWNlIHN0YWNrLiAgVGhl
IHJvb3QgY2F1c2UgbGllcyBpbiB0aGUgc3BlY2lmaWMgQU1EIENQVQ0KYmVoYXZpb3VyIHdoaWNo
IG1hbmlmZXN0cyBpdHNlbGYgYXMgdW51c2FibGUgc2VnbWVudCBhdHRyaWJ1dGVzIG9uIFNZU1JF
VC4NClRoZSBjb3JyZXNwb25kaW5nIHdvcmsgYXJvdW5kIGZvciB0aGUga2VybmVsIGlzIHRoZSBm
b2xsb3dpbmc6DQoNCjYxZjAxZGQ5NDFiYSAoIng4Nl82NCwgYXNtOiBXb3JrIGFyb3VuZCBBTUQg
U1lTUkVUIFNTIGRlc2NyaXB0b3IgYXR0cmlidXRlIGlzc3VlIikNCg0KSW4gb3RoZXIgdHVybiB2
aXJ0dWFsaXphdGlvbiBzaWRlIHRyZWF0ZWQgdW51c2FibGUgc2VnbWVudCBpbmNvcnJlY3RseSBh
bmQNCnJlc3RvcmVkIENQTCBmcm9tIFNTIGF0dHJpYnV0ZXMsIHdoaWNoIHdlcmUgemVyb2VkIG91
dCBmZXcgbGluZXMgYWJvdmUuDQoNCkluIGN1cnJlbnQgcGF0Y2ggaXQgaXMgYXNzdXJlZCBvbmx5
IHRoYXQgUCBiaXQgaXMgY2xlYXJlZCBpbiBWTUNCLnNhdmUgc3RhdGUNCmFuZCBzZWdtZW50IGF0
dHJpYnV0ZXMgYXJlIG5vdCB6ZXJvZWQgb3V0IGlmIHNlZ21lbnQgaXMgbm90IHByZXNlbnRlZCBv
ciBpcw0KdW51c2FibGUsIHRoZXJlZm9yZSBDUEwgY2FuIGJlIHNhZmVseSByZXN0b3JlZCBmcm9t
IERQTCBmaWVsZC4NCg0KVGhpcyBpcyBvbmx5IG9uZSBwYXJ0IG9mIHRoZSBmaXgsIHNpbmNlIFFF
TVUgc2lkZSBzaG91bGQgYmUgZml4ZWQgYWNjb3JkaW5nbHkNCm5vdCB0byB6ZXJvIG91dCBhdHRy
aWJ1dGVzIG9uIGl0cyBzaWRlLiAgQ29ycmVzcG9uZGluZyBwYXRjaCB3aWxsIGZvbGxvdy4NCg0K
WzFdIE1lc3NhZ2UgaWQ6IENBSnJXT3pENlhxPT1iLXpZQ0RkRkxnU1JNUE0tTmtOdVRTREZFdFg9
N01yZVQ0NWk3UUBtYWlsLmdtYWlsLmNvbQ0KDQpTaWduZWQtb2ZmLWJ5OiBSb21hbiBQZW4gPHJv
bWFuLnBlbnlhZXZAcHJvZml0YnJpY2tzLmNvbT4NClNpZ25lZC1vZmYtYnk6IE1pa2hhaWwgU2Vu
bmlrb3Zza2lpIDxtaWtoYWlsLnNlbm5pa292c2tpaUBwcm9maXRicmlja3MuY29tPg0KQ2M6IFBh
b2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQpDYzogUmFkaW0gS3LDhG3Dg8Khw4Xi
hKIgPHJrcmNtYXJAcmVkaGF0LmNvbT4NCkNjOiBrdm1Admdlci5rZXJuZWwub3JnDQpDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU2lnbmVkLW9mZi1ieTogUGFvbG8gQm9uemluaSA8
cGJvbnppbmlAcmVkaGF0LmNvbT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5k
ZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGFyY2gveDg2L2t2bS9zdm0uYyB8IDI0ICsr
KysrKysrKysrLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
LCAxMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0uYyBiL2Fy
Y2gveDg2L2t2bS9zdm0uYw0KaW5kZXggMzY0MTRkMTMyODlmLi4yZTBjNjRhMDg1NDkgMTAwNjQ0
DQotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtLmMNCisrKyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KQEAg
LTE0NjcsNiArMTQ2Nyw3IEBAIHN0YXRpYyB2b2lkIHN2bV9nZXRfc2VnbWVudChzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsDQogCQkgKi8NCiAJCWlmICh2YXItPnVudXNhYmxlKQ0KIAkJCXZhci0+ZGIg
PSAwOw0KKwkJLyogVGhpcyBpcyBzeW1tZXRyaWMgd2l0aCBzdm1fc2V0X3NlZ21lbnQoKSAqLw0K
IAkJdmFyLT5kcGwgPSB0b19zdm0odmNwdSktPnZtY2ItPnNhdmUuY3BsOw0KIAkJYnJlYWs7DQog
CX0NCkBAIC0xNjExLDE4ICsxNjEyLDE0IEBAIHN0YXRpYyB2b2lkIHN2bV9zZXRfc2VnbWVudChz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsDQogCXMtPmJhc2UgPSB2YXItPmJhc2U7DQogCXMtPmxpbWl0
ID0gdmFyLT5saW1pdDsNCiAJcy0+c2VsZWN0b3IgPSB2YXItPnNlbGVjdG9yOw0KLQlpZiAodmFy
LT51bnVzYWJsZSkNCi0JCXMtPmF0dHJpYiA9IDA7DQotCWVsc2Ugew0KLQkJcy0+YXR0cmliID0g
KHZhci0+dHlwZSAmIFNWTV9TRUxFQ1RPUl9UWVBFX01BU0spOw0KLQkJcy0+YXR0cmliIHw9ICh2
YXItPnMgJiAxKSA8PCBTVk1fU0VMRUNUT1JfU19TSElGVDsNCi0JCXMtPmF0dHJpYiB8PSAodmFy
LT5kcGwgJiAzKSA8PCBTVk1fU0VMRUNUT1JfRFBMX1NISUZUOw0KLQkJcy0+YXR0cmliIHw9ICh2
YXItPnByZXNlbnQgJiAxKSA8PCBTVk1fU0VMRUNUT1JfUF9TSElGVDsNCi0JCXMtPmF0dHJpYiB8
PSAodmFyLT5hdmwgJiAxKSA8PCBTVk1fU0VMRUNUT1JfQVZMX1NISUZUOw0KLQkJcy0+YXR0cmli
IHw9ICh2YXItPmwgJiAxKSA8PCBTVk1fU0VMRUNUT1JfTF9TSElGVDsNCi0JCXMtPmF0dHJpYiB8
PSAodmFyLT5kYiAmIDEpIDw8IFNWTV9TRUxFQ1RPUl9EQl9TSElGVDsNCi0JCXMtPmF0dHJpYiB8
PSAodmFyLT5nICYgMSkgPDwgU1ZNX1NFTEVDVE9SX0dfU0hJRlQ7DQotCX0NCisJcy0+YXR0cmli
ID0gKHZhci0+dHlwZSAmIFNWTV9TRUxFQ1RPUl9UWVBFX01BU0spOw0KKwlzLT5hdHRyaWIgfD0g
KHZhci0+cyAmIDEpIDw8IFNWTV9TRUxFQ1RPUl9TX1NISUZUOw0KKwlzLT5hdHRyaWIgfD0gKHZh
ci0+ZHBsICYgMykgPDwgU1ZNX1NFTEVDVE9SX0RQTF9TSElGVDsNCisJcy0+YXR0cmliIHw9ICgo
dmFyLT5wcmVzZW50ICYgMSkgJiYgIXZhci0+dW51c2FibGUpIDw8IFNWTV9TRUxFQ1RPUl9QX1NI
SUZUOw0KKwlzLT5hdHRyaWIgfD0gKHZhci0+YXZsICYgMSkgPDwgU1ZNX1NFTEVDVE9SX0FWTF9T
SElGVDsNCisJcy0+YXR0cmliIHw9ICh2YXItPmwgJiAxKSA8PCBTVk1fU0VMRUNUT1JfTF9TSElG
VDsNCisJcy0+YXR0cmliIHw9ICh2YXItPmRiICYgMSkgPDwgU1ZNX1NFTEVDVE9SX0RCX1NISUZU
Ow0KKwlzLT5hdHRyaWIgfD0gKHZhci0+ZyAmIDEpIDw8IFNWTV9TRUxFQ1RPUl9HX1NISUZUOw0K
IA0KIAkvKg0KIAkgKiBUaGlzIGlzIGFsd2F5cyBhY2N1cmF0ZSwgZXhjZXB0IGlmIFNZU1JFVCBy
ZXR1cm5lZCB0byBhIHNlZ21lbnQNCkBAIC0xNjMxLDcgKzE2MjgsOCBAQCBzdGF0aWMgdm9pZCBz
dm1fc2V0X3NlZ21lbnQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LA0KIAkgKiB3b3VsZCBlbnRhaWwg
cGFzc2luZyB0aGUgQ1BMIHRvIHVzZXJzcGFjZSBhbmQgYmFjay4NCiAJICovDQogCWlmIChzZWcg
PT0gVkNQVV9TUkVHX1NTKQ0KLQkJc3ZtLT52bWNiLT5zYXZlLmNwbCA9IChzLT5hdHRyaWIgPj4g
U1ZNX1NFTEVDVE9SX0RQTF9TSElGVCkgJiAzOw0KKwkJLyogVGhpcyBpcyBzeW1tZXRyaWMgd2l0
aCBzdm1fZ2V0X3NlZ21lbnQoKSAqLw0KKwkJc3ZtLT52bWNiLT5zYXZlLmNwbCA9ICh2YXItPmRw
bCAmIDMpOw0KIA0KIAltYXJrX2RpcnR5KHN2bS0+dm1jYiwgVk1DQl9TRUcpOw0KIH0NCi0tIA0K
Mi4xNC4xDQo=
