Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ACDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9792204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="poyAxVX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9792204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbeH2Tl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:41:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46348 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbeH2Tl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:41:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so2484629pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=2meWOA9oGDyWgLQWwxPX/f4xl+IDWSF7Snih4pWm2Ok=;
        b=poyAxVX7NeugMGsgxtBRd8vr6/V+rNf5OU8w4pf57ejqcka0Xf+WdzyqYoBDJfiEzE
         Oh/g7YbSwP9IXd5AZdlfAnL+5rYX6Jl060KpBwJFuT6sxCrgS6ycIZBB1WeRznFRC36D
         NCHLFU1Jz2LvAJiJfLCTa10OqDVyU741bolN0I85p3E6sp+jJYsdXsUnxbYx7BV8G05i
         59Gt3fE2JA7KdcSEwCGqiaArAtoqCwg6PIKuFc6K7u+45xx++H1KKRnuNNhz3ZSTyIEY
         tmi2ClSLzKIIxXBXkFg5A6vlAyfengONEcl+eQOzEwJc1YkZX9y4IizidvuqQtpwdn4W
         /hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=2meWOA9oGDyWgLQWwxPX/f4xl+IDWSF7Snih4pWm2Ok=;
        b=YOP2OF4lIcR1D9V/Ha5rta3AXYc9ddisCia3aq2VvzcUBB0jjTQ/vrtpI8kipn7T9x
         +jrkGuW42u45BTAvT4X0xRmdzJg6T8KUQNUNAxbxM+Cn8nS/yEEFPq/K30Bjs6Gu9zrR
         zV00UAfuMrOKvzr7Rg2WSY5zumN4lgnnm9rq/PWAV9AjtYawOOYSismAs94in5zeGftF
         euYrzWC44RTGV08gRouvsSzCLCy5VbnExyUkm0tSbLraJNEMNcYiWAUc0/xOdnML2dq1
         MZQ2czZOhXEYjTubLJB8klhxSJwszhyg7QxiitXzhZ3PbSX5RBNQX31pcUkIEn+6E5Dn
         fINQ==
X-Gm-Message-State: APzg51CDYgwfyaEtmw+heykIFNoBoYHHdNanYCtMxKpkmSs7V1e7tjAq
        fSCgMcOSLfbbp/cbCZCu1tk=
X-Google-Smtp-Source: ANB0Vda6X1r+XvlS1cGdGAyvLAl0Sm8I5CvK9LfXFWMvbOnA2KYF25MjxIptYr8uk4Hbn2iqIVjS8g==
X-Received: by 2002:a63:3cc:: with SMTP id 195-v6mr6016530pgd.229.1535557434947;
        Wed, 29 Aug 2018 08:43:54 -0700 (PDT)
Received: from mhkkerneltest.corp.microsoft.com ([131.107.160.79])
        by smtp.gmail.com with ESMTPSA id z6-v6sm6178821pgr.41.2018.08.29.08.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 08:43:54 -0700 (PDT)
From:   mhkelley58@gmail.com
X-Google-Original-From: mikelley@microsoft.com
To:     will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        marcelo.cerri@canonical.com, sthemmin@microsoft.com,
        kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v2 3/4] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Date:   Wed, 29 Aug 2018 08:22:27 -0700
Message-Id: <1535556148-10452-4-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1535556148-10452-1-git-send-email-mikelley@microsoft.com>
References: <1535556148-10452-1-git-send-email-mikelley@microsoft.com>
Reply-To: mikelley@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

Add hooks to enable/disable a per-CPU IRQ for VMbus. These hooks
are in the architecture independent setup and shutdown paths for
Hyper-V, and are needed by Linux guests on Hyper-V on ARM64.  The
x86/x64 implementation is null because VMbus interrupts on x86/x64
don't use an IRQ.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: James Morris <jmorris@namei.org>
---
 arch/x86/include/asm/mshyperv.h | 4 ++++
 drivers/hv/hv.c                 | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f377044..44ba554 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -109,6 +109,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 void hv_setup_vmbus_irq(void (*handler)(void));
 void hv_remove_vmbus_irq(void);
 
+/* On x86/x64, there isn't a real IRQ to be enabled/disable */
+static inline void hv_enable_vmbus_irq(void) {}
+static inline void hv_disable_vmbus_irq(void) {}
+
 void hv_setup_kexec_handler(void (*handler)(void));
 void hv_remove_kexec_handler(void);
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 748a1c41..f8d1245 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -300,6 +300,7 @@ int hv_synic_init(unsigned int cpu)
 	hv_set_siefp(siefp.as_uint64);
 
 	/* Setup the shared SINT. */
+	hv_enable_vmbus_irq();
 	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	shared_sint.vector = HYPERVISOR_CALLBACK_VECTOR;
@@ -429,6 +430,7 @@ int hv_synic_cleanup(unsigned int cpu)
 	hv_get_synic_state(sctrl.as_uint64);
 	sctrl.enable = 0;
 	hv_set_synic_state(sctrl.as_uint64);
+	hv_disable_vmbus_irq();
 
 	return 0;
 }
-- 
1.8.3.1

