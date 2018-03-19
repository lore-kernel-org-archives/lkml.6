Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521494292-2-11734597642876032910
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
    t=1521494292; b=hYXva5SwBsRlc659o1FIXCFG/i0rRRxzcQV8j8GvHGvsyBD
    9FVJzMQaj9FFSpSUa5t/hhWDRXPgsoLG6V1gJsANpw6dWB4YFDRaqRQhUgJIcJr6
    NlTVBPo9OVbr1s5uNVukqK2YEopcgRCbCz6or+E0nRzOARwaFZWbytOCjCpVwIeE
    aH4LSeGOy/jaenKnzq0h3p4RvvWiDriNznNvTzg2HBfVcBhi3QrLrR65DgrpzW8q
    cQJ2grLbQSct+htQ3R341M3pJQriOFsWZCPHzZ8tUoqtSUh0zwrq7YMDqWGaEOLr
    2QV5kTzWeNOiDBNbIcT1//bm0qCB/40+6/07oZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521494292; bh=tfPlR+PF8ciBoeOfCAqo8wVqqPAwpapXoO2hLk
    N7PDc=; b=fRFN8jOVRuGHLsWC1wKRJ42iXxnHOBtjZyvdOV/uka3xl+dDVbp16N
    Bkm7pmzyku1SQVw+eLl8rfzM/lwNcZKX2+kyd1RoeuJiWlWCA2VZ83vzViKQFmwE
    63HFjqNgJkkGAnwIsX7SaMf+a97upSGOiIsdJrTRfcdbJZIm9/SA+GHkRcY8xyQz
    M1C/CGCM/xvLc+rI5N9PUGuWxYEUYETCdm044BDan6eDXDlLWEmhERk1o4vHuaoe
    MRPV/N566uaET6b53We9EoZUXn8EeiuWwe5dG3bL3Zs/24vfri2d2VwRaaGNhkaB
    JsDp0BsJvqj6WehJ/YpdLcrjttCkQf/A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MWmEu0QO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdehgeeinecuvehluhhsthgvrhfuihiivgepudei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MWmEu0QO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdehgeeinecuvehluhhsthgvrhfuihiivgepudei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969209AbeCSVRU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:17:20 -0400
Received: from mail-by2nam03on0105.outbound.protection.outlook.com ([104.47.42.105]:9497
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934774AbeCSQBG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Wanpeng Li <wanpeng.li@hotmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 116/281] KVM: X86: Fix preempt the preemption
 timer cancel
Thread-Topic: [PATCH AUTOSEL for 4.9 116/281] KVM: X86: Fix preempt the
 preemption timer cancel
