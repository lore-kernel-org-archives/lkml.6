Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493641-2-8327738802795406008
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
    t=1521493641; b=s/R0+k2Z7HnZJpmF5RWErUL/ozcluI28iqHjVisXGtAyItG
    xijw2EQ2HTLSKo1coSD+i95LM9ZiknDi9EgDGhvyukIrOBClGu7F1clOuupWiyGY
    0AhyasajsA6ZL2kxiQmvtBx8Lwf125r2NS2eih0ZROM19GA9j9DPXvkLG4GSGa6g
    SqjXnYNGfJj79bQfXvwIrKqGZE5hT12KaZjnVOcyOatW7vlphWTrS6YwEFW/mx4l
    zMaEPZJ0b3F3LdvoiWz76Y0XqFgBnvWiX7ANbKDabFdqJD/R0tCboK2uEfAtcCiG
    450laa6JJuRKaP9j+lty0Ongmz/8Dn6WmWUnkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521493641; bh=G9GdJ0mgik0lxMSK0O2Je30/kdDY5OGKaVSlO9
    yJm1c=; b=t77QJqtgpFKi9RiKOsun31LO/7UlRzWJIQ8etJnXwoM4gB5/z2PJUv
    ee5Y/XThuCIKAvEtVq9WER7iXWX3YF3uH2D4kdyUboaPloIkIxRJ9uuYtHwugrAO
    t8mK+xFIdSLVs5KiPNcJA1MB49rniGEi+cG5QDh+OtBfgZOjrOqoS6wUNeVJgmq1
    8gSVSUNCFcDnqlDUpcDatGDCTLLZ1hzM9XJfLGSClepUqxu7X7HpdWu50b7SzW5R
    WCtSQIramx21iCqeFvdOPkXeU9/PLuRO5Yvc2zS9WX+ZMlgyoayAeVnr7lZOgvUd
    6QNtV98vB1p28sjQvGYmb5NmZXivlPOw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o7LrR9fE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduvdehleefnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o7LrR9fE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduvdehleefnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936013AbeCSVGM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:06:12 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:15805
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965385AbeCSQCH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?UGV0ZXIgR3Jvw59l?= <pegro@friiks.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 140/281] mac80211: Fix setting TX power on
 monitor interfaces
Thread-Topic: [PATCH AUTOSEL for 4.9 140/281] mac80211: Fix setting TX power
 on monitor interfaces
