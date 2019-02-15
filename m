Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D3DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB60222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelim-com.20150623.gappssmtp.com header.i=@kernelim-com.20150623.gappssmtp.com header.b="kQOMbEBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbfBOTh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:37:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41924 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbfBOTh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:37:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so11501775wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 11:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+Rk8V2hQQPZf2dKwm4KrlYZ0kHgrNxMdy0bb3kZHHQ=;
        b=kQOMbEBioGrTPXUlKvlDUH30kaXHjfOCuEjkRg5G7oyMSYHV83NGJGntf0IydYMpRy
         Pc33LLB09R7zdLd8t3CAc3uJgWwZwwV/CIL4nqDCK8JD4BqzilDRcqeqpOh4HNJuneDN
         l406Zao2uA1b1jT5tidYcrhEwrx0zukdSsSubcRKGaODw/WVtqmXqFLuA2QBpapnYFYD
         Wtq+MsBRSrzCVU0rt1fpLi8OonPNZ77WeG0+PQQX/QxSJEdKP66gZ8hl2gK1CKavqKSE
         3HvaniZNYjdQYCVsdkWypmswJKnyDpCx8jIJpWpyk5bLjMRwZmykFmiCn27GVsLdCR1L
         QKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+Rk8V2hQQPZf2dKwm4KrlYZ0kHgrNxMdy0bb3kZHHQ=;
        b=mfWs0uAhRWWgNy5vrFPazGOxHchcPUaRtGKr8oe0s1vbFQd7DYGij2GajhyCmpkGJD
         0fkj1aiJyW6hFncKTbODgOhVNntQZn9IZONj/StEKEw0sEYejKUEzNmbVEcmbf9nZBaZ
         WTxBdQlLJbFmBXlvudJPl+GtR9tmspH2XOGF/W/25k1Zz34G1a6s8jtiyS7tFaqJaBqy
         G9w/D+Tj5ZtwEbnJrMVc+Ph2YG6xxVlLfnqabTfFalqF7OURuU+c9ydIuIki3yXBBl9+
         DM5LzZkciZqBT+dmZ3rWgmp33bDlRX0n1+J44PWWfQtV+C+UeGk4lJOGI9QogcFIO+Cp
         cMBg==
X-Gm-Message-State: AHQUAuagfxS+aGAXsN32bswa0cty0oyj1nO24JNlOFXaR1wUKDqmXPzy
        lF1aBPpIrc18CyILoJP3eijG6w==
X-Google-Smtp-Source: AHgI3IbElb9v7tQQXuQSPDYJItwIrUfnB8AA8FCa+BC38p99NhlFJ/Zdelum5B47NThphlRaGrlOPw==
X-Received: by 2002:a5d:6086:: with SMTP id w6mr7689491wrt.308.1550259473487;
        Fri, 15 Feb 2019 11:37:53 -0800 (PST)
Received: from jupiter.home.aloni.org ([141.226.148.58])
        by smtp.gmail.com with ESMTPSA id j5sm3966662wrw.59.2019.02.15.11.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 11:37:52 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     Steven Rostedt <srostedt@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/recordmcount: support more than 64K ELF sections
Date:   Fri, 15 Feb 2019 21:36:58 +0200
Message-Id: <20190215193658.30657-1-dan@kernelim.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this change, recordmcount thought that there were zero sections
in an ELF that has more than 64K sections.  It did nothing and exited
with exit status 0.

This change is needed so that CONFIG_DYNAMIC_FTRACE continues working
with special compilation flags that put each function in its own
section, a situation sometimes happens with modern compilers.

The other ELF mangling host program helpers in the kernel tree have also
received this treatment in the past.  For example, see commit
6845756b29e4 ("modpost: Update 64k section support for binutils
2.18.50").

Some changes here were taken from scripts/sortextable.c.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 scripts/recordmcount.c |   5 ++
 scripts/recordmcount.h | 106 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 99 insertions(+), 12 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index a50a2aa963ad..85b5a5105cce 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -409,6 +409,11 @@ is_mcounted_section_name(char const *const txtname)
 		strcmp(".text.unlikely", txtname) == 0;
 }
 
+static inline int is_shndx_special(unsigned int i)
+{
+	return i != SHN_XINDEX && i >= SHN_LORESERVE && i <= SHN_HIRESERVE;
+}
+
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 2e7793735e14..89758521d7e3 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -32,6 +32,10 @@
 #undef get_mcountsym
 #undef get_sym_str_and_relp
 #undef do_func