Thread-Index: AQHTv5tcrmrjLWWQ9EKkdRU5YGEXVA==
Date: Mon, 19 Mar 2018 16:00:11 +0000
Message-ID: <20180319155742.13731-116-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:ZXjW/jpcBuVBtPtBkHXkeToCU6sGJOCuJL1QOidQTRNjv3kszPH9CDAaX9Ro2ZF+VBx5uAxE4RxAlCM6gVBarSporQUKdPaxABoJSNn4bjNCKrOwRICdCmuOkzPvsuQ1AUfEIK/uN7dj3wca4hg3ml+WWwJ8LjC9gEdJvmoJI8lk4pDzj2/geylJVgYajyjaIlvvzWX0YL5dLgGhi2D/gzU828BjLMA5B6YmgYQTM2J5l7sV/74vmaS5z4OQ5erb;20:0SiMegy4Tt+RMt2gBTnlQ3VU1rCJW8bJy0Yk9KAIVeuZ4qYhbw6aNGpBSvH/nDGHGKMNH80LdeiVnS7KA4Llms6F1EgkX00L+MQGhSgpxUCJT65Pz++sXukPrO4lNXZkV17LnnK9bJJqJpvN6/dKb3ltRimaoVpvvZSdTJqWlek=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6128237-14cf-411e-8fc0-08d58db29dac
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031D0DA4524CF81AE7E460DFBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130873036417446)(194151415913766);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(39060400002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: MuoP2IXXwQA0oUhKY2WWs0y1iArApcPTMWImFkVVH+wdU0mLvZdy/UGyAmWFoNFWNKy5Dz8JgMuZ7X7juEOoH/1DzfxC6N7HmEBqL5XI2LcAd8uEqFLIw8ojVBhUhLHAKFLZmJp+CR6Bf5NkX2+UNzt9tq6wS/leLySCmVZ2XkFTqjdm0PRTyiS9ySzeKDK9rv99lQ0+bek1n6RwZGA6iV0ZWmC5rim7FSuBfxMTyzvDcRWAGj3kYh2Nh/YBWyvWKHaGDwpO+fNflBPjzMnmY/APcjtD/3yJC+bg1ocxnyXSWHLqScZzIXMi7i+Kzl34+clbGfpoQkACcdshxENIEg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC3BAF1681FA094C8A26B39DD8B7DCD7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6128237-14cf-411e-8fc0-08d58db29dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:11.7460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogV2FucGVuZyBMaSA8d2FucGVuZy5saUBob3RtYWlsLmNvbT4NCg0KWyBVcHN0cmVhbSBj
b21taXQgNWFjYzFjYTRmYjE1ZjAwYmZhM2Q0MDQ2ZTM1Y2EzODFiYzI1ZDU4MCBdDQoNClByZWVt
cHRpb24gY2FuIG9jY3VyIGR1cmluZyBjYW5jZWwgcHJlZW1wdGlvbiB0aW1lciwgYW5kIHRoZXJl
IHdpbGwgYmUNCmluY29uc2lzdGVudCBzdGF0dXMgaW4gbGFwaWMsIHZteCBhbmQgdm1jcyBmaWVs
ZC4NCg0KICAgICAgICAgIENQVTAgICAgICAgICAgICAgICAgICAgIENQVTENCg0KICBwcmVlbXB0
aW9uIHRpbWVyIHZtZXhpdA0KICBoYW5kbGVfcHJlZW1wdGlvbl90aW1lcih2Q1BVMCkNCiAgICBr
dm1fbGFwaWNfZXhwaXJlZF9odl90aW1lcg0KICAgICAgdm14X2NhbmNlbF9odl90aW1lcg0KICAg
ICAgICB2bXgtPmh2X2RlYWRsaW5lX3RzYyA9IC0xDQogICAgICAgIHZtY3NfY2xlYXJfYml0cw0K
ICAgICAgICAvKiBodl90aW1lcl9pbl91c2Ugc3RpbGwgdHJ1ZSAqLw0KICBzY2hlZF9vdXQNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNjaGVkX2luDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICBrdm1fYXJjaF92Y3B1X2xvYWQNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm14
X3NldF9odl90aW1lcg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdyaXRlIHZteC0+
aHZfZGVhZGxpbmVfdHNjDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm1jc19zZXRf
Yml0cw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogYmFjayBpbiBrdm1fbGFwaWNfZXhw
aXJlZF9odl90aW1lciAqLw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgaHZfdGltZXJfaW5f
dXNlID0gZmFsc2UNCiAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLg0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdm14X3ZjcHVfcnVuDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZteF9hcm1faHZfcnVuDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd3JpdGUgcHJl
ZW1wdGlvbiB0aW1lciBkZWFkbGluZQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzcHVy
aW91cyBwcmVlbXB0aW9uIHRpbWVyIHZtZXhpdA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGhhbmRsZV9wcmVlbXB0aW9uX3RpbWVyKHZDUFUwKQ0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAga3ZtX2xhcGljX2V4cGlyZWRfaHZfdGltZXINCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgV0FSTl9PTighYXBpYy0+bGFwaWNfdGltZXIuaHZfdGltZXJfaW5f
dXNlKTsNCg0KVGhpcyBjYW4gYmUgcmVwcm9kdWNlZCBzcG9yYWRpY2FsbHkgZHVyaW5nIGJvb3Qg
b2YgTDIgb24gYQ0KcHJlZW1wdGlibGUgTDEsIGNhdXNpbmcgYSBzcGxhdCBvbiBMMS4NCg0KIFdB
Uk5JTkc6IENQVTogMyBQSUQ6IDE5NTIgYXQgYXJjaC94ODYva3ZtL2xhcGljLmM6MTUyOSBrdm1f
bGFwaWNfZXhwaXJlZF9odl90aW1lcisweGI1LzB4ZDAgW2t2bV0NCiBDUFU6IDMgUElEOiAxOTUy
IENvbW06IHFlbXUtc3lzdGVtLXg4NiBOb3QgdGFpbnRlZCA0LjEyLjAtcmMxKyAjMjQgUklQOiAw
MDEwOmt2bV9sYXBpY19leHBpcmVkX2h2X3RpbWVyKzB4YjUvMHhkMCBba3ZtXQ0KICBDYWxsIFRy
YWNlOg0KICBoYW5kbGVfcHJlZW1wdGlvbl90aW1lcisweGUvMHgyMCBba3ZtX2ludGVsXQ0KICB2
bXhfaGFuZGxlX2V4aXQrMHhjOS8weDE1ZjAgW2t2bV9pbnRlbF0NCiAgPyBsb2NrX2FjcXVpcmUr
MHhkYi8weDI1MA0KICA/IGxvY2tfYWNxdWlyZSsweGRiLzB4MjUwDQogID8ga3ZtX2FyY2hfdmNw
dV9pb2N0bF9ydW4rMHhkZjMvMHgxY2UwIFtrdm1dDQogIGt2bV9hcmNoX3ZjcHVfaW9jdGxfcnVu
KzB4ZTU1LzB4MWNlMCBba3ZtXQ0KICBrdm1fdmNwdV9pb2N0bCsweDM4NC8weDdiMCBba3ZtXQ0K
ICA/IGt2bV92Y3B1X2lvY3RsKzB4Mzg0LzB4N2IwIFtrdm1dDQogID8gX19mZ2V0KzB4ZjMvMHgy
MTANCiAgZG9fdmZzX2lvY3RsKzB4YTQvMHg3MDANCiAgPyBfX2ZnZXQrMHgxMTQvMHgyMTANCiAg
U3lTX2lvY3RsKzB4NzkvMHg5MA0KICBkb19zeXNjYWxsXzY0KzB4OGYvMHg3NTANCiAgPyB0cmFj
ZV9oYXJkaXJxc19vbl90aHVuaysweDFhLzB4MWMNCiAgZW50cnlfU1lTQ0FMTDY0X3Nsb3dfcGF0
aCsweDI1LzB4MjUNCg0KVGhpcyBwYXRjaCBmaXhlcyBpdCBieSBkaXNhYmxpbmcgcHJlZW1wdGlv
biB3aGlsZSBjYW5jZWxsaW5nDQpwcmVlbXB0aW9uIHRpbWVyLiAgVGhpcyB3YXkgY2FuY2VsX2h2
X3RpbWVyIGlzIGF0b21pYyB3aXRoDQpyZXNwZWN0IHRvIGt2bV9hcmNoX3ZjcHVfbG9hZC4NCg0K
Q2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQpDYzogUmFkaW0gS3LEjW3D
ocWZIDxya3JjbWFyQHJlZGhhdC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBXYW5wZW5nIExpIDx3YW5w
ZW5nLmxpQGhvdG1haWwuY29tPg0KU2lnbmVkLW9mZi1ieTogUGFvbG8gQm9uemluaSA8cGJvbnpp
bmlAcmVkaGF0LmNvbT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2
aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGFyY2gveDg2L2t2bS9sYXBpYy5jIHwgMiArKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2
bS9sYXBpYy5jIGIvYXJjaC94ODYva3ZtL2xhcGljLmMNCmluZGV4IGIyNGIzYzZkNjg2ZS4uNWMz
ZDQxNmZmZjE3IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva3ZtL2xhcGljLmMNCisrKyBiL2FyY2gv
eDg2L2t2bS9sYXBpYy5jDQpAQCAtMTM2Myw4ICsxMzYzLDEwIEBAIEVYUE9SVF9TWU1CT0xfR1BM
KGt2bV9sYXBpY19odl90aW1lcl9pbl91c2UpOw0KIA0KIHN0YXRpYyB2b2lkIGNhbmNlbF9odl90
c2NkZWFkbGluZShzdHJ1Y3Qga3ZtX2xhcGljICphcGljKQ0KIHsNCisJcHJlZW1wdF9kaXNhYmxl
KCk7DQogCWt2bV94ODZfb3BzLT5jYW5jZWxfaHZfdGltZXIoYXBpYy0+dmNwdSk7DQogCWFwaWMt
PmxhcGljX3RpbWVyLmh2X3RpbWVyX2luX3VzZSA9IGZhbHNlOw0KKwlwcmVlbXB0X2VuYWJsZSgp
Ow0KIH0NCiANCiB2b2lkIGt2bV9sYXBpY19leHBpcmVkX2h2X3RpbWVyKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSkNCi0tIA0KMi4xNC4xDQo=
