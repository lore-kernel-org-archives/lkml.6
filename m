Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C18EC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FE520833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="2OfgrUez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FE520833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbeGZBNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:13:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42326 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbeGZBNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:13:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so6308047pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Fn7b5BcXHji/BjrZDgAToax3z3FLWmW1Mh6h9L8PD8=;
        b=2OfgrUeznMrsC3nZLE4vW7u5YYh5mmNxAs4W1nYpOPB5DUHXTaCPbarq0tzRQ6pdjo
         1ZOtQ83s5zFXZA0eB3RmMuIXylHDUlbmYzkEPBLsudPDRVTMA1c5oxink+2EhRs43yaD
         BRw2DS0rHYQoKTzbNYR3dnHmBlBMPV3laKdp40PWB/9v+2PPrEUciRcQ7utddfuhojHq
         SLpFVtOCooB22Bbob2fdD47LpaECWgt4pV37KvE1XPsSsHaUgonRW98pH23R8e13je/Y
         /NUre+JMUCIzuJBfqpPKtqP+YuOr9DEZVtIh9z1x+IXroVcRw2vESkbf7brgihKQyTwF
         /MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Fn7b5BcXHji/BjrZDgAToax3z3FLWmW1Mh6h9L8PD8=;
        b=DT0dyMkcmh8j2VnmzK7Emzod3PFXQvHXzCw7KFwgDwwD4Ga1jvHLjAhFfK8eLtwbjc
         W2k1XNJ8AfQhCuZ+mfKj6dF5AcBsUYlxUiMNq8YqvPNcuD54GnfBrSaT5tPNrvTAjmRo
         ksqww3z0a8NVc01S1i+pEN7QyuP9Wu5urD9+vrHbSe7ynCaTBjf2Gw1dMsLLca/lYHMK
         loRfXT9/l0rh8GSqoB+e8htJSJwKeNMm0so3S9gVF/mLM9Ye7b7/i/3KfKC+EbzgXcay
         ogcTNLaVd4B+tl3mnbGVUWJ2w3Bn11GT22dp94+lhjALJN8rURWVpbOk5n819rqF4tpZ
         1m/A==
X-Gm-Message-State: AOUpUlEw9WL03Qyjn5fKbgXJVbcWT5DcJYaObym3JucENNBIkccnKFu2
        6gj8nm/hMgqihB6Bchysy4B59XNZoBE=
X-Google-Smtp-Source: AAOMgpeNSUjIB270/O0/LQLK576zZFlDXb//ddkAy7elqDP+JlJPs17ycpj40ZTnBPBc9LhXNh4tdg==
X-Received: by 2002:a63:9741:: with SMTP id d1-v6mr21770519pgo.403.1532563174589;
        Wed, 25 Jul 2018 16:59:34 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1:8d38])
        by smtp.gmail.com with ESMTPSA id 65-v6sm23188753pfq.81.2018.07.25.16.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 16:59:34 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v4 6/9] proc/kcore: clean up ELF header generation
Date:   Wed, 25 Jul 2018 16:59:17 -0700
Message-Id: <9877fbf510da820bd7f9a5907fa64463bae5e59a.1532563124.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532563124.git.osandov@fb.com>
References: <cover.1532563124.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Currently, the ELF file header, program headers, and note segment are
allocated all at once, in some icky code dating back to 2.3. Programs
tend to read the file header, then the program headers, then the note
segment, all separately, so this is a waste of effort. It's cleaner and
more efficient to handle the three separately.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 350 +++++++++++++++++++-----------------------------
 1 file changed, 141 insertions(+), 209 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index dc34642bbdb7..808ef9afd084 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -49,15 +49,6 @@ static struct proc_dir_entry *proc_root_kcore;
 #define	kc_offset_to_vaddr(o) ((o) + PAGE_OFFSET)
 #endif
 
-/* An ELF note in memory */
-struct memelfnote
-{
-	const char *name;
-	int type;
-	unsigned int datasz;
-	void *data;
-};
-
 static LIST_HEAD(kclist_head);
 static DECLARE_RWSEM(kclist_lock);
 static int kcore_need_update = 1;
