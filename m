Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B46C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DEA20815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzLuZYPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfBDUdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:33:19 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:41087 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfBDUdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:33:16 -0500
Received: by mail-wr1-f49.google.com with SMTP id x10so1314627wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 12:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dun5wPJoK/rlKzvfmi38IsblWoixzya66CPHyuYiPKE=;
        b=GzLuZYPrAK+3HzzPTL0uBAo2C08FtkS+IfqSS5vCDNNkfHQAjAzjPJ5tPQ7kqcHpfg
         092UxKKDi4JLNgt/RtGRULC35mSKPJPBYz/1bfFQumrZcmkWDiwAi24bUlM7KMM18dWZ
         IFKmbcyrIzjgHMEyCD9vVfLhMFT17nbg54j0bE3xcRI4lItAJiG6IZwPEAyUPcaCTj28
         xGepzDFWxOZEkQTe5u6nfnClEmDeAtSjkXdi+VdjDZ6p5qcyamGWcP76pLGX2g08zaB9
         s/IBEHrEKR8ezEm+E+we9EFlcvkg/AK+rohVNF2+RG1BnYx9D9eMmQK3ZpEDgDb3abJ6
         4ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dun5wPJoK/rlKzvfmi38IsblWoixzya66CPHyuYiPKE=;
        b=QI9hD2FA6cCopyDJI3bOcz7DYsA7N9CWrxNZvUQRXWg8SPaSoIVUwaadWbNNRzQJyn
         fxSMQEH0zTlpITgl9tmK4up52YBlmP6UiSNjK+2QhFnA9NUA66TP2LvFvl0uNnnHXMAf
         BthxvqS9iOm4u/hf15YYqlDcvbVMbAZVHchb8WbAUaV9jv8e6Ur6Jb2suVwfJq/0P9Ik
         bRgCX0Mq6nhF4fOivuu6UpgNzizwK0BJ+nccoGNyT8TCwJcqTb6Ch9agLbwJSAH/7ZUh
         nUbSwkIkowDAXFzQwU3RTHEKA3kR7rdR987nA2gpvDhsdhzcLtXzlqvbF84a3PexLVvW
         +lsw==
X-Gm-Message-State: AHQUAub0ceFnaO4efQW4rS2hNXizCJUri43SR+GEbNiLJE4L1Hz7FUMU
        7hAxcZef+r6Mk2PbGS4L8pi4z2s=
X-Google-Smtp-Source: AHgI3IZPkl5kMWxsNLQACLVJpT3q0JqPgX0gKn10d28Dgsq7xxCRNXmsgj5Ty43zEEB/Ykqd1jFcIA==
X-Received: by 2002:adf:ba94:: with SMTP id p20mr910252wrg.62.1549312393488;
        Mon, 04 Feb 2019 12:33:13 -0800 (PST)
Received: from avx2 ([46.53.245.13])
        by smtp.gmail.com with ESMTPSA id w11sm5119389wrt.5.2019.02.04.12.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:33:12 -0800 (PST)
Date:   Mon, 4 Feb 2019 23:33:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] elf: save allocation per exec
Message-ID: <20190204203310.GD27482@avx2>
References: <20190204202715.GA27482@avx2>
 <20190204202800.GB27482@avx2>
 <20190204202830.GC27482@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190204202830.GC27482@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 ELF header aren't that large to allocate them on heap.

However, code is bloated by 1.5 KB (!!!) with gcc 8.2 and stack size
grows by ~340 bytes.

The problem is that 2 elf headers are only 128 bytes.

I'm shocked and the patch should not be applied probably.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   78 ++++++++++++++++++++++++--------------------------------
 1 file changed, 34 insertions(+), 44 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -699,37 +699,29 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long reloc_func_desc __maybe_unused = 0;
 	int executable_stack = EXSTACK_DEFAULT;
 	struct pt_regs *regs = current_pt_regs();
-	struct {
-		struct elfhdr elf_ex;
-		struct elfhdr interp_elf_ex;
-	} *loc;
+	struct elfhdr elf_ex;
+	struct elfhdr interp_elf_ex;
 	struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
 	loff_t pos;
 
-	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
-	if (!loc) {
-		retval = -ENOMEM;
-		goto out_ret;
-	}
-	
 	/* Get the exec-header */
