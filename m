Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20678C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36852622D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBXDkDZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36852622D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755754AbeFYWm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:42:56 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:37668 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754079AbeFYWmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:42:53 -0400
Received: by mail-yw0-f202.google.com with SMTP id p11-v6so2698312ywm.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=R2r79+X0b/ELpXa2zgTHCygaB4cb8B9XjtpsN6oi2vE=;
        b=oBXDkDZ2moMDG/e0KqKyw2G9lofsExkCswfJhgNE8feHvIqmuPEgj+FRjvC6VX38lF
         /G/H6WRRFYVY6RWa+wMzrRpTnPGSnnbaFURbKLQn+K02QK1CpTaecd7tr09MVj/glhk7
         LLKSUo64fYvVWGgbPCdsZ4YHgjd3IxHngjStY+hJ0+ZsEpmrIFA0c3BDRxjnOLysFACs
         O8Rz/CAtrrOJo4Ie6117mnzdQarvkcYKfip/pGjdrvoJJh928ew4m0cNrsf57Z/BMaet
         20yfJRhps6V6IPmz9n7R32nv8b3WsG0IXj0Qu7vhtTootIaK3QFZnaHaleUfdgG2VwRu
         KigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=R2r79+X0b/ELpXa2zgTHCygaB4cb8B9XjtpsN6oi2vE=;
        b=fhJJcDbIJ1EUL7boSlIkeq2/dldzL1jmVku/M4nGBubJFpbet8oq+PowHbe4glMZGR
         epiapnICWqRVZtUfiU1GWF5Fw9OSX8joFxc2Cq8upC91v+to8mqLSi2lqiz/A+y/gSFz
         cvXkC4H5VJCUgop5uOA6whNWa7LN1S3KOpAUx9u8xBsRtKF7IxT3wLWnqOBBI8pRmRze
         zqcX9BQvubFIqHoM5DJYS1TfdMRwcyfz6qbuDLBnpRg5FdtApXQT4iFt+c6OaxOpXp5S
         wwAqZ+YVBgkP6R3K7QmKum9vZ/RZhp27RnmEvYMKrJMLCLb+3+yUBM94e6DCc/2utd1t
         OncQ==
X-Gm-Message-State: APt69E0ZI/Z8CoAGmCWPmivU9Rbh7ZqJ6lXQUb3xNtNaUdHaODT4Ir+o
        2jLVpHlXnByNxgpKxs0qsipT4V5uVsAUXg==
X-Google-Smtp-Source: ADUXVKJt2WPZGwuCOhBK2mS9NR98cUP/hV1PBdPmLq1Wx2OOXovNBg/gEYfH4sw+Q5ejyaq7okbJGp6Ewo8JFw==
MIME-Version: 1.0
X-Received: by 2002:a81:9a93:: with SMTP id r141-v6mr3821092ywg.159.1529966572456;
 Mon, 25 Jun 2018 15:42:52 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:39:14 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-27-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 26/27] x86/relocs: Add option to generate 64-bit relocations
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 relocation tool generates a list of 32-bit signed integers. There
was no need to use 64-bit integers because all addresses where above the 2G
top of the memory.

This change add a large-reloc option to generate 64-bit unsigned integers.
It can be used when the kernel plan to go below the top 2G and 32-bit
integers are not enough.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/tools/relocs.c        | 60 +++++++++++++++++++++++++++-------
 arch/x86/tools/relocs.h        |  4 +--
 arch/x86/tools/relocs_common.c | 15 ++++++---
 3 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 29283ad3950f..a29cccceaac6 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -13,8 +13,14 @@
 
 static Elf_Ehdr ehdr;
 
+#if ELF_BITS == 64
+typedef uint64_t rel_off_t;
+#else
+typedef uint32_t rel_off_t;
+#endif
+
 struct relocs {
-	uint32_t	*offset;
+	rel_off_t	*offset;
 	unsigned long	count;
 	unsigned long	size;
 };
@@ -685,7 +691,7 @@ static void print_absolute_relocs(void)
 		printf("\n");
 }
 
