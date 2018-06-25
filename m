Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD9BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBE025D6B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnibrHve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBE025D6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755740AbeFYPzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:55:40 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40574 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754943AbeFYPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:55:26 -0400
Received: by mail-pl0-f67.google.com with SMTP id t6-v6so1664171plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=d0weFdD2JSzhFesTgwoxX2LLvoyNJXhMj3XB5I+8GmQ=;
        b=ZnibrHvecUf5O+sLSHOaN48ndlqt5CbpkvCLO7Y1XyBz1dFJCbRxE8djUB3LzuYkJu
         XrzGkFQHmeJFuzUnSAazGp43nk6vQQqiL3XFQk0R6hhIvcrusMTwKnh9z56OEX3EoGGS
         0yttnpDlk/C/6fxmk1F9aYYube6/kxp9iRm2fiIOAPeCn/V7EoMZwE7giG/q7vAYACuK
         NDOS+ozXULIHNHs13DfEIkpiN9KLAdCk5JiuE/wL/h9iQG4ewopk31dz7Bd6NOVjeq9q
         l0JU7XGCwjhwbF55kmUSZpmxtHOVQdEtT5rR6OFq7Z1Rrl96U7/upoxZLt0+au6HvQ0u
         ll6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=d0weFdD2JSzhFesTgwoxX2LLvoyNJXhMj3XB5I+8GmQ=;
        b=PLPxDBNjrQ1GONTv0ZU9G6HOhnJyhrSZRRV+OA6NP3AaYmkHP/GoVK3sKhl7RmKobd
         0QGMLA7JIVcidPa7XPJn9vvnJEsO7r5okWQUTB/LJU0I2ATxJHykMJ7Nj+Yhm/16OZyp
         Fa+t/gQR8msN4AbHKTxwqvRMb4LfnGqtbTSl+93tAJ6Z+6HtpZ/WPsrgwhucJiKa/6bb
         qQ9tIE46RmbJiNM+hYYumDMj5X+yTEXJ+Haigf91l4lKWdYIGj1ELPPQs+qOH0THk5yt
         Lzg0F8Fjq3MmqbIkc4RaMjuXekrIpNRX2/uVlgt5Hs2h4hhNtDaYXLK7ykFEoqeBO2uu
         wKXw==
X-Gm-Message-State: APt69E3S5+Pp8SheAtW/GOOEAHb9du1V+nq1wCDarwsewWHdL4RZME3S
        +kM+e/paYxCF9WL2JJNHHw8=
X-Google-Smtp-Source: ADUXVKLHIb80+klBq7xcczaE91A7RZUzDocyapMqKITko6C4vr9q2PXlImJNuxn2HFFTfbJQRUqUGw==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4-v6mr1002459plo.100.1529942125495;
        Mon, 25 Jun 2018 08:55:25 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.217.204])
        by smtp.gmail.com with ESMTPSA id n68-v6sm26689008pfk.145.2018.06.25.08.55.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jun 2018 08:55:23 -0700 (PDT)
Date:   Mon, 25 Jun 2018 21:27:50 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, luto@amacapital.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com
Subject: [PATCH] x86/vdso: Change return type to vm_fault_t for fault handlers
Message-ID: <20180625155750.GA14306@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Previously vm_insert_pfn() returns err which has to
mapped into VM_FAULT_* type. The new function
vmf_insert_pfn() will replace this inefficiency by
returning VM_FAULT_* type.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
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

