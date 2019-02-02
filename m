Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8A6C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA622173B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTfxvEmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfBBNPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 08:15:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33588 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbfBBNPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 08:15:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so4299783pgu.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 05:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Ges32LHPg+2yzjDern7OBAJnkY60393Ywovq/o3kjw=;
        b=MTfxvEmE+hXJY0lJ45ZIj8c5fJkwyJzbbtA1EJXZshKcefjEqBFbw47Ehy7opXw7Ww
         jy59c1A2GXM0GWeD14ydsF8JrLEDHJMrN0TFN4GOsH3aEUqWIJZX8WHIdswHOfO+L5gh
         J2tekoHrz6fhzbEXtdARj2nKKeI4hOpHY5MvmOrrvXuAF8Vj4dqxfRj3Cc7oySAf5XyC
         sHMMsFbrsTJg4kX1XFVXlFsv/HLcBs4ghFdurHYeo7rxqN+Jr3m9Za/YxHr7Ylaslrwr
         LVhjA7UY4OLocCTWVtqhazsW7yLng3SwMEYIyI5Ib5kP3ywbpPJQN+23qlLOj9tKHFVr
         1kQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Ges32LHPg+2yzjDern7OBAJnkY60393Ywovq/o3kjw=;
        b=mb20LR06kEvmnKxRGfPcJhN+ViQMf095QSrbE/Cs1mWUpUfEVaYx3daU6e5+nUlcPq
         g8/0rNPiutbFGdtMFgeHYHTfx3N5Y8i0yhf2pCSVA2whkKtlqc0eS26uapUXxpaxQ3wb
         SDLOFtH8q2bcqQgmFeLZ8q8hw00HFEb6SuAwdsQeVMX4WTMdNU/pvPRI+S3wU/oGtMZo
         /FI90VpNt1dV/AmYmg2liZtSkec81zFa5R0Ibz730r0yhwH2dQS94ItvdmG4VdxpaIA5
         PdaM8UKlMkhXBswbL1kDeNQsw5zz04Mcw6UD1A/VGjFQlE/7WaxpTTLEa/4v/JAF3ele
         iWUw==
X-Gm-Message-State: AHQUAuYtd9jGpp+cIyWqvcwOZzHvWBIvn0syNlgoOR9FdgzVUys7kiaF
        8bK4tHyZOgLIb3/NBGREMKc=
X-Google-Smtp-Source: AHgI3IaKZedMLBzFn7A7B7vmYKUjUDPu37IqIfk4XemSoaovnA3iw7Y4DZm9MBemyp/6xUEUCPpaKA==
X-Received: by 2002:a63:2141:: with SMTP id s1mr6143124pgm.148.1549113306855;
        Sat, 02 Feb 2019 05:15:06 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id g28sm15148045pfd.100.2019.02.02.05.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Feb 2019 05:15:05 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, joro@8bytes.org, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, iommu@lists.linux-foundation.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com,
        alex.williamson@redhat.com, dan.carpenter@oracle.com
Subject: [PATCH V2 1/3] x86/Hyper-V: Set x2apic destination mode to physical when x2apic is available
Date:   Sat,  2 Feb 2019 21:14:45 +0800
Message-Id: <1549113287-5606-2-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549113287-5606-1-git-send-email-Tianyu.Lan@microsoft.com>
References: <1549113287-5606-1-git-send-email-Tianyu.Lan@microsoft.com>
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

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       - Remove redundant extern for x2apic_phys
---
 arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e81a2db..4bd6d90 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -328,6 +328,16 @@ static void __init ms_hyperv_init_platform(void)
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
 # endif
+
+/*
+ * Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
+ * set x2apic destination mode to physcial mode when x2apic is available
+ * and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs
+ * have 8-bit APIC id.
+ */
+	if (IS_ENABLED(CONFIG_HYPERV_IOMMU) && x2apic_supported())
+		x2apic_phys = 1;
+
 #endif
 }
 
-- 
2.7.4