-	loc->elf_ex = *((struct elfhdr *)bprm->buf);
+	elf_ex = *(struct elfhdr *)bprm->buf;
 
 	retval = -ENOEXEC;
 	/* First of all, some simple consistency checks */
-	if (memcmp(loc->elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
+	if (memcmp(elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
 		goto out;
 
-	if (loc->elf_ex.e_type != ET_EXEC && loc->elf_ex.e_type != ET_DYN)
+	if (elf_ex.e_type != ET_EXEC && elf_ex.e_type != ET_DYN)
 		goto out;
-	if (!elf_check_arch(&loc->elf_ex))
+	if (!elf_check_arch(&elf_ex))
 		goto out;
-	if (elf_check_fdpic(&loc->elf_ex))
+	if (elf_check_fdpic(&elf_ex))
 		goto out;
 	if (!bprm->file->f_op->mmap)
 		goto out;
 
-	elf_phdata = load_elf_phdrs(&loc->elf_ex, bprm->file);
+	elf_phdata = load_elf_phdrs(&elf_ex, bprm->file);
 	if (!elf_phdata)
 		goto out;
 
@@ -742,7 +734,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	start_data = 0;
 	end_data = 0;
 
-	for (i = 0; i < loc->elf_ex.e_phnum; i++) {
+	for (i = 0; i < elf_ex.e_phnum; i++) {
 		if (elf_ppnt->p_type == PT_INTERP) {
 			/* This is the program interpreter used for
 			 * shared libraries - for now assume that this
@@ -786,9 +778,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 			/* Get the exec headers */
 			pos = 0;
-			retval = kernel_read(interpreter, &loc->interp_elf_ex,
-					     sizeof(loc->interp_elf_ex), &pos);
-			if (retval != sizeof(loc->interp_elf_ex)) {
+			retval = kernel_read(interpreter, &interp_elf_ex,
+					     sizeof(interp_elf_ex), &pos);
+			if (retval != sizeof(interp_elf_ex)) {
 				if (retval >= 0)
 					retval = -EIO;
 				goto out_free_dentry;
@@ -800,7 +792,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	}
 
 	elf_ppnt = elf_phdata;
-	for (i = 0; i < loc->elf_ex.e_phnum; i++, elf_ppnt++)
+	for (i = 0; i < elf_ex.e_phnum; i++, elf_ppnt++)
 		switch (elf_ppnt->p_type) {
 		case PT_GNU_STACK:
 			if (elf_ppnt->p_flags & PF_X)
@@ -810,7 +802,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			break;
 
 		case PT_LOPROC ... PT_HIPROC:
-			retval = arch_elf_pt_proc(&loc->elf_ex, elf_ppnt,
+			retval = arch_elf_pt_proc(&elf_ex, elf_ppnt,
 						  bprm->file, false,
 						  &arch_state);
 			if (retval)
@@ -822,25 +814,25 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (elf_interpreter) {
 		retval = -ELIBBAD;
 		/* Not an ELF interpreter */
-		if (memcmp(loc->interp_elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
+		if (memcmp(interp_elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
 			goto out_free_dentry;
 		/* Verify the interpreter has a valid arch */
-		if (!elf_check_arch(&loc->interp_elf_ex) ||
-		    elf_check_fdpic(&loc->interp_elf_ex))
+		if (!elf_check_arch(&interp_elf_ex) ||
+		    elf_check_fdpic(&interp_elf_ex))
 			goto out_free_dentry;
 
 		/* Load the interpreter program headers */
-		interp_elf_phdata = load_elf_phdrs(&loc->interp_elf_ex,
+		interp_elf_phdata = load_elf_phdrs(&interp_elf_ex,
 						   interpreter);
 		if (!interp_elf_phdata)
 			goto out_free_dentry;
 
 		/* Pass PT_LOPROC..PT_HIPROC headers to arch code */
 		elf_ppnt = interp_elf_phdata;
-		for (i = 0; i < loc->interp_elf_ex.e_phnum; i++, elf_ppnt++)
+		for (i = 0; i < interp_elf_ex.e_phnum; i++, elf_ppnt++)
 			switch (elf_ppnt->p_type) {
 			case PT_LOPROC ... PT_HIPROC:
-				retval = arch_elf_pt_proc(&loc->interp_elf_ex,
+				retval = arch_elf_pt_proc(&interp_elf_ex,
 							  elf_ppnt, interpreter,
 							  true, &arch_state);
 				if (retval)
@@ -854,8 +846,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	 * still possible to return an error to the code that invoked
 	 * the exec syscall.
 	 */
-	retval = arch_check_elf(&loc->elf_ex,
-				!!interpreter, &loc->interp_elf_ex,
+	retval = arch_check_elf(&elf_ex,
+				!!interpreter, &interp_elf_ex,
 				&arch_state);
 	if (retval)
 		goto out_free_dentry;
@@ -867,8 +859,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
 	   may depend on the personality.  */
-	SET_PERSONALITY2(loc->elf_ex, &arch_state);
-	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
+	SET_PERSONALITY2(elf_ex, &arch_state);
+	if (elf_read_implies_exec(elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
 	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
@@ -889,7 +881,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	/* Now we do a little grungy work by mmapping the ELF image into
 	   the correct location in memory. */
 	for(i = 0, elf_ppnt = elf_phdata;
-	    i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
+	    i < elf_ex.e_phnum; i++, elf_ppnt++) {
 		int elf_prot = 0, elf_flags, elf_fixed = MAP_FIXED_NOREPLACE;
 		unsigned long k, vaddr;
 		unsigned long total_size = 0;
@@ -945,9 +937,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		 * If we are loading ET_EXEC or we have already performed
 		 * the ET_DYN load_addr calculations, proceed normally.
 		 */
-		if (loc->elf_ex.e_type == ET_EXEC || load_addr_set) {
+		if (elf_ex.e_type == ET_EXEC || load_addr_set) {
 			elf_flags |= elf_fixed;
-		} else if (loc->elf_ex.e_type == ET_DYN) {
+		} else if (elf_ex.e_type == ET_DYN) {
 			/*
 			 * This logic is run once for the first LOAD Program
 			 * Header for ET_DYN binaries to calculate the
@@ -996,7 +988,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			load_bias = ELF_PAGESTART(load_bias - vaddr);
 
 			total_size = total_mapping_size(elf_phdata,
-							loc->elf_ex.e_phnum);
+							elf_ex.e_phnum);
 			if (!total_size) {
 				retval = -EINVAL;
 				goto out_free_dentry;
@@ -1014,7 +1006,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (!load_addr_set) {
 			load_addr_set = 1;
 			load_addr = (elf_ppnt->p_vaddr - elf_ppnt->p_offset);
-			if (loc->elf_ex.e_type == ET_DYN) {
+			if (elf_ex.e_type == ET_DYN) {
 				load_bias += error -
 				             ELF_PAGESTART(load_bias + vaddr);
 				load_addr += load_bias;
@@ -1055,7 +1047,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 	}
 
-	loc->elf_ex.e_entry += load_bias;
+	elf_ex.e_entry += load_bias;
 	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
@@ -1079,7 +1071,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (elf_interpreter) {
 		unsigned long interp_map_addr = 0;
 
-		elf_entry = load_elf_interp(&loc->interp_elf_ex,
+		elf_entry = load_elf_interp(&interp_elf_ex,
 					    interpreter,
 					    &interp_map_addr,
 					    load_bias, interp_elf_phdata);
@@ -1089,7 +1081,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * adjustment
 			 */
 			interp_load_addr = elf_entry;
-			elf_entry += loc->interp_elf_ex.e_entry;
+			elf_entry += interp_elf_ex.e_entry;
 		}
 		if (BAD_ADDR(elf_entry)) {
 			retval = IS_ERR((void *)elf_entry) ?
@@ -1102,7 +1094,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		fput(interpreter);
 		kfree(elf_interpreter);
 	} else {
-		elf_entry = loc->elf_ex.e_entry;
+		elf_entry = elf_ex.e_entry;
 		if (BAD_ADDR(elf_entry)) {
 			retval = -EINVAL;
 			goto out_free_dentry;
@@ -1120,7 +1112,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out;
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
 
-	retval = create_elf_tables(bprm, &loc->elf_ex,
+	retval = create_elf_tables(bprm, &elf_ex,
 			  load_addr, interp_load_addr);
 	if (retval < 0)
 		goto out;
@@ -1166,8 +1158,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	start_thread(regs, elf_entry, bprm->p);
 	retval = 0;
 out:
-	kfree(loc);
-out_ret:
 	return retval;
 
 	/* error cleanup */