@@ -73,7 +64,8 @@ void __init kclist_add(struct kcore_list *new, void *addr, size_t size,
 	list_add_tail(&new->list, &kclist_head);
 }
 
-static size_t get_kcore_size(int *nphdr, size_t *elf_buflen)
+static size_t get_kcore_size(int *nphdr, size_t *phdrs_len, size_t *notes_len,
+			     size_t *data_offset)
 {
 	size_t try, size;
 	struct kcore_list *m;
@@ -87,15 +79,15 @@ static size_t get_kcore_size(int *nphdr, size_t *elf_buflen)
 			size = try;
 		*nphdr = *nphdr + 1;
 	}
-	*elf_buflen =	sizeof(struct elfhdr) + 
-			(*nphdr + 2)*sizeof(struct elf_phdr) + 
-			3 * ((sizeof(struct elf_note)) +
-			     roundup(sizeof(CORE_STR), 4)) +
-			roundup(sizeof(struct elf_prstatus), 4) +
-			roundup(sizeof(struct elf_prpsinfo), 4) +
-			roundup(arch_task_struct_size, 4);
-	*elf_buflen = PAGE_ALIGN(*elf_buflen);
-	return size + *elf_buflen;
+
+	*phdrs_len = *nphdr * sizeof(struct elf_phdr);
+	*notes_len = (3 * (sizeof(struct elf_note) + ALIGN(sizeof(CORE_STR), 4)) +
+		      ALIGN(sizeof(struct elf_prstatus), 4) +
+		      ALIGN(sizeof(struct elf_prpsinfo), 4) +
+		      ALIGN(arch_task_struct_size, 4));
+	*data_offset = PAGE_ALIGN(sizeof(struct elfhdr) + *phdrs_len +
+				  *notes_len);
+	return *data_offset + size;
 }
 
 #ifdef CONFIG_HIGHMEM
@@ -241,7 +233,7 @@ static int kcore_update_ram(void)
 	LIST_HEAD(list);
 	LIST_HEAD(garbage);
 	int nphdr;
-	size_t size;
+	size_t phdrs_len, notes_len, data_offset;
 	struct kcore_list *tmp, *pos;
 	int ret = 0;
 
@@ -263,7 +255,8 @@ static int kcore_update_ram(void)
 	}
 	list_splice_tail(&list, &kclist_head);
 
-	proc_root_kcore->size = get_kcore_size(&nphdr, &size);
+	proc_root_kcore->size = get_kcore_size(&nphdr, &phdrs_len, &notes_len,
+					       &data_offset);
 
 out:
 	up_write(&kclist_lock);
@@ -274,228 +267,168 @@ static int kcore_update_ram(void)
 	return ret;
 }
 
