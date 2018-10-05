Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A16C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA57208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA57208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbeJEXSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:18:22 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:46027 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbeJEXSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:18:22 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N1M4p-1fjOZh2og7-012lnk; Fri, 05 Oct 2018 18:18:46 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N1M4p-1fjOZh2og7-012lnk; Fri, 05 Oct 2018 18:18:46 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Luis Henriques <lhenriques@suse.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ceph: use an enum instead of 'static const' to define constants
Date:   Fri,  5 Oct 2018 18:18:38 +0200
Message-Id: <20181005161845.959919-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:U7g/JovbVRmUvIWHMhDo9InnZSi8KsJh/pi3+A9ngUPNgizb2Hf
 W5RQ3Ipj5w4F+uq/eGlHnv0KHiu9E3Z3v8efvqvItWENnFaKoAgvkLL4ZQGyC4Df3naQzFW
 PaMRbzlR2g1ammXJ2S7ylluXYLtpMJYx6E8vLzMdiXeUJqmx572WOPRC75My6euQXLE0vcr
 sdzAMZ7vDKwFIJWEWNlrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DnMKUp3GjcI=:FqVSfnHXe1ZrtpryTC8gJm
 HANSyzqF8t2DogP+/YNO37uKFFLM3wXR9Upn6BNvsJYA2xMm/kVHZ1igEMxJcA8iURZ1bCqKA
 FESzZD7+nbCZev+CVx7QE1cvBIQZsqcIKLCZGdFnJtJjIBPewIcz/Y2vdAE5/HvmhRItG4+/E
 YQCMOBu6nzKvJIR1NxV2pwrv/pZWzFA2IjLKohM/8H+/J6JXSyKumJja/g2OL7K6f5Kmp9CtJ
 SBOPlLS1anV5cj958REeAlVKv5VBAqpKsRJjXDkPJB6HB0u1BPCQPYLYcQOWfGho1sxQ78PNU
 1bcMgsUwjc8TpcqhKmGgTQRE2oVEQnH+C5MM4jTs/TkY49OgvxwOVmzzOLu5wS8ep/WOa5/jm
 sucpgYqUBbvD8uuJx2qgP4YIR5ENeiMHbL7WYcdCmbX9IqSUjm0V1zeD2p2U+BIvspLG+NmNU
 k4Y2AEfsSKxR5yevvBJdEESRgdWLLD3r39FVJoLPsL9C8UabPzOnfMgAXqZejyVMwQ+uvjFXh
 XPZIKVkB09UReAnAgcYuBQSgWlaEiMCLlYcbCxachz4mX0wgQ2TIhK6NbiW4q4LrAQxcFr90m
 XYnOvf0meOU5pT7XLOgrIfWLe7oiNk1A45nwEzdsgm0tThnNr0T0CPjjBbWunzjdm6eJXy4pd
 udV1YW/OZtQy4StF0H4w9D7vLaiVokUSIXzPy6S2/86CqmEh6wgaoiLoXXZMbYMUFIpU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with W=1 produces lots of warnings for files including
ceph_features.h:

include/linux/ceph/ceph_features.h:15:24: error: 'CEPH_FEATUREMASK_SERVER_M' defined but not used [-Werror=unused-const-variable=]

The normal way to define compile-time constants in the kernel is
to use either macros or enums, and gcc does not warn about those.

Converting to an enum is simple here and means we can still use
the names while debugging.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/ceph/ceph_features.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index 6b92b3395fa9..676908eca060 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -11,15 +11,15 @@
 #define CEPH_FEATURE_INCARNATION_2 (1ull<<57) // CEPH_FEATURE_SERVER_JEWEL
 
 #define DEFINE_CEPH_FEATURE(bit, incarnation, name)			\
-	static const uint64_t CEPH_FEATURE_##name = (1ULL<<bit);		\
-	static const uint64_t CEPH_FEATUREMASK_##name =			\
-		(1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation);
+	CEPH_FEATURE_##name = (1ULL<<bit),				\
+	CEPH_FEATUREMASK_##name =					\
+		(1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation),
 
 /* this bit is ignored but still advertised by release *when* */
-#define DEFINE_CEPH_FEATURE_DEPRECATED(bit, incarnation, name, when) \
-	static const uint64_t DEPRECATED_CEPH_FEATURE_##name = (1ULL<<bit); \
-	static const uint64_t DEPRECATED_CEPH_FEATUREMASK_##name =		\
-		(1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation);
+#define DEFINE_CEPH_FEATURE_DEPRECATED(bit, incarnation, name, when)	\
+	DEPRECATED_CEPH_FEATURE_##name = (1ULL<<bit),			\
+	DEPRECATED_CEPH_FEATUREMASK_##name =				\
+		(1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation),
 
 /*
  * this bit is ignored by release *unused* and not advertised by
@@ -71,7 +71,7 @@
  * This ensures that no two versions who have different meanings for
  * the bit ever speak to each other.
  */
-
+enum ceph_features {
 DEFINE_CEPH_FEATURE( 0, 1, UID)
 DEFINE_CEPH_FEATURE( 1, 1, NOSRCADDR)
 DEFINE_CEPH_FEATURE_RETIRED( 2, 1, MONCLOCKCHECK, JEWEL, LUMINOUS)
@@ -170,13 +170,13 @@ DEFINE_CEPH_FEATURE(61, 1, CEPHX_V2)             // *do not share this bit*
 
 DEFINE_CEPH_FEATURE(62, 1, RESERVED)           // do not use; used as a sentinal
 DEFINE_CEPH_FEATURE_DEPRECATED(63, 1, RESERVED_BROKEN, LUMINOUS) // client-facing
-
+};
 
 /*
  * Features supported.
  */
 #define CEPH_FEATURES_SUPPORTED_DEFAULT		\
-	(CEPH_FEATURE_NOSRCADDR |		\
+	(u64)(CEPH_FEATURE_NOSRCADDR |		\
 	 CEPH_FEATURE_FLOCK |			\
 	 CEPH_FEATURE_SUBSCRIBE2 |		\
 	 CEPH_FEATURE_RECONNECT_SEQ |		\
-- 
2.18.0

