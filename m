Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371C2C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 10:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048E32082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 10:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048E32082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeKDTZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 14:25:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38821 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbeKDTZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 14:25:44 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA4AAhET4023259
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 4 Nov 2018 02:10:43 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA4AAcaA4023246;
        Sun, 4 Nov 2018 02:10:38 -0800
Date:   Sun, 4 Nov 2018 02:10:38 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Michael Kelley <tipbot@zytor.com>
Message-ID: <tip-1de72c706488b7be664a601cf3843bd01e327e58@git.kernel.org>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        olaf@aepfle.de, daniel.lezcano@linaro.org, apw@canonical.com,
        jgross@suse.com, mingo@kernel.org, mikelley@microsoft.com,
        hpa@zytor.com, vkuznets@redhat.com, tglx@linutronix.de,
        kys@microsoft.com, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, akataria@vmware.com,
        gregkh@linuxfoundation.org, marcelo.cerri@canonical.com
Reply-To: mingo@kernel.org, mikelley@microsoft.com, jgross@suse.com,
          daniel.lezcano@linaro.org, olaf@aepfle.de, apw@canonical.com,
          virtualization@lists.linux-foundation.org, jasowang@redhat.com,
          akataria@vmware.com, gregkh@linuxfoundation.org,
          devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
          marcelo.cerri@canonical.com, kys@microsoft.com,
          tglx@linutronix.de, hpa@zytor.com, vkuznets@redhat.com
In-Reply-To: <1541303219-11142-3-git-send-email-mikelley@microsoft.com>
References: <1541303219-11142-3-git-send-email-mikelley@microsoft.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/hyper-v: Enable PIT shutdown quirk
Git-Commit-ID: 1de72c706488b7be664a601cf3843bd01e327e58
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1de72c706488b7be664a601cf3843bd01e327e58
Gitweb:     https://git.kernel.org/tip/1de72c706488b7be664a601cf3843bd01e327e58
Author:     Michael Kelley <mikelley@microsoft.com>
AuthorDate: Sun, 4 Nov 2018 03:48:57 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 4 Nov 2018 11:04:46 +0100

x86/hyper-v: Enable PIT shutdown quirk

Hyper-V emulation of the PIT has a quirk such that the normal PIT shutdown
path doesn't work, because clearing the counter register restarts the
timer.

Disable the counter clearing on PIT shutdown.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "jgross@suse.com" <jgross@suse.com>
Cc: "akataria@vmware.com" <akataria@vmware.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>
Cc: "apw@canonical.com" <apw@canonical.com>
Cc: vkuznets <vkuznets@redhat.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Cc: KY Srinivasan <kys@microsoft.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1541303219-11142-3-git-send-email-mikelley@microsoft.com

---
 arch/x86/kernel/cpu/mshyperv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 1c72f3819eb1..e81a2db42df7 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kexec.h>
+#include <linux/i8253.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
@@ -295,6 +296,16 @@ static void __init ms_hyperv_init_platform(void)
 	if (efi_enabled(EFI_BOOT))
 		x86_platform.get_nmi_reason = hv_get_nmi_reason;
 
+	/*
+	 * Hyper-V VMs have a PIT emulation quirk such that zeroing the
+	 * counter register during PIT shutdown restarts the PIT. So it
+	 * continues to interrupt @18.2 HZ. Setting i8253_clear_counter
+	 * to false tells pit_shutdown() not to zero the counter so that
+	 * the PIT really is shutdown. Generation 2 VMs don't have a PIT,
+	 * and setting this value has no effect.
+	 */
+	i8253_clear_counter_on_shutdown = false;
+
 #if IS_ENABLED(CONFIG_HYPERV)
 	/*
 	 * Setup the hook to get control post apic initialization.
