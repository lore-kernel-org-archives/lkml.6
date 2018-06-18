Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC61C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D338208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="EHsBfzvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D338208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935880AbeFRPKr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:10:47 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34707 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935444AbeFRPKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:10:21 -0400
Received: by mail-pl0-f65.google.com with SMTP id g20-v6so9207174plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2pfESoiXW7kZE4xChCGGKPZSQMnBX5sI3eDemQAvvzk=;
        b=EHsBfzvL8GWOY24pk8dwcVmsQX2cOQ0pKwpoxENUIb++3Ak+5K7M2P9wT3WE8RLgrh
         YLmDCFUWV+dJSQillLfx/BlCDG8Ut250QNQEXyQ8hsXfVefFraX44rgAwco9OvUMKIlF
         1apURrqENPQRF9vCL6ezGMfBoG2MfOQrx2QuhKIIzokNvMzYkQTunfK7t2wDs463ND2/
         mKQyaodXlYp+E1t8PUQgFGYwa29m/EU9g3SDmGzic1u7TuMkpHqidK6ZFgIT/D1CUUH7
         nAXfLnjzGOAAF7ykD4wlhJ9ZQyBTKbp4RB4ee7R0LxUDJqR333ZjZmxCnQUnP7h3uLiy
         q97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2pfESoiXW7kZE4xChCGGKPZSQMnBX5sI3eDemQAvvzk=;
        b=esMtQyngpeo+G8K9k+of1LU7siHueaO9hTinGOGVYrtkunxOpmA/RaCXYmK/tmzDAJ
         HAvbDcqNcjDg6pEtVtk+l28MNe9CZnnDDL3nv1PVA3UVoVJpEAifhy4JHXHMvFcXhnZB
         57rZQbgsPk954ePV0ruwrx15pNlew9aSii1L3oG53oAI93hrPXydelWg9wZBTrcxcBUX
         A0m0LySy73wJPkrJk5Fw68AwWCi5Za3X70yjXthn6WJhqnrX0lzqOLTNyawAph1Mi/kl
         E0PcSC+nkHlVsX9iP5HU65mHVTJZ+I7X1/c0ZZL0S6cBOK6Qo5rciIdt9d2pTAbhywI2
         Hx9w==
X-Gm-Message-State: APt69E1CSBfyC34BRLRueg7xyyLO90odb1lbBx4Xokaapzal22cNnUeO
        SNlQR3ZUCcCogjNLxkWKVynRq0uoCyI=
X-Google-Smtp-Source: ADUXVKJHY0ybKm9xMrCU22gORgxP/w9WdqNmWtVqvQUESgTcsUYd136P0K6z0lNXx0xAv4sktLcGcQ==
X-Received: by 2002:a17:902:7105:: with SMTP id a5-v6mr14448095pll.171.1529334620971;
        Mon, 18 Jun 2018 08:10:20 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:10:20 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kevin Brodsky <kevin.brodsky@arm.com>,
        Mark Salyzyn <salyzyn@android.com>,
        James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <Jeremy.Linton@arm.com>
Subject: RESEND [PATCH 5/6] arm64: compat: 32-bit vDSO setup
Date:   Mon, 18 Jun 2018 08:06:08 -0700
Message-Id: <20180618150613.10322-23-salyzyn@android.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618150613.10322-1-salyzyn@android.com>
References: <20180618150613.10322-1-salyzyn@android.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

