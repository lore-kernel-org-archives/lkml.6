Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1EAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10EC25FEF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP4Nv9E/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10EC25FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964960AbeFYRzO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:55:14 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35157 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964841AbeFYRzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:55:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id c22-v6so6802600pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jTjKqLdRDB82ECu3mQSszSPSwzzkxmGseAQgiMc+WvI=;
        b=QP4Nv9E/f1dTI+f8040+yR+BxbfaWab2FoAfy0j2qMgEuBbzZsNlX3reDZMpcm6XiK
         qLaoH9OpHeRElvWehZzoQeSI0pU7j5wKXQl18zNloyzM+Bgw/X327Ms+W/+sOZt1pyiH
         gcuNVZwgS2fDXmukSE6SfIfXPJ104DBIZO19V9N+xWqg4cRCQIPhhNRws9Y0pwvTY7Xx
         bTc3q7KDZcfVgt313reSQr2mvA0G1wbXdMnaq4rXFoLv+RT/7OuVjmNea5X9/UUSAK/Z
         jKkUt+RLaoaKu+xlEsW+ICM5byrXmcZEpC13cC5w6P9LGEhyeZc5H8bxFxMowCUaiF6C
         hzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jTjKqLdRDB82ECu3mQSszSPSwzzkxmGseAQgiMc+WvI=;
        b=M47oN5cOxDm9H8wDFmpsotWCxE8aJYo9bYZm4Nn6B2BY30MuAJvj25dyGpxbzhBVpC
         ZPk1lcSrdA6kqHmltPiCwfl9UDv1qVXgaO4iUTibBonIEbLLvkoYfWL3SQRyTVmvw1GX
         M0zoLkVlHjpVewWvu0MegZT3W2KiC+xqhm1XTklRjPvMWFX9v+wneO6qHfwa9MlGT8g2
         ujrWcM/THJ4NSqFA7H74QWRrZwNQnivU1U+klWQqrRcJW6ZvEMbnWaVOPV2FSHHahE9T
         xsjrIJYKSK403uwJArm8BgB+F74ery+f5c+mx2oUy+fuzEQdIsUdzAV/Njox1fFhp4t/
         8/JA==
X-Gm-Message-State: APt69E2qfF0wVu9tFERA0+UzBN8KIEdqj7H9BtdbE28+OAB2c/OcrgnF
        +a0nCAGD4kTTru25o3SFyj4=
X-Google-Smtp-Source: ADUXVKKWnKtpYm2UNprkrzOHzUyrdrgMoYtMGnccM55zolpPd+aOF8j0L3cojbHRELG+QP2VfKtDKQ==
X-Received: by 2002:a62:9652:: with SMTP id c79-v6mr14153130pfe.114.1529949312327;
        Mon, 25 Jun 2018 10:55:12 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.217.204])
        by smtp.gmail.com with ESMTPSA id z12-v6sm18618708pgu.57.2018.06.25.10.55.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jun 2018 10:55:10 -0700 (PDT)
Date:   Mon, 25 Jun 2018 23:27:37 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, luto@amacapital.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com
Subject: [PATCH v2] x86/vdso: Change return type to vm_fault_t for fault
 handlers
Message-ID: <20180625175737.GA20042@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for both fault handler
vdso_fault() and vvar_fault(). Previously vm_insert_pfn()
returns err which has to mapped into VM_FAULT_* type.
The new function vmf_insert_pfn() will replace this
inefficiency by returning correct VM_FAULT_* type.

See the following commit:

  1c8f422059ae ("mm: change return type to vm_fault_t")
  b3ec9f33acb8 ("mm: change return type to vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---

v2: Updated the change log

 arch/x86/entry/vdso/vma.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 5b8b556..3679885 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -39,7 +39,7 @@ void __init init_vdso_image(const struct vdso_image *image)
 
 struct linux_binprm;
 
-static int vdso_fault(const struct vm_special_mapping *sm,
+static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	const struct vdso_image *image = vma->vm_mm->context.vdso_image;
@@ -84,15 +84,15 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
-static int vvar_fault(const struct vm_special_mapping *sm,
+static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	const struct vdso_image *image = vma->vm_mm->context.vdso_image;
 	long sym_offset;
-	int ret = -EFAULT;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
 
 	if (!image)
-		return VM_FAULT_SIGBUS;
+		return ret;
 
 	sym_offset = (long)(vmf->pgoff << PAGE_SHIFT) +
 		image->sym_vvar_start;
@@ -105,10 +105,10 @@ static int vvar_fault(const struct vm_special_mapping *sm,
 	 * the page past the end of the vvar mapping.
 	 */
 	if (sym_offset == 0)
-		return VM_FAULT_SIGBUS;
+		return ret;
 
 	if (sym_offset == image->sym_vvar_page) {
-		ret = vm_insert_pfn(vma, vmf->address,
+		ret = vmf_insert_pfn(vma, vmf->address,
 				    __pa_symbol(&__vvar_page) >> PAGE_SHIFT);
 	} else if (sym_offset == image->sym_pvclock_page) {
 		struct pvclock_vsyscall_time_info *pvti =
@@ -124,14 +124,11 @@ static int vvar_fault(const struct vm_special_mapping *sm,
 		struct ms_hyperv_tsc_page *tsc_pg = hv_get_tsc_page();
 
 		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
-			ret = vm_insert_pfn(vma, vmf->address,
+			ret = vmf_insert_pfn(vma, vmf->address,
 					    vmalloc_to_pfn(tsc_pg));
 	}
 
-	if (ret == 0 || ret == -EBUSY)
-		return VM_FAULT_NOPAGE;
-
-	return VM_FAULT_SIGBUS;
+	return ret;
 }
 
 static const struct vm_special_mapping vdso_mapping = {
-- 
1.9.1

