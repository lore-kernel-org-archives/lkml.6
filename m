Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D3FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5946B206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfBOPB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:01:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34803 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfBOPB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:01:56 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1FF1Di01223712
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 07:01:13 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1FF1Cl71223706;
        Fri, 15 Feb 2019 07:01:12 -0800
Date:   Fri, 15 Feb 2019 07:01:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hedi Berriche <tipbot@zytor.com>
Message-ID: <tip-f331e766c4be33f4338574f3c9f7f77e98ab4571@git.kernel.org>
Cc:     bhsharma@redhat.com, dvhart@infradead.org, tglx@linutronix.de,
        hpa@zytor.com, steve.wahl@hpe.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, sivanich@hpe.com, ard.biesheuvel@linaro.org,
        linux-efi@vger.kernel.org, mingo@kernel.org, hedi.berriche@hpe.com,
        mingo@redhat.com, mike.travis@hpe.com, bp@suse.de, rja@hpe.com,
        andy@infradead.org
Reply-To: bhsharma@redhat.com, dvhart@infradead.org, tglx@linutronix.de,
          hpa@zytor.com, steve.wahl@hpe.com, linux-kernel@vger.kernel.org,
          x86@kernel.org, sivanich@hpe.com, ard.biesheuvel@linaro.org,
          linux-efi@vger.kernel.org, mingo@kernel.org,
          hedi.berriche@hpe.com, mingo@redhat.com, mike.travis@hpe.com,
          bp@suse.de, rja@hpe.com, andy@infradead.org
In-Reply-To: <20190213193413.25560-5-hedi.berriche@hpe.com>
References: <20190213193413.25560-5-hedi.berriche@hpe.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/platform/UV: Use efi_runtime_lock to serialise
 BIOS calls
Git-Commit-ID: f331e766c4be33f4338574f3c9f7f77e98ab4571
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

Commit-ID:  f331e766c4be33f4338574f3c9f7f77e98ab4571
Gitweb:     https://git.kernel.org/tip/f331e766c4be33f4338574f3c9f7f77e98ab4571
Author:     Hedi Berriche <hedi.berriche@hpe.com>
AuthorDate: Wed, 13 Feb 2019 19:34:13 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 15 Feb 2019 15:19:56 +0100

x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls

Calls into UV firmware must be protected against concurrency, expose the
efi_runtime_lock to the UV platform, and use it to serialise UV BIOS
calls.

Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Russ Anderson <rja@hpe.com>
Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
Reviewed-by: Mike Travis <mike.travis@hpe.com>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-efi <linux-efi@vger.kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: stable@vger.kernel.org # v4.9+
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190213193413.25560-5-hedi.berriche@hpe.com
---
 arch/x86/include/asm/uv/bios.h          |  8 +++++++-
 arch/x86/platform/uv/bios_uv.c          | 23 +++++++++++++++++++++--
 drivers/firmware/efi/runtime-wrappers.c |  7 +++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index e652a7cc6186..3f697a9e3f59 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -48,7 +48,8 @@ enum {
 	BIOS_STATUS_SUCCESS		=  0,
 	BIOS_STATUS_UNIMPLEMENTED	= -ENOSYS,
 	BIOS_STATUS_EINVAL		= -EINVAL,
-	BIOS_STATUS_UNAVAIL		= -EBUSY
+	BIOS_STATUS_UNAVAIL		= -EBUSY,
+	BIOS_STATUS_ABORT		= -EINTR,
 };
 
 /* Address map parameters */
@@ -167,4 +168,9 @@ extern long system_serial_number;
 
 extern struct kobject *sgi_uv_kobj;	/* /sys/firmware/sgi_uv */
 
+/*
+ * EFI runtime lock; cf. firmware/efi/runtime-wrappers.c for details
+ */
+extern struct semaphore __efi_uv_runtime_lock;
+
 #endif /* _ASM_X86_UV_BIOS_H */
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 4a6a5a26c582..eb33432f2f24 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -29,7 +29,8 @@
 
 struct uv_systab *uv_systab;
 
-s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
+static s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
+			u64 a4, u64 a5)
 {
 	struct uv_systab *tab = uv_systab;
 	s64 ret;
@@ -51,6 +52,19 @@ s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
 
 	return ret;
 }
+
+s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
+{
+	s64 ret;
+
+	if (down_interruptible(&__efi_uv_runtime_lock))
+		return BIOS_STATUS_ABORT;
+
+	ret = __uv_bios_call(which, a1, a2, a3, a4, a5);
+	up(&__efi_uv_runtime_lock);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(uv_bios_call);
 
 s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
@@ -59,10 +73,15 @@ s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 	unsigned long bios_flags;
 	s64 ret;
 
+	if (down_interruptible(&__efi_uv_runtime_lock))
+		return BIOS_STATUS_ABORT;
+
 	local_irq_save(bios_flags);
-	ret = uv_bios_call(which, a1, a2, a3, a4, a5);
+	ret = __uv_bios_call(which, a1, a2, a3, a4, a5);
 	local_irq_restore(bios_flags);
 
+	up(&__efi_uv_runtime_lock);
+
 	return ret;
 }
 
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 8903b9ccfc2b..e2abfdb5cee6 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -146,6 +146,13 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
  */
 static DEFINE_SEMAPHORE(efi_runtime_lock);
 
+/*
+ * Expose the EFI runtime lock to the UV platform
+ */
+#ifdef CONFIG_X86_UV
+extern struct semaphore __efi_uv_runtime_lock __alias(efi_runtime_lock);
+#endif
+
 /*
  * Calls the appropriate efi_runtime_service() with the appropriate
  * arguments.
