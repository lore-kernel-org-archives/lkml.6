Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83AFECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939BE20839
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlQui/vZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939BE20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbeGQQkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729716AbeGQQkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:40:19 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AB932086D;
        Tue, 17 Jul 2018 16:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531843617;
        bh=+GQcUk1iUT7FX83Cyp9Jzp6VhgvFmOqhLVzZOzSfqco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KlQui/vZgsjTG+f5Bp1ysneRJ6vUkAEvUOBkR0Qw3bXUFzkHXB3gsc5Ky2COZdTsV
         CKsm4ql6TNntop1RvOxJ4SUTRz7db5e8i6BQevjsGyFVStR8l838DBbbQzCTiZvMky
         /n/nm6v7vvBhBhB5OANGLB8IE7miJDUNr1J9+oxg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Vitaly Bordug <vbordug@ru.mvista.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devel@driverdev.osuosl.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/6] staging: rtl: Use existing define with polynomial
Date:   Tue, 17 Jul 2018 18:05:40 +0200
Message-Id: <20180717160541.3843-6-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180717160541.3843-1-krzk@kernel.org>
References: <20180717160541.3843-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not define again the polynomial but use header with existing define.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Not tested

It would be nice to get some testing. Only generic lib/crc, bunzip, xz_crc32
and Freescale's Ethernet driver were tested on HW.  Rest got just different
builds.

 drivers/staging/rtl8712/rtl871x_security.c    | 5 ++---
 drivers/staging/rtl8723bs/core/rtw_security.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_security.c b/drivers/staging/rtl8712/rtl871x_security.c
index 7bc74d7d8a3a..1075eacdb441 100644
--- a/drivers/staging/rtl8712/rtl871x_security.c
+++ b/drivers/staging/rtl8712/rtl871x_security.c
@@ -40,6 +40,7 @@
 #include <linux/uaccess.h>
 #include <asm/byteorder.h>
 #include <linux/atomic.h>
+#include <linux/crc32poly.h>
 #include <linux/semaphore.h>
 
 #include "osdep_service.h"
@@ -49,8 +50,6 @@
 
 /* =====WEP related===== */
 
-#define CRC32_POLY 0x04c11db7
-
 struct arc4context {
 	u32 x;
 	u32 y;
@@ -135,7 +134,7 @@ static void crc32_init(void)
 	for (i = 0; i < 256; ++i) {
 		k = crc32_reverseBit((u8)i);
 		for (c = ((u32)k) << 24, j = 8; j > 0; --j)
-			c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY : (c << 1);
+			c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY_BE : (c << 1);
 		p1 = (u8 *)&crc32_table[i];
 		p1[0] = crc32_reverseBit(p[3]);
 		p1[1] = crc32_reverseBit(p[2]);
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 612277a555d2..6c8ac9e86c9f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -6,6 +6,7 @@
  ******************************************************************************/
 #define  _RTW_SECURITY_C_
 
+#include <linux/crc32poly.h>
 #include <drv_types.h>
 #include <rtw_debug.h>
 
@@ -87,8 +88,6 @@ const char *security_type_str(u8 value)
 
 /* WEP related ===== */
 
-#define CRC32_POLY 0x04c11db7
-
 struct arc4context {
 	u32 x;
 	u32 y;
@@ -178,7 +177,7 @@ static void crc32_init(void)
 		for (i = 0; i < 256; ++i) {
 			k = crc32_reverseBit((u8)i);
 			for (c = ((u32)k) << 24, j = 8; j > 0; --j) {
-				c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY : (c << 1);
+				c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY_BE : (c << 1);
 			}
 			p1 = (u8 *)&crc32_table[i];
 
-- 
2.14.1

