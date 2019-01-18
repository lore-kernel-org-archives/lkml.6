Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBE7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9659420855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SXS6zvSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfARFoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:44:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39686 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfARFoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:44:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so5513598pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 21:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1GHCrIH/zhKjvR57yQojViA6vvVSllVOfQJXVhcIPV8=;
        b=SXS6zvSgz61eGAv+AUSQPQ6wGd+cifI1ReG8IIAjkcfzVHY/3CovtB/8eydebQ4gIt
         zSmEDiZIqGQpIePtIG19FbT36ChW54ES9DRZYdohs7GSnjD94HVMlmucXef3izKcnWI8
         wTzAocoVkZC88/FlTk2jgcE8vDUqnsZenLBoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1GHCrIH/zhKjvR57yQojViA6vvVSllVOfQJXVhcIPV8=;
        b=XMQgjiceskNvhiegY799wrWVNxCu5PRpW5/QlEaGBVkGKYqb/e8NlfsmFHNssgxVfP
         yM2/YT2QiSfP5Lslw+pd0fDy1ln8f3XiY7sEJ8ABDHMNsrwqe11N3qav0OVoFqb1sqf2
         epcZECsc+ofVpT/TmCm8h/JNawQ15hOcRtDMJoBz4Shk/ll1yCuG5dzBSR+8CC1X1Pyu
         3fqHdIPOlGvs2WYPv0b8URKI6J7CBSVTIeFvNELtHV1TjBNHwqI+b5zi/KToS13omMon
         +QScQPZ8OIunoPLtQ90OblIEs4zpkJELnB4K1kYiDUC2Ysmq6mD8RedoUi5OqeXfQUep
         B7Ww==
X-Gm-Message-State: AJcUukdNS86KnzHs/E4zY2G8aAZ7HR1QT8WJ7ZsI+Pb8ZRTi+7522rkM
        t9IQjU/NJhFc4ePjgtpaqpLRO8y2a5kykA==
X-Google-Smtp-Source: ALg8bN49T6bfJ1cB6jKb8O0W5gsSDGCPeYkKhTQ8bC3uZz/f6qYeJnrPPuAyBV86a9zR6czQAf8k5Q==
X-Received: by 2002:a63:68c4:: with SMTP id d187mr16071423pgc.11.1547790257873;
        Thu, 17 Jan 2019 21:44:17 -0800 (PST)
Received: from pramodku-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 202sm4537444pfy.87.2019.01.17.21.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 21:44:17 -0800 (PST)
From:   Pramod Kumar <pramod.kumar@broadcom.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: [PATCH INTERNAL RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug is supported
Date:   Fri, 18 Jan 2019 11:15:00 +0530
Message-Id: <1547790300-6190-1-git-send-email-pramod.kumar@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CPU hotplug is supported, ipi_cpu_stop should use PSCI cpudie
call to stop the CPU. This call ensures L1/L2 cache flush,
CPUs cache-cohenrecy setting w.r.to interconnect.

Apart from this, this gives control to f/w to reduce power consumption
by take appropriate decesion on power rails for plugging-out core.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/kernel/smp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1598d6f..360e52b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -822,8 +822,13 @@ static void ipi_cpu_stop(unsigned int cpu)
 	local_daif_mask();
 	sdei_mask_local_cpu();
 
+#ifdef CONFIG_HOTPLUG_CPU
+	if (cpu_ops[cpu]->cpu_die)
+		cpu_ops[cpu]->cpu_die(cpu);
+#else
 	while (1)
 		cpu_relax();
+#endif
 }
 
 #ifdef CONFIG_KEXEC_CORE
-- 
1.9.1

