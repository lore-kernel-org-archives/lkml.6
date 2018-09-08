Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A227C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BFE20645
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mnxs8KCh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QVFeaYzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BFE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeIIBPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 21:15:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49060 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeIIBPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 21:15:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AD54A60C4B; Sat,  8 Sep 2018 20:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536438528;
        bh=s/4HW6Ju/hAPrCTV9+MZr06mE12Pko0OOktWpH8Rzyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mnxs8KChdBJX97/83BjmZXVl68/GK+dQsHodh4/2cHWIcm4wU6q7wiDb2r18TpAID
         p7VWL/eQyLEZcue9lbBWlkdiloyuf8FuPde0fK5lQ3JV9l43q4VhFNXUkmOu3lhB1i
         7/oy1AEOmIfkX82tDRaeFgKoc791YAx3cdKDpvxo=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0ABA60BE1;
        Sat,  8 Sep 2018 20:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536438523;
        bh=s/4HW6Ju/hAPrCTV9+MZr06mE12Pko0OOktWpH8Rzyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVFeaYzL7OivItbKyrt8rYyWRZ+DjN8wvYCUM9QQP/d3Ir0HWwEgVQo4Kcb0fwMs0
         J6NlkUPmeFAPJSpGAGgL6KxGXDxycFE36wOXBf2B5IYX3QaedKYfw6m9LhFT1lV650
         RnjVQjM6zSeJcnf2wXcNasW6/2OIRQ2ToXhKZmXM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0ABA60BE1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 5/6] arm64/io: Add header for instrumentation of io operations
Date:   Sun,  9 Sep 2018 01:57:06 +0530
Message-Id: <bb322d763aa6c58f036e5209a481c769be92ab9b.1536430404.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new asm-generic/io-instrumented.h will keep arch code
clean and separate from instrumented version which traces
io register accesses. This instrumented header can later
be included in arm as well for tracing io register accesses.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 arch/arm64/include/asm/io.h           | 25 ++++++---------
 include/asm-generic/io-instrumented.h | 45 +++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 16 deletions(-)
 create mode 100644 include/asm-generic/io-instrumented.h

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 35b2e50f17fb..768a6a8c5778 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -36,32 +36,27 @@
 /*
  * Generic IO read/write.  These perform native-endian accesses.
  */
-#define __raw_writeb __raw_writeb
-static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
+static inline void arch_raw_writeb(u8 val, volatile void __iomem *addr)
 {
 	asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr));
 }
 
-#define __raw_writew __raw_writew
-static inline void __raw_writew(u16 val, volatile void __iomem *addr)
+static inline void arch_raw_writew(u16 val, volatile void __iomem *addr)
 {
 	asm volatile("strh %w0, [%1]" : : "rZ" (val), "r" (addr));
 }
 
-#define __raw_writel __raw_writel
-static inline void __raw_writel(u32 val, volatile void __iomem *addr)
+static inline void arch_raw_writel(u32 val, volatile void __iomem *addr)
 {
 	asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
 }
 
-#define __raw_writeq __raw_writeq
-static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
+static inline void arch_raw_writeq(u64 val, volatile void __iomem *addr)
 {
 	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
 }
 
-#define __raw_readb __raw_readb
-static inline u8 __raw_readb(const volatile void __iomem *addr)
+static inline u8 arch_raw_readb(const volatile void __iomem *addr)
 {
 	u8 val;
 	asm volatile(ALTERNATIVE("ldrb %w0, [%1]",
@@ -71,8 +66,7 @@ static inline u8 __raw_readb(const volatile void __iomem *addr)
 	return val;
 }
 
-#define __raw_readw __raw_readw
-static inline u16 __raw_readw(const volatile void __iomem *addr)
+static inline u16 arch_raw_readw(const volatile void __iomem *addr)
 {
 	u16 val;
 
@@ -83,8 +77,7 @@ static inline u16 __raw_readw(const volatile void __iomem *addr)
 	return val;
 }
 
-#define __raw_readl __raw_readl
-static inline u32 __raw_readl(const volatile void __iomem *addr)
+static inline u32 arch_raw_readl(const volatile void __iomem *addr)
 {
 	u32 val;
 	asm volatile(ALTERNATIVE("ldr %w0, [%1]",
@@ -94,8 +87,7 @@ static inline u32 __raw_readl(const volatile void __iomem *addr)
 	return val;
 }
 
-#define __raw_readq __raw_readq
-static inline u64 __raw_readq(const volatile void __iomem *addr)
+static inline u64 arch_raw_readq(const volatile void __iomem *addr)
 {
 	u64 val;
 	asm volatile(ALTERNATIVE("ldr %0, [%1]",
@@ -193,6 +185,7 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 #define iowrite32be(v,p)	({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
 #define iowrite64be(v,p)	({ __iowmb(); __raw_writeq((__force __u64)cpu_to_be64(v), p); })
 
+#include <asm-generic/io-instrumented.h>
 #include <asm-generic/io.h>
 
 /*
diff --git a/include/asm-generic/io-instrumented.h b/include/asm-generic/io-instrumented.h
new file mode 100644
index 000000000000..7b050e2487ed
--- /dev/null
+++ b/include/asm-generic/io-instrumented.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_IO_INSTRUMENTED_H
+#define _ASM_GENERIC_IO_INSTRUMENTED_H
+
+#if defined(CONFIG_TRACING_EVENTS_IO)
+#include <linux/tracepoint-defs.h>
+
+extern struct tracepoint __tracepoint_io_write;
+extern struct tracepoint __tracepoint_io_read;
+#define io_tracepoint_active(t) static_key_false(&(t).key)
+extern void do_trace_io_write(const char *type, void *addr);
+extern void do_trace_io_read(const char *type, void *addr);
+#else
+#define io_tracepoint_active(t) false
+static inline void do_trace_io_write(const char *type, void *addr) {}
+static inline void do_trace_io_read(const char *type, void *addr) {}
+#endif /* CONFIG_TRACING_EVENTS_IO */
+
+#define __raw_write(v, a, _l)	({						\
+	volatile void __iomem *_a = (a);					\
+	if (io_tracepoint_active(__tracepoint_io_write))			\
+		do_trace_io_write(__stringify(write##_l), (void __force *)(_a));\
+	arch_raw_write##_l((v), _a);						\
+	})
+
+#define __raw_writeb(v, a)	__raw_write((v), a, b)
+#define __raw_writew(v, a)	__raw_write((v), a, w)
+#define __raw_writel(v, a)	__raw_write((v), a, l)
+#define __raw_writeq(v, a)	__raw_write((v), a, q)
+
+#define __raw_read(a, _l, _t)    ({						\
+	_t __a;									\
+	const volatile void __iomem *_a = (a);					\
+	if (io_tracepoint_active(__tracepoint_io_read))				\
+		do_trace_io_read(__stringify(read##_l), (void __force *)(_a));	\
+	__a = arch_raw_read##_l(_a);						\
+	__a;									\
+	})
+
+#define __raw_readb(a)	__raw_read((a), b, u8)
+#define __raw_readw(a)	__raw_read((a), w, u16)
+#define __raw_readl(a)	__raw_read((a), l, u32)
+#define __raw_readq(a)	__raw_read((a), q, u64)
+
+#endif /* _ASM_GENERIC_IO_INSTRUMENTED_H */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

