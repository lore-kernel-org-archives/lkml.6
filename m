Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3954714-1521498983-2-2922883439800392955
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521498983; b=cb0lkCx/gGuEIhikhufBI4hHpeGMfSO1dwJR/rP1tXwMEX+
    FzTTE0s+n+HeOro+NbE7mY+Wo3mXwbdR5C36oXfBhfbJdho5umxQH3KPWGCrago0
    Hmup84Z01+Bf31dmMdiO1z8UKpX1LdMXEo6EvxeD0bj3Rj9GoaNmwnDS32v1hqB6
    6EQjHKfP9KDW/CZS2AnWQ5O037JJ1DhKo5QVi6RRJS4CuRO2sdvsWAkqITSXYkl2
    LPT90J0SfSNRvRNYm7tAFoZg2hBLpJIJbWArrmiW87zBL09AGbAhlDTmPAezQxDm
    6aqlPcENUTS++jqPONyjbWooU5Z5xB23PKwieEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521498983; bh=9a0n7GdxIwebwXXNc9lLO8T1VWKPbEU7ypHcHi
    XHiRA=; b=GR+QxSwDWc1VrWffajGUw7vrMbG1EVJbBEVxhRQB5dUb+SXWB1J2NW
    SOPFXu0BPn+PXAMqyrRTe+XPp2ls4dTLHckw3K1DUnxBSxu80KpceXaE/oGL7Xix
    fIOPzAWoBkNgcK0QLcZGknsRLCHkPr9MLrR4rpPGdBrgj7Gi7Z4GEFwa/m7hcpAG
    N4g22Exjow2cpd215cPbtoJGvVMRPIJYdQ78O0SZiHvvIUai5gpkBu67DWxaV1el
    rTcKJE7ilp5GKmii5kOq/jLS1L6LL2ykpG5KWNWw+472ZU7t2pVxU4lEFo7sIwIH
    1RaRPWpPgoSuqMkAqMh7+qH7kqZoAAig==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bo+BI47g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduvdehleefnecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bo+BI47g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduvdehleefnecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936640AbeCSWcC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:32:02 -0400
