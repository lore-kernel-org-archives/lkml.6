Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A924AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DC02229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DjeCDkyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439408AbfBNOua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:50:30 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42840 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439338AbfBNOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:49:49 -0500
Received: by mail-qt1-f196.google.com with SMTP id b8so7058592qtr.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VL5Y6vm9NuZCG1g7W3hxrDkMxlPp0J/npa1K1+DSsiA=;
        b=DjeCDkyV03p1MH23SfbryccfoXky+ZfeRQgVk59WH61M3aiQFNuoTqEtnSd18iHNvz
         jNbVyzFcF/kLYL5g1hgCcz/ZFhr1ONI3akJbnPFHJ9JWg7SSqiqjy4xSEGYcMrK33XAH
         RFtFyVjp6H2T3psO58C5eLTbzsvOi8U3juSoTmm0jdYHZFF8avbc5gTgSPx23/r1Th5O
         vwS0Htt/7JZgffxa+wg/Ii9eWKpuQmE5HLBqLaeCEDkqvsHBuCZ7iZsdCWXwbAtmTLm1
         3dazqrRVXEDpDMY67zjdO1PTI5vm5fylBbd6lP1TtohRWOmJSP/yQkluTwsNz5pbi7TL
         0XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VL5Y6vm9NuZCG1g7W3hxrDkMxlPp0J/npa1K1+DSsiA=;
        b=gI0FPuwKszvQVjtW/KYtsg6butEGU47bXPJnHgafMmm/lGmH2yKAwOpwWM1tKcVU7c
         Zp5kq03T9rQa96cX4udK5hg/1dTLkJQpk0kUE9Bo3UWmw3mUdY/c9y6ncghIHWbmMXgd
         Rubz7TsXGFG1TUAhoE6H4M24AU132BPEQbvCicgu/ayH2tA6dKC7t4Fk+Yx/GsyCzh6f
         Sy+fVxTSd+StRo5WJh6T4AC2gff27deJqIwS7a4D13P/XVeqy4aKPVqk1ZA+89d9bzgD
         jNuy619cOFE7bE+SwocBE6CUUyUjlowoxISVPyW2Rj1o4XlKIddhde/4WfjkUxBm1Z7y
         YfXg==
X-Gm-Message-State: AHQUAuYmg4F/XVf/SXWLko0mNiL0XMMBxEkbpWVhIvQNK/Vm8FlBYEBM
        2f/2QKar7m9bO0R30bkumA8mAQ==
X-Google-Smtp-Source: AHgI3IbB0ZSFfIrhdjj4XKHl5dxzwGQFiY0GI+HzN6q1flYBcTqnMA61qDFeacUeSNmw+iMsy6qDwg==
X-Received: by 2002:a0c:d80f:: with SMTP id h15mr3241724qvj.228.1550155787910;
        Thu, 14 Feb 2019 06:49:47 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id k66sm1498919qkc.25.2019.02.14.06.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:49:47 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.9 11/16] ARM: split out processor lookup
Date:   Thu, 14 Feb 2019 09:49:25 -0500
Message-Id: <20190214144930.27539-12-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
References: <20190214144930.27539-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 65987a8553061515b5851b472081aedb9837a391 upstream.

Split out the lookup of the processor type and associated error handling
from the rest of setup_processor() - we will need to use this in the
secondary CPU bringup path for big.Little Spectre variant 2 mitigation.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/cputype.h |  1 +
 arch/arm/kernel/setup.c        | 31 +++++++++++++++++++------------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index c55db1e22f0c..b9356dbfded0 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -106,6 +106,7 @@
 #define ARM_CPU_PART_SCORPION		0x510002d0
 
 extern unsigned int processor_id;
+struct proc_info_list *lookup_processor(u32 midr);
 
 #ifdef CONFIG_CPU_CP15
 #define read_cpuid(reg)							\
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index f4e54503afa9..8d5c3a118abe 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -667,22 +667,29 @@ static void __init smp_build_mpidr_hash(void)
 }
 #endif
 
-static void __init setup_processor(void)
+/*
+ * locate processor in the list of supported processor types.  The linker
+ * builds this table for us from the entries in arch/arm/mm/proc-*.S
+ */
+struct proc_info_list *lookup_processor(u32 midr)
 {
-	struct proc_info_list *list;
+	struct proc_info_list *list = lookup_processor_type(midr);
 
-	/*
-	 * locate processor in the list of supported processor
-	 * types.  The linker builds this table for us from the
-	 * entries in arch/arm/mm/proc-*.S
-	 */
-	list = lookup_processor_type(read_cpuid_id());
 	if (!list) {
-		pr_err("CPU configuration botched (ID %08x), unable to continue.\n",
-		       read_cpuid_id());
-		while (1);
+		pr_err("CPU%u: configuration botched (ID %08x), CPU halted\n",
+		       smp_processor_id(), midr);
+		while (1)
+		/* can't use cpu_relax() here as it may require MMU setup */;
 	}
 
+	return list;
+}
+
+static void __init setup_processor(void)
+{
+	unsigned int midr = read_cpuid_id();
+	struct proc_info_list *list = lookup_processor(midr);
+
 	cpu_name = list->cpu_name;
 	__cpu_architecture = __get_cpu_architecture();
 
@@ -700,7 +707,7 @@ static void __init setup_processor(void)
 #endif
 
 	pr_info("CPU: %s [%08x] revision %d (ARMv%s), cr=%08lx\n",
-		cpu_name, read_cpuid_id(), read_cpuid_id() & 15,
+		list->cpu_name, midr, midr & 15,
 		proc_arch[cpu_architecture()], get_cr());
 
 	snprintf(init_utsname()->machine, __NEW_UTS_LEN + 1, "%s%c",
-- 
2.17.1

