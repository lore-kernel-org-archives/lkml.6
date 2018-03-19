Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482898-2-12274929260890462272
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
    t=1521482898; b=TSe8zEiXm6F54TW+SOB83QnJGH+C843NLjAfYj1Pcdpveoc
    Y4hFwuFBg5BDbVgwRglqv+Veckf8KqrMP8oTJ4xEfTBVkDbulQ/IYnN/eDGY2AMC
    4+boLKdg6FJqStiYLrf9hzT5NwDXAcvZiEJrvWeI8TPRQoEGxswsOEWcMyUyYk5F
    9rLDDW5s840Uqg4O08HypD20yFa06RAAYzkEFBlm8T/Q/mnPMm8yGJElo+/s5kLG
    idoQ6hfI+dFk9KJ5beIKayKPB9aH0uD3WJqApulzzSO7HSX4RBTIMEHkT/ls2XBH
    qFTpoJfuRHjtBgpdCCXgmB3UmlKPOa6y1xrBclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521482898; bh=W/d5AWkhdPJ51E3Abz9Aaf1gAU/2Au37eJrvji
    mPNSE=; b=ZqS1cuH5H7B+3qmTBd+PhQ8eJkxh0wpHckUv4+096bRMPo6So2vrd7
    bf2sfu//uzjSo84LEULSQCm0uhV6QMeVJtU0VIvBpdYeVOASOmCP2PIU31DdnW2X
    TzrjmYg3o/qGMFhq4PMZnyzPtqDBb1xk8u4sbXUgWqwUFSsBzWpWkWrE9kXtjLnb
    llqHCgoeZQPW2+p5MnLrCHatZNncyKSjLJ8ap7LqsEwAVywzHu4ndxRq9IuhkmR/
    V6JT/8ID/7Ojasw4S53NKiCpRLxbcwYfISe1BWcfVrpDDRYkgFYfG+zFlg6xY2EN
    4quo7SrYc+2S9ghdJ02xI0cLojGmFrLg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KleMaw8S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudefheegnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KleMaw8S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudefheegnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968191AbeCSSHh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:07:37 -0400
Received: from mail-cys01nam02on0139.outbound.protection.outlook.com ([104.47.37.139]:43744
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934824AbeCSQDV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Roman Pen <roman.penyaev@profitbricks.com>,
        Mikhail Sennikovskii <mikhail.sennikovskii@profitbricks.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LDhG3Dg8Khw4XihKI=?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 176/281] KVM: SVM: do not zero out segment
 attributes if segment is unusable or not present
Thread-Topic: [PATCH AUTOSEL for 4.9 176/281] KVM: SVM: do not zero out
 segment attributes if segment is unusable or not present
Thread-Index: AQHTv5uGIauxBVNXTE+TsqmB6CGiqQ==
Date: Mon, 19 Mar 2018 16:01:21 +0000
Message-ID: <20180319155742.13731-176-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:cCJRdjipO0C1Lvl0aw818UdYd7D9UEnISXwCU4rkIag6ZbKvUbGl+KeOVssnPF3PLE8Tw8KLd/atEK8CDFvXOksCo9LG9Wv2WMJi60c6Jvo10EdtZ5DF16ASIQrR6IBKbgP6ArlFkqhC4PRTwvMC1CIvsJsryqslXHZHjdL4DBSvTdHzVeQIU1TtbCKIkfX7fqNTxUzWhVPOCgJ0vMiPHPWzsgIIt99qaiRL2cxY+cT/xaKOqnaazmWtyGU/b0QM;20:3cfWnZ4+KTvvQ8BhXHHa4qywBIJPlbA+Ec5McL9FT+zoKIDCsUHncNNj51bbMgbceakIf3D3tNFZBQLKT1HywV/7kw/4iUaLhre2uecqbZDGV1bGk9wVeIyeXE9KCm0mm1wHagB2ZgcZDnNXPVwT5l7X42sGfOEZZ8pGcWbd8+A=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea080a57-47ad-4d39-74e7-08d58db2ebb5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725B603E545E8B9CDC61557FBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(2900100001)(4326008)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(59450400001)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(575784001)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: HYgGx5EWx3jC3zeom2c8p+5sZrUc7Fuzw6wvrQ4B8efd7uSke0v9rScDjD3lHWyYrQgk91hDJ9rWHk+rhTiNZW6M9yC/AibBbDE27it2Jou6OcfREVyvSHmmNp5wNRqfrN6PFfOZidmUtQTI3X9Gp05yuXDUAFYfaS2/WMDQuN4aFN4yDrqoVq6ndTKztWosv9hG3XqhgXzqhlXVQYIkducICmNV+hEXx312WsOjfmloxQocc066zsjq/OYwitcO8qX+Rpsx7PmNiHIacmAFY81TsM45xcY7wcrxSdkVFYVwEZIF8fkNDITHGPqVuq8VZDnPII0GXxIswHjh910WRw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0772183DE6DA6459E14E392B5019CAE@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea080a57-47ad-4d39-74e7-08d58db2ebb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:21.6652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
Y2gveDg2L2t2bS9zdm0uYw0KaW5kZXggMjRkMmEzZWU3NDNmLi45OTliMGI4NGFhYmQgMTAwNjQ0
DQotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtLmMNCisrKyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KQEAg
LTE4NzksNiArMTg3OSw3IEBAIHN0YXRpYyB2b2lkIHN2bV9nZXRfc2VnbWVudChzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsDQogCQkgKi8NCiAJCWlmICh2YXItPnVudXNhYmxlKQ0KIAkJCXZhci0+ZGIg
PSAwOw0KKwkJLyogVGhpcyBpcyBzeW1tZXRyaWMgd2l0aCBzdm1fc2V0X3NlZ21lbnQoKSAqLw0K
IAkJdmFyLT5kcGwgPSB0b19zdm0odmNwdSktPnZtY2ItPnNhdmUuY3BsOw0KIAkJYnJlYWs7DQog
CX0NCkBAIC0yMDI0LDE4ICsyMDI1LDE0IEBAIHN0YXRpYyB2b2lkIHN2bV9zZXRfc2VnbWVudChz
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
ZXR1cm5lZCB0byBhIHNlZ21lbnQNCkBAIC0yMDQ0LDcgKzIwNDEsOCBAQCBzdGF0aWMgdm9pZCBz
dm1fc2V0X3NlZ21lbnQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LA0KIAkgKiB3b3VsZCBlbnRhaWwg
cGFzc2luZyB0aGUgQ1BMIHRvIHVzZXJzcGFjZSBhbmQgYmFjay4NCiAJICovDQogCWlmIChzZWcg
PT0gVkNQVV9TUkVHX1NTKQ0KLQkJc3ZtLT52bWNiLT5zYXZlLmNwbCA9IChzLT5hdHRyaWIgPj4g
U1ZNX1NFTEVDVE9SX0RQTF9TSElGVCkgJiAzOw0KKwkJLyogVGhpcyBpcyBzeW1tZXRyaWMgd2l0
aCBzdm1fZ2V0X3NlZ21lbnQoKSAqLw0KKwkJc3ZtLT52bWNiLT5zYXZlLmNwbCA9ICh2YXItPmRw
bCAmIDMpOw0KIA0KIAltYXJrX2RpcnR5KHN2bS0+dm1jYiwgVk1DQl9TRUcpOw0KIH0NCi0tIA0K
Mi4xNC4xDQo=
