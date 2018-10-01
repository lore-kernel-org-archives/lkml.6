Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67130C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229F3208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="qJBcg+SM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229F3208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeJBAnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:43:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44816 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeJBAnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:43:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so9778908pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WWliIodzBkjg/YvVrM0vD1BBjyk86A4iDE2GhInXr68=;
        b=qJBcg+SMf0bBhav/XKsrHsnUEr8fqNOqIyTleeRJtIIeO2LHHW8liGZ6Bj0zbZ26kz
         JTWQ0VFWqLKU/uKRX3GxAB9hyGw7JLltnKBNLfYIhiAH5SnMJZDNcfLR09K7UfIvA6S+
         Cpv3C6FCTDUrK1ZT89uK5g6IbB4XDo9117ERAoGZLKOhCx9klEvMP24zdatyH1syLZLx
         TAq2H759J2P0+lB/+rP1F8BNZiIWkOqkuVydkFbmxAFVVRZOl9dQGHuAyo7E4o7XdavS
         MLH39vo6cv0njDhtp9JPBRURhEGywmjGDft+L6aaQcNoRc5Jcq2BiOs/SylpKnsoTN4t
         eQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWliIodzBkjg/YvVrM0vD1BBjyk86A4iDE2GhInXr68=;
        b=t7i0RgaeItd1B5eTnO7Tzk9z1+ecpUwY25aCFzTLk9oP8vLCvGynO9r4GH4bUBN35R
         HVHFbDvO18aP15cK+ZEREiVKbEJO/dR194QNE2/x5BtxITky3lXXBWt8RoeiWwb67ed0
         PkHco0svnb7aIQ0cEGKLLQBkkiEhaw3naU+WCWzw6scHfHsYuYt50ypnnv08OnfnVmaI
         QoXNAsrMU/14dXsMS4ybOq8NLtEVo2Q/pQLoH+4FF+ytpp6qNBzSyxBWnAJdfkjRlNsR
         IIQmobxpUDAkEEkD2POJICraDldkLPd0CED9QxakPj/Bv13dYG4ztN18NuKu1LvHQg0P
         WitQ==
X-Gm-Message-State: ABuFfojcTPqeH5AWDn8E7mJDxIQNn2PDPcqc37RRYnOLgVrLJHf5dLOM
        CxwmPdsQiHu+4C7q0ztUWGVIpiqchws=
X-Google-Smtp-Source: ACcGV63OkG+zVeZll+/FlhgOeIhhQ9b8adrsZya5tFZZK7RuefGpR8JqafmQuzi2hn+9i9qViwmh0w==
X-Received: by 2002:a63:8c0b:: with SMTP id m11-v6mr11187164pgd.372.1538417092395;
        Mon, 01 Oct 2018 11:04:52 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:04:51 -0700 (PDT)
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
        Jeremy Linton <Jeremy.Linton@arm.com>,
        android-kernel@android.com
Subject: RESEND [PATCH 5/6] arm64: compat: 32-bit vDSO setup
Date:   Mon,  1 Oct 2018 10:58:42 -0700
Message-Id: <20181001175845.168430-23-salyzyn@android.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Tested-by: Mark Salyzyn <salyzyn@android.com>
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
Cc: android-kernel@android.com
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
2.19.0.605.g01d371f741-goog