+#undef read_shstrndx
+#undef read_shnum
+#undef write_shnum
+#undef get_symb_shndx
 #undef Elf_Addr
 #undef Elf_Ehdr
 #undef Elf_Shdr
@@ -66,6 +70,10 @@
 # define fn_is_fake_mcount	fn_is_fake_mcount64
 # define MIPS_is_fake_mcount	MIPS64_is_fake_mcount
 # define mcount_adjust		mcount_adjust_64
+# define read_shstrndx		read_shstrndx_64
+# define read_shnum		read_shnum_64
+# define write_shnum		write_shnum_64
+# define get_symb_shndx		get_secindex_64
 # define Elf_Addr		Elf64_Addr
 # define Elf_Ehdr		Elf64_Ehdr
 # define Elf_Shdr		Elf64_Shdr
@@ -99,6 +107,10 @@
 # define fn_is_fake_mcount	fn_is_fake_mcount32
 # define MIPS_is_fake_mcount	MIPS32_is_fake_mcount
 # define mcount_adjust		mcount_adjust_32
+# define read_shstrndx		read_shstrndx_32
+# define read_shnum		read_shnum_32
+# define write_shnum		write_shnum_32
+# define get_symb_shndx		get_secindex_32
 # define Elf_Addr		Elf32_Addr
 # define Elf_Ehdr		Elf32_Ehdr
 # define Elf_Shdr		Elf32_Shdr
@@ -138,6 +150,58 @@ static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
 }
 static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_ELF_R_INFO;
 
+static unsigned int read_shstrndx(const Elf_Ehdr * const ehdr,
+				  const Elf_Shdr * const shdr0)
+{
+	unsigned int shstrndx = w2(ehdr->e_shstrndx);
+
+	if (shstrndx == SHN_XINDEX)
+		return w(shdr0->sh_link);
+
+	return shstrndx;
+}
+
+static unsigned int read_shnum(const Elf_Ehdr * const ehdr,
+			       const Elf_Shdr * const shdr0)
+{
+	unsigned int shnum = w2(ehdr->e_shnum);
+
+	if (shnum == 0)
+		return w(shdr0->sh_size);
+
+	return shnum;
+}
+
+static void write_shnum(Elf_Ehdr * const ehdr,
+			Elf_Shdr * const shdr0,
+			const unsigned int shnum)
+{
+	if (shnum >= SHN_LORESERVE) {
+		ehdr->e_shnum = 0;
+		shdr0->sh_size = shnum;
+	} else {
+		ehdr->e_shnum = shnum;
+	}
+}
+
+/* Accessor for sym->st_shndx, hides ugliness of "64k sections" */
+static unsigned int get_symb_shndx(const Elf_Sym *sym,
+				   const Elf_Sym *sym0,
+				   const unsigned int *indexes,
+				   unsigned int *index_out)
+{
+	if (is_shndx_special(sym->st_shndx))
+		return 0;
+
+	if (sym->st_shndx != SHN_XINDEX) {
+		*index_out = sym->st_shndx;
+		return 1;
+	}
+
+	*index_out = _w(indexes[sym - sym0]);
+	return 1;
+}
+
 static int mcount_adjust = 0;
 
 /*
@@ -189,8 +253,9 @@ static void append_func(Elf_Ehdr *const ehdr,
 	char const *mc_name = (sizeof(Elf_Rela) == rel_entsize)
 		? ".rela__mcount_loc"
 		:  ".rel__mcount_loc";
-	unsigned const old_shnum = w2(ehdr->e_shnum);
 	uint_t const old_shoff = _w(ehdr->e_shoff);
+	Elf_Shdr *const old_shdr0 = (Elf_Shdr *)(old_shoff + (void *)ehdr);
+	unsigned const old_shnum = read_shnum(ehdr, old_shdr0);
 	uint_t const old_shstr_sh_size   = _w(shstr->sh_size);
 	uint_t const old_shstr_sh_offset = _w(shstr->sh_offset);
 	uint_t t = 1 + strlen(mc_name) + _w(shstr->sh_size);
@@ -207,11 +272,18 @@ static void append_func(Elf_Ehdr *const ehdr,
 	uwrite(fd_map, old_shstr_sh_offset + (void *)ehdr, old_shstr_sh_size);
 	uwrite(fd_map, mc_name, 1 + strlen(mc_name));
 
+	/* update shnum (this may write both to ehdr and old_shdr0 */
+	write_shnum(ehdr, old_shdr0, old_shnum + 2);
+
+	/* write updated elf header */
+	ehdr->e_shoff = _w(new_e_shoff);
+	ulseek(fd_map, 0, SEEK_SET);
+	uwrite(fd_map, ehdr, sizeof(*ehdr));
+
 	/* old(modified) Elf_Shdr table, word-byte aligned */
 	ulseek(fd_map, t, SEEK_SET);
 	t += sizeof(Elf_Shdr) * old_shnum;
