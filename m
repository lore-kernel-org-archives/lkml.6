Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ADCC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FD52081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kvg7ewro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FD52081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeLDW10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:27:26 -0500
Received: from mail-eopbgr790072.outbound.protection.outlook.com ([40.107.79.72]:9666
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbeLDW1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsoQcqxROloOahMuC/B6HG1jASeLP38UndCAcR9Hosw=;
 b=Kvg7ewrowOeqb7aMzuUFicTOLuDyzypMdbJ6p6C3uk669ViK9mRGPFjp2erIwAeraCCbWFtn1XAe64GmHWfkWxLJ9IKvHXWF1huj/RwjvUwZraj53qha4Q153BnBJgrOQkRcp2OiiMAyMIr5Hj9NApdPcYvIRqZF6ZqQ/VmOFMs=
Received: from DM2PR12MB0169.namprd12.prod.outlook.com (10.161.145.20) by
 DM2PR12MB0361.namprd12.prod.outlook.com (10.161.147.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 22:27:21 +0000
Received: from DM2PR12MB0169.namprd12.prod.outlook.com
 ([fe80::412b:7d8b:b5d1:fe7]) by DM2PR12MB0169.namprd12.prod.outlook.com
 ([fe80::412b:7d8b:b5d1:fe7%6]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 22:27:20 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] x86/umip: Make the UMIP activated message generic
Thread-Topic: [PATCH] x86/umip: Make the UMIP activated message generic
Thread-Index: AQHUjCCFH8x+LgP8GkWS/ubsimhkSA==
Date:   Tue, 4 Dec 2018 22:27:20 +0000
Message-ID: <20181204222718.9375.11043.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0113.namprd12.prod.outlook.com
 (2603:10b6:802:21::48) To DM2PR12MB0169.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR12MB0361;20:tZsg1n/XQhot9SpbMWWwLfM63LqYUnsEhJDrACwgS7VNtLIMJa3J451FgHJnq4VAxoKwWGCIs2peIL5/8YUd4glQeEiRMk24Xnc7kIdlPjXxsQdnhIa94zEDrnufxx9PX9WKa35ed1xoAztzfSEKTfB20KgypwY+MY27g7BWnvDbvLxdhS18aYnFnXPKnEqRe5amhHGvx5B/rnL2IVvVccdwuZl3TIkZHnRXAfPMGaGLNZyRTIcUg/6iFMBF6/kG
x-ms-office365-filtering-correlation-id: 72f87541-d16e-4c66-5d8f-08d65a37a7dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0361;
x-ms-traffictypediagnostic: DM2PR12MB0361:
x-microsoft-antispam-prvs: <DM2PR12MB0361705B82D7C0C4D4EA9B14ECAF0@DM2PR12MB0361.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(10201501046)(3231455)(999002)(944501515)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM2PR12MB0361;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0361;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(189003)(199004)(81166006)(71190400001)(86362001)(81156014)(8676002)(71200400001)(66066001)(478600001)(25786009)(106356001)(256004)(14444005)(2351001)(2906002)(72206003)(6916009)(105586002)(103116003)(33896004)(4326008)(6486002)(14454004)(102836004)(6436002)(26005)(5640700003)(486006)(97746001)(6116002)(476003)(3846002)(186003)(15650500001)(68736007)(99286004)(52116002)(53936002)(7736002)(6512007)(9686003)(5660300001)(8936002)(305945005)(97736004)(1076002)(6506007)(386003)(54906003)(2501003)(316002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0361;H:DM2PR12MB0169.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8Kx7PgI2r8JrD3Wh9/Y4Do4LiTZShhOpmU/380/GWOwVEExljME5ekLzLC+iLZtN4lcEyxZBbgB7Rz1BbgTZmSyKmg/dfpkz7ZtbWAaFprBPxn9IXlvN1AbDpSwPeQo1vbhSd+sU0GqjGxotsBdXT80D2px3hv63wFamqsymSXtl64XJpERb1/oiaYSigMGFA1tIqt3pDemq1fA7l8QpL8rO+RcvNDunybAUJKnLWxEAqUirNhsG4+UJ8fgGXsojCAm7J1a6HuP5Bk6HdIGdtdEMUD5gKcr098RTvdGF8z7ALRdUYh21lln2V5zMFpd6AglqFK9LYiH/CxM5+zRoORPEAkO54jC1QBR8Lg0ZhDw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE12BBFCA709024B8C04166C2313730C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f87541-d16e-4c66-5d8f-08d65a37a7dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 22:27:20.8098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0361
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIFVzZXIgTW9kZSBJbnN0cnVjdGlvbiBQcmV2ZW50aW9uIChVTUlQKSBmZWF0dXJlIGlzIHBh
cnQgb2YgdGhlIHg4Nl82NA0KaW5zdHJ1Y3Rpb24gc2V0IGFyY2hpdGVjdHVyZSBhbmQgbm90IHNw
ZWNpZmljIHRvIEludGVsLiAgTWFrZSB0aGUgbWVzc2FnZQ0KZ2VuZXJpYy4NCg0KU2lnbmVkLW9m
Zi1ieTogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCi0tLQ0KDQpUaGlz
IHBhdGNoIGlzIGFnYWluc3QgdGhlIHg4Ni9jcHUgYnJhbmNoIG9mIHRoZSB0aXAgdHJlZToNCiAg
Z2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RpcC90aXAuZ2l0
IHg4Ni9jcHUNCg0KIGFyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMgfCAgICAyICstDQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9jb21t
b24uYw0KaW5kZXggMmM1NmI4MC4uY2IyOGU5OCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5l
bC9jcHUvY29tbW9uLmMNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCkBAIC0z
NTMsNyArMzUzLDcgQEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIHNldHVwX3VtaXAoc3Ry
dWN0IGNwdWluZm9feDg2ICpjKQ0KIA0KIAljcjRfc2V0X2JpdHMoWDg2X0NSNF9VTUlQKTsNCiAN
Ci0JcHJfaW5mb19vbmNlKCJ4ODYvY3B1OiBJbnRlbCBVc2VyIE1vZGUgSW5zdHJ1Y3Rpb24gUHJl
dmVudGlvbiAoVU1JUCkgYWN0aXZhdGVkXG4iKTsNCisJcHJfaW5mb19vbmNlKCJ4ODYvY3B1OiBV
c2VyIE1vZGUgSW5zdHJ1Y3Rpb24gUHJldmVudGlvbiAoVU1JUCkgYWN0aXZhdGVkXG4iKTsNCiAN
CiAJcmV0dXJuOw0KIA0KDQo=
