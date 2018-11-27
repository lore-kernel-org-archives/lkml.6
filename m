Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D528C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1560A20660
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="O8zT2ZV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1560A20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbeK1DR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:17:59 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:11920
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726390AbeK1DR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSet/S81Mtv6dpLYl3q2GiwQx64z/SUzI+ET131Z3Kw=;
 b=O8zT2ZV/WgQsltGwtwqPTpdcGhm8lrLWIOEm4emt+kxy9/5WtIEpySMMYHTPIMyRA0OfE7nTpUeFvDIlWZspmADudzUiDtmnoa7YcNuEmIOvymLP2ev9UJDPbInjJQsovO/0fWYJ1O/xqs1w+Ad4zaotV8L9klVSUiZq8LFxbSI=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2256.eurprd08.prod.outlook.com (10.172.13.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 16:19:30 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1361.019; Tue, 27 Nov
 2018 16:19:30 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [PATCH 1/7] lib/lzo: tidy-up ifdefs
Thread-Topic: [PATCH 1/7] lib/lzo: tidy-up ifdefs
Thread-Index: AQHUhmz5Dbhxk66+A0CD7vBvoJQ3/g==
Date:   Tue, 27 Nov 2018 16:19:30 +0000
Message-ID: <20181127161913.23863-2-dave.rodgman@arm.com>
References: <20181127161913.23863-1-dave.rodgman@arm.com>
In-Reply-To: <20181127161913.23863-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::23) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2256;6:F2l7ZqnQMIr8SkW2W7eU4EgYndYy9N5ZptTS0r4S51JA4ZNCf/b2LyFo2O5OI6D5RRrxthED4DRGbVMcMIJuXjAdzGR/+QZlYzzgBQCxNf2D80chtcPPxEvpRItUKhXwrS/QrL3c1yj0UXCRBbQmOzOnFzXwKFbeP1Qem/6faNem9o+GgEFEJY/9RnjlR2q9yoXYWdLNrsfnlTUQV7N2UgDW15FGFf3d9v1mJuKFTuc3v4iUXJyZhmM0SxaOej7yk18M9Ak/sipU+xXv5baLQoLBMtIGxxy+ewuue9feZwhVN8q64xTtboBN4IBTdD6rwnz71x/2iB0o6WjcOoUEMTYbspkbmF1IKFgQS9P6cmqvRFT6uutc+EXefNnzMo/nAxIqDa21zF8IEkODQDzouIERa6Xs4DR3CQck9eA6FCM51KyH7vYROtsafjJ33BlfFqd7EwW4fvN1Y4XBtavkIg==;5:uHob1wIwklvN0GWvqPLIiBLlZ7k55I0LCaJkpuKvEfIQ8IM8FtpYQivRlt8kHnBBfMXUbkElMHyMU7e4Nn1G9dcjRlDP3TJedT5PQetfBZiH7N/DRWscxE6if/kMnvUFL2udtGzPssq+SeRvuZDOU3rC9Bn5AEefC05jERxukIg=;7:bgJKaf4zcdSY1/IQobF1i2QaeIQgC9vi85pE01PZsaQs6uX/b+2Q6WFCjuYipBnpR02uanMio+Xe7PaeEhB2GDNqkfGrA/vt3i/mdC5kDeq/nyZQYvL9hbaxaCKORRy/2UIGF9MvUeKThu1bnxemhg==
x-ms-office365-filtering-correlation-id: ecc6d4d3-9041-477e-b092-08d654841c12
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2256;
x-ms-traffictypediagnostic: VI1PR0802MB2256:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB22569A447498B5257EA61C418FD00@VI1PR0802MB2256.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2256;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2256;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(2906002)(106356001)(105586002)(2351001)(256004)(6486002)(52116002)(53936002)(99286004)(6512007)(5660300001)(54906003)(7416002)(7736002)(6116002)(305945005)(1076002)(5640700003)(6916009)(446003)(486006)(3846002)(39060400002)(11346002)(76176011)(6436002)(316002)(476003)(2616005)(44832011)(68736007)(4326008)(102836004)(386003)(66066001)(71200400001)(36756003)(478600001)(25786009)(50226002)(26005)(6506007)(186003)(8936002)(8676002)(81156014)(81166006)(2501003)(97736004)(86362001)(71190400001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2256;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7inF5BoQBQx6Z7bXc6SkS7oziDzhnhXD7oDivDkt+bokmRqRVrx8VULOz2TdFM9yt15KsibeJc+lcBLN3mBEDMybLn+uttZU6M4C2nkK1hQKhM7MeQ8CnIx3qdvWrwSQsB7zjKKBiLpxMtJoNPpfn/OeYbdzZx1+selWJaKiW2mXGMGPvsU/ndUvuHHsjso+RK8j1LHUowTy4MpB1xvqAiqPcmusVeRzhrcJAjj2OmbWBiTikc7nDe3FhN7oR/lOhKJi2+NnZ8xT7Zm42bdZqnpyOTAv/DNdd7mpig1G0kABdVipKNErZQYoChNhjG/PAuxsZT2PCYZZLbnQJh1LnwFlxgj99GrSYTN8k5S79AM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc6d4d3-9041-477e-b092-08d654841c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 16:19:30.7040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the ifdefs in lzodefs.h to be more consistent with normal kernel
macros (e.g., change __aarch64__ to CONFIG_ARM64).

Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
---
 lib/lzo/lzodefs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
index 4edefd2f540c..497f9c9f03a8 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -15,7 +15,7 @@
=20
 #define COPY4(dst, src)	\
 		put_unaligned(get_unaligned((const u32 *)(src)), (u32 *)(dst))
-#if defined(__x86_64__)
+#if defined(CONFIG_X86_64)
 #define COPY8(dst, src)	\
 		put_unaligned(get_unaligned((const u64 *)(src)), (u64 *)(dst))
 #else
@@ -25,12 +25,12 @@
=20
 #if defined(__BIG_ENDIAN) && defined(__LITTLE_ENDIAN)
 #error "conflicting endian definitions"
-#elif defined(__x86_64__)
+#elif defined(CONFIG_X86_64)
 #define LZO_USE_CTZ64	1
 #define LZO_USE_CTZ32	1
-#elif defined(__i386__) || defined(__powerpc__)
+#elif defined(CONFIG_X86) || defined(CONFIG_PPC)
 #define LZO_USE_CTZ32	1
-#elif defined(__arm__) && (__LINUX_ARM_ARCH__ >=3D 5)
+#elif defined(CONFIG_ARM) && (__LINUX_ARM_ARCH__ >=3D 5)
 #define LZO_USE_CTZ32	1
 #endif
=20
--=20
2.16.4

