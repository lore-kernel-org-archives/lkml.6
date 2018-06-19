Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EF7C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C94E20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnoDKvAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C94E20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757460AbeFSVZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:25:50 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46964 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757412AbeFSVZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:25:22 -0400
Received: by mail-pg0-f65.google.com with SMTP id d2-v6so433207pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=lywYxy9doLfOj6cd2i2Rkt7MeIi678q9zfPQMjIfrVA=;
        b=fnoDKvASTV1hcLOTjv4jSrdGRYuZIimiBTEMeWrdZvuzja7AYVhm9BIJ1yin5e3B+l
         v3w29PyqEZkyZP9XtqyyjNaroGNjvnCMQGclOWqgZ4ly7CUdTQnGPfl1iJhBN0bWLPHS
         EEuLGI8dWDiBVx2XlgIuXusAMwtZfmhOXqeXpPiVnIlQVLs+MS2YzbvXPIU9QT9xqCb3
         p25NLbg93pty3TmH1dKS5ZoGKSh07XbDnS3wJiXTXHXz4uttXKS2rVSK0gd9bVJ80WtI
         J0s3utbbIlVl2hUaf5i2ldXvo04po6kio74ySq3PXIW1xz9jB9vMgk0LrHYsBrgrHGfv
         ObAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=lywYxy9doLfOj6cd2i2Rkt7MeIi678q9zfPQMjIfrVA=;
        b=YKd3NXSGZcceh91ugxYOT9PGwS2GTN4AteurLfVrXEKcGQiqosP6qryTYN/qDsagEI
         mRzXrsYT/LF59+D9M42QSVqQHHrIeu7WayXDGuc4sw4YcEGcIwOzRmS2s6mjYQ1GMtMm
         42QQZyL6XnXjHlm+gOd9JaUI2pUX+KGapke4CvjtfZY0GoxX8BiqeMMUnquwOprvlBSr
         d4sxIX35ZP9qKDGjmF+xVu3lJTJxr3EFYtZxRpIEeFESB11W48h2ZR5W/rr/nwHcg4I9
         LX8YYGuXW5X8jeK/RZcPfZW1YP1NlfLbEg3rDV0q/ypzOsuDZQgHHRkfE+YqChHD3nFO
         KqYg==
X-Gm-Message-State: APt69E0WKox+aiwgHfgXG0LE88u74eATkIXLHl2vDs48HiZ6Lc+p0lyf
        cKdM7UJxMWB2274huWK/1rw=
X-Google-Smtp-Source: ADUXVKKQB3QbqumT4YiZYLLveN3+73bOzKzh47wGNsBSWRAkGCImtt0TnKzClErI9dLihD4tBWn0sg==
X-Received: by 2002:a62:1146:: with SMTP id z67-v6mr19659832pfi.135.1529443521354;
        Tue, 19 Jun 2018 14:25:21 -0700 (PDT)
Received: from mhkkerneltest.corp.microsoft.com ([131.107.160.79])
        by smtp.gmail.com with ESMTPSA id t23-v6sm846203pfa.86.2018.06.19.14.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:25:20 -0700 (PDT)
From:   Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mikelley@microsoft.com>
To:     will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        leann.ogasawara@canonical.com, marcelo.cerri@canonical.com,
        sthemmin@microsoft.com, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH 4/5] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Date:   Tue, 19 Jun 2018 14:23:14 -0700
Message-Id: <1529443395-20874-5-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
References: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
Reply-To: mikelley@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hooks to enable/disable a per-CPU IRQ for VMbus. These hooks
are in the architecture independent setup and shutdown paths for
Hyper-V, and are needed by Linux guests on Hyper-V on ARM64.  The
x86/x64 implementation is null because VMbus interrupts on x86/x64
don't use an IRQ.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 4 ++++
 drivers/hv/hv.c                 | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 3cd1431..27d0e83 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -101,6 +101,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
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
index 658dc76..15f835a 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -298,6 +298,7 @@ int hv_synic_init(unsigned int cpu)
 	hv_set_siefp(siefp.as_uint64);
 
 	/* Setup the shared SINT. */
+	hv_enable_vmbus_irq();
 	hv_get_synint_state(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT,
 			    shared_sint.as_uint64);
 
@@ -431,6 +432,7 @@ int hv_synic_cleanup(unsigned int cpu)
 	hv_get_synic_state(sctrl.as_uint64);
 	sctrl.enable = 0;
 	hv_set_synic_state(sctrl.as_uint64);
+	hv_disable_vmbus_irq();
 
 	return 0;
 }
-- 
1.8.3.1

