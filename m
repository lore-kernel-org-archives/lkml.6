Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC727C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817F72087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="DPyLB7Vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfARVVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:21:11 -0500
Received: from mail-eopbgr740074.outbound.protection.outlook.com ([40.107.74.74]:45216
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729539AbfARVVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5S6MYsUeT92p2SLbOd9Rcr8yCzWpYdQJwRLS7rc4xs=;
 b=DPyLB7VtJZMvl3TlzU6kyEIkg54MqCqtsECiZCVRc3XL2Q64I4PmLdYDlN/VQSX+yvvE+Yq0q0QiLjCivsV0xIvJEw00aj6xNzS6R4E1jkgGXeteCCwXSxpDm8a73FebhtW6cclKlPy7a+EOoPXw95KDXcTRu034qFSZfwfFpv0=
Received: from DM5PR06MB3161.namprd06.prod.outlook.com (10.174.240.148) by
 DM5SPR00MB2471.namprd06.prod.outlook.com (10.175.92.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Fri, 18 Jan 2019 21:21:08 +0000
Received: from DM5PR06MB3161.namprd06.prod.outlook.com
 ([fe80::4dff:a718:257f:c974]) by DM5PR06MB3161.namprd06.prod.outlook.com
 ([fe80::4dff:a718:257f:c974%4]) with mapi id 15.20.1516.019; Fri, 18 Jan 2019
 21:21:08 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.linux.org" <linux-nfs@vger.linux.org>
Subject: [GIT PULL] Please pull NFS client bugfixes for 5.0-rc3
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes for 5.0-rc3
Thread-Index: AQHUr3O6TJHvdY9bGUqtRh8n2fWlTQ==
Date:   Fri, 18 Jan 2019 21:21:08 +0000
Message-ID: <a8ab9ed89d15439b0d4332f2170a6aa5bf9bfb46.camel@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.4 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [2602:306:3097:450:83a8:291f:68f7:337c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5SPR00MB2471;6:XV2ZGyHtHuoQB+VuyZZDnMavaUglqgtng5HLAthPOrx1iNMip7ycZMQ4iS6l2dJszVZhL4HanIpsc0S2HeTeaszNvVHZpM3qkNetKdWBKMAZstkzsBU654RVuiuxw7Tuh9A8k9NiSYmfMzEbs1UKXC5GDU+ZryxKdjfEQ1ohDdtmHWUmWVA5w+0MjLyNmbpJZifNtqP5YZJ9iBlOcfb6WWQGqKmxUwHlvJbsnhoAmq630EqsENwJ6/wwV4fg7n2lCx51nOel1ckSqxkJ1rvlm3T/71BxrVgezcpNpoudXlyBd8aH93m8TJFPGx4w+n//wHNzZEGNwaaC6ki1jwnROLiaZY9TtCbHWhPCBlOSBIKjqsko38C8akP9RrcMYyLLWoBSzRZD3zwo9U8VRdjkNA8vBzAkOPwfB7eAL420kNPxMzj50s4Hbt+ujpAAtAMLC5S/7xUNDWHsf6rRsMQ02Q==;5:C6IvVH0OZNsHKe2PjPBKe5Zq5zHAcj/omFDoWq4bhh35sViXHBf8PXrb5B71hYznFRHBdF4r+9w8P2nLxOY81JCT6IyRFw1mAGX/Cb40b6l2L+fqpoQ5tD7jd673Y+TFIH0nGzruY6OlZa6/JVGOl44uKkW1diVYR9/Z+DS5En121yMIVcFfui0W/bFrOxGx81mYc/zP9Nmt07VyAU09Gg==;7:Cxh8GaZ2zhles9kMcQUw1luJP0lmIV2LzKpCUsr60tseCEoWuCHyLjYaJxvLWrWFk035Uk01JMp/uPt3fFEwKJkXUfhVOAJPbIs5PyYyyCZkyqFpBxe+fC3DES7TSq/cYX6vooUE5NeJiSBfMECmmw==
x-ms-office365-filtering-correlation-id: 43ee4a58-20f4-4d2e-b51f-08d67d8adceb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5SPR00MB2471;
x-ms-traffictypediagnostic: DM5SPR00MB2471:
x-microsoft-antispam-prvs: <DM5SPR00MB24713E605C291E9EAABE6C3CF89C0@DM5SPR00MB2471.namprd06.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(189003)(105586002)(486006)(71190400001)(36756003)(316002)(25786009)(6916009)(186003)(14444005)(14454004)(72206003)(256004)(2351001)(102836004)(2501003)(6506007)(53936002)(6116002)(478600001)(2616005)(476003)(6436002)(81156014)(71200400001)(81166006)(1730700003)(97736004)(5640700003)(99286004)(46003)(5660300001)(8676002)(68736007)(6486002)(2906002)(106356001)(305945005)(7736002)(8936002)(6512007)(58126008)(54906003)(4326008)(118296001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5SPR00MB2471;H:DM5PR06MB3161.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: onZ4tKtLj0g3cT4nklpy0791QNKRqI4TSLPMZEBE4fqUaCoT2y0ndkz6EHp1lT9Za9eSYz+5GD10PINzO2rCH+VvqHtthEvYluH/8Yi03BwLVFY70qmBnK5Zg/VL/3ak5ee9hswXtLODV49CYHRPwHeUY8hO4muLfx9ceVHYQ1NW2rM3q1psSZ4i8GCEEWAR4GK2WcQCvh0041HnMWZjcDBlfrs8tXGiNxqyqKEukG3DZOv8gF8H8S5ul8Egjso7+kyEGI8e/Z9CfN1GXFtmD+rjUgve2sumJu5E/VF2lKIcKfSOOPbOTy/nxbeJvIqgtzLnYNUSUZcQn3+J00KEFQq8MGTbvpOXu1lwwKeL2hBAUSwr4PxhmX+jU+O2rPjxqL6y4adekO8wnyA0C4/ZbiTnvRYI7cSURwgitYVx2to=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <39F4A2174597734AB2A097DF64488EF5@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ee4a58-20f4-4d2e-b51f-08d67d8adceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 21:21:08.3335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR00MB2471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgYmZlZmZkMTU1
MjgzNzcyYmJlNzhjNmEwNWRlYzdjMDEyOGVlNTAwYzoNCg0KICBMaW51eCA1LjAtcmMxICgyMDE5
LTAxLTA2IDE3OjA4OjIwIC0wODAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy9hbm5hL2xpbnV4
LW5mcy5naXQgdGFncy9uZnMtZm9yLTUuMC0yDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1
cCB0byBkZWFhNWM5NmMyZjdlOGI5MzQwODhhMWU3MGEwZmU4Nzk3YmQxMTQ5Og0KDQogIFNVTlJQ
QzogQWRkcmVzcyBLZXJiZXJvcyBwZXJmb3JtYW5jZS9iZWhhdmlvciByZWdyZXNzaW9uICgyMDE5
LTAxLTE1IDE1OjM2OjQxDQotMDUwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KVGhlc2UgYXJlIG1vc3RseSBmaXhl
cyBmb3IgU1VOUlBDIGJ1Z3MsIHdpdGggYSBzaW5nbGUgdjQuMiBjb3B5X2ZpbGVfcmFuZ2UoKSBm
aXgNCm1peGVkIGluLg0KDQpTdGFibGUgYnVnZml4ZXM6DQotIEZpeCBUQ1AgcmVjZWl2ZSBjb2Rl
IG9uIGFyY2hzIHdpdGggZmx1c2hfZGNhY2hlX3BhZ2UoKQ0KDQpPdGhlciBidWdmaXhlczoNCi0g
Rml4IGVycm9yIGNvZGUgaW4gcnBjcmRtYV9idWZmZXJfY3JlYXRlKCkNCi0gRml4IGEgZG91Ymxl
IGZyZWUgaW4gcnBjcmRtYV9zZW5kX2N0eHNfY3JlYXRlKCkNCi0gRml4IGtlcm5lbCBCVUcgYXQg
a2VybmVsL2NyZWQuYzo4MjUNCi0gRml4IHVubmVjZXNzYXJ5IHJldHJ5IGluIG5mczQyX3Byb2Nf
Y29weV9maWxlX3JhbmdlKCkNCi0gRW5zdXJlIHJxX2J5dGVzX3NlbnQgaXMgcmVzZXQgYmVmb3Jl
IHJlcXVlc3QgdHJhbnNtaXNzaW9uDQotIEVuc3VyZSB3ZSByZXNwZWN0IHRoZSBSUENTRUNfR1NT
IHNlcXVlbmNlIG51bWJlciBsaW1pdA0KLSBBZGRyZXNzIEtlcmJlcm9zIHBlcmZvcm1hbmNlL2Jl
aGF2aW9yIHJlZ3Jlc3Npb24NCg0KVGhhbmtzLA0KQW5uYQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpDaHVjayBMZXZl
ciAoMSk6DQogICAgICBTVU5SUEM6IEFkZHJlc3MgS2VyYmVyb3MgcGVyZm9ybWFuY2UvYmVoYXZp
b3IgcmVncmVzc2lvbg0KDQpEYW4gQ2FycGVudGVyICgyKToNCiAgICAgIHhwcnRyZG1hOiBGaXgg
ZXJyb3IgY29kZSBpbiBycGNyZG1hX2J1ZmZlcl9jcmVhdGUoKQ0KICAgICAgeHBydHJkbWE6IERv
dWJsZSBmcmVlIGluIHJwY3JkbWFfc2VuZGN0eHNfY3JlYXRlKCkNCg0KT2xnYSBLb3JuaWV2c2th
aWEgKDEpOg0KICAgICAgTkZTdjQuMiBmaXggdW5uZWNlc3NhcnkgcmV0cnkgaW4gbmZzNF9jb3B5
X2ZpbGVfcmFuZ2UNCg0KU2FudG9zaCBrdW1hciBwcmFkaGFuICgxKToNCiAgICAgIHN1bnJwYzog
a2VybmVsIEJVRyBhdCBrZXJuZWwvY3JlZC5jOjgyNSENCg0KVHJvbmQgTXlrbGVidXN0ICgzKToN
CiAgICAgIFNVTlJQQzogRml4IFRDUCByZWNlaXZlIGNvZGUgb24gYXJjaHMgd2l0aCBmbHVzaF9k
Y2FjaGVfcGFnZSgpDQogICAgICBTVU5SUEM6IEVuc3VyZSBycV9ieXRlc19zZW50IGlzIHJlc2V0
IGJlZm9yZSByZXF1ZXN0IHRyYW5zbWlzc2lvbg0KICAgICAgU1VOUlBDOiBFbnN1cmUgd2UgcmVz
cGVjdCB0aGUgUlBDU0VDX0dTUyBzZXF1ZW5jZSBudW1iZXIgbGltaXQNCg0KIGZzL25mcy9uZnM0
ZmlsZS5jICAgICAgICAgICAgICB8ICA4ICstLS0tLS0tDQogbmV0L3N1bnJwYy9hdXRoLmMgICAg
ICAgICAgICAgIHwgIDMgKysrDQogbmV0L3N1bnJwYy9hdXRoX2dzcy9hdXRoX2dzcy5jIHwgMTIg
KysrKysrKysrLS0tDQogbmV0L3N1bnJwYy9jbG50LmMgICAgICAgICAgICAgIHwgMjAgKysrKysr
KysrKysrLS0tLS0tLS0NCiBuZXQvc3VucnBjL3hwcnQuYyAgICAgICAgICAgICAgfCAgMyArKy0N
CiBuZXQvc3VucnBjL3hwcnRyZG1hL3ZlcmJzLmMgICAgfCAxMCArKysrLS0tLS0tDQogbmV0L3N1
bnJwYy94cHJ0c29jay5jICAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KIDcg
ZmlsZXMgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQo=
