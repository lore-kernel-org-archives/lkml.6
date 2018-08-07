Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C2CC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFCC2159F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0RJnfSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFCC2159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeHHAmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:42:14 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:39772 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeHHAmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:42:14 -0400
Received: by mail-qt0-f202.google.com with SMTP id c6-v6so233074qta.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qJCOjqNxFtKmqGH5vUW3yqjdtP2jB6E+9RWxAqqlfzc=;
        b=j0RJnfSnJHeisHvX2LaicgfuFtaL7Zh/vzA4e1LOVV5cGnpt8WnWwZWbxBKAFpYMom
         R1KqNuUMhzLbioDtjEoaJshf5sGewm6+UkcbyIaZC/wJdWgV4Vr0U/4e0Z3S9SYCAJMz
         LZXFNxSVR8tG1IWiZyuWrUrYGkAry3ULczeb048J4Cz8X9A48Zw/ABySZ4RLiU51cV6+
         S3qRfDErmaAxNvsw+70OY2xZ6YUeGhbuwsPXfhlE5kBTQkexXEBC1xlLoxGJM+zI2W7F
         5LGSHJAAHiV2xASOx5AWkPK7EclPW8wzo/ZjfgpvLrQGA82/vEherejbqsh2jlmXb0Xo
         dOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qJCOjqNxFtKmqGH5vUW3yqjdtP2jB6E+9RWxAqqlfzc=;
        b=DrmSPBJhnfe0SgBce/7AEbqARAh38fd9CqiF4EUeMLize37HFtu09gk3mDW6Q3pwLs
         4YZzK8LttyH5tvzVWEtDjsZ2v4gZG40LMX6OZ+4HQR/+9A4K7WHPp0ex9oPawUrfQZ9P
         wRYkKL2Hl6eRTr81b1soRSeTYv2EFgLdZS7pIH7BXNtPM6Qm+BTyPy028WKH0SSU0mSN
         5dPnRpCkgD4IgZKBqPLITBVTlIVFXMxqkZmxOyMlU4peLRSJXS4s1nM/9emhn8EYsDEL
         9a2dZGtNfYuTsWsuYQuAPUjpqFf6ZhFITsoaXdrthV7uFkC6srAi04AYjAD0gdmov9Qh
         3sdw==
X-Gm-Message-State: AOUpUlGm6sTL3ObdWUmU5hBVHdPKeMMjX/jExgDDxj3O7osu0IbZH9Gb
        1UTGsrQnVLaeb7dLstrNieoXCphhN4A6ow==
X-Google-Smtp-Source: AA+uWPyu7FCyuaVKpoeQP1qIX2Zc+D3/lT9UBIeJGRNT7cLl5maXwpCAxK9aM0hOF1RDPhE50IBSJX1LV/Y/vw==
X-Received: by 2002:ac8:48d:: with SMTP id s13-v6mr182412qtg.60.1533680742478;
 Tue, 07 Aug 2018 15:25:42 -0700 (PDT)
Date:   Tue,  7 Aug 2018 15:25:35 -0700
Message-Id: <20180807222535.143193-1-jmattson@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] x86/spectre: Expand test for vulnerability to empty RSB exploits
From:   Jim Mattson <jmattson@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org, Fred Jacobs <fjacobs@vmware.com>,
        Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skylake-era Intel CPUs are vulnerable to exploits of empty RSB
conditions. On hardware, platform vulnerability can be determined
simply by checking the processor's DisplayModel/DisplayFamily
signature.  However, when running in a VM, the operating system should
also query IA32_ARCH_CAPABILITIES.RSBA[bit 2], a synthetic bit that
can be set by a hypervisor to indicate that the VM might run on a
vulnerable physical processor, regardless of the
DisplayModel/DisplayFamily reported by CPUID.

Note that IA32_ARCH_CAPABILITIES.RSBA[bit 2] is always clear on
hardware, so the DisplayModel/DisplayFamily check is still required.

For all of the details, see the Intel white paper, "Retpoline: A
Branch Target Injection Mitigation" (document number 337131-001),
section 5.3: Virtual Machine CPU Identification.

Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kernel/cpu/bugs.c       | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 68b2c3150de1..f37ec58c4e04 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -70,6 +70,7 @@
 #define MSR_IA32_ARCH_CAPABILITIES	0x0000010a
 #define ARCH_CAP_RDCL_NO		(1 << 0)   /* Not susceptible to Meltdown */
 #define ARCH_CAP_IBRS_ALL		(1 << 1)   /* Enhanced IBRS support */
+#define ARCH_CAP_RSBA			(1 << 2)   /* Vulnerable to empty RSB */
 #define ARCH_CAP_SSB_NO			(1 << 4)   /*
 						    * Not susceptible to Speculative Store Bypass
 						    * attack, so no Speculative Store Bypass
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5c0ea39311fe..b6fe335746a4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -330,6 +330,18 @@ static bool __init is_skylake_era(void)
 	return false;
 }
 
+/* Check for vulnerability to exploits of empty RSB conditions */
+static bool __init is_vulnerable_to_empty_rsb(void)
+{
+	u64 ia32_cap = 0;
+
+	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
+
+	return (ia32_cap & ARCH_CAP_RSBA) || is_skylake_era();
+}
+
+
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
@@ -402,7 +414,7 @@ static void __init spectre_v2_select_mitigation(void)
 	 * switch is required.
 	 */
 	if ((!boot_cpu_has(X86_FEATURE_PTI) &&
-	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
+	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_vulnerable_to_empty_rsb()) {
 		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 		pr_info("Spectre v2 mitigation: Filling RSB on context switch\n");
 	}
-- 
2.18.0.597.ga71716f1ad-goog

