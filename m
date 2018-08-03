Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB52C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F8521748
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QUOD4WK8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="orD8lry9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F8521748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbeHCQ0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:26:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54866 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732362AbeHCQ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:26:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3658A60D0C; Fri,  3 Aug 2018 14:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533306578;
        bh=P+GNtZZyeIlwe5ewxfy9BJ6cDSvlD5Xa0qlQO89Wo2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=QUOD4WK8O/NTEL2+0WwAK4/rfY7FANlPAZDczVi+U68L+JIKTkGZEqU5ut/JFSp75
         dxttLLFBxLNea2bfPjoFOryo0ote3VVJg7vkTLc4XxVBUSjH9ChJsmoPgr5Vg0OJvc
         dM1tOWtFlRBDUT7B++8x17wy8G6TYxdOOZmSqJXA=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D015960B22;
        Fri,  3 Aug 2018 14:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533306573;
        bh=P+GNtZZyeIlwe5ewxfy9BJ6cDSvlD5Xa0qlQO89Wo2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=orD8lry9etnsADIaM4yaaMB9hEZneOyI7NNXzgvolE09sAYgwpILnUMRVHzk641O6
         OpkeVaFctTYbVRvXJK0TgZ1+AipbADzZwHqGq1CqoeHmXcI9h3ddrYzknZ7SUrI8fJ
         h0radPHiexvK7tpWkHL3kiJ0ZPaI7g/9tLiJYxVM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D015960B22
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
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
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [RFC PATCH 3/3] dynamic_debug: Add support for dynamic register trace
Date:   Fri,  3 Aug 2018 19:58:44 +0530
Message-Id: <37c723a7892b21eb67b8447160d8d602703f321f.1533211509.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1533211508.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1533211508.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <cover.1533211508.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1533211508.git.saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce dynamic debug filtering mechanism to register
tracing as dynamic_rtb() which will reduce a lot of
overhead otherwise of tracing all the register reads/writes
in all files.

Now we can just specify the file name or any wildcard pattern
as any other dynamic debug facility in bootargs and dynamic rtb
will just trace them and the output can be seen in pstore.

TODO: Now we use same 'p' flag but will add a separate flag for register trace
later.

Example for tracing all register reads/writes in drivers/soc/qcom/* below:

  # dyndbg="file drivers/soc/qcom/* +p" in bootargs
  # reboot -f
  # mount -t pstore pstore /sys/fs/pstore
  # cat /sys/fs/pstore/rtb-ramoops-0
    [LOGK_WRITEL ] ts:1373030419  data:ffff00000d5065a4  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
    [LOGK_WRITEL ] ts:1373360576  data:ffff00000d506608  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668

Also we add uncached_logk api to readl/writel definitions for arm64
as of now. This can be extended to arm as well later for tracing.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 arch/arm64/include/asm/io.h   | 93 +++++++++++++++++++++++++++++++++++
 include/linux/dynamic_debug.h | 10 ++++
 kernel/trace/Kconfig          |  1 +
 3 files changed, 104 insertions(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 35b2e50f17fb..e5f68b1b00a0 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -22,6 +22,7 @@
 #ifdef __KERNEL__
 
 #include <linux/types.h>
+#include <linux/rtb.h>
 
 #include <asm/byteorder.h>
 #include <asm/barrier.h>
@@ -36,6 +37,7 @@
 /*
  * Generic IO read/write.  These perform native-endian accesses.
  */
+#if !defined(CONFIG_RTB)
 #define __raw_writeb __raw_writeb
 static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
 {
@@ -104,6 +106,97 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 		     : "=r" (val) : "r" (addr));
 	return val;
 }
