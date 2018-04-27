Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoWRFwNpqfXr5+4dY+zuAPPM4Rd2b10PPIbVTMKif50yWl6BcfdxcTdEGKS9JuUQu8YU7oV
ARC-Seal: i=1; a=rsa-sha256; t=1524837731; cv=none;
        d=google.com; s=arc-20160816;
        b=gQocbfNpNmIV/BoZv0j5/MJLHOeL6WSLBRNMb780OFxZxxmebfdzSpi8XRZQ/jjM4Y
         7qjXaFmVP9thBiB87D4vS51D5SpEMyQt7iP+8mRBLnSPaTx1QOe/OOnvZt99XUiQb6kq
         UTLWBqzI9v2QAQLZFZCSdJRPYmNWhEeMUBupbkpwU8Jv/hv/HvQd/G4oagVRWWRNXIiA
         GwOCBpBtYd+pkkVGjpq0oSJgaPclc8Yyxox7MsBBvXYv9EdO1u+UeEdTZ6XTljD/XDnv
         f8ELVf831Q7Q4pet4qHpQBUAbGaKD3K6eXR78bneJJcwgSWEfswyljJwEQNylNfZ+avf
         VktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=TTnCtXAuI+o7BhlRqMsHpKOjm8gxweUolo3RKfDawzs=;
        b=vWd1osg6xUhrhavlwOrCdMT2YMrlaOskx1IKjFCvspUaxidrN2nm6h43MpHb8OH0/U
         2Di1BAZdRcIoFzAmoGoptdLNXW7faJc16VyncgriAifKiWJP+jupIfr24A1Eo+T4le1J
         FR9qnaNBSq+zExergRtRBjBiba8aU4CTAT70Blpf15mSk15zzdRNkbBXYea6/Sb7Xb7N
         JVW1TE/C4hOwgqV3ddWupQbjytvgYu+gZE9lMcezyVIAZ4yPTWEEROsNM2JoInlRIf1j
         R97adBqUMCrpt005PnEb2DHKljuep4QbYNy0AMJj/ZQGGlnxN4nySBv4SIxOh4xN9mVS
         sAyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533582189F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 4.4 11/50] s390: enable CPU alternatives unconditionally
Date: Fri, 27 Apr 2018 15:58:13 +0200
Message-Id: <20180427135656.368223813@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908248930767762?=
X-GMAIL-MSGID: =?utf-8?q?1598908248930767762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


From: Heiko Carstens <heiko.carstens@de.ibm.com>

[ Upstream commit 049a2c2d486e8cc82c5cd79fa479c5b105b109e9 ]

Remove the CPU_ALTERNATIVES config option and enable the code
unconditionally. The config option was only added to avoid a conflict
with the named saved segment support. Since that code is gone there is
no reason to keep the CPU_ALTERNATIVES config option.

Just enable it unconditionally to also reduce the number of config
options and make it less likely that something breaks.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/Kconfig                   |   16 ----------------
 arch/s390/include/asm/alternative.h |   20 +++-----------------
 arch/s390/kernel/Makefile           |    3 +--
 arch/s390/kernel/module.c           |   15 ++++++---------
 4 files changed, 10 insertions(+), 44 deletions(-)

--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -705,22 +705,6 @@ config SECCOMP
 
 	  If unsure, say Y.
 
-config ALTERNATIVES
-	def_bool y
-	prompt "Patch optimized instructions for running CPU type"
-	help
-	  When enabled the kernel code is compiled with additional
-	  alternative instructions blocks optimized for newer CPU types.
-	  These alternative instructions blocks are patched at kernel boot
-	  time when running CPU supports them. This mechanism is used to
-	  optimize some critical code paths (i.e. spinlocks) for newer CPUs
-	  even if kernel is build to support older machine generations.
-
-	  This mechanism could be disabled by appending "noaltinstr"
-	  option to the kernel command line.
-
-	  If unsure, say Y.
-
 endmenu
 
 menu "Power Management"
--- a/arch/s390/include/asm/alternative.h
+++ b/arch/s390/include/asm/alternative.h
@@ -15,14 +15,9 @@ struct alt_instr {
 	u8  replacementlen;	/* length of new instruction */
 } __packed;
 
-#ifdef CONFIG_ALTERNATIVES
-extern void apply_alternative_instructions(void);
-extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
-#else
-static inline void apply_alternative_instructions(void) {};
-static inline void apply_alternatives(struct alt_instr *start,
-				      struct alt_instr *end) {};
-#endif
+void apply_alternative_instructions(void);
+void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
+
 /*
  * |661:       |662:	  |6620      |663:
  * +-----------+---------------------+
@@ -109,7 +104,6 @@ static inline void apply_alternatives(st
 	b_altinstr(num)":\n\t" altinstr "\n" e_altinstr(num) ":\n"	\
 	INSTR_LEN_SANITY_CHECK(altinstr_len(num))
 
-#ifdef CONFIG_ALTERNATIVES
 /* alternative assembly primitive: */
 #define ALTERNATIVE(oldinstr, altinstr, facility) \
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
@@ -130,14 +124,6 @@ static inline void apply_alternatives(st
 	ALTINSTR_ENTRY(facility1, 1)					\
 	ALTINSTR_ENTRY(facility2, 2)					\
 	".popsection\n"
-#else
-/* Alternative instructions are disabled, let's put just oldinstr in */
-#define ALTERNATIVE(oldinstr, altinstr, facility) \
-	oldinstr "\n"
-
-#define ALTERNATIVE_2(oldinstr, altinstr1, facility1, altinstr2, facility2) \
-	oldinstr "\n"
-#endif
 
 /*
  * Alternative instructions for different CPU types or capabilities.
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -44,7 +44,7 @@ obj-y	+= processor.o sys_s390.o ptrace.o
 obj-y	+= debug.o irq.o ipl.o dis.o diag.o sclp.o vdso.o
 obj-y	+= sysinfo.o jump_label.o lgr.o os_info.o machine_kexec.o pgm_check.o
 obj-y	+= runtime_instr.o cache.o dumpstack.o
-obj-y	+= entry.o reipl.o relocate_kernel.o
+obj-y	+= entry.o reipl.o relocate_kernel.o alternative.o
 
 extra-y				+= head.o head64.o vmlinux.lds
 
@@ -62,7 +62,6 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o
-obj-$(CONFIG_ALTERNATIVES)	+= alternative.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_cpum_cf.o perf_cpum_sf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_cpum_cf_events.o
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -428,16 +428,13 @@ int module_finalize(const Elf_Ehdr *hdr,
 	const Elf_Shdr *s;
 	char *secstrings;
 
-	if (IS_ENABLED(CONFIG_ALTERNATIVES)) {
-		secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-		for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
-			if (!strcmp(".altinstructions",
-				    secstrings + s->sh_name)) {
-				/* patch .altinstructions */
-				void *aseg = (void *)s->sh_addr;
+	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
+		if (!strcmp(".altinstructions", secstrings + s->sh_name)) {
+			/* patch .altinstructions */
+			void *aseg = (void *)s->sh_addr;
 
-				apply_alternatives(aseg, aseg + s->sh_size);
-			}
+			apply_alternatives(aseg, aseg + s->sh_size);
 		}
 	}
 
