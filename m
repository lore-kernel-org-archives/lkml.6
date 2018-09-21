Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0B5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F240221545
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9NEtbBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F240221545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389018AbeIUIlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:41:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45990 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:41:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id t70-v6so536136pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 19:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=W5V790ekTmPiq/s4qHSLLw+0znVIlnT1bGCmYfgL9rg=;
        b=O9NEtbBUDSaOVMhnB74ISS5LP2O1BlAdwx4jevUQ5bR+at3X8uHaNJExam6jR6lD/L
         Ihp9eNXRbjvgketTKdAKSpgr6zCO0jhGhcA5nvO1Drg/txG3faWBnoIqmZw+7fcFPqUv
         g/YSPQ8YAkfoVk9KN/zXiAKU6In2vKO+LwEkIwR6/+hk63kT6N/J9dLGXTeqRY/xdrCI
         SbECpUhM0NoT3ua6HKtY3iFcnq0ng3CUmAm+wY+9RGX2D4RMMrnyZctUroB4vNEJ+5sz
         ND7MLMONjNLO8xgI9NIIotzxgexBTLrFiEvhdzfWwQ0RyglEDzgwfgK2j64SS/Gl1swO
         RBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=W5V790ekTmPiq/s4qHSLLw+0znVIlnT1bGCmYfgL9rg=;
        b=K2acDQ1mKSaVAGEosAiHKHZYHJKQevbXixIBPbYZE85210W8GcQVwmxePixiQNz06q
         NHwVdQKH3X+k5wo3+EjwtmyiNAkCjJ5toRO1b42ywlyAMDrw+wVw+8R3AMzOzTLYR4O3
         SyJ0zYf+Pr6XNPmiAKFayC+30iDb9qQK63g2peYTzKWonepwgXd8RHRiXfw8zihhBU0m
         aVp7PS+b73Rq2Qhkd649XcHT9hzGN/IIDdaMM+h/ul8oI8q0nxQbJtWxX3NtQiza8ico
         SN571Ba6wdtCWyBv+ph+s94FWuGaGT4aG+TSGT57JT6cJJxx6sPqiOzMpEAoDLbm5LPh
         hkYA==
X-Gm-Message-State: APzg51DGg0FDpWkxwl9dEwblL6MbIvJWjuf7Zpg7Oe9vR/QZ85IdSOKJ
        jKcG+/KUwpjx8UpsRTYd8qg=
X-Google-Smtp-Source: ANB0VdbIbu1R63Hr64yYoI1e/ZdPixyhvolI9dTUi8i8JAYf+b6wOMje8XIMobU6Est8SBK5DZsuDg==
X-Received: by 2002:a63:f54c:: with SMTP id e12-v6mr39441533pgk.286.1537498480683;
        Thu, 20 Sep 2018 19:54:40 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id h4-v6sm26802903pgp.13.2018.09.20.19.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 19:54:39 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Fri, 21 Sep 2018 12:24:32 +0930
From:   Joel Stanley <joel@jms.id.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        Meelis Roos <mroos@linux.ee>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/xz: Put CRC32_POLY_LE in xz_private.h
Date:   Fri, 21 Sep 2018 12:24:31 +0930
Message-Id: <20180921025431.28366-1-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a regression introduced by faa16bc404d72a5 ("lib: Use
existing define with polynomial").

The cleanup added a dependency on include/linux, which broke the PowerPC
boot wrapper/decompresser when KERNEL_XZ is enabled:

  BOOTCC  arch/powerpc/boot/decompress.o
 In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
                 from arch/powerpc/boot/decompress.c:42:
 arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
 linux/crc32poly.h: No such file or directory
  #include <linux/crc32poly.h>
           ^~~~~~~~~~~~~~~~~~~

The powerpc decompresser is a hairy corner of the kernel. Even while building
a 64-bit kernel it needs to build a 32-bit binary and therefore avoid including
files from include/linux.

This allows users of the xz library to avoid including headers from
'include/linux/' while still achieving the cleanup of the magic number.

Fixes: faa16bc404d72a5 ("lib: Use existing define with polynomial")
Reported-by: Meelis Roos <mroos@linux.ee>
Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 lib/xz/xz_crc32.c   | 1 -
 lib/xz/xz_private.h | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
index 25a5d87e2e4c..912aae5fa09e 100644
--- a/lib/xz/xz_crc32.c
+++ b/lib/xz/xz_crc32.c
@@ -15,7 +15,6 @@
  * but they are bigger and use more memory for the lookup table.
  */
 
-#include <linux/crc32poly.h>
 #include "xz_private.h"
 
 /*
diff --git a/lib/xz/xz_private.h b/lib/xz/xz_private.h
index 482b90f363fe..09360ebb510e 100644
--- a/lib/xz/xz_private.h
+++ b/lib/xz/xz_private.h
@@ -102,6 +102,10 @@
 #	endif
 #endif
 
+#ifndef CRC32_POLY_LE
+#define CRC32_POLY_LE 0xedb88320
+#endif
+
 /*
  * Allocate memory for LZMA2 decoder. xz_dec_lzma2_reset() must be used
  * before calling xz_dec_lzma2_run().
-- 
2.17.1

