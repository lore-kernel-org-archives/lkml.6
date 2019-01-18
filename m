Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0791FC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65172087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="npo16viF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfARVUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:20:32 -0500
Received: from mail-eopbgr820049.outbound.protection.outlook.com ([40.107.82.49]:48328
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729539AbfARVUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5S6MYsUeT92p2SLbOd9Rcr8yCzWpYdQJwRLS7rc4xs=;
 b=npo16viFJukQEE1ShATuIw2igcm2FY5mMlWrrW14+o44qqeCJXVEYNwqsPk1S5RQDPCrjSgipCT/INL/D8RlyV7v/4LHod2O6FXXTiSXLP8BbdWIKXgbOLS4WIezeA4xPWjFYCD+R71tAlRUOCbbSvliNaUmCFvTH12+B5NH23A=
Received: from DM5PR06MB3161.namprd06.prod.outlook.com (10.174.240.148) by
 DM5PR06MB3115.namprd06.prod.outlook.com (10.174.240.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Fri, 18 Jan 2019 21:20:28 +0000
Received: from DM5PR06MB3161.namprd06.prod.outlook.com
 ([fe80::4dff:a718:257f:c974]) by DM5PR06MB3161.namprd06.prod.outlook.com
 ([fe80::4dff:a718:257f:c974%4]) with mapi id 15.20.1516.019; Fri, 18 Jan 2019
 21:20:28 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.linux.org" <linux-nfs@vger.linux.org>
Subject: [GIT PULL] Please pull NFS client bugfixes for 5.0-rc3
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes for 5.0-rc3
Thread-Index: AQHUr3OiynSEES372U2gyU17GJjcvA==
Date:   Fri, 18 Jan 2019 21:20:28 +0000
Message-ID: <d64e31f9e6021428fc2d3765da01e5976f1a9923.camel@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.4 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [2602:306:3097:450:83a8:291f:68f7:337c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR06MB3115;6:obSQrqf8E8CwJ3jJCJ5VHg9VM1AjHGQQxzopMTUusgygmx7jmWWfAhH79WekQBVVADv8jkgD8Z232geUeZJpmHizBDFqjgOMZRJWVeVXuObDv091KJuuUgpBn0X7LmOa9khXRGvJn0EIvo2njN9yRBVnlWH7T2imFwuGzHewb4Mb10hO/Tf56Lr0DERnq4MSNZkiSAZIDK9plMhNxN4fQferARyJ9CNGmeg1Qa7pR3O9j2jSpBkFQTPJCTEIOjQEjXX0hoUKK2pJlWDOP5TdzPsVaAY00xZKMl1EiPzAHu+guOC9/a4LGrvP8FHtciefznSExNqrTtqxxEEMtJ15QEqIMdcn6ZLjCIi5kpw1B/FXhc+qtUOMaZH7t89s2TqULepcmlegh6yyTzpfCC5+yR8nc/MwLPKCT5ekINmcOkuptmo+jtNburieN76KvVyprcyr4+Mi4Y01Ni4bqfAG9g==;5:2/ZBKV5cuDbdckrmKqFAxSlw/zUHsSgK3TfrV9bXa94Yomy2YUu9QTukPv1DU4IILwI8kuYdemfSUbFIx7tK3CMmLD+knJ8iggIt3qv2FJBJvXI5LkT91D0kSY/nOgMBKhS4q+dWOQQSiR1jGShr3fxCOdTpzMb0av+WH99KKonXZCldc7tWrjv+W8+DA0G13kf4dgRdN8ShvABiZIawzg==;7:T62m9Z4wMogUBqWBedGZ+Ik41jw8amXLJFcbPqgICI1xnFINCN/iek6IH/n9Z5GGpasX0Bplln8qbHKUgbFFTNvSEkwFCQU5nWESiYB1rAy0V/fbm6tjTYICBaFkHYEhOHk8Ume59kDpc+ssP/xm8w==
x-ms-office365-filtering-correlation-id: cc1af658-1945-4060-661b-08d67d8ac54d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7193020);SRVR:DM5PR06MB3115;
x-ms-traffictypediagnostic: DM5PR06MB3115:
x-microsoft-antispam-prvs: <DM5PR06MB3115D3D1CCF242D63F673E4AF89C0@DM5PR06MB3115.namprd06.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(366004)(346002)(189003)(199004)(6506007)(6512007)(97736004)(5660300001)(6916009)(316002)(71190400001)(71200400001)(8676002)(4326008)(99286004)(102836004)(256004)(6436002)(5640700003)(58126008)(36756003)(186003)(305945005)(14444005)(54906003)(46003)(6486002)(7736002)(2501003)(68736007)(72206003)(2906002)(53936002)(14454004)(86362001)(118296001)(476003)(81156014)(105586002)(1730700003)(106356001)(25786009)(478600001)(2616005)(2351001)(81166006)(486006)(8936002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3115;H:DM5PR06MB3161.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u/tw0XSAg93e4E59sQVA24o2GvPXDggojBgJpwX5up2dwB8j+XuPn2rULvoOS9tnLw9W4Q+c0lV/EfcnLmC5AE1RDuaSYYLHWdz7ztthOvg9VjjZg3iQuvwdJX2haYVZ93aNuxosBb/1BaLwI3cvxCVC3uPrz+MygLY8ohqH8xieMKQaDfCqlKlfZ4SNa3cdkH1E3jpvzAqxB4fMSVgl0F26BOC2lSWr1luHcWZY3LIIlWOTd2xZti2av18crdqHpZam2OVmqzOqeWhUO7WkPHZmSlvOxw3s4rEhQZUyg38puxRJGzFuYLx/zOzr4yCOFpb6NJTEHDwC7xw1wjGVcTkgOm/zXF2nAHjjSKCeaD9lQlgYRfGLqcwz+aTQyDyo1nyEpPfKM5kJrUj/t2YS0pzNzIYlQyxCMMmVxyfQ7DA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <68867AE5A0C71C46BEFA14075E7BA23E@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1af658-1945-4060-661b-08d67d8ac54d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 21:20:28.7240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3115
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