+#else
+static inline void __raw_writeb_log(u8 val, volatile void __iomem *addr)
+{
+	asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr));
+}
+
+static inline void __raw_writew_log(u16 val, volatile void __iomem *addr)
+{
+	asm volatile("strh %w0, [%1]" : : "rZ" (val), "r" (addr));
+}
+
+static inline void __raw_writel_log(u32 val, volatile void __iomem *addr)
+{
+	asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
+}
+
+static inline void __raw_writeq_log(u64 val, volatile void __iomem *addr)
+{
+	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
+}
+
+static inline u8 __raw_readb_log(const volatile void __iomem *addr)
+{
+	u8 val;
+
+	asm volatile(ALTERNATIVE("ldrb %w0, [%1]",
+				 "ldarb %w0, [%1]",
+				 ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE)
+		     : "=r" (val) : "r" (addr));
+	return val;
+}
+
+static inline u16 __raw_readw_log(const volatile void __iomem *addr)
+{
+	u16 val;
+
+	asm volatile(ALTERNATIVE("ldrh %w0, [%1]",
+				 "ldarh %w0, [%1]",
+				 ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE)
+		     : "=r" (val) : "r" (addr));
+	return val;
+}
+
+static inline u32 __raw_readl_log(const volatile void __iomem *addr)
+{
+	u32 val;
+
+	asm volatile(ALTERNATIVE("ldr %w0, [%1]",
+				 "ldar %w0, [%1]",
+				 ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE)
+		     : "=r" (val) : "r" (addr));
+	return val;
+}
+
+static inline u64 __raw_readq_log(const volatile void __iomem *addr)
+{
+	u64 val;
+
+	asm volatile(ALTERNATIVE("ldr %0, [%1]",
+				 "ldar %0, [%1]",
+				 ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE)
+		     : "=r" (val) : "r" (addr));
+	return val;
+}
+
+#define __raw_write_logged(v, a, _t) ({		\
+	volatile void __iomem *_a = (a);	\
+	void *_addr = (void __force *)(_a);	\
+	dynamic_rtb("LOGK_WRITEL", _addr);	\
+	__raw_write##_t##_log((v), _a);		\
+	})
+
+#define __raw_writeb(v, a)	__raw_write_logged((v), a, b)
+#define __raw_writew(v, a)	__raw_write_logged((v), a, w)
+#define __raw_writel(v, a)	__raw_write_logged((v), a, l)
+#define __raw_writeq(v, a)	__raw_write_logged((v), a, q)
+
+#define __raw_read_logged(a, _l, _t)    ({				\
+	_t __a;								\
+	const volatile void __iomem *_a = (const volatile void __iomem *)(a);\
+	void *_addr = (void __force *)(_a);				\
+	dynamic_rtb("LOGK_READL", _addr);				\
+	__a = __raw_read##_l##_log(_a);					\
+	__a;								\
+	})
+
+#define __raw_readb(a)	__raw_read_logged((a), b, u8)
+#define __raw_readw(a)	__raw_read_logged((a), w, u16)
+#define __raw_readl(a)	__raw_read_logged((a), l, u32)
+#define __raw_readq(a)	__raw_read_logged((a), q, u64)
+#endif
 
 /* IO barriers */
 #define __iormb()		rmb()
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2fd8006153c3..d76bd63c13b3 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -155,6 +155,16 @@ do {								\
 			       buf, len, ascii);		\
 } while (0)
 
+#if defined(CONFIG_RTB)
+#define dynamic_rtb(log_type, data)				\
+do {								\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,		\
+		__builtin_constant_p(log_type) ? log_type : "rtb");\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor))			\
+		uncached_logk(log_type, data);			\
+} while (0)
+#endif
+
 #else
 
 #include <linux/string.h>
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 9bbf7d1f60aa..898fcc38264b 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -724,6 +724,7 @@ config TRACING_EVENTS_GPIO
 
 config RTB
 	bool "Register Trace Buffer"
+	depends on DYNAMIC_DEBUG
 	help
 	  Add support for logging different events to a small uncached
 	  region. This is designed to aid in debugging reset cases where the
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

