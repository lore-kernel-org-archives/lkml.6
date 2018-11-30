Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD696C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AFA2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="e+yLdslV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AFA2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeLABfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:35:55 -0500
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:30574
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbeLABfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvm4XoRVcy7jGILPlVC9Pi+JYamPsOqzbrounse2FTk=;
 b=e+yLdslVwdMqtitYvFMl1yLzOZHZ0ZQiV+RMNl2W9BPu/eHEtuAl/v7bxyoNS0WvyT5D1hsjrK00WktJ30sFK1I0pP/N3laq69jTMhIewb1WyJeT7iv5e1nf4WrUYHNcofV60OydKIyvgxE4Z3YOUTen3PhwjeWiHO5iEBEZt30=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2415.eurprd08.prod.outlook.com (10.175.25.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 14:26:22 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 14:26:22 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: [PATCH 1/8] lib/lzo: tidy-up ifdefs
Thread-Topic: [PATCH 1/8] lib/lzo: tidy-up ifdefs
Thread-Index: AQHUiLirBc9LPR0670aMEqZrPH0aBg==
Date:   Fri, 30 Nov 2018 14:26:22 +0000
Message-ID: <20181130142600.13782-2-dave.rodgman@arm.com>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
In-Reply-To: <20181130142600.13782-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.53]
x-clientproxiedby: CWLP265CA0336.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:57::36) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2415;6:KajD5GNtYwe41abGHSa4tjyIkE7SZVjQLK3s04a2TKPidtkCEJi6ZeOMXQLu6XTYtFpZcmDLcq9PoAx8ZZg2zTEEb4x5T2Us4I7sPLjiY8Ls1iXFycic5KN9qhq0Iy6/+kWGaglg+w7BJ55cpV+29pKLW05PMZg31xm0mS9HIT3YdDqMaaZlydYOXvCCg8OKZ13IG97AB2YwLJInRwz1y5tX3XCLiwO0aQJKrsSvNlnR75wUTpM4T2fWTAAAH0/kuzm3rmkXAKUrTIwoZ1EVdrdttnkz10izB+D56cKKxDvS0W2EGafvyD+KGmXErB6XL03AuB9bLDzEahuK3t1gVoQWgpc6U+fJGo52Yp40Z8+3VnZR/4ivp0VKtxmZERuIKOsLIEzgGoat6EfSx7MWPShPWYVepCsOPu9Pbmdxh/M8psBESa5m3mck+CzFKGTLOkQa+qls+fg4BZO3C1v9Fg==;5:PgKEklQX1wRxQmvm3pCXKZsd/c88kUv2rNxUv1TC0JLbuW3qhDruQYNk63dj4E1iX4npQXWaT3RhMRTmSBtzxByx8R/FinywcbzJ9a7FBkdBYE2OZQnEb5lW+Yu4riaF9+/xVSahPQ+yz+BvoJy1+YtSCS2ku8XYxwJsN5TsoH8=;7:NJUzvur7Fe1HYTvAlF64OAlyzmrMSisDshfzzYTzODQT/9GBdsAhcy6g8YlUTY+xKJErx1nnbEtm2/mukWVSAXJtEaP19UtjZxA/nGWFLB6lKqS//FJ2+WVh45nWdiE9pc8szRzQ1HE1WjPwygRvvw==
x-ms-office365-filtering-correlation-id: 5d8a1d76-3c53-4ff6-2009-08d656cfcd57
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2415;
x-ms-traffictypediagnostic: VI1PR0802MB2415:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB241510943C2834F260FB3E7C8FD30@VI1PR0802MB2415.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501466)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2415;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2415;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(386003)(5660300001)(476003)(50226002)(11346002)(486006)(8936002)(446003)(6486002)(7416002)(39060400002)(25786009)(6506007)(2616005)(44832011)(6436002)(4326008)(66066001)(102836004)(6512007)(110136005)(71190400001)(71200400001)(76176011)(81166006)(305945005)(81156014)(52116002)(99286004)(186003)(26005)(316002)(8676002)(54906003)(14454004)(97736004)(68736007)(1076002)(256004)(7736002)(2906002)(478600001)(106356001)(105586002)(36756003)(6116002)(2501003)(86362001)(53936002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2415;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p32aA56mIFnIw44EDtXjSVZvFXrMqO7z3SSKJgJha3piEkpuy2FhnyLr30HNh1B2MbJa0rxcw07tGd/nEKrhQfDeRQMFF0kTXbyjCu3+vQ/nTYupHesKrE/9bAEJ9C5UfKLMexPwrNB906HfAur6g/I6E5Y4Ahs9FQHV6ibBWy7URS5pXmbJNtsYRuJu0+GNqZ4dFXpDTMFoIw9v6y4gpv8SKHVHkXl6tM1XFzy1N1I3Y1HaAxJiSe/LgThkmnqtyS/Tnmgpbh2A0RM0iZo11rqyK9l0PuqyaNse79yMx9t8UQRkgam1X3nP2+LkjzV/dewPgKBmbX9SAGeY2sjTQEWgGRbCoLkjjrfo9aPZm1c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8a1d76-3c53-4ff6-2009-08d656cfcd57
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 14:26:22.5274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the ifdefs in lzodefs.h to be more consistent with normal kernel
macros (e.g., change __aarch64__ to CONFIG_ARM64).

Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Nitin Gupta <nitingupta910@gmail.com>
Cc: Richard Purdie <rpurdie@openedhand.com>
Cc: Markus F.X.J. Oberhumer <markus@oberhumer.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sonny Rao <sonnyrao@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matt Sealey <matt.sealey@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
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
2.17.1