-/*****************************************************************************/
-/*
- * determine size of ELF note
- */
-static int notesize(struct memelfnote *en)
+static void append_kcore_note(char *notes, size_t *i, const char *name,
+			      unsigned int type, const void *desc,
+			      size_t descsz)
 {
-	int sz;
-
-	sz = sizeof(struct elf_note);
-	sz += roundup((strlen(en->name) + 1), 4);
-	sz += roundup(en->datasz, 4);
-
-	return sz;
-} /* end notesize() */
-
-/*****************************************************************************/
-/*
- * store a note in the header buffer
- */
-static char *storenote(struct memelfnote *men, char *bufp)
-{
-	struct elf_note en;
-
-#define DUMP_WRITE(addr,nr) do { memcpy(bufp,addr,nr); bufp += nr; } while(0)
-
-	en.n_namesz = strlen(men->name) + 1;
-	en.n_descsz = men->datasz;
-	en.n_type = men->type;
-
-	DUMP_WRITE(&en, sizeof(en));
-	DUMP_WRITE(men->name, en.n_namesz);
-
-	/* XXX - cast from long long to long to avoid need for libgcc.a */
-	bufp = (char*) roundup((unsigned long)bufp,4);
-	DUMP_WRITE(men->data, men->datasz);
-	bufp = (char*) roundup((unsigned long)bufp,4);
-
-#undef DUMP_WRITE
-
-	return bufp;
-} /* end storenote() */
-
-/*
- * store an ELF coredump header in the supplied buffer
- * nphdr is the number of elf_phdr to insert
- */
-static void elf_kcore_store_hdr(char *bufp, int nphdr, int dataoff)
-{
-	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
-	struct elf_prpsinfo prpsinfo;	/* NT_PRPSINFO */
-	struct elf_phdr *nhdr, *phdr;
-	struct elfhdr *elf;
-	struct memelfnote notes[3];
-	off_t offset = 0;
-	struct kcore_list *m;
-
-	/* setup ELF header */
-	elf = (struct elfhdr *) bufp;
-	bufp += sizeof(struct elfhdr);
-	offset += sizeof(struct elfhdr);
-	memcpy(elf->e_ident, ELFMAG, SELFMAG);
-	elf->e_ident[EI_CLASS]	= ELF_CLASS;
-	elf->e_ident[EI_DATA]	= ELF_DATA;
-	elf->e_ident[EI_VERSION]= EV_CURRENT;
-	elf->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(elf->e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
-	elf->e_type	= ET_CORE;
-	elf->e_machine	= ELF_ARCH;
-	elf->e_version	= EV_CURRENT;
-	elf->e_entry	= 0;
-	elf->e_phoff	= sizeof(struct elfhdr);
-	elf->e_shoff	= 0;
-	elf->e_flags	= ELF_CORE_EFLAGS;
-	elf->e_ehsize	= sizeof(struct elfhdr);
-	elf->e_phentsize= sizeof(struct elf_phdr);
-	elf->e_phnum	= nphdr;
-	elf->e_shentsize= 0;
-	elf->e_shnum	= 0;
-	elf->e_shstrndx	= 0;
-
-	/* setup ELF PT_NOTE program header */
-	nhdr = (struct elf_phdr *) bufp;
-	bufp += sizeof(struct elf_phdr);
-	offset += sizeof(struct elf_phdr);
-	nhdr->p_type	= PT_NOTE;
-	nhdr->p_offset	= 0;
-	nhdr->p_vaddr	= 0;
-	nhdr->p_paddr	= 0;
-	nhdr->p_filesz	= 0;
-	nhdr->p_memsz	= 0;
-	nhdr->p_flags	= 0;
-	nhdr->p_align	= 0;
-
-	/* setup ELF PT_LOAD program header for every area */
-	list_for_each_entry(m, &kclist_head, list) {
-		phdr = (struct elf_phdr *) bufp;
-		bufp += sizeof(struct elf_phdr);
-		offset += sizeof(struct elf_phdr);
-
-		phdr->p_type	= PT_LOAD;
-		phdr->p_flags	= PF_R|PF_W|PF_X;
-		phdr->p_offset	= kc_vaddr_to_offset(m->addr) + dataoff;
-		phdr->p_vaddr	= (size_t)m->addr;
-		if (m->type == KCORE_RAM)
-			phdr->p_paddr	= __pa(m->addr);
-		else if (m->type == KCORE_TEXT)
-			phdr->p_paddr	= __pa_symbol(m->addr);
-		else
-			phdr->p_paddr	= (elf_addr_t)-1;
-		phdr->p_filesz	= phdr->p_memsz	= m->size;
-		phdr->p_align	= PAGE_SIZE;
-	}
-
-	/*
-	 * Set up the notes in similar form to SVR4 core dumps made
-	 * with info from their /proc.
-	 */
-	nhdr->p_offset	= offset;
-
-	/* set up the process status */
-	notes[0].name = CORE_STR;
-	notes[0].type = NT_PRSTATUS;
-	notes[0].datasz = sizeof(struct elf_prstatus);
-	notes[0].data = &prstatus;
-
-	memset(&prstatus, 0, sizeof(struct elf_prstatus));
-
-	nhdr->p_filesz	= notesize(&notes[0]);
-	bufp = storenote(&notes[0], bufp);
-
-	/* set up the process info */
-	notes[1].name	= CORE_STR;
-	notes[1].type	= NT_PRPSINFO;
-	notes[1].datasz	= sizeof(struct elf_prpsinfo);
-	notes[1].data	= &prpsinfo;
-
-	memset(&prpsinfo, 0, sizeof(struct elf_prpsinfo));
-	prpsinfo.pr_state	= 0;
-	prpsinfo.pr_sname	= 'R';
-	prpsinfo.pr_zomb	= 0;
-
-	strcpy(prpsinfo.pr_fname, "vmlinux");
-	strlcpy(prpsinfo.pr_psargs, saved_command_line, sizeof(prpsinfo.pr_psargs));
-
-	nhdr->p_filesz	+= notesize(&notes[1]);
-	bufp = storenote(&notes[1], bufp);
-
-	/* set up the task structure */
-	notes[2].name	= CORE_STR;
-	notes[2].type	= NT_TASKSTRUCT;
-	notes[2].datasz	= arch_task_struct_size;
-	notes[2].data	= current;
-
-	nhdr->p_filesz	+= notesize(&notes[2]);
-	bufp = storenote(&notes[2], bufp);
-
-} /* end elf_kcore_store_hdr() */
+	struct elf_note *note = (struct elf_note *)&notes[*i];
+
+	note->n_namesz = strlen(name) + 1;
+	note->n_descsz = descsz;
+	note->n_type = type;
+	*i += sizeof(*note);
+	memcpy(&notes[*i], name, note->n_namesz);
+	*i = ALIGN(*i + note->n_namesz, 4);
+	memcpy(&notes[*i], desc, descsz);
+	*i = ALIGN(*i + descsz, 4);
+}
 
