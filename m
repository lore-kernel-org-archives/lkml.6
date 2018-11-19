Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09781C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A592086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Oukja+Js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A592086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbeKTIK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:10:26 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43335 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731271AbeKTIKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:10:25 -0500
Received: by mail-qk1-f194.google.com with SMTP id r71so51231111qkr.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 13:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+oQAX8fwUnGMvYCxHbkSvUAGYzEO5k42+h8wSeOChms=;
        b=Oukja+Js1aUq3NeEs4N79u8gxf2bCTQ2K/Z5der+Rrzww1avzZ2PrSS7S4mhMtxpzb
         XLu6KzfuVo7WnqoNO35C4RXKsJMhKDY9xNA4VkIrQWLriPARO3w3RauD6FBo7pn7lmNU
         j8LuJvPcX7OFaGvujNsu6BR3tYL3UVGTAF2drHttnM1rsnDfq27sx1w8KSR5+gSe4WlM
         yz8Ku/AMauxpvMfgKTuY1B7BzYi/nC57xpvWDIyGstX4wJw0RF2EWWOl2RHYULFBK2mz
         6FyRP1Nk4oT3knhZUJSwUK2JJnHmDtDjZ71WefwsUQl29MDCs8hdkAOvigNqUDShBY8a
         tkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+oQAX8fwUnGMvYCxHbkSvUAGYzEO5k42+h8wSeOChms=;
        b=MGvd+7s3Fxr+ve4mItCyuSe09INxHA2X8tW2SfdxHuwid0V06z7rnWi3ewtjg8H8IX
         lha8MLDB4Iv7qzL90reOXxw7nCPInEnZUMjM+i0SSZTgYZ9CbcOJ6MegmlV9ILh/QfZS
         Tv6ptSO+jwvcNBxrexItb5ByFbBwzrYo1bcBoIHWbNF4ZUbwB6CeMBh+DOHSj4nC8UV+
         yFAAsc0fBBIPIVsAOvYzyRbCKNOcJEPRJEfHVbeNCeW9FPZPTz9D3mZqCSQScwi6/qJ0
         k/A3nZOgbDALFgwffVQ6R9Br7T0GfYXC22R3g1FQFVMvcHmu/NodQSiOkj3R5vGtysPM
         IZSQ==
X-Gm-Message-State: AGRZ1gLe7zxJchWXPY4LWvQbDWSU/YwNMa+q2y8GbCfH9yfw2/ki4wGy
        ISUqlrInMSyOl5+nrAUXc2dPWA==
X-Google-Smtp-Source: AJdET5eCz8eaYpJLthFftXGDx+7xM8nZvQyJsMUXnrynMCHshVEfCIAcsKk/W8Vp9iHsJqS17FVO2w==
X-Received: by 2002:ac8:7116:: with SMTP id z22mr14773455qto.377.1542663886774;
        Mon, 19 Nov 2018 13:44:46 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x5sm27493714qtc.43.2018.11.19.13.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 13:44:46 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, ard.biesheuvel@linaro.org, andrew.murray@arm.com,
        james.morse@arm.com, marc.zyngier@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com
Subject: [PATCH v1 1/1] arm64: Early boot time stamps
Date:   Mon, 19 Nov 2018 16:44:43 -0500
Message-Id: <20181119214443.25175-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119214443.25175-1-pasha.tatashin@soleen.com>
References: <20181119214443.25175-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow printk time stamps/sched_clock() to be available from the early
boot.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/setup.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f4fc1e0544b7..4df41a66b403 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -40,6 +40,7 @@
 #include <linux/efi.h>
 #include <linux/psci.h>
 #include <linux/sched/task.h>
+#include <linux/sched_clock.h>
 #include <linux/mm.h>
 
 #include <asm/acpi.h>
@@ -279,8 +280,26 @@ arch_initcall(reserve_memblock_reserved_regions);
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
+/*
+ * Get time stamps available early in boot, useful to identify boot time issues
+ * from the early boot.
+ */
+static __init void sched_clock_early_init(void)
+{
+	u64 freq = arch_timer_get_cntfrq();
+	u64 (*read_time)(void) = arch_counter_get_cntvct;
+
+	/* Early clock is available only on platforms with known freqs */
+	if (!freq)
+		return;
+
+	sched_clock_register(read_time, BITS_PER_LONG, freq);
+}
+
 void __init setup_arch(char **cmdline_p)
 {
+	sched_clock_early_init();
+
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
-- 
2.19.1

