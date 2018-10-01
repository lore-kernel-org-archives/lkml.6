Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11588C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93192089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="hnDPHpV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93192089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJBAnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:43:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35749 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeJBAnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:43:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so9815035pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sOPjKLOAakk2ATxxw5XzVSyruYdNVeZzHr/Hs8pvlVw=;
        b=hnDPHpV7TRVLm1iFIa+huzuRU52EietdeZtd38RC4mD3lpJ1E56o+dY5ponRV1+tDH
         CjhttDPBZsCyq+6GWF2H90ZKfgbgPWC+ZMjwyEEzH3O+TCPxB7Lcydfv5iUrElcaletM
         smKvnJKirX6OAHOoFdP1mdtEnYigBtHyRVCRZ9TRTGSr3oNk5OxVocVvt80FxDzV7LGv
         QRCmAKg6r5sTNr+gnIQ1R0kAUHaIbqXzm2LO2SOxsPcZ/1swGJc0h/dlapt3mK+gUC7h
         a2MSWCS/jJSLAf4m+Xr0M75IXW4xtztUiAE4Z2ZLxF7VTaEYZHqN0hAqxSqmVHFNUm0Q
         lRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sOPjKLOAakk2ATxxw5XzVSyruYdNVeZzHr/Hs8pvlVw=;
        b=oX8/ofCccJhUkrbcsP0Gr6BZ1dar4UMMdht5KpYx6XVyGM08anEDFor4ieXRmJ3268
         jw+roCfZcistqtM849+I27IqsY6nl6/mTlPE0+Tb2MyoecTyllAAmMZmEpZOcwehRjpN
         AIU4o8MG5xhzrzPzO75r3AF1c6NIZm5jIh+UXQo6WwatWT5jeLUHIDdGleiqLWV1sSHw
         KaA41KPkdq3f/n+6zO0RE0iJwXxPidqfGpe/1QEpt1THdz4MAruYEKYpPITGND8Bxz3l
         Wfucb7GOc28H3szN2b+A4srjluV9bs/WKGFSTOvwoLzEn0Lve15r6j9qGtOv/1kGgR9o
         +UOQ==
X-Gm-Message-State: ABuFfojA3RwSrwVhmngdcQpfxgZFkUCT4Lzck3s0hPhmaDgWK7Aubjqe
        c4o/slcXi2rzTtsTF1P5qNSysL2VGgQ=
X-Google-Smtp-Source: ACcGV609gFtSB8A7iVi5SNuJhxzQZ+JwUX0XV2went9IB2rxXdILtfk8FBA6kCYRUlUeYkAeXK8A6A==
X-Received: by 2002:a63:1245:: with SMTP id 5-v6mr11167820pgs.299.1538417051064;
        Mon, 01 Oct 2018 11:04:11 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:04:10 -0700 (PDT)
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
Subject: RESEND [PATCH 3/6] arm64: Refactor vDSO init/setup
Date:   Mon,  1 Oct 2018 10:58:40 -0700
Message-Id: <20181001175845.168430-21-salyzyn@android.com>
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

Move the logic for setting up mappings and pages for the vDSO into
static functions. This makes the vDSO setup code more consistent with
the compat side and will allow to reuse it for the future compat vDSO.

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
 arch/arm64/kernel/vdso.c | 118 +++++++++++++++++++++++----------------
 1 file changed, 70 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 76a94bed4bd5..8529e85a521f 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -39,8 +39,11 @@
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
 
