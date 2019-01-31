Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F40C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EABE218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXo23dZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbfAaKSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:18:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42533 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfAaKSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:18:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so1265984plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GSsa4cz53oK4WF704GByADPLNT6tPN3u1p6vSHbfrH0=;
        b=nXo23dZ7OHQQZPyZEOFHELGs+L3NsKm1T/rJepsLrs/uWQDRH1cXF7/Y2vDZZ6opPX
         O6H+j4on0WszASrumIy4LwBp+WfaW0HErCxhEbbK9S7U7g+ATI7vT8gdkPT/KqL48ZIk
         WbXUkjjmeU7rHKUu88RZt27dvr5HXfmiAe0LLu5SPm4HFJs/AlFtQB6Z3IGjx7FmhYMv
         Z2c+i/frcf9ZF7p7J8kQo4c+xOaKn2KAHkDiKr5JPy8bM0PuMGIs6Jyh+COF4Nn50GAz
         ryr+D2Xj00QQ6IyeOLrgH+5DSRueXPBWFN5Sm8NRc8+9IeTB3StAiciuJsy9R7yWxH5h
         Bf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GSsa4cz53oK4WF704GByADPLNT6tPN3u1p6vSHbfrH0=;
        b=bqg8IxT99QFjhfTqdwthrhGoAQ5rQbH8nq+5v50AIBd/JVdxH4+EngV80AwDibLums
         zs5YjjDU9VINjK1qarH+7T+qnXDz6J05aqcru3n7hfllzeqJ4FoHAuWKJTWSsmqvxmcu
         DMBe0mUilE0oYzSJGut143P84pi/VL3ntpELAMbP1PCs+fk2s7CjIrq0Npgv3VD4GlGl
         ETf4HB3Pl2Lu68Q0rG/E0iQhf1MddutivcbVXXNGffGkIub3F/7nqZxHLmmXWklq2rnX
         Xd2pmPIUS3cdHEXh5NulZcI6/wLiKcMffqTZOAJ8qyCrw2LL9K9Fxsxe7l1ziA6bwoxN
         CixQ==
X-Gm-Message-State: AJcUukdXfbdNNv/tOmf7phAvPOEKa3NzIwLyjSPULRHOMxWWRNKZu4pz
        pcaERLpgJLs2gTKT2A5fFDQ=
X-Google-Smtp-Source: ALg8bN6QMux67Vz9RpngaUnVEfeNMgm0+lhB9fkoKjLncZ33u0psX5H8gFimARY6NgQI4JQ7Bjt7eQ==
X-Received: by 2002:a17:902:2f03:: with SMTP id s3mr33478433plb.277.1548929879976;
        Thu, 31 Jan 2019 02:17:59 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id p67sm5944830pfg.44.2019.01.31.02.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 02:17:59 -0800 (PST)
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
        alex.williamson@redhat.com
Subject: [PATCH 1/3] x86/Hyper-V: Set x2apic destination mode to physical when x2apic is available
Date:   Thu, 31 Jan 2019 18:17:31 +0800
Message-Id: <1548929853-25877-2-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
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
 arch/x86/kernel/cpu/mshyperv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e81a2db..9d62f33 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -36,6 +36,8 @@
 struct ms_hyperv_info ms_hyperv;
 EXPORT_SYMBOL_GPL(ms_hyperv);
 
+extern int x2apic_phys;
+
 #if IS_ENABLED(CONFIG_HYPERV)
 static void (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
@@ -328,6 +330,18 @@ static void __init ms_hyperv_init_platform(void)
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
+# if IS_ENABLED(CONFIG_HYPERV_IOMMU)
+	if (x2apic_supported())
+		x2apic_phys = 1;
+# endif
+
 #endif
 }
 
-- 
2.7.4

