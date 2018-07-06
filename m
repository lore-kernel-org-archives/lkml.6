Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE27C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C87A22CA0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="fZNJ2jLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C87A22CA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934838AbeGFTd1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:33:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38672 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934654AbeGFTcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:32:51 -0400
Received: by mail-pf0-f194.google.com with SMTP id j17-v6so9189777pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 12:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tkNowSeMKdSY9qW3aM4suoNZ5b8PMWqlFZwaD8C0z5k=;
        b=fZNJ2jLC05CXKbFQ7MAHURJ3ggkxlfzlBEQNpT+mJBi1w6B8IgLU+1i/VIWuShLKPp
         aEtT0xukKoQGpKokXM87JtJ/Spkv7zgiCDltLUrXK/JeCiWutp2gQ2yYw10iDyvM8fLt
         ILAsSseO+HdJ0E4AejQZMqWkkG4vZrtWBw9LXOZ7EThpSRGFvlZiAs2yrUpW9tuqrUMd
         MPqX280EsVAt9QgZLO6kGHgVqM+/i67YDcsRXxaJ7pF+yZZB89nKCWGSRc1rzpoDRccZ
         GHhDZ4ohuP4s2kuEabsN+jMphCOguIsj1x8ZTSN6FoFI/daxgS5N8sdEvDKzmb+c/IzR
         1ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tkNowSeMKdSY9qW3aM4suoNZ5b8PMWqlFZwaD8C0z5k=;
        b=c6RVQQsP+rSNKuLt3139ZdD6DQBcN3Wpdy0ixncWDPvpBKzhpFfdToXEZld+vNibSK
         t3IHLCDlo95t3GOjhkVqnrnCXuyeqr0u+YXytz3zKogm0aWoD7DRjLb8pdNJ7FAOld6x
         rMpBy9xBqhSQZswEWibCAezZ8kr+3tO85Q0BenavbJ4Z+J+OFvTaU6nPDhuS6oQm16/3
         XUYORrHNUHtvD/JVhUgJZNVmh7pkuqyfHg8nb0Zfhz+wcZQOr4+XK0ONirht8R/8t0YU
         reTgwmbi+cqi005i5gPMkGlqo5oREBx3notBz1cdnsBnKHkgnlbwTi47hCocsSjKYCEU
         yuWQ==
X-Gm-Message-State: APt69E0WzsaSjsr3nvXxprFogq1Zrb1CJE+tiS7Dgkit2R7H01ceXyN9
        Hk8YXzhzG/6NAGazbH57EdTtmYWrNEQ=
X-Google-Smtp-Source: AAOMgpefBZS5ahNZ7qi2cDPz2FoTr6TRL6yL1JcOb2t/LJOHgX49LyoxSp9Koa2YPNni6kqjclT21A==
X-Received: by 2002:aa7:80cf:: with SMTP id a15-v6mr11729962pfn.19.1530905570425;
        Fri, 06 Jul 2018 12:32:50 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::4:984e])
        by smtp.gmail.com with ESMTPSA id a11-v6sm12846162pgq.32.2018.07.06.12.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 12:32:49 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kernel-team@fb.com
Subject: [PATCH 5/7] proc/kcore: clean up ELF header generation
Date:   Fri,  6 Jul 2018 12:32:36 -0700
Message-Id: <196479b479237502d4d8b0e5a562b52205e5c374.1530904769.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530904769.git.osandov@fb.com>
References: <cover.1530904769.git.osandov@fb.com>
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
 fs/proc/kcore.c | 346 +++++++++++++++++++-----------------------------
 1 file changed, 139 insertions(+), 207 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index b7ff2e2ec350..de225b61f34f 100644
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
 static atomic_t kcore_need_update = ATOMIC_INIT(1);
@@ -73,7 +64,8 @@ kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
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
@@ -274,226 +267,166 @@ static int kcore_update_ram(void)
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
-		if (m->type == KCORE_RAM || m->type == KCORE_TEXT)
-			phdr->p_paddr	= __pa(m->addr);
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
+			if (m->type == KCORE_RAM || m->type == KCORE_TEXT)
+				phdr->p_paddr = __pa(m->addr);
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
+		struct elf_prstatus prstatus = {0};
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
@@ -555,7 +488,6 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	return orig_buflen - buflen;
 }
 
-
 static int open_kcore(struct inode *inode, struct file *filp)
 {
 	if (!capable(CAP_SYS_RAWIO))
-- 
2.18.0