-	uwrite(fd_map, old_shoff + (void *)ehdr,
-	       sizeof(Elf_Shdr) * old_shnum);
+	uwrite(fd_map, old_shdr0, sizeof(Elf_Shdr) * old_shnum);
 
 	/* new sections __mcount_loc and .rel__mcount_loc */
 	t += 2*sizeof(mcsec);
@@ -244,11 +316,6 @@ static void append_func(Elf_Ehdr *const ehdr,
 
 	uwrite(fd_map, mloc0, (void *)mlocp - (void *)mloc0);
 	uwrite(fd_map, mrel0, (void *)mrelp - (void *)mrel0);
-
-	ehdr->e_shoff = _w(new_e_shoff);
-	ehdr->e_shnum = w2(2 + w2(ehdr->e_shnum));  /* {.rel,}__mcount_loc */
-	ulseek(fd_map, 0, SEEK_SET);
-	uwrite(fd_map, ehdr, sizeof(*ehdr));
 }
 
 static unsigned get_mcountsym(Elf_Sym const *const sym0,
@@ -415,6 +482,7 @@ static void nop_mcount(Elf_Shdr const *const relhdr,
  *      2: 00000000     0 SECTION LOCAL  DEFAULT    1
  */
 static unsigned find_secsym_ndx(unsigned const txtndx,
+				unsigned const *const indexes,
 				char const *const txtname,
 				uint_t *const recvalp,
 				Elf_Shdr const *const symhdr,
@@ -428,8 +496,12 @@ static unsigned find_secsym_ndx(unsigned const txtndx,
 
 	for (symp = sym0, t = nsym; t; --t, ++symp) {
 		unsigned int const st_bind = ELF_ST_BIND(symp->st_info);
+		unsigned int st_shndx = 0;
+
+		if (!get_symb_shndx(symp, sym0, indexes, &st_shndx))
+			continue;
 
-		if (txtndx == w2(symp->st_shndx)
+		if (txtndx == st_shndx
 			/* avoid STB_WEAK */
 		    && (STB_LOCAL == st_bind || STB_GLOBAL == st_bind)) {
 			/* function symbols on ARM have quirks, avoid them */
@@ -504,12 +576,13 @@ do_func(Elf_Ehdr *const ehdr, char const *const fname, unsigned const reltype)
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
 		+ (void *)ehdr);
-	unsigned const nhdr = w2(ehdr->e_shnum);
-	Elf_Shdr *const shstr = &shdr0[w2(ehdr->e_shstrndx)];
+	unsigned const nhdr = read_shnum(ehdr, shdr0);
+	Elf_Shdr *const shstr = &shdr0[read_shstrndx(ehdr, shdr0)];
 	char const *const shstrtab = (char const *)(_w(shstr->sh_offset)
 		+ (void *)ehdr);
 
 	Elf_Shdr const *relhdr;
+	const unsigned int *indexes = NULL; /* Special section of indexes */
 	unsigned k;
 
 	/* Upper bound on space: assume all relevant relocs are for mcount. */
@@ -524,13 +597,22 @@ do_func(Elf_Ehdr *const ehdr, char const *const fname, unsigned const reltype)
 	unsigned rel_entsize = 0;
 	unsigned symsec_sh_link = 0;
 
+	/* First, find the special section of indexes if it exists */
+	for (relhdr = shdr0, k = nhdr; k; --k, ++relhdr) {
+		if (relhdr->sh_type == SHT_SYMTAB_SHNDX) {
+			indexes = _w(relhdr->sh_offset) + (void *)ehdr;
+			break;
+		}
+	}
+
+	/* Then, do the main work */
 	for (relhdr = shdr0, k = nhdr; k; --k, ++relhdr) {
 		char const *const txtname = has_rel_mcount(relhdr, shdr0,
 			shstrtab, fname);
 		if (txtname && is_mcounted_section_name(txtname)) {
 			uint_t recval = 0;
 			unsigned const recsym = find_secsym_ndx(
-				w(relhdr->sh_info), txtname, &recval,
+				w(relhdr->sh_info), indexes, txtname, &recval,
 				&shdr0[symsec_sh_link = w(relhdr->sh_link)],
 				ehdr);
 
-- 
2.20.1

