Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A51C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8548B2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loe07Ibj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfBKOU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:20:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46883 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfBKOUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:20:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so5001520pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tTPsu0Tly/9LmgM4P6llE4UL5oymeBEZj3d8anCiLC8=;
        b=loe07IbjkU/2n5IJhCPJM6oG8gFvpRcbZsvZ+Aibb4wp4HS7J1ZJ9sny/T67j0f7E5
         8NvD8pMp7VmF44ahqKIFWSCChZ0O1UsA8J9wGdcy228wQG8YzUr8psDz3uXqT/LPvZIM
         2mToZFvgZteKib5NP4Q1Qe9s8TVf4TgU96I5RItnofLZNTcZ0Jgo6uSA/NcPJfZrimzf
         LEZ7uBHHulRlvG92ZF+2N3fcVcJPmciXG3lmRxjulanucso94f5bmBFVLehUale1DVKJ
         GI93a5guP4HhtJsHLFJhEAsoNcEWBrPOk7zsaFrB0jVd+MOUFGBRrGu5kCwxI4SLluak
         4kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tTPsu0Tly/9LmgM4P6llE4UL5oymeBEZj3d8anCiLC8=;
        b=mlQD+vFzcrW0I7i44wFtx2j6wHAH8YgUDh4Nb/H90ewcR2CHpOfHDXdFM8+3jsV66r
         BlN1+3+goTc0scnrcIDs4/54GTUZL2kyek1OG0HZ/qW2nZc2gmre7ZG5YrzyNI5DuPTt
         Vt0wMSVBD33BDiYjKREpRFzFplfCJoYZsDKIGKX4MT3CyzBmZyDc/Vn3sxpQs/U+w8vC
         feSu4gYwP9UZCLMBZ3DoAY2vSsWBTyr8JYYRCe07wb9KrnqGsce6rk9z02TzncttmDyN
         Dpdp/1Wmn6fCy2OdQpJJIov38SkrOC0jUzEyK/mk79a5ghf0+nKGclRkhac3GrDz7qGk
         dz1w==
X-Gm-Message-State: AHQUAualebfzcX0IPNDvagAFG1mTDdz9MlsLXPPRuwtBthcAxYOOSWcS
        G1EF2uWBLw1yKvmsjtIsBdA=
X-Google-Smtp-Source: AHgI3IZI1DMyazyWztIUhYH7zaJWnGVQEqTLht7KrTX6b0OTinspZivNEePKVIOToJfKc/StiI1w4w==
X-Received: by 2002:a65:6219:: with SMTP id d25mr19043834pgv.18.1549894852247;
        Mon, 11 Feb 2019 06:20:52 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id e2sm20551664pga.92.2019.02.11.06.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 06:20:51 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, joro@8bytes.org, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com, alex.williamson@redhat.com,
        dan.carpenter@oracle.com
Subject: [PATCH V4 1/3] x86/Hyper-V: Set x2apic destination mode to physical when x2apic is available
Date:   Mon, 11 Feb 2019 22:20:22 +0800
Message-Id: <1549894824-26623-2-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
References: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
set x2apic destination mode to physcial mode when x2apic is available
and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
8-bit APIC id.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v2:
       - Fix compile error due to x2apic_phys
       - Fix comment indent
Change since v1:
       - Remove redundant extern for x2apic_phys
---
 arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e81a2db..0c29e4e 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -328,6 +328,16 @@ static void __init ms_hyperv_init_platform(void)
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
 # endif
+
+	/*
+	 * Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
+	 * set x2apic destination mode to physcial mode when x2apic is available
+	 * and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs
+	 * have 8-bit APIC id.
+	 */
+	if (IS_ENABLED(CONFIG_X86_X2APIC) && x2apic_supported())
+		x2apic_phys = 1;
+
 #endif
 }
 
-- 
2.7.4