-static void add_reloc(struct relocs *r, uint32_t offset)
+static void add_reloc(struct relocs *r, rel_off_t offset)
 {
 	if (r->count == r->size) {
 		unsigned long newsize = r->size + 50000;
@@ -1061,26 +1067,48 @@ static void sort_relocs(struct relocs *r)
 	qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
 }
 
-static int write32(uint32_t v, FILE *f)
+static int write32(rel_off_t rel, FILE *f)
 {
-	unsigned char buf[4];
+	unsigned char buf[sizeof(uint32_t)];
+	uint32_t v = (uint32_t)rel;
 
 	put_unaligned_le32(v, buf);
-	return fwrite(buf, 1, 4, f) == 4 ? 0 : -1;
+	return fwrite(buf, 1, sizeof(buf), f) == sizeof(buf) ? 0 : -1;
 }
 
-static int write32_as_text(uint32_t v, FILE *f)
+static int write32_as_text(rel_off_t rel, FILE *f)
 {
+	uint32_t v = (uint32_t)rel;
 	return fprintf(f, "\t.long 0x%08"PRIx32"\n", v) > 0 ? 0 : -1;
 }
 
-static void emit_relocs(int as_text, int use_real_mode)
+static int write64(rel_off_t rel, FILE *f)
+{
+	unsigned char buf[sizeof(uint64_t)];
+	uint64_t v = (uint64_t)rel;
+
+	put_unaligned_le64(v, buf);
+	return fwrite(buf, 1, sizeof(buf), f) == sizeof(buf) ? 0 : -1;
+}
+
+static int write64_as_text(rel_off_t rel, FILE *f)
+{
+	uint64_t v = (uint64_t)rel;
+	return fprintf(f, "\t.quad 0x%016"PRIx64"\n", v) > 0 ? 0 : -1;
+}
+
+static void emit_relocs(int as_text, int use_real_mode, int use_large_reloc)
 {
 	int i;
-	int (*write_reloc)(uint32_t, FILE *) = write32;
+	int (*write_reloc)(rel_off_t, FILE *);
 	int (*do_reloc)(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 			const char *symname);
 
+	if (use_large_reloc)
+		write_reloc = write64;
+	else
+		write_reloc = write32;
+
 #if ELF_BITS == 64
 	if (!use_real_mode)
 		do_reloc = do_reloc64;
@@ -1091,6 +1119,9 @@ static void emit_relocs(int as_text, int use_real_mode)
 		do_reloc = do_reloc32;
 	else
 		do_reloc = do_reloc_real;
+
+	/* Large relocations only for 64-bit */
+	use_large_reloc = 0;
 #endif
 
 	/* Collect up the relocations */
@@ -1114,8 +1145,13 @@ static void emit_relocs(int as_text, int use_real_mode)
 		 * gas will like.
 		 */
 		printf(".section \".data.reloc\",\"a\"\n");
-		printf(".balign 4\n");
-		write_reloc = write32_as_text;
+		if (use_large_reloc) {
+			printf(".balign 8\n");
+			write_reloc = write64_as_text;
+		} else {
+			printf(".balign 4\n");
+			write_reloc = write32_as_text;
+		}
 	}
 
 	if (use_real_mode) {
@@ -1183,7 +1219,7 @@ static void print_reloc_info(void)
 
 void process(FILE *fp, int use_real_mode, int as_text,
 	     int show_absolute_syms, int show_absolute_relocs,
-	     int show_reloc_info)
+	     int show_reloc_info, int use_large_reloc)
 {
 	regex_init(use_real_mode);
 	read_ehdr(fp);
@@ -1206,5 +1242,5 @@ void process(FILE *fp, int use_real_mode, int as_text,
 		print_reloc_info();
 		return;
 	}
-	emit_relocs(as_text, use_real_mode);
+	emit_relocs(as_text, use_real_mode, use_large_reloc);
 }
diff --git a/arch/x86/tools/relocs.h b/arch/x86/tools/relocs.h
index 43c83c0fd22c..3d401da59df7 100644
--- a/arch/x86/tools/relocs.h
+++ b/arch/x86/tools/relocs.h
@@ -31,8 +31,8 @@ enum symtype {
 
 void process_32(FILE *fp, int use_real_mode, int as_text,
 		int show_absolute_syms, int show_absolute_relocs,
-		int show_reloc_info);
+		int show_reloc_info, int use_large_reloc);
 void process_64(FILE *fp, int use_real_mode, int as_text,
 		int show_absolute_syms, int show_absolute_relocs,
-		int show_reloc_info);
+		int show_reloc_info, int use_large_reloc);
 #endif /* RELOCS_H */
diff --git a/arch/x86/tools/relocs_common.c b/arch/x86/tools/relocs_common.c
index 6634352a20bc..11f49adf1c06 100644
--- a/arch/x86/tools/relocs_common.c
+++ b/arch/x86/tools/relocs_common.c
@@ -12,14 +12,14 @@ void die(char *fmt, ...)
 
 static void usage(void)
 {
-	die("relocs [--abs-syms|--abs-relocs|--reloc-info|--text|--realmode]" \
-	    " vmlinux\n");
+	die("relocs [--abs-syms|--abs-relocs|--reloc-info|--text|--realmode|" \
+	    "--large-reloc]  vmlinux\n");
 }
 
 int main(int argc, char **argv)
 {
 	int show_absolute_syms, show_absolute_relocs, show_reloc_info;
-	int as_text, use_real_mode;
+	int as_text, use_real_mode, use_large_reloc;
 	const char *fname;
 	FILE *fp;
 	int i;
@@ -30,6 +30,7 @@ int main(int argc, char **argv)
 	show_reloc_info = 0;
 	as_text = 0;
 	use_real_mode = 0;
+	use_large_reloc = 0;
 	fname = NULL;
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
@@ -54,6 +55,10 @@ int main(int argc, char **argv)
 				use_real_mode = 1;
 				continue;
 			}
+			if (strcmp(arg, "--large-reloc") == 0) {
+				use_large_reloc = 1;
+				continue;
+			}
 		}
 		else if (!fname) {
 			fname = arg;
@@ -75,11 +80,11 @@ int main(int argc, char **argv)
 	if (e_ident[EI_CLASS] == ELFCLASS64)
 		process_64(fp, use_real_mode, as_text,
 			   show_absolute_syms, show_absolute_relocs,
-			   show_reloc_info);
+			   show_reloc_info, use_large_reloc);
 	else
 		process_32(fp, use_real_mode, as_text,
 			   show_absolute_syms, show_absolute_relocs,
-			   show_reloc_info);
+			   show_reloc_info, use_large_reloc);
 	fclose(fp);
 	return 0;
 }
-- 
2.18.0.rc2.346.g013aa6912e-goog

