Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDAFC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B338D217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WogKkukD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfBEOUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:20:10 -0500
Received: from mail-eopbgr20075.outbound.protection.outlook.com ([40.107.2.75]:22565
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727302AbfBEOUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvm4XoRVcy7jGILPlVC9Pi+JYamPsOqzbrounse2FTk=;
 b=WogKkukDqCpjynjiHHG6XrTPGL68D1LzUZj3hCN5sqjdQnUVXAgciloKmn+TRSrQ4QT/6JyOghRv/rzmGvTpIqQsNXjZpzJY8ew67uTZZGpTlNfdjaf0IXnBIkCNEuXsQH5Q4ehgsIBI/RHbwvQHGSitiZVG3pdgcRadXVChZC0=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2158.eurprd08.prod.outlook.com (10.172.12.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 14:20:04 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::7446:fa53:3f15:c96c]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::7446:fa53:3f15:c96c%4]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 14:20:04 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matt Sealey <Matt.Sealey@arm.com>,
        Dave Rodgman <dave.rodgman@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
CC:     nd <nd@arm.com>
Subject: [PATCH v5 1/3] lib/lzo: tidy-up ifdefs
Thread-Topic: [PATCH v5 1/3] lib/lzo: tidy-up ifdefs
Thread-Index: AQHUvV3jIME5Uwz32U6L1g/N/FDnMQ==
Date:   Tue, 5 Feb 2019 14:20:04 +0000
Message-ID: <20190205141950.9058-2-dave.rodgman@arm.com>
References: <20190205141950.9058-1-dave.rodgman@arm.com>
In-Reply-To: <20190205141950.9058-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LNXP265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::21) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-arm-no-footer: FoSSMail
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2158;6:lPlKM4QpUBHXIxeQCmLw7qP7qW0N6qTQz0e/NMolyeGGQZxfch4ZzzOQXqIb//lDMJlk6sLUm2NxlbSH0Oh6dxlEzVX9Lg2BqSxp52Zmi34hDvgftGAJ5DTM1fi+OVCsMqEUS+eYNz+K0+r1yPjcnMktD0vRlG3QBhG5bkU2+07Vvvg9PNEruNIFd1kKjgL6l+Ju1aquHj7nTZ9NpMIVlPU8QO5q+2tC8PppglF+aN+KuX+3Aw4j3GjKd35yPVWgq0Tc8nGk7w3e/XULUVyCNbZhmYKf3pM76J05kCXeEL+Sac9ikFHWT9GaBUYgH5HW2zaWI1jYkc3Zujr1NLRhRiQgnok2xMI1PAk8gv/fdVuB7gKgUodoSqFYMWPqYjt+e7nUZBHv67FKJ3QtoXWUzhYrvRgEpXn+R7AzKNkJVOdbGkT47ozZRKhCCl8SH4WoYn6GUkVXHojtEmcx/YcWIA==;5:l7LE/U36B9gxHvxa9N1gVfpuG1QSihb8mE/Sd0LT4siY01dG3BoWEh97Gyrg/7vKWCXmpgwK66xPgkr6gHH7KvChGENq6ZmEGrPVAv8A6aDpy9aDPBEeEfZW5mXQaXjSqfX5aOQn3nZgn+jyOagS5pqXOOIzOT1jM7DXR6GVsXm9w2bR0o8QFvdkTqUqP+yJ5gwF3Pyw0CVZOKqw08iJXA==;7:/5zoFqq9VeIVZY1dnwzv4dXJ5d7gJqkI2K/DmEFAWrkkuRZ5MPEzaBFb4Mf84z99oJPYQQ87YLpSWRKAHuaTLcC9tJ48vYd5Oyk8nDKvV8kKvceR+eY9qhkA1DJCLOMc34mxfYQvs1M9LLwGY1a5uw==
x-ms-office365-filtering-correlation-id: 373171d6-1fbf-4382-747d-08d68b7505e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2158;
x-ms-traffictypediagnostic: VI1PR0802MB2158:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2158E0F5E2372300C3F2C8E38F6E0@VI1PR0802MB2158.eurprd08.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(476003)(486006)(8676002)(76176011)(2616005)(1076003)(25786009)(11346002)(446003)(68736007)(44832011)(71200400001)(53936002)(71190400001)(52116002)(316002)(2906002)(478600001)(26005)(6512007)(110136005)(102836004)(106356001)(4326008)(105586002)(86362001)(50226002)(36756003)(2201001)(186003)(386003)(81156014)(81166006)(66066001)(7416002)(6506007)(256004)(6116002)(3846002)(7736002)(14454004)(8936002)(2501003)(6486002)(99286004)(6436002)(305945005)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2158;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +zJfI/XD8PlDnrp7xv7Zs+QR4PWOotZEEaCYwa1IXVXDYQON3ATurdBmpBBO+E3jLBvFviuFAaAUj0V0dwSXjcXyrv9lSVWfhD8AU265k7f5qUQ0Ph9t1CUG0of/TYME2m33JRrDt7W0IMijw7Zwm5fTMeZDu7nriK8hnh0tGG/xPwbw+SZq3hZpFunCmobwtoB/4TqW5+Yx07mDIQPQ42fVRw7PUeSQA0See6DgV6+n/ZR+yDQ7ba19j8+wRlnOeMohZXH1PoANB6wZr7LxwpggNz+fDJo6/xAOLdnX6AdMcBDMcmfED+SbT/u1CI8Vn0Tond4Cb8VwbfkAIn75zvHaavzTc9IzcpOtIxLK226XBtJtjK//aOg+4HRoh5f/nYT3O6JPraVAuO72m/Rhy16gfMqNLHrOml/0P2TzFGg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373171d6-1fbf-4382-747d-08d68b7505e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 14:20:04.1124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2158
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