Received: from mail-by2nam01on0106.outbound.protection.outlook.com ([104.47.34.106]:16179
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933697AbeCSPsU (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?UGV0ZXIgR3Jvw59l?= <pegro@friiks.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 048/124] mac80211: Fix setting TX power on
 monitor interfaces
Thread-Topic: [PATCH AUTOSEL for 4.15 048/124] mac80211: Fix setting TX power
 on monitor interfaces
Thread-Index: AQHTv5mie1Ec7yNGIUe425fi1vewGA==
Date: Mon, 19 Mar 2018 15:47:49 +0000
Message-ID: <20180319154645.11350-48-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:rhdBUA875rVLDN9aAvEG+eQAMJnY/L+/z/KYFa4DEcoy36outOQXrkErRYnmO6sa8vMOS+OVqzF6iYLms/3KqaMh+ZCib61fq0hihI5VfvOBR7vLvJcNf4KyEFAOSI0Thx5or7LGGGxufSFa2g5Dru/MebkCJTkgX7eJRrnQemi4P2fsky1O8UcbHVA0G3U4QTfi3nxOVgS4DnvUas9kT/DchRyFRKfgVgJk+FOI2yYTVPaGLAdntKm2LoppSG1u;20:NnOcwI/SubUoqFFSaHsBkZ9pBeq8eotqJgpzlD1YSrS29cebGAVMUBJZNfaQCsni+SYRq8N0/NUvGLmMK893LaqejL2cXRQfAIu5njScBiPOtZxfbBLCM8N1ZglZeY2k0WBLMyMToEvTnu1ZYfTl5UXnN0Vuwzqpd/vO5Uzsdyw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ffffd61-88e4-4f53-7aa2-08d58db0d19c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031235B1DFFBEC97A917863FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(189003)(199004)(6436002)(6512007)(6666003)(3280700002)(2950100002)(7736002)(6116002)(3846002)(10090500001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(2906002)(6486002)(81166006)(8676002)(8936002)(2900100001)(106356001)(36756003)(68736007)(54906003)(3660700001)(22452003)(97736004)(6506007)(25786009)(59450400001)(99286004)(10290500003)(76176011)(66066001)(14454004)(72206003)(478600001)(102836004)(26005)(186003)(316002)(2501003)(110136005)(5250100002)(86362001)(53936002)(107886003)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: curffPiMHu3tk/LhQJeCB+T3X/vf/91NRczUEoFnY5VqWbqsuVyk1pDVZiBK04P5Yhds8Fe2qetCCU9AntH8dqez97nN9eOW6SQUv00Lr/LE5u1+lOcNiK1OLMT8uSeWpULEM2Gu6l5Eiuih9xrHJ/FAVA2JnYg4qKG0FPjwB1+uYFN1PtuLyo7y7ZxzH81erNaz72MagchjI0KVw4FPsV49cYaHzG9q4ggIs53yYvpu47zoGkhFbAAo1qecnzc0gSB/bCN7El6Q2b0sA/htRctsc6rnCl3pzo6lcUmioydZd5pWBkjMOuKD/FZ1mRMOnfUyZRNB/7erzDG/LG1b8g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E040FEB0F719449A330F4B4E6DB807F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffffd61-88e4-4f53-7aa2-08d58db0d19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:49.5184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogUGV0ZXIgR3Jvw59lIDxwZWdyb0Bmcmlpa3MuZGU+DQoNClsgVXBzdHJlYW0gY29tbWl0
IDNhMzcxM2VjMzYwMTM4ZjgwNmM2ZmMzNjhkMWRlNTcwZjY5MmIzNDcgXQ0KDQpJbnN0ZWFkIG9m
IGNhbGxpbmcgaWVlZTgwMjExX3JlY2FsY190eHBvd2VyIG9uIG1vbml0b3IgaW50ZXJmYWNlcw0K
ZGlyZWN0bHksIGNhbGwgaXQgdXNpbmcgdGhlIHZpcnR1YWwgbW9uaXRvciBpbnRlcmZhY2UsIGlm
IG9uZSBleGlzdHMuDQoNCkluIGNhc2Ugb2YgYSBzaW5nbGUgbW9uaXRvciBpbnRlcmZhY2UgZ2l2
ZW4sIHJlamVjdCBzZXR0aW5nIFRYIHBvd2VyLA0KaWYgbm8gdmlydHVhbCBtb25pdG9yIGludGVy
ZmFjZSBleGlzdHMuDQoNClRoYXQgYmVpbmcgY2hlY2tlZCwgZG9uJ3Qgd2FybiBpbiBpZWVlODAy
MTFfYnNzX2luZm9fY2hhbmdlX25vdGlmeSwNCmFmdGVyIHNldHRpbmcgVFggcG93ZXIgb24gYSBt
b25pdG9yIGludGVyZmFjZS4NCg0KRml4ZXMgd2FybmluZzoNCi0tLS0tLS0tLS0tLVsgY3V0IGhl
cmUgXS0tLS0tLS0tLS0tLQ0KIFdBUk5JTkc6IENQVTogMCBQSUQ6IDIxOTMgYXQgbmV0L21hYzgw
MjExL2RyaXZlci1vcHMuaDoxNjcNCiBpZWVlODAyMTFfYnNzX2luZm9fY2hhbmdlX25vdGlmeSsw
eDExMS8weDE5MCBNb2R1bGVzIGxpbmtlZCBpbjogdXZjdmlkZW8NCiB2aWRlb2J1ZjJfdm1hbGxv
YyB2aWRlb2J1ZjJfbWVtb3BzIHZpZGVvYnVmMl92NGwyIHZpZGVvYnVmMl9jb3JlDQpybmRpc19o
b3N0IGNkY19ldGhlciB1c2JuZXQgbWlpIHRwX3NtYXBpKE8pIHRoaW5rcGFkX2VjKE8pIG9oY2lf
aGNkIHZib3hwY2koTykNCiB2Ym94bmV0YWRwKE8pIHZib3huZXRmbHQoTykgdiBib3hkcnYoTykg
eDg2X3BrZ190ZW1wX3RoZXJtYWwga3ZtX2ludGVsIGt2bQ0KIGlycWJ5cGFzcyBpd2xkdm0gaXds
d2lmaSBlaGNpX3BjaSBlaGNpX2hjZCB0cG1fdGlzIHRwbV90aXNfY29yZSB0cG0gQ1BVOiAwDQog
UElEOiAyMTkzIENvbW06IGl3IFRhaW50ZWQ6IEcgICAgICAgICAgIE8gICAgNC4xMi4xMi1nZW50
b28gIzIgdGFzazoNCiBmZmZmODgwMTg2ZmQ1Y2MwIHRhc2suc3RhY2s6IGZmZmZjOTAwMDFiNTQw
MDAgUklQOg0KIDAwMTA6aWVlZTgwMjExX2Jzc19pbmZvX2NoYW5nZV9ub3RpZnkrMHgxMTEvMHgx
OTAgUlNQOiAwMDE4OmZmZmZjOTAwMDFiNTdhMTANCiBFRkxBR1M6IDAwMDEwMjQ2IFJBWDogMDAw
MDAwMDAwMDAwMDAwNiBSQlg6IGZmZmY4ODAxMDUyY2U4NDAgUkNYOg0KIDAwMDAwMDAwMDAwMDAw
NjQgUkRYOiAwMDAwMDAwMGZmZmZmZmZjIFJTSTogMDAwMDAwMDAwMDA0MDAwMCBSREk6DQogZmZm
Zjg4MDEwNTJjZTg0MCBSQlA6IGZmZmZjOTAwMDFiNTdhMzggUjA4OiAwMDAwMDAwMDAwMDAwMDYy
IFIwOToNCiAwMDAwMDAwMDAwMDAwMDAwIFIxMDogZmZmZjg4MDIxNDRiNTAwMCBSMTE6IGZmZmY4
ODAwNDlkYzQ2MTQgUjEyOg0KIDAwMDAwMDAwMDAwNDAwMDAgUjEzOiAwMDAwMDAwMDAwMDAwMDY0
IFIxNDogZmZmZjg4MDIxMDVmMDc2MCBSMTU6DQogZmZmZmM5MDAwMWI1N2I0OCBGUzogIDAwMDA3
ZjkyNjQ0YjQ1ODAoMDAwMCkgR1M6ZmZmZjg4MDIxZTIwMDAwMCgwMDAwKQ0KIGtubEdTOjAwMDAw
MDAwMDAwMDAwMDAgQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1
MDAzMw0KIENSMjogMDAwMDdmOTI2M2MxMDlmMCBDUjM6IDAwMDAwMDAxZGY4NTAwMDAgQ1I0OiAw
MDAwMDAwMDAwMDQwNmYwDQogQ2FsbCBUcmFjZToNCiAgaWVlZTgwMjExX3JlY2FsY190eHBvd2Vy
KzB4MzMvMHg0MA0KICBpZWVlODAyMTFfc2V0X3R4X3Bvd2VyKzB4NDAvMHgxODANCiAgbmw4MDIx
MV9zZXRfd2lwaHkrMHgzMmUvMHg5NTANCg0KUmVwb3J0ZWQtYnk6IFBldGVyIEdyb8OfZSA8cGVn
cm9AZnJpaWtzLmRlPg0KU2lnbmVkLW9mZi1ieTogUGV0ZXIgR3Jvw59lIDxwZWdyb0Bmcmlpa3Mu
ZGU+DQoNClNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzLmJlcmdAaW50ZWwu
Y29tPg0KDQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jv
c29mdC5jb20+DQotLS0NCiBuZXQvbWFjODAyMTEvY2ZnLmMgICAgICAgIHwgMjggKysrKysrKysr
KysrKysrKysrKysrKysrKysrLQ0KIG5ldC9tYWM4MDIxMS9kcml2ZXItb3BzLmggfCAgMyArKy0N
CiAyIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9uZXQvbWFjODAyMTEvY2ZnLmMgYi9uZXQvbWFjODAyMTEvY2ZnLmMNCmluZGV4
IDg0Zjc1N2M1ZDkxYS4uMjg4NjQwNDcxYzJmIDEwMDY0NA0KLS0tIGEvbmV0L21hYzgwMjExL2Nm
Zy5jDQorKysgYi9uZXQvbWFjODAyMTEvY2ZnLmMNCkBAIC0yMzczLDEwICsyMzczLDE3IEBAIHN0
YXRpYyBpbnQgaWVlZTgwMjExX3NldF90eF9wb3dlcihzdHJ1Y3Qgd2lwaHkgKndpcGh5LA0KIAlz
dHJ1Y3QgaWVlZTgwMjExX3N1Yl9pZl9kYXRhICpzZGF0YTsNCiAJZW51bSBubDgwMjExX3R4X3Bv
d2VyX3NldHRpbmcgdHhwX3R5cGUgPSB0eXBlOw0KIAlib29sIHVwZGF0ZV90eHBfdHlwZSA9IGZh
bHNlOw0KKwlib29sIGhhc19tb25pdG9yID0gZmFsc2U7DQogDQogCWlmICh3ZGV2KSB7DQogCQlz
ZGF0YSA9IElFRUU4MDIxMV9XREVWX1RPX1NVQl9JRih3ZGV2KTsNCiANCisJCWlmIChzZGF0YS0+
dmlmLnR5cGUgPT0gTkw4MDIxMV9JRlRZUEVfTU9OSVRPUikgew0KKwkJCXNkYXRhID0gcnRubF9k
ZXJlZmVyZW5jZShsb2NhbC0+bW9uaXRvcl9zZGF0YSk7DQorCQkJaWYgKCFzZGF0YSkNCisJCQkJ
cmV0dXJuIC1FT1BOT1RTVVBQOw0KKwkJfQ0KKw0KIAkJc3dpdGNoICh0eXBlKSB7DQogCQljYXNl
IE5MODAyMTFfVFhfUE9XRVJfQVVUT01BVElDOg0KIAkJCXNkYXRhLT51c2VyX3Bvd2VyX2xldmVs
ID0gSUVFRTgwMjExX1VOU0VUX1BPV0VSX0xFVkVMOw0KQEAgLTI0MTUsMTUgKzI0MjIsMzQgQEAg
c3RhdGljIGludCBpZWVlODAyMTFfc2V0X3R4X3Bvd2VyKHN0cnVjdCB3aXBoeSAqd2lwaHksDQog
DQogCW11dGV4X2xvY2soJmxvY2FsLT5pZmxpc3RfbXR4KTsNCiAJbGlzdF9mb3JfZWFjaF9lbnRy
eShzZGF0YSwgJmxvY2FsLT5pbnRlcmZhY2VzLCBsaXN0KSB7DQorCQlpZiAoc2RhdGEtPnZpZi50
eXBlID09IE5MODAyMTFfSUZUWVBFX01PTklUT1IpIHsNCisJCQloYXNfbW9uaXRvciA9IHRydWU7
DQorCQkJY29udGludWU7DQorCQl9DQogCQlzZGF0YS0+dXNlcl9wb3dlcl9sZXZlbCA9IGxvY2Fs
LT51c2VyX3Bvd2VyX2xldmVsOw0KIAkJaWYgKHR4cF90eXBlICE9IHNkYXRhLT52aWYuYnNzX2Nv
bmYudHhwb3dlcl90eXBlKQ0KIAkJCXVwZGF0ZV90eHBfdHlwZSA9IHRydWU7DQogCQlzZGF0YS0+
dmlmLmJzc19jb25mLnR4cG93ZXJfdHlwZSA9IHR4cF90eXBlOw0KIAl9DQotCWxpc3RfZm9yX2Vh
Y2hfZW50cnkoc2RhdGEsICZsb2NhbC0+aW50ZXJmYWNlcywgbGlzdCkNCisJbGlzdF9mb3JfZWFj
aF9lbnRyeShzZGF0YSwgJmxvY2FsLT5pbnRlcmZhY2VzLCBsaXN0KSB7DQorCQlpZiAoc2RhdGEt
PnZpZi50eXBlID09IE5MODAyMTFfSUZUWVBFX01PTklUT1IpDQorCQkJY29udGludWU7DQogCQlp
ZWVlODAyMTFfcmVjYWxjX3R4cG93ZXIoc2RhdGEsIHVwZGF0ZV90eHBfdHlwZSk7DQorCX0NCiAJ
bXV0ZXhfdW5sb2NrKCZsb2NhbC0+aWZsaXN0X210eCk7DQogDQorCWlmIChoYXNfbW9uaXRvcikg
ew0KKwkJc2RhdGEgPSBydG5sX2RlcmVmZXJlbmNlKGxvY2FsLT5tb25pdG9yX3NkYXRhKTsNCisJ
CWlmIChzZGF0YSkgew0KKwkJCXNkYXRhLT51c2VyX3Bvd2VyX2xldmVsID0gbG9jYWwtPnVzZXJf
cG93ZXJfbGV2ZWw7DQorCQkJaWYgKHR4cF90eXBlICE9IHNkYXRhLT52aWYuYnNzX2NvbmYudHhw
b3dlcl90eXBlKQ0KKwkJCQl1cGRhdGVfdHhwX3R5cGUgPSB0cnVlOw0KKwkJCXNkYXRhLT52aWYu
YnNzX2NvbmYudHhwb3dlcl90eXBlID0gdHhwX3R5cGU7DQorDQorCQkJaWVlZTgwMjExX3JlY2Fs
Y190eHBvd2VyKHNkYXRhLCB1cGRhdGVfdHhwX3R5cGUpOw0KKwkJfQ0KKwl9DQorDQogCXJldHVy
biAwOw0KIH0NCiANCmRpZmYgLS1naXQgYS9uZXQvbWFjODAyMTEvZHJpdmVyLW9wcy5oIGIvbmV0
L21hYzgwMjExL2RyaXZlci1vcHMuaA0KaW5kZXggYzdmOTNmZDljYTdhLi40ZDgyZmU3ZDYyN2Mg
MTAwNjQ0DQotLS0gYS9uZXQvbWFjODAyMTEvZHJpdmVyLW9wcy5oDQorKysgYi9uZXQvbWFjODAy
MTEvZHJpdmVyLW9wcy5oDQpAQCAtMTY1LDcgKzE2NSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBk
cnZfYnNzX2luZm9fY2hhbmdlZChzdHJ1Y3QgaWVlZTgwMjExX2xvY2FsICpsb2NhbCwNCiAJaWYg
KFdBUk5fT05fT05DRShzZGF0YS0+dmlmLnR5cGUgPT0gTkw4MDIxMV9JRlRZUEVfUDJQX0RFVklD
RSB8fA0KIAkJCSBzZGF0YS0+dmlmLnR5cGUgPT0gTkw4MDIxMV9JRlRZUEVfTkFOIHx8DQogCQkJ
IChzZGF0YS0+dmlmLnR5cGUgPT0gTkw4MDIxMV9JRlRZUEVfTU9OSVRPUiAmJg0KLQkJCSAgIXNk
YXRhLT52aWYubXVfbWltb19vd25lcikpKQ0KKwkJCSAgIXNkYXRhLT52aWYubXVfbWltb19vd25l
ciAmJg0KKwkJCSAgIShjaGFuZ2VkICYgQlNTX0NIQU5HRURfVFhQT1dFUikpKSkNCiAJCXJldHVy
bjsNCiANCiAJaWYgKCFjaGVja19zZGF0YV9pbl9kcml2ZXIoc2RhdGEpKQ0KLS0gDQoyLjE0LjEN
Cg==