-/*****************************************************************************/
-/*
- * read from the ELF header and then kernel memory
- */
 static ssize_t
 read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 {
 	char *buf = file->private_data;
-	size_t size, tsz;
-	size_t elf_buflen;
+	size_t phdrs_offset, notes_offset, data_offset;
+	size_t phdrs_len, notes_len;
+	struct kcore_list *m;
+	size_t tsz;
 	int nphdr;
 	unsigned long start;
 	size_t orig_buflen = buflen;
 	int ret = 0;
 
 	down_read(&kclist_lock);
-	size = get_kcore_size(&nphdr, &elf_buflen);
 
-	if (buflen == 0 || *fpos >= size)
-		goto out;
+	get_kcore_size(&nphdr, &phdrs_len, &notes_len, &data_offset);
+	phdrs_offset = sizeof(struct elfhdr);
+	notes_offset = phdrs_offset + phdrs_len;
+
+	/* ELF file header. */
+	if (buflen && *fpos < sizeof(struct elfhdr)) {
+		struct elfhdr ehdr = {
+			.e_ident = {
+				[EI_MAG0] = ELFMAG0,
+				[EI_MAG1] = ELFMAG1,
+				[EI_MAG2] = ELFMAG2,
+				[EI_MAG3] = ELFMAG3,
+				[EI_CLASS] = ELF_CLASS,
+				[EI_DATA] = ELF_DATA,
+				[EI_VERSION] = EV_CURRENT,
+				[EI_OSABI] = ELF_OSABI,
+			},
+			.e_type = ET_CORE,
+			.e_machine = ELF_ARCH,
+			.e_version = EV_CURRENT,
+			.e_phoff = sizeof(struct elfhdr),
+			.e_flags = ELF_CORE_EFLAGS,
+			.e_ehsize = sizeof(struct elfhdr),
+			.e_phentsize = sizeof(struct elf_phdr),
+			.e_phnum = nphdr,
+		};
+
+		tsz = min_t(size_t, buflen, sizeof(struct elfhdr) - *fpos);
+		if (copy_to_user(buffer, (char *)&ehdr + *fpos, tsz)) {
+			ret = -EFAULT;
+			goto out;
+		}
 
-	/* trim buflen to not go beyond EOF */
-	if (buflen > size - *fpos)
-		buflen = size - *fpos;
+		buffer += tsz;
+		buflen -= tsz;
+		*fpos += tsz;
+	}
 
-	/* construct an ELF core header if we'll need some of it */
-	if (*fpos < elf_buflen) {
-		char * elf_buf;
+	/* ELF program headers. */
+	if (buflen && *fpos < phdrs_offset + phdrs_len) {
+		struct elf_phdr *phdrs, *phdr;
 
-		tsz = elf_buflen - *fpos;
-		if (buflen < tsz)
-			tsz = buflen;
-		elf_buf = kzalloc(elf_buflen, GFP_KERNEL);
-		if (!elf_buf) {
+		phdrs = kzalloc(phdrs_len, GFP_KERNEL);
+		if (!phdrs) {
 			ret = -ENOMEM;
 			goto out;
 		}
-		elf_kcore_store_hdr(elf_buf, nphdr, elf_buflen);
-		if (copy_to_user(buffer, elf_buf + *fpos, tsz)) {
-			kfree(elf_buf);
+
+		phdrs[0].p_type = PT_NOTE;
+		phdrs[0].p_offset = notes_offset;
+		phdrs[0].p_filesz = notes_len;
+
+		phdr = &phdrs[1];
+		list_for_each_entry(m, &kclist_head, list) {
+			phdr->p_type = PT_LOAD;
+			phdr->p_flags = PF_R | PF_W | PF_X;
+			phdr->p_offset = kc_vaddr_to_offset(m->addr) + data_offset;
+			phdr->p_vaddr = (size_t)m->addr;
+			if (m->type == KCORE_RAM)
+				phdr->p_paddr = __pa(m->addr);
+			else if (m->type == KCORE_TEXT)
+				phdr->p_paddr = __pa_symbol(m->addr);
+			else
+				phdr->p_paddr = (elf_addr_t)-1;
+			phdr->p_filesz = phdr->p_memsz = m->size;
+			phdr->p_align = PAGE_SIZE;
+			phdr++;
+		}
+
+		tsz = min_t(size_t, buflen, phdrs_offset + phdrs_len - *fpos);
+		if (copy_to_user(buffer, (char *)phdrs + *fpos - phdrs_offset,
+				 tsz)) {
+			kfree(phdrs);
 			ret = -EFAULT;
 			goto out;
 		}
-		kfree(elf_buf);
+		kfree(phdrs);
+
+		buffer += tsz;
 		buflen -= tsz;
 		*fpos += tsz;
-		buffer += tsz;
+	}
+
+	/* ELF note segment. */
+	if (buflen && *fpos < notes_offset + notes_len) {
+		struct elf_prstatus prstatus = {};
+		struct elf_prpsinfo prpsinfo = {
+			.pr_sname = 'R',
+			.pr_fname = "vmlinux",
+		};
+		char *notes;
+		size_t i = 0;
+
+		strlcpy(prpsinfo.pr_psargs, saved_command_line,
+			sizeof(prpsinfo.pr_psargs));
+
+		notes = kzalloc(notes_len, GFP_KERNEL);
+		if (!notes) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		append_kcore_note(notes, &i, CORE_STR, NT_PRSTATUS, &prstatus,
+				  sizeof(prstatus));
+		append_kcore_note(notes, &i, CORE_STR, NT_PRPSINFO, &prpsinfo,
+				  sizeof(prpsinfo));
+		append_kcore_note(notes, &i, CORE_STR, NT_TASKSTRUCT, current,
+				  arch_task_struct_size);
 
-		/* leave now if filled buffer already */
-		if (buflen == 0)
+		tsz = min_t(size_t, buflen, notes_offset + notes_len - *fpos);
+		if (copy_to_user(buffer, notes + *fpos - notes_offset, tsz)) {
+			kfree(notes);
+			ret = -EFAULT;
 			goto out;
+		}
+		kfree(notes);
+
+		buffer += tsz;
+		buflen -= tsz;
+		*fpos += tsz;
 	}
 
 	/*
 	 * Check to see if our file offset matches with any of
 	 * the addresses in the elf_phdr on our list.
 	 */
-	start = kc_offset_to_vaddr(*fpos - elf_buflen);
+	start = kc_offset_to_vaddr(*fpos - data_offset);
 	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
 		tsz = buflen;
-		
-	while (buflen) {
-		struct kcore_list *m;
 
+	while (buflen) {
 		list_for_each_entry(m, &kclist_head, list) {
 			if (start >= m->addr && start < (m->addr+m->size))
 				break;
@@ -557,7 +490,6 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	return orig_buflen - buflen;
 }
 
-
 static int open_kcore(struct inode *inode, struct file *filp)
 {
 	if (!capable(CAP_SYS_RAWIO))
-- 
2.18.0

