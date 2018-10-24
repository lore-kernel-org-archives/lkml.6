Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2C4ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487902064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUVPRaDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487902064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeJYECu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:02:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35799 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeJYECn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:02:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so2809245pgu.2;
        Wed, 24 Oct 2018 12:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R7GnanBC/dUP1yUUX1JKpyThiE0iCRjX5YFPvjRZfCc=;
        b=XUVPRaDoxMaZ0lc+zIzwRmVi++6Px2u+8TgSt+ESHM01GRwvZtXwQDGr4zqDSMZfrw
         8nq+I4eE4vaqFXIJDj0j7q+PI42qbkO9Lx9HT8x5RKjlanTfAVScBJLHwP7splrM/86g
         SwKMGcaiEl1CEBvNP0jbIDkfSLJKkemdtX42rsEnrMQENoVA80iYvrzrwMnfiQoxbZni
         JkfwfIdggNQDt4uFgzXJhfpmuyCYCHoxEVICC0TXx1+PvFtzmXL0tV4d+3IFqdBUfCN3
         GqHTcCVh6xi6gCkOdgy0tizfHP5iGPbFk5siMBPV9ZhNeCLYFPKMA1XnN4fFTHSdfvvV
         A26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R7GnanBC/dUP1yUUX1JKpyThiE0iCRjX5YFPvjRZfCc=;
        b=hK0UguTfdY9QfVLUphhAYiqBaYyDs1BQywRXoBMPy1dZ8kaZkdEoIm8sqZJLUUTWoS
         h8HTfypSxE4jRuo6KQxLXXdtU7U1deIAZachZjkF1N8dLiGJoQrvNFCNNrJTkU7/wy2Q
         E/WyVYhUKj/bDZ73RnTqVVSO5NtD/LYS2hs3RfOxfaQmwqly143RRxvym3ns1AbRVlnV
         BE5LWq75n/oSXPj8q72U6Mz0eb/0f2MBaweeoO1eNN9TpZhc79+5K5lYOb1hZiBgEKpY
         9WaIRI45kQnoTMc5hho+5CinU2l8FMP5mFL1KT96mKtHefE5UjSN6PClltB/4r7yoUIa
         l9ig==
X-Gm-Message-State: AGRZ1gKKuqivUU4xrW0KYYR4hoYVn0h9wIH6wbysUEfHQ7JKqWv2won5
        DMuFuReqgb5dpHX1KkR9aJgkja9yD7g=
X-Google-Smtp-Source: AJdET5dg31dP21iFfiQOW43Rew2HT+LpqU+mmMjIz/9NCSpREeKfcx0lWewCTEg3MxMGJke0wlIAEA==
X-Received: by 2002:a62:b87:: with SMTP id 7-v6mr3903770pfl.67.1540409601762;
        Wed, 24 Oct 2018 12:33:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j187-v6sm9818878pfc.39.2018.10.24.12.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 12:33:20 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>,
        linux-alpha@vger.kernel.org (open list:ALPHA PORT),
        linux-snps-arc@lists.infradead.org (open list:SYNOPSYS ARC ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-c6x-dev@linux-c6x.org (open list:C6X ARCHITECTURE),
        uclinux-h8-devel@lists.sourceforge.jp (moderated list:H8/300
        ARCHITECTURE),
        linux-hexagon@vger.kernel.org (open list:QUALCOMM HEXAGON ARCHITECTURE),
        linux-ia64@vger.kernel.org (open list:IA64 (Itanium) PLATFORM),
        linux-m68k@lists.linux-m68k.org (open list:M68K ARCHITECTURE),
        linux-mips@linux-mips.org (open list:MIPS),
        nios2-dev@lists.rocketboards.org (moderated list:NIOS2 ARCHITECTURE),
        openrisc@lists.librecores.org (open list:OPENRISC ARCHITECTURE),
        linux-parisc@vger.kernel.org (open list:PARISC ARCHITECTURE),
        linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND
        64-BIT)),
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-s390@vger.kernel.org (open list:S390),
        linux-sh@vger.kernel.org (open list:SUPERH),
        sparclinux@vger.kernel.org (open list:SPARC + UltraSPARC
        (sparc/sparc64)),
        linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
        linux-xtensa@linux-xtensa.org (open list:TENSILICA XTENSA PORT (xtensa)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v2 2/2] arm64: Create asm/initrd.h
Date:   Wed, 24 Oct 2018 12:32:56 -0700
Message-Id: <20181024193256.23734-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181024193256.23734-1-f.fainelli@gmail.com>
References: <20181024193256.23734-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 is the only architecture that requires a re-definition of
__early_init_dt_declare_initrd(). Now that we added the infrastructure
in asm-generic to provide an asm/initrd.h file, properly break up that
definition from asm/memory.h and make use of that header in
drivers/of/fdt.c where this is used.

This significantly cuts the number of objects that need to be rebuilt on
ARM64 due to the repercusions of including asm/memory.h in several
places.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/initrd.h | 13 +++++++++++++
 arch/arm64/include/asm/memory.h |  8 --------
 drivers/of/fdt.c                |  1 +
 3 files changed, 14 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/initrd.h

diff --git a/arch/arm64/include/asm/initrd.h b/arch/arm64/include/asm/initrd.h
new file mode 100644
index 000000000000..0c9572485810
--- /dev/null
+++ b/arch/arm64/include/asm/initrd.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_INITRD_H
+#define __ASM_INITRD_H
+
+#ifdef CONFIG_BLK_DEV_INITRD
+#define __early_init_dt_declare_initrd(__start, __end)			\
+	do {								\
+		initrd_start = (__start);				\
+		initrd_end = (__end);					\
+	} while (0)
+#endif
+
+#endif /* __ASM_INITRD_H */
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..dc3ca21ba240 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 800ad252cf9c..4e4711af907b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -28,6 +28,7 @@
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
+#include <asm/initrd.h>
 
 #include "of_private.h"
 
-- 
2.17.1

