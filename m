Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CDFC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565BE2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="fhKRWl0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565BE2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeKIJW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:22:57 -0500
Received: from mail-eopbgr730120.outbound.protection.outlook.com ([40.107.73.120]:30368
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727016AbeKIJW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLsfMvuFiw3nMm95TlLx3HfVMmVD1YQBeNWc7iSg9ms=;
 b=fhKRWl0aKZnmOaYV+s8ei5ceiuu+visGlTlbSWJnmawKeofQ5RM5IxOpbMZZYnSas9AJOfI3uh0rzUlBMJdQld0WD0oOvHuTqnXJZKyrqC4oCICIAFvev8HKziaf8yvV+XuoiI1GQg4QnLywN4zWF9LUVTJmcVEPc0c9m/J5wnM=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1757.namprd22.prod.outlook.com (10.164.133.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 8 Nov 2018 23:44:57 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 23:44:57 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: [PATCH 2/2] lib/gcd: Remove use of CPU_NO_EFFICIENT_FFS macro
Thread-Topic: [PATCH 2/2] lib/gcd: Remove use of CPU_NO_EFFICIENT_FFS macro
Thread-Index: AQHUd70OIrEKngo1F0mKIBkwbyHR9Q==
Date:   Thu, 8 Nov 2018 23:44:56 +0000
Message-ID: <20181108234409.21199-2-paul.burton@mips.com>
References: <20181108234409.21199-1-paul.burton@mips.com>
In-Reply-To: <20181108234409.21199-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0074.namprd22.prod.outlook.com
 (2603:10b6:301:5e::27) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1757;6:jToF7ckdzvNJ/45n1YBdh1fjcjky1rOYjInyvAxdjJAqgstvriR9DOJnuMmAR4cVJflArMDE/oJPdVujgGU++bnG3OpesRhrnxxzFvSR6nx4WL7k3zHnZSTxTqle9B0lc+/SFmWeRc8xXWCPTXfkW5lrp6ENLEz7N6ulClU4wBQZC6N5jSUoAHl+GuCJ5eI9FWvQSsej5iM/9dq71N+ZIAj5EB4lrR5aIVSFGoM/pPKk7nmqa3hTDiA8gEpXEt+9dGj597rw70Xgu1xi1MKCMKdiBDN6rQlffBjhB9gCyscWbhEfjT7lB4SU7ymM3OEa4FmKffUKh5599Ey5+hpRk3cnGUAx5bD/JOWM+hDgymkKQXVO9qnNAg30L00DESniDN4JewPm3NJ7YexPVCai2J8VGI8yB7cxaTQH1Pz5QcsTPl2Aq3v2O6Qz13m+XvWbtrg8UDFcQqKJgpR5YyN3gQ==;5:EIEjnTiwsxR5LwihPWDx0dXCxnB5dKJDW5F1Zg0Yv+ici8s6+cvm6DpJHZMuh27EFcmYLXGXUTsj9a+uP6t9a66Z7YUnjo3FdxtKPLwHCXSccM7x8wVqlmS86shjDVAE/OnTpVoBOYjH8Yc3K5sFYrE0VoXCljnjZYAYkGkLIfs=;7:DOdrRk2kL5fBUlvUqgTuXkbIqFmZi30Mm0gSHTFPs4rN6sFbLz5kOc5aRtgUZbboBDTFW4IPfHKXSJbEljyQ1t9MMW3zcZykDxecoagd5Piz6wX520femTGLuIepJzo56FrPWtPAUQy2g1d5IdA5Bw==
x-ms-office365-filtering-correlation-id: a5e444af-3e6c-42bc-a374-08d645d4305d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1757;
x-ms-traffictypediagnostic: MWHPR2201MB1757:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-microsoft-antispam-prvs: <MWHPR2201MB1757E6E29A203C662CD7D370C1C50@MWHPR2201MB1757.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231382)(944501410)(52105095)(93006095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1757;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1757;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(136003)(376002)(396003)(346002)(189003)(199004)(186003)(1076002)(316002)(26005)(2351001)(14444005)(256004)(2906002)(105586002)(7736002)(305945005)(106356001)(575784001)(8676002)(76176011)(6116002)(81166006)(8936002)(81156014)(3846002)(99286004)(68736007)(52116002)(102836004)(386003)(54906003)(2900100001)(6506007)(39060400002)(446003)(11346002)(53936002)(4326008)(2501003)(508600001)(44832011)(25786009)(5660300001)(486006)(71200400001)(6512007)(2616005)(71190400001)(476003)(97736004)(66066001)(14454004)(6486002)(42882007)(6916009)(6436002)(5640700003)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1757;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L3q9uCwe7YXuipdo9mIhA56fIm+SFrpFYd+lMmGFaZvMs4AVzkKzQpY0yjyjf0VDo6M3Ichjd36bLfASiHu+kA7TfawAxDTH0adVr1cS7XVNjdVGOz7oJnM1+n5qIeenknU80KKd8O14zjARx3d8q8bSK7EQgnGZxt6OEMDpeGj8IoDCk5YWf42RqWfe2kqRLw6w+A1r1Jzz0hOhTtlzDzINo+dtZYz/UWudLe3EmTiUnKE5i6v5ocrc+3UCj7dVGvm2Px9gPjjgYOGg8lw8dlucdOcGbnkUOF4rlbLSnlI5YoMYkVtdBbD8iHpGtqHYMP+01LpqY1Z37sYtKJP4AfkCUN0DkkJ5KoGMQoVUQt8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e444af-3e6c-42bc-a374-08d645d4305d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 23:44:57.0053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU_NO_EFFICIENT_FFS pre-processor macro is no longer used, with all
architectures toggling the equivalent Kconfig symbol
CONFIG_CPU_NO_EFFICIENT_FFS instead. Remove our check for the unused
macro.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

---

 lib/gcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/gcd.c b/lib/gcd.c
index 227dea924425..7948ab27f0a4 100644
--- a/lib/gcd.c
+++ b/lib/gcd.c
@@ -10,7 +10,7 @@
  * has decent hardware division.
  */
=20
-#if !defined(CONFIG_CPU_NO_EFFICIENT_FFS) && !defined(CPU_NO_EFFICIENT_FFS=
)
+#if !defined(CONFIG_CPU_NO_EFFICIENT_FFS)
=20
 /* If __ffs is available, the even/odd algorithm benchmarks slower. */
=20
--=20
2.19.1

