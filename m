Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740A2C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AB02084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AB02084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeJEW5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:57:33 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43783 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJEW5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:57:33 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1McpeM-1fYZhF22R0-00a0PW; Fri, 05 Oct 2018 17:57:27 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1McpeM-1fYZhF22R0-00a0PW; Fri, 05 Oct 2018 17:57:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, richard@nod.at, ard.biesheuvel@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Coly Li <colyli@suse.de>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/bch: fix possible stack overrun
Date:   Fri,  5 Oct 2018 17:56:51 +0200
Message-Id: <20181005155723.199954-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:pOcFM6ICKhVc1maX2EgSY+b1pjMwb31Udh6lxeuNmWc/c8rqj82
 cpZg5F/WsR9C97bywn8c5+fcuU4irr3hgo2UjU35UMfyFIU1rnq8ARSbPwiBhEC6OCJF3FS
 sKDx0DApYjz3XEu0Ih474klDh24JGyro+0exRmfCQvG578d1oNWaXUeknASaxaDoo0IDRUr
 Ww5Yhkf6f6nwhA3j5Pt0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aW9u17qqDwk=:uui/6FHVh6Ty4a2QF1LU9e
 DbDlaLOfhYAp4SkhPGMoPj2bqeLjKE6Ng5kGYU3Ju13GDdaPvvXzxhA2ctAOFDSChTiJKn3pO
 fxplKEI4bjB/3AgMXfP/cT7wU5YOpA2MZDpnL5clqXEU2zO69VGHg2d1aXaqvniFDd1Cbq3g0
 LhmixcJeTjoDBnACXDPsBpH4eFZ6tw1YDjQ1+SiX3E0FLzhrKLYsMq4RlivA/jHGFQUeRMcu8
 RlevoDgVr0auxJjVfMJNuw5Tw0EtOJNEZml+7Y6pxOkBlFuF2HdlhhTWlKDQCfc0iGPDwP8hk
 NQaGOrnqDIaMrhzJ2UmfvJgN+blAYKvVkX+172YSdebIICocq2CYPBuxKfKZQ5QIykXcxbcI3
 Dwk7KN/fJQL/RAfE+ntEMaD8NWMQg+URZ63TxLX4Td5csPvgBeXa0o1G5Fpf6kGm2yWeo49Ja
 0UrYdBl2ZvLvPRqfaGhNVLFUOuWaleCK1OaEYYawT/VLHJ2kxDehpJrN2j2XCrs/YaXI5wjd+
 UBXIO2FhC18aoeqqPVKfjSCw63aIdv9SOEwnqd8dbw6OG7bh13njFUCRFVPkcOb/kRxj2lO09
 /W0sijMyUbcfrEbSD/tF3fpW6RNRmYeAri8HwSMHzzs00lpSJpenUIRcSLlXaT4lRsKfeqO6c
 pqHgNQgAifyG5zdFQhgeMQtjSzRTPuW0QJXCzD9DYFChthBSc6KIbAJ1NjjbnsXsKLno=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch introduced very large kernel stack usage and a Makefile
change to hide the warning about it.

From what I can tell, a number of things went wrong here:

- The BCH_MAX_T constant was set to the maximum value for 'n',
  not the maximum for 't', which is much smaller.

- The stack usage is actually larger than the entire kernel stack
  on some architectures that can use 4KB stacks (m68k, sh, c6x), which
  leads to an immediate overrun.

- The justification in the patch description claimed that nothing
  changed, however that is not the case even without the two points above:
  the configuration is machine specific, and most boards  never use the
  maximum BCH_ECC_WORDS() length but instead have something much smaller.
  That maximum would only apply to machines that use both the maximum
  block size and the maximum ECC strength.

The largest value for 't' that I could find is '32', which in turn leads
to a 60 byte array instead of 2048 bytes. With that changed, the warning
can be enabled again.

Fixes: 02361bc77888 ("lib/bch: Remove VLA usage")
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Please review carefully to ensure my logic is correct. I spent a
long time trying to understand what is going on here, but I'm not
too familiar with this algorithm, and it's possible I still got it
wrong as well.
In particular, I'm not 100% sure if '32' is the maximum ECC strength
we can support, or if a larger one (which?) might be possible.
---
 lib/Makefile |  1 -
 lib/bch.c    | 10 ++++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 8c9647fa271a..12c479dd46e0 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -122,7 +122,6 @@ obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
 obj-$(CONFIG_REED_SOLOMON) += reed_solomon/
 obj-$(CONFIG_BCH) += bch.o
-CFLAGS_bch.o := $(call cc-option,-Wframe-larger-than=4500)
 obj-$(CONFIG_LZO_COMPRESS) += lzo/
 obj-$(CONFIG_LZO_DECOMPRESS) += lzo/
 obj-$(CONFIG_LZ4_COMPRESS) += lz4/
diff --git a/lib/bch.c b/lib/bch.c
index 7b0f2006698b..3ef1a3467e7b 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -79,20 +79,19 @@
 #define GF_T(_p)               (CONFIG_BCH_CONST_T)
 #define GF_N(_p)               ((1 << (CONFIG_BCH_CONST_M))-1)
 #define BCH_MAX_M              (CONFIG_BCH_CONST_M)
+#define BCH_MAX_T	       (CONFIG_BCH_CONST_T)
 #else
 #define GF_M(_p)               ((_p)->m)
 #define GF_T(_p)               ((_p)->t)
 #define GF_N(_p)               ((_p)->n)
-#define BCH_MAX_M              15
+#define BCH_MAX_M              15 /* 2KB */
+#define BCH_MAX_T              32 /* 32 bit correction */
 #endif
 
-#define BCH_MAX_T              (((1 << BCH_MAX_M) - 1) / BCH_MAX_M)
-
 #define BCH_ECC_WORDS(_p)      DIV_ROUND_UP(GF_M(_p)*GF_T(_p), 32)
 #define BCH_ECC_BYTES(_p)      DIV_ROUND_UP(GF_M(_p)*GF_T(_p), 8)
 
 #define BCH_ECC_MAX_WORDS      DIV_ROUND_UP(BCH_MAX_M * BCH_MAX_T, 32)
-#define BCH_ECC_MAX_BYTES      DIV_ROUND_UP(BCH_MAX_M * BCH_MAX_T, 8)
 
 #ifndef dbg
 #define dbg(_fmt, args...)     do {} while (0)
@@ -202,6 +201,9 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
 	const uint32_t * const tab3 = tab2 + 256*(l+1);
 	const uint32_t *pdata, *p0, *p1, *p2, *p3;
 
+	if (WARN_ON(r_bytes > sizeof(r)))
+		return;
+
 	if (ecc) {
 		/* load ecc parity bytes into internal 32-bit buffer */
 		load_ecc8(bch, bch->ecc_buf, ecc);
-- 
2.18.0