Thread-Index: AQHTv5ts0zeiD5J/LkecNqpSAKG44Q==
Date: Mon, 19 Mar 2018 16:00:38 +0000
Message-ID: <20180319155742.13731-140-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:HdyAEsaq/cydt66Mk990sDaLEE5rzgK3R5J3b8b7e9Os9UUwwgqF/DptJznXe8yVAgODAa4b869LV+9PaMRAURHm9cp6rTRa1ABo0lNlup3vBFGVj0kbyV/4v68xuSlkorSVqPbnfu1AvHL2fCz/GlrW9TFIUEoqJ1ejeUB2I8zos8o4sWZoJseiTmrBTXWB8mG8vH4finC3YqKj+tObdvotaO9SJGPzyBov+pCgjEtgYcgl06wHwVd6kSEh76HT;20:p3busOZgSl1uhuYxsKO/R0Ulek9bEf5Fa4bsCdX99RcImXd6O7V6iRMpE8+YEfcvUybb09KR+19aRXU8byEBpMzuGTKSWEUE5XGGjFxsq63zOyEnGak88/Pn70u4e7FpsSCEzaKbQnWDG2w50tciQ7qMgZQ8veTkgOQrYBXwUjQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6b77354-a1a7-481d-c2e3-08d58db2bb91
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919437E1F062CCD191ED309FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: fl24M/ZIYp6EUREPf28edOUFXj8u1dQa0RKJwekpzYx91rEFTldHLHNkfUXvG6SAdwBe6FUOlrxA9YL53PCeKJR0m8vg0jRUA6oltEGtU19mgxt6SaE/ocE9s0dSVlCs8MvhrOuA4qLlITy4u5Q/b8pHa3/ZpaaKn7J+a0vXZ3rbsH/mXfm7BSQLo+T2ZmwIh+/RbGzunhoQlhJi4nG4Dswcu1f5hsTVdkJMBZvSt01oFV2jMXJ5yHAX6FaEB5VL/qA3TXR0vQ9/q+OsbvXtQssgo3491ug71ZejBYssiydRox2w68+R3TM54p0fyfa57F75QZ1QqMsddAqsh2J83g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <159CA2DF10CC304391C8FB905B6421EE@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b77354-a1a7-481d-c2e3-08d58db2bb91
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:38.9065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
IGRlZTYwNDI4Yzc4Yy4uZmRiZDg0ZjdkOGVlIDEwMDY0NA0KLS0tIGEvbmV0L21hYzgwMjExL2Nm
Zy5jDQorKysgYi9uZXQvbWFjODAyMTEvY2ZnLmMNCkBAIC0yMzM3LDEwICsyMzM3LDE3IEBAIHN0
YXRpYyBpbnQgaWVlZTgwMjExX3NldF90eF9wb3dlcihzdHJ1Y3Qgd2lwaHkgKndpcGh5LA0KIAlz
dHJ1Y3QgaWVlZTgwMjExX3N1Yl9pZl9kYXRhICpzZGF0YTsNCiAJZW51bSBubDgwMjExX3R4X3Bv
d2VyX3NldHRpbmcgdHhwX3R5cGUgPSB0eXBlOw0KIAlib29sIHVwZGF0ZV90eHBfdHlwZSA9IGZh
bHNlOw0KKwlib29sIGhhc19tb25pdG9yID0gZmFsc2U7DQogDQogCWlmICh3ZGV2KSB7DQogCQlz
ZGF0YSA9IElFRUU4MDIxMV9XREVWX1RPX1NVQl9JRih3ZGV2KTsNCiANCisJCWlmIChzZGF0YS0+
dmlmLnR5cGUgPT0gTkw4MDIxMV9JRlRZUEVfTU9OSVRPUikgew0KKwkJCXNkYXRhID0gcnRubF9k
ZXJlZmVyZW5jZShsb2NhbC0+bW9uaXRvcl9zZGF0YSk7DQorCQkJaWYgKCFzZGF0YSkNCisJCQkJ
cmV0dXJuIC1FT1BOT1RTVVBQOw0KKwkJfQ0KKw0KIAkJc3dpdGNoICh0eXBlKSB7DQogCQljYXNl
IE5MODAyMTFfVFhfUE9XRVJfQVVUT01BVElDOg0KIAkJCXNkYXRhLT51c2VyX3Bvd2VyX2xldmVs
ID0gSUVFRTgwMjExX1VOU0VUX1BPV0VSX0xFVkVMOw0KQEAgLTIzNzksMTUgKzIzODYsMzQgQEAg
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
L21hYzgwMjExL2RyaXZlci1vcHMuaA0KaW5kZXggMDlmNzdlNGE4YTc5Li40OWM4YTljOWI5MWYg
MTAwNjQ0DQotLS0gYS9uZXQvbWFjODAyMTEvZHJpdmVyLW9wcy5oDQorKysgYi9uZXQvbWFjODAy
MTEvZHJpdmVyLW9wcy5oDQpAQCAtMTY0LDcgKzE2NCw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBk
cnZfYnNzX2luZm9fY2hhbmdlZChzdHJ1Y3QgaWVlZTgwMjExX2xvY2FsICpsb2NhbCwNCiAJaWYg
KFdBUk5fT05fT05DRShzZGF0YS0+dmlmLnR5cGUgPT0gTkw4MDIxMV9JRlRZUEVfUDJQX0RFVklD
RSB8fA0KIAkJCSBzZGF0YS0+dmlmLnR5cGUgPT0gTkw4MDIxMV9JRlRZUEVfTkFOIHx8DQogCQkJ
IChzZGF0YS0+dmlmLnR5cGUgPT0gTkw4MDIxMV9JRlRZUEVfTU9OSVRPUiAmJg0KLQkJCSAgIXNk
YXRhLT52aWYubXVfbWltb19vd25lcikpKQ0KKwkJCSAgIXNkYXRhLT52aWYubXVfbWltb19vd25l
ciAmJg0KKwkJCSAgIShjaGFuZ2VkICYgQlNTX0NIQU5HRURfVFhQT1dFUikpKSkNCiAJCXJldHVy
bjsNCiANCiAJaWYgKCFjaGVja19zZGF0YV9pbl9kcml2ZXIoc2RhdGEpKQ0KLS0gDQoyLjE0LjEN
Cg==
