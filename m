Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B18C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A5F2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Dd/P631F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A5F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeK3W4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:56:46 -0500
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:25845
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbeK3W4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvm4XoRVcy7jGILPlVC9Pi+JYamPsOqzbrounse2FTk=;
 b=Dd/P631F2g/nphd1D6e4iKuRpg3t4+uOTLEGDBTq6RIt4RpatM7vRxG1RkivCw5cbOc/xD9dFPRLTXkexalMOjGSA8MKLmegzMHqZmxkAqMPpe1LVt90+E6e+N4s+XMfoaIu+WCKIuQAvNcxkA1zlGLw03SGg7tqyqLA/iTDvxE=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2623.eurprd08.prod.outlook.com (10.175.20.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 11:47:37 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 11:47:37 +0000
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
        nd <nd@arm.com>
Subject: [PATCH 1/8] lib/lzo: tidy-up ifdefs
Thread-Topic: [PATCH 1/8] lib/lzo: tidy-up ifdefs
Thread-Index: AQHUiKJ9mqcf8HhAPEmqdSjYkid7zw==
Date:   Fri, 30 Nov 2018 11:47:37 +0000
Message-ID: <20181130114715.27523-2-dave.rodgman@arm.com>
References: <20181130114715.27523-1-dave.rodgman@arm.com>
In-Reply-To: <20181130114715.27523-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.53]
x-clientproxiedby: CWXP265CA0058.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2c::22) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2623;6:h6dbJdqrTBjeBjvWU4K9uJO8AkpYley5w++r4LiS9UsxfuP3CJzuZEO4b2YqHvtgjyX4oxC923zxInVLgWHWVoeHBvToyb16Tv13NCnEz7mVIgPdE7q1M/Llwu2mHwcMFjuuG6PXh134etT6RSXiFrZVB3sS6H3RNh5iaQlCc00opGR6K0+JyqRqnaCY1VqZUaajVt286/G6LFUIhu2h8wi/NpTa4F7YvAWQ4zstbgiNAU0ekT7rXMJNCLNiDM45Lbie4qAiGCSKpcV6002sidvbKjJ8dPkA2Se3OKIxHak88X1YoGk9Xo2Hz40gVJiDInqlWLun8E7Lfb4imn2915w4m0vBlAJEgI8F5itp2l+sdOqXC8jKIm0tX+tLUNgcfhqVNerl/GViAuEuGSmYhRmeQGTgM4oIWLDMaxAfAqPEya0hjzgpbDcZ+7yzi/xJxt84ZN4M80JPfJsod2xRTw==;5:xxJU1lEFsw9jgwxxgZEDIYp374gLnMpiT23j9MBBL8f776Pa/LzkMegAirKRXwnOyyxxcqtLZrFMAibgrikWvaim5gw3dRKCc2bDfAKcSre2/wVZOyk5rh3kuFg6E2l5pS1E9aoVj96apdR6OaDoAZKCafuNVYRFK2jlUAwCeyQ=;7:G+crdB+hrHSsIBSp2h49OJPVBNYCYPL+0hsRwzb7qITqZGP3TTOeTBU+B0ARqaYP4hj5LGtdVmPhBOvhtbDKUhg2qeD+evxmSNUdWNHXXoJxRCA60RRxaksZ3bgeiokQIAa/5dIu01lDm6iS0yhE0Q==
x-ms-office365-filtering-correlation-id: df233b4b-0921-4e42-f006-08d656b9a019
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2623;
x-ms-traffictypediagnostic: VI1PR0802MB2623:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB262358AB7C3CDC54920B45F98FD30@VI1PR0802MB2623.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231453)(999002)(944501466)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2623;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2623;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(366004)(346002)(199004)(189003)(52116002)(256004)(76176011)(2501003)(106356001)(478600001)(99286004)(39060400002)(105586002)(68736007)(476003)(2616005)(446003)(11346002)(5660300001)(36756003)(71200400001)(8936002)(25786009)(102836004)(186003)(26005)(486006)(50226002)(44832011)(8676002)(81166006)(81156014)(6506007)(86362001)(386003)(14454004)(316002)(7416002)(53936002)(305945005)(66066001)(6436002)(7736002)(110136005)(6486002)(71190400001)(54906003)(2906002)(1076002)(3846002)(6116002)(6512007)(4326008)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2623;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qftu31bPxjqGSL4WTRax2rA12JbgoNkjpTkhCQc9VGF6dNwirUMO6uJ3TtTbn0gefAwAn1S8h+eHTlAnoOsArugtV+2/C1bmkCr1367Dn5HYADwXbkF5s/1Ip8wHTjKmY7vD60LsJEMZb9anSwqbtlJ40hjdrXDYWzq1/sdu3w22TNCYosG3MWT7GfGmMrZtb7TIbyoG5E92Ccb+9ELdxq/7S/3oEap+ke5ETo++FgZ9YqfBjzD4Rj3fY66jACX0ika9L136CQwBCG17PQfk3wArWazu5PQH33nERjPB9+igOQ+pBO7bxIXRcJoPsA+CW9rfQxEYO0Kfb7Hwt7T5pk3SlQQrw7qb+/p/KwXmipg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df233b4b-0921-4e42-f006-08d656b9a019
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 11:47:37.6998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2623
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