If the compat vDSO is enabled, install it in compat processes. In this
case, the compat vDSO replaces the sigreturn page (it provides its own
sigreturn trampolines).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
---
 arch/arm64/kernel/vdso.c | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 8529e85a521f..9fb1e0d380ab 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -58,6 +58,7 @@ struct vdso_data *vdso_data = &vdso_data_store.data;
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
+#if !defined(CONFIG_VDSO32) || defined(CONFIG_KUSER_HELPERS)
 static struct page *vectors_page[] __ro_after_init;
 static const struct vm_special_mapping compat_vdso_spec[] = {
 	{
@@ -73,6 +74,7 @@ static const struct vm_special_mapping compat_vdso_spec[] = {
 #endif
 };
 static struct page *vectors_page[ARRAY_SIZE(compat_vdso_spec)] __ro_after_init;
+#endif
 
 static int __init alloc_vectors_page(void)
 {
@@ -82,6 +84,7 @@ static int __init alloc_vectors_page(void)
 	unsigned long kuser_vpage;
 #endif
 
+#ifndef CONFIG_VDSO32
 	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
 	size_t sigret_sz =
 		__aarch32_sigret_code_end - __aarch32_sigret_code_start;
@@ -90,19 +93,24 @@ static int __init alloc_vectors_page(void)
 	sigret_vpage = get_zeroed_page(GFP_ATOMIC);
 	if (!sigret_vpage)
 		return -ENOMEM;
+#endif
 
 #ifdef CONFIG_KUSER_HELPERS
 	kuser_vpage = get_zeroed_page(GFP_ATOMIC);
 	if (!kuser_vpage) {
+#ifndef CONFIG_VDSO32
 		free_page(sigret_vpage);
+#endif
 		return -ENOMEM;
 	}
 #endif
 
+#ifndef CONFIG_VDSO32
 	/* sigreturn code */
 	memcpy((void *)sigret_vpage, __aarch32_sigret_code_start, sigret_sz);
 	flush_icache_range(sigret_vpage, sigret_vpage + PAGE_SIZE);
 	vectors_page[0] = virt_to_page(sigret_vpage);
+#endif
 
 #ifdef CONFIG_KUSER_HELPERS
 	/* kuser helpers */
@@ -116,6 +124,7 @@ static int __init alloc_vectors_page(void)
 }
 arch_initcall(alloc_vectors_page);
 
+#ifndef CONFIG_VDSO32
 int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
@@ -151,6 +160,7 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 
 	return PTR_ERR_OR_ZERO(ret);
 }
+#endif /* !CONFIG_VDSO32 */
 #endif /* CONFIG_COMPAT */
 
 static int vdso_mremap(const struct vm_special_mapping *sm,
@@ -221,6 +231,23 @@ static int __init vdso_mappings_init(const char *name,
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
+#ifdef CONFIG_VDSO32
+
+static struct vdso_mappings vdso32_mappings __ro_after_init;
+
+static int __init vdso32_init(void)
+{
+	extern char vdso32_start[], vdso32_end[];
+
+	return vdso_mappings_init("vdso32", vdso32_start, vdso32_end,
+				  &vdso32_mappings);
+}
+arch_initcall(vdso32_init);
+
+#endif /* CONFIG_VDSO32 */
+#endif /* CONFIG_COMPAT */
+
 static struct vdso_mappings vdso_mappings __ro_after_init;
 
 static int __init vdso_init(void)
@@ -263,6 +290,34 @@ static int vdso_setup(struct mm_struct *mm,
 	return PTR_ERR_OR_ZERO(ret);
 }
 
+#ifdef CONFIG_COMPAT
+#ifdef CONFIG_VDSO32
+int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
+{
+	struct mm_struct *mm = current->mm;
+	void *ret;
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	ret = ERR_PTR(vdso_setup(mm, &vdso32_mappings));
+#ifdef CONFIG_KUSER_HELPERS
+	if (!IS_ERR(ret))
+		/* Map the kuser helpers at the ABI-defined high address. */
+		ret = _install_special_mapping(mm, AARCH32_KUSER_HELPERS_BASE,
+					       PAGE_SIZE,
+					       VM_READ|VM_EXEC|
+					       VM_MAYREAD|VM_MAYEXEC,
+					       &compat_vdso_spec[1]);
+#endif
+
+	up_write(&mm->mmap_sem);
+
+	return PTR_ERR_OR_ZERO(ret);
+}
+#endif /* CONFIG_VDSO32 */
+#endif /* CONFIG_COMPAT */
+
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
-- 
2.18.0.rc1.244.gcf134e6275-goog