-extern char vdso_start[], vdso_end[];
-static unsigned long vdso_pages __ro_after_init;
+struct vdso_mappings {
+	unsigned long num_code_pages;
+	struct vm_special_mapping data_mapping;
+	struct vm_special_mapping code_mapping;
+};
 
 /*
  * The vDSO data page.
@@ -164,95 +167,114 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
-static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
-	{
-		.name	= "[vvar]",
-	},
-	{
-		.name	= "[vdso]",
-		.mremap = vdso_mremap,
-	},
-};
-
-static int __init vdso_init(void)
+static int __init vdso_mappings_init(const char *name,
+				     const char *code_start,
+				     const char *code_end,
+				     struct vdso_mappings *mappings)
 {
-	int i;
+	unsigned long i, vdso_page;
 	struct page **vdso_pagelist;
 	unsigned long pfn;
 
-	if (memcmp(vdso_start, "\177ELF", 4)) {
-		pr_err("vDSO is not a valid ELF object!\n");
+	if (memcmp(code_start, "\177ELF", 4)) {
+		pr_err("%s is not a valid ELF object!\n", name);
 		return -EINVAL;
 	}
 
-	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
-	pr_info("vdso: %ld pages (%ld code @ %p, %ld data @ %p)\n",
-		vdso_pages + 1, vdso_pages, vdso_start, 1L, vdso_data);
-
-	/* Allocate the vDSO pagelist, plus a page for the data. */
-	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
-				GFP_KERNEL);
+	vdso_pages = (code_end - code_start) >> PAGE_SHIFT;
+	pr_info("%s: %ld pages (%ld code @ %p, %ld data @ %p)\n",
+		name, vdso_pages + 1, vdso_pages, code_start, 1L,
+		vdso_data);
+
+	/*
+	 * Allocate space for storing pointers to the vDSO code pages + the
+	 * data page. The pointers must have the same lifetime as the mappings,
+	 * which are static, so there is no need to keep track of the pointer
+	 * array to free it.
+	 */
+	vdso_pagelist = kmalloc_array(vdso_pages + 1, sizeof(struct page *),
+				      GFP_KERNEL);
 	if (vdso_pagelist == NULL)
 		return -ENOMEM;
 
 	/* Grab the vDSO data page. */
 	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
 
-
 	/* Grab the vDSO code pages. */
-	pfn = sym_to_pfn(vdso_start);
+	pfn = sym_to_pfn(code_start);
 
 	for (i = 0; i < vdso_pages; i++)
 		vdso_pagelist[i + 1] = pfn_to_page(pfn + i);
 
-	vdso_spec[0].pages = &vdso_pagelist[0];
-	vdso_spec[1].pages = &vdso_pagelist[1];
+	/* Populate the special mapping structures */
+	mappings->data_mapping = (struct vm_special_mapping) {
+		.name	= "[vvar]",
+		.pages	= &vdso_pagelist[0],
+	};
+
+	mappings->code_mapping = (struct vm_special_mapping) {
+		.name	= "[vdso]",
+		.pages	= &vdso_pagelist[1],
+	};
 
+	mappings->num_code_pages = vdso_pages;
 	return 0;
 }
+
+static struct vdso_mappings vdso_mappings __ro_after_init;
+
+static int __init vdso_init(void)
+{
+	extern char vdso_start[], vdso_end[];
+
+	return vdso_mappings_init("vdso", vdso_start, vdso_end,
+				  &vdso_mappings);
+}
 arch_initcall(vdso_init);
 
-int arch_setup_additional_pages(struct linux_binprm *bprm,
-				int uses_interp)
+static int vdso_setup(struct mm_struct *mm,
+		      const struct vdso_mappings *mappings)
 {
-	struct mm_struct *mm = current->mm;
 	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
 	void *ret;
 
-	vdso_text_len = vdso_pages << PAGE_SHIFT;
+	vdso_text_len = mappings->num_code_pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
 	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
 
-	if (down_write_killable(&mm->mmap_sem))
-		return -EINTR;
 	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
-	if (IS_ERR_VALUE(vdso_base)) {
-		ret = ERR_PTR(vdso_base);
-		goto up_fail;
-	}
+	if (IS_ERR_VALUE(vdso_base))
+		ret = PTR_ERR_OR_ZERO(ERR_PTR(vdso_base));
+
 	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
 				       VM_READ|VM_MAYREAD,
-				       &vdso_spec[0]);
+				       &mappings->data_mapping);
 	if (IS_ERR(ret))
-		goto up_fail;
+		return PTR_ERR_OR_ZERO(ret);
 
 	vdso_base += PAGE_SIZE;
-	mm->context.vdso = (void *)vdso_base;
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|
 				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
-				       &vdso_spec[1]);
-	if (IS_ERR(ret))
-		goto up_fail;
+				       &mappings->code_mapping);
+	if (!IS_ERR(ret))
+		mm->context.vdso = (void *)vdso_base;
+
+	return PTR_ERR_OR_ZERO(ret);
+}
 
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+{
+	struct mm_struct *mm = current->mm;
+	int ret;
 
-	up_write(&mm->mmap_sem);
-	return 0;
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	ret = vdso_setup(mm, &vdso_mappings);
 
-up_fail:
-	mm->context.vdso = NULL;
 	up_write(&mm->mmap_sem);
-	return PTR_ERR(ret);
+	return ret;
 }
 
 /*
-- 
2.19.0.605.g01d371f741-goog

