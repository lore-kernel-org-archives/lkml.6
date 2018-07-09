Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A9FC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606322087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0m68q8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606322087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754551AbeGIN4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:56:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40141 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754492AbeGIN4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:56:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id a6-v6so14174848ljj.7;
        Mon, 09 Jul 2018 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HH5lNU/xQ4ewQdE7lfMKkvdCC1oLo1y6fg3RnXQ/fAA=;
        b=g0m68q8aLdAOzq/D/l7+L0XagH5AmUrW40B6TxsU2YU9yWomfeClOnn4W5TBfH51ni
         CN+P7Nlkwbp1zJT/cZHfv8LTEfQ/4aFjepceZhz24KSn4uHrvBB9lyijs94T4F4WDbpc
         6q1rk3q56TVEVTwF1+ydCSV48JICzg+RsOT1i78dRlo0JSH0Vd+R2LGsHpAoTAF2h73r
         /ED7ZdfNHjIemFmEy7ekCkCtM94eizypCa5RnDSqR25Xocz3ekzmR/YvnoSMUlG4KaYI
         Aj/2EhnT3xG3uDqx3bNnFe6mpYyIJhRIwB9cD8dVUmO152pqggrZcwlYPsJnJZ3AL5tk
         VLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HH5lNU/xQ4ewQdE7lfMKkvdCC1oLo1y6fg3RnXQ/fAA=;
        b=m39TBnCAaJpqaGYlFSc643//xpZy2HNByh590hFCCdYljmZeMDjbVC0WCpeKAJksrt
         ch6hE6Ki+Rt6Jm7sad6naYbN1hNa/TNK7HFNxbhK4GhFlKf3VNgVzYCi2cRmH3sC8tL8
         Ur4QdV0p4xDzQgsiX9vDM1cnRvY8i3nc+u6G9GzwSTLAUTd4A7+nEEfvDD7XANsMbXAH
         wt3MhQvehtQfOqx+PKi5XmuHhvTGSCZtH9+9Lqb1AKJtm8H26nd8aEjyqA5aoJ8bUQdL
         MuAiqZ5NSAs7Cr5krnPiYnq4lLUcLALsBxHLFi4rZjJf/LI2zIq8ahkR91Omc1swj1Kv
         506A==
X-Gm-Message-State: APt69E3V84Ev92N5WUmPuoR1aTY62cHEsYKUm0Ja/eoqWRRg4947eRN7
        xTZkAWXNCVD8Pd5iJkAWFNs=
X-Google-Smtp-Source: AAOMgpetad43bj3BJOe0lsfAKdcV14mdAiyE/0OdXR0mI3jeBdPqCFVyU2iybJVtnIxmJLescl2pjA==
X-Received: by 2002:a2e:1b03:: with SMTP id b3-v6mr13470576ljb.24.1531144599357;
        Mon, 09 Jul 2018 06:56:39 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id g12-v6sm4076662lfe.1.2018.07.09.06.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 06:56:38 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     okaya@codeaurora.org, chenhc@lemote.com,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] mips: mm: Create UCA-based ioremap_wc() method
Date:   Mon,  9 Jul 2018 16:57:12 +0300
Message-Id: <20180709135713.8083-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern MIPS cores (like P5600/6600, M5150/6520, end so on) which
got L2-cache on chip also can enable a special type Cache-Coherency
attribute (CCA) named UnCached Accelerated attribute (UCA). In this
way uncached accelerated accesses are treated the same way as
non-accelerated uncached accesses, but uncached stores are gathered
together for more efficient bus utilization. So to speak this CCA
enables uncached transactions to better utilize bus bandwidth via
burst transactions.

This is exactly why ioremap_wc() method has been introduced in linux.
Alas MIPS-platform code hasn't implemented it so far, instead default
one has been used which was an alias to ioremap_nocache. In order to
fix this we added MIPS-specific ioremap_wc() macro substituted by
generic __ioremap_mode() method call with writecombine CPU-info
field passed. It shall create real ioremap_wc() method if CPU-cache
supports UCA feature and fall-back to _CACHE_UNCACHED attribute
if one doesn't. Additionally platform-specific io.h shall declare
ARCH_HAS_IOREMAP_WC macro as indication of architectural definition
of ioremap_wc() (similar to x86/powerpc).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Singed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
---
 arch/mips/include/asm/io.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 4d709b61d..d4f8cdc58 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -12,6 +12,8 @@
 #ifndef _ASM_IO_H
 #define _ASM_IO_H
 
+#define ARCH_HAS_IOREMAP_WC
+
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -278,6 +280,27 @@ static inline void __iomem * __ioremap_mode(phys_addr_t offset, unsigned long si
 #define ioremap_cache ioremap_cachable
 
 /*
+ * ioremap_wc     -   map bus memory into CPU space
+ * @offset:    bus address of the memory
+ * @size:      size of the resource to map
+ *
+ * ioremap_wc performs a platform specific sequence of operations to
+ * make bus memory CPU accessible via the readb/readw/readl/writeb/
+ * writew/writel functions and the other mmio helpers. The returned
+ * address is not guaranteed to be usable directly as a virtual
+ * address.
+ *
+ * This version of ioremap ensures that the memory is marked uncachable
+ * but accelerated by means of write-combining feature. It is specifically
+ * useful for PCIe prefetchable windows, which may vastly improve a
+ * communications performance. If it was determined on boot stage, what
+ * CPU CCA doesn't support UCA, the method shall fall-back to the
+ * _CACHE_UNCACHED option (see cpu_probe() method).
+ */
+#define ioremap_wc(offset, size)					\
+	__ioremap_mode((offset), (size), boot_cpu_data.writecombine)
+
+/*
  * These two are MIPS specific ioremap variant.	 ioremap_cacheable_cow
  * requests a cachable mapping, ioremap_uncached_accelerated requests a
  * mapping using the uncached accelerated mode which isn't supported on
-- 
2.12.0

