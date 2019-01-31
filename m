Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FCEC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193CF218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wpZQtf3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfAaOdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:33:09 -0500
Received: from mail-eopbgr810053.outbound.protection.outlook.com ([40.107.81.53]:47432
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfAaOdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnDICfok3t5sJqDzotg8N+qA2mExPVXetH46pPxPmbU=;
 b=wpZQtf3IRSwQSCEoWodc7E/0kviuoTXr2N09sEOII9nB8J0L+oiPHiagQ3oE1o8LvRFEV4+ZXvMqMgwGH8lQmzZcIIp6ezdfP8C1GtR/C+u3koQNiGYWHK6rpLvzQHjBZb29pVBqbciq2acpVRjmCItbaUVmkAQrHrX06xzwIJc=
Received: from MN2PR12MB3631.namprd12.prod.outlook.com (20.178.243.19) by
 MN2PR12MB3184.namprd12.prod.outlook.com (20.179.82.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 14:33:06 +0000
Received: from MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044]) by MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044%5]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 14:33:06 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/microcode/amd: Don't attempt to load older microcode
 patch
Thread-Topic: [PATCH] x86/microcode/amd: Don't attempt to load older microcode
 patch
Thread-Index: AQHUuXHhUCHAzHW+REelJrKbNwilcA==
Date:   Thu, 31 Jan 2019 14:33:06 +0000
Message-ID: <154894518427.9406.8246222496874202773.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:805:16::35) To MN2PR12MB3631.namprd12.prod.outlook.com
 (2603:10b6:208:cc::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3184;20:qH8h1fhr2NGT5VRo/95aQ6wjpVyvOhmki4ic6VKkFGicdmOolhGpy+8jLPYS74wxp3uiNwU+M1zSHq6bipyOqyCdUuZt6PQMkrZcRzu2x7fIePp4KnsjXl53VzWmcwHk6YAt03NJLmnQdMI3a8QtDiXzLIaKdUDLcWjfdGGQX5G8yx0NTthFlyuh7KwBlDmPhlwkq9qDjgJb8b4q9NtxQ9L7wTiqTUTf6Av33CcBEOys/4J4EPbiKh51sQzcibJ7
x-ms-office365-filtering-correlation-id: 569c4c04-7bf9-4804-91fb-08d6878903e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3184;
x-ms-traffictypediagnostic: MN2PR12MB3184:
x-microsoft-antispam-prvs: <MN2PR12MB318426C718CAC42C961E5184EC910@MN2PR12MB3184.namprd12.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(103116003)(110136005)(6436002)(3846002)(6116002)(26005)(186003)(305945005)(68736007)(7736002)(72206003)(81166006)(54906003)(86362001)(14454004)(478600001)(81156014)(316002)(386003)(53936002)(8676002)(102836004)(6506007)(6486002)(33896004)(106356001)(2906002)(25786009)(8936002)(14444005)(97736004)(2501003)(71190400001)(476003)(105586002)(256004)(4326008)(66066001)(9686003)(486006)(99286004)(52116002)(6512007)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3184;H:MN2PR12MB3631.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AUuIkU2olJ9RsT33rIuiWC/wV0Cl/HPMa7j1PyUmOrzQqi714EJ6WQi7D4bpCbQ+mdx53QoZe1XHFLB2infI2o2ffCyh9bcgTad5KGRU1vTeBf2TgdFCmCOxmHvV+G52oqPWXbMzpFSbsFAe8FKxJGSD6XA6BzSiwyK3zp8z+j24r1MnWY/TBsbi4qoDncmgBIK0HJoGpLHROh+5NWFyUjvbm1kxqUBhyaC+7ITKnzaTJezuLdXnKCftJP0UFWTJrUOcRcawEy345xoQNZqCBllGEDuS/HMHk9fPV1Blm++BlKCjBMfUpJ4MJdeN91G2bERoKoeO1Vq0Enz9JrLIHxyRqWfVS7Fpw5SxvH6GKlC4fAJgFyxaWUXh/SETnuzg68ToKnsj0vvYO+X/v8ckNklElBSxYlFnmknQmti8Iqs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A04227C132165746A1804EAC424F67E6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569c4c04-7bf9-4804-91fb-08d6878903e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 14:33:06.0020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGxvYWRfbWljcm9jb2RlX2FtZCgpIGZ1bmN0aW9uIHNlYXJjaGVzIGZvciBtaWNyb2NvZGUg
cGF0Y2hlcyBhbmQNCmF0dGVtcHRzIHRvIGFwcGx5IGEgbWljcm9jb2RlIHBhdGNoIGlmIGlzIGEg
ZGlmZmVyZW50IGxldmVsIHRoYW4gdGhlDQpjdXJyZW50bHkgaW5zdGFsbGVkIGxldmVsLiBXaGls
ZSB0aGUgcHJvY2Vzc29yIHdvbid0IGFjdHVhbGx5IGxvYWQgYQ0KbGV2ZWwgdGhhdCBpcyBsZXNz
IHRoYW4gd2hhdCBpcyBpbnN0YWxsZWQsIHRoZSBsb2dpYyBpcyBmb2xsb3dlZCBhcyBpZg0KdGhl
IHBhdGNoIHNob3VsZCBiZSBpbnN0YWxsZWQuIElmIHRoZSBmaWxlLXN5c3RlbSBjb250YWlucyBh
biBvbGRlcg0KdmVyc2lvbiBvZiBtaWNyb2NvZGUgdGhhbiB3aGF0IGlzIGN1cnJlbnRseSBydW5u
aW5nLCBhIGxhdGUgbWljcm9jb2RlDQpsb2FkIGNoZWNrIGNhbiByZXN1bHQgaW4gdGhlIGZvbGxv
d2luZyBtZXNzYWdlczoNCg0KeDg2L0NQVTogQ1BVIGZlYXR1cmVzIGhhdmUgY2hhbmdlZCBhZnRl
ciBsb2FkaW5nIG1pY3JvY29kZSwgYnV0IG1pZ2h0IG5vdCB0YWtlIGVmZmVjdC4NCng4Ni9DUFU6
IFBsZWFzZSBjb25zaWRlciBlaXRoZXIgZWFybHkgbG9hZGluZyB0aHJvdWdoIGluaXRyZC9idWls
dC1pbiBvciBhIHBvdGVudGlhbCBCSU9TIHVwZGF0ZS4NCg0KVGhlc2UgbWVzc2FnZXMgd2VyZSBp
c3N1ZWQgb24gYSBzeXN0ZW0gd2hlcmUgU01FL1NFViBhcmUgbm90IGVuYWJsZWQgYnkNCnRoZSBC
SU9TIChNU1IgQzAwMV8wMDEwWzIzXSA9IDBiKS4gRHVyaW5nIGJvb3QsIGVhcmx5X2RldGVjdF9t
ZW1fZW5jcnlwdCgpDQppcyBjYWxsZWQgYW5kIGNsZWFycyB0aGUgU01FIGFuZCBTRVYgZmVhdHVy
ZXMuIEhvd2V2ZXIsIGFmdGVyIHRoZSAobm9uKQ0KbGF0ZSBsb2FkIG9mIHRoZSBmaXJtd2FyZSwg
Z2V0X2NwdV9jYXAoKSBpcyBjYWxsZWQgYW5kIHJlc2V0cyB0aGUgU01FIGFuZA0KU0VWIGZlYXR1
cmVzIHJlc3VsdGluZyBpbiB0aGUgbWVzc2FnZXMuDQoNClVwZGF0ZSB0aGUgbWljcm9jb2RlIGxl
dmVsIGNoZWNrIHRvIG5vdCBhdHRlbXB0IG1pY3JvY29kZSBsb2FkaW5nIGlmDQp0aGUgY3VycmVu
dCBsZXZlbCBpcyBncmVhdGVyIHRoYW4gb3IgZXF1YWwgdG8gdGhlIHBhdGNoIGxldmVsLg0KDQpT
aWduZWQtb2ZmLWJ5OiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KLS0t
DQogYXJjaC94ODYva2VybmVsL2NwdS9taWNyb2NvZGUvYW1kLmMgfCAgICAyICstDQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rZXJuZWwvY3B1L21pY3JvY29kZS9hbWQuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUv
bWljcm9jb2RlL2FtZC5jDQppbmRleCA1MWFkZGUwYTBmMWEuLmUxZjNiYTE5YmE1NCAxMDA2NDQN
Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWljcm9jb2RlL2FtZC5jDQorKysgYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L21pY3JvY29kZS9hbWQuYw0KQEAgLTg1NSw3ICs4NTUsNyBAQCBsb2FkX21p
Y3JvY29kZV9hbWQoYm9vbCBzYXZlLCB1OCBmYW1pbHksIGNvbnN0IHU4ICpkYXRhLCBzaXplX3Qg
c2l6ZSkNCiAJaWYgKCFwKSB7DQogCQlyZXR1cm4gcmV0Ow0KIAl9IGVsc2Ugew0KLQkJaWYgKGJv
b3RfY3B1X2RhdGEubWljcm9jb2RlID09IHAtPnBhdGNoX2lkKQ0KKwkJaWYgKGJvb3RfY3B1X2Rh
dGEubWljcm9jb2RlID49IHAtPnBhdGNoX2lkKQ0KIAkJCXJldHVybiByZXQ7DQogDQogCQlyZXQg
PSBVQ09ERV9ORVc7DQoNCg==
