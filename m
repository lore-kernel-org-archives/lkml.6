Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517681969-2-15886057718811372811
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681968; b=h640/b/8TyyY7xa6b8U7thH3FIPvIbQWkCzWL6akWM2sAou
    eFcsIVYInRJTIE/yiPDQkwACXxNXjULAgoO+1zT7a23t/rOTGaaGnLs47wILBLby
    3RQxDQiU1vrF+flB5ybg6APMqfQ+kYsBpa1Qzjyx7sHw02z6ywQCA8dDcEU8n2jy
    F5WOMpFcUrPYm4THqqW/wVxMOnlH1SHTR9g1ScvrQolTHFNbbZ/HWpoZLYpY1XOv
    hPSbrB4uHxs9x5ZWRsMARevKt93oZxStyShNdnuCUQzHLR8ByT1yt9e6hA9X2stG
    GLC8zSn2Upailhvuy26cekoIpq6NacL+K/+Eexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681968; bh=qqXbZ5
    0AQTyyVG64uxkLBCV2APfSQu/1y9BGMytmWho=; b=abu2AABjmUzCPl38ZzAUO/
    gcZ4VmElgK74DYjBgR3h7VOPC0NXShOhK5b/6xhUSC06Zx6LoQEG7C1DFeq/u9Hh
    n9LertAgamzVyJkA27LpCbXT48mxopMsp4xz0Waql5a7ciN0BNcJDjIgbw+FqtrZ
    HEbg3YbX8Mtg2+c/NElzDABFPsgukJNRSbGIV+UqTe2jzwQ+eHwm4jBxyPh9VUNe
    OrzToqr06MsJnRlZdjoFMl1ZXotiKd2+XLSaf+xcJDtpldJqyKidYli1Ldpje6PH
    Ub3QCCP8c0KP++XGBVM3QFM8VhHNa4UuQDkyVe+T+NY5X4lwd2Jpl3Vyh+fpzlng
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A9cuo50e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A9cuo50e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbeBCSS3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:18:29 -0500
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:52828
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753493AbeBCSGu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 11/32] lib/mpi: Fix umul_ppmm() for MIPS64r6
Thread-Topic: [PATCH AUTOSEL for 4.4 11/32] lib/mpi: Fix umul_ppmm() for
 MIPS64r6
Thread-Index: AQHTnRlvwOqr5yORREqmpyspv1W4uQ==
Date: Sat, 3 Feb 2018 18:04:29 +0000
Message-ID: <20180203180413.7438-11-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:LiaKToRV1l1eUDTMY0qkfaSYjkVY5GbzQ72j4PjFaBokx82n0w0xflrLOjbY+oFIxCk02Sso+Wsbax0sRVxB3GeHGzXREZPIy33euYyPze+g2WEioHnSAGo8vreXSmg7Eb1K/s4ih69LLsoROl4dosR8bm1hxyc3yxUjDzi8fpEeEhmUtygrwsUQo4uezd+iHbfTjVDbfOU5ls+G+T1MExKbrkB4gk/GqhekIlsNP3ZzhdYDx+7LzdQqMASa7sP3
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42bb685e-37be-40c2-0b9f-08d56b30b9ed
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB108981EF31C15B3C3DD6EBE5FBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(575784001)(106356001)(22452003)(4326008)(97736004)(25786009)(6666003)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(59450400001)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: EDoWiX6lCqDghk+ENyshAxatBrVlqWUMvzd+n8P781XYmbtOJ/2k8/BebFT3ExoOVP+qkVqPW2IXuhAErFxTDg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bb685e-37be-40c2-0b9f-08d56b30b9ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:29.8933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Hogan <jhogan@kernel.org>

[ Upstream commit bbc25bee37d2b32cf3a1fab9195b6da3a185614a ]

Current MIPS64r6 toolchains aren't able to generate efficient
DMULU/DMUHU based code for the C implementation of umul_ppmm(), which
performs an unsigned 64 x 64 bit multiply and returns the upper and
lower 64-bit halves of the 128-bit result. Instead it widens the 64-bit
inputs to 128-bits and emits a __multi3 intrinsic call to perform a 128
x 128 multiply. This is both inefficient, and it results in a link error
since we don't include __multi3 in MIPS linux.

For example commit 90a53e4432b1 ("cfg80211: implement regdb signature
checking") merged in v4.15-rc1 recently broke the 64r6_defconfig and
64r6el_defconfig builds by indirectly selecting MPILIB. The same build
errors can be reproduced on older kernels by enabling e.g. CRYPTO_RSA:

lib/mpi/generic_mpih-mul1.o: In function `mpihelp_mul_1':
lib/mpi/generic_mpih-mul1.c:50: undefined reference to `__multi3'
lib/mpi/generic_mpih-mul2.o: In function `mpihelp_addmul_1':
lib/mpi/generic_mpih-mul2.c:49: undefined reference to `__multi3'
lib/mpi/generic_mpih-mul3.o: In function `mpihelp_submul_1':
lib/mpi/generic_mpih-mul3.c:49: undefined reference to `__multi3'
lib/mpi/mpih-div.o In function `mpihelp_divrem':
lib/mpi/mpih-div.c:205: undefined reference to `__multi3'
lib/mpi/mpih-div.c:142: undefined reference to `__multi3'

Therefore add an efficient MIPS64r6 implementation of umul_ppmm() using
inline assembly and the DMULU/DMUHU instructions, to prevent __multi3
calls being emitted.

Fixes: 7fd08ca58ae6 ("MIPS: Add build support for the MIPS R6 ISA")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-mips@linux-mips.org
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 lib/mpi/longlong.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
index b90e255c2a68..d2ecf0a09180 100644
--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -671,7 +671,23 @@ do {						\
 	**************  MIPS/64  **************
 	***************************************/
 #if (defined(__mips) && __mips >=3D 3) && W_TYPE_SIZE =3D=3D 64
-#if (__GNUC__ >=3D 5) || (__GNUC__ >=3D 4 && __GNUC_MINOR__ >=3D 4)
+#if defined(__mips_isa_rev) && __mips_isa_rev >=3D 6
+/*
+ * GCC ends up emitting a __multi3 intrinsic call for MIPS64r6 with the pl=
ain C
+ * code below, so we special case MIPS64r6 until the compiler can do bette=
r.
+ */
+#define umul_ppmm(w1, w0, u, v)						\
+do {									\
+	__asm__ ("dmulu %0,%1,%2"					\
+		 : "=3Dd" ((UDItype)(w0))					\
+		 : "d" ((UDItype)(u)),					\
+		   "d" ((UDItype)(v)));					\
+	__asm__ ("dmuhu %0,%1,%2"					\
+		 : "=3Dd" ((UDItype)(w1))					\
+		 : "d" ((UDItype)(u)),					\
+		   "d" ((UDItype)(v)));					\
+} while (0)
+#elif (__GNUC__ >=3D 5) || (__GNUC__ >=3D 4 && __GNUC_MINOR__ >=3D 4)
 #define umul_ppmm(w1, w0, u, v) \
 do {									\
 	typedef unsigned int __ll_UTItype __attribute__((mode(TI)));	\
--=20
2.11.0
